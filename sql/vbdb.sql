-- Adminer 4.7.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `car_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  PRIMARY KEY (`car_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `garage`;
CREATE TABLE `garage` (
  `garage_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `color` varchar(6) NOT NULL,
  `bodygroups` varchar(20) DEFAULT NULL,
  `license_plate` varchar(11) NOT NULL DEFAULT 'VeryBadRP',
  PRIMARY KEY (`garage_id`),
  UNIQUE KEY `player_id_car_id` (`player_id`,`car_id`),
  KEY `car_id` (`car_id`),
  CONSTRAINT `garage_ibfk_4` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`) ON UPDATE CASCADE,
  CONSTRAINT `garage_ibfk_5` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `steam_id` varchar(25) NOT NULL,
  `item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `inventory_id` (`inventory_id`),
  UNIQUE KEY `idxInvItem` (`steam_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`steam_id`) REFERENCES `players` (`steam_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id` (`item_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(191) COLLATE utf8_bin NOT NULL,
  `organization_color` varchar(6) COLLATE utf8_bin NOT NULL,
  `organization_created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`organization_id`),
  UNIQUE KEY `organization_id` (`organization_id`),
  UNIQUE KEY `organization_name` (`organization_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `rank_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `steam_id` varchar(25) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `player_money` int(11) NOT NULL,
  `sex` char(1) NOT NULL,
  `first_connection` date DEFAULT NULL,
  `bodygroup` varchar(191) NOT NULL,
  `group_permissions` varchar(191) NOT NULL DEFAULT '0',
  `is_police_chief` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `player_id` (`player_id`),
  UNIQUE KEY `steam_id` (`steam_id`),
  UNIQUE KEY `idxPlyNames` (`first_name`,`last_name`),
  KEY `organization_id` (`organization_id`),
  KEY `rank_id` (`rank_id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE,
  CONSTRAINT `players_ibfk_2` FOREIGN KEY (`rank_id`) REFERENCES `rank` (`rank_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rank`;
CREATE TABLE `rank` (
  `rank_id` int(11) NOT NULL AUTO_INCREMENT,
  `rank_name` char(1) NOT NULL,
  PRIMARY KEY (`rank_id`),
  UNIQUE KEY `rank_id` (`rank_id`),
  UNIQUE KEY `rank_name` (`rank_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- 2019-11-05 10:29:35