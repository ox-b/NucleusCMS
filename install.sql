CREATE TABLE `nucleus_actionlog` (
  `timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `message` varchar(255) NOT NULL default ''
) TYPE=MyISAM;

CREATE TABLE `nucleus_activation` (
  `vkey` varchar(40) NOT NULL default '',
  `vtime` datetime NOT NULL default '0000-00-00 00:00:00',
  `vmember` int(11) NOT NULL default '0',
  `vtype` varchar(15) NOT NULL default '',
  `vextra` varchar(128) NOT NULL default '',
  PRIMARY KEY  (`vkey`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_ban` (
  `iprange` varchar(15) NOT NULL default '',
  `reason` varchar(255) NOT NULL default '',
  `blogid` int(11) NOT NULL default '0'
) TYPE=MyISAM;

CREATE TABLE `nucleus_blog` (
  `bnumber` int(11) NOT NULL auto_increment,
  `bname` varchar(60) NOT NULL default '',
  `bshortname` varchar(15) NOT NULL default '',
  `bdesc` varchar(200) default NULL,
  `bcomments` tinyint(2) NOT NULL default '1',
  `bmaxcomments` int(11) NOT NULL default '0',
  `btimeoffset` decimal(3,1) NOT NULL default '0.0',
  `bnotify` varchar(60) default NULL,
  `burl` varchar(100) default NULL,
  `bupdate` varchar(60) default NULL,
  `bdefskin` int(11) NOT NULL default '1',
  `bpublic` tinyint(2) NOT NULL default '1',
  `bsendping` tinyint(2) NOT NULL default '0',
  `bconvertbreaks` tinyint(2) NOT NULL default '1',
  `bdefcat` int(11) default NULL,
  `bnotifytype` int(11) NOT NULL default '15',
  `ballowpast` tinyint(2) NOT NULL default '0',
  `bincludesearch` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`bnumber`),
  UNIQUE KEY `bnumber` (`bnumber`),
  UNIQUE KEY `bshortname` (`bshortname`)
) TYPE=MyISAM;

INSERT INTO `nucleus_blog` VALUES (1, 'My Nucleus Weblog', 'myweblog', '', 1, 0, 0.0, '', 'http://localhost:8080/nucleus/', '', 5, 1, 0, 1, 1, 1, 1, 0);

CREATE TABLE `nucleus_category` (
  `catid` int(11) NOT NULL auto_increment,
  `cblog` int(11) NOT NULL default '0',
  `cname` varchar(40) default NULL,
  `cdesc` varchar(200) default NULL,
  PRIMARY KEY  (`catid`)
) TYPE=MyISAM;

INSERT INTO `nucleus_category` VALUES (1, 1, 'General', 'Items that do not fit in other categories');

CREATE TABLE `nucleus_comment` (
  `cnumber` int(11) NOT NULL auto_increment,
  `cbody` text NOT NULL,
  `cuser` varchar(40) default NULL,
  `cmail` varchar(100) default NULL,
  `cmember` int(11) default NULL,
  `citem` int(11) NOT NULL default '0',
  `ctime` datetime NOT NULL default '0000-00-00 00:00:00',
  `chost` varchar(60) default NULL,
  `cip` varchar(15) NOT NULL default '',
  `cblog` int(11) NOT NULL default '0',
  PRIMARY KEY  (`cnumber`),
  UNIQUE KEY `cnumber` (`cnumber`),
  KEY `citem` (`citem`),
  FULLTEXT KEY `cbody` (`cbody`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_config` (
  `name` varchar(20) NOT NULL default '',
  `value` varchar(128) default NULL,
  PRIMARY KEY  (`name`)
) TYPE=MyISAM;

INSERT INTO `nucleus_config` VALUES ('DefaultBlog', '1');
INSERT INTO `nucleus_config` VALUES ('AdminEmail', 'example@example.org');
INSERT INTO `nucleus_config` VALUES ('IndexURL', 'http://localhost:8080/nucleus/');
INSERT INTO `nucleus_config` VALUES ('Language', 'english');
INSERT INTO `nucleus_config` VALUES ('SessionCookie', '');
INSERT INTO `nucleus_config` VALUES ('AllowMemberCreate', '');
INSERT INTO `nucleus_config` VALUES ('AllowMemberMail', '1');
INSERT INTO `nucleus_config` VALUES ('SiteName', 'My Nucleus Weblog');
INSERT INTO `nucleus_config` VALUES ('AdminURL', 'http://localhost:8080/nucleus/nucleus/');
INSERT INTO `nucleus_config` VALUES ('NewMemberCanLogon', '1');
INSERT INTO `nucleus_config` VALUES ('DisableSite', '');
INSERT INTO `nucleus_config` VALUES ('DisableSiteURL', 'http://www.this-page-intentionally-left-blank.org/');
INSERT INTO `nucleus_config` VALUES ('LastVisit', '');
INSERT INTO `nucleus_config` VALUES ('MediaURL', 'http://localhost:8080/nucleus/media/');
INSERT INTO `nucleus_config` VALUES ('AllowedTypes', 'jpg,jpeg,gif,mpg,mpeg,avi,mov,mp3,swf,png');
INSERT INTO `nucleus_config` VALUES ('AllowLoginEdit', '');
INSERT INTO `nucleus_config` VALUES ('AllowUpload', '1');
INSERT INTO `nucleus_config` VALUES ('DisableJsTools', '2');
INSERT INTO `nucleus_config` VALUES ('CookiePath', '/');
INSERT INTO `nucleus_config` VALUES ('CookieDomain', '');
INSERT INTO `nucleus_config` VALUES ('CookieSecure', '');
INSERT INTO `nucleus_config` VALUES ('CookiePrefix', '');
INSERT INTO `nucleus_config` VALUES ('MediaPrefix', '1');
INSERT INTO `nucleus_config` VALUES ('MaxUploadSize', '1048576');
INSERT INTO `nucleus_config` VALUES ('NonmemberMail', '');
INSERT INTO `nucleus_config` VALUES ('PluginURL', 'http://localhost:8080/nucleus/nucleus/plugins/');
INSERT INTO `nucleus_config` VALUES ('ProtectMemNames', '1');
INSERT INTO `nucleus_config` VALUES ('BaseSkin', '5');
INSERT INTO `nucleus_config` VALUES ('SkinsURL', 'http://localhost:8080/nucleus/skins/');
INSERT INTO `nucleus_config` VALUES ('ActionURL', 'http://localhost:8080/nucleus/action.php');
INSERT INTO `nucleus_config` VALUES ('URLMode', 'normal');
INSERT INTO `nucleus_config` VALUES ('DatabaseVersion', '310');

CREATE TABLE `nucleus_item` (
  `inumber` int(11) NOT NULL auto_increment,
  `ititle` varchar(160) default NULL,
  `ibody` text NOT NULL,
  `imore` text,
  `iblog` int(11) NOT NULL default '0',
  `iauthor` int(11) NOT NULL default '0',
  `itime` datetime NOT NULL default '0000-00-00 00:00:00',
  `iclosed` tinyint(2) NOT NULL default '0',
  `idraft` tinyint(2) NOT NULL default '0',
  `ikarmapos` int(11) NOT NULL default '0',
  `icat` int(11) default NULL,
  `ikarmaneg` int(11) NOT NULL default '0',
  PRIMARY KEY  (`inumber`),
  UNIQUE KEY `inumber` (`inumber`),
  KEY `itime` (`itime`),
  FULLTEXT KEY `ibody` (`ibody`,`ititle`,`imore`)
) TYPE=MyISAM PACK_KEYS=0;

INSERT INTO `nucleus_item` VALUES (1, 'Welcome to Nucleus v3.2', 'The building blocks are here to help you create a web presence, be it a personal blog, a family page, a business site or maybe you just don''t have any idea. Well you came to the right place, cause we didn''t know what you wanted either.<br />\r\n<br />\r\nWe''ve loaded this first entry with links and information to get you started. Though you can delete this entry, it will eventually scroll off the main page as you add to your site. Add your notes as comments while you learn to work with Nucleus and bookmark this page to gain access to it in the future.', '<b>Home - <a href="http://nucleuscms.org/" title="Nucleus CMS home">nucleuscms.org</a></b><br />\r\n<br />\r\nWelcome to the world of Nucleus.<br />\r\n<br />\r\nIn 2001 a set of PHP scripts were let loose on the open net. Algorithms to read data and display it in a browser window via the preferred language of html. Some of us caught link of Nucleus and to this day are still amazed at how light, flexible and secure this publishing system is.<br />\r\n<br />\r\nWe hope you enjoy this power.<br />\r\n<br />\r\n<b>Documentation - <a href="http://docs.nucleuscms.org/" title="Nucleus Documentation">docs.nucleuscms.org</a></b><br />\r\n<br />\r\nThe Nucleus <a href="http://nucleuscms.org/faq.php">frequently asked questions</a> page.<br />\r\n<br />\r\nThe install process places <a href="/nucleus/documentation/">user</a> and <a href="/nucleus/documentation/devdocs/">developer</a> documentation on your web server.<br />\r\n<br />\r\nPop-up <a href="/nucleus/documentation/help.html">help</a> is available throughout the administration area and will assist you in customizing and designing your site.<br />\r\n<br />\r\nOnce you''ve read through the available documentation, please visit the <a href="http://wiki.nucleuscms.org/">Wiki</a> for user written how-tos and tips.<br />\r\n<br />\r\n<b>Support - <a href="http://forum.nucleuscms.org/" title="Nucleus Support Forum">forum.nucleuscms.org</a></b><br />\r\n<br />\r\nThanks to the <a href="http://forum.nucleuscms.org/groupcp.php?g=3">moderators</a> and all the volunteers manning the support forums.<br />\r\n<br />\r\n- <a href="http://edmondhui.homeip.net/blog/">admun</a> - Ottawa, ON, Canada 	  	<br />\r\n- <a href="http://www.tamizhan.com/">anand</a> - Bangalore, India<br />\r\n- <a href="http://hcgtv.com">hcgtv</a> - Miami, USA<br />\r\n- <a href="http://www.adrenalinsports.nl/">ikeizer</a> - Maastricht<br />\r\n- <a href="http://www.tipos.com.br/">moraes</a> -  Curitiba, Brazil<br />\r\n- <a href="http://roelg.nl/">roel</a> -  Rotterdam, The Netherlands<br />\r\n- <a href="http://budts.be/weblog/">TeRanEX</a> - Ekeren, Antwerp, Belgium<br />\r\n- <a href="http://music.trentadams.com/">Trent</a> - Alberta, Canada<br />\r\n- <a href="http://xiffy.nl/weblog/">xiffy</a> - Deventer<br />\r\n<br />\r\nIf you should require assistance, please don''t hesitate to <a href="http://forum.nucleuscms.org/faq.php">join</a> the 1800+ registered users in our forums. With it''s built in search capability and 28,000+ posted articles, your answers are just a few clicks away.<br />\r\n<br />\r\n<b>Personalization - <a href="http://skins.nucleuscms.org/" title="Nucleus Skins">skins.nucleuscms.org</a></b><br />\r\n<br />\r\nThe combination of multi-weblogs and skins/templates make for a powerful duo in personalizing your site or designing one for a friend, relative or client.<br />\r\n<br />\r\nThe featured sites are a sampling of the 682 <a href="http://nucleuscms.org/sites.php">sites running Nucleus</a>.<br />\r\n<br />\r\nPersonal blogs<br />\r\n- <a href="http://beefcake.nl/">beefcake.nl</a> - Beefcake | Nuke the whales!<br />\r\n- <a href="http://www.rakaz.nl/">rakaz.nl</a> - Rakaz''s personal weblog<br />\r\n- <a href="http://www.stanch.net/">stanch.net</a> - Not everything here makes sense<br />\r\n- <a href="http://bloggard.com/">bloggard.com</a> - The Adventures of Bloggard<br />\r\n- <a href="http://battleangel.org/">battleangel.org</a> - Giving meaning to the meaningless<br />\r\n- <a href="http://www.yetanotherblog.de/">yetanotherblog.de</a> - Yet Another Blog<br />\r\n<br />\r\nMulti user blogs<br />\r\n- <a href="http://tipos.com.br/">tipos.com.br</a> - Blogging community<br />\r\n<br />\r\nHobby, Travel and News sites<br />\r\n- <a href="http://adrenalinsports.nl/">adrenalinsports.nl</a> - Extreme sports<br />\r\n- <a href="http://hsbluebird.com/">hsbluebird.com</a> - Hot Springs, Montana''s Online Resource <br />\r\n- <a href="http://groningen-info.de/">groningen-info.de</a> - Neues aus Groningen. F�r Leute aus Duitsland.<br />\r\n- <a href="http://www.americandaily.com/">americandaily.com</a> - American Daily - Home<br />\r\n<br />\r\n<b>Nucleus Developer Network - <a href="http://dev.nucleuscms.org/" title="Nucleus Developer Network">dev.nucleuscms.org</a></b><br />\r\n<br />\r\nThe NUDN is a hub for developer sites and programming resources.<br />\r\n<br />\r\nNUDN satellite sites, handles, location and UTC offset:<br />\r\n- <a href="http://karma.nucleuscms.org/">karma</a> - Izegem +02<br />\r\n- <a href="http://nupusi.com/">hcgtv</a> - Miami -05<br />\r\n- <a href="http://edmondhui.homeip.net/blog/nudn.php">admun</a> - Ottawa -04<br />\r\n- <a href="http://dev.budts.be/nucleus/">TeRanEX</a> - Ekeren +02<br />\r\n<br />\r\nSourceforge.net graciously hosts our <a href="http://sourceforge.net/projects/nucleuscms/">CVS repository</a>.<br />\r\n<br />\r\nWant to play around or test changes, visit our demo site at <a href="http://demo.nucleuscms.org/">demo.nucleuscms.org</a>.<br />\r\n<br />\r\nThen visit the <a href="http://wiki.nucleuscms.org/plugin">plugin repository</a> for download and installation instructions.<br />\r\n<br />\r\n<b>Donators</b><br />\r\n<br />\r\nI would like to thank these <a href="http://nucleuscms.org/donators.php">nice people</a> for their <a href="http://nucleuscms.org/donate.php">support</a>. <em>Thanks all!</em><br />\r\n<br />\r\nLike Nucleus? Vote for us at <a href="http://www.hotscripts.com/Detailed/13368.html?RID=nucleus@demuynck.org">HotScripts</a> and <a href="http://www.opensourcecms.com/index.php?option=content&task=view&id=145">opensourceCMS</a>.<br />\r\n<br />\r\n<b>License</b><br />\r\n<br />\r\nWhen we speak of free software, we are referring to freedom, not price. Our <a href="http://www.gnu.org/licenses/gpl.html">General Public Licenses</a> are designed to make sure that you have the freedom to distribute copies of free software (and charge for this service if you wish), that you receive source code or can get it if you want it, that you can change the software or use pieces of it in new free programs; and that you know you can do these things.', 1, 1, '2005-02-21 18:48:27', 0, 0, 0, 1, 0);

CREATE TABLE `nucleus_karma` (
  `itemid` int(11) NOT NULL default '0',
  `ip` char(15) NOT NULL default ''
) TYPE=MyISAM;

CREATE TABLE `nucleus_member` (
  `mnumber` int(11) NOT NULL auto_increment,
  `mname` varchar(16) NOT NULL default '',
  `mrealname` varchar(60) default NULL,
  `mpassword` varchar(40) NOT NULL default '',
  `memail` varchar(60) default NULL,
  `murl` varchar(100) default NULL,
  `mnotes` varchar(100) default NULL,
  `madmin` tinyint(2) NOT NULL default '0',
  `mcanlogin` tinyint(2) NOT NULL default '1',
  `mcookiekey` varchar(40) default NULL,
  `deflang` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`mnumber`),
  UNIQUE KEY `mname` (`mname`),
  UNIQUE KEY `mnumber` (`mnumber`)
) TYPE=MyISAM;

INSERT INTO `nucleus_member` VALUES (1, 'God', 'God', '714d82a0a84f9c6e3495fe2aa5618627', 'example@example.org', 'http://localhost:8080/nucleus/', '', 1, 1, '2b0b7cec42e697b5aae52461b2398e44', '');

CREATE TABLE `nucleus_plugin` (
  `pid` int(11) NOT NULL auto_increment,
  `pfile` varchar(40) NOT NULL default '',
  `porder` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pid`),
  KEY `pid` (`pid`),
  KEY `porder` (`porder`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_plugin_event` (
  `pid` int(11) NOT NULL default '0',
  `event` varchar(40) default NULL,
  KEY `pid` (`pid`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_plugin_option` (
  `ovalue` text NOT NULL,
  `oid` int(11) NOT NULL auto_increment,
  `ocontextid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`oid`,`ocontextid`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_plugin_option_desc` (
  `oid` int(11) NOT NULL auto_increment,
  `opid` int(11) NOT NULL default '0',
  `oname` varchar(20) NOT NULL default '',
  `ocontext` varchar(20) NOT NULL default '',
  `odesc` varchar(255) default NULL,
  `otype` varchar(20) default NULL,
  `odef` text,
  `oextra` text,
  PRIMARY KEY  (`opid`,`oname`,`ocontext`),
  UNIQUE KEY `oid` (`oid`)
) TYPE=MyISAM;

CREATE TABLE `nucleus_skin` (
  `sdesc` int(11) NOT NULL default '0',
  `stype` varchar(20) NOT NULL default '',
  `scontent` text NOT NULL,
  PRIMARY KEY  (`sdesc`,`stype`)
) TYPE=MyISAM;

INSERT INTO `nucleus_skin` VALUES (2, 'index', '<?xml version="1.0" encoding="utf-8"?>\r\n<feed version="0.3" xmlns="http://purl.org/atom/ns#">\r\n    <title><%blogsetting(name)%></title>\r\n    <link rel="alternate" type="text/html" href="<%blogsetting(url)%>" />\r\n    <generator url="http://nucleuscms.org/"><%version%></generator>\r\n    <modified><%blog(feeds/atom/modified,1)%></modified>\r\n    <%blog(feeds/atom/entries,10)%>\r\n</feed>');
INSERT INTO `nucleus_skin` VALUES (4, 'index', '<?xml version="1.0"?>\r\n<rsd version="1.0">\r\n <service>\r\n  <engineName><%version%></engineName>\r\n  <engineLink>http://nucleuscms.org/</engineLink>\r\n  <homepageLink><%sitevar(url)%></homepageLink>\r\n  <apis>\r\n   <api name="MetaWeblog" preferred="true" apiLink="<%adminurl%>xmlrpc/server.php" blogID="<%blogsetting(id)%>">\r\n    <docs>http://nucleuscms.org/documentation/devdocs/xmlrpc.html</docs>\r\n   </api>\r\n   <api name="Blogger" preferred="false" apiLink="<%adminurl%>xmlrpc/server.php" blogID="<%blogsetting(id)%>">\r\n    <docs>http://nucleuscms.org/documentation/devdocs/xmlrpc.html</docs>\r\n   </api>\r\n  </apis>\r\n </service>\r\n</rsd>');
INSERT INTO `nucleus_skin` VALUES (3, 'index', '<?xml version="1.0" encoding="ISO-8859-1"?>\r\n<rss version="2.0">\r\n  <channel>\r\n    <title><%blogsetting(name)%></title>\r\n    <link><%blogsetting(url)%></link>\r\n    <description><%blogsetting(desc)%></description>\r\n    <!-- optional tags -->\r\n    <language>en-us</language>           <!-- valid langugae goes here -->\r\n    <generator><%version%></generator>\r\n    <copyright>�</copyright>             <!-- Copyright notice -->\r\n    <category>Weblog</category>\r\n    <docs>http://backend.userland.com/rss</docs>\r\n    <image>\r\n      <url><%blogsetting(url)%>/nucleus/nucleus2.gif</url>\r\n      <title><%blogsetting(name)%></title>\r\n      <link><%blogsetting(url)%></link>\r\n    </image>\r\n    <%blog(feeds/rss20,10)%>\r\n  </channel>\r\n</rss>');
INSERT INTO `nucleus_skin` VALUES (1, 'item', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%itemtitle%> - <%blogsetting(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n  <meta name="description" content="<%blogsetting(desc)%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="alternate" type="application/rss+xml" title="RSS" href="xml-rss2.php" />\n  <link rel="archives" title="Archives" href="<%archivelink%>" />\n  <link rel="top" title="Today" href="<%sitevar(url)%>" />\n  <link rel="next" href="<%nextlink%>" title="Next Item" />\n  <link rel="prev" href="<%prevlink%>" title="Previous Item" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n <!-- page title -->\n <h1><%blogsetting(name)%></h1>\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- inserts the selected item using the template named ''grey/full''     -->\n <%item(grey/full)%>\n\n <!-- this tag inserts the comments on the selected item, also using the -->\n <!-- template with name ''grey/full''                                     -->\n <h2>Comments</h2>\n <%comments(grey/full)%>\n\n <h2>Add Comments</h2>\n <%commentform%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n <ul class="nobullets">\n  <li><a href="<%nextlink%>">Previous Item</a></li>\n  <li><a href="<%prevlink%>">Next Item</a></li>\n  <li><a href="<%todaylink%>">Today</a></li>\n  <li><a href="<%archivelink%>">Archives</a></li>\n  <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n\n <h2>Categories</h2>\n <%categorylist(grey/short)%>\n\n <h2>Search</h2>\n <%searchform%>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'member', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%sitevar(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="top" title="Today" href="<%todaylink%>" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- a title -->\n <h1><%sitevar(name)%></h1>\n\n <h2>Info about <%member(name)%></h2>\n\n <ul>\n  <li>Real name: <%member(realname)%></li>\n  <li>Website: <a href="<%member(url)%>"><%member(url)%></a></li>\n </ul>\n\n <h2>Send Message</h2>\n <%membermailform%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n\n <ul class="nobullets">\n  <li><a href="<%todaylink%>">Today</a></li>\n  <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'search', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%blogsetting(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n  <meta name="description" content="<%blogsetting(desc)%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n  \n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="alternate" type="application/rss+xml" title="RSS" href="xml-rss2.php" />\n  <link rel="archives" title="Archives" href="<%archivelink%>" />\n  <link rel="top" title="Today" href="<%sitevar(url)%>" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- a title -->\n <h1><%blogsetting(name)%></h1>\n\n <h2>Search</h2>\n <%searchform%>\n\n <h2>Search results</h2>\n <%searchresults(grey/short)%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n\n <ul class="nobullets">\n   <li><a href="<%todaylink%>">Today</a></li>\n   <li><a href="<%archivelink%>">Archives</a></li>\n   <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n\n <h2>Search</h2>\n <%searchform%>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'error', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%sitevar(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="top" title="Today" href="<%todaylink%>" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n</div>\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- a title -->\n <h1><%sitevar(name)%></h1>\n\n <h2>Error!</h2>\n\n <p><%errormessage%></p>\n\n <p><a href="javascript:history.go(-1);">Go back</a></p>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n\n <ul class="nobullets">\n  <li><a href="<%todaylink%>">Today</a></li>\n  <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'imagepopup', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%imagetext%></title>\n  <style type="text/css">\n   img { border: none; }\n   body { margin: 0px; }\n  </style>\n</head>\n<body onblur="window.close()">\n  <a href="javascript:window.close();"><%image%></a>\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'index', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%blogsetting(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n  <meta name="description" content="<%blogsetting(desc)%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="archives" title="Archives" href="<%archivelink%>" />\n  <link rel="top" title="Today" href="<%todaylink%>" />\n\n  <!-- link RSS as alternate version -->\n  <link rel="alternate" type="application/rss+xml" title="RSS" href="xml-rss2.php" />\n\n  <!-- RSD support -->\n  <link rel="EditURI" type="application/rsd+xml" title="RSD" href="rsd.php" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n <!-- page title -->\n <h1><%blogsetting(name)%></h1>\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- this tag inserts a weblog using the template named ''grey/short''   -->\n <!-- and showing 15 entries                                                -->\n <%blog(grey/short,15)%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo (left-top) -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n <ul class="nobullets">\n  <li><a href="<%todaylink%>">Today</a></li>\n  <li><a href="<%archivelink%>">Archives</a></li>\n  <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n\n <h2>Categories</h2>\n <%categorylist(grey/short)%>\n\n <h2>Search</h2>\n <%searchform%>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>My Links</h2>\n\n <ul class="nobullets">\n  <li><a href="http://nucleuscms.org/" title="This site is Nucleus-powered">Nucleus</a></li>\n  <li><a href="http://www.weblogs.com/" title="latest updates">Weblogs</a></li>\n  <li><a href="http://www.daypop.com/" title="Search news &amp; weblog sites">DayPop</a></li>\n  <li><a href="http://www.google.com/" title="Search the web">Google</a></li>\n </ul>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'archivelist', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%blogsetting(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n  <meta name="description" content="<%blogsetting(desc)%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="alternate" type="application/rss+xml" title="RSS" href="xml-rss2.php" />\n  <link rel="archives" title="Archives" href="<%archivelink%>" />\n  <link rel="top" title="Today" href="<%sitevar(url)%>" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n<!-- a title -->\n<h1><%blogsetting(name)%></h1>\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <h2>Archives</h2>\n <!-- This tag inserts the archivelist using the grey/short template -->\n <%archivelist(grey/short)%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a> \n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n <ul class="nobullets">\n   <li><a href="<%todaylink%>">Today</a></li>\n   <li><a href="<%archivelink%>">Archives</a></li>\n   <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n\n <h2>Categories</h2>\n <%categorylist(grey/short)%>\n \n <h2>Search</h2>\n <%searchform%>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n\n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (1, 'archive', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n  <title><%blogsetting(name)%></title>\n\n  <!-- some meta information (search engines might read this) -->\n  <meta name="generator" content="<%version%>" />\n  <meta name="description" content="<%blogsetting(desc)%>" />\n\n  <!-- stylesheet definition (points to the place where colors -->\n  <!-- and layout is defined -->\n  <link rel="stylesheet" type="text/css" href="<%skinfile(grey.css)%>" />\n\n  <!-- prevent caching (can be removed) -->\n  <meta http-equiv="Pragma" content="no-cache" />\n  <meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />\n  <meta http-equiv="Expires" content="-1" />\n  \n  <!-- extra navigational links -->\n  <link rel="bookmark" title="Nucleus" href="http://nucleuscms.org/" />\n  <link rel="alternate" type="application/rss+xml" title="RSS" href="xml-rss2.php" />\n  <link rel="archives" title="Archives" href="<%archivelink%>" />\n  <link rel="top" title="Today" href="<%sitevar(url)%>" />\n  <link rel="up" href="<%todaylink%>" title="Today" />\n\n</head>\n<body>\n\n<!-- here starts the code that will be displayed in your browser -->\n<div class="contents">\n\n <!-- this is a normally hidden link, included for accessibility reasons -->\n <a href="#navigation" class="skip">Jump to navigation</a>\n\n <!-- a title -->\n <h1><%blogsetting(name)%></h1>\n\n <!-- This tag inserts the archive using the grey/short template -->\n <%archive(grey/short)%>\n\n</div><!-- end of the contents div -->\n\n<!-- definition of the logo left-top -->\n<div class="logo">\n <a href="<%sitevar(url)%>"><img src="<%skinfile(atom3.gif)%>" width="155" height="137" alt="" /></a>\n</div>\n\n<!-- definition of the menu -->\n<div class="menu">\n <!-- accessibility anchor -->\n <a name="navigation" id="navigation" class="skip"></a>\n <h1 class="skip">Navigation</h1>\n\n <h2>Navigation</h2>\n\n <ul class="nobullets">\n   <li><a href="<%prevlink%>">Previous <%archivetype%></a></li>\n   <li><a href="<%nextlink%>">Next <%archivetype%></a></li>\n   <li><a href="<%todaylink%>">Today</a></li>\n   <li><a href="<%archivelink%>">Archives</a></li>\n   <li><a href="<%adminurl%>">Admin Area</a></li>\n </ul>\n\n <h2>Categories</h2>\n <%categorylist(grey/short)%>\n\n <h2>Search</h2>\n <%searchform%>\n \n <h2>Login</h2>\n <%loginform%>\n\n <h2>Powered by</h2>\n <%nucleusbutton(nucleus.gif,85,31)%>\n \n</div>\n\n</body>\n</html>');
INSERT INTO `nucleus_skin` VALUES (5, 'archive', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<div class="contenttitle">\n<h2>Archives</h2>\n</div>\nYou are currently viewing archive for <%archivedate%>\n</div>\n<%archive(default/short)%>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'archivelist', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<div class="contenttitle">\n<h2>Archives</h2>\n</div>\n<dl>\n<dt>Monthly Archives</dt>\n<%archivelist(default/short)%>\n</dl>\n</div>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'error', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<div class="contenttitle">\n<h2>Error!</h2>\n</div>\n<%errormessage%><br /><br />\n<a href="javascript:history.go(-1);">Go back</a>\n</div>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'imagepopup', '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\n<html>\n<head>\n<title><%imagetext%></title>\n<style type="text/css">\nimg { border: none; }\nbody { margin: 0px; }\n</style>\n</head>\n\n<body onblur="window.close()">\n<a href="javascript:window.close();"><%image%></a>\n</body>\n\n</html>');
INSERT INTO `nucleus_skin` VALUES (5, 'index', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<%blog(default/short,10)%>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'item', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<%item(default/full)%>\n</div>\n<div class="content">\n<div class="contenttitle">\n<h2>Comments</h2>\n</div>\n<a name="c"></a>\n<%comments(default/full)%>\n</div>\n<div class="content">\n<div class="contenttitle">\n<h2>Add Comment</h2>\n</div>\n<%commentform%>\n</div>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'member', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<div class="contenttitle">\n<h2>Info about <%member(name)%></h2>\n</div>\nReal name: <%member(realname)%>\n<br /><br />\nWebsite: <a href="<%member(url)%>"><%member(url)%></a>\n</div>\n<div class="content">\n<div class="contenttitle">\n<h2>Send message</h2>\n</div>\n<%membermailform%>\n</div>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');
INSERT INTO `nucleus_skin` VALUES (5, 'search', '<%parsedinclude(head.inc)%>\n\n<%parsedinclude(header.inc)%>\n\n<div id="container">\n<div class="content">\n<div class="contenttitle">\n<h2>Search Results</h2>\n</div>\n<%searchform%>\n</div>\n<%searchresults(default/short)%>\n</div>\n\n<h2 class="hidden">Sidebar</h2>\n<div id="sidebarcontainer">\n<%parsedinclude(menu.inc)%>\n</div>\n\n<%parsedinclude(footer.inc)%>');

CREATE TABLE `nucleus_skin_desc` (
  `sdnumber` int(11) NOT NULL auto_increment,
  `sdname` varchar(20) NOT NULL default '',
  `sddesc` varchar(200) default NULL,
  `sdtype` varchar(40) NOT NULL default 'text/html',
  `sdincmode` varchar(10) NOT NULL default 'normal',
  `sdincpref` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`sdnumber`),
  UNIQUE KEY `sdname` (`sdname`),
  UNIQUE KEY `sdnumber` (`sdnumber`)
) TYPE=MyISAM;

INSERT INTO `nucleus_skin_desc` VALUES (2, 'feeds/atom', 'Atom 0.3 weblog syndication', 'application/atom+xml', 'normal', '');
INSERT INTO `nucleus_skin_desc` VALUES (3, 'feeds/rss20', 'RSS 2.0 syndication of weblogs', 'text/xml', 'normal', '');
INSERT INTO `nucleus_skin_desc` VALUES (4, 'xml/rsd', 'RSD (Really Simple Discovery) information for weblog clients', 'text/xml', 'normal', '');
INSERT INTO `nucleus_skin_desc` VALUES (1, 'grey', 'Default skin to display your blog', 'text/html', 'skindir', 'grey/');
INSERT INTO `nucleus_skin_desc` VALUES (5, 'default', 'Nucleus default skin', 'text/html', 'skindir', 'default/');

CREATE TABLE `nucleus_team` (
  `tmember` int(11) NOT NULL default '0',
  `tblog` int(11) NOT NULL default '0',
  `tadmin` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`tmember`,`tblog`)
) TYPE=MyISAM;

INSERT INTO `nucleus_team` VALUES (1, 1, 1);

CREATE TABLE `nucleus_template` (
  `tdesc` int(11) NOT NULL default '0',
  `tpartname` varchar(20) NOT NULL default '',
  `tcontent` text NOT NULL,
  PRIMARY KEY  (`tdesc`,`tpartname`)
) TYPE=MyISAM;

INSERT INTO `nucleus_template` VALUES (3, 'ITEM', '<item>\r\n <title><![CDATA[<%title%>]]></title>\r\n <link><%blogurl%>index.php?itemid=<%itemid%></link>\r\n<description><![CDATA[<%body%><%more%>]]></description>\r\n <category><%category%></category>\r\n<comments><%blogurl%>index.php?itemid=<%itemid%></comments>\r\n <pubDate><%date(rfc822)%></pubDate>\r\n</item>');
INSERT INTO `nucleus_template` VALUES (3, 'EDITLINK', '<a href="<%editlink%>" onclick="<%editpopupcode%>">edit</a>');
INSERT INTO `nucleus_template` VALUES (4, 'ITEM', '<%date(utc)%>');
INSERT INTO `nucleus_template` VALUES (5, 'ITEM', '<entry>\r\n <title type="text/html" mode="escaped"><![CDATA[<%title%>]]></title>\r\n <link rel="alternate" type="text/html" href="<%blogurl%>index.php?itemid=<%itemid%>" />\r\n <author>\r\n  <name><%author%></name>\r\n </author>\r\n <modified><%date(utc)%></modified>\r\n <issued><%date(iso8601)%></issued>\r\n <content type="text/html" mode="escaped"><![CDATA[<%body%><%more%>]]></content>\r\n <id><%blogurl%>:<%blogid%>:<%itemid%></id>\r\n</entry>');
INSERT INTO `nucleus_template` VALUES (1, 'ITEM', '\n<h3 class="item"><%title%></h3>\n\n<div class="itembody">\n  <%body%>\n  <%morelink%>\n</div>\n\n<div class="iteminfo">\n  <%time%> -\n  <a href="<%authorlink%>"><%author%></a> -\n  <%edit%>\n  <%comments%>\n</div>\n');
INSERT INTO `nucleus_template` VALUES (1, 'FORMAT_TIME', '%X');
INSERT INTO `nucleus_template` VALUES (1, 'IMAGE_CODE', '<%image%>');
INSERT INTO `nucleus_template` VALUES (1, 'FORMAT_DATE', '%x');
INSERT INTO `nucleus_template` VALUES (1, 'EDITLINK', '<a href="<%editlink%>" onclick="<%editpopupcode%>">edit</a> -');
INSERT INTO `nucleus_template` VALUES (1, 'DATE_HEADER', '<h2>%d %B</h2>');
INSERT INTO `nucleus_template` VALUES (1, 'COMMENTS_TOOMUCH', '<a href="<%itemlink%>" rel="bookmark"><%commentcount%> <%commentword%></a>');
INSERT INTO `nucleus_template` VALUES (1, 'COMMENTS_ONE', 'comment');
INSERT INTO `nucleus_template` VALUES (1, 'COMMENTS_NONE', '<a href="<%itemlink%>" rel="bookmark">No <%commentword%></a>');
INSERT INTO `nucleus_template` VALUES (1, 'CATLIST_LISTITEM', ' <li><a href="<%catlink%>"><%catname%></a></li>');
INSERT INTO `nucleus_template` VALUES (1, 'COMMENTS_MANY', 'comments');
INSERT INTO `nucleus_template` VALUES (1, 'CATLIST_HEADER', '<ul class="nobullets"><li><a href="<%blogurl%>">All</a></li>');
INSERT INTO `nucleus_template` VALUES (1, 'CATLIST_FOOTER', '</ul>');
INSERT INTO `nucleus_template` VALUES (1, 'ARCHIVELIST_LISTITEM', '<li><a href="<%archivelink%>">%B, %Y</a></li>');
INSERT INTO `nucleus_template` VALUES (1, 'ARCHIVELIST_HEADER', '<ul>');
INSERT INTO `nucleus_template` VALUES (1, 'ARCHIVELIST_FOOTER', '</ul>');
INSERT INTO `nucleus_template` VALUES (2, 'ITEM', '\n<h2><%date(%d %B)%></h2>\n<h3 class="item"><%title%></h3>\n\n<div class="itembody">\n  <%body%>\n  <br /><br />\n  <%more%>\n</div>\n\n<div class="iteminfo">\n  posted at <%time%> on <%date%>\n  by <a href="?memberid=<%authorid%>"><%author%></a> -\n  Category: <a href="<%categorylink%>"><%category%></a>\n  <%edit%>\n</div>\n');
INSERT INTO `nucleus_template` VALUES (2, 'COMMENTS_NONE', '<div class="comments">No comments yet</div>');
INSERT INTO `nucleus_template` VALUES (2, 'COMMENTS_ONE', 'comment');
INSERT INTO `nucleus_template` VALUES (2, 'EDITLINK', '- <a href="<%editlink%>" onclick="<%editpopupcode%>">edit</a>');
INSERT INTO `nucleus_template` VALUES (2, 'FORMAT_DATE', '%x');
INSERT INTO `nucleus_template` VALUES (2, 'FORMAT_TIME', '%X');
INSERT INTO `nucleus_template` VALUES (2, 'IMAGE_CODE', '<%image%>');
INSERT INTO `nucleus_template` VALUES (3, 'FORMAT_DATE', '%x');
INSERT INTO `nucleus_template` VALUES (3, 'FORMAT_TIME', '%X');
INSERT INTO `nucleus_template` VALUES (2, 'COMMENTS_MANY', 'comments');
INSERT INTO `nucleus_template` VALUES (2, 'COMMENTS_BODY', '<h3 class="comment"><%userlink%> wrote:</h3>\n\n<div class="commentbody">\n  <%body%>\n</div>\n\n<div class="commentinfo">\n  <%date%> <%time%>\n</div>');
INSERT INTO `nucleus_template` VALUES (1, 'LOCALE', 'en');
INSERT INTO `nucleus_template` VALUES (1, 'MEDIA_CODE', '<%media%>');
INSERT INTO `nucleus_template` VALUES (1, 'MORELINK', '<a href="<%itemlink%>">[Read More!]</a>');
INSERT INTO `nucleus_template` VALUES (1, 'POPUP_CODE', '<%popuplink%>');
INSERT INTO `nucleus_template` VALUES (1, 'SEARCH_HIGHLIGHT', '<span class="highlight">\\0</span>');
INSERT INTO `nucleus_template` VALUES (1, 'SEARCH_NOTHINGFOUND', 'No search results found for <b><%query%></b>');
INSERT INTO `nucleus_template` VALUES (2, 'LOCALE', 'en');
INSERT INTO `nucleus_template` VALUES (2, 'MEDIA_CODE', '<%media%>');
INSERT INTO `nucleus_template` VALUES (2, 'POPUP_CODE', '<%popuplink%>');
INSERT INTO `nucleus_template` VALUES (2, 'SEARCH_HIGHLIGHT', '<span class="highlight">\\0</span>');
INSERT INTO `nucleus_template` VALUES (6, 'CATLIST_LISTITEM', '<dd><a href="<%catlink%>" title="Category: <%catname%>"><%catname%></a></dd>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'CATLIST_HEADER', '<dd><a href="<%blogurl%>" title="All categories">All</a></dd>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'ARCHIVELIST_LISTITEM', '<dd><a href="<%archivelink%>" title="Archive for %B, %Y">%B, %Y</a></dd>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'COMMENTS_ONE', 'Comment');
INSERT INTO `nucleus_template` VALUES (6, 'COMMENTS_MANY', 'Comments');
INSERT INTO `nucleus_template` VALUES (6, 'COMMENTS_NONE', '<div class="contentitem3"><small class="contentitemcomments">\r\n<a href="<%itemlink%>#c" rel="bookmark" title="Add comment on ''<%itemtitle%>''">Add comment</a>\r\n</small></div>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'COMMENTS_TOOMUCH', '<div class="contentitem3"><small class="contentitemcomments">\r\n<a href="<%itemlink%>#c" rel="bookmark"\r\ntitle="Add comment on ''<%itemtitle%>''"><%commentcount%> <%commentword%></a>\r\n</small></div>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'MORELINK', '<p>&raquo; <a href="<%itemlink%>#more" title="Read more on ''<%title%>''">Read More</a></p>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'EDITLINK', '<div class="contentitem4">\r\n<small class="contentitemedit">\r\n<a href="<%editlink%>" title="Make changes to your entry" onclick="<%editpopupcode%>" >Edit item</a>\r\n</small></div>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'ITEM', '<div class="content">\r\n<div class="contenttitle">\r\n<h2><%date%>: <a href="<%itemlink%>" title="Read entry: <%title%>"><%title%></a></h2>\r\n</div>\r\n<div class="contentitem">\r\n<div class="contentitem1">\r\n<small class="contentitemcategory">\r\nCategory: <a href="<%categorylink%>" title="Category: <%Category%>"><%Category%></a>\r\n</small></div>\r\n<div class="contentitem2">\r\n<small class="contentitempostedby">\r\nPosted by: <a href="<%authorlink%>" title="Author: <%author%>"><%author%></a>\r\n</small></div>\r\n<%comments%>\r\n<%edit%>\r\n</div>\r\n<div class="contentbody">\r\n<%body%>\r\n<%morelink%>\r\n</div>\r\n</div>\r\n');
INSERT INTO `nucleus_template` VALUES (7, 'COMMENTS_ONE', 'comment');
INSERT INTO `nucleus_template` VALUES (7, 'COMMENTS_MANY', 'comments');
INSERT INTO `nucleus_template` VALUES (7, 'COMMENTS_NONE', '<div class="comments">No comments yet</div>');
INSERT INTO `nucleus_template` VALUES (7, 'COMMENTS_BODY', '<div class="itemcomment id<%memberid%>">\r\n<h3><a href="<%userlinkraw%>"\r\ntitle="<%ip%> | Click to visit <%user%>''s website or send an email">\r\n<%user%></a> wrote:</h3>\r\n<div class="commentbody">\r\n<%body%>\r\n</div>\r\n<div class="commentinfo">\r\n<%date%> <%time%>\r\n</div>\r\n</div>\r\n');
INSERT INTO `nucleus_template` VALUES (7, 'EDITLINK', '<div class="contentitem4">\r\n<small class="contentitemedit">\r\n<a href="<%editlink%>" title="Make changes to your entry" onclick="<%editpopupcode%>" >Edit item</a>\r\n</small></div>\r\n');
INSERT INTO `nucleus_template` VALUES (7, 'ITEM', '<div class="contenttitle">\r\n<h2><%date%>: <%title%></h2></div>\r\n<div class="contentitem">\r\n<div class="contentitem1">\r\n<small class="contentitemcategory">\r\nCategory: <a href="<%categorylink%>" title="Category: <%category%>"><%category%></a>\r\n</small></div>\r\n<div class="contentitem2">\r\n<small class="contentitempostedby">\r\nPosted by: <a href="<%authorlink%>" title="Author: <%author%>"><%author%></a>\r\n</small></div>\r\n<%edit%>\r\n</div>\r\n<div class="contentbody">\r\n<%body%><br /><br />\r\n<a name="more"></a><%more%>\r\n</div>\r\n');
INSERT INTO `nucleus_template` VALUES (7, 'FORMAT_DATE', '%d/%m');
INSERT INTO `nucleus_template` VALUES (7, 'FORMAT_TIME', '%X');
INSERT INTO `nucleus_template` VALUES (7, 'LOCALE', 'en');
INSERT INTO `nucleus_template` VALUES (7, 'SEARCH_HIGHLIGHT', '<span class="highlight">\\0</span>');
INSERT INTO `nucleus_template` VALUES (7, 'POPUP_CODE', '<%popuplink%>');
INSERT INTO `nucleus_template` VALUES (7, 'MEDIA_CODE', '<%media%>');
INSERT INTO `nucleus_template` VALUES (7, 'IMAGE_CODE', '<%image%>');
INSERT INTO `nucleus_template` VALUES (6, 'FORMAT_DATE', '%d/%m');
INSERT INTO `nucleus_template` VALUES (6, 'FORMAT_TIME', '%X');
INSERT INTO `nucleus_template` VALUES (6, 'LOCALE', 'en');
INSERT INTO `nucleus_template` VALUES (6, 'SEARCH_HIGHLIGHT', '<span class="highlight">\\0</span>');
INSERT INTO `nucleus_template` VALUES (6, 'SEARCH_NOTHINGFOUND', '<div class="content">No search results found for <b><%query%></b></div>\r\n');
INSERT INTO `nucleus_template` VALUES (6, 'POPUP_CODE', '<%popuplink%>');
INSERT INTO `nucleus_template` VALUES (6, 'MEDIA_CODE', '<%media%>');
INSERT INTO `nucleus_template` VALUES (6, 'IMAGE_CODE', '<%image%>');

CREATE TABLE `nucleus_template_desc` (
  `tdnumber` int(11) NOT NULL auto_increment,
  `tdname` varchar(20) NOT NULL default '',
  `tddesc` varchar(200) default NULL,
  PRIMARY KEY  (`tdnumber`),
  UNIQUE KEY `tdnumber` (`tdnumber`),
  UNIQUE KEY `tdname` (`tdname`)
) TYPE=MyISAM;

INSERT INTO `nucleus_template_desc` VALUES (4, 'feeds/atom/modified', 'Atom feeds: Inserts last modification date');
INSERT INTO `nucleus_template_desc` VALUES (5, 'feeds/atom/entries', 'Atom feeds: Feed items');
INSERT INTO `nucleus_template_desc` VALUES (3, 'feeds/rss20', 'Used for RSS 2.0 syndication of your blog');
INSERT INTO `nucleus_template_desc` VALUES (1, 'grey/short', 'The default template that is used to display your Nucleus blog');
INSERT INTO `nucleus_template_desc` VALUES (2, 'grey/full', 'Used for detailed item pages');
INSERT INTO `nucleus_template_desc` VALUES (6, 'default/short', 'Nucleus default blog template');
INSERT INTO `nucleus_template_desc` VALUES (7, 'default/full', 'Nucleus default item template');

CREATE TABLE `nucleus_tickets` (
  `ticket` varchar(40) NOT NULL default '',
  `ctime` datetime NOT NULL default '0000-00-00 00:00:00',
  `member` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ticket`,`member`)
) TYPE=MyISAM;
