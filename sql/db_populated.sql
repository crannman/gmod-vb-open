-- Adminer 4.7.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `car_id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  PRIMARY KEY (`car_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `car` (`car_id`, `identifier`) VALUES
(3,	'c12'),
(2,	'mas_ghibli'),
(4,	'skyline_r34'),
(1,	'sl65amg');

DROP TABLE IF EXISTS `garage`;
CREATE TABLE `garage` (
  `garage_id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `car_id` int NOT NULL,
  `color` varchar(6) NOT NULL,
  `bodygroups` varchar(20) DEFAULT NULL,
  `license_plate` varchar(11) NOT NULL DEFAULT 'VeryBadRP',
  PRIMARY KEY (`garage_id`),
  UNIQUE KEY `player_id_car_id` (`player_id`,`car_id`),
  KEY `car_id` (`car_id`),
  CONSTRAINT `garage_ibfk_4` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`) ON UPDATE CASCADE,
  CONSTRAINT `garage_ibfk_5` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `steam_id` varchar(25) NOT NULL,
  `item_id` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `inventory_id` (`inventory_id`),
  UNIQUE KEY `idxInvItem` (`steam_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`steam_id`) REFERENCES `players` (`steam_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id` (`item_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `item` (`item_id`, `name`) VALUES
(57,	'ENTITY_LAMP'),
(29,	'MARKET_LOAM'),
(34,	'MARKET_WEED'),
(31,	'MARKET_WEEDPOT'),
(27,	'MARKET_WEEDSEED'),
(77,	'PROP_BIG_METAL_FENCE01'),
(59,	'PROP_BIG_TABLE01'),
(72,	'PROP_BIG_TABLE02'),
(55,	'PROP_BLASTDOOR01'),
(76,	'PROP_BLUECHAIR'),
(63,	'PROP_DOCUMENT_CABINET01'),
(81,	'PROP_FURNITURE01'),
(65,	'PROP_FURNITURE02'),
(12,	'PROP_INDOOR_BENCH01'),
(16,	'PROP_METAL_DOOR_FENCE'),
(74,	'PROP_METAL_DOOR_FRAME'),
(23,	'PROP_METAL_SHELVES01'),
(64,	'PROP_NORMAL_METAL_FENCE01'),
(30,	'PROP_NORMAL_METAL_FENCE02'),
(15,	'PROP_POLICE_BARRICADE01'),
(6,	'PROP_POLICE_BARRICADE02'),
(45,	'PROP_SMALL_METAL_FENCE01'),
(39,	'PROP_SMALL_METAL_FENCE02'),
(33,	'PROP_SMALL_METAL_FENCE03'),
(9,	'PROP_SOFA1'),
(14,	'PROP_TRASHBIN1'),
(24,	'PROP_WOODFENCE01'),
(54,	'PROP_WOODFENCE02'),
(26,	'PROP_WOOD_BAR01'),
(2,	'PROP_WOOD_DRESSER01'),
(84,	'PROP_WOOD_SHELVES01'),
(68,	'PROP_WOOD_SHELVES02'),
(36,	'UPGR_ACOG'),
(7,	'UPGR_AIMPOINT'),
(21,	'UPGR_AMMO'),
(78,	'UPGR_AMMO_AP'),
(47,	'UPGR_AMMO_BIRDSHOT'),
(43,	'UPGR_AMMO_FRAG'),
(49,	'UPGR_AMMO_HP'),
(48,	'UPGR_AMMO_INCENDIARY'),
(46,	'UPGR_AMMO_MAGNUM'),
(1,	'UPGR_AMMO_SLUG'),
(51,	'UPGR_BALLISTIC'),
(41,	'UPGR_BIPOD'),
(38,	'UPGR_CMAG'),
(37,	'UPGR_ELCAN'),
(28,	'UPGR_EOTECH557'),
(35,	'UPGR_KOBRA'),
(11,	'UPGR_LASERSIGHT'),
(13,	'UPGR_REFLEXSIGHT'),
(17,	'UPGR_RIFLEREFLEX'),
(32,	'UPGR_VERTGRIP'),
(61,	'WEP_57'),
(53,	'WEP_AK47'),
(62,	'WEP_AUG'),
(8,	'WEP_AWP'),
(20,	'WEP_CZ75'),
(71,	'WEP_DEAGLE'),
(18,	'WEP_DUAL'),
(4,	'WEP_FAMAS'),
(25,	'WEP_G3'),
(83,	'WEP_G36C'),
(40,	'WEP_GALIL'),
(42,	'WEP_GLOCK18'),
(66,	'WEP_L85A2'),
(75,	'WEP_M14EBR'),
(58,	'WEP_M249'),
(79,	'WEP_M3'),
(80,	'WEP_M4A1'),
(44,	'WEP_M92FS'),
(67,	'WEP_M98B'),
(10,	'WEP_MAC10'),
(19,	'WEP_MP5'),
(5,	'WEP_MR96'),
(69,	'WEP_P228'),
(50,	'WEP_P90'),
(3,	'WEP_SCOUT'),
(82,	'WEP_SG550'),
(70,	'WEP_SG552'),
(73,	'WEP_SPAS12'),
(56,	'WEP_SR3M'),
(22,	'WEP_TMP'),
(52,	'WEP_UMP45'),
(60,	'WEP_XM1014');

DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `organization_id` int NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(191) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `organization_color` varchar(6) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `organization_created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`organization_id`),
  UNIQUE KEY `organization_id` (`organization_id`),
  UNIQUE KEY `organization_name` (`organization_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `rank_id` int NOT NULL,
  `organization_id` int DEFAULT NULL,
  `steam_id` varchar(25) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `player_money` int NOT NULL,
  `sex` char(1) NOT NULL,
  `first_connection` date DEFAULT NULL,
  `bodygroup` varchar(191) NOT NULL,
  `group_permissions` varchar(191) NOT NULL DEFAULT '0',
  `is_police_chief` tinyint NOT NULL DEFAULT '0',
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
  `rank_id` int NOT NULL AUTO_INCREMENT,
  `rank_name` char(1) NOT NULL,
  PRIMARY KEY (`rank_id`),
  UNIQUE KEY `rank_id` (`rank_id`),
  UNIQUE KEY `rank_name` (`rank_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `rank` (`rank_id`, `rank_name`) VALUES
(6,	'A'),
(4,	'G'),
(5,	'M'),
(3,	'S'),
(1,	'U'),
(2,	'V'),
(7,	'X');

-- 2020-02-23 12:09:22
