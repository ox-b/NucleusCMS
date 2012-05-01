<?php

/*
 * Nucleus: PHP/MySQL Weblog CMS (http://nucleuscms.org/)
 * Copyright (C) 2012 The Nucleus Group
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * (see nucleus/documentation/index.html#license for more info)
 */

/**
 * @license http://nucleuscms.org/license.txt GNU General Public License
 * @copyright Copyright (C) 2012 The Nucleus Group
 * @version $Id$
 */

class DB
{
	private static $dbh;
	private static $execCount = 0;
	private static $dateFormat = '%Y-%m-%d %H:%M:%S';
	
	/**
	 * Set the information to connect to the database, it will attempt to connect.
	 * @param string $engine Engine
	 * @param string $host Host
	 * @param string $user User
	 * @param string $password Password
	 * @param string $database Database
	 * @return bool Returns TRUE if able to connect, otherwise it returns FALSE.
	 */
	public static function setConnectionInfo($engine, $host, $user, $password, $database)
	{
		self::disConnect();

		try
		{
			if ( i18n::strpos($host, ':') === false )
			{
				$portnum = '';
			}
			else
			{
				list($host, $portnum) = i18n::explode(":", $host);
				if ( isset($portnum) )
				{
					$portnum = trim($portnum);
				}
				else
				{
					$portnum = '';
				}
			}

			switch ( $engine )
			{
				case 'sybase':
				case 'dblib':
					$port = is_numeric($portnum) ? ':' . intval($portnum) : '';
					$db = $database ? ';dbname=' . $database : '';
					self::$dbh = new PDO($engine . ':host=' . $host . $port . $db, $user, $password);
					break;
				case 'mssql':
					$port = is_numeric($portnum) ? ',' . intval($portnum) : '';
					$db = $database ? ';dbname=' . $database : '';
					self::$dbh = new PDO($engine . ':host=' . $host . $port . $db, $user, $password);
					break;
				case 'oci':
					$port = is_numeric($portnum) ? ':' . intval($portnum) : '';
					self::$dbh = new PDO($engine . ':dbname=//' . $host . $port . '/' . $database, $user, $password);
					break;
				case 'odbc':
					$port = is_numeric($portnum) ? ';PORT=' . intval($portnum) : '';
					self::$dbh = new PDO(
						$engine . ':DRIVER={IBM DB2 ODBC DRIVER};HOSTNAME=' . $host . $port . ';DATABASE=' . $database . ';PROTOCOL=TCPIP;UID='
							. $user . ';PWD=' . $password);
					break;
				case 'pgsql':
					$port = is_numeric($portnum) ? ';port=' . intval($portnum) : '';
					$db = $database ? ';dbname=' . $database : '';
					self::$dbh = new PDO($engine . ':host=' . $host . $port . $db, $user, $password);
					break;
				case 'sqlite':
				case 'sqlite2':
					$port = is_numeric($portnum) ? ':' . intval($portnum) : '';
					self::$dbh = new PDO($engine . ':' . $database, $user, $password);
					if ( self::$dbh )
					{
						self::$dbh->sqliteCreateFunction('SUBSTRING', 'substr', 3);
						self::$dbh->sqliteCreateFunction('UNIX_TIMESTAMP', 'strtotime', 1);
					}
					break;
				case 'mysql':
					$port = is_numeric($portnum) ? ';port=' . intval($portnum) : '';
					$db = $database ? ';dbname=' . $database : '';
					self::$dbh = new PDO(
						'mysql' . ':host=' . $host . $port . $db,
						$user,
						$password,
						array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'utf8\''));
					break;
				default: // mysql
					if ( !class_exists('MysqlPDO') )
					{
						include_once realpath(dirname(__FILE__)) . '/MYSQLPDO.php';
					}
					$port = is_numeric($portnum) ? ';port=' . intval($portnum) : '';
					$db = $database ? ';dbname=' . $database : '';
					self::$dbh = new MysqlPDO(
						'mysql' . ':host=' . $host . $port . $db,
						$user,
						$password,
						array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'utf8\''));
					break;
			}
		}
		catch (PDOException $e)
		{
			self::disConnect();
			return FALSE;
		}
		return TRUE;
	}

	/**
	 * Disconnect the connection to the database.
	 */
	public static function disConnect()
	{
		self::$dbh = null;
	}

	/**
	 * To get the number of times you run the statement.
	 * @return int Number of executions
	 */
	public static function getExecCount()
	{
		return self::$execCount;
	}

	/**
	 * The value converted to a format that can be passed to the database datetime.
	 * @param int $timestamp UNIX timestamp
	 * @param int $offset timestamp offset
	 * @return string formatted datetime
	 */
	public static function formatDateTime($timestamp = null, $offset=0)
	{
		if ( $timestamp == null )
		{
			$timestamp = time();
		}
		$timestamp += $offset;
		return preg_replace_callback('/(%[a-z%])/i',
			create_function('$matches', 'return strftime($matches[1], ' . intval($timestamp) . ');'),
			self::$dateFormat
		);
	}
	
	/**
	 * Gets the value of the first column of the first row of the results obtained in the statement.
	 * @param string $statement SQL Statement
	 * @return mixed Result value. If the call fails, it will return FALSE.
	 */
	public static function getValue($statement)
	{
		if ( self::$dbh == null ) return FALSE;
		self::$execCount++;
		$stmt = &self::$dbh->query($statement);
		if ( $result = $stmt->fetch(PDO::FETCH_NUM) )
		{
			return $result[0];
		}
		return FALSE;
	}

	/**
	 * Gets the first row of the results obtained in the statement.
	 * @param string $statement SQL Statement
	 * @return array Result row. If the call fails, it will return FALSE.
	 */
	public static function getRow($statement)
	{
		if ( self::$dbh == null ) return FALSE;
		self::$execCount++;
		return self::$dbh->query($statement)->fetch(PDO::FETCH_BOTH);
	}

	/**
	 * Gets the set of results obtained in the statement.
	 * @param string $statement SQL Statement
	 * @return PDOStatement Result set object. If the call fails, it will return FALSE.
	 */
	public static function getResult($statement)
	{
		if ( self::$dbh == null ) return FALSE;
		self::$execCount++;
		return self::$dbh->query($statement);
	}

	/**
	 * Execute an SQL statement and return the number of affected rows.
	 * @param string $statement SQL Statement
	 * @return int number of rows that were modified or deleted by the SQL statement you issued.
	 */
	public static function execute($statement)
	{
		if ( self::$dbh == null ) return FALSE;
		self::$execCount++;
		return self::$dbh->exec($statement);
	}
	
	/**
	 * Gets the error information associated with the last operation.
	 * @return array Error info
	 */
	public static function getError()
	{
		if ( self::$dbh == null ) return FALSE;
		return self::$dbh->errorInfo();
	}

	/**
	 * Quotes a string for use in a query.
	 * @param string $value Value to quote
	 * @return string Quoted value
	 */
	public static function quoteValue($value)
	{
		if ( self::$dbh == null ) return FALSE;
		return self::$dbh->quote($value);
	}

	/**
	 * Get the value of the ID of the rows that are inserted at the end.
	 * @return string ID of the row
	 */
	public static function getInsertId()
	{
		if ( self::$dbh == null ) return FALSE;
		return self::$dbh->lastInsertId();
	}

	/**
	 * Gets the attribute of the database.
	 * @return string Attribute
	 */
	public static function getAttribute($attribute)
	{
		if ( self::$dbh == null ) return FALSE;
		return self::$dbh->getAttribute($attribute);
	}
	
}
