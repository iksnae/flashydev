# CocoaMySQL dump
# Version 0.5
# http://cocoamysql.sourceforge.net
#
# Host: 192.168.0.14 (MySQL 4.0.21 Complete MySQL by Server Logistics)
# Database: test
# Generation Time: 2005-08-09 15:09:20 +1000
# ************************************************************

# Dump of table comments
# ------------------------------------------------------------

CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `who` varchar(128) NOT NULL default '',
  `fromURL` varchar(255) default '',
  `postedOn` datetime NOT NULL default '0000-00-00 00:00:00',
  `comment` text NOT NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

INSERT INTO `comments` (`id`,`who`,`fromURL`,`postedOn`,`comment`) VALUES ("2","Luke","http://www.lingoworkshop.com","2005-08-09 12:39:37","Hello World");


