-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 22. Jun 2014 um 17:40
-- Server Version: 5.5.37-0ubuntu0.14.04.1
-- PHP-Version: 5.5.9-1ubuntu4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `scuttle`
--

DELIMITER $$
--
-- Prozeduren
--
CREATE DEFINER=`sakai`@`localhost` PROCEDURE `drop_tables_like`(pattern varchar(255), db varchar(255))
begin
select @str_sql:=concat('drop table ', group_concat(table_name))
from information_schema.tables
where table_schema=db and table_name like pattern;

prepare stmt from @str_sql;
execute stmt;
drop prepare stmt;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_fachbereich`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_fachbereich` (
  `fb_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fb_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fb_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`fb_id`),
  UNIQUE KEY `fb_kuerzel` (`fb_kuerzel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `modulverwaltung_fachbereich`
--

INSERT INTO `modulverwaltung_fachbereich` (`fb_id`, `fb_name`, `fb_kuerzel`) VALUES
(1, 'Mathematik und Informatik', '19'),
(2, 'Physik', '20');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_gebaeude`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_gebaeude` (
  `g_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `g_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `g_strasse` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `g_strassen_nummer` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `g_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`g_id`),
  UNIQUE KEY `g_kuerzel` (`g_kuerzel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Daten für Tabelle `modulverwaltung_gebaeude`
--

INSERT INTO `modulverwaltung_gebaeude` (`g_id`, `g_name`, `g_strasse`, `g_strassen_nummer`, `g_kuerzel`) VALUES
(1, 'Informatik Hauptgebäude', 'Takusstraße', '9', 'T 9'),
(2, '', 'Arnimallee', '5 / 7', 'A 5 / 7'),
(3, 'PI - Gebäude', 'Arnimallee', '6', 'A 6'),
(4, '', 'Arnimallee', '3 / 3A', 'A 3 / 3A'),
(5, '', 'Königin-Luise-Straße', '24 / 26', 'KöLu 24/26');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_huelsen`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_huelsen` (
  `h_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `h_sws1` int(2) NOT NULL,
  `h_ects` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `h_kuerzel1` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `h_sws2` int(2) DEFAULT NULL,
  `h_kuerzel2` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `i_id` bigint(20) NOT NULL,
  PRIMARY KEY (`h_id`),
  KEY `i_id` (`i_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_institut`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_institut` (
  `i_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `i_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `i_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `fb_id` bigint(20) NOT NULL,
  PRIMARY KEY (`i_id`),
  KEY `fb_id` (`fb_id`),
  KEY `fb_id_2` (`fb_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Daten für Tabelle `modulverwaltung_institut`
--

INSERT INTO `modulverwaltung_institut` (`i_id`, `i_name`, `i_kuerzel`, `fb_id`) VALUES
(6, 'keine STO', '0', 1),
(7, 'STO Informatik', '1', 1),
(8, 'STO Mathematik', '2', 1),
(9, 'keine STO', '0', 2),
(10, 'STO Physik', '1', 2),
(11, 'STO Bioinformatik', '3', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_klausur`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_klausur` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kt_id` bigint(20) NOT NULL,
  `m_id` bigint(20) NOT NULL,
  `s_id` bigint(20) NOT NULL,
  `k_datum` date DEFAULT NULL,
  `r_id` bigint(20) DEFAULT NULL,
  `k_von` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_bis` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  KEY `kt_id` (`kt_id`,`m_id`,`s_id`),
  KEY `m_id` (`m_id`),
  KEY `s_id` (`s_id`),
  KEY `t_id` (`r_id`),
  KEY `r_id` (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_klausur_typ`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_klausur_typ` (
  `kt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kt_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`kt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `modulverwaltung_klausur_typ`
--

INSERT INTO `modulverwaltung_klausur_typ` (`kt_id`, `kt_name`) VALUES
(1, 'Klausur'),
(2, 'Zwischenklausur'),
(3, 'Nachklausur'),
(4, 'Mündliche Prüfung');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_lehrender`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_lehrender` (
  `l_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `l_vorname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `l_nachname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `l_zedat_account` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `l_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lt_id` bigint(20) NOT NULL,
  PRIMARY KEY (`l_id`),
  KEY `lt_id` (`lt_id`),
  KEY `lt_id_2` (`lt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=291 ;

--
-- Daten für Tabelle `modulverwaltung_lehrender`
--

INSERT INTO `modulverwaltung_lehrender` (`l_id`, `l_vorname`, `l_nachname`, `l_zedat_account`, `l_email`, `lt_id`) VALUES
(2, 'Stephan', 'Adler', 'adler', 'adler@zedat.fu-berlin.de', 1),
(5, 'Ulrike', 'Alexiev', 'alexiev', 'alexiev@zedat.fu-berlin.de', 1),
(6, 'Helmut', 'Alt', 'alt', 'alt@zedat.fu-berlin.de', 1),
(8, 'Sandro', 'Andreotti', 'andreott', 'andreott@zedat.fu-berlin.de', 1),
(10, 'Andrei', 'Asinowski', 'asinowski', 'asinowski@zedat.fu-berlin.de', 1),
(12, 'Stefanie', 'Bahe', 'bahe', 'bahe@zedat.fu-berlin.de', 4),
(13, 'Isabella', 'Bargilly', 'bargilly', 'bargilly@zedat.fu-berlin.de', 4),
(14, 'Bernhard', 'Brehm', 'bbrehm', 'bbrehm@zedat.fu-berlin.de', 1),
(15, 'Karin', 'Bergmann', 'bergmannkar', 'bergmannkar@zedat.fu-berlin.de', 1),
(16, 'Benjamin', 'Hatting', 'bhatting', 'bhatting@zedat.fu-berlin.de', 1),
(19, 'Brigitte', 'Odeh', 'bodeh', 'bodeh@zedat.fu-berlin.de', 1),
(20, 'Beate', 'Pierchalla', 'bpiercha', 'bpiercha@zedat.fu-berlin.de', 4),
(21, 'Jürgen', 'Braun', 'braunj', 'braunj@zedat.fu-berlin.de', 1),
(22, 'Robert', 'Brodwolf', 'brodwolf', 'brodwolf@zedat.fu-berlin.de', 2),
(24, 'Teresa', 'Busjahn', 'busjahn', 'busjahn@zedat.fu-berlin.de', 1),
(25, 'Christoph', 'Benzmüller', 'cbenzmueller', 'cbenzmueller@zedat.fu-berlin.de', 1),
(26, 'Carsten', 'Lange', 'cemcl', 'cemcl@zedat.fu-berlin.de', 1),
(28, 'Christoph', 'Schaller', 'chschall', 'chschall@zedat.fu-berlin.de', 1),
(30, 'Dennis', 'Clemens', 'cle1986', 'cle1986@zedat.fu-berlin.de', 1),
(31, 'Claudia', 'Mueller-Birn', 'clmb', 'clmb@zedat.fu-berlin.de', 1),
(32, 'Carsten', 'Schulte', 'cschulte', 'cschulte@zedat.fu-berlin.de', 1),
(35, 'Birgit', 'Dabisch', 'dabisch', 'dabisch@zedat.fu-berlin.de', 1),
(36, 'Holger', 'Dau', 'dau', 'dau@zedat.fu-berlin.de', 1),
(37, 'Stefanie', 'Demmler', 'demmler', 'demmler@zedat.fu-berlin.de', 1),
(38, 'Claudia', 'Dieckmann', 'dieck', 'dieck@zedat.fu-berlin.de', 1),
(39, 'Dorothe', 'Auth', 'doroauth', 'doroauth@zedat.fu-berlin.de', 1),
(40, 'Jens Matthias', 'Dreger', 'dreger', 'dreger@zedat.fu-berlin.de', 1),
(43, 'Ekaterina', 'Engel', 'eengel', 'eengel@zedat.fu-berlin.de', 1),
(44, 'Elfriede', 'Fehr', 'efehr', 'efehr@zedat.fu-berlin.de', 1),
(46, 'Ulrike', 'Eickers', 'eickers', 'eickers@zedat.fu-berlin.de', 4),
(47, 'Elena', 'Martinengo', 'elenamartine', 'elenamartine@zedat.fu-berlin.de', 1),
(48, 'Elke', 'Heinecke', 'elkeh', 'elkeh@zedat.fu-berlin.de', 1),
(49, 'Elvira', 'Scheich', 'elsch', 'elsch@zedat.fu-berlin.de', 1),
(52, 'Enrica', 'Bordignon', 'enricab', 'enricab@zedat.fu-berlin.de', 1),
(53, 'Hélène', 'Esnault', 'esnault', 'esnault@zedat.fu-berlin.de', 1),
(54, 'Margarita', 'Esponda', 'esponda', 'esponda@mi.fu-berlin.de', 1),
(56, 'Jörg', 'Fandrich', 'fandrich', 'fandrich@zedat.fu-berlin.de', 1),
(57, 'Frank', 'Hoffmann', 'fershoff', 'fershoff@zedat.fu-berlin.de', 1),
(59, 'Robert', 'Franke', 'frankero', 'frankero@zedat.fu-berlin.de', 1),
(60, 'Fritz', 'Ulbrich', 'fritz', 'fritz.ulbrich@fu-berlin.de', 1),
(61, 'Paul', 'Fumagalli', 'fumagall', 'fumagall@zedat.fu-berlin.de', 1),
(64, 'Gesine', 'Milde', 'gesinem', 'milde@inf.fu-berlin.de', 4),
(65, 'Gabriele', 'Herrmann', 'gherrman', 'gherrman@zedat.fu-berlin.de', 1),
(67, 'Gudrun', 'May-Nasseri', 'gmay3', 'gmay3@zedat.fu-berlin.de', 4),
(68, 'Carsten', 'Gräser', 'graeser', 'graeser@zedat.fu-berlin.de', 1),
(69, 'Mesut', 'Günes', 'guenes', 'guenes@zedat.fu-berlin.de', 1),
(70, 'Thomas', 'Gust', 'gustron', 'gustron@zedat.fu-berlin.de', 1),
(71, 'Lilit', 'Hakobyan', 'hakobyan', 'hakobyan@zedat.fu-berlin.de', 1),
(72, 'Marko', 'Harasic', 'harasic', 'harasic@zedat.fu-berlin.de', 1),
(73, 'Hanne', 'Hardering', 'harderin', 'harderin@zedat.fu-berlin.de', 1),
(74, 'Michael', 'Haumann', 'haumann', 'haumann@zedat.fu-berlin.de', 1),
(75, 'Heike', 'Eckart', 'heickart', 'heickart@zedat.fu-berlin.de', 4),
(76, 'Lutz', 'Heindorf', 'heindorf', 'heindorf@zedat.fu-berlin.de', 1),
(77, 'Manfred', 'Hild', 'hild', 'hild@zedat.fu-berlin.de', 1),
(79, 'Edzard', 'Hoefig', 'hoefig', 'hoefig@zedat.fu-berlin.de', 1),
(81, 'Benjamin', 'Güldenring', 'ibenny', 'ibenny@zedat.fu-berlin.de', 1),
(82, 'Ina', 'Schieferdecker', 'ina', 'ina@zedat.fu-berlin.de', 1),
(83, 'Ingmar', 'Camphausen', 'ingmar', 'ingmar@zedat.fu-berlin.de', 3),
(84, 'Jan-Ole', 'Malchow', 'j0m', 'j0m@zedat.fu-berlin.de', 1),
(85, 'Jens', 'Eisert', 'jense', 'jense@zedat.fu-berlin.de', 1),
(87, 'Jochen', 'Schiller', 'jhs67', 'jhs67@zedat.fu-berlin.de', 1),
(90, 'Klaus', 'Altmann', 'kaltmann', 'kaltmann@zedat.fu-berlin.de', 1),
(91, 'Eva-Cristina', 'Stanca-Kaposta', 'kaposta', 'kaposta@zedat.fu-berlin.de', 4),
(92, 'Anja', 'Kasseckert', 'kassecke', 'kassecke@zedat.fu-berlin.de', 4),
(93, 'Katinka', 'Wolter', 'katinkaw', 'katinkaw@zedat.fu-berlin.de', 1),
(94, 'Kristian', 'Beilke', 'kbeilke', 'kbeilke@zedat.fu-berlin.de', 1),
(95, 'Katharina', 'Franke', 'kjfranke', 'kjfranke@zedat.fu-berlin.de', 1),
(97, 'Christoph', 'Kohstall', 'kohstall', 'kohstall@zedat.fu-berlin.de', 1),
(99, 'Konstantin', 'Poelke', 'kpoelke', 'kpoelke@zedat.fu-berlin.de', 1),
(100, 'Daniel', 'Kreßner', 'kressner', 'kressner@zedat.fu-berlin.de', 1),
(101, 'Klaus', 'Kriegel', 'kriegel', 'kriegel@zedat.fu-berlin.de', 1),
(102, 'Wolfgang', 'Kuch', 'kuch', 'kuch@zedat.fu-berlin.de', 1),
(103, 'Marcel', 'Kyas', 'kyas', 'kyas@zedat.fu-berlin.de', 1),
(104, 'Tim', 'Landgraf', 'landgraf', 'landgraf@zedat.fu-berlin.de', 1),
(105, 'Achim', 'Liers', 'liers', 'liers@zedat.fu-berlin.de', 1),
(106, 'Albrecht', 'Lindinger', 'lindin', 'lindin@zedat.fu-berlin.de', 1),
(107, 'Lars', 'Kastner', 'lkastner', 'lkastner@zedat.fu-berlin.de', 1),
(108, 'Ribisch', 'Lukas', 'lribisch', 'lribisch@zedat.fu-berlin.de', 2),
(109, 'Marianne', 'Braun', 'mabraun', 'mabraun@zedat.fu-berlin.de', 1),
(110, 'Marianne', 'Merz', 'mamerz', 'mamerz@zedat.fu-berlin.de', 1),
(111, 'Martin Christian', 'Götze', 'martni', 'martni@zedat.fu-berlin.de', 1),
(114, 'Matthias', 'Horn', 'mhorn', 'mhorn@zedat.fu-berlin.de', 1),
(116, 'Mary', 'Metzler-Kliegl', 'mmetzler', 'mmetzler@zedat.fu-berlin.de', 4),
(118, 'Wolfgang', 'Mulzer', 'mulzer', 'mulzer@zedat.fu-berlin.de', 1),
(119, 'Ana-Nicoleta', 'Bondar', 'nbondar', 'nbondar@zedat.fu-berlin.de', 1),
(120, 'Mariana', 'Neves', 'neves', 'neves@zedat.fu-berlin.de', 1),
(122, 'Tamara', 'Nunner', 'nunner', 'nunner@zedat.fu-berlin.de', 1),
(124, 'Angelika', 'Pasanec', 'pasanec', 'pasanec@zedat.fu-berlin.de', 3),
(125, 'Adrian', 'Paschke', 'paschke', 'paschke@zedat.fu-berlin.de', 1),
(128, 'Petra', 'Imhof', 'pimhof', 'pimhof@zedat.fu-berlin.de', 1),
(129, 'Elke', 'Pose', 'pose', 'pose@zedat.fu-berlin.de', 4),
(130, 'Lutz', 'Prechelt', 'prechelt', 'prechelt@zedat.fu-berlin.de', 1),
(132, 'Ralph', 'Püttner', 'puettner', 'puettner@zedat.fu-berlin.de', 1),
(133, 'Martin', 'Aigner', 'ren05gia', 'ren05gia@zedat.fu-berlin.de', 1),
(136, 'Rolf-Bodo', 'Riediger-Klaus', 'riediger', 'riediger@zedat.fu-berlin.de', 3),
(137, 'Raúl', 'Rojas', 'rojas', 'rojas@zedat.fu-berlin.de', 1),
(138, 'Günter', 'Rote', 'rote', 'rote@zedat.fu-berlin.de', 1),
(139, 'Ramona', 'Schlesinger', 'rschlesinger', 'rschlesinger@zedat.fu-berlin.de', 1),
(140, 'Stefanie', 'Ruß', 'russ', 'russ@zedat.fu-berlin.de', 1),
(142, 'Ralph', 'Schäfermeier', 'schaef', 'schaef@zedat.fu-berlin.de', 1),
(143, 'Carsten', 'Schaeuble', 'schauble', 'schauble@zedat.fu-berlin.de', 3),
(144, 'Julia', 'Schenk', 'schenu', 'julia.schenk@fu-berlin.de', 1),
(146, 'Susanne', 'Schoettker-Soehl', 'schoetke', 'schoetke@zedat.fu-berlin.de', 4),
(147, 'Sebastian', 'Müller', 'semu', 'semu@zedat.fu-berlin.de', 1),
(148, 'Ulrike', 'Seyferth', 'seyferth', 'seyferth@zedat.fu-berlin.de', 3),
(149, 'Silvia', 'Hoemke', 'shoes', 'shoes@zedat.fu-berlin.de', 1),
(150, 'Melanie', 'Siering', 'siering', 'siering@zedat.fu-berlin.de', 4),
(153, 'Christian', 'Zick', 'sowhat', 'sowhat@zedat.fu-berlin.de', 1),
(154, 'Matthias', 'Bernien', 'spacebea', 'spacebea@zedat.fu-berlin.de', 1),
(155, 'Stephan', 'Salinger', 'ssalinge', 'ssalinge@zedat.fu-berlin.de', 1),
(156, 'Saskia', 'Steiger', 'ssteiger', 'ssteiger@zedat.fu-berlin.de', 1),
(157, 'Christian', 'Stump', 'stumpc5', 'stumpc5@zedat.fu-berlin.de', 1),
(159, 'Tibor', 'Szabo', 'szabo', 'szabo@zedat.fu-berlin.de', 1),
(160, 'Ernesto', 'Tapia-Rodriguez', 'tapia', 'tapia@zedat.fu-berlin.de', 1),
(163, 'Sylvia', 'Theodos', 'theodos', 'theodos@zedat.fu-berlin.de', 3),
(165, 'Tillmann', 'Miltzow', 'till85', 'till85@zedat.fu-berlin.de', 1),
(167, 'Alexandru Aurelian', 'Todor', 'todor', 'todor@zedat.fu-berlin.de', 1),
(168, 'Julia', 'Löwenstein', 'toju', 'toju@zedat.fu-berlin.de', 2),
(169, 'Robert', 'Tolksdorf', 'tolk', 'tolk@zedat.fu-berlin.de', 1),
(173, 'Susi', 'Uezel', 'uezel', 'uezel@zedat.fu-berlin.de', 3),
(174, 'Ulrike', 'Geiger', 'ugeiger', 'ugeiger@zedat.fu-berlin.de', 1),
(175, 'Ursula', 'Schild', 'uschild', 'uschild@zedat.fu-berlin.de', 4),
(177, 'Agnès', 'Voisard', 'voisard', 'voisard@zedat.fu-berlin.de', 1),
(178, 'Volker', 'Roth', 'volkerroth', 'volkerroth@zedat.fu-berlin.de', 1),
(179, 'Felix', 'Oppen', 'vonoppen', 'vonoppen@zedat.fu-berlin.de', 1),
(180, 'Matthias', 'Waehlisch', 'waehl', 'waehl@zedat.fu-berlin.de', 1),
(181, 'Martin', 'Weinelt', 'weinelt', 'weinelt@zedat.fu-berlin.de', 1),
(184, 'Anna', 'Wissdorf', 'wissdorf', 'wissdorf@zedat.fu-berlin.de', 1),
(185, 'Ludger Heinrich', 'Wöste', 'woeste', 'woeste@zedat.fu-berlin.de', 1),
(186, 'Till', 'Zoppke', 'zoppke', 'zoppke@zedat.fu-berlin.de', 1),
(187, 'Emmanuel', 'Baccelli', 'emmanuel.baccelli', 'emmanuel.baccelli@fu-berlin.de', 1),
(189, 'Heiko', 'Will', 'hwill', 'hwill@inf.fu-berlin.de', 1),
(191, 'Amjad', 'Saadeh', 'trion', 'trion@zedat.fu-berlin.de', 2),
(192, 'Jim', 'Neuendorf', 'jimneuendorf', 'jimneuendorf@zedat.fu-berlin.de', 2),
(193, 'Lucas', 'Jacob', 'lucasjacob', 'lucasjacob@zedat.fu-berlin.de', 2),
(195, 'Nicolas', 'Lehmann', 'vellox', 'vellox@zedat.fu-berlin.de', 2),
(196, 'Katharina', 'Colditz', 'kcolditz', 'kcolditz@zedat.fu-berlin.de', 2),
(197, 'Jonas', 'Cleve', 'jonascleve', 'jonascleve@zedat.fu-berlin.de', 2),
(198, 'Sebastian', 'Faase', 'sacastor', 'sacastor@zedat.fu-berlin.de', 2),
(199, 'Alexander', 'Kauer', 'alexander.kauer', 'alexander.kauer@fu-berlin.de', 2),
(200, 'Simon', 'Tippenhauer', 'simon.tippenhauer', 'simon.tippenhauer@fu-berlin.de', 2),
(201, 'Katharina', 'Klost', 'kathklost', 'kathklost@zedat.fu-berlin.de', 2),
(203, 'Marco', 'Traeger', 'marcot', 'marcot@zedat.fu-berlin.de', 2),
(204, 'Timo', 'Hanisch', 'timoh1991', 'timoh1991@zedat.fu-berlin.de', 2),
(205, 'Max Peter', 'Wisniewski', 'mwisnie', 'mwisnie@zedat.fu-berlin.de', 2),
(206, 'Julian', 'Fleischer', 'scravy', 'scravy@zedat.fu-berlin.de', 2),
(207, 'Melanie', 'Skodzik', 'm.skodzik', 'm.skodzik@fu-berlin.de', 2),
(208, 'Thierry', 'Meurers', 'srcds', 'srcds@zedat.fu-berlin.de', 2),
(209, 'Christopher', 'Pockrandt', 'cpockrandt', 'cpockrandt@zedat.fu-berlin.de', 2),
(210, 'Marcel', 'Ehrhardt', 'marehr', 'marehr@zedat.fu-berlin.de', 2),
(211, 'Ron', 'Wenzel', 'ron.wenzel', 'ron.wenzel@fu-berlin.de', 2),
(212, 'Tim Tobias', 'Braun', 'timbraun', 'timbraun@zedat.fu-berlin.de', 2),
(213, 'Florian', 'Ruhland', 'flomo', 'flomo@zedat.fu-berlin.de', 2),
(214, 'Philipp', 'Haarmeyer', 'cph', 'cph@zedat.fu-berlin.de', 2),
(215, 'Denise', 'Thiel', 'denisethiel', 'denisethiel@zedat.fu-berlin.de', 2),
(216, 'Julius', 'Auer', 'juauer', 'juauer@zedat.fu-berlin.de', 2),
(217, 'Moritz', 'Hoeppner', 'moritzhoepp', 'moritzhoepp@zedat.fu-berlin.de', 2),
(218, 'Paul', 'Dieckwisch', 'paul777', 'paul777@zedat.fu-berlin.de', 2),
(219, 'Martin', 'Karl', 'bigl', 'bigl@zedat.fu-berlin.de', 2),
(220, 'Beck', 'Florian', 'casi', 'casi@zedat.fu-berlin.de', 2),
(221, 'Koki', 'Yoshimoto', 'yoshimoto', 'yoshimoto@zedat.fu-berlin.de', 2),
(222, 'Benedikt John', 'Wieder', 'benjohnwie', 'benjohnwie@zedat.fu-berlin.de', 2),
(223, 'Philipp Leon', 'Weber', 'leonweber', 'leonweber@zedat.fu-berlin.de', 2),
(224, 'Justus', 'Pfannschmidt', 'pfannie', 'pfannie@zedat.fu-berlin.de', 2),
(225, 'David', 'Bohn', 'davbohn', 'davbohn@zedat.fu-berlin.de', 2),
(226, 'Kristin', 'Knorr', 'knorrkri', 'knorrkri@zedat.fu-berlin.de', 2),
(227, 'Claudia', 'Dieckmann', 'dieck', 'dieck@zedat.fu-berlin.de', 1),
(228, 'Lena', 'Schlipf', 'schlipf', 'schlipf@zedat.fu-berlin.de', 2),
(231, 'Paul', 'Podlech', 'madcow', 'madcow@zedat.fu-berlin.de', 2),
(232, 'Christian', 'Hofmann', 'chofmann', 'chofmann@zedat.fu-berlin.de', 2),
(233, 'Enrico', 'Seiler', 'enricoseiler', 'enricoseiler@zedat.fu-berlin.de', 2),
(234, 'Max', 'Willert', 'willerma', 'willerma@zedat.fu-berlin.de', 2),
(235, 'Michael', 'Kmoch', 'alkatore', 'alkatore@zedat.fu-berlin.de', 2),
(236, 'Eduard Johannes', 'Wolf', 'edbrain7', 'edbrain7@zedat.fu-berlin.de', 2),
(237, 'Tony', 'Schwedek', 'schwtony', 'schwtony@zedat.fu-berlin.de', 2),
(239, 'Mehmet Can', 'Göktas', 'cangoektas', 'cangoektas@zedat.fu-berlin.de', 2),
(240, 'Hoang Ha', 'Do', 'ryuujin', 'ryuujin@zedat.fu-berlin.de', 2),
(241, 'Alexander', 'Kammeyer', 'akammeyer', 'akammeyer@zedat.fu-berlin.de', 2),
(242, 'Thomas', 'Tegethoff', 'cone', 'cone@zedat.fu-berlin.de', 2),
(243, 'Ajit', 'Parikh', 'paraj21', 'paraj21@zedat.fu-berlin.de', 2),
(244, 'Thomas Vincent', 'Boelens', 'tvboelens', 'tvboelens@zedat.fu-berlin.de', 2),
(245, 'Nadja', 'Scharf', 'scharfn', 'scharfn@zedat.fu-berlin.de', 2),
(246, 'Oliver', 'Wiese', 'oliver.wiese', 'oliver.wiese@fu-berlin.de', 2),
(247, 'Michael', 'Decker', 'eboreus113', 'eboreus113@zedat.fu-berlin.de', 2),
(248, 'Kathleen', 'Gallo', 'kgallo13', 'kgallo13@zedat.fu-berlin.de', 2),
(249, 'Annkatrin Sarah', 'Bressin', 'annkatrin', 'annkatrin@zedat.fu-berlin.de', 2),
(250, 'Thimo', 'Wellner', 'thwelln31416', 'thwelln31416@zedat.fu-berlin.de', 2),
(251, 'Benjamin', 'Heinrich', 'bheinrich', 'bheinrich@zedat.fu-berlin.de', 2),
(252, 'Nino', 'Hatter', 'hatter', 'hatter@zedat.fu-berlin.de', 2),
(253, 'Michael', 'Kleinert', 'chemicha', 'chemicha@zedat.fu-berlin.de', 2),
(254, 'Christian', 'Krumnow', 'ckrumnow', 'ckrumnow@zedat.fu-berlin.de', 2),
(255, 'Bartosz', 'Kowalik', 'bkowalik', 'bkowalik@zedat.fu-berlin.de', 2),
(256, 'Christian', 'Fräßdorf', 'fraisy', 'fraisy@zedat.fu-berlin.de', 2),
(257, 'Robert', 'Huebener', 'rhuebener', 'rhuebener@zedat.fu-berlin.de', 2),
(258, 'Alexander', 'Humeniuk', 'humeniuka', 'humeniuka@zedat.fu-berlin.de', 2),
(259, 'Silvia', 'Kusminskiy', 'kusminskiy', 'kusminskiy@zedat.fu-berlin.de', 2),
(260, 'Francis', 'Wilken', 'wilken', 'wilken@zedat.fu-berlin.de', 2),
(261, 'Clemens', 'Meyer zu Rheda', 'meyerc', 'meyerc@zedat.fu-berlin.de', 2),
(263, 'Jens-Thorsten', 'Ollek', 'jtollek', 'jtollek@zedat.fu-berlin.de', 2),
(265, 'Robert', 'Brodwolf', 'brodwolf', 'brodwolf@zedat.fu-berlin.de', 2),
(266, 'Christian', 'Teutloff', 'teutloff', 'teutloff@zedat.fu-berlin.de', 2),
(268, 'Heike', 'Eckart', 'heickart', 'heickart@zedat.fu-berlin.de', 4),
(269, 'Tamara', 'Knoll', 'tknoll', 'tknoll@zedat.fu-berlin.de', 4),
(273, 'Christina', 'Bracht', 'bracht', 'bracht@zedat.fu-berlin.de', 2),
(276, 'Klaus-Peter', 'Löhr', 'loh', 'lohr@inf.fu-berlin.de', 1),
(278, 'Heinz F.', 'Schweppe', 'schweppe', 'schweppe@inf.fu-berlin.de', 1),
(279, 'Christian', 'Maurer', 'maurer', 'maurer@zedat.fu-berlin.de', 1),
(280, 'Anina', 'Mischau', 'amischau', 'amischau@zedat.fu-berlin.de', 1),
(281, 'Marco', 'Block-Berlitz', 'marco.block', 'marco.block@fu-berlin.de', 1),
(282, 'Hansjürgen', 'Garstka', 'garstka', 'garstka@berlin.de', 1),
(283, 'Christian', 'Anese', 'test', 'testAccount@mail.com', 1),
(284, 'N.', 'N.', NULL, NULL, 1),
(285, 'Felix', 'Daub', 'felix.daub@fu-berlin.de', 'felix.daub@fu-berlin.de', 1),
(286, 'Philip', 'Reinecke', 'preineck', 'preineck@inf.fu-berlin.de', 1),
(287, 'Simon', 'Schmitt', 'rimesime', 'rimesime@zedat.fu-berlin.de	', 1),
(288, 'Christian', 'Anese', 'christian91', 'christian.anese@hotmail.com', 1),
(289, 'Kashif', 'Rasul', 'kashif', 'kashif.rasul@gmail.com', 1),
(290, 'Daniel', 'Göhring', '', '', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_lehrender_typ`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_lehrender_typ` (
  `lt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lt_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`lt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `modulverwaltung_lehrender_typ`
--

INSERT INTO `modulverwaltung_lehrender_typ` (`lt_id`, `lt_name`) VALUES
(1, 'Dozent'),
(2, 'Tutor'),
(3, 'Verwaltung'),
(4, 'Sekretariat');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_lehrveranstaltung`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_lehrveranstaltung` (
  `lv_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lv_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lv_inhalt` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lv_ziel` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lv_literatur` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lv_voraussetzung` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lv_sws` int(2) NOT NULL,
  `lv_anwesenheitspflicht` tinyint(1) NOT NULL,
  `lv_nummer` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `m_id` bigint(20) NOT NULL,
  `lvt_id` bigint(20) NOT NULL,
  PRIMARY KEY (`lv_id`),
  KEY `m_id` (`m_id`,`lvt_id`),
  KEY `m_id_2` (`m_id`),
  KEY `lvt_id` (`lvt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=184 ;

--
-- Daten für Tabelle `modulverwaltung_lehrveranstaltung`
--

INSERT INTO `modulverwaltung_lehrveranstaltung` (`lv_id`, `lv_name`, `lv_inhalt`, `lv_ziel`, `lv_literatur`, `lv_voraussetzung`, `lv_sws`, `lv_anwesenheitspflicht`, `lv_nummer`, `m_id`, `lvt_id`) VALUES
(4, 'ALP II: Objektorientierte Programmierung', '								<ul>\r\n  <li>Grundlagen der Berechenbarkeit: \r\n    <ul>\r\n      <li>Universelle Registermaschinen </li>\r\n      <li>Syntax und operationelle Semantik imperativer Programmiersprachen</li>\r\n    </ul>\r\n  </li>\r\n  <li>Formale Verfahren zur Spezifikation und Verifikation imperativer\r\n    Programme: \r\n    <ul>\r\n      <li>Bedingungen auf dem Zustandsraum (assertions), </li>\r\n      <li>Hoare-Kalkül, partielle Korrektheit, Termination </li>\r\n    </ul>\r\n  </li>\r\n  <li>Konzepte imperativer und objektorientierter Programmierung (Java): \r\n    <ul>\r\n      <li>Primitive und Zusammengesetzte Datentypen, </li>\r\n      <li>Methoden (Prozeduren und Funktionen), Parameterübergabe, Überladung\r\n      </li>\r\n      <li>Module, Klassen, Objekte </li>\r\n      <li>Klassenhierarchien, Vererbung, Polymorphie</li>\r\n      <li>Abstrakte Klassen, Schnittstellen </li>\r\n    </ul>\r\n  </li>\r\n  <li>Programmiermethodik: \r\n    <ul>\r\n      <li>schrittweise korrekte Programmentwicklung </li>\r\n      <li>Teile und Herrsche </li>\r\n      <li>Backtracking </li>\r\n    </ul>\r\n  </li>\r\n  <li>Analyse von Laufzeit und Speicherbedarf: \r\n    <ul>\r\n      <li>O-Notation </li>\r\n      <li>Umwandlung von Rekursion in Iteration </li>\r\n      <li>Analyse von Such- und Sortieralgorithmen </li>\r\n      <li>Algorithmen, Datenstrukturen, Datenabstraktion</li>\r\n    </ul>\r\n  </li>\r\n</ul>\r\n			\r\n			\r\n			', '', '<ul>\r\n<li>Concepts of Programming Languages, Robert Sebesta, Pearson Education , 10th Edition, 2012, ISBN: 0131395319</li>\r\n<li>Data Structures &amp; Problem Solving Using Java, Mark Allen Weiss, Addison Wesley, 4. Auflage, 2010, ISBN: 0-321-54140-5</li> \r\n<li> Cormen, Leiserson, Rivest: Introduction to Algorithms, 3. Auflage 2009, </li> \r\n<li>Bundle of algorithms in java, third edition, parts 1-5. Sedgewick Robert und Michael Schidlowsky. Addison-Wesley Longman, Amsterdam. 2003.</li>\r\n</ul>', '				\r\n				\r\n				<h3>Voraussetzungen</h3><p>Kenntnisse aus ALP I sind nützlich, der Schein dazu ist aber nicht zwingend\r\nerforderlich.</p>\r\n			\r\n			\r\n			\r\n			', 4, 0, '19100101', 3, 1),
(5, 'ALP IV: Nichtsequentielle Programmierung', '<h3>Inhalt</h3>\r\n<p>Programmierung und Synchronisation nebenl&auml;ufiger Prozesse, die auf gemeinsame Daten zugreifen oder &uuml;ber Nachrichten miteinander kommunizieren (Referenzsprache: Java):</p>\r\n<ul>\r\n<li>Nichtsequentielle Programme und Prozesse in ihren verschiedenen Auspr&auml;gungen (Prozess, Thread, ?), Nichtdeterminismus</li>\r\n<li>Programmierung und Prozesse</li>\r\n<li>Synchronisationsmechanismen wie Sperren, Monitore, Wachen, Ereignisse, Semaphore</li>\r\n<li>Nebenl&auml;ufigkeit und Objektorientierung</li>\r\n<li>Ablaufsteuerung, Auswahlstrategien, Umgang mit Verklemmungen</li>\r\n<li>Implementierung, Mehrprozessorsysteme, Koroutinen</li>\r\n<li>Interaktion &uuml;ber Nachrichten</li>\r\n</ul>', NULL, '<ul>\r\n<li>G.R. Andrews.: Foundations of multithreaded, parallel and distributed programming. Addison-Wesley, 2000.</li>\r\n<li>G. Taubenfeld: Synchronisation Algorithms and Concurrent Programming. Prentice Hall, 2006.</li>\r\n<li>M. Ben-Ari: Principles of Concurrent and Distributed Programming (Second Edition). Addison-Wesley, 2006.</li>\r\n<li>B. Goetz, T. Peierls, J. Bloch, et.al.: Java Concurrency in Practice, Addison-Wesley, 2006.</li>\r\n<li>Lea, D.: Concurrent Programming in Java (2. ed.). Addison-Wesley, 1999 Homepage http://lms.fu-berlin.de/</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<ul>\r\n<li>Studierende im Bachelorstudiengang Informatik</li>\r\n<li>Studierende im Hauptstudium des Diplomstudiengangs Informatik</li>\r\n<li>Studierende im Lehramtsmaster (Gro&szlig;er Master, Zweitfach Informatik) k&ouml;nnen dieses Modul als Ersatz f&uuml;r "Gemeinsames Modul</li>\r\n<li>Netzprogrammierung" zusammen mit dem Begleitpraktikum "Praktikum zu NSP (19513c) absolvieren.</li>\r\n</ul>\r\n<h3>Voraussetzungen</h3>\r\n<p>Kenntnisse aus ALP II, ALP III und MafI I</p>', 2, 0, '19100301', 4, 1),
(7, 'TI II: Rechnerarchitektur', '<h3>Inhalt</h3>\r\n<p>Das Modul Rechnerarchitektur behandelt grundlegende Konzepte und Architekturen von Rechnersystemen. Themenbereiche sind hier insbesondere Von-Neumann-Rechner, Harvard-Architektur, Mikroarchitektur RISC/CISC, Mikroprogrammierung, Pipelining, Cache, Speicherhierarchie, Bussysteme, Assemblerprogrammierung, Multiprozessorsysteme, VLIW, Sprungvorhersage. Ebenso werden interne Zahlendarstellungen, Rechnerarithmetik und die Repr&auml;sentation weiterer Datentypen im Rechner behandelt.</p>', NULL, '<ul>\r\n<li>Andrew S. Tannenbaum: Computerarchitektur, 5.Auflage, Pearson Studium, 2006</li>\r\n<li>English: Andrew S. Tanenbaum (with contributions from James R. Goodman):</li>\r\n<li>Structured Computer Organization, 4th Ed., Prentice Hall International, 2005.</li>\r\n</ul>', NULL, 2, 0, '19100601', 6, 1),
(9, 'TI IV: Praktikum Technische Informatik', '<h3>Inhalt</h3> \r\n<p>Das Modul Praktikum Technische Informatik vertieft mit zahlreichen praktischen Übungen das in den Modulen Rechnerarchitektur und Betriebs- und Kommunikationssysteme Erlernte. Aufbauend auf einer einfachen Hardwareplattform mit Prozessor und diversen Schnittstellen sollen die Teilnehmer elementare Treiber programmieren, Betriebssystemroutinen erweitern und die Schnittstellen ansteuern lernen. Anschließend sollen die Systeme vernetzt werden und mit ihrer Umwelt in Interaktion treten können. </p>', NULL, NULL, NULL, 3, 1, '19100830', 7, 13),
(10, 'Grundlagen der theoretischen Informatik', '<h3>Inhalt:</h3>\r\n\r\n<ul>\r\n  <li>Theoretische Rechnermodelle </li>\r\n    <ul>\r\n      <li>Automaten</li>\r\n      <li>formale Sprachen</li>\r\n      <li>Grammatiken und die Chomsky-Hierarchie</li>\r\n      <li>Turing-Maschinen</li>\r\n      <li>Berechenbarkeit</li>\r\n  </ul>\r\n  <li>Einführung in die Komplexität von Problemen</li>\r\n</ul>', '1', '<ul>\r\n<li>Uwe Schöning, Theoretische Informatik kurzgefasst, 5. Aufl, Spektrum Akademischer Verlag, 2008</li>  \r\n<li>John E. Hopcroft, Rajeev Motwani, Jeffrey D. Ullman, Einführung in die Automatentheorie, Formale Sprachen und Komplexität, Pearson Studium, 2.Auflage, 2002</li>\r\n<li>Ingo Wegener: Theoretische Informatik - \r\n  Eine algorithmenorientierte Einführung, 2. Auflage, Teubner, 1999</li> \r\n<li>Michael Sipser, Introduction to the Theory of Computation, 2nd ed., \r\nThomson Course Technology, 2006</li>\r\n<li>Wegener, Kompendium theoretische Informatik - Eine Ideensammlung, Teubner 1996</li> \r\n</ul>', '<h3>Website</h3>\r\n<a href="http://www.inf.fu-berlin.de/lehre/SS14/GTI/"> http://www.inf.fu-berlin.de/lehre/SS14/GTI</a>', 3, 0, '19101201', 8, 1),
(12, 'Datenbanksysteme', '<h3>Inhalt</h3>\r\n<p>Datenbankentwurf mit ER / UML. Theoretische Grundlagen Relationaler Datenbanksysteme: relationale Algebra, Funktionale Abhängigkeiten, Normalformen. Relationale Datenbankentwicklung: SQL Datendefinition, Fremdschlüssel und andere Integritätsbedingungen. SQL als applikative Sprache: wesentliche Sprachelemente, Einbettung in Programmiersprachen, Anwendungsprogrammierung; objekt-relationale Abbildung. Sicherheits- und Schutzkonzepte.</p>\r\n<p>Technik: Transaktionsbegriff, transaktionale Garantien, Synchronisation des Mehrbenutzerbetriebs, Fehlertoleranzeigenschaften. Anwendungen und neue Entwicklungen: Data Warehouse-Technik, Data-Mining, Information Retrieval / Suchmaschinen. Im begleitenden Projekt werden die Themen praktisch vertieft.</p>', NULL, '<ul>\r\n<li>Alfons Kemper, Andre Eickler: Datenbanksysteme - Eine Einführung, 5. Auflage, Oldenbourg 2004</li>\r\n<li>R. Elmasri, S. Navathe: Grundlagen von Datenbanksystemen, Pearson Studium, 2005</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<ul>\r\n<li>Pflichtmodul im Bachelorstudiengang Informatik</li>\r\n<li>Pflichtmodul im lehramtsbezogenen Bachelorstudiengang mit Kernfach Informatik und Ziel: Großer Master</li>\r\n<li>Studierende im lehramtsbezogenen Masterstudiengang (Großer Master mit Zeitfach Informatik) können dieses Modul zusammen mit dem "Praktikum DBS (19515c)" absolvieren und ersetzen damit die Module "Netzprogrammierung" und "Embedded Internet"</li>\r\n<li>Wahlpflichtmodul im Nebenfach Informatik</li>\r\n</ul>\r\n\r\n<h3>Voraussetzungen</h3>\r\n<p>"Datenstrukturen und Datenabstraktion"  oder  "Informatik B"</p>', 3, 0, '19101501', 9, 1),
(14, 'MafI II: Analysis', '<h3>Inhalt:</h3>\r\n<ul>\r\n  <li>Aufbau der Zahlenbereiche von den natürlichen bis zu den reellen Zahlen,        Vollständigkeitseigenschaft der reellen Zahlen</li>   \r\n   <li>Polynome, Nullstellen und Polynominterpolation</li>  \r\n   <li>Exponential- und Logarithmusfunktion, trigonometrische Funktionen</li>   \r\n   <li>Komplexe Zahlen, komplexe Exponentialfunktion und komplexe Wurzeln</li>  \r\n   <li>Konvergenz von Folgen und Reihen, Konvergenz und Stetigkeit von Funktionen,         O-Notation</li>\r\n   <li>Differentialrechnung: Ableitung einer Funktion, ihre Interpretation und          Anwendungen</li>\r\n   <li>Intergralrechnung: Bestimmtes und unbestimmtes Integral, Hauptsatz der         Differential- und Intergralrechnung, Anwendungen</li>\r\n   <li>Potenzreihen</li>   \r\n</ul>', NULL, '<ul>\r\n<li>Kurt Meyberg, Peter Vachenauer: Höhere Mathematik 1, \r\n  Springer-Verlag, 6. Auflage 2001 \r\n<li>Dirk Hachenberger: Mathematik für Informatiker, Pearson 2005\r\n<li>Gerhard Berendt: Mathematische Grundlagen der Informatik, Band 2, \r\nB.I.-Wissenschaftsverlag; 1990 \r\n<li>Thomas Westermann: Mathematik für Ingenieure mit Maple 1, Springer-Verlag, 4. Auflage 2005\r\n</ul>', NULL, 4, 0, '19101001', 10, 1),
(16, 'Rechnersicherheit', '<h3>Content</h3>\r\n<p>This course motivates the need for computer security and introduces central concepts of computer security such as security objectives, threats, threat analysis, security policy and mechanism, assumptions and trust, and assurance.</p>\r\n<p>We discuss authentication mechanisms, followed by various security models and show which security related questions can be answered in these models. The models we discussed include the Access Control Matrix Model, the Take-Grant Protection Model, the Bell-LaPadula and related models, the Chinese Wall Model, the Lattice Model of Information Flow.</p>\r\n<p>Subsequently, we cover principles of security architectures and go through design approaches for secure systems e.g., capability based systems and hardware rotection mechanism concepts such as protection rings.  Based on the learned, we may look at selected case studies of existing systems.</p>\r\n<p>In the remainder of the course, we cover exploitation techniques for specific implementation vulnerabilities such as race conditions, stack and heap overflows, integer overflows, and return oriented programming.  We continue with a discussion of insider threats, insider recruitment and social engineering attacks.</p>\r\n<p>If time permits, we continue to look at the problems that arise when humans interface with security e.g., password habits and password entry mechanisms, human responses to security prompts, incentives and distractors for better security, or reverse Turing tests.</p>', NULL, NULL, NULL, 4, 0, '19104601', 11, 1),
(18, 'Computergrafik', '<h3>Inhalt</h3>\r\n<ul>\r\n<li>Mathematische Grundlagen der Computergrafik,</li>\r\n<li>Darstellung von 3d Szenen im Rechner,</li>\r\n<li>geometrische Transformationen, Projektionen auf die Bildebene,</li>\r\n<li>Bestimmung sichtbarer Flaechen, Beleuchtungsmodelle,</li>\r\n<li>Ray-Tracing,</li>\r\n<li>Radiosity,</li>\r\n<li>Animation</li>\r\n</ul>', NULL, '<ul>\r\n<li>Computer Graphics (2nd Edition C Version). D. Hearn, M.P. Baker, Prentice-Hall, 1997.  </li> \r\n<li>Computer Graphics - Principles and Practice (2nd Edition in C). \r\nJ.D. Foley, A. Van-Dam, S.K. Feiner and J.F. Hughes. Addison-Wesley, 1996   </li>\r\n<li>Interactive Computer Graphics (4th Edition).E. Angel, Addison-Wesley, 2006  </li>\r\n\r\n<li>OpenGL Programming Guide: The Official Guide to Learning OpenGL, Version 2.1.D. Shreiner, M. Woo, J. Neider, T. Davis, Addison-Wesley, 2007    </li>\r\n</ul>', 'B.Sc.-Studierende ab 5. Semester, M.Sc.-Studierende in Informatik, Mathematik, Physik o.ä., ', 4, 0, '19103201', 12, 1),
(20, 'Empirische Bewertung in der Informatik', '<h3>Inhalt</h3>\r\n<p>\r\nDas Modul behandelt zunächst die Rolle empirischer Untersuchungen für den Informationsgewinn in der Forschung und Praxis der Informatik und stellt dann generisch das Vorgehen bei empirischen Untersuchungen vor (mit den folgenden Phasen: Definition der Fragestellung, Auswahl der Methode(n), Entwurf der Studie, Durchführung, Auswertung, Bericht/Präsentation). \r\n</p>\r\n<p>Aufbauend auf diesem Grundverständnis und anhand der zentralen Qualitätsbegriffe von Glaubwürdigkeit (insbesondere innere Gültigkeit) und Relevanz (insbesondere äußere Gültigkeit) werden dann verschiedene Methodenklassen (z.B. kontrollierte Experimente, Quasiexperimente, Umfragen etc.) behandelt und jeweils anhand realer Fallbeispiele veranschaulicht: Eignung und Gegenanzeigen; Stärken und Schwächen; Vorgehen; Fallstricke. </p>\r\n\r\n<p>In der Übung wird die Benutzung von Software für die Datenauswertung erlernt und eine kleine empirische Studie projekthaft komplett von der Konzeption bis zur Präsentation durchgeführt.</p>', NULL, '<ul>\r\n<li>Jacob Cohen: The Earth Is Round (p &gt; .05). American Psychologist 49(12): 997003, 1994. Darrell Huff: How to lie with statistics, Penguin 1991.</li>\r\n<li>John C. Knight, Nancy G. Leveson: An Experimental Evaluation of the Assumption of Independence in Multi-Version Programming. IEEE Transactions on Software Engineering 12(1):9609, January 1986.</li>\r\n<li>John C. Knight, Nancy G. Leveson: A Reply to the Criticisms of the Knight and Leveson Experiment. Software Engineering Notes 15(1):24-35, January 1990. \r\n<li>Audris Mockus, Roy T. Fielding, James D. Herbsleb: Two Case Studies of Open Source Software Development: Apache and Mozilla. ACM Transactions of Software Engineering and Methodology 11(3):309-346, July 2002.</li>\r\n<li>Timothy Lethbridge: What Knowledge Is Important to a Software Professional? IEEE Computer 33(5):44-50, May 2000.</li>\r\n<li>David A. Scanlan: Structured Flowcharts Outperform Pseudocode: An Experimental Comparison. IEEE Software 6(5):28-36, September 1989.  </li>\r\n<li>Ben Shneiderman, Richard Mayer, Don McKay, Peter Heller: Experimental investigations of the utility of detailed flowcharts in programming. Commun. ACM 20(6):373-381, 1977.</li>\r\n<li>Lutz Prechelt, Barbara Unger-Lamprecht, Michael Philippsen, Walter F. Tichy: Two Controlled Experiments Assessing the Usefulness of Design Pattern Documentation in Program Maintenance. IEEE Transactions on Software Engineering 28(6):595-606, 2002.</li>\r\n<li>Lutz Prechelt. An Empirical Comparison of Seven Programming Languages: Computer 33(10):23-29, October 2000.</li>\r\n<li>Lutz Prechelt: An empirical comparison of C, C++, Java, Perl, Python, Rexx, and Tcl for a search/string-processing program. Technical Report 2000-5, March 2000.  </li>\r\n<li>Tom DeMarco, Tim Lister: Programmer performance and the effects of the workplace. Proceedings of the 8th international conference on Software engineering. IEEE Computer Society Press, 268-272, 1985.</li>\r\n<li>John L. Henning: SPEC CPU2000: Measuring CPU Performance in the New Millennium. Computer 33(7):28-35, July 2000.</li>\r\n<li>Susan Elliot Sim, Steve Easterbrook, Richard C. Holt: Using Benchmarking to Advance Research: A Challenge to Software Engineering. Proceedings of the 25th International Conference on Software Engineering (ICSE''03). 2003.</li>\r\n<li>Ellen M. Voorhees, Donna Harman: Overview of the Eighth Text REtrieval Conference (TREC-8).</li>\r\n<li>Susan Elliott Sim, Richard C. Holt: The Ramp-Up Problem in Software Projects: A case Study of How Software Immigrants Naturalize. Proceedings of the 20th international conference on Software engineering, April 19-25, 1998, Kyoto, Japan: 361-370.</li>\r\n<li>Oliver Laitenberger, Thomas Beil, Thilo Schwinn: An Industrial Case Study to Examine a Non-Traditional Inspection Implementation for Requirements Specifications. Empirical Software Engineering 7(4): 345-374, 2002.</li>\r\n<li>Yatin Chawathe, Sylvia Ratnasamy, Lee Breslau, Nick Lanham, Scott Shenker: Making Gnutella-like P2P Systems Scalable. Proceedings of ACM SIGCOMM 2003. April 2003.</li>\r\n<li>Stephen G. Eick, Todd L. Graves, Alan F. Karr, J.S. Marron, Audris Mockus: Does Code Decay? Assessing the Evidence from Change Management Data. IEEE Transactions of Software Engineering 27(1):12, 2001.</li>\r\n<li>Chris Sauer, D. Ross Jeffrey, Lesley Land, Philip Yetton: The Effectiveness of Software Development Technical Reviews: A Behaviorally Motivated Program of Research. IEEE Transactions on Software Engineering 26(1):14, January 2000.</li></ul>', '<h3>Homepage</h3>\r\n<a href="http://www.inf.fu-berlin.de/w/SE/VorlesungEmpirie2014">\r\nhttp://www.inf.fu-berlin.de/w/SE/VorlesungEmpirie2014</a>', 2, 0, '19103401', 13, 1),
(22, 'XML-Technologien', '<h3>Inhalt</h3>\r\n<p>\r\nDie Extensible Markup Language (XML) ist die neue Sprache des Webs. Sie wird zwar HTML nicht ersetzen, jedoch in einem wichtigen Bereich ergänzen: Während HTML für die Präsentation von elektronischen Dokumenten entwickelt wurde (Mensch-Maschine-Kommunikation), ist XML insbesondere für den Austausch von Daten zwischen Computern geeignet. XML erlaubt dabei die Definition von speziellen Datenaustauschformaten (Standards) sowie die einfache Kombination und Erweiterung solcher Standards.</p>\r\n<p>\r\nZusammen mit einer breiten Unterstützung der Software-Industrie ermöglicht dies eine schnelle Verbreitung von XML im Web. Anwendungen von XML findet man heute u.a. in XHTML, Web Services und im E-Business. Der Vorlesungsstoff wird durch Projektarbeit vertieft.</p>', NULL, '<p>W3C Standards</p>', '<h3>Voraussetzungen</h3>\r\n<p>Kenntnisse der Internet-Grundlagen, passive Englischkenntnisse</p>', 2, 0, '19105401', 14, 1),
(24, 'Bildverarbeitung', '<h3>Inhalt </h3>\r\n<p>In der Vorlesung werden grundlegende Bildverarbeitungstechniken behandelt. Sie umfassen Farbkorrekturen von Bildern, Fouriertransformation, Glätten, Schärfen, Kantendetektion, Aufbau von Bildpyramiden, ScaleSpace-Theory sowie grundlegende Verfahren zur Mustererkennung, wie z.B. die Hough-Transformation.</p>', NULL, '<p>wird noch bekanntgegeben</p>', '<p>Übungen siehe <a href="http://www.fu-berlin.de/vv/de/lv/146197?query=Ulbrich&sm=119983">19553a</a>\r\n</p>', 2, 0, '19103001', 15, 1),
(26, 'Künstliche Intelligenz', '<h3>Inhalt</h3>\r\n\r\n<p>Suchverfahren für die Lösung kombinatorischer Aufgaben, Prädikatenlogik und ihre Mechanisierung, Resolution und Theorembeweise, Wissensbasierte- und Expertensysteme, Diffuse Logik, Mensch-Maschinen-Schnittstellen, Mustererkennung insbesondere für Handschrift und für gesprochene Sprache.</p>', NULL, '<p>wird noch bekannt gegeben.</p>', 'Achtung: Blockveranstaltung vor Beginn des SS14<br>\r\nÜbungen siehe <a href="http://www.fu-berlin.de/vv/de/lv/143923?query=Ulbrich&sm=119983">19548a</a>\r\n</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p> Grundkenntnisse in Mathematik und Algorithmen und Datenstrukturen', 2, 0, '19103701', 16, 1),
(28, 'Proseminar - Intelligente Systeme und Robotik', '<h3>Inhalt</h3>\r\n<p>Fortgeschrittene Themen mit wechselnden Schwerpunkten zum Hard- und Softwareaufbau komplexer, intelligenter Systeme.</p>', NULL, '<p>wird noch bekannt gegeben</p>', NULL, 2, 1, '19102510', 143, 3),
(29, 'Mobilkommunikation', '<h3>Inhalt:</h3>\r\n<p>Das Modul Mobilkommunikation stellt exemplarisch alle Aspekte mobiler und drahtloser Kommunikation dar, welche derzeit den stärksten Wachstumsmarkt überhaupt darstellt und in immer mehr Bereiche der Gesellschaft vordringt.</p>\r\n<p>Während der gesamten Vorlesung wird ein starker Wert auf die Systemsicht gelegt und es werden zahlreiche Querverweise auf reale Systeme, internationale Standardisierungen und aktuellste Forschungsergebnisse gegeben.</p>\r\n<p>Die zu behandelnden Themen sind:</p>\r\n<ul>\r\n<il>Technische Grundlagen der drahtlosen Übertragung: Frequenzen, Signale, Antennen, Signalausbreitung, Multiplex, Modulation, Spreizspektrum, zellenbasierte Systeme;</il>\r\n<il>Medienzugriff: SDMA, FDMA, TDMA, CDMA;</il>\r\n<il>Drahtlose Telekommunikationssysteme: GSM, TETRA, UMTS, IMT-2000, LTE;</il>\r\n<il>Drahtlose lokale Netze: Infrastruktur/ad-hoc, IEEE 802.11/15, Bluetooth;</il>\r\n<il>Mobile Netzwerkschicht: Mobile IP, DHCP, ad-hoc Netze;</il>\r\n<il>Mobile Transportschicht: traditionelles TCP, angepasste TCP-Varianten, weitere Mechanismen;</il>\r\n<il>Mobilitätsunterstützung;</il>\r\n<il>Ausblick: 4. Generation Mobilnetze</il>\r\n</ul>', NULL, '<p>Jochen Schiller, Mobilkommunikation, Addison-Wesley, 2.Auflage 2003</p>\r\n\r\n<p>Alle Unterlagen verfügbar unter \r\n<a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/resources/Mobile_Communications/course_Material/index.html">\r\nhttp://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/resources/Mobile_Communications/course_Material/index.html\r\n</a>\r\n</p>', NULL, 2, 0, '19103901', 18, 1),
(30, 'Proseminar - Algorithmen und Datenstrukturen', '<h3>Inhalt:</h3>\r\n<p>Das Proseminar baut auf den ALP-Vorlesungen auf.<p>', NULL, NULL, '<h3>Zielgruppe:</h3>\r\n<p>Bachelorstudenten der Informatik, Bioinformatik und Mathematik</p>', 2, 1, '19101810', 143, 3),
(31, 'Proseminar - Programmiersprachen', 'h3>Inhalt</h3>\r\n<p> Jeder Vortrag wird von zwei Studierenden gehalten und behandelt jeweils eine selbst gewählte Programmiersprache mit ihren spezifischen Besonderheiten. <br>\r\nVoranmeldungen mit Angabe der gewünschten Programmiersprache  sind über das KVV oder per e-Mail an fehr@inf.fu-berlin.de möglich.</p>', NULL, '<p>Literatur wird selbst recherchiert </p>', '<h3>Zielgruppe</h3> \r\n<ul><li> Studierende im Bachelorstudiengang (ab 3. Fachsemester)</li>\r\n<li> Studierende im lehramtsbezogenen Bachelorstudiengang</li>\r\n<li>Studierende mit Nebenfach Informatik</li>\r\n</ul>  \r\n<h3> Voraussetzungen</h3>\r\n <p> Funktionale und objektorientierte Programmierung </p>', 2, 1, '19102010', 143, 3),
(32, 'Proseminar - Corporate Semantic Web', '<h3>Inhalt</h3> \r\n<p> In der Veranstaltung werden verschiedene Themen des Semantic Webs und der deklarativen Wissensrepräsentation im betrieblichen Anwendungskontext behandelt.\r\n</p>', NULL, NULL, NULL, 2, 1, '19101910', 143, 3),
(33, 'Softwareprojekt Datenverwaltung', '<h3>Inhalt</h3>\r\n<p>Das Thema des Projekts steht noch nicht fest. Entweder wird in Fortsetzung des Projekts im Wintersemester (aber unabhängig davon) eine Aufgabe mit einem echten Kunden durchgeführt, oder wir bauen ein so genanntes NoSQL-System. Im ersten Fall findet die Veranstaltung als Block statt, sonst wöchentlich. Die Entscheidung fällt voraussichtlich erst im März.</p>\r\n<p>Subject of the project: either development of software together with a company (in this case: 4-weeks fulltime August/ September) or we build a so called NoSQL system. Decision in march.</p>', NULL, '<p>Wird bekannt gegeben</p>', '<h3>Zielgruppe</h3>\r\n<p>Studierende im Master- bzw. Bachelorstudiengang</p>\r\n<h3>Voraussetzungen</h3>\r\n<p>Gute Programmierkenntnisse, Einführung in Datenbanksysteme.</p>', 4, 1, '19108422', 140, 12),
(34, 'Softwareprojekt Übersetzerbau', '<h3>Inhalt</h3>  \r\n<p>Im Softwareprojekt wird von Bachelor-Studierenden im Team unter Anleitung von Master-Studierenden und des Dozenten ein Übersetzer arbeitsteilig entwickelt. Dabei sollen alle Phasen eines Softwareprojekts durchlaufen sowie typische Methoden und Hilfsmittel der Softwaretechnik eingeübt werden.</p> \r\n<p>Dabei geht es u.a. um \r\n<ul><li> Definieren, Abstimmen und Dokumentieren von Schnittstellen </li>\r\n<li> Anleitung eines Teams bei der arbeitsteiligen Erstellung von Softwarekomponeneten (dabei Verwendung noch nicht implementierter Schnittstellen) </li>\r\n<li> Eine noch fremde Technologie oder größere Softwarekomponente selbständig beurteilen und erlernen (Wiederverwendung) </li>\r\n<li> Durchsichten von Anforderungen, Schnittstellen, Implementierungen, Testfällen - Modultest, Integrationstest, Systemtest; einschließlich Automatisierung und Rückfalltesten </li>\r\n<li> Versions- und Konfigurationsverwaltung, Build-Prozesse und Werkzeuge</li>\r\n</ul>', NULL, '<p>wechselnd</p>\r\n\r\n<h3>Homepage</h3>\r\n<p>\r\n<a href="http://www.mi.fu-berlin.de/w/SWP2014/">\r\nhttp://www.mi.fu-berlin.de/w/SWP2014/\r\n</a>\r\n</p>', '<h3> Voraussetzungen: </h3> \r\n<p>Softwaretechnik, Übersetzerbau </p>', 4, 1, '19109322', 140, 12),
(35, 'Softwareprojekt Telematik', 'h3>Programming the Internet of Things with RIOT</h3>\r\n<p>\r\nIn this course, students will get an introduction to distributed embedded systems programming, focusing on the RIOT operating system (http://www.riot-os.org), running on their choice of hardware platform -- see for instance https://github.com/RIOT-OS/RIOT/wiki/RIOT-Platforms. For students that do not possess appropriate hardware, they will be offered the possibility to work directly on their Linux machine via the native port of RIOT, and the possibility to use hardware on one of the open testbeds supported by RIOT, such as the DES testbed (http://www.des-testbed.net). Participants will learn how to use embedded software development environments and how to take advantage of the hardware''s capabilities including wireless data communication, while always keeping an eye on energy consumption, memory and CPU usage.\r\n</p>\r\n<p>\r\nAfter an introductory crash-course on RIOT, students will be provided with a selection of software projects in this context. Typically groups of 2 or 3 students tackle one such project. Proposed projects will fall into three main categories.\r\n</p>\r\n<h4>System Projects:</h4>\r\n<p>\r\nThis type of project tackles low level system development. Proposed projects in this category may include for example: </p>\r\n<ul>\r\n<li> porting of RIOT to a new hardware platform (e.g. ARM Cortex A9)</li>\r\n<li> evaluation of concepts for 8bit MCU support for RIOT)</li>\r\n<li>dynamic linking support for RIOT)</li>\r\n<li> evaluation of concepts for automatic software update for RIOT)</li>\r\n<li> design and implementation of a driver model )</li>\r\n<li>advanced simulation environment (ns-3) support for RIOT)</li>\r\n<li>energy profiling in IoT scenarios)</li>\r\n<li> ... final list to be be determined. Students may also propose their own subject, subject to validation.)</li>\r\n</ul>\r\n\r\n<h4>Network Stack Projects:</h4>\r\n<p>This type of project tackles network protocols development. Proposed projects in this category may include for example:</p>\r\n<ul>\r\n<li>implementation and evaluation of P2P-RPL (RFC6997)</li>\r\n<li> implementation and evaluation of a scalable link bidirectionality check for RPL, using an approach based on Bloom filters</li>\r\n<li> implementation and evaluation of a network coding approach for data dissemination in sensor networks</li>\r\n<li> comparison of routing protocols for IoT scenarios (RPL, AODVv2, OLSRv2, MMR)</li>\r\n<li> development and evaluation of scheduling strategies for 6LoWPAN operation over Time-slotted Channel Hopping (6TiSCH) and 802.15.4e</li>\r\n<li> ... final list to be be determined. Students may also propose their own subject, subject to validation.</li>\r\n</ul>\r\n<h4>Application/Use Cases Projects:</h4>\r\n<p>This type of project tackles application development on top of the APIs provided by RIOT. Proposed projects in this category may include for example:</p>\r\n<ul>\r\n<li> eLua support for RIOT</li\r\n<li> Go support for RIOT</li\r\n<li>your dream IoT application</li\r\n<li> ... final list to be be determined. Students may also propose their own subject, subject to validation.</li\r\n</ul>', NULL, '<ul>\r\n\r\n<li>A. S. Tanenbaum, Modern Operating Systems, 3rd ed. Upper Saddle River, NJ, USA: Prentice Hall Press, 2007.</li>\r\n\r\n<li>Shelby, Zach, and Carsten Bormann. 6LoWPAN: The wireless embedded Internet. Vol. 43. Wiley. com, 2011.</li>\r\n\r\n<li>A. Dunkels, B. Gronvall, and T. Voigt, "Contiki - a lightweight and flexible operating system for tiny networked sensors." in LCN. IEEE Computer Society, 2004, pp. 455-462.</li> \r\n\r\n<li>P. Levis, S. Madden, J. Polastre, R. Szewczyk, K. Whitehouse, A. Woo, D. Gay, J. Hill, M. Welsh, E. Brewer, and D. Culler, "TinyOS: An Operating System for Sensor Networks," in Ambient Intelligence, W. Weber, J. M. Rabaey, and E. Aarts, Eds. Berlin/Heidelberg: Springer-Verlag, 2005, ch. 7, pp. 115-148.</li>\r\n\r\n<li>Oliver Hahm, Emmanuel Baccelli, Mesut Günes, Matthias Wählisch, Thomas C. Schmidt, "RIOT OS: Towards an OS for the Internet of Things," in Proceedings of the 32nd IEEE International Conference on Computer Communications (INFOCOM), Poster Session, April 2013.</li>\r\n\r\n<li>M.R. Palattella, N. Accettura, X. Vilajosana, T. Watteyne, L.A. Grieco, G. Boggia and M. Dohler, "Standardized Protocol Stack For The Internet Of\r\n(Important) Things", IEEE Communications Surveys and Tutorials, December 2012.</li>\r\n\r\n<li>J. Wiegelmann, Softwareentwicklung in C für Mikroprozessoren und Mikrocontroller, Hüthig, 2009</li>\r\n\r\n</ul>', '<p>In this course you will be expected to write code. The outcome of your software project should be a concrete contribution to the RIOT code base, and take the shape of one or more pull request(s) to the RIOT github (https://github.com/RIOT-OS/RIOT). Before you start coding, refer to the starting guide </p>\r\n\r\n<a href="https://github.com/RIOT-OS/RIOT/wiki#wiki-start-the-riot"> \r\nhttps://github.com/RIOT-OS/RIOT/wiki#wiki-start-the-riot </a>', 4, 1, '19109222', 140, 12),
(36, 'Softwareprojekt Anwendungen von Algorithmen', '<h3>Inhalt</h3>\r\n<p>\r\n Ein typisches Anwendungsgebiet meist geometrischer Algorithmen wird ausgewählt und softwaretechnisch behandelt, zum Beispiel Computer-Graphik (Darstellung von Objekten im Rechner, Projektionen, Entfernung verdeckter Kanten und Flächen, Ausleuchtung, Ray-Tracing) , Computer-Sehen (Bildverarbeitung, Filter, Projektionen, Kamera-Kalibrierung, Stereo-Sehen) oder Mustererkennung (Klassifikation, Suchverfahren).\r\n</p>', NULL, '<p>je nach Anwendungsgebiet</p>', '<h3>Zielgruppe</h3>\r\n\r\nGrundkenntnisse in Entwurf und Analyse von Algorithmen', 4, 1, '19108322', 140, 12),
(37, 'Seminar Aktuelle Probleme des Datenschutzes', '<h3>Inhalte:</h3>\r\n<p>Anhand aktueller politischer Themen werden die Grundprobleme des Datenschutzes behandelt. Als Grundlage dienen die datenschutzrechtlich relevanten Punkte des "Koalitionsvertrags 2013" zwischen CDU/CSU und SPD (z.B. EU-Datenschutzgrundverordnung, Vorratsdatenspeicherung, digitaler Datenschutz, privacy by design und privacy by default, NSA-Affaire, Besch&auml;ftigtendatenschutz, Elektronische Kommunikations- und Informationstechnologien im Gesundheitswesen, moderne Technik zur Erh&ouml;hung der Verkehrssicherheit). Prof. Garstka ist der fr&uuml;here Berliner Datenschutzbeauftragte. </p>', NULL, NULL, '<h3>Zielgruppe</h3>\r\n<p>Studierende, die die Vorlesung Datenschutz gehört haben.</p>', 2, 1, '19107211', 26, 4),
(38, 'Seminar über Algorithmen', '<p>Das Seminar behandelt das Thema <em>Datenkompression</em>. Die Vorlesung vom\r\nWintersemester zu diesem Thema ist nicht Voraussetzung.</p>\r\n<p><a\r\nhref="http://w3.inf.fu-berlin.de/lehre/SS14/Seminar-Algorithmen-Datenkompression/">Weitere\r\nInformationen</a></p>', NULL, NULL, '<h3>Zielgruppe:</h3>\r\n<p>Master-Studenten der Informatik oder Mathematik</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p>Vorlesung "Höhere Algorithmik" oder vergleichbare Veranstaltung</p>\r\n<p>Es gibt eine <strong>erste Vorbesprechung</strong> am <font color="red"><em>Dienstag,\r\nden 18. März 2014</em></font> um 14 Uhr im Raum T9, SR 053.\r\nBei diesem Termin k&ouml;nnen schon die ersten Themen vergeben werden.</p>', 2, 1, '19106711', 27, 4),
(39, 'Seminar: Zuverlässige Systeme', '<h3>Inhalt:</h3>\r\n\r\n<p>The seminar Dependable Systems will cover theoretical as well as applied topics. And combinations of both. We will study the performance and dependability of systems such as data centres, sensor networks, memories and web services using stochastic models and queueing networks.</p>\r\n<p>Presentations can focus on the application or on the modelling methods and tools.</p>\r\n\r\n<p>The seminar will take place in 2 blocks. \r\nPresentations can be in German or English.</p>', NULL, NULL, NULL, 2, 1, '19107111', 28, 4),
(40, 'Seminar IT-Sicherheit', '<p>In this seminar, students perform literature research on topics related to information security, possibly augmented by practical exploration. The list of topics is discussed and topics are assigned during the first seminar.\r\n</p>', NULL, '<p>All seminar participants must perform a thorough search for scientific literature on their chosen topics. At least the following sources must be searched for relevant literature:\r\n</p>\r\n <p>    ACM Digital Library  http://dl.acm.org/ \r\n     Google Scholar  http://scholar.google.com/ \r\n     Authors'' homepages found via web searches with relevant keywords\r\n</p>\r\n<p>\r\n It is imperative that students follow literature references backwards (to identify seminal and foundational papers on their subject i.e., the first ones to report results on the topic under consideration) and forward (using the cited-by features of digital libraries, or Web searches for the current paper''s title) to identify the most recent work on the topic under consideration.\r\n</p>\r\n<p>\r\n Note that newsticker articles or Wikipedia articles do not count as scientific literature.\r\n</p>', '<p>Students are expected to:</p>\r\n<p>\r\n     Give a technical presentation of their assigned topics; \r\n     Demonstrate research software prototypes whenever applicable; \r\n     Turn in a short technical report on their assigned topics (10 pages).\r\n</p>\r\n<p>\r\nStudents will be graded on their preparedness for discussion, their presentations and their seminar report. The report must be typeset in LaTeX. Both the LaTeX source and the PDF generated from it must be submitted as a TAR or ZIP archive. A LaTeX template is here.\r\n</p>\r\n<p>\r\n The seminar report must contain references to all the articles that were used. Each literature entry must include a brief and concise summary of the article''s contribution and the contribution''s benefits. Please use the BibTex "note" field for this purpose and inline the bibliography by including the bbl file into the LaTeX source.\r\n</p>', 2, 1, '19106411', 29, 4),
(41, 'Seminar Anonyme Kommunikation', '<h3>Inhalt</h3>\r\n<p>Wir studieren "historische" und aktuelle Systeme zur anonymen Kommunikation aus der Praxis und der wissenschaftlichen Literatur. Neben der grunds&auml;tzlichen Frage "Was ist anonyme Kommunikation?" werden wir ferner verschiedene Bedrohungsszenarien und Angriffe diskutieren. Aus den dabei gewonnenen Erkenntnissen wollen wir kritisch die Sicherheit dieser Systeme anhand der Angriffsmodelle reflektieren, die j&uuml;ngste Medienberichte aktuell als realistisch vermuten lassen.</p>', NULL, '<p>Wird in der Veranstaltung bekannt gegeben;verschiedene Quellen aus der wissenschaftlichen Literatur.</p>', '<h3>Zielgruppe</h3>\r\n<p>Studierende im Master oder Diplom Hauptstudium mit Schwerpunkt Sicherheit, Praktischer- oder Technischer Informatik</p>\r\n<h3>Voraussetzung</h3>\r\n<p>Telematik,Technische Informatik III; (Rechnersicherheit oder Kryptographie w&uuml;nschenswert)</p>', 2, 1, '19105711', 30, 4),
(42, 'Seminar Zensur und zensurresistente Kommunikation', '<h3>Inhalt:</h3>\r\n<p>\r\nIn diesem Seminar betrachten wir die Zensur von digitaler Kommunikation. In einer ersten Bestandsaufnahme er&ouml;rtern wir wie Zensur heute ausge&uuml;bt wird, und welche Erkennungs- und Umgehungsm&ouml;glichkeiten in der Praxis genutzt werden.</p>\r\n<p>\r\nAnschlie&szlig;end untersuchen wir dazu:</p>\r\n<ol>\r\n<li>technische M&ouml;glichkeiten zur Zensur und</li>\r\n<li>zensurresistente Netzwerke aus der wissenschaftlichen Literatur.</li>\r\n</ol>', '', '<p>Wird in der Veranstaltung bekannt gegeben; <br>\r\nverschiedene Quellen aus der wissenschaftlichen Literatur.\r\n</p>', '<h3>Zielgruppe:</h3>\r\n<p>\r\nStudierende im Master oder Diplom Hauptstudium mit Schwerpunkt: Sicherheit, Praktischer- oder Technischer Informatik</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p>Telematik, Technische Informatik III; (Rechnersicherheit oder Kryptographie w&uuml;nschenswert)</p>', 2, 1, '19107011', 31, 4),
(43, 'Seminar Beiträge zum Software Engineering', '<h3>Inhalt</h3>\r\n\r\n<p>Dies ist ein Forschungsseminar. Das bedeutet, die Vorträge sollen in der Regel zur Förderung laufender Forschungsarbeiten beitragen. Es gibt deshalb, grob gesagt, drei Arten möglicher Themen:</p>    \r\n\r\n<ul>\r\n<li>Publizierte oder laufende Forschungsarbeiten aus einem der Bereiche, in denen die Arbeitsgruppe Software Engineering arbeitet.  </li>\r\n<li>Besonders gute spezielle Forschungsarbeiten (oder anderes Wissen) aus anderen Bereichen des Software Engineering oder angrenzender Bereiche der Informatik.  </li>\r\n<li>Grundlagenthemen aus wichtigen Gebieten des Software Engineering oder angrenzender Fächer wie Psychologie, Soziologie, Pädagogik, Wirtschaftswissenschaften sowie deren Methoden. </li>\r\n</ul>\r\n\r\n<p>Eine scharfe Einschränkung der Themen gibt es jedoch nicht; fast alles ist möglich.</p>', NULL, NULL, '<h3>Zielgruppe</h3>\r\n\r\n<p>\r\nStudierende der Informatik (auch Nebenfach).</p>\r\n<p>\r\nBitte melden Sie sich bei Interesse mit einem Themenvorschlag oder einer Themenanfrage bei irgendeinem geeigneten Mitarbeiter der Arbeitsgruppe.</p>\r\n<p>\r\nDer Einstieg ist auch während des laufenden Semesters möglich, da die Veranstaltung fortlaufend angeboten wird.</p>   \r\n\r\n<h3>Voraussetzungen </h3>\r\n<p>\r\nTeilnehmen kann jede/r Student/in der Informatik, der/die die Vorlesung "Softwaretechnik" gehört hat.</p> \r\n<p>\r\nIm Rahmen der Teilnahme kann es nötig werden, sich mit Teilen der Materialien zur Veranstaltung "Empirische Bewertung in der Informatik" auseinanderzusetzen.</p>   \r\n\r\n<h3>Homepage </h3>\r\n<p><a href="https://www.inf.fu-berlin.de/w/SE/SeminarBeitraegeZumSE">\r\nhttps://www.inf.fu-berlin.de/w/SE/SeminarBeitraegeZumSE</a></p>', 2, 1, '19105811', 32, 4),
(44, 'Simulierte Unternehmensgründung in der IT-Industrie', '<h3>Inhalt</h3>\r\n<p>Ziel der Veranstaltung ist die eigenständige Planung, Durchführung und Evaluation eines IT-Gründungsprojektes. Die Teilnehmer/innen setzen eine Geschäftsidee um und entwickeln die entsprechende Software. In Teams wird relevantes Fach- und Gründungswissen erlernt und im Rahmen einer praxisnahen simulierten Unternehmensgründung selbständig angewandt.</p>\r\n<p>\r\nZentrale Themen sind:</p>\r\n<ul>\r\n<li>Entwicklung und Umsetzung eines Geschäftsmodells</li>\r\n<li>Softwareentwicklung</li>\r\n<li>Marktanalyse</li>\r\n<li>Marketingplan</li>\r\n<li>Finanzierungskonzeption</li>\r\n<li>Projektmanagement und Teamarbeit</li>\r\n<li>Präsentationstechniken</li>\r\n</ul>', NULL, '<ul>\r\n<li>W. Benzel und E. Wolz, Businessplan für Existenzgründer, Walhalla, 2. aktualisierte Auflage, 2006.</li>\r\n<li>Jo B. Nolte, Existenzgründung, Haufe Verlag 2006.</li>\r\n<li>R. Bleiber, Kaufmännisches Wissen für Selbständige, Haufe Verlag 2005.</li>\r\n<li>P. Mangold, IT-Projektmanagement kompakt, Spektrum Akademischer Verlag, 2004</li>\r\n<li>W. Simon (Hrsg.), Persönlichkeitsmodelle und Persönlichkeitstests, GABAL Verlag 2006.</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<p>Informatik-Studierende aller Studiengänge</p>', 4, 1, '19109799', 33, 22),
(45, 'Proseminar - Information Retrieval', 'Wer immer schon einmal wissen wollte, wie Google tickt - natürlich nur technisch - ist in diesem Proseminar richtig. Inhalte des Proseminars sind - Standardtechniken des Information Retrieval(IR) - Neuere Verfahren wie "Page Rank" Rangfolgebestimmung oder Hauptkomponentenanalyse - Zu IR verwandte Themen wie die Spam-Analyse von Emails (Text) u.a. - Textanalyse Die Vorträge sind im Allgemeinen mit einer praktischen Aufgabe verbunden. Als Basissystem wird dazu Lucene verwendet.', '', 'Literatur: Manning, C., Schütze, H.: Introduction to Information Retrieval, Cambridge University Press (und online) Weitere Literatur wird bekannt gegeben.', 'Vorträge und weitere Details ab Mitte September 2013 auf der Homepage. Hier http://www.inf.fu-berlin.de/lehre/WS13/DBS-ProSem/index.html finden Sie Details zur Lehrveranstaltung. Sie können sich ab sofort für einen Vortrag per Mail beim Dozenten bewerben.', 2, 1, '19102410', 143, 3),
(47, 'Modelchecking', '<h3>\n	<strong>Inhalte:</strong></h3>\n<div>\n	- Unterschied zwischen Programmieren und Modellieren&nbsp;</div>\n<div>\n	- Modellieren reaktiver Systeme in SPIN und Promela&nbsp;</div>\n<div>\n	- Spezifizieren von Anforderungen in temporalen Logiken&nbsp;</div>\n<div>\n	- Automatentheoretische Modelle von Systemen und Spezifikationen&nbsp;</div>\n<div>\n	- Entscheidungsverfahren f&uuml;r temporale Logiken&nbsp;</div>\n<div>\n	- Symbolisches Modelchecking und Bin&auml;re Entscheidungsdiagramme&nbsp;</div>\n<div>\n	- Modelchecking mit NuSMV&nbsp;</div>\n<div>\n	- Automatenmodelle mit Zeit&nbsp;</div>\n<div>\n	- Modellchecking von Zeitautomaten mit Uppaal&nbsp;</div>\n<div>\n	- Formale Methoden zur Abstraktion und dem Nachweis der erhaltenen Eigenschaften.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	<strong>Miniprojekt:</strong></div>\n<div>\n	Es soll selbst&auml;ndig ein nicht-sequentielles Systems oder ein nicht-sequentieller Algorithmus modelliert, dessen Anforderungen formalisiert und schlie&szlig;lich das Modell bez&uuml;glich der Anforderungen mit Hilfe von geeigneten Modell&uuml;berpr&uuml;fern verifiziert werden. Diese Leistung wird durch Abgabe der Modelle und eines schriftlichen Berichts nachgewiesen.</div>\n<div>\n	&nbsp;</div>', NULL, '<div>\n	- Christel Baier und Joost-Pieter Katoen, Principles of Model Checking, The MIT Press, 2008&nbsp;</div>\n<div>\n	- Mordechai Ben Ari, Principles of the SPIN Model Checker, Springer Verlag, 2008&nbsp;</div>\n<div>\n	- Gerard Holzmann, The SPIN Model Checker, Addison-Wesley, 2004&nbsp;</div>\n<div>\n	- Edmund M. Clarke, Jr., Orna Grumberg and Doron A. Peled, Model Checking, MIT Press, 1999</div>', NULL, 2, 0, '19104101', 35, 1),
(48, 'Logik erster Stufe in Theorie und Praxis', '<ul>\n\n<li>A) eine kompakte Einführung in die Theorie von Logik erster Stufe mit\n\n</li>\n<li>B) einem praktischen Training zur Verwendung von Theorembeweisern für die Logik erster Stufe in Anwendungen.</li></ul>', NULL, '\r\nHinsichtlich A) orientiert sich die Vorlesung am Lehrbuch von Fitting [1] (Harrison [2] wird ebenfalls sehr empfohlen). Zu den Themen der Vorlesung zählen:<br>\r\n<ul>\r\n<li>Syntax und Semantik von Aussagenlogik und Logik erster Stufe (mit und ohne Gleichheit),</li>\r\n<li>Herbrand Modelle,</li>\r\n\r\n<li> Hintikka Mengen und Abstrakte Konsistenz,</li>\r\n\r\n<li>Korrektheit und Vollständigkeit,</li>\r\n\r\n<li>semantische Tableaux und Resolution,</li>\r\n\r\n<li>Implementierung.</li>\r\n</ul>\r\n\r\n\r\nHinsichtlich B) konzentriert sich die Vorlesung auf eine Einführung in die TPTP Infrastruktur [4]. Angesprochene Themen sind:<br>\r\n<ul>\r\n\r\n<li>TPTP Sprache(n),SZS Ontologie für Beweiserresultate,</li>\r\n\r\n<li>TPTP und TSTP Problem- und Beweis-Bibliotheken,</li> \r\n<li>Anwendung von TPTP kompatiblen Beweisern,</li>\r\n\r\n<li>weitere TPTP Werkzeuge und Systeme,</li>\r\n\r\n<li>(TPTP für Logik höherer Stufe).</li></ul><br>\r\n\r\n\r\n\r\nIn Teil B) der Vorlesung werden praktische Übungen im Vordergrund stehen. Sofern Zeit bleibt, wird in der Vorlesung auch ein kurzer Ausblick auf Theorie und Praxis von Logik höherer Stufe geboten (ein Thema, das evtl. im Rahmen einer Vorlesung im SS 2014 vertieft werden wird). \r\n<br>\r\n\r\n\r\nEs wird den Teilnehmern empfohlen, sich bereits im Vorfeld in [1] und [5] einzuarbeiten (auch [2] wird sehr empfohlen).\r\n<br><br>\r\n', '<div>Weitere Angaben siehe (provisorische) <a href="http://page.mi.fu-berlin.de/cbenzmueller/2013-FOL/">Webseite</a><br>Literaturangaben zu A): \n<ul>\n<li> [1] Melvin Fitting, First-Order Logic and Automated Theorem Proving, Springer-Verlag, New York, 1996 </li>\n <li>[2] John Harrison, Handbook of Practical Logic and Automated Theorem Proving, Springer Verlag, New York, 1996. </li> \n<li>[2] John Harrison, Handbook of Practical Logic and Automated Reasoning. Cambridge University Press, 2009. </li>\n <li>[3] Uwe Schöning, Logik für Informatiker, Spektrum, 2000. </li><br></ul><br>\nzu B):<br>\n<ul>\n<li> [4] TPTP Infrastruktur: http://www.tptp.org</li>\n<li> [5] G. Sutcliffe, The TPTP Problem Library and Associated Infrastructure. Journal of Automated Reasoning (2009) 43(4):337:362. (http://www.springerlink.com/content/2g263588337ku424/fulltext.pdf</li>\n<li>[6] G. Sutcliffe and C. Benzmüller, Automated Reasoning in Higher-Order Logic using the TPTP THF Infrastructure, Journal of Formalized Reasoning, (2010) 3(1):1-27.</li></ul>\n</div>', 2, 0, '19103801', 36, 1),
(50, 'Softwareprojekt Intelligente Multicopter', '<p>Programmierung von Multicoptern. Im Softwarepraktikum entwickeln und erweitern wir verschiedene Anwendungen in Java f&uuml;r die automatische und semi-automatische Steuerung von Multicoptern. Siehe <a href="http://www.archaeocopter.de">archaeocopter</a></p>', '', '', 'Studenten mit Interesse an künstlicher Intelligenz \nKenntnisse in Java oder Shaderprogrammierung/CUDA', 4, 1, '19108722', 140, 12),
(51, 'Digitales Video', 'Es werden die gängigen digitalen Videoformate, ihre jeweiligen Algorithmen (sofern offen), ihre jeweils speziellen Eigenschaften und die vorhandenen Werkzeuge vorgestellt: MPEG-1, -2, -4, -7 und -21 wird ausführlich behandelt, ferner AVI, Quicktime, WindowsMedia, MPEG-4/H.264, OGG, Matroska. In jedem Fall ist der Kurs stark praxis-orientiert. Im Rahmen von "Labor"-Übungen steht Software zur Erzeugung und Untersuchung von Video-Dateien zur Verfügung. Teilnehmer/innen, die Credit-Points erwerben wollen, halten einen 40-minütigen Vortrag und fertigen dazu eine kurze Ausarbeitung an.', '', 'Literatur noch nicht genannt ', '<a href="http://www.mi.fu-berlin.de/zdm/lectures/digvideo/index.html>Homepage</a>', 2, 1, '19109820', 38, 10),
(52, 'Softwareprojekt - Anwendung von Algorithmen', '<p>Ein typisches Anwendungsgebiet meist geometrischer Algorithmen wird ausgewC$hlt und softwaretechnisch behandelt, zum Beispiel Computer-Graphik (Darstellung von Objekten im Rechner, Projektionen, Entfernung verdeckter Kanten und FlC$chen, Ausleuchtung, Ray-Tracing), Computer-Sehen (Bildverarbeitung, Filter, Projektionen, Kamera-Kalibrierung, Stereo-Sehen) oder Mustererkennung (Klassifikation, Suchverfahren). </p>', '', 'Je nach Anwendungsgebiet', 'Grundkenntnisse in Entwurf und Analyse von Algorithmen<br>\nsiehe <a  href=\\"http://www.inf.fu-berlin.de/lehre/WS13/Algorithmen-Softwareprojekt/\\" target=\\"_blank\\">http://www.inf.fu-berlin.de/lehre/WS13/Algorithmen-Softwareprojekt/</a></div>', 4, 1, '19108222', 140, 12),
(53, 'Student Research Seminar', '<p>\n	The student research seminar is an event for students doing their theses in our research group. Content varies from meeting to meeting: status reports from theses, reports from conferences, status of research projects, etc.Everyone is invited to join and to experience how we manage and organize theses. One of our primary goals is to keep in touch with each student. In addition to a personal supervisor every student can make use of this event to get support from all participating members of the CST research group - and of course all other students.If you want to do your thesis with us, just attend the meeting. We will discuss our open topics, your personal preferences, and areas of interest. In the end we will come up with a topic that is of interest for all of us.</p>', '', 'Je nach Anwendungsgebiet', '', 2, 1, '19107811', 40, 4),
(54, 'Forschungsseminar - Datenverwaltung', 'Vorträge zu Abschlussarbeiten und aktuellen Forschungsthemen, Teilnahme nur mit persönlicher Einladung. Voraussetzungen Solide Kenntnisse im Bereich Datenbanken und Informationssysteme', '', '', '', 2, 1, '19110216', 142, 9),
(55, 'Forschungsseminar - Secure Identity', 'Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus dem Bereich Secure Identity Voraussetzungen Solide Kenntnisse im Bereich IT-Sicherheit', '', '', '', 2, 1, '19110316', 142, 9);
INSERT INTO `modulverwaltung_lehrveranstaltung` (`lv_id`, `lv_name`, `lv_inhalt`, `lv_ziel`, `lv_literatur`, `lv_voraussetzung`, `lv_sws`, `lv_anwesenheitspflicht`, `lv_nummer`, `m_id`, `lvt_id`) VALUES
(56, 'Vertiefung Fachdidaktik Informatik: Seminar/Praktikum', '<p>Die Studentinnen und Studenten absolvieren im Rahmen des Moduls ein fachdidaktisches Hauptseminar, ein fachdidaktisches Forschungsseminar, ein Seminar &uuml;ber schulform- und altersstufenbezogene Fragen des Informatikunterrichts sowie ein darauf abgestimmtes Praktikum. Inhalte Seminar:</p>\n<ul>\n<li>Analyse, Entwicklung und Erprobung von Unterrichtskonzepten und -materialien</li>\n<li>adressatenbezogene Zug&auml;nge und Unterrichtssequenzen: Einstiege, Motivation, Interesse, Problemorientierung, Kontextbezug, Curricula und Bildungsstandards.</li>\n<li>Inhalte des begleitenden Praktikums: Praktische Umsetzung der im Seminar erprobten Unterrichtskonzepte unter Einsatz der erarbeiteten Materialien.</li>\n</ul>', '', '', ' Diese Veranstaltung ist ein Teil des Moduls /Vertiefung Fachdidaktik Informatik/ im Master-Studiengang /Lehramt Informatik/ und im Master-Studiengang Bioinformatik. Sie kann auch im alten Staatsexamens-Studiengang belegt werden. Empfohlen insbesondere f&uuml;r Lehramtstudierende mit zwei F&auml;chern. Literatur Wird im Seminar bekannt gegeben.', 2, 1, '19107911', 43, 4),
(57, 'Proseminar - Technische Informatik', ' Wechselnd, aufbauend auf der Vorlesung TI II: Rechnerarchitektur', '', 'Literatur wird mit der Ankündigung bekannt gegeben', 'Themenvergabe ist am 1. Termin, danach wöchentlich Vorträge.', 2, 1, '19101610', 143, 3),
(58, 'Proseminar - Parallel Programming', 'Wechselnd, aufbauend auf der Vorlesung Grundlagen der Theoretischen Informatik. \nVorbesprechung in der ersten Semesterwoche (15.10.2013) ', '', 'wird mit der Ankündigung bekannt gegeben', '<h3>Voraussetzungen:</h3><p>zwei abgeschlossene Fachsemester Informatik, Leistungsnachweis GTI </p>\n\n<a href="http://www.inf.fu-berlin.de/lehre/WS13/ProSem-ThInf/Proseminar13.html">Website</a> Literaturangaben Informationen für Studenten Zusätzliche Informationen', 2, 1, '19102310', 143, 3),
(59, 'Proseminar - Geschichte des Computers', 'Im Proseminar Geschichte des Computers beschäftigen wir uns mit der digitalen Revolution und ihren Voraussetzungen. Zum Einstieg untersuchen wir Computerkonzepte und die theoretischen Grundlagen des Rechnens.<br>\nDer nächste Themenblock widmet sich den Computertechnologien, mit denen die Konzepte umgesetzt wurden, und bedeutenden historischen Rechenmaschinen.<br>\nIn den siebziger Jahren eroberte der Computer den Massenmarkt und wurde Teil des Alltags. Wir greifen einige Beispiele heraus, die ihrer Geräteklasse jeweils zum Durchbruch verhalfen. Zum Abschluss des Proseminars schauen wir uns einige während der digitalen Revolution entstandene Technologien an und diskutieren die Frage, welche Entwicklungen in der Zukunft noch zu erwarten sind.\n', '', '', '<h3>Ablauf:</h3>\nDas Proseminar findet als Blockveranstaltung während der Semesterferien statt. An jedem Termin finden bis zu fünf Vorträge statt. Jede Teilnehmerin bereitet einen Vortrag vor (10-15 Folien, 30 Minuten Vortrag + 15 Minuten Diskussion). Die Teilnehmer eines Themenblocks arbeiten als Gruppe zusammen und übernehmen die Gestaltung des Tages (Einführung in das Thema, Moderation, Fazit)\nVorbesprechung und Themenvergabe: 17.10.2013, 16-18 ct. (Donnerstag, erste Woche der Vorlesungszeit)\nAbgabe der Vortragsfolien und Rücksprache: 31.1.2014, anschließend Gelegenheit zur Überarbeitung und Ergänzung\nSeminar: 24.2. - 27.2.2014, 10:00-16:00 ct. Abgabe der schriftlichen Ausarbeitung (max. 10 Seiten): 4.4.2014\nThemen etc. siehe <a href="http://www.inf.fu-berlin.de/w/Inf/GeschichteDesComputers/">http://www.inf.fu-berlin.de/w/Inf/GeschichteDesComputers/</a>', 2, 1, '19102710', 143, 3),
(60, 'Proseminar - Logische Programmierung', 'In diesem Proseminar werden Themen aus den Grundlagen der logischen Programmierung und logischer Programmiertechniken, der Implementierung von Logiksprachen wie Prolog, sowie der Einsatz logischer Programmiersprachen in verschiedenen Anwendungsbereichen bearbeitet. Zielgruppe - Studierende im Bachelorstudiengang (ab 3. Fachsemester) - Studierende im lehramtsbezogenen Bachelorstudiengang - Studierende mit Nebenfach Informatik Voraussetzungen Logik (MafiI);Funktionale und objektorientierte Programmierung wünschenswert<br>\n<a href="http://www.inf.fu-berlin.de/groups/ag-csw/Teaching/Wintersemester_2012_13/Proseminar_Logik_Programmierung.html">Homepage</a>', '', '', '<p>Vorbesprechung und Themenvergabe am 16.10.2012 um 16 Uhr in der Takustr. 9, SR 053</p>\n<br>\n<h3>Zielgruppe</h3>\n<ul>\n<li>Studierende im Bachelorstudiengang</li>\n<li>Studierende mit Nebenfach Informatik</li>\n<li>Studierende im lehramtsbezogenen Bachelorstudiengang</li></ul>\n<br>\n<h3>Voraussetzungen:</h3>\n\n<p>Logik (Mafi I) hilfreich</p>', 2, 1, '19102110', 143, 3),
(61, 'Proseminar - Frauen in der Geschichte der Mathematik und Informatik', 'Inhalt Im Zentrum des Seminars steht die Erarbeitung und Wiederentdeckung der Lebensgeschichten und des Wirken einiger bedeutender Mathematikerinnen und Informatikerinnen im 19. und 20. Jahrhundert. Betrachtet werden z.B. das Leben und Werk von Sophie Germaine (1776-1831), Ada Lovelace (1815-1852), Sonja Kovalevskaya (1850-1891), Emmy Noether (1882-1935), Ruth Moufang (1905-1977), Grace Murray Hopper (1906-1992) und weiteren Wissenschaftlerinnen. Im Seminar geht es nicht darum, diese Frauen als Ausnahmeerscheinung hervorzuheben, denn dies würde sie lediglich auf ihren Exotinnenstatus festschreiben. Es geht vielmehr um eine historische Kontextualisierung deren Leben und Werk. Dies ermöglicht nicht nur eine exemplarische Auseinandersetzung mit gesellschaftlichen wie fachkulturellen Inklusions- und Exklusionsprozessen entlang der Kategorie Geschlecht, sondern auch die Entwicklung neuer Sichtweisen auf die tradierte Kulturgeschichte beider Disziplinen. Das Seminar basiert auf dem Ansatz eines forschenden oder entdeckenden Lernens, d.h. die Studierenden werden selbständig in Gruppenarbeiten einzelne Seminarthemen vorbereiten und präsentieren. Diese Präsentationen werden dann im Seminar diskutiert. Durch den Einsatz von Beobachtungsbögen soll zudem eine Feedbackkultur erprobt werden, die im späteren Berufsalltag im Umgang mit SchülerInnen und/oder KollegInnen hilfreich ist. ierende in den Bachelorstudiengängen Mathematik und Informatik und den entsprechenden Lehramtsstudiengängen.', '', 'Literatur wird in der Veranstaltung bekannt gegeben. ', '<a href="http://www.math.fu-berlin.de/groups/ag-ddm/members/mischau.html">Homepage</a>', 2, 1, '19102610', 143, 3),
(62, 'Proseminar - Verteilte Programmierung', 'Die Studierenden arbeiten sich in einen ausgewählten Verteilten Algorithmus (z.B. aus dem Katalog der möglichen Themen auf der Homepage der Veranstaltung) ein, stellen ihn vor und erklären ihn ausführlich (eventuell unter Einbezug verwandter Algorithmen). Sie programmieren ihn in Go, erläutern ihre Implementierung und führen ggf. eine beispielhafte Anwendung oder Animation vor.', '', 'siehe <a href="http://www.inf.fu-berlin.de/lehre/WS13/psvp/index.shtml">Homepage</a>', '<h3>Zielgruppe:</h3> Studierende der Informatik ab 5. Semester; insbesondere erfolgreiche Absolventen der ALP IV aus dem SS 13.\n<h3>Voraussetzungen:</h3> Leistungsnachweis in Algorithmen und Programmierung IV, Kenntnisse in Go im erforderlichen Umfang.\n', 2, 1, '19102210', 143, 3),
(63, 'Proseminar - Theoretische Informatik', '<div>Wechselnd, aufbauend auf der Vorlesung <i>Grundlagen der Theoretischen Informatik</i>.\n<br>\nVorbesprechung in der ersten Semesterwoche (15.10.2013)\n<br><br>\n</div>', '', '', '<h3>Voraussetzungen</h3>: zwei abgeschlossene Fachsemester Informatik, Leistungsnachweis GTI \r\n<br><br>\r\n<h3>Literatur</h3>: wird mit der Ankündigung bekannt gegeben \r\n<br><br>\r\n<b>Website</b>: <a href="http://www.inf.fu-berlin.de/lehre/WS13/ProSem-ThInf/Proseminar13.html">\r\nhttp://www.inf.fu-berlin.de/lehre/WS13/ProSem-ThInf/Proseminar13.html</a>\r\n', 2, 1, '19101710', 143, 3),
(64, 'ALP 3 - Datenstrukturen und Datenabstraktion', '<ul>\n<li>Analyse von Sortierverfahren: Mergesort, Quicksort, u.a. \n</li><li>ADTs Prioritätswarteschlange und Wörterbuch und zugehörige Datenstrukturen: Heaps, Hashing, \nbinäre Suchbäume, B-Bäume, u.a. \n</li><li>Algorithmen auf Graphen: Breiten- und Tiefensuche, topologisches Sortieren, minimale Spannbäume, kürzeste Wege. \n</li><li>Algorithmen für Mengen von Zeichenketten. \n</li><li>Speicherverwaltung. \n</li><li>Verschiedene Entwurfstechniken für Algorithmen: teile-und-herrsche, greedy, dynamische Programmierung. \n</li><li>Mathematische Analyse von Algorithmen bezüglich ihres Resourcenbedarfs: Laufzeit, Speicherplatz.\n</li></ul>', '', '<ul>\n<li>M.T. Goodrich, R. Tamassia: Data Structures and Algorithms in Java. Wiley 2004 \n</li><li> R. H. Güting, S. Dieker: Datenstrukturen und Algorithmen, Teubner 2003 \n</li><li> Cormen, Leiserson, Rivest: Algorithmen, Oldenbourg 2004 \n</li><li>R. Sedgewick: Algorithmen in Java. (Teil 1-4), Pearson 2003\n</li></ul>', '<br>', 4, 0, '19100201', 51, 1),
(67, 'ALP 1 - Funktionale Programmierung', 'Grundlagen der Berechenbarkeit: \n<ul>\n<li>Lambda-Kalkül</li>\n<li>primitive Rekursion</li>\n<li>µ-Rekursion</li>\n</ul>\n\n<br>\n\nEinführung in die ufnktionale Programmierung (Haskell):\n<ul>\n<li>Syntax (Backus-Naur-Form)</li>\n<li>	primitive Datentypen, Listen, Tupel, Zeichenketten</li>\n<li>Ausdrücke, Funktionsdefinitionen, Rekursion und Iteration</li>\n<li>Funktionen höherer Ordnung, Polymorphie</li>\n<li>Typsystem, Typherleitung und –überprüfung</li>\n<li>Algebraische und abstrakte Datentypen<li>\n<li>Ein- und Ausgabe<li>\n<li>Such- und Sortieralgorithmen</li>\n</ul>\n<br>\n\nBeweisen von Programmeigenschaften: \n<ul>\n<li>Termersetzung</li>\n<li>strukturelle Induktion</li>\n<li>Terminierung</li>\n</ul>\n<br>\nImplementierung und Programmiertechnik: \n<ul>\n<li>Auswertungsstrategien für funktionale Programme</li>\n<li>Modularer Programmentwurf</li></ul>', '', '<ul>\n<li>Simon Thompson: Haskell: The Craft of Functional Programming, 2nd Edition, Addison-Wesley, 1999</li>\n<li>Graham Hutton: Programming in Haskell, Cambridge University Press, 2007</li>\n<li>Bird, R./Wadler, Ph.: Einführung in Funktionale Programmierung, Hanser Verlag, 1982</li>\n<li>Hans Hermes: Aufzählbarkeit, Entscheidbarkeit, Berechenbarkeit, Springer-Verlag 1978</li></ul>', 'Informationen für Studenten Homepage <a href="http://www.inf.fu-berlin.de/lehre/WS13/ALP1/">http://www.inf.fu-berlin.de/lehre/WS13/ALP1/</a>', 4, 0, '19100001', 52, 1),
(68, 'ALP 5 - Netzprogrammierung', '<p>Die Vorlesung stellt Prinzipien, Sprachen und Middleware f&uuml;r die Entwicklung verteilter Anwendungssysteme vor. In Fortsetzung von Algorithmen und Programmierung IV werden nichtsequentielle Programme betrachtet, deren Prozesse &uuml;ber Nachrichten interagieren. Verschiedene Architekturstile werden behandelt: Datenfluss, verteilte Algorithmen, Ereignissysteme, Client/Server.&nbsp; Nach einer Auffrischung der elementaren Client/Server-Kommunikation &uuml;ber Sockets wird am Beispiel von Java RMI die Fernaufruf-Technik behandelt.&nbsp; Web-Anwendungen und -Dienste werden als alternative Auspr&auml;gungen des Fernaufruf-Prinzips identifiziert.</p>', '', 'Bengel, Günther: Grundkurs Verteilte Systeme. Vieweg & Teubner 2004', '<h3>Voraussetzungen</h3><div>ALP 1-4, TI 1-3. Ferner wird erwartet, dass die Teilnehmer Grundkenntnisse in HTML mitbringen und ihre HTML-Kenntnissewährend des Semesters selbständig erweitern. (Eine von zahlreichen einschlägigen Ressourcen ist http://de.selfhtml.org/html/index.htm</div><br>\nHomepage <a  href=\\"http://www.inf.fu-berlin.de/lehre/WS13/alp5\\" target=\\"_blank\\">www.inf.fu-berlin.de/lehre/WS13/alp5</a>', 2, 0, '19100401', 53, 1),
(72, 'TI 1 - Grundlagen der Technischen Informatik', '<div>\n	Die Vorlesung Grundlagen der Technischen Informatik bildet die Basis f&uuml;r das Verst&auml;ndnis der Funktionsweise realer Rechnersysteme. Es werden grundlegende Kenntnisse aus den Bereichen Gleich- und Wechselstromnetzwerke, Halbleiter, Transistoren, CMOS, Operationsverst&auml;rker, A/D- und DA-Umsetzer vermittelt, soweit sie f&uuml;r die Informatik notwendig sind. Ausgehend von der Logik werden in diesem Modul vorrangig die Themenbereiche Schaltnetze und Schaltwerke, Logikminimierung, Gatter, Flip-Flops, Speicher, Automaten und einfacher Hardware-Entwurf behandelt.</div>', '', '<strong>Literatur:</strong>\n<ul>\n<li>H. M. Lipp: Grundlagen der Digitaltechnik, 3. Auflage, Oldenbourg Verlag 2000</li>\n<li>Th. R. McCalla: Digital Logic and Computer Design, Macmillan Publishing Company in New York 1992</li>\n<li>W. Oberschelp, G. Vossen: Rechneraufbau und Rechnerstrukturen 8. Auflage Oldenbourg-Verlag M&uuml;nchen, 2000</li>\n<li> J. Hayes: Computer Architecture and Organisation McGraw, 3. Auflage 1998</li>\n<li> H. Liebig, S. Thome: Logischer Entwurf digitaler Systeme, 3. Auflage, Springer Verlag, 1996</li>\n<li>G. Scarbata: Synthese und Analyse digitaler Schaltungen, Oldenbourg Verlag 1996</li>\n<li>A. Bleck, M. Geodecke, A. Huss, K. Waldschmidt: Praktikum des modernen VLSI-Entwurfs, Teubner Verlag 1996</li></ul>', '<a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/2013-14_WS/index.html">Homepage</a>', 2, 0, '19100501', 55, 1),
(75, 'TI 3 - Betriebs- und Kommunikationssysteme', '<div>Das Modul Betriebs- und Kommunikationssysteme schlie&szlig;t die L&uuml;cke zwischen dem Rechner als Hardware und den Anwendungen. Themen sind daher Ein-/Ausgabe-Systeme, DMA/PIO, Unterbrechungsbehandlung, Puffer, Prozesse/Threads, virtueller Speicher, UNIX und Windows, Shells, Utilities, Peripherie und Vernetzung, Netze, Medien, Medienzugriff, Protokolle, Referenzmodelle, TCP/IP, grundlegender Aufbau des Internet.</div>', '', '<ul>\n<li>William Stallings: Betriebssysteme - Prinzipien und Umsetzung, Pearson Studium 2003</li>\n<li>James F. Kurose, Keit W. Ross: Computernetze, Pearson Studium 2002</li>\n</ul>', '<a href="https://lms.fu-berlin.de/webapps/blackboard/execute/courseMain?course_id=_43706_1">Homepage</a>', 2, 0, '19100701', 56, 1),
(76, 'Seminar - Autonome Fahrzeuge', 'Das Seminar kann als Vorbereitung für eine Master- oder Diplomarbeit in der AG "Intelligente Systeme und Robotik" dienen. Folgende Themen aus dem Gebiet der Autonomen Fahrzeuge stehen zur Auswahl: Fahrplanung in dynamischen Situationen, Fahrplanung mit begrenztem Wissen, Lokalisierung mittels Landmarken, Objekterkennung im Straßenverkehr. ', '', '', '', 2, 0, '19105611', 57, 4),
(80, 'Mikroprozessor-Praktikum', 'Die überwältigende Mehrheit zukünftiger Computersysteme wird durch miteinander kommunizierende, eingebettete Systeme geprägt sein. Diese finden sich in Maschinensteuerungen, Haushaltsgeräten, Kraftfahrzeugen, Flugzeugen, intelligenten Gebäuden etc. und werden zukünftig immer mehr in Netze wie dem Internet eingebunden sein. Das Praktikum wird auf die Architektur eingebetteter Systeme eingehen und die Unterschiede zu traditionellen PC-Architekturen (z.B. Echtzeitfähigkeit, Interaktion mit der Umgebung) anhand praktischer Beispiele aufzeigen. Das Praktikum basiert auf einem MSP430 Mikrocontrollersystem. Schwerpunkte des in einzelne Versuche gegliederten Praktikums sind: Registerstrukturen, Speicherorganisation, hardwarenahe Assembler- und Hochsprachenprogrammierung, I/O-System- und Timer-Programmierung, Interrupt-System, Watchdog-Logik, Analogschnittstellen, Bussystemanbindung von Komponenten, Kommunikation (seriell, CAN-Bus, Ethernet, Funk und USB), Ansteuerung von Modellen und Nutzung unterschiedlichster Sensorik', '', 'Das große MSP430 Praxisbuch, Franzis Verlag GmbH, 2000 Brian W. Kernighan, Dennis M. Ritchie: The C Programming Language, Second Edition, Prentice Hall, 1988', 'Siehe Unterlagen auf der Homepage - nur aus dem FB-Netz oder über VPN <a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/2013-14_WS/index.html">Homepage</a>', 4, 1, '19110030', 59, 13),
(81, 'Kundenprojekt Web-Technologien (Entrepreneurship Application)', 'Zusammen mit der Universität Sydney und dem Department Wirtschaftsinformatik der FU Berlin soll eine Software für die Unterstützung von Gründungslehre erstellt werden. Dafür liegen erste Anforderungen vor, s.u., die noch recht unscharf formuliert sind.Hier das Original-Anforderungsdokument der Universität Sydney.The application aims to assist trainers with the coordination, support, delivery, measurement and management of essential business education programs targeting multiple cohorts of entrepreneurs. We will focus programs on micro- and small-entrepreneurs and specifically seek to include women and people with disabilities, but generally target people from socially underprivileged communities with limited prior business education. Examples of such communities and cohorts may include Asian or Indigenous enterprises.Our programs will include a mix of learning communities, with key phrases being learning by doing, problem-based learning, communities of practice etc. We will have a little ''learning'' and a lot of ''coaching/mentoring/sharing'' to shape the course.This application will focus on trainers. We want to simplify how we share content with them (across multiple languages and cultures). We want to help them best manage their cohorts. We want to assist them with their classes. We want to be able to track their and our progress.Education philosophy - enquiry based learning "	We have some content, including material with an overview of enquiry based learning, case studies, lesson structures, and key mentoring requirements. "	We want to help people to ask the right questions of the right people at the right time… "	Material for trainers will include stimuli and concepts that facilitate learning through doing and discussing. We want to concentrate on ''ask, try, do, reflect'' and clearly articulate the differing implications of ''observations, implications and opportunities''. We have stories, experiences, open-ended questioning etc. and will form part of the content/training material created and managed centrally. Technology To be made available on an android tablet. Make/model yet to be determined, but sourced primarily by price. Hearsay regarding a $30 tablet manufactured in India is yet to be investigated to confirm appropriateness. Required Functionality (High Level) Functions/Modules "	Manage Content "	Manage Students "	Manage Cohorts "	Engaged Learning (user interface to trainers/students) "	Manage Security " Intelligence & Reporting Bitte beachten Sie auch die allgemeine Beschreibung der Veranstaltung Kundenprojekt.', '', '', '', 4, 0, '19108022', 140, 12),
(82, 'Kundenprojekt Web-Technologien (Verteilte Clusterarchitekturen)', 'Inhalt des Projektes ist es, Technologien zu erproben, mit denen eine Softwareinfrastruktur für das Projektmanagement international tätiger Unternehmen, deren Projektdurchführung oder Produktentwicklung an verschiedenen Standorten in verschiedenen Zeitzonen weltweit erfolgt, realisiert werden kann. Umgesetzt werden soll eine verteilte Cluster-Architektur, bei der jeder Standort einen eigenen Server erhält. Die Projektdaten oder vom jeweiligen Standort freigegebene Teile davon werden für Projektmanagementzwecke zwischen den Servern ausgetauscht, und Teile der Daten werden in einem Server in der Zentrale für Steuerungs- und Controllingzwecke zu Auswertungen und Berichten aggregiert.Projektron hat bereits für einen Spezialfall - die Synchronisation von Daten zwischen einer intern installierten Projektron-BCS-Vollversion und einer extern installierten Version mit Ticketsystem und Kundenzugang - Erfahrung mit "verteilten" Systemen gesammelt. Bei einem weltweit verteilten Cluster sind jedoch zahlreiche neue und interessante Herausforderungen zu erwarten, an denen sich die Studenten beweisen können. Dabei sind zahlreiche Probleme zu lösen, von denen für das Projekt einige ausgesucht werden können: "	Fragen der Kommunikationswege zwischen den Systemen "	unterschiedliche Konfigurationen auf den Systemen "	unterschiedliche Rechtesysteme "	Vergabe von Clusterweit eindeutigen Nummernkreisen "	Termin-Behandlung in Zeitzonen "	Mehrwährungen "	Sprachen "	interne Leistungsverrechnung Bitte beachten Sie auch die allgemeine Beschreibung der Veranstaltung Kundenprojekt.', '', '', '', 4, 0, '19108122', 140, 12),
(83, 'Softwareprojekt Intelligente Systeme und Robotik', 'Im Softwareprojekt werden wir die Software (low- and high level) der Roboter der AG Intelligente Systeme und Robotik ausbauen (z.B. FUmanoids, FUB-KIT)\n\nWeitere Informationen zu den FUmanoids unter http://www.fumanoids.de', '', 'wird noch bekannt gegeben', '<h2>Voraussetzungen:</h2>\nMaster- und Diplomstudenten (Bachelorstudenten ab dem 5. Semester)\nNotwendige Kenntnisse C/C++, git', 4, 1, '19108822', 140, 12),
(84, 'Softwareprojekt: Design and implementation of a hacking challenge server', 'Software vulnerabilities are a common problem of todays computer landscape. We believe that understanding vulnerabilities is an important prerequisite to avoid them. Current CS classes have a large focus on the theoretical background of vulnerabilities but often lack an integrated practical part. However, the practical experience in exploiting a vulnerability would teach CS students some important lessons. The purpose of this software project is to create a legal and safe platform for CS students to practically explore software vulnerabilities in a controlled environment. The project will be organized in two phases. During the semester the participants will be asked to become subject matter experts for different types of vulnerabilities. There will be biweekly meetings in which the theoretic backgrounds will be discussed. In addition the architecture of the overall system will be designed. In the second phase (block) the students will implement the system. If the participants are interested and the system is fully functional at the end of the project phase we can organize a small hacking competition for other students', '', 'See Computer Security: http://www.inf.fu-berlin.de/groups/ag-si/compsec.html', '<h2>Zielgruppe:</h2>\n<ol><li>Bachelor / Master students in computer science</li><li>Bachelor students may need to invest more time to catch up on basic knowledge</li></ol>\n<h2>Voraussetzungen:</h2>\n<ol>\n<li>Basics in computer security</li>\n<li>Basics in C programming - Interest in software vulnerabilities</li></ol>', 4, 1, '19109422', 140, 12),
(85, 'Softwareprojekt modellgetriebene Softwareentwicklung', 'Softwareentwicklungsprozesse werden üblicherweise in verschiedene Phasen aufgeteilt, Beispiele hierfür sind die Anforderungsanalyse, die Entwurfsphase oder das Testen. Verschiedene Vorgehensmodelle wie das Wasserfallmodell oder das V-Modell beschreiben solche Prozesse und Phasen. Eine spezielle Ausprägung der Softwareentwicklung ist die modell-gestützte Softwareentwicklung, bei der in allen Phasen Modelle im Mittelpunkt stehen. Die Verwendung von Modellen ist dabei kein Selbstzweck: vielmehr ist sie bei großen und komplexen Entwicklungsprozessen ein wichtiges Hilfsmittel im Umgang mit der Komplexität des zu entwerfenden Systems und des Prozesses an sich. Häufig arbeiten mehrere hundert Entwickler verteilt an einem Projekt und eine Vielzahl verschiedener Werkzeuge wird verwendet.Um eine nahtlose Integration zwischen den verwendeten Werkzeugen zu erreichen, sowie die Arbeiten der Entwicklerteams zu synchronisieren ist es notwendig zu berücksichtigen wie Informationen von einem Werkzeug in einem anderen Werkzeug transparent wiederverwendet werden können. Einen möglichen Ansatz bietet der ModelBus . Der ModelBus wird seit 5 Jahren im Rahmen von mehreren europäischen Verbundprojekten am Fraunhofer Institut FOKUS entwickelt. Diese Software bietet verschiedene Dienste an, die auf Modellen arbeiten. So gibt es als Basisdienst ein Repository, in das alle Artefakte eines Entwicklungsprozesses abgespeichert werden. Es gibt Dienste für die Transformation von Modellen zu Modellen oder Verifikationsdienste für bestimmte Artefakte des Entwicklungsprozesses. Im Rahmen des Projektes werden zunächst die Grundprinzipien der Model-getriebenen Entwicklung vorgestellt. Darauf aufbauend sollen unter Berücksichtigung der erworbenen Kenntnisse eine Werkzeugkette erstellt werden und Daten zwischen den unterschiedlichen Werkzeugen ausgetauscht werden. Weiterhin können bei Bedarf zusätzliche Dienste und Werkzeuge für die Modell-getriebene Entwicklung in diesem Projekt implementiert werden.', '', 'Anneke Kleppe, Wim Bast, Jos B. Warmer. MDA Explained - The Model Driven Architecture: Practice and Promise, Addison-Wesley Longman, ISBN 978-0321194428?Markus Völter, Thomas Stahl, Jorn Bettin, Arno Haase, Simon Helsen, Krzystof Czarnecki, Bettina von Stockfleht. Model-Driven Software Development, John Wiley & Sons, ISBN 978-0470025703?David Steinberg, Frank Budinsky, Marcelo Paternostro, Ed Merks. EMF: Eclipse Modeling Framework (2nd Edition), Addison-Wesley Longman, ISBN 978-0321331885?Martin Fowler, Rebecca Parsons. Domain Specific Languages, Addison-Wesley Longman, ISBN 978-0321712943?Object Management Group. Meta Object Facility (MOF) Core Specification (Version 2.0), formal/06-01-01, http://www.omg.org/spec/MOF/2.0/PDF/ Homepage https://www.inf.fu-berlin.de/w/SE/ProjektModellgetriebeneSoftwareentwicklungWS1213', ' <h2>Zielgruppe:</h2>\nStudierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik.\n<h2>Voraussetzungen:</h2>\nGrundlagen der Java Programmierung, Hilfreich sind Grundlagen in Software Engineering, sowie Kenntnisse des Versionskontrollsystems Subversion', 4, 1, '19109022', 140, 12),
(86, 'Softwareprojekt: Entwicklung eines autonomen Modellautos', 'In dieser Blockveranstaltung wird ein autonomes Modellauto im Maßstab1:10 weiterentwickelt, das am Carolo-Cup ( http://racing.berlin-united.org ) teilnehmen soll. Das Auto soll autonom eine unbekannte Rennstrecke mit und ohne Hindernissen abfahren können, sowie in eine freie Parklücke einparken. Als Eingabedaten werden Kamerabilder verwendet, die ausgewertet werden müssen. Diese Daten sollen dann von der Lenkregelung zum Halten der Fahrspur verwendet werden. Die Ansteuerung der Motoren erfolgt über einen separaten Mikrocontroller. Mögliche Themengebiete umfassen Computer Vision, Verhaltensprogrammierung, Selbstlokalisierung und Modellierung, Auswertung von Sensordaten, Anwendung von Lernverfahren, uvm. Bei der Umsetzung der Aufgaben werden fachübergreifende Kenntnisse erworben, Teamfähigkeit gefördert und Praktiken der guten Software-Entwicklung geübt. ', '', '', '<h2>Zielgruppe</h2>\nStudenten ab dem 5. Semester\n<h2>Voraussetzungen</h2>\nStudenten mit Interesse an Künstlicher Intelligenz und Robotik\n<h2>Zus&auml;tzliche Informationen</h2>\nBlockveranstaltung vor WS14/15; täglich von 14-17 Uhr im Robotiklabor 020 der Arnimallee 7', 4, 1, '19109522', 140, 12),
(87, 'Softwareprojekt Geometric Computing: Introduction to CGAL', 'Learn how to program and use basic computational geometry algorithms and data structures with the help of the Computational Geometry Algorithms Library (CGAL: http://www.cgal.org/)! Geometric algorithms are important in many areas such as: computer graphics, scientific visualization, computer aided design and modeling, geographic information systems, molecular biology, medical imaging, etc.We will cover several topics such as: Convex Hulls, Triangulations, Arrangements, Polygons etc.Each topic will be sufficiently covered in a lecture; We''ll then work on exercises. This is a practical course (the aim is to learn how to work with several CGAL packages). The working programming language wil be C++. CGAL is a library based on generic programming principles, so we''ll also learn about CGAL traits classes, kernels, etc.Students can work in teams and each team will also have to work on a final project that will be chosen in class. Note: This course can serve as a good introduction to the Computational Geometry course that will be taught in SS 2013. Zielgruppe Bachelor/Master students that want to learn something about geometric computing, CGAL, computational geometry', '', 'CGAL: http://www.cgal.org/ CGAL Arrangements and Their Applications, E. Fogel, D. Halperin, R. Wein, Springer 2012.Computational Geometry: Algorithms and Applications, Mark de Berg, Otfried Cheong, Marc van Kreveld, Mark Overmars, Springer, 2008 (third edition).', '<h2>Voraussetzungen:</h2> The students should have knowledge in algorithms, and should have sufficient competence in C++ and generic programming (templates, iterators, containers etc.). Experience with Qt, Boost, etc. will be also helpful but not necessary.', 4, 1, '19108522', 140, 12),
(88, 'Softwareprojekt in Kooperation mit der Firma Testing Technologies', '<p>In der heutigen Zeit, ist für Unternehmen überlebenswichtig schnell ein neues Produkt auf dem Markt zu bringen. Dafür müssen Prozesse geschaffen werden, die Entwicklerteams dabei unterstützen. Ein Beispiel bietet die Agile Softwareentwicklung: sie ist kundennah, zweckmäßig, erfolgsorientiert und strebt an Overhead auf ein Minimum zu reduzieren. Dieses Projekt-Praktikum wird Sie praktisch begleiten um, unter Anwendung agiler Methoden, ein Open Source Projekt aufzusetzen, zu planen, zu koordinieren und umzusetzen.\nDas Projekt wird von Herrn Bogdan Stanca-Kaposta und Herrn Dr. Jacob Wieland von TestingTech betreut.</p>\n<br>\n<p>Die vorgeschlagen Projekte setzen auf der Eclipse basierten Testautomatisierungs IDE TTworkbench auf. Es werden benutzerfreundliche User Interface Widgets entwickelt die mittels Google''s Protocol Buffer mit einer Implementierung kommunizieren. Optional könnten leichte webbasierte Widgets mittels HTML/JavaScript erstellt werden. Letztere werden mittels JSON mit der Implementierung kommunizieren.. An den ersten Terminen werden anhand von Beispielen die Möglichkeiten des TTworkbench Frameworks vorgestellt und parallel dazu mit dem Teams die Designs der (Teil-)Projekte besprochen und im Plenum vorgestellt.</p>\n<br>\n<p>Es werden gemischte Gruppen von Bachelor- und Master-Studenten gebildet, die entweder ein eigenständiges Projekt erstellen oder aber ein Teil eines größeren Projektes übernehmen. Die Teams werden regelmäßig über Fortschritte und eventuelle Probleme in einem wöchentlichen Plenum berichten. Am Ende des Praktikums werden die (Teil-)Projekte im Plenum präsentiert und bewertet.</p>\n<br>\n<p>Die Fortführung des Projektes als Master- oder Diplomarbeit ist möglich und ausdrücklich erwünscht.</p>\n<br>\n<p>Der Code des letzten Projektes liegt auf https://github.com/TestingTechnologies/PlayITS</p>', '', '', '<h2>Zielgruppe:</h2>\n<p>Studierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik.</p>\n<h2>Voraussetzungen:</h2>\n<p>Grundlagen der Java Programmierung, Google''s Protocol Buffers, HTML/JavaScript, Hilfreich sind Grundlagen in Software Engineering, sowie Kenntnisse eines Versionskontrollsystems</p>', 4, 1, '19108622', 140, 12),
(89, 'Softwareprojekt Programmierung eines Kartenspiels', 'Das Kernziel dieses Softwareprojektes ist es, ein Multiplayer-Kartenspiel umzusetzen. Es soll eine Künstliche Intelligenz als Mitspieler entwickelt werden, damit der Spieler das Spiel auch ohne echten Gegner jederzeit spielen kann. Die entwickelte KI hat dabei vor allem die Aufgabe dem Spielverhalten eines menschlichen Spielers möglichst gut zu simulieren. Außerhalb des eigentlichen Spieles sollen potentielle Spieler von Anfang an über eine eigens für das Spiel entworfene Homepage an das Spiel herangeführt und gehalten werden. Während der Entwicklung sollen Interessierte über einen Entwicklerblog auf dem Laufenden gehalten werden. Insgesamt soll das Spiel für den Spieler als rundes Gesamtprojekt erreichbar und spielbar sein. Die Teilnehmer selbst sollen am Ende des Projektes Wissen über den Aufbau und die Durchführung größerer Projekte und die damit verbundenen Fähigkeiten der Softwaretechnik erlangt haben. In einer finalen Präsentation soll schließlich das fertige Projekt an der Universität vorgestellt werden. Es ist nicht Ziel des Projektes ein grafisch aufwendiges Spiel umzusetzen. Ebenso wenig soll der Fokus auf dem Design des Spiels liegen.', '', '', '<h2>Voraussetzungen:</h2>\n<p>Module ALP II, ALP III, Mafi III, Softwaretechnik</p>\n<h2>Zielgruppe:</h2>\n<p>Studierende im Bachelor oder Master Informatik</p>', 4, 1, '19109122', 140, 12),
(90, 'MafI I: Logik und Diskrete Mathematik', '<ol>\n<li>Aussagenlogik und mathematische Beweistechniken</li>\n<li>Boolesche Formeln und Boolesche Funktionen, DNF und KNF, Erfüllbarkeit, Resolutionskalkül</li>\n<li>Mengenlehre: Mengen, Relationen, Äquivalenz- und Ordnungsrelationen, Funktionen</li>\n<li>Natürliche Zahlen und vollständige Induktion, Abzählbarkeit<(li>\n<li>Prädikatenlogik und mathematische Strukturen</li>\n<li>Kombinatorik: Abzählprinzipien, Binomialkoeffizienten und Stirling-Zahlen, Rekursion, Schubfachprinzip</li>\n<li>Graphentheorie: Graphen und ihre Darstellungen, Wege und Kreise in Graphen, Bäume</li></ol>', '', '<ol>\n<li>Christoph Meinel, Martin Mundhenk: Mathematische Grundlagen der Informatik, Teubner; 2. Auflage 2002</li>\n<li>Uwe Schöning: Logik für Informatiker, B.I.-Wissenschaftsverlag; 5. Auflage 2000</li>\n<li>Kenneth H. Rosen: Discrete Mathematics and its Applications, Mc-Graw Hill; 1999</li>\n<li>M. Aigner: Diskrete Mathematk, Vieweg, 5. Auflage 2004</li></ol>', '', 4, 0, '19100901', 69, 1),
(92, 'MafI III: Lineare Algebra', '<ul>\n<li>Lineare Algebra: \n  <ul>\n    <li>Vektorraum, Basis und Dimension; \n    </li><li>lineare Abbildung, Matrix und Rang; \n    </li><li>Gauss-Elimination und lineare Gleichungssysteme; \n    </li><li>Determinanten, Eigenwerte und Eigenvektoren; \n    </li><li>Euklidische Vektorräume und Orthonormalisierung; \n    </li><li>Hauptachsentransformation\n  </li></ul>\n</li><li>Anwendungen der linearen Algebra in der affinen Geometrie, Statistik und Codierungstheorie (lineare Codes) \n</li><li>Grundbegriffe der Stochastik: \n  <ul>\n    <li>Diskrete und stetige Wahrscheinlichkeitsräume, Unabhängigkeit von Ereignissen; \n    </li><li>Zufallsvariable und Standardverteilungen; \n    </li><li>Erwartungswert und Varianz\n  </li></ul>\n</li></ul>', '', '<ul>\n<li>Klaus Jänich: Lineare Algebra, Springer-Lehrbuch, 10. Auflage 2004\n</li><li>Dirk Hachenberger: Mathematik für Informatiker, Pearson 2005 \n</li><li>G. Grimmett, D. Welsh: Probability - An Introduction, Oxford Science Publications 1986 \n</li><li>Kurt Meyberg, Peter Vachenauer: Höhere Mathematik 1, Springer-Verlag, 6.Auflage 2001 \n</li><li>G. Berendt: Mathematik für Informatiker, Spektrum Akademischer Verlag 1994 \n</li><li>Oliver Pretzel: Error-Correcting Codes and Finite Fields, Oxford Univ. Press 1996\n</li></ul>', 'Freischaltung der Anmeldung zu Tutorien wird rechtzeitig bekanntgegeben.', 4, 0, '19101101', 70, 1),
(94, 'Kryptographie und Sicherheit in Verteilten Systemen', 'Diese Vorlesung gibt eine Einführung in die Kryptographie und das kryptographische Schlüsselverwaltung, sowie eine Einführung in kryptographische Protokolle und deren Anwendung im Bereich der Sicherheit in verteilten Systemen. Mathematische Werkzeuge werden im erforderlichen und einer Einführungsveranstaltung angemessenen Umfang entwickelt. Zusätzlich berührt die Vorlesung die Bedeutung von Implementierungsdetails für die Systemsicherheit. Voraussetzungen Teilnehmer müssen gutes mathematisches Verständnis sowie gute Kenntnisse in den Bereichen Rechnersicherheit und Netzwerken mitbringen. ', NULL, 'Jonathan Katz and Yehuda Lindell, Introduction to Modern Cryptography, 2008 Lindsay N. Childs, A Concrete Introduction to Higher Algebra. Springer Verlag, 1995. <br>Johannes Buchmann, Einfuehrung in die Kryptographie. Springer Verlag, 1999.<br> Weitere noch zu bestimmende Literatur und Primärquellen.', NULL, 4, 0, '19103601', 71, 1),
(97, 'Zuverlässige Systeme', 'Es wird in die Grundlagen der Zuverlässigkeit und Fehlertoleranz eingeführt (Failure, Fault, Error). Die wichtigsten Fehlertoleranztechniken, spezielle Probleme in verteilten Systemen, Fehlererkennung und die unterschiedlichen Arten von Redundanz werden behandelt. Neben den Techniken zur Entwicklung und Analyse zuverlässiger und fehlertoleranter Systeme werden Methoden und Modelle zur Bewertung der Verlässlichkeit vorgestellt. Dies sind Fehlerbäume, kombinatorische Modelle, sowie Zustandsraum-basierte stochastische Modelle, wie Warteschlangen und Petri-Netze. Für diese Modelle werden analytische, sowie simulative Lösungsverfahren besprochen. Mit Hilfe quantitativer Methoden ist es möglich, verschiedene Systeme zu vergleichen, was sowohl in der Entwurfsphase als auch bei der Verbesserung zuverlässiger Systeme von hoher Bedeutung ist. Die Vorlesung wird von einer Übung begleitet, die aus einzelnen Aufgaben besteht. Ferner gibt es für Interessierte die Möglichkeit, die erworbenen Kenntnisse im Rahmen eines kleinen Projektes anzuwenden.', '', 'B. Haverkort. Performance of Computer Communication Systems - A Model-Based Approach. Wiley.K. Echtle. Fehlertoleranzverfahren, Springer-Verlag, Berlin, 1990 D. P. Siewiorek, R.S. Swarz. Reliable Computer Systems, Digital Press,1992R. Jain. The Art of Computer Systems Performance Analysis: Techniques for Experimental Design, Measurement, Simulation, and Modeling, Wiley- Interscience, 1992. Homepage http://cst.mi.fu-berlin.de/teaching/WS1213/19537-V-ZS/index.html', '<h2>Zielgruppe:</h2>\nStudierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik. \n<h2>Voraussetzungen:</h2>Nicht unbedingt nötig aber hilfreich sind Grundlagen in Stochastik.', 4, 0, '19105501', 72, 1),
(99, 'Modellgetriebene Softwareentwicklung', 'Die Vorlesung beschäftigt sich mit modellgetriebener Softwareentwicklung. Wir werden, auf den bereits erworbenen Kenntnissen der UML aufbauend, zuerst grundlegende Konzepte der Metamodellierung betrachten um uns anschließend dem Bereich der domänenspezifischen Sprachen (DSL ? Domain Specific Languages) zuzuwenden. Wir betrachten den Entwurf und die Implementierung von DSLs im Rahmen des gesamten Softwareentwicklungsprozesses, angefangen von der Motivation, über Konzeption bis hin zu Kodegeneration und Ausführung. Auf der Ebene der Modelle werden wir uns mit Ansätzen der Modellanalyse, wie dem Model Checking, und der Transformation von Modellen beschäftigen. Dabei betrachten wir sowohl Modell-zu-Modell Transformationen, wie die Abbildung eines plattformunabhängigen Modells auf eine konkrete Ausführungsplattform oder verhaltensneutrale Refactorings von Modellen, als auch die Modell-zu-Text Transformation wie sie beispielsweise für die Kodeerzeugung verwendet werden. Der letzte thematische Block der Veranstaltung wird sich mit der Verwendung von Modellen zur Laufzeit beschäftigen. Wir werden uns genauer mit der Interpretation von Verhaltensmodellen auseinander setzen und den Zusammenhang zwischen Strukturmodellen und dynamischen Komponentensystemen näher beleuchten.Die Übungen werden parallel durchgeführt und sollen den theoretisch vermittelten Stoff durch praktische Anwendung der gelernten Konzepte und Ansätze besser verständlich machen. Technisch bauen wir dabei auf Java und dem Eclipse Modelling Framework (EMF) auf.', NULL, 'Tom Stahl, Markus Völter, Sven Efftinge, Arno Haase. Modellgetriebene Softwareentwicklung, 2. Auflage, ISBN-13 978-3-89864-448-8, dPunkt, 2007 - Dave Steinberg, Frank Budinsky, Marcelo Paternostro, Ed Merks. EMF: Eclipse Modeling Framework, 2nd Edition, ISBN-13: 978-0-321-33188-5, Addison-Wesley Professional, 2009- Martin Fowler, Rebecca Parsons. Domain Specific Languages, ISBN-13: 978-0-3217-1294-3, Addison-Wesley, 2010', '<h2>Zielgruppe:</h2>\nStudierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik.   \n\n<h2>Voraussetzungen:</h2>\n Grundlagen der Programmierung. Erfolgreiche Teilnahme an der Veranstaltung "Softwaretechnik".   \n\n<h2>Homepage</h2>\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungModellgetriebeneSoftwareentwicklungWS1213">https://www.inf.fu-berlin.de/w/SE/VorlesungModellgetriebeneSoftwareentwicklungWS1213</a>', 2, 1, '19104001', 73, 1),
(100, 'New Trends in DB', '', '', '', '', 2, 1, '19104401', 74, 1),
(101, 'Datenschutz', 'Hintergrund der Datenschutzdiskussion (USA in den 60er Jahren unter Rückgriff auf Privacy-Diskussion Ende des 19. Jahrhunderts), deutsche Regelungsmodelle in den 70ern- Aktuelle Debatte zur "Überwachungsgesellschaft"- Grundlagen des Datenschutzrechts- Technische Anforderungen- Datenschutz im öffentlichen/nichtöffentlichen Bereich- Betroffenenrechte- Kontrollsystem und Sanktionen- Spezialrechtliche Aspekte (z.B. Sicherheit, Sozialwesen, Telekommunikation, Überwachung am Arbeitsplatz)Prof. Garstka ist der frühere Berliner Datenschutzbeauftragte.', NULL, NULL, NULL, 2, 1, '19103301', 75, 1),
(102, 'Seminar Echtzeitsysteme', 'Ein Echtzeitsystem ist ein informatisches System, dessen Verhalten nicht nur von den Eingaben abhängt, sondern auch von der Zeit. Dieser Zeit ist hier die physikalische Zeit ausserhalb des Systems und eben nicht die logische Zeit, wie sie ein Rechner vorgibt. Daraus ergeben sich für die Entwicklung eines Echtzeitsystems neue Anforderungen und auch Methoden, insbesondere in Bezug auf die Verwaltung von Betriebsmitteln und die Ablaufplanung. Denn nicht nur die Funktionalität ist hier wichtig, vor allem die Vorhersagbarkeit der Zeit von Ereignissen und Berechnungen sind hier wichtig. Auf Grundlage von Lehrbüchern und aktueller Forschungsarbeiten werden in diesem System diese Anforderungen und Methoden erarbeitet und vorgestellt. Zuerst betrachten wir die technische Realisierung in Echtzeitbetriebssystemen und erarbeiten die Methoden für die Ablaufplanung für aperiodische und periodische Aufgaben, sowie die Methoden für Überlastsituationen, in denen die Zeiteigenschaften nicht mehr garantiert werden können. Dann erarbeiten wir die formalen Sprachen und Methoden, mit denen Eigenschaften von Echtzeitsystemen beschrieben und validiert werden', '', '', '', 2, 1, '19106311', 76, 4),
(103, 'Seminar Bildgebende Verfahren in der Medizin', 'Es werden aktuelle Themen aus dem Bereich Bildgebende Verfahren in der Medizin erarbeitet und präsentiert. Dazu zählen Anwendungen aus den Bereichen Radiographie, Computertomographie, Nuklearmedizin, Magnetresonanztomographie und Ultraschallbildgebung ', '', '', '<h2>Zielgruppe</h2>\nStudierende im Masterstudiengang\n<h2>Voraussetzungen</h2>Teilnahme an Vorlesung und Übungen Bildgebende Verfahren in der Medizin Homepage http://www.charite.de/medinfo/Studium/wahllehre.php', 2, 1, '19105911', 77, 4),
(104, 'Seminar : Chipkartentechnologie', 'Das Seminar kann als Vorbereitung für eine Master- oder Diplomarbeit in der AG "Sichere Identität" dienen. Folgende Themen stehen zur Auswahl: Grundlagen, ISO-7816, ISO-14443, Java Card, Chipkartenhardware, Kartenbetriebssysteme, NFC, elektronischer Personalausweis & Reisepass, Gesundheitskarte, Integration in Betriebssysteme (PCSC, CT-API, PKCS11). ', '', 'Handbuch der Chipkarten ISBN-13: 978-3446404021 und individuell zusammengestellte wiss. Veröffentlichungen.', '<h2>Zielgruppe</h2>\nMasterstudenten/Diplomstudenten.\n<h2>Voraussetzungen:</h2>Kenntnisse in Kryptographie.', 2, 1, '19107411', 78, 4),
(105, 'Seminar Vertrauenswürdige Systeme', 'Wir beschäftigen uns mit aktuellen Forschungsthemen im Bereich vertrauenswürdiger Systeme. Dabei verstehen wir vertrauenswürdige Systeme nicht nur als besonders sicherere Systeme, sondern als Systeme deren Funktionsweise transparent und für Benutzer nachvollziehbar ist. Herkömmlicherweise wird oft versucht, Sicherheit von Systemen zulasten einer Einschränkung seiner Benutzer zu etablieren: Im übertragenen Sinne ist das wie der Einsatz von dicken Stahltüren vor einem Banktresor zur Verhinderung von Diebstahl. Obwohl Panzertüren das Vertrauen eines Benutzers in das System Banktresor steigern, gilt der Umkehrschluss nicht. Aus Sicht der Bank gewähren die Stahltüren Sicherheit vor Personen denen sie ? eben nicht ? vertraut. Aus dieser Perspektive heraus ist Vertrauen ein Gegensatz zu Sicherheit: Bei hoher Systemsicherheit wird wenig Vertrauen gebraucht, bei starkem Vertrauen braucht man wenig Systemsicherheit ? Wenn niemand klaut, werden keine abgeschlossenen Türen gebraucht. Unsere Untersuchungen konzentrieren sich dabei auf die Frage, ob man durch geeignete informationstechnische Ansätze die Vertrauenswürdigkeit eines Systems so stärken kann, das restriktive Sicherheitsmechanismen unnötig werden.Auf diesem gedanklichen Fundament bewegen sich auch die zu bearbeitenden Forschungsthemen. Dabei geht es vorwiegend um die Bereiche: - Nachvollziehbarkeit von Informationsflüssen in vernetzten Umgebungen- Automatisierte Einschätzung des Wahrheitsgehalts von Informationen- Belegung der Authentizität von Informationsquellen- Mechanismen zum Aufbau und zur Verwaltung von Bewertungen und Vertrauenswerten- Nachvollziehbarkeit von Systemverwendung- Modellierung und Formalisierung von Vertrauen und Ansehen- Datenschutz und Schutz der Privatsphäre. ', '', 'Aktuelle und themenrelevante Veröffentlichungen im Rahmen von Doktorarbeiten, Fachzeitschriften und Konferenzbänden, beispielsweise:- Jennifer Golbeck (ed.). Computing with Social Trust, Human-Computer Interaction Series, DOI 10.1007/978-1-84800-356-9_1, Springer, 2009- Zaki Malik, Athman Bouguettaya, Trust Management for Service-Oriented Environments, ISBN 978-1-4419-0309-9, Springer, 2009- Karl Krukow. Towards a Theory of Trust for the Global Ubiquitous Computer, PhD Thesis, Department of Computer Science, University of Aarhus, Denmark, 2006- Jonathan M. McCune et al. (eds.). Proceedings of the 4th International Conference on Trust & Trustworthy Computing, Lecture Notes in Computer Science, Vol. 6740, Springer, 2011', 'Die Studierenden sollen zu jeweils einem Thema einen Vortrag auf Deutsch oder Englisch vorbereiten und ihn vor dem Seminar präsentieren. Anschließend findet eine kurze Diskussion zu dem Thema statt. Am Ende des Semesters ist eine schriftliche Ausarbeitung des Themas einzureichen.Es sollen aktuelle Forschungsthemen besprochen werden - als Vorbereitung für Bachelor- und Masterarbeiten nutzbar.\n\n<h2>Zielgruppe:</h2>Studierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. <h2>Voraussetzungen:</h2> Interesse am Thema, Fähigkeit zur eigenständigen Erarbeitung des Stoffs aus wissenschaftlichen Veröffentlichungen. \n<a href="https://www.inf.fu-berlin.de/w/SE/SeminarVertrauenswuerdigeSystemeWS1213">Homepage</a>', 2, 1, '19106911', 79, 4),
(106, 'Seminar : Seminar Opinion Mining and Sentiment Analysis', 'Opinion mining, also called sentiment analysis or sentiment classification is a kind of text classification. Its main task is to automatically obtain the people''s opinions towards certain object which might be a car, a product, a human or anything else. The result of the opinion mining will help not only individuals to decide upon their required object but also helps commercial sectors to improve their products, plans, marketing objectives by taking successful decisions. It also helps the government to improve the effectiveness of their service, and much more. Its importance lies in the fact that it provides the user with the related and the relevant information required automatically without bothering him to deal with a huge number of resulting documents most of which might be unrelated or even unrequited. By taking this seminar, students will learn what exactly the opinion mining and sentiment analysis is, what are the important and related areas that are working in association with opinion mining and sentiment analysis such as information retrieval, information extraction, machine learning classification algorithms and some preprocessing tasks from the area of natural language processing. ', '', '', '<h2>Zielgruppe:</h2> Studenten der Informatik im Master <h2>Voraussetzungen:</h2> Grundlagen des Information Retrievals oder Data Mining sind hilfreich', 2, 1, '19106611', 80, 4),
(107, 'Praktikum : Text-Mining-Toolbox: Verfahren und Werkzeuge zur Textanalyse', '', '', '', '', 2, 1, '19110130', 81, 13),
(109, 'Mustererkennung', 'Bayesche Verfahren der Mustererkennung, Clustering, Expectation Maximization, Neuronale Netze und Lernalgorithmen, Assoziative Netze, Rekurrente Netze. Computer-Vision mit neuronalen Netzen, Anwendungen in der Robotik.', '', 'wird noch bekannt gegeben', 'Grundkenntnisse in Mathematik und Datenstrukturen', 2, 0, '19104201', 82, 1);
INSERT INTO `modulverwaltung_lehrveranstaltung` (`lv_id`, `lv_name`, `lv_inhalt`, `lv_ziel`, `lv_literatur`, `lv_voraussetzung`, `lv_sws`, `lv_anwesenheitspflicht`, `lv_nummer`, `m_id`, `lvt_id`) VALUES
(113, 'Netzbasierte Informationssysteme', 'Der Kurs "Netzbasierte Informationssysteme" vermittelt Wissen über aktuelle Web Technologien und deren Einsatz zur Umsetzung modernen Web-basierter Informationssysteme. Die Vorlesung adressiert folgende vier Themengebiete: - Web Technologien (HTML 5, XML, Client- und Server-seitige Web Anwendungen, Web Services, Semantic Web) - Architektur, Struktur und Zugang zum Web (Web Architekturen, Web Anwendungen, Deep Web, Crawling und Indexing, ... ) - Web Suche (Information Retrieval, Suchmaschinenmethoden, Collaborative Filtering, Text/Web Mining, ...) - Corporate Semantic Web (Semantische Suche, Engineering, Kollaboration, Social-Semantic Web 3.0) In der zugehörigen Übung werden anhand von praktischen Aufgaben diese Web Technologien und Standards praktisch angewandt und die Teilnehmer lernen, wie damit moderne Web-basierte Informationssysteme implementiert werden können. Vorlesung: Dienstag, 14-16 Uhr, Takusstr. 9 SR06Übung: Mittwoch, 14-16 Uhr Takusstr. 9 SR05 ', '', 'Literatur noch nicht erfasst', 'Voraussetzungen Grundkenntnisse in Netzprogrammierung', 2, 0, '19104301', 84, 1),
(114, 'Projektseminar : Projektseminar Datenverwaltungssysteme', 'Entwicklung von Software in kleinen, unabhängigen Teams meist im Kontext von Forschungsvorhaben der Arbeitsgruppe DB&IS. Lesen wissenschaftlicher Literatur und Umsetzung in Sofwarelösungen. Regelmäßige Präsentation der Arbeitsergebnisse und des wissenschaftlichen Hintergrunds. Ein Projektseminar dient als Vorbereitung für eine Masterarbeit.', '', 'Wird jeweils individuell zusammengestellt (wiss. Veröffentlichungen)', '', 3, 1, '19110412', 85, 5),
(115, 'Robotics', '<p>Der humanoide Roboter Myon (siehe <a href="http://www.neurorobotik.de/robots/myon_de.php">Neurorobotik</a>) wird 2015 in einer Bühnenproduktion der Komischen Oper mitwirken. Dafür wird er sehen, hören, sprechen, lernen und sich zielgerichtet bewegen müssen. Um diese Fähigkeiten implementieren zu können, stellt die Vorlesung aktuelle Algorithmen aus den folgenden fünf Themenblöcken vor: 1. Active Vision, 2. Sensomotorische Regelschleifen, 3. Audiosignalverarbeitung, 4. Verhaltensregelung und 5. Lernverfahren. Die vorlesungsbegleitenden Übungen werden zum Teil mit realen Robotern und Versuchsaufbauten durchgeführt. Es werden außer mathematischen Grundkenntnissen der Analysis und linearen Algebra keine speziellen Vorkenntnisse erwartet.</p>', '', '<p>Handbook of Robotics (partially online at Googlebooks) <br>\n  Robotics: modelling, planning and control,  by Bruno Siciliano, Lorenzo Sciavicco, Luigi Villani <br>\n LaValle''s Planning Algorithms <br>\nRobot Modeling and Control  </p>', '<h2>Vorausetzungen:</h2>\n<p>Students interested in robotics and the synthetic approach to artificial intelligence.   As a prerequisite, student should have basic knowledge of maths, in particular linear algebra and a bit of optimization.</p>\n', 2, 0, '19104701', 86, 1),
(117, 'Seminar Datenverwaltung: Location-based Services', ' Location-based services are now often part of every day''s life through applications such as navigation assistants in the public or private transportation domain. The underlying technology deals with many different aspects, such as location detection, information retrieval, or privacy. More recently, aspects such as user context and preferences were considered in order to send users more personalized information. This seminar aims at studying the last trends in location-based services technology. Very important: Registering in advance, attending the first session - as well as *all student talks* during the seminar - is mandatory. Zielgruppe Vertiefung im Gebiet Datenverwaltung. Voraussetzungen Mindestens eine vertiefende Veranstaltung im Bereich Datenverwaltung / Informationssysteme.', '', 'Wird noch bekannt gegeben', '', 2, 1, '19106211', 87, 4),
(118, 'Seminar Data Visualization and Mining', '', '', 'Wird noch bekannt gegeben', '<h2>Zielgruppe:</h2>\nVertiefung im Gebiet Datenverwaltung', 2, 1, '19106011', 88, 4),
(119, 'Seminar : Algorithmen und Technologien im RoboCup', 'Aktuelle Algorithmen und Technologien im RoboCup-Forschungsumfeld werden erarbeitet und vorgestellt. Folgende Themen stehen u.a. zur Auswahl:\n<ul><li>reconstruction of real-world images</li><li>model-free reinforcement learning</li><li>footstep planning for humanoid robots</li><li>object tracking with sparse observations</li><li>multi-agent planning and coordination ', '', 'Je nach Seminarthema', '<h2>Zielgruppe:</h2>Studierende ab dem 5. Semester <h2>Voraussetzungen</h2>Interesse an künstlicher Intelligenz/Robotik', 2, 1, '19107311', 89, 4),
(120, 'Seminar : Expressive Klassische und Nichtklassische Logiken und deren Automatisierung', 'Im Fokus dieses Seminars stehen ausdrucksstarke klassische und nichtklassische Logiken, beispielsweise: Klassische Logik höherer Stufe, Quantifizierte Modallogiken (einschliesslich Temporallogiken), Quantifizierte Konditionale Logiken, Quantifizierte Mehrwertige Logiken, usw. \n\nDiese Logiken sind von grossem Interesse für die Informatik, die Künstliche Intelligenz, die Philosophie und die Computerlinguistik. Ihre Automatisierbarkeit ist allerdings als sehr schwierig einzustufen, was praktische Anwendungen bisher weitgehend ausschloss. \n\nWir werden die Theorie einiger solcher expressiven Logiken skizzieren und aktuelle Fortschritte hinsichtlich ihrer Mechanisierung und Automatisierung diskutieren. \n\nEs ist geplant, dass in diesem Seminar auch verschiedene externe Wissenschaftler Vorträge anbieten.', '', '', '<h2>Zielgruppe:</h2>\nStudenten mit Interesse an Logic und Deduktionssystemen\n<h2>Voraussetzungen:</h2>\nStudenten ab dem 5. Semester, Grundkenntnisse und Logik und theoretischer Informatik \n<br>\nsiehe provisorische <a href="http://page.mi.fu-berlin.de/cbenzmueller/2013-ExLog/">Webseite</a>', 2, 1, '19107511', 90, 4),
(121, 'Seminar : Kalibrierung und Selbstkalibrierung von Sensoren in der Robotik', 'Das Seminar kann als Vorbereitung für eine Bachelor- oder Masterarbeit in dem Forschungsprojekt "Plug and Sense" dienen. Aktuelle Themen aus dem Gebiet der Kalibrierung und Selbstkalibrierung werden erarbeitet und vorgestellt.', '', 'Wird jeweils individuell zusammengestellt (wiss. Veröffentlichungen)', 'Kenntnisse in Computer Vision und/oder Robotik', 2, 1, '19107711', 91, 4),
(122, 'Seminar : Seminar über Programmiersprachen', 'In diesem Seminar werden ausgewählte Konferenz- und Zeitschriftenbeiträge über Programmiersprachen in Einzel- oder Doppelreferaten von Studierenden vorgetragen. Ausgewählte Themen aus den theoretischen und praktischen Grundlagen der Programmiersprachen sowie die wissenschaftliche Fundierung von diversen weniger gängigen Programmierparadigmen wie die Aspektorientierung oder das synchrone Paradigma werden in den Vorträgen behandelt.<br>\n\nIm Anschluss an jedes Referat findet eine ausführliche Diskussion statt, an der sich möglichst alle Teilnehmer beteiligen sollen. Zur Vorbereitung auf diese Diskussion muss allen Teilnehmern eine schriftliche Ausarbeitung des Referats rechtzeitig zur Verfügung gestellt werden.', '', 'wechselnd', 'Homepage: <a href="http://www.inf.fu-berlin.de/lehre/WS13/Sem-Prog/organisation.php">Programmiersprachen</a>', 2, 1, '19106811', 92, 4),
(123, 'Softwareprojekt Mobilkommunikation', 'Das Modul Praktikum Mobilkommunikation gibt Studierenden tiefere Einblicke in einige Bereiche der Mobilkommunikation. Dabei ist eine komplexe Aufgabe, selbstständig durch Entwurf, Implementierung und Testen zu bearbeiten, um die aus den Modulen Telematik und Mobilkommunikation gewonnenen theoretischen Kenntnisse in die Praxis umzusetzen. Das Modul deckt unterschiedliche Schichten des klassischen Kommunikationsnetzes ab: Medienzugriff im drahtlosen Netz; Mobile IP/Mobilität in der Netzwerkschicht; Ad-hoc-Netze; Entwicklung von Anwendungen für und Dienstnutzung auf mobilen Geräten. ', '', 'Literatur noch nicht erfasst', '<a href="http://cst.mi.fu-berlin.de/teaching/WS1213/19517d-SP-Telematics/index.html">Homepage </a>', 4, 1, '19108922', 140, 12),
(124, 'Selbstorganisiertes Softwareprojekt', '', '', '', '', 4, 1, '19109622', 140, 12),
(126, 'Softwareprozesse', 'Diese Veranstaltung vertieft das Wissen über die Gestaltung von Softwareprozessen. Wir sprechen über\n<ul>\n   <li>Prozesse für hochkritische Software ("Cleanroom Software Engineering")</li>\n   <li>Prozesse für Projekte mit unklaren oder schnell veränderlichen Anforderungen ("Agile Methoden")</li>\n   <li>ein für viele Zwecke zuschneidbares Prozessmodell ("V-Modell XT")</li>\n   <li>Prozesse für die verteilte Kollaboration von Freiwilligen ("Open-Source-Entwicklung")</li>\n   <li>Prozessreife und Prozessverbesserung ("CMMI")</li>\n   <li>spezielle Vorgehensweisen dabei ("Messen und Maße")</li>\n   <li>und über ein zentrales Phänomen im Zusammenhang mit Softwarequalität und Produktivität: Fehler und Defekte</li>\n   <li>Ferner besprechen wir die Rolle von Softwarewerkzeugen im Softwareprozess und einen Überblick über taugliche Werkzeuge für die verschiedensten Zwecke.</li>\n</ul>\nDie Teilnehmenden lernen, die Tauglichkeit gewisser Prozessmerkmale für gegebene Zwecke und Situationen zu beurteilen und erwerben somit die Fähigkeit, Softwareprozesse zu analysieren und sinnvolle Verbesserungen vorzuschlagen.   ', '', '', '<h2>Zielgruppe</h2>\r\nStudierende mit Hauptfach Informatik   \r\n\r\n<h2>Voraussetzungen</h2> \r\nGrundkenntnisse in Softwaretechnik   \r\n\r\n<h2>Homepage</h2>\r\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungSoftwareprozesse2013">https://www.inf.fu-berlin.de/w/SE/VorlesungSoftwareprozesse2013</a>', 2, 0, '19104901', 95, 1),
(127, 'Spezielle Aspekte der Datenverwaltung: Spatial Databases', '<strong>ENGLISH:</strong><br>The goal of this course is to acquire the background of spatial databases, the kernel of Geographic Systems. The major aspects that will be handled are: modeling and querying geospatial information, spatial access methods (SAMs), data representation, basic operations (mostly from computational geometry), and optimization. Insights into current applications such as location-based services (e.g., navigation systems) will also be given. Knowledge in databases is necessary. This course encompasses: formal lectures, exercises, as well as a practical project with PostGIS.\n<br>\n<strong>GERMAN:</strong><br>Diese Vorlesung dient der Einführung in raumbezogene Datenbanken, wie sie insbesondere in geographischen Informationssystemen (GIS) Verwendung finden. Schwerpunkte sind u.a. die Modellierung raumbezogener Daten, Anfragesprachen und Optimierung sowie raumbezogene Zugriffsmethoden und Navigationssysteme ("Location-based services"). Grundwissen in Datenbanken ist erforderlich. Die Vorlesung beinhaltet Übungsblätter und Rechnerpraktika mit PostGIS. ', '', 'Handouts are enough to understand the course. The following book will be mostly used:P. Rigaux, M. Scholl, A. Voisard.Spatial Databases - With Application to GIS. Morgan Kaufmann, May 2001. 432 p.(copies in the main library)', '<h2>Zielgruppe:</h2>Studierende im Masterstudiengang. <br>\r\n<h2>Voraussetzungen:</h2>Vorlesung: Einf. in Datenbanksysteme.\r\n<br>\r\n<h2>Sonstiges:</h2> Die Vorlesung wird in englischer Sprache gehalten.', 2, 0, '19104801', 96, 1),
(129, 'Telematik', 'Telematik ist Telekommunikation mit Hilfe von Mitteln der Informatik und befasst sich mit Themen der technischen Nachrichtenübertragung, Rechnernetze, Internet-Techniken, WWW, und Netzsicherheit. Behandelte Themen sind unter anderem folgende: ?Allgemeine Grundlagen: Protokolle, Dienste, Modelle, Standards, Datenbegriff; Nachrichtentechnische Grundlagen: Signale, Codierung, Modulation, Medien; Sicherungsschicht: Datensicherung, Medienzugriff; Lokale Netze: IEEE-Standards, Ethernet, Brücken; Vermittlungsschicht: Wegewahl, Router, Internet-Protokoll (IPv4, IPv6); Transportschicht: Dienstgüte, Flussteuerung, Staukontrolle, TCP; Internet: Protokollfamilie rund um TCP/IP; Anwendungen: WWW, Sicherheitsdienste, Netzwerkmanagement; Konvergenz der Netze: neue Dienste, Dienstgüte im Internet, Multimedia. Voraussetzungen Grundkenntnisse im Bereich Rechnersysteme', '', 'Larry Peterson, Bruce S. Davie: Computernetze - Ein modernes Lehrbuch, dpunkt Verlag, Heidelberg, 2000 Krüger, G., Reschke, D.: Lehr- und Übungsbuch Telematik, Fachbuchverlag Leipzig, 2000 Kurose, J. F., Ross, K. W.: Computer Networking: A Top-Down Approach Featuring the Internet, Addi-son-Wesley Publishing Company, Wokingham, England, 2001 Siegmund, G.: Technik der Netze, 4. Auflage, Hüthig Verlag, Heidelberg, 1999 Halsall, F.: Data Communi-cations, Computer Networks and Open Systems 4. Auflage, Addison-Wesley Publishing Company, Wokingham, England, 1996 Tanenbaum, A. S.: Computer Networks, 3. Auflage, Prentice Hall, Inc., New Jersey, 1996', '', 4, 0, '19105101', 97, 1),
(131, 'Übersetzerbau', 'Ein Übersetzer ist ein Programm, das Programme einer höheren Programmiersprache in eine andere Programmiersprache (im allgemeinen Maschinensprache) überführt. In der Regel erfolgt die Übersetzung in mehreren Phasen, wovon die wichtigsten die lexikalische Analyse, die Syntaxanalyse, die semantische Analyse und die Codeerzeugung sind. Mit Hilfe der lexikalischen und syntaktischen Analyse wird das Quellprogramm in eine computergerechte Repräsentation überführt (abstrakter Syntaxbaum). Diese Repräsentation wird dann als Ausgangspunkt für Optimierungen und Codeerzeugung verwendet. Die hier vorgestellten Verfahren finden an vielen Stellen in der Informatik Anwendung. Deshalb ist dieses Thema auch für solche Hörer von Interesse, die nie vorhaben, einen Übersetzer zu schreiben. Homepage http://www.inf.fu-berlin.de/lehre/WS13/Uebersetzerbau/index.html', '', 'Zur Beschaffung empfohlen: Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman: Compilers - Principles, Techniques , & Tools, Pearson International Edition, 2007 Die deutsche Version wegen Mängel in der Übersetzung nicht so sehr zu empfehlen: Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman: Compiler, Pearson Studium, 2008 Helmut Seidl: Compilerbau, TUM, SS08 Pat D Terry: Compiling with C# and Java, Pearson Education 2005 Reinhard Wilhelm, Dieter Maurer: Übersetzerbau - Theorie, Konstruktion, Generierung, Springer-Verlag, 2. Auflage 1997 Niklaus Wirth: Grundlagen und Techniken des Compilerbaus, 3. Auflage, Oldenbourg-Verlag, 2011', 'Grundkenntnisse in Automatentheorie, Formalen Sprachen, Rechnerorganisation und Programmiersprachen\n<br>\nDie Vorlesung gehört zum Studienbereich "Praktische Informatik" <a href="http://www.inf.fu-berlin.de/lehre/WS13/Uebersetzerbau/index.html">Homepage</a>', 4, 0, '19105201', 98, 1),
(133, 'Seminar Datenbanksysteme: Location and Privacy', 'Anhand von wissenschaftlichen Veröffentlichungen werden aktuelle Themen der Datenbanksysteme vorgestellt und diskutiert. Den jeweiligen thematischen Schwerpunkt kann man der Ankündigung entnehmen', '', 'Wechselnd', '<h2>Voraussetzungen</h2> Grundkenntnisse aus dem Bereich Datenbanksysteme', 2, 1, '19106111', 99, 4),
(134, 'Seminar Netzwerke', '', '', '', '', 2, 1, '19106511', 100, 4),
(136, 'Aktuelle Forschungsthemen der Algorithmik: Advanced Algorithms II', 'Advanced algorithmic techniques for solving hard problems: - Linear Programming techniques - theory: Duality, Farkas Lemma, Simplex, Ellipsoid method, etc. - applications (how to use LP): approximation algorithms, fixed-parameter tractable algorithms, Zero_sum Games, etc. - Integer Programming techniques (Problem modelling, Branch and Bound method, Cutting Planes, etc.) - Fixed-parameter (in)tractablity, exponential time algorithms for graph problems: - bounded search trees - dynamic programming on tree decompositions - graph minors (introduction) - color coding - iterative compression, etc. - Iterative methods, heuristics, etc. Zielgruppe This is a course for graduate students (on the PhD and the master level) working in Computer Science or Discrete Mathematics. Voraussetzungen Prerequisite: Höhere Algorithmik.Participants are expected to have good knowledge in (at least one of): discrete mathematics, graph theory, algorithmic geometry, or general algorithms and complexity. The language of the course is English.', NULL, 'Understanding and Using Linear Programming, J. Matou?ek and B. Gärtner, Springer 2006. Introduction to Linear Optimization, Dimitris Bertsimas, John N. Tsitsiklis, Athena Scientific, 1997. Parameterized Complexity Theory, Flum, Grohe, Springer, 2006. Invitation to Fixed-Parameter Algorithms, Niedermeier Oxford University Press, 2006.', NULL, 2, 0, '19102801', 101, 1),
(137, 'Ausgewählte Themen der Algorithmik: Datenkompression', 'Die wachsende Kapazität von Massenspeichern und Übertragungskapazitäten läuft um die Wette mit steigenden Datenmengen; daher ist Datenkompression nach wie vor ein interessantes Gebiet. \n<br><br>\n<b>Inhalt:</b>\n<ul>\n<li>Theoretische Grundlagen: Informationstheorie, Kolmogoroff-Komplexität. \n</li><li>Verschiedene Arten der Kompression: lustlose und lustbehaftetete, adaptive und progressive \n  Kompression. \n</li><li>Vektorquantisierung. \n</li><li>Kompression für verschiedenartige Daten: "reine" Binärdaten, Text, Bilder, Klänge, Geometrie. \n</li><li>Verschiedene Verfahren: unter anderem effiziente Codes, Wavelets, iterierte Funktionssysteme (IFS), gewichtete Automaten.\n</li></ul>', NULL, NULL, NULL, 4, 0, '19102901', 102, 1),
(139, 'Höhere Algorithmik', '<b>Inhalt:</b> Es werden Themen wie:<br>\n<ul>\n<li>allgemeine Algorithmenentwurfsprinzipien \n</li><li>Flussprobleme in Graphen,  \n</li><li>zahlentheoretische Algorithmen (einschließlich RSA Kryptosystem), \n</li><li>String Matching, \n</li><li>NP-Vollständigkeit \n</li><li>Approximationsalgorithmen für schwere Probleme, \n</li><li>arithmetische Algorithmen und Schaltkreise sowie schnelle Fourier-Transformation\n</li></ul><br>\nbehandelt.', NULL, '<b>Literatur</b>\n<ul><li>Cormen, Leiserson, Rivest, Stein: Introduction to Algorithms, 2nd Ed. McGraw-Hill 2001</li>\n<li>Kleinberg, Tardos: Algorithm Design Addison-Wesley 2005.</li></ul>', '<b>Zielgruppe:</b> alle Masterstudenten und Bachelorstudenten die sich in Algorithmen vertiefen wollen.\n<br>\n<b>Voraussetzungen</b> Grundkenntnisse im Bereich Entwurf und Analyse von Algorithmen ', 4, 0, '19103501', 103, 1),
(141, 'E-Learning-Plattformen', 'E-Learning-Plattformen umfassen Funktionen für Mitglieder- und Gruppenverwaltung, Rollenverwaltung, Gestaltung von Inhaltsbereichen, Tests und Umfragen, synchrone und asynchrone Kommunikation (Mail, Chat, Foren), Datenablage und -austausch und Vieles mehr. Sie bilden damit den Präsenzunterricht ab und implizieren somit auch ein didaktisches Lehr-Lern-Modell. Die Teilnehmer/innen des Kurses werden in verschiedenen E-learning-Plattformen kleine Kurse mit eigenen Inhalten modellieren. Die jeweils anderen Teilnehmer/innen übernehmen dann die Rolle der Lernenden. Unsere Aktivitäten in dem Kurs: Vergleich und Untersuchung aktueller E-Learning-Umgebungen wie Blackboard, ILIAS, FLE, Moodle, Claroline, etc. Aufgabe: Erstellung eines kleinen Kurses in einer dieser Plattformen und Vorbereitung und Durchführung einer Lernphase mit den anderen Teilnehmern. Die Gestaltung, Durchführung und Auswertung dieses eigenen Kurses ersetzt die sonst für die Leistungserbringung übliche schriftliche Ausarbeitung. Alternative Aufgabe: systematische Vorstellung meist einer Lernplattform und ihrer jeweiligen Charakteristika. Einige E-Learning-Plattformen haben komplexe Funktionen z.B. im Bereich der Tests und der Bewertung. Dies können ebenfalls Themen für systematische Vorträge sein. Für solche systematischen Vorträge muss für die Leistungserbringung eine Ausarbeitung vorgelegt werden. Zielgruppe Geeignet für Teilnehmer/innen aller Fachbereiche: Interessenten an multimedialem Web-basiertem Lernen; speziell: Lernkurs-Entwickler, die nach einer Plattform-unabhängigen Autorenumgebung für Web-basiertes Lernen suchen. Dieser Kurs ist Bestandteil des Moduls E-Learning/digitales Video (plus Praktikum) und des Moduls E-Learning (plus Praktikum) des neuen Lehrer-Masters und daher auch für Lehramtstudierende offen.', '', 'Information und Lernen mit Multimedia. L.J.Issing, P.Klimas, Hrsg. Beltz-Verlag. ISBN 3-671-27374-3. (Es gibt eine neuere Ausgabe!) Lernplattformen für das virtuelle Lernen. R.Schulmeister. Oldenbourg-Verlag. ISBN 3-486-27250-0 Homepage http://www.mi.fu-berlin.de/zdm/lectures/lernplatt/', '', 2, 1, '19109920', 104, 10),
(142, 'Projektmanagement', 'Nahezu jeder Absolvent eines Informatikstudiums wird in seiner beruflichen Tätigkeit mit der Organisation von Entwicklungsarbeiten in Projektform in Kontakt kommen und viele der Karrierepfade von Informatikern führen über die Leitung von mehr oder weniger großen Projekten. Für alle der im Rahmen der Projektabwicklung aufretenden Probleme gibt es eine Reihe von Vorgehensweisen und Werkzeugen, die sich in der Praxis als erfolgreich erwiesen haben. Das Project Management Institute (www.pmi.org) hat diese im "Guide to the Project Management Body of Knowledge" (PMBoK Guide) als ANSI-Standard zusammengefasst und in der inzwischen vierten Auflage veröffentlicht. Mit dieser systematischen Vorlage werden in der Vorlesung die einzelnen Prozesse in der Projektabwicklung während des typischen Lebenszyklus eines Projekts behandelt und an Hand von Beispielen aus der Praxis diskutiert.', '', '', '<a href="http://www.inf.fu-berlin.de/lehre/mhorn/PM/">Homepage</a>', 2, 0, '19104501', 105, 1),
(144, 'Existenzgründungen in der IT-Industrie', 'Erfolgreiche Geschäftsmodelle - Goldene Regeln der Existenzgründung - Businessplan - Finanzierung - Rechtsform - Marketing Diese theoretischen Grundlagen werden in Form von Referaten vermittelt. Im praktischen Teil des Kurses entwickeln die Teilnehmer in Teams ein eigenes Geschäftsmodell und formulieren hierfür einen detaillierten Businessplan. Jedes Team stellt seinen Businessplan im Rahmen eines Businessplan-Wettbewerbs mit externen Gutachtern aus der Gründerbranche vor. Der Kurs wird durch Gastvorträge von Praktikern abgerundet. Literatur Miroslaw Malek und Peter K. Ibach, Entrepreneurship, dpunkt.verlag, 2004. Carl Shapiro und Hal R. Varian, Information Rules, Harvard Business School Press, 1998', '', '', '', 1, 1, '19107611', 106, 4),
(145, 'Existenzgründungen in der IT-Industrie', 'Erfolgreiche Geschäftsmodelle - Goldene Regeln der Existenzgründung - Businessplan - Finanzierung - Rechtsform - Marketing Diese theoretischen Grundlagen werden in Form von Referaten vermittelt. Im praktischen Teil des Kurses entwickeln die Teilnehmer in Teams ein eigenes Geschäftsmodell und formulieren hierfür einen detaillierten Businessplan. Jedes Team stellt seinen Businessplan im Rahmen eines Businessplan-Wettbewerbs mit externen Gutachtern aus der Gründerbranche vor. Der Kurs wird durch Gastvorträge von Praktikern abgerundet. Literatur Miroslaw Malek und Peter K. Ibach, Entrepreneurship, dpunkt.verlag, 2004. Carl Shapiro und Hal R. Varian, Information Rules, Harvard Business School Press, 1998', '', '', '', 1, 1, '19107622', 140, 12),
(146, 'Stochastic Models for System Validation', '', '', '', '', 2, 0, '19105001', 107, 1),
(148, 'Wie sicher wollen wir leben? - Sicherheitsforschung im Dialog', 'Das Thema: Öffentliche Sicherheit ist ein Querschnittsthema, dass sowohl in der naturwissenschaftlich-technischen als auch geistes- und sozialwissenschaftlichen Forschung eine hohe Relevanz beinhaltet.\n\nSicherheit ist nicht nur abhängig von unseren Möglichkeiten mit technischen, natürlichen und gesellschaftlichen Bedrohungen und Herausforderungen umzugehen. Sicherheit ist ebenso abhängig von unseren Werten, Wahrnehmungen und Überzeugungen. Veränderungen wie Klimawandel, Globalisierung oder Digitalisierung zeigen, dass sich die Rahmenbedingungen verändert haben und Sicherheit heute eine gesamtgesellschaftliche Aufgabe ist.\n\nWie sicher wollen wir leben? Unter dieser Fragestellung spiegelt die Ringvorlesung das gesamte Spektrum, vom technisch Möglichen bis hin zum gesellschaftlich Akzeptierten wider und diskutiert eine neue Sicherheitskultur.', '', '', '', 2, 0, '19105301', 108, 1),
(149, 'Seminar : Wie sicher wollen wir leben? - Sicherheitsforschung im Dialog', 'Das Thema: Öffentliche Sicherheit ist ein Querschnittsthema, dass sowohl in der naturwissenschaftlich-technischen als auch geistes- und sozialwissenschaftlichen Forschung eine hohe Relevanz beinhaltet.\n\nSicherheit ist nicht nur abhängig von unseren Möglichkeiten mit technischen, natürlichen und gesellschaftlichen Bedrohungen und Herausforderungen umzugehen. Sicherheit ist ebenso abhängig von unseren Werten, Wahrnehmungen und Überzeugungen. Veränderungen wie Klimawandel, Globalisierung oder Digitalisierung zeigen, dass sich die Rahmenbedingungen verändert haben und Sicherheit heute eine gesamtgesellschaftliche Aufgabe ist.\n\nWie sicher wollen wir leben? Unter dieser Fragestellung spiegelt die Ringvorlesung das gesamte Spektrum, vom technisch Möglichen bis hin zum gesellschaftlich Akzeptierten wider und diskutiert eine neue Sicherheitskultur.', '', '', '', 1, 1, '19105311', 108, 4),
(150, 'Computational Network Analysis', '<p>Das World Wide Web basiert auf formal definierten Sprachen und Protokollen, aber erst durch die Nutzung des Webs durch die Erstellung von Webseiten und den Einsatz von Anwendungen wie beispielsweise Blog-Plattformen, Social Networking Services wie Facebook und Twitter, aber auch Wikipedia entsteht der Mehrwert. Dieser Mehrwert basiert auf der Wechselbeziehung von Inhalte, die durch Millionen von Individuen und Organisationen erzeugt und genutzt werden und der zugrundliegenden Technologie.</p>\n<br>\n<p>In dieser Veranstaltung werden Sie die zentralen Konzepte und Ansätze der Analyse von sozialen und Informationsnetzwerken anhand von bestehenden Forschungserkenntnissen kennenlernen. Die praktische Anwendung des Erlernten erfolgt innerhalb eines eigenständigen Projekts..</p>\n<br>\n<p>Wir werden uns unter anderem mit folgenden Themen beschäftigen:.</p><ul>\n<li>- Networke: Basiskonzepte, Definitionen, Modelle<l i="">\n</l></li><li>- Struktur des Webs<l i="">\n</l></li><li>- Community Detection, Modularität und Overlapping Communities<l i="">\n</l></li><li>- Informationsverbreitung in Netzwerken<l i="">\n</l></li><li>- Dynamische Netzwerkanalyse<l i="">\n</l></li></ul>\n<br>\n<p>Im Rahmen des Praktikums werden sich Studierende mit einem Themenbereich aus dem Bereich der Komplexen Netzwerke auseinandersetzen und sich dazu mit bestehenden wissenschaftlichen Artikeln beschäftigen. Unter Nutzung von Beispieldatensätzen werden Studierende sich in ausgewählte Themenbereiche eigenständig einarbeiten. Zum Einsatz sollen dazu vor allem die Programmiersprache und Softwareumgebung R für statistisches Rechnen mit ihren unterschiedlichen Netzwerkbibliotheken als auch die Python Softwarepaket NetworkX kommen.</p>', NULL, NULL, '<h2>Voraussetzungen:</h2>\n<p>Studierende am Ende ihres Bachelorstudium (&gt; 4 Semester) und Studierende im Masterstudiengang Informatik oder aus verwandten Disziplinen (Mathematik, Bioinformatik)</p>\n<h2>Zusätzliche Informationen:</h2><p>Es handelt sich um eine zweiwöchige Blockveranstaltung</p>', 2, 1, '19103130', 109, 13),
(151, 'Computational Network Analysis', '<p>Das World Wide Web basiert auf formal definierten Sprachen und Protokollen, aber erst durch die Nutzung des Webs durch die Erstellung von Webseiten und den Einsatz von Anwendungen wie beispielsweise Blog-Plattformen, Social Networking Services wie Facebook und Twitter, aber auch Wikipedia entsteht der Mehrwert. Dieser Mehrwert basiert auf der Wechselbeziehung von Inhalte, die durch Millionen von Individuen und Organisationen erzeugt und genutzt werden und der zugrundliegenden Technologie.</p>\n<br>\n<p>In dieser Veranstaltung werden Sie die zentralen Konzepte und Ansätze der Analyse von sozialen und Informationsnetzwerken anhand von bestehenden Forschungserkenntnissen kennenlernen. Die praktische Anwendung des Erlernten erfolgt innerhalb eines eigenständigen Projekts..</p>\n<br>\n<p>Wir werden uns unter anderem mit folgenden Themen beschäftigen:.</p><ul>\n<li>- Networke: Basiskonzepte, Definitionen, Modelle<l i="">\n</l></li><li>- Struktur des Webs<l i="">\n</l></li><li>- Community Detection, Modularität und Overlapping Communities<l i="">\n</l></li><li>- Informationsverbreitung in Netzwerken<l i="">\n</l></li><li>- Dynamische Netzwerkanalyse<l i="">\n</l></li></ul>\n<br>\n<p>Im Rahmen des Praktikums werden sich Studierende mit einem Themenbereich aus dem Bereich der Komplexen Netzwerke auseinandersetzen und sich dazu mit bestehenden wissenschaftlichen Artikeln beschäftigen. Unter Nutzung von Beispieldatensätzen werden Studierende sich in ausgewählte Themenbereiche eigenständig einarbeiten. Zum Einsatz sollen dazu vor allem die Programmiersprache und Softwareumgebung R für statistisches Rechnen mit ihren unterschiedlichen Netzwerkbibliotheken als auch die Python Softwarepaket NetworkX kommen.</p>', NULL, NULL, '<h2>Voraussetzungen:</h2>\n<p>Studierende am Ende ihres Bachelorstudium (&gt; 4 Semester) und Studierende im Masterstudiengang Informatik oder aus verwandten Disziplinen (Mathematik, Bioinformatik)</p>\n<h2>Zusätzliche Informationen:</h2><p>Es handelt sich um eine zweiwöchige Blockveranstaltung</p>', 2, 0, '19103101', 109, 1),
(153, 'Anwendungssysteme', '<p>\nDiese Veranstaltung behandelt Auswirkungen der Informatik. Sie will ein Verständnis dafür zu wecken, dass und wie Informatiksysteme in vielfältiger Weise in unser privates und professionelles Leben eingreifen und es erheblich prägen. Viele dieser Wirkungen bergen erhebliche Risiken und benötigen eine bewusste, aufgeklärte Gestaltung, bei der Informatiker/innen naturgemäß eine besondere Rolle spielen -- oder jedenfalls spielen sollten. </p><p>Als Themenbereiche werden wir beispielsweise betrachten, wie die Computerisierung unsere Privatsphäre beeinflusst, Wirtschaft und Gesellschaft im Ganzen, unsere Sicherheit und unser Arbeitsumfeld. Davor steht eine konzeptionelle Einführung, was es bedeutet Orientierungswissen zusätzlich zu Verfügungswissen zu erlangen und wie man damit umgehen sollte: kritisch mitdenken und sich in die Gestaltung der Technik einmischen.</p>', '', '<ul>\n<li>Rob Kling: "Computerization and Controversy: Value Conflicts and Social Choices", 2nd ed., Academic Press 1996</li>\n<li>Sara Baase: "A Gift of Fire: Social, Legal, and Ethical Issues for Computing and the Internet", 3rd ed., Pearson 2009</li></ul>', '<h2>Weitere Informationen:</h2>\n<p>ABV 3-wöchiger Blockkurs in den Semesterferien</p>\n<h2>Voraussetzungen:</h2><p>ALP II oder Informatik B</p>\n<h2>Zielgruppe:</h2>\n<p>Studierende im Bachelor-Studiengang Studierende im lehramtsbezogenen Bachelorstudiengang mit Informatik als Kernfach oder als Zweitfach.</p>\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungAnwendungssysteme2013"><h2>Homepage</h2></a>', 2, 0, '19101301', 110, 1),
(155, 'Softwaretechnik', '<p>Softwaretechnik (oder englisch Software Engineering) ist die Lehre von der Softwarekonstruktion im Großen, also das Grundlagenfach zur Methodik.</p>\n<p>Die Softwaretechnik ist bemüht, Antworten auf die folgenden Fragen zu geben:</p>\n<ul>\n<li>Wie findet man heraus, was eine Software für Eigenschaften haben soll (Anforderungsermittlung)?</li>\n<li>Wie beschreibt man dann diese Eigenschaften (Spezifikation)?</li>\n<li>Wie strukturiert man die Software so, dass sie sich leicht bauen und flexibel verändern lässt (Entwurf)?</li>\n<li>Wie verändert man Software, die keine solche Struktur hat oder deren Struktur man nicht (mehr) versteht (Wartung, Reengineering)?</li>\n<li>Wie deckt man Mängel in Software auf (Qualitätssicherung, Test)?</li>\n<li>Wie organisiert man die Arbeit einer Softwarefirma oder -abteilung, um regelmäßig kostengünstige und hochwertige Resultate zu erzielen (Prozessmanagement)?</li>\n<li>Welche (großenteils gemeinsamen) Probleme liegen allen diesen Fragestellungen zu Grunde und welche (größtenteils gemeinsamen) allgemeinen Lösungsansätze liegen den verwendeten Methoden und Techniken zu Grunde?</li>\n<li> \n</li></ul>\n<p>...und viele ähnliche mehr.</p>\n<p>Diese Vorlesung gibt einen Überblick über die Methoden und stellt essentielles Grundwissen für jede/n ingenieurmäßig arbeitende/n Informatiker/in dar.\n</p><p>Genauere Information siehe Verweis in</p>', '', '<p>Bernd Brügge, Allen Dutoit: Objektorientierte Softwaretechnik mit UML, Entwurfsmustern und Java, Pearson 2004. </p>\n<a href="http://www.inf.fu-berlin.de/w/SE/TeachingHome">\nhttp://www.inf.fu-berlin.de/w/SE/TeachingHome.</a>', '<h2>Weitere Informationen:</h2>\n<p>ABV 3-wöchiger Blockkurs in den Semesterferien</p>\n<h2>Voraussetzungen:</h2><p>ALP III oder Informatik B</p>\n<h2>Zielgruppe:</h2>\n<ul>\n<li>Pflichtmodul im Bachelorstudiengang Informatik </li>\n<li>Wahlpflichtmodul im Nebenfach Informatik </li>\n<li>Studierende im lehramtsbezogenen Masterstudiengang (Großer Master mit Zeitfach Informatik) können dieses Modul zusammen mit dem "Praktikum SWT (19516c)" absolvieren und ersetzen damit die Module "Netzprogrammierung" und "Embedded Internet"   </li>\n</ul>\n<a href="http://www.inf.fu-berlin.de/w/SE/VorlesungSoftwaretechnik2014">\nhttp://www.inf.fu-berlin.de/w/SE/VorlesungSoftwaretechnik2014</a>', 4, 0, '19101401', 111, 1),
(156, 'Professionelle Softwareentwicklung', '', '', '', '', 2, 0, '19110620', 112, 10),
(157, 'Projektseminar : Professionelle Softwareentwicklung', '', '', '', '', 2, 0, '19110612', 112, 5),
(158, 'Forschungspraktikum Indoorlokalisierung', '<div>Die Arbeitsgruppe Technische Informatik beschäftigt sich mit der \nLokalisierung von Personen oder Objekten innerhalb von Gebäuden\ndurch drahtlose Sensornetzwerke. Durch Distanzmessung im 2,4 GHz \nBand über Bestimmung der Funklaufzeiten zwischen einem mobilen, \nzu lokalisierenden Knoten und festen Ankerknoten kann über\nLokalisierungsalgorithmen eine geschätzte Position berechnet werden.\nDa die Signale Reflektionen (multi-path) und Pfadverlusten (path loss) \nunterliegen, ist es von besonderem Interesse sowohl die Hardware als \nauch die Lokalisierungsalgorithmen in verschiedenen Gebäuden unter \nverschiedenen Bedingungen zu testen. Um die Resultate bewerten zu können,\nwird der mobile Knoten während der Datenaufzeichnung auf einem Roboter \nplatziert, welcher den zur Verfügung stehenden Freiraum selbstständig \nund systematisch abfährt. Zu den Fragestellungen zählt sowohl der \nEinfluss des Gebäudeaufbaus als auch die un-/vorteilhafte Platzierung der Ankerknoten.</div>\n<br>\n<div>\nIn diesem Forschungspraktikum sollen zunächst Grundlagen im Umgang mit mobilen Robotern \n(Robot Operating System) und Grundlagen bzw. Eigenschaften der funkbasierten\nIndoorlokalisierung im drahtlosen Sensornetzwerk erlernt werden. Anschließend werden \nselbstständig Experimente in verschiedenen Gebäuden und Szenarien durchgeführt. Die\naufgezeichneten Daten werden analysiert und bewertet. Erfahrungen und Ergebnisse \nwerden zum Abschluss als Präsentationen analysiert und diskutiert.</div>', '', '', '', 2, 1, '19110716', 142, 9),
(159, 'Seminar Technische Informatik', '<div>\nDas Modul Seminar Technische Informatik vertieft anhand von aktueller Forschungsliteratur ein Thema aus dem Bereich der Technischen Informatik. Studierende sollen, basierend auf diversen Forschungsergebnissen und eigenständiger Materialsuche eine 12-15-seitige Ausarbeitung erstellen, welche wissenschaftlichen Ansprüchen an Inhalt und Aufbau genügt. Weiterhin ist ein ca. 30-minütiger Vortrag zu erstellen, der die Kernaussagen der Ausarbeitung weitergibt. Im Rahmen des Seminars werden ebenso Review-Techniken eingeübt, welche die Arbeiten der anderen Teilnehmer bewerten sollen</div>', '', '<p>je nach Thema</p>', '', 2, 1, '19110811', 114, 4),
(160, 'Brückenkurs Mathematische Grundlagen', '<div>Mathematisch-logisches Denken ist eine wichtige Grundlage für die Beschäftigung mit Problemen der Informatik. Da hinsichtlich dieser Voraussetzungen in den letzten Jahren in den Informatik-Anfängervorlesungen einige Defizite deutlich wurden, wendet sich dieser Brückenkursan an alle Studienanfänger der Informatik und Bioinformatik sowie an Studierende mit dem Nebenfach Informatik, die hier noch einen persönlichen Nachholbedarf sehen und sich so besser auf die Informatik-Vorlesungen vorbereiten wollen. Die einzelnen Schwerpunkte des Brückenkurses sind: elementare Mengenlehre, Relationen und Funktionen, logische Grundlagen, Umgang mit mathematischen Formeln und das Verstehen von mathematischen Beweisen.</div>', '', '', '', 2, 1, '19110920', 115, 10),
(161, 'Mathematik für Bioinformatiker', '<div>Aussagenlogik und mathematische BeweistechnikenMengenlehre: Mengen, Relationen, Äquivalenz- und Ordnungsrelationen, FunktionenNatürliche Zahlen und vollständige Induktion, AbzählbarkeitKombinatorik: Abzählprinzipien, Binomialkoeffizienten und Stirling-Zahlen, Rekursion, SchubfachprinzipLineare Algebra: Vektorraum, Basis und Dimension; lineare Abbildung, Matrix und Rang; Gauss-Elemination und lineare Gleichungssysteme; Determinanten, Eigenwerte und Eigenvektoren; Euklidische Vektorräume und Orthonormalisierung; Hauptachsentransformation;Anwendungen der linearen Algebra in der affinen Geometrie Zielgruppe Studierende der Bioinformatik im 1. Semester.</div>', '', '', '', 4, 0, '19000001', 116, 1),
(164, 'Informatik A', '<div>Im Mittelpunkt stehen zunächst der Begriff des Algorithmus und der Weg von der Problemstellung über die algorithmische Lösung zum Programm. Anhand zahlreicher Beispiele werden Grundprinzipien des Algorithmenentwurfs erläutert. Die Implementierung der Algorithmen wird verbunden mit der Einführung der funktionalen Programmiersprache Haskell. Im Weiteren werden die theoretischen, technischen und organisatorischen Grundlagen von Rechnersystemen vorgestellt. Dabei werden die Themen Binärdarstellung von Informationen im Rechner, Boolesche Funktionen und ihre Berechnung durch Schaltnetze, Schaltwerke für den Aufbau von Prozessoren und das von- Neumann-Rechnermodell behandelt. </div>', '', '<ul>\n<li>S. Thompson; Haskell: The Craft of Functional Programming; Addison-Wesley\n</li><li>F. Rabhi, G. Lapalme; Algorithms: A Functional Proramming Approach; Addison-Wesley\n</li><li>G. Hutton; Programming in Haskell; Cambridge University Press\n</li><li>A. Tanenbaum, J. Goodman; Computerarchitektur; Pearson Studium\n</li></ul>', '<h2>Voraussetzungen:</h2>\n<p>Zur Vorbereitung wird der Besuch des Brückenkurses Mathematische Grundlagen für Informatik, Bioinformatik und Nebenfach Informatik empfohlen. </p>\n<h2>Zusätzliche Informationen</h2>\n<p>Freischaltung der Anmeldung zu Tutorien wird rechtzeitg bekanntgegeben</p>', 4, 0, '19111001', 117, 1),
(165, 'Forschungsseminar Theoretische Informatik (Mittagsseminar)', '<p>Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus der Theoretischen Informatik, insbesondere Algorithmen</p>', '', '', '', 2, 1, '19111116', 142, 9),
(166, 'Forschungsseminar Programmiersprachen', '<p>Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus dem Bereich Programmiersprachen</p>', '', '', '', 2, 1, '19111216', 142, 9),
(167, 'Planung, Durchführung und Analyse eines Tutoriums', '<p>In einem vorbereitenden Kolloquium werden aktuelle Unterrichtsmethoden für Tutorien zur Mathematik und Informatik vorgestellt und diskutiert. Anschließend findet noch während der Semesterferien ein Vorstellungsgespräch mit dem Tutorenauswahlausschuss statt, in dem die Eignung als Tutor festestellt wird. Nach erfolgreicher Eignungsfeststellung wird ein Tutorium zu einer selbst gewählten Veranstaltung des Pflichtbereichs vorbereitet, durchgeführt, dokumentiert und analysiert.</p>', '', '<p>\neifert, J. W.: Visualisieren Präsentieren Moderieren. GABAL Verlag, 16. Auflage 2001 Informationen für Studenten Bitte wenden Sie sich direkt an den zuständigen Tutorenauswahlbeauftragten: Herrn Heindorf für die Mathematik bzw. Herrn Hoffmann für die Informatik. </p>\n', '<h2>Zusätzliche Informationen</h2>\n<p>Vorbesprechung am Do, 16. 7. um 14:00 im Raum 159, Takustr. 9</p>', 2, 1, '19111351', 120, 20),
(168, 'Planung, Durchführung und Analyse eines Tutoriums', '<p>In einem vorbereitenden Kolloquium werden aktuelle Unterrichtsmethoden für Tutorien zur Mathematik und Informatik vorgestellt und diskutiert. Anschließend findet noch während der Semesterferien ein Vorstellungsgespräch mit dem Tutorenauswahlausschuss statt, in dem die Eignung als Tutor festestellt wird. Nach erfolgreicher Eignungsfeststellung wird ein Tutorium zu einer selbst gewählten Veranstaltung des Pflichtbereichs vorbereitet, durchgeführt, dokumentiert und analysiert.</p>', '', '<p>\neifert, J. W.: Visualisieren Präsentieren Moderieren. GABAL Verlag, 16. Auflage 2001 Informationen für Studenten Bitte wenden Sie sich direkt an den zuständigen Tutorenauswahlbeauftragten: Herrn Heindorf für die Mathematik bzw. Herrn Hoffmann für die Informatik. </p>\n', '<h2>Zusätzliche Informationen</h2>\n<p>Vorbesprechung am Do, 16. 7. um 14:00 im Raum 159, Takustr. 9</p>', 2, 1, '19111320', 120, 10),
(169, 'Softwareprojekt Praktische Informatik A', '', '', '', '', 4, 1, '19111422', 140, 12),
(170, 'Seminar Collaborative and Social Computing', '<p>Das Ziel dieses Seminars ist es Studierenden ein Verständnis für bestehende Anwendungen im Bereich Social and Collborative Computing als auch Einsichten zu bestehenden Technologien zu vermitteln. Die Besonderheit dieser Anwendungen besteht darin, dass sich ihr Mehrwert nicht durch den alleinigen Einsatz bestimmter Algorithmen ergibt, sondern erst durch deren umfassende Nutzung durch Menschen. Diese Wechselbeziehung zwischen Menschen und digitalen Artefakten führt häufig zu emergenten Eigenschaften des sozio-technischen Systems. Um nun diese Eigenschaften offenzulegen und zu verstehen ist eine gleichzeitige Betrachtung der Technologie und der menschlichen Interaktionen erforderlich. Der Bereich Social and Collaborative Computing hat sich in den letzten Jahren umfassend geändert. Anwendungen wie Wikipedia, Facebook, Twitter, Mechanical Turk oder Flickr bieten eine umfangreiches Repertoire an Interaktions¬modalitäten im täglichen Leben, aber auch im Unternehmens- und Bildungsbereich. In diesem Seminar werden wir uns mit diesen Anwendungsbereichen, aber auch ausgewählten Algorithmen zur ?Steuerung? der Mensch-Maschine-Interaktion auseinandersetzen. Die wissenschaftliche Basis der gestellten Fragen rekrutiert sich vor allem aus dem Bereich CSCW (Computer Supported Cooperative Work) und angrenzenden Bereichen wie beispielweise Data Mining und Human Computer Interaktion. In diesem Seminar erarbeiten sich Studierende die einzelnen Themen anhand von wissenschaftlichen Artikeln. Die zentralen Erkenntnisse aus diesen Artikeln werden innerhalb des Seminars präsentiert und diskutiert. Die im Laufe des Semesters gesammelten Erkenntnisse werden innerhalb eines Forschungsartikels zusammengefasst. Jede Woche werden wir uns mit einem ausgewählten Thema aus diesem Bereich auseinandersetzen, welches alle drei Perspektiven (Konzepte, Anwendungsbereiche, Technologien) behandelt. Am Ende dieser Veranstaltung sollten Studierende über folgende Kompetenzen verfügen: - Beschreiben und erklären von zentralen Konzepten in diesem Bereich, wie beispielsweise Human Computation, Crowdsourcing, Kollektive Intelligenz, Koordination, Communities of Practice - Beschreiben und vergleichen von Anwendungen im Bereich Social and Collborative Computing - Beschreiben und diskutieren der technologischen Entwicklungen im Bereich Social and Collborative Computing in den letzten Jahren - Rekonfiguren von Konzepte und Technologien aus dem Bereich Social and Collborative Computing und entwickeln von neuen Lösungen</p>', '', '', '', 2, 1, '19111511', 122, 4),
(171, 'Seminar Moderne Web-Technologien', '', '', '', '', 2, 1, '19111611', 123, 4),
(172, 'Arbeits- und Lebensmethodik', 'Wir werden in diesem Kurs gemeinsam die Fragen beleuchten, die über ein erfolgreiches Arbeiten in Studium und Beruf und ebenso über den Erfolg und die Zufriedenheit im privaten Leben entscheiden. Dies sind meistens weniger technische Fertigkeiten als vielmehr Fragen der Persönlichkeit: Zielstrebigkeit, Selbstbewusstsein, Fähigkeit zu Konzentration und Entspannung, Entscheidungsfähigkeit, klare Kommunikation, Selbstbild, Motivation, Durchhaltevermögen. Ziel dieses Kurses ist es, Anstöße zur und erste Fortschritte bei der gezielten und selbstgetriebenen Persönlichkeitsentwicklung zu geben. Es wird ferner erklärt, wie und warum große Teile der oft als "soft skills" bezeichneten Fertigkeiten sich fast von alleine einstellen, wenn man die obigen Fähigkeiten entwickelt.Dieser Kurs ist ein Seminar im ursprünglichen Sinne: Eine hauptsächlich als Diskussion verlaufende Veranstaltung, in der jede/r Beteiligte etwas selbst erforscht (in diesem Fall das eigene Verhalten). Das Format ist jedoch vollkommen anders als unter dem Titel "Seminar" sonst in der Informatik gewohnt: Es gibt keine Themenzuweisung, keine Vorträge, keine Ausarbeitungen. Es geht um Bildung, nicht um Ausbildung.', '', '', '<p>Die Teilnehmerzahl ist beschränkt; vorherige Anmeldung ist erforderlich.</p><br>\n<p>\nIch erwarte von allen Teilnehmern eine offene und engagierte Mitarbeit. Die Veranstaltung benötigt nur einen moderaten Zeitaufwand, aber einen erheblichen Einsatz von Willenskraft.</p>', 3, 1, '19111720', 124, 10),
(173, 'Kurs und Praxisseminar Professionelle Softwareentwicklung ', '', '', '', '', 2, 1, '19111813', 125, 6),
(174, 'Kurs und Praxisseminar Professionelle Softwareentwicklung ', '', '', '', '', 2, 1, '19111820', 125, 10),
(175, 'Seminar Künstliche Intelligenz', '', '', '', '', 2, 1, '19111911', 126, 4),
(176, 'Softwareprojekt Künstliche Intelligenz', '', '', '', '', 4, 1, '19112022', 140, 12),
(177, 'Betriebssysteme', '', '', '', '', 4, 0, '19112101', 128, 1),
(179, 'Softwareprojekt Bildverarbeitung in der Verhaltensbiologie', '', '', '', '', 4, 1, '19112222', 140, 12),
(180, 'Forschungsseminar Intelligente Systeme und Robotik', '', '', '', '', 2, 1, '19112316', 142, 9),
(181, 'New Algorithms for Big Data', '<h2>Abstract:</h2><p>\nIn many modern workflows the data one deals with no longer fits in the memory of a single node, or arrives incrementally over time and is usually noisy/uncertain and typically it is all these cases. This course deals with the development and analysis of algorithms for dealing with such Big Data workflows.</p><br>\n\n<p>We will look into:</p>\n<ul>\n<li>sketching</li>\n<li>streaming</li>\n<li>dimensionality reduction</li>\n<li>big matrix algorithms</li>\n<li>sparse signals</li>\n<li>map-reduce</li>\n<li>Resilient distributed datasets</li>\n<li>random walks</li><li></ul>\n\n<p>Unlike my other courses, this one will be more theoretical but also involve hands-on programming exercises.</p>', '', '', '<h2>Prerequisites:</h2>\n<p>Must have taken Algorithms and Databases.</p>', 2, 1, '19112420', 131, 10),
(182, 'Softwareprojekt: Identifikation und Autorisierung', NULL, NULL, NULL, NULL, 4, 1, '19112622', 140, 12),
(183, 'Softwareprojekt: User-Centric High Entropy HyperText Documents', NULL, NULL, NULL, NULL, 4, 1, '19112722', 140, 12);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_lv_typ`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_lv_typ` (
  `lvt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lvt_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lvt_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`lvt_id`),
  UNIQUE KEY `lvt_kuerzel` (`lvt_kuerzel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=25 ;

--
-- Daten für Tabelle `modulverwaltung_lv_typ`
--

INSERT INTO `modulverwaltung_lv_typ` (`lvt_id`, `lvt_name`, `lvt_kuerzel`) VALUES
(1, 'Vorlesung', '01'),
(2, 'Übung', '02'),
(3, 'Proseminar', '10'),
(4, 'Seminar', '11'),
(5, 'Projektseminar', '12'),
(6, 'Praxisseminar', '13'),
(7, 'Oberseminar', '14'),
(8, 'Hauptseminar', '15'),
(9, 'Forschungsseminar', '16'),
(10, 'Kurs', '20'),
(11, 'Brückenkurs', '21'),
(12, 'Projektkurs', '22'),
(13, 'Praktikum', '30'),
(14, 'Laborpraktikum', '31'),
(15, 'Forschungspraktikum', '32'),
(16, 'Repetitorium', '40'),
(17, 'Mentorium', '41'),
(18, 'Workshop', '42'),
(19, 'Einführung', '50'),
(20, 'Colloquium', '51'),
(21, 'Exkursion', '52'),
(22, 'Verschiedenes', '99'),
(23, 'Zusatzvorlesung', '60'),
(24, 'Zusatzübung', '61');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul` (
  `m_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `m_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `m_inhalt` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `m_ziel` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `m_literatur` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `m_voraussetzung` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `m_lvNummer` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `m_typ` bigint(10) DEFAULT NULL COMMENT 'GIbt an ob es sich um eine Pflichtveranstaltung handelt ',
  `sp_id` bigint(20) NOT NULL,
  `mk_id` bigint(20) NOT NULL,
  `m_geaendert_am` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`m_id`),
  KEY `sp_id` (`sp_id`,`mk_id`),
  KEY `mk_id` (`mk_id`),
  KEY `sp_id_2` (`sp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=144 ;

--
-- Daten für Tabelle `modulverwaltung_modul`
--

INSERT INTO `modulverwaltung_modul` (`m_id`, `m_name`, `m_inhalt`, `m_ziel`, `m_literatur`, `m_voraussetzung`, `m_lvNummer`, `m_typ`, `sp_id`, `mk_id`, `m_geaendert_am`) VALUES
(3, 'Objektorientierte Programmierung', '								<ul>\r\n  <li>Grundlagen der Berechenbarkeit: \r\n    <ul>\r\n      <li>Universelle Registermaschinen </li>\r\n      <li>Syntax und operationelle Semantik imperativer Programmiersprachen</li>\r\n    </ul>\r\n  </li>\r\n  <li>Formale Verfahren zur Spezifikation und Verifikation imperativer\r\n    Programme: \r\n    <ul>\r\n      <li>Bedingungen auf dem Zustandsraum (assertions), </li>\r\n      <li>Hoare-Kalkül, partielle Korrektheit, Termination </li>\r\n    </ul>\r\n  </li>\r\n  <li>Konzepte imperativer und objektorientierter Programmierung (Java): \r\n    <ul>\r\n      <li>Primitive und Zusammengesetzte Datentypen, </li>\r\n      <li>Methoden (Prozeduren und Funktionen), Parameterübergabe, Überladung\r\n      </li>\r\n      <li>Module, Klassen, Objekte </li>\r\n      <li>Klassenhierarchien, Vererbung, Polymorphie</li>\r\n      <li>Abstrakte Klassen, Schnittstellen </li>\r\n    </ul>\r\n  </li>\r\n  <li>Programmiermethodik: \r\n    <ul>\r\n      <li>schrittweise korrekte Programmentwicklung </li>\r\n      <li>Teile und Herrsche </li>\r\n      <li>Backtracking </li>\r\n    </ul>\r\n  </li>\r\n  <li>Analyse von Laufzeit und Speicherbedarf: \r\n    <ul>\r\n      <li>O-Notation </li>\r\n      <li>Umwandlung von Rekursion in Iteration </li>\r\n      <li>Analyse von Such- und Sortieralgorithmen </li>\r\n      <li>Algorithmen, Datenstrukturen, Datenabstraktion</li>\r\n    </ul>\r\n  </li>\r\n</ul>\r\n			\r\n			\r\n			', '', '<ul>\r\n<li>Concepts of Programming Languages, Robert Sebesta, Pearson Education , 10th Edition, 2012, ISBN: 0131395319</li>\r\n<li>Data Structures &amp; Problem Solving Using Java, Mark Allen Weiss, Addison Wesley, 4. Auflage, 2010, ISBN: 0-321-54140-5</li> \r\n<li> Cormen, Leiserson, Rivest: Introduction to Algorithms, 3. Auflage 2009, </li> \r\n<li>Bundle of algorithms in java, third edition, parts 1-5. Sedgewick Robert und Michael Schidlowsky. Addison-Wesley Longman, Amsterdam. 2003.</li>\r\n</ul>', '				\r\n				\r\n				<h3>Voraussetzungen</h3><p>Kenntnisse aus ALP I sind nützlich, der Schein dazu ist aber nicht zwingend\r\nerforderlich.</p>\r\n			\r\n			\r\n			\r\n			', '086bA1.2', 1, 1, 1, '2014-05-04 12:27:02'),
(4, 'Nichtsequentielle Programmierung', '<h3>Inhalt</h3>\r\n<p>Programmierung und Synchronisation nebenl&auml;ufiger Prozesse, die auf gemeinsame Daten zugreifen oder &uuml;ber Nachrichten miteinander kommunizieren (Referenzsprache: Java):</p>\r\n<ul>\r\n<li>Nichtsequentielle Programme und Prozesse in ihren verschiedenen Auspr&auml;gungen (Prozess, Thread, ?), Nichtdeterminismus</li>\r\n<li>Programmierung und Prozesse</li>\r\n<li>Synchronisationsmechanismen wie Sperren, Monitore, Wachen, Ereignisse, Semaphore</li>\r\n<li>Nebenl&auml;ufigkeit und Objektorientierung</li>\r\n<li>Ablaufsteuerung, Auswahlstrategien, Umgang mit Verklemmungen</li>\r\n<li>Implementierung, Mehrprozessorsysteme, Koroutinen</li>\r\n<li>Interaktion &uuml;ber Nachrichten</li>\r\n</ul>', NULL, '<ul>\r\n<li>G.R. Andrews.: Foundations of multithreaded, parallel and distributed programming. Addison-Wesley, 2000.</li>\r\n<li>G. Taubenfeld: Synchronisation Algorithms and Concurrent Programming. Prentice Hall, 2006.</li>\r\n<li>M. Ben-Ari: Principles of Concurrent and Distributed Programming (Second Edition). Addison-Wesley, 2006.</li>\r\n<li>B. Goetz, T. Peierls, J. Bloch, et.al.: Java Concurrency in Practice, Addison-Wesley, 2006.</li>\r\n<li>Lea, D.: Concurrent Programming in Java (2. ed.). Addison-Wesley, 1999 Homepage http://lms.fu-berlin.de/</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<ul>\r\n<li>Studierende im Bachelorstudiengang Informatik</li>\r\n<li>Studierende im Hauptstudium des Diplomstudiengangs Informatik</li>\r\n<li>Studierende im Lehramtsmaster (Gro&szlig;er Master, Zweitfach Informatik) k&ouml;nnen dieses Modul als Ersatz f&uuml;r "Gemeinsames Modul</li>\r\n<li>Netzprogrammierung" zusammen mit dem Begleitpraktikum "Praktikum zu NSP (19513c) absolvieren.</li>\r\n</ul>\r\n<h3>Voraussetzungen</h3>\r\n<p>Kenntnisse aus ALP II, ALP III und MafI I</p>', '086bA1.4', 1, 1, 1, '2014-05-08 11:54:55'),
(6, 'Rechnerarchitektur', '<h3>Inhalt</h3>\r\n<p>Das Modul Rechnerarchitektur behandelt grundlegende Konzepte und Architekturen von Rechnersystemen. Themenbereiche sind hier insbesondere Von-Neumann-Rechner, Harvard-Architektur, Mikroarchitektur RISC/CISC, Mikroprogrammierung, Pipelining, Cache, Speicherhierarchie, Bussysteme, Assemblerprogrammierung, Multiprozessorsysteme, VLIW, Sprungvorhersage. Ebenso werden interne Zahlendarstellungen, Rechnerarithmetik und die Repr&auml;sentation weiterer Datentypen im Rechner behandelt.</p>', NULL, '<ul>\r\n<li>Andrew S. Tannenbaum: Computerarchitektur, 5.Auflage, Pearson Studium, 2006</li>\r\n<li>English: Andrew S. Tanenbaum (with contributions from James R. Goodman):</li>\r\n<li>Structured Computer Organization, 4th Ed., Prentice Hall International, 2005.</li>\r\n</ul>', NULL, '086bA2.2', 1, 1, 2, '2014-05-08 12:00:01'),
(7, 'Praktikum Technische Informatik', '<h3>Inhalt</h3> \r\n<p>Das Modul Praktikum Technische Informatik vertieft mit zahlreichen praktischen Übungen das in den Modulen Rechnerarchitektur und Betriebs- und Kommunikationssysteme Erlernte. Aufbauend auf einer einfachen Hardwareplattform mit Prozessor und diversen Schnittstellen sollen die Teilnehmer elementare Treiber programmieren, Betriebssystemroutinen erweitern und die Schnittstellen ansteuern lernen. Anschließend sollen die Systeme vernetzt werden und mit ihrer Umwelt in Interaktion treten können. </p>', NULL, NULL, NULL, '086bA2.4', 1, 1, 2, '2014-05-08 12:01:43'),
(8, 'Grundlagen der theoretischen Informatik', '<h3>Inhalt:</h3>\r\n\r\n<ul>\r\n  <li>Theoretische Rechnermodelle </li>\r\n    <ul>\r\n      <li>Automaten</li>\r\n      <li>formale Sprachen</li>\r\n      <li>Grammatiken und die Chomsky-Hierarchie</li>\r\n      <li>Turing-Maschinen</li>\r\n      <li>Berechenbarkeit</li>\r\n  </ul>\r\n  <li>Einführung in die Komplexität von Problemen</li>\r\n</ul>', '1', '<ul>\r\n<li>Uwe Schöning, Theoretische Informatik kurzgefasst, 5. Aufl, Spektrum Akademischer Verlag, 2008</li>  \r\n<li>John E. Hopcroft, Rajeev Motwani, Jeffrey D. Ullman, Einführung in die Automatentheorie, Formale Sprachen und Komplexität, Pearson Studium, 2.Auflage, 2002</li>\r\n<li>Ingo Wegener: Theoretische Informatik - \r\n  Eine algorithmenorientierte Einführung, 2. Auflage, Teubner, 1999</li> \r\n<li>Michael Sipser, Introduction to the Theory of Computation, 2nd ed., \r\nThomson Course Technology, 2006</li>\r\n<li>Wegener, Kompendium theoretische Informatik - Eine Ideensammlung, Teubner 1996</li> \r\n</ul>', '<h3>Website</h3>\r\n<a href="http://www.inf.fu-berlin.de/lehre/SS14/GTI/"> http://www.inf.fu-berlin.de/lehre/SS14/GTI</a>', '086bA3.1', 1, 1, 3, '2014-05-08 12:04:16'),
(9, 'Datenbanksysteme', '<h3>Inhalt</h3>\r\n<p>Datenbankentwurf mit ER / UML. Theoretische Grundlagen Relationaler Datenbanksysteme: relationale Algebra, Funktionale Abhängigkeiten, Normalformen. Relationale Datenbankentwicklung: SQL Datendefinition, Fremdschlüssel und andere Integritätsbedingungen. SQL als applikative Sprache: wesentliche Sprachelemente, Einbettung in Programmiersprachen, Anwendungsprogrammierung; objekt-relationale Abbildung. Sicherheits- und Schutzkonzepte.</p>\r\n<p>Technik: Transaktionsbegriff, transaktionale Garantien, Synchronisation des Mehrbenutzerbetriebs, Fehlertoleranzeigenschaften. Anwendungen und neue Entwicklungen: Data Warehouse-Technik, Data-Mining, Information Retrieval / Suchmaschinen. Im begleitenden Projekt werden die Themen praktisch vertieft.</p>', NULL, '<ul>\r\n<li>Alfons Kemper, Andre Eickler: Datenbanksysteme - Eine Einführung, 5. Auflage, Oldenbourg 2004</li>\r\n<li>R. Elmasri, S. Navathe: Grundlagen von Datenbanksystemen, Pearson Studium, 2005</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<ul>\r\n<li>Pflichtmodul im Bachelorstudiengang Informatik</li>\r\n<li>Pflichtmodul im lehramtsbezogenen Bachelorstudiengang mit Kernfach Informatik und Ziel: Großer Master</li>\r\n<li>Studierende im lehramtsbezogenen Masterstudiengang (Großer Master mit Zeitfach Informatik) können dieses Modul zusammen mit dem "Praktikum DBS (19515c)" absolvieren und ersetzen damit die Module "Netzprogrammierung" und "Embedded Internet"</li>\r\n<li>Wahlpflichtmodul im Nebenfach Informatik</li>\r\n</ul>\r\n\r\n<h3>Voraussetzungen</h3>\r\n<p>"Datenstrukturen und Datenabstraktion"  oder  "Informatik B"</p>', '086bA3.3', 1, 1, 3, '2014-05-08 12:06:52'),
(10, 'Analysis', '<h3>Inhalt:</h3>\r\n<ul>\r\n  <li>Aufbau der Zahlenbereiche von den natürlichen bis zu den reellen Zahlen,        Vollständigkeitseigenschaft der reellen Zahlen</li>   \r\n   <li>Polynome, Nullstellen und Polynominterpolation</li>  \r\n   <li>Exponential- und Logarithmusfunktion, trigonometrische Funktionen</li>   \r\n   <li>Komplexe Zahlen, komplexe Exponentialfunktion und komplexe Wurzeln</li>  \r\n   <li>Konvergenz von Folgen und Reihen, Konvergenz und Stetigkeit von Funktionen,         O-Notation</li>\r\n   <li>Differentialrechnung: Ableitung einer Funktion, ihre Interpretation und          Anwendungen</li>\r\n   <li>Intergralrechnung: Bestimmtes und unbestimmtes Integral, Hauptsatz der         Differential- und Intergralrechnung, Anwendungen</li>\r\n   <li>Potenzreihen</li>   \r\n</ul>', NULL, '<ul>\r\n<li>Kurt Meyberg, Peter Vachenauer: Höhere Mathematik 1, \r\n  Springer-Verlag, 6. Auflage 2001 \r\n<li>Dirk Hachenberger: Mathematik für Informatiker, Pearson 2005\r\n<li>Gerhard Berendt: Mathematische Grundlagen der Informatik, Band 2, \r\nB.I.-Wissenschaftsverlag; 1990 \r\n<li>Thomas Westermann: Mathematik für Ingenieure mit Maple 1, Springer-Verlag, 4. Auflage 2005\r\n</ul>', NULL, '086bA4.2', 1, 1, 4, '2014-05-08 12:08:31'),
(11, 'Rechnersicherheit', '<h3>Content</h3>\r\n<p>This course motivates the need for computer security and introduces central concepts of computer security such as security objectives, threats, threat analysis, security policy and mechanism, assumptions and trust, and assurance.</p>\r\n<p>We discuss authentication mechanisms, followed by various security models and show which security related questions can be answered in these models. The models we discussed include the Access Control Matrix Model, the Take-Grant Protection Model, the Bell-LaPadula and related models, the Chinese Wall Model, the Lattice Model of Information Flow.</p>\r\n<p>Subsequently, we cover principles of security architectures and go through design approaches for secure systems e.g., capability based systems and hardware rotection mechanism concepts such as protection rings.  Based on the learned, we may look at selected case studies of existing systems.</p>\r\n<p>In the remainder of the course, we cover exploitation techniques for specific implementation vulnerabilities such as race conditions, stack and heap overflows, integer overflows, and return oriented programming.  We continue with a discussion of insider threats, insider recruitment and social engineering attacks.</p>\r\n<p>If time permits, we continue to look at the problems that arise when humans interface with security e.g., password habits and password entry mechanisms, human responses to security prompts, incentives and distractors for better security, or reverse Turing tests.</p>', NULL, NULL, NULL, '086bA5.1', 2, 1, 5, '2014-05-08 17:26:35'),
(12, 'Computergrafik', '<h3>Inhalt</h3>\r\n<ul>\r\n<li>Mathematische Grundlagen der Computergrafik,</li>\r\n<li>Darstellung von 3d Szenen im Rechner,</li>\r\n<li>geometrische Transformationen, Projektionen auf die Bildebene,</li>\r\n<li>Bestimmung sichtbarer Flaechen, Beleuchtungsmodelle,</li>\r\n<li>Ray-Tracing,</li>\r\n<li>Radiosity,</li>\r\n<li>Animation</li>\r\n</ul>', NULL, '<ul>\r\n<li>Computer Graphics (2nd Edition C Version). D. Hearn, M.P. Baker, Prentice-Hall, 1997.  </li> \r\n<li>Computer Graphics - Principles and Practice (2nd Edition in C). \r\nJ.D. Foley, A. Van-Dam, S.K. Feiner and J.F. Hughes. Addison-Wesley, 1996   </li>\r\n<li>Interactive Computer Graphics (4th Edition).E. Angel, Addison-Wesley, 2006  </li>\r\n\r\n<li>OpenGL Programming Guide: The Official Guide to Learning OpenGL, Version 2.1.D. Shreiner, M. Woo, J. Neider, T. Davis, Addison-Wesley, 2007    </li>\r\n</ul>', 'B.Sc.-Studierende ab 5. Semester, M.Sc.-Studierende in Informatik, Mathematik, Physik o.ä., ', '089bA1.3', 3, 1, 1, '2014-05-08 17:26:35'),
(13, 'Empirische Bewertung in der Informatik', '<h3>Inhalt</h3>\r\n<p>\r\nDas Modul behandelt zunächst die Rolle empirischer Untersuchungen für den Informationsgewinn in der Forschung und Praxis der Informatik und stellt dann generisch das Vorgehen bei empirischen Untersuchungen vor (mit den folgenden Phasen: Definition der Fragestellung, Auswahl der Methode(n), Entwurf der Studie, Durchführung, Auswertung, Bericht/Präsentation). \r\n</p>\r\n<p>Aufbauend auf diesem Grundverständnis und anhand der zentralen Qualitätsbegriffe von Glaubwürdigkeit (insbesondere innere Gültigkeit) und Relevanz (insbesondere äußere Gültigkeit) werden dann verschiedene Methodenklassen (z.B. kontrollierte Experimente, Quasiexperimente, Umfragen etc.) behandelt und jeweils anhand realer Fallbeispiele veranschaulicht: Eignung und Gegenanzeigen; Stärken und Schwächen; Vorgehen; Fallstricke. </p>\r\n\r\n<p>In der Übung wird die Benutzung von Software für die Datenauswertung erlernt und eine kleine empirische Studie projekthaft komplett von der Konzeption bis zur Präsentation durchgeführt.</p>', NULL, '<ul>\r\n<li>Jacob Cohen: The Earth Is Round (p &gt; .05). American Psychologist 49(12): 997003, 1994. Darrell Huff: How to lie with statistics, Penguin 1991.</li>\r\n<li>John C. Knight, Nancy G. Leveson: An Experimental Evaluation of the Assumption of Independence in Multi-Version Programming. IEEE Transactions on Software Engineering 12(1):9609, January 1986.</li>\r\n<li>John C. Knight, Nancy G. Leveson: A Reply to the Criticisms of the Knight and Leveson Experiment. Software Engineering Notes 15(1):24-35, January 1990. \r\n<li>Audris Mockus, Roy T. Fielding, James D. Herbsleb: Two Case Studies of Open Source Software Development: Apache and Mozilla. ACM Transactions of Software Engineering and Methodology 11(3):309-346, July 2002.</li>\r\n<li>Timothy Lethbridge: What Knowledge Is Important to a Software Professional? IEEE Computer 33(5):44-50, May 2000.</li>\r\n<li>David A. Scanlan: Structured Flowcharts Outperform Pseudocode: An Experimental Comparison. IEEE Software 6(5):28-36, September 1989.  </li>\r\n<li>Ben Shneiderman, Richard Mayer, Don McKay, Peter Heller: Experimental investigations of the utility of detailed flowcharts in programming. Commun. ACM 20(6):373-381, 1977.</li>\r\n<li>Lutz Prechelt, Barbara Unger-Lamprecht, Michael Philippsen, Walter F. Tichy: Two Controlled Experiments Assessing the Usefulness of Design Pattern Documentation in Program Maintenance. IEEE Transactions on Software Engineering 28(6):595-606, 2002.</li>\r\n<li>Lutz Prechelt. An Empirical Comparison of Seven Programming Languages: Computer 33(10):23-29, October 2000.</li>\r\n<li>Lutz Prechelt: An empirical comparison of C, C++, Java, Perl, Python, Rexx, and Tcl for a search/string-processing program. Technical Report 2000-5, March 2000.  </li>\r\n<li>Tom DeMarco, Tim Lister: Programmer performance and the effects of the workplace. Proceedings of the 8th international conference on Software engineering. IEEE Computer Society Press, 268-272, 1985.</li>\r\n<li>John L. Henning: SPEC CPU2000: Measuring CPU Performance in the New Millennium. Computer 33(7):28-35, July 2000.</li>\r\n<li>Susan Elliot Sim, Steve Easterbrook, Richard C. Holt: Using Benchmarking to Advance Research: A Challenge to Software Engineering. Proceedings of the 25th International Conference on Software Engineering (ICSE''03). 2003.</li>\r\n<li>Ellen M. Voorhees, Donna Harman: Overview of the Eighth Text REtrieval Conference (TREC-8).</li>\r\n<li>Susan Elliott Sim, Richard C. Holt: The Ramp-Up Problem in Software Projects: A case Study of How Software Immigrants Naturalize. Proceedings of the 20th international conference on Software engineering, April 19-25, 1998, Kyoto, Japan: 361-370.</li>\r\n<li>Oliver Laitenberger, Thomas Beil, Thilo Schwinn: An Industrial Case Study to Examine a Non-Traditional Inspection Implementation for Requirements Specifications. Empirical Software Engineering 7(4): 345-374, 2002.</li>\r\n<li>Yatin Chawathe, Sylvia Ratnasamy, Lee Breslau, Nick Lanham, Scott Shenker: Making Gnutella-like P2P Systems Scalable. Proceedings of ACM SIGCOMM 2003. April 2003.</li>\r\n<li>Stephen G. Eick, Todd L. Graves, Alan F. Karr, J.S. Marron, Audris Mockus: Does Code Decay? Assessing the Evidence from Change Management Data. IEEE Transactions of Software Engineering 27(1):12, 2001.</li>\r\n<li>Chris Sauer, D. Ross Jeffrey, Lesley Land, Philip Yetton: The Effectiveness of Software Development Technical Reviews: A Behaviorally Motivated Program of Research. IEEE Transactions on Software Engineering 26(1):14, January 2000.</li></ul>', '<h3>Homepage</h3>\r\n<a href="http://www.inf.fu-berlin.de/w/SE/VorlesungEmpirie2014">\r\nhttp://www.inf.fu-berlin.de/w/SE/VorlesungEmpirie2014</a>', '089bA1.6', 3, 1, 5, '2014-05-08 17:30:28'),
(14, 'XML-Technologien', '<h3>Inhalt</h3>\r\n<p>\r\nDie Extensible Markup Language (XML) ist die neue Sprache des Webs. Sie wird zwar HTML nicht ersetzen, jedoch in einem wichtigen Bereich ergänzen: Während HTML für die Präsentation von elektronischen Dokumenten entwickelt wurde (Mensch-Maschine-Kommunikation), ist XML insbesondere für den Austausch von Daten zwischen Computern geeignet. XML erlaubt dabei die Definition von speziellen Datenaustauschformaten (Standards) sowie die einfache Kombination und Erweiterung solcher Standards.</p>\r\n<p>\r\nZusammen mit einer breiten Unterstützung der Software-Industrie ermöglicht dies eine schnelle Verbreitung von XML im Web. Anwendungen von XML findet man heute u.a. in XHTML, Web Services und im E-Business. Der Vorlesungsstoff wird durch Projektarbeit vertieft.</p>', NULL, '<p>W3C Standards</p>', '<h3>Voraussetzungen</h3>\r\n<p>Kenntnisse der Internet-Grundlagen, passive Englischkenntnisse</p>', '089bA1.31', 2, 1, 1, '2014-05-08 17:30:28'),
(15, 'Bildverarbeitung', '<h3>Inhalt </h3>\r\n<p>In der Vorlesung werden grundlegende Bildverarbeitungstechniken behandelt. Sie umfassen Farbkorrekturen von Bildern, Fouriertransformation, Glätten, Schärfen, Kantendetektion, Aufbau von Bildpyramiden, ScaleSpace-Theory sowie grundlegende Verfahren zur Mustererkennung, wie z.B. die Hough-Transformation.</p>', NULL, '<p>wird noch bekanntgegeben</p>', '<p>Übungen siehe <a href="http://www.fu-berlin.de/vv/de/lv/146197?query=Ulbrich&sm=119983">19553a</a>\r\n</p>', '089bA4.9', 2, 1, 1, '2014-05-08 17:32:31'),
(16, 'Künstliche Intelligenz', '<h3>Inhalt</h3>\r\n\r\n<p>Suchverfahren für die Lösung kombinatorischer Aufgaben, Prädikatenlogik und ihre Mechanisierung, Resolution und Theorembeweise, Wissensbasierte- und Expertensysteme, Diffuse Logik, Mensch-Maschinen-Schnittstellen, Mustererkennung insbesondere für Handschrift und für gesprochene Sprache.</p>', NULL, '<p>wird noch bekannt gegeben.</p>', 'Achtung: Blockveranstaltung vor Beginn des SS14<br>\r\nÜbungen siehe <a href="http://www.fu-berlin.de/vv/de/lv/143923?query=Ulbrich&sm=119983">19548a</a>\r\n</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p> Grundkenntnisse in Mathematik und Algorithmen und Datenstrukturen', '089bA1.9', 2, 1, 1, '2014-05-08 20:21:32'),
(18, 'Mobilkommunikation', '<h3>Inhalt:</h3>\r\n<p>Das Modul Mobilkommunikation stellt exemplarisch alle Aspekte mobiler und drahtloser Kommunikation dar, welche derzeit den stärksten Wachstumsmarkt überhaupt darstellt und in immer mehr Bereiche der Gesellschaft vordringt.</p>\r\n<p>Während der gesamten Vorlesung wird ein starker Wert auf die Systemsicht gelegt und es werden zahlreiche Querverweise auf reale Systeme, internationale Standardisierungen und aktuellste Forschungsergebnisse gegeben.</p>\r\n<p>Die zu behandelnden Themen sind:</p>\r\n<ul>\r\n<il>Technische Grundlagen der drahtlosen Übertragung: Frequenzen, Signale, Antennen, Signalausbreitung, Multiplex, Modulation, Spreizspektrum, zellenbasierte Systeme;</il>\r\n<il>Medienzugriff: SDMA, FDMA, TDMA, CDMA;</il>\r\n<il>Drahtlose Telekommunikationssysteme: GSM, TETRA, UMTS, IMT-2000, LTE;</il>\r\n<il>Drahtlose lokale Netze: Infrastruktur/ad-hoc, IEEE 802.11/15, Bluetooth;</il>\r\n<il>Mobile Netzwerkschicht: Mobile IP, DHCP, ad-hoc Netze;</il>\r\n<il>Mobile Transportschicht: traditionelles TCP, angepasste TCP-Varianten, weitere Mechanismen;</il>\r\n<il>Mobilitätsunterstützung;</il>\r\n<il>Ausblick: 4. Generation Mobilnetze</il>\r\n</ul>', NULL, '<p>Jochen Schiller, Mobilkommunikation, Addison-Wesley, 2.Auflage 2003</p>\r\n\r\n<p>Alle Unterlagen verfügbar unter \r\n<a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/resources/Mobile_Communications/course_Material/index.html">\r\nhttp://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/resources/Mobile_Communications/course_Material/index.html\r\n</a>\r\n</p>', NULL, '089bA1.22', 2, 1, 1, '2014-05-08 20:51:48'),
(26, 'Aktuelle Probleme des Datenschutzes', '<h3>Inhalte:</h3>\r\n<p>Anhand aktueller politischer Themen werden die Grundprobleme des Datenschutzes behandelt. Als Grundlage dienen die datenschutzrechtlich relevanten Punkte des "Koalitionsvertrags 2013" zwischen CDU/CSU und SPD (z.B. EU-Datenschutzgrundverordnung, Vorratsdatenspeicherung, digitaler Datenschutz, privacy by design und privacy by default, NSA-Affaire, Besch&auml;ftigtendatenschutz, Elektronische Kommunikations- und Informationstechnologien im Gesundheitswesen, moderne Technik zur Erh&ouml;hung der Verkehrssicherheit). Prof. Garstka ist der fr&uuml;here Berliner Datenschutzbeauftragte. </p>', NULL, NULL, '<h3>Zielgruppe</h3>\r\n<p>Studierende, die die Vorlesung Datenschutz gehört haben.</p>', '089bA4.46', 3, 1, 5, '2014-05-09 05:28:59'),
(27, 'Seminar über Algorithmen', '<p>Das Seminar behandelt das Thema <em>Datenkompression</em>. Die Vorlesung vom\r\nWintersemester zu diesem Thema ist nicht Voraussetzung.</p>\r\n<p><a\r\nhref="http://w3.inf.fu-berlin.de/lehre/SS14/Seminar-Algorithmen-Datenkompression/">Weitere\r\nInformationen</a></p>', NULL, NULL, '<h3>Zielgruppe:</h3>\r\n<p>Master-Studenten der Informatik oder Mathematik</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p>Vorlesung "Höhere Algorithmik" oder vergleichbare Veranstaltung</p>\r\n<p>Es gibt eine <strong>erste Vorbesprechung</strong> am <font color="red"><em>Dienstag,\r\nden 18. März 2014</em></font> um 14 Uhr im Raum T9, SR 053.\r\nBei diesem Termin k&ouml;nnen schon die ersten Themen vergeben werden.</p>', '089bA4.47', 3, 1, 2, '2014-05-09 05:28:59'),
(28, 'Seminar: Zuverlässige Systeme', '<h3>Inhalt:</h3>\r\n\r\n<p>The seminar Dependable Systems will cover theoretical as well as applied topics. And combinations of both. We will study the performance and dependability of systems such as data centres, sensor networks, memories and web services using stochastic models and queueing networks.</p>\r\n<p>Presentations can focus on the application or on the modelling methods and tools.</p>\r\n\r\n<p>The seminar will take place in 2 blocks. \r\nPresentations can be in German or English.</p>', NULL, NULL, NULL, '089bA3.14', 3, 1, 3, '2014-05-09 05:31:37'),
(29, 'Seminar IT-Sicherheit', '<p>In this seminar, students perform literature research on topics related to information security, possibly augmented by practical exploration. The list of topics is discussed and topics are assigned during the first seminar.\r\n</p>', NULL, '<p>All seminar participants must perform a thorough search for scientific literature on their chosen topics. At least the following sources must be searched for relevant literature:\r\n</p>\r\n <p>    ACM Digital Library  http://dl.acm.org/ \r\n     Google Scholar  http://scholar.google.com/ \r\n     Authors'' homepages found via web searches with relevant keywords\r\n</p>\r\n<p>\r\n It is imperative that students follow literature references backwards (to identify seminal and foundational papers on their subject i.e., the first ones to report results on the topic under consideration) and forward (using the cited-by features of digital libraries, or Web searches for the current paper''s title) to identify the most recent work on the topic under consideration.\r\n</p>\r\n<p>\r\n Note that newsticker articles or Wikipedia articles do not count as scientific literature.\r\n</p>', '<p>Students are expected to:</p>\r\n<p>\r\n     Give a technical presentation of their assigned topics; \r\n     Demonstrate research software prototypes whenever applicable; \r\n     Turn in a short technical report on their assigned topics (10 pages).\r\n</p>\r\n<p>\r\nStudents will be graded on their preparedness for discussion, their presentations and their seminar report. The report must be typeset in LaTeX. Both the LaTeX source and the PDF generated from it must be submitted as a TAR or ZIP archive. A LaTeX template is here.\r\n</p>\r\n<p>\r\n The seminar report must contain references to all the articles that were used. Each literature entry must include a brief and concise summary of the article''s contribution and the contribution''s benefits. Please use the BibTex "note" field for this purpose and inline the bibliography by including the bbl file into the LaTeX source.\r\n</p>', '089bA1.49', 3, 1, 1, '2014-05-09 05:31:37'),
(30, 'Seminar Anonyme Kommunikation', '<h3>Inhalt</h3>\r\n<p>Wir studieren "historische" und aktuelle Systeme zur anonymen Kommunikation aus der Praxis und der wissenschaftlichen Literatur. Neben der grunds&auml;tzlichen Frage "Was ist anonyme Kommunikation?" werden wir ferner verschiedene Bedrohungsszenarien und Angriffe diskutieren. Aus den dabei gewonnenen Erkenntnissen wollen wir kritisch die Sicherheit dieser Systeme anhand der Angriffsmodelle reflektieren, die j&uuml;ngste Medienberichte aktuell als realistisch vermuten lassen.</p>', NULL, '<p>Wird in der Veranstaltung bekannt gegeben;verschiedene Quellen aus der wissenschaftlichen Literatur.</p>', '<h3>Zielgruppe</h3>\r\n<p>Studierende im Master oder Diplom Hauptstudium mit Schwerpunkt Sicherheit, Praktischer- oder Technischer Informatik</p>\r\n<h3>Voraussetzung</h3>\r\n<p>Telematik,Technische Informatik III; (Rechnersicherheit oder Kryptographie w&uuml;nschenswert)</p>', '089bA1.41', 3, 1, 1, '2014-05-09 05:33:44'),
(31, 'Seminar Zensur und zensurresistente Kommunikation', '<h3>Inhalt:</h3>\r\n<p>\r\nIn diesem Seminar betrachten wir die Zensur von digitaler Kommunikation. In einer ersten Bestandsaufnahme er&ouml;rtern wir wie Zensur heute ausge&uuml;bt wird, und welche Erkennungs- und Umgehungsm&ouml;glichkeiten in der Praxis genutzt werden.</p>\r\n<p>\r\nAnschlie&szlig;end untersuchen wir dazu:</p>\r\n<ol>\r\n<li>technische M&ouml;glichkeiten zur Zensur und</li>\r\n<li>zensurresistente Netzwerke aus der wissenschaftlichen Literatur.</li>\r\n</ol>', '', '<p>Wird in der Veranstaltung bekannt gegeben; <br>\r\nverschiedene Quellen aus der wissenschaftlichen Literatur.\r\n</p>', '<h3>Zielgruppe:</h3>\r\n<p>\r\nStudierende im Master oder Diplom Hauptstudium mit Schwerpunkt: Sicherheit, Praktischer- oder Technischer Informatik</p>\r\n<h3>Voraussetzungen:</h3>\r\n<p>Telematik, Technische Informatik III; (Rechnersicherheit oder Kryptographie w&uuml;nschenswert)</p>', '089bA1.41', 3, 1, 1, '2014-05-09 05:33:44'),
(32, 'Seminar Beiträge zum Software Engineering', '<h3>Inhalt</h3>\r\n\r\n<p>Dies ist ein Forschungsseminar. Das bedeutet, die Vorträge sollen in der Regel zur Förderung laufender Forschungsarbeiten beitragen. Es gibt deshalb, grob gesagt, drei Arten möglicher Themen:</p>    \r\n\r\n<ul>\r\n<li>Publizierte oder laufende Forschungsarbeiten aus einem der Bereiche, in denen die Arbeitsgruppe Software Engineering arbeitet.  </li>\r\n<li>Besonders gute spezielle Forschungsarbeiten (oder anderes Wissen) aus anderen Bereichen des Software Engineering oder angrenzender Bereiche der Informatik.  </li>\r\n<li>Grundlagenthemen aus wichtigen Gebieten des Software Engineering oder angrenzender Fächer wie Psychologie, Soziologie, Pädagogik, Wirtschaftswissenschaften sowie deren Methoden. </li>\r\n</ul>\r\n\r\n<p>Eine scharfe Einschränkung der Themen gibt es jedoch nicht; fast alles ist möglich.</p>', NULL, NULL, '<h3>Zielgruppe</h3>\r\n\r\n<p>\r\nStudierende der Informatik (auch Nebenfach).</p>\r\n<p>\r\nBitte melden Sie sich bei Interesse mit einem Themenvorschlag oder einer Themenanfrage bei irgendeinem geeigneten Mitarbeiter der Arbeitsgruppe.</p>\r\n<p>\r\nDer Einstieg ist auch während des laufenden Semesters möglich, da die Veranstaltung fortlaufend angeboten wird.</p>   \r\n\r\n<h3>Voraussetzungen </h3>\r\n<p>\r\nTeilnehmen kann jede/r Student/in der Informatik, der/die die Vorlesung "Softwaretechnik" gehört hat.</p> \r\n<p>\r\nIm Rahmen der Teilnahme kann es nötig werden, sich mit Teilen der Materialien zur Veranstaltung "Empirische Bewertung in der Informatik" auseinanderzusetzen.</p>   \r\n\r\n<h3>Homepage </h3>\r\n<p><a href="https://www.inf.fu-berlin.de/w/SE/SeminarBeitraegeZumSE">\r\nhttps://www.inf.fu-berlin.de/w/SE/SeminarBeitraegeZumSE</a></p>', '089bA1.17', 2, 1, 1, '2014-05-09 05:35:42'),
(33, 'Simulierte Unternehmensgründung in der IT-Industrie', '<h3>Inhalt</h3>\r\n<p>Ziel der Veranstaltung ist die eigenständige Planung, Durchführung und Evaluation eines IT-Gründungsprojektes. Die Teilnehmer/innen setzen eine Geschäftsidee um und entwickeln die entsprechende Software. In Teams wird relevantes Fach- und Gründungswissen erlernt und im Rahmen einer praxisnahen simulierten Unternehmensgründung selbständig angewandt.</p>\r\n<p>\r\nZentrale Themen sind:</p>\r\n<ul>\r\n<li>Entwicklung und Umsetzung eines Geschäftsmodells</li>\r\n<li>Softwareentwicklung</li>\r\n<li>Marktanalyse</li>\r\n<li>Marketingplan</li>\r\n<li>Finanzierungskonzeption</li>\r\n<li>Projektmanagement und Teamarbeit</li>\r\n<li>Präsentationstechniken</li>\r\n</ul>', NULL, '<ul>\r\n<li>W. Benzel und E. Wolz, Businessplan für Existenzgründer, Walhalla, 2. aktualisierte Auflage, 2006.</li>\r\n<li>Jo B. Nolte, Existenzgründung, Haufe Verlag 2006.</li>\r\n<li>R. Bleiber, Kaufmännisches Wissen für Selbständige, Haufe Verlag 2005.</li>\r\n<li>P. Mangold, IT-Projektmanagement kompakt, Spektrum Akademischer Verlag, 2004</li>\r\n<li>W. Simon (Hrsg.), Persönlichkeitsmodelle und Persönlichkeitstests, GABAL Verlag 2006.</li>\r\n</ul>', '<h3>Zielgruppe</h3>\r\n<p>Informatik-Studierende aller Studiengänge</p>', '089bA4.39', 3, 1, 4, '2014-05-09 05:35:42'),
(35, 'Modelchecking', '<h3>\n	<strong>Inhalte:</strong></h3>\n<div>\n	- Unterschied zwischen Programmieren und Modellieren&nbsp;</div>\n<div>\n	- Modellieren reaktiver Systeme in SPIN und Promela&nbsp;</div>\n<div>\n	- Spezifizieren von Anforderungen in temporalen Logiken&nbsp;</div>\n<div>\n	- Automatentheoretische Modelle von Systemen und Spezifikationen&nbsp;</div>\n<div>\n	- Entscheidungsverfahren f&uuml;r temporale Logiken&nbsp;</div>\n<div>\n	- Symbolisches Modelchecking und Bin&auml;re Entscheidungsdiagramme&nbsp;</div>\n<div>\n	- Modelchecking mit NuSMV&nbsp;</div>\n<div>\n	- Automatenmodelle mit Zeit&nbsp;</div>\n<div>\n	- Modellchecking von Zeitautomaten mit Uppaal&nbsp;</div>\n<div>\n	- Formale Methoden zur Abstraktion und dem Nachweis der erhaltenen Eigenschaften.&nbsp;</div>\n<div>\n	&nbsp;</div>\n<div>\n	<strong>Miniprojekt:</strong></div>\n<div>\n	Es soll selbst&auml;ndig ein nicht-sequentielles Systems oder ein nicht-sequentieller Algorithmus modelliert, dessen Anforderungen formalisiert und schlie&szlig;lich das Modell bez&uuml;glich der Anforderungen mit Hilfe von geeigneten Modell&uuml;berpr&uuml;fern verifiziert werden. Diese Leistung wird durch Abgabe der Modelle und eines schriftlichen Berichts nachgewiesen.</div>\n<div>\n	&nbsp;</div>', NULL, '<div>\n	- Christel Baier und Joost-Pieter Katoen, Principles of Model Checking, The MIT Press, 2008&nbsp;</div>\n<div>\n	- Mordechai Ben Ari, Principles of the SPIN Model Checker, Springer Verlag, 2008&nbsp;</div>\n<div>\n	- Gerard Holzmann, The SPIN Model Checker, Addison-Wesley, 2004&nbsp;</div>\n<div>\n	- Edmund M. Clarke, Jr., Orna Grumberg and Doron A. Peled, Model Checking, MIT Press, 1999</div>', NULL, '089bA2.7', 2, 1, 2, '2014-05-15 12:01:01'),
(36, 'Logik erster Stufe in Theorie und Praxis', '<ul>\n\n<li>A) eine kompakte Einführung in die Theorie von Logik erster Stufe mit\n\n</li>\n<li>B) einem praktischen Training zur Verwendung von Theorembeweisern für die Logik erster Stufe in Anwendungen.</li></ul>', NULL, '\r\nHinsichtlich A) orientiert sich die Vorlesung am Lehrbuch von Fitting [1] (Harrison [2] wird ebenfalls sehr empfohlen). Zu den Themen der Vorlesung zählen:<br>\r\n<ul>\r\n<li>Syntax und Semantik von Aussagenlogik und Logik erster Stufe (mit und ohne Gleichheit),</li>\r\n<li>Herbrand Modelle,</li>\r\n\r\n<li> Hintikka Mengen und Abstrakte Konsistenz,</li>\r\n\r\n<li>Korrektheit und Vollständigkeit,</li>\r\n\r\n<li>semantische Tableaux und Resolution,</li>\r\n\r\n<li>Implementierung.</li>\r\n</ul>\r\n\r\n\r\nHinsichtlich B) konzentriert sich die Vorlesung auf eine Einführung in die TPTP Infrastruktur [4]. Angesprochene Themen sind:<br>\r\n<ul>\r\n\r\n<li>TPTP Sprache(n),SZS Ontologie für Beweiserresultate,</li>\r\n\r\n<li>TPTP und TSTP Problem- und Beweis-Bibliotheken,</li> \r\n<li>Anwendung von TPTP kompatiblen Beweisern,</li>\r\n\r\n<li>weitere TPTP Werkzeuge und Systeme,</li>\r\n\r\n<li>(TPTP für Logik höherer Stufe).</li></ul><br>\r\n\r\n\r\n\r\nIn Teil B) der Vorlesung werden praktische Übungen im Vordergrund stehen. Sofern Zeit bleibt, wird in der Vorlesung auch ein kurzer Ausblick auf Theorie und Praxis von Logik höherer Stufe geboten (ein Thema, das evtl. im Rahmen einer Vorlesung im SS 2014 vertieft werden wird). \r\n<br>\r\n\r\n\r\nEs wird den Teilnehmern empfohlen, sich bereits im Vorfeld in [1] und [5] einzuarbeiten (auch [2] wird sehr empfohlen).\r\n<br><br>\r\n', '<div>Weitere Angaben siehe (provisorische) <a href="http://page.mi.fu-berlin.de/cbenzmueller/2013-FOL/">Webseite</a><br>Literaturangaben zu A): \n<ul>\n<li> [1] Melvin Fitting, First-Order Logic and Automated Theorem Proving, Springer-Verlag, New York, 1996 </li>\n <li>[2] John Harrison, Handbook of Practical Logic and Automated Theorem Proving, Springer Verlag, New York, 1996. </li> \n<li>[2] John Harrison, Handbook of Practical Logic and Automated Reasoning. Cambridge University Press, 2009. </li>\n <li>[3] Uwe Schöning, Logik für Informatiker, Spektrum, 2000. </li><br></ul><br>\nzu B):<br>\n<ul>\n<li> [4] TPTP Infrastruktur: http://www.tptp.org</li>\n<li> [5] G. Sutcliffe, The TPTP Problem Library and Associated Infrastructure. Journal of Automated Reasoning (2009) 43(4):337:362. (http://www.springerlink.com/content/2g263588337ku424/fulltext.pdf</li>\n<li>[6] G. Sutcliffe and C. Benzmüller, Automated Reasoning in Higher-Order Logic using the TPTP THF Infrastructure, Journal of Formalized Reasoning, (2010) 3(1):1-27.</li></ul>\n</div>', ' 089bA1.42', 3, 1, 5, '2014-05-15 12:14:31'),
(38, 'Digitales Video', 'Es werden die gängigen digitalen Videoformate, ihre jeweiligen Algorithmen (sofern offen), ihre jeweils speziellen Eigenschaften und die vorhandenen Werkzeuge vorgestellt: MPEG-1, -2, -4, -7 und -21 wird ausführlich behandelt, ferner AVI, Quicktime, WindowsMedia, MPEG-4/H.264, OGG, Matroska. In jedem Fall ist der Kurs stark praxis-orientiert. Im Rahmen von "Labor"-Übungen steht Software zur Erzeugung und Untersuchung von Video-Dateien zur Verfügung. Teilnehmer/innen, die Credit-Points erwerben wollen, halten einen 40-minütigen Vortrag und fertigen dazu eine kurze Ausarbeitung an.', '', 'Literatur noch nicht genannt ', '<a href="http://www.mi.fu-berlin.de/zdm/lectures/digvideo/index.html>Homepage</a>', '089bA4.5', 3, 1, 4, '2014-05-15 12:25:19'),
(40, 'Student Research Seminar', '<p>\n	The student research seminar is an event for students doing their theses in our research group. Content varies from meeting to meeting: status reports from theses, reports from conferences, status of research projects, etc.Everyone is invited to join and to experience how we manage and organize theses. One of our primary goals is to keep in touch with each student. In addition to a personal supervisor every student can make use of this event to get support from all participating members of the CST research group - and of course all other students.If you want to do your thesis with us, just attend the meeting. We will discuss our open topics, your personal preferences, and areas of interest. In the end we will come up with a topic that is of interest for all of us.</p>', '', 'Je nach Anwendungsgebiet', '', 'E24fA1.4', 3, 1, 4, '2014-05-15 12:36:50'),
(41, 'Forschungsseminar - Datenverwaltung', 'Vorträge zu Abschlussarbeiten und aktuellen Forschungsthemen, Teilnahme nur mit persönlicher Einladung. Voraussetzungen Solide Kenntnisse im Bereich Datenbanken und Informationssysteme', '', '', '', 'E24fA1.4', 4, 1, 1, '2014-05-15 12:45:09'),
(42, 'Forschungsseminar - Secure Identity', 'Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus dem Bereich Secure Identity Voraussetzungen Solide Kenntnisse im Bereich IT-Sicherheit', '', '', '', 'E24fA1.4', 4, 1, 1, '2014-05-15 12:47:09'),
(43, 'Vertiefung Fachdidaktik Informatik: Seminar/Praktikum', '<p>Die Studentinnen und Studenten absolvieren im Rahmen des Moduls ein fachdidaktisches Hauptseminar, ein fachdidaktisches Forschungsseminar, ein Seminar &uuml;ber schulform- und altersstufenbezogene Fragen des Informatikunterrichts sowie ein darauf abgestimmtes Praktikum. Inhalte Seminar:</p>\n<ul>\n<li>Analyse, Entwicklung und Erprobung von Unterrichtskonzepten und -materialien</li>\n<li>adressatenbezogene Zug&auml;nge und Unterrichtssequenzen: Einstiege, Motivation, Interesse, Problemorientierung, Kontextbezug, Curricula und Bildungsstandards.</li>\n<li>Inhalte des begleitenden Praktikums: Praktische Umsetzung der im Seminar erprobten Unterrichtskonzepte unter Einsatz der erarbeiteten Materialien.</li>\n</ul>', '', '', ' Diese Veranstaltung ist ein Teil des Moduls /Vertiefung Fachdidaktik Informatik/ im Master-Studiengang /Lehramt Informatik/ und im Master-Studiengang Bioinformatik. Sie kann auch im alten Staatsexamens-Studiengang belegt werden. Empfohlen insbesondere f&uuml;r Lehramtstudierende mit zwei F&auml;chern. Literatur Wird im Seminar bekannt gegeben.', 'E24fA1.1', 3, 1, 1, '2014-05-15 12:55:35'),
(51, 'Datenstrukturen und Datenabstraktion', '<ul>\n<li>Analyse von Sortierverfahren: Mergesort, Quicksort, u.a. \n</li><li>ADTs Prioritätswarteschlange und Wörterbuch und zugehörige Datenstrukturen: Heaps, Hashing, \nbinäre Suchbäume, B-Bäume, u.a. \n</li><li>Algorithmen auf Graphen: Breiten- und Tiefensuche, topologisches Sortieren, minimale Spannbäume, kürzeste Wege. \n</li><li>Algorithmen für Mengen von Zeichenketten. \n</li><li>Speicherverwaltung. \n</li><li>Verschiedene Entwurfstechniken für Algorithmen: teile-und-herrsche, greedy, dynamische Programmierung. \n</li><li>Mathematische Analyse von Algorithmen bezüglich ihres Resourcenbedarfs: Laufzeit, Speicherplatz.\n</li></ul>', '', '<ul>\n<li>M.T. Goodrich, R. Tamassia: Data Structures and Algorithms in Java. Wiley 2004 \n</li><li> R. H. Güting, S. Dieker: Datenstrukturen und Algorithmen, Teubner 2003 \n</li><li> Cormen, Leiserson, Rivest: Algorithmen, Oldenbourg 2004 \n</li><li>R. Sedgewick: Algorithmen in Java. (Teil 1-4), Pearson 2003\n</li></ul>', '<br>', '086bA1.3', 1, 1, 1, '2014-05-15 13:44:59'),
(52, 'Funktionale Programmierung', 'Grundlagen der Berechenbarkeit: \n<ul>\n<li>Lambda-Kalkül</li>\n<li>primitive Rekursion</li>\n<li>µ-Rekursion</li>\n</ul>\n\n<br>\n\nEinführung in die ufnktionale Programmierung (Haskell):\n<ul>\n<li>Syntax (Backus-Naur-Form)</li>\n<li>	primitive Datentypen, Listen, Tupel, Zeichenketten</li>\n<li>Ausdrücke, Funktionsdefinitionen, Rekursion und Iteration</li>\n<li>Funktionen höherer Ordnung, Polymorphie</li>\n<li>Typsystem, Typherleitung und –überprüfung</li>\n<li>Algebraische und abstrakte Datentypen<li>\n<li>Ein- und Ausgabe<li>\n<li>Such- und Sortieralgorithmen</li>\n</ul>\n<br>\n\nBeweisen von Programmeigenschaften: \n<ul>\n<li>Termersetzung</li>\n<li>strukturelle Induktion</li>\n<li>Terminierung</li>\n</ul>\n<br>\nImplementierung und Programmiertechnik: \n<ul>\n<li>Auswertungsstrategien für funktionale Programme</li>\n<li>Modularer Programmentwurf</li></ul>', '', '<ul>\n<li>Simon Thompson: Haskell: The Craft of Functional Programming, 2nd Edition, Addison-Wesley, 1999</li>\n<li>Graham Hutton: Programming in Haskell, Cambridge University Press, 2007</li>\n<li>Bird, R./Wadler, Ph.: Einführung in Funktionale Programmierung, Hanser Verlag, 1982</li>\n<li>Hans Hermes: Aufzählbarkeit, Entscheidbarkeit, Berechenbarkeit, Springer-Verlag 1978</li></ul>', 'Informationen für Studenten Homepage <a href="http://www.inf.fu-berlin.de/lehre/WS13/ALP1/">http://www.inf.fu-berlin.de/lehre/WS13/ALP1/</a>', '086bA1.1', 1, 1, 1, '2014-05-15 13:52:47'),
(53, 'Netzprogrammierung', '<p>Die Vorlesung stellt Prinzipien, Sprachen und Middleware f&uuml;r die Entwicklung verteilter Anwendungssysteme vor. In Fortsetzung von Algorithmen und Programmierung IV werden nichtsequentielle Programme betrachtet, deren Prozesse &uuml;ber Nachrichten interagieren. Verschiedene Architekturstile werden behandelt: Datenfluss, verteilte Algorithmen, Ereignissysteme, Client/Server.&nbsp; Nach einer Auffrischung der elementaren Client/Server-Kommunikation &uuml;ber Sockets wird am Beispiel von Java RMI die Fernaufruf-Technik behandelt.&nbsp; Web-Anwendungen und -Dienste werden als alternative Auspr&auml;gungen des Fernaufruf-Prinzips identifiziert.</p>', '', 'Bengel, Günther: Grundkurs Verteilte Systeme. Vieweg & Teubner 2004', '<h3>Voraussetzungen</h3><div>ALP 1-4, TI 1-3. Ferner wird erwartet, dass die Teilnehmer Grundkenntnisse in HTML mitbringen und ihre HTML-Kenntnissewährend des Semesters selbständig erweitern. (Eine von zahlreichen einschlägigen Ressourcen ist http://de.selfhtml.org/html/index.htm</div><br>\nHomepage <a  href=\\"http://www.inf.fu-berlin.de/lehre/WS13/alp5\\" target=\\"_blank\\">www.inf.fu-berlin.de/lehre/WS13/alp5</a>', '086bA1.5', 1, 1, 1, '2014-05-15 13:57:26'),
(55, 'TI I - Grundlagen der Technischen Informatik', '<div>\n	Die Vorlesung Grundlagen der Technischen Informatik bildet die Basis f&uuml;r das Verst&auml;ndnis der Funktionsweise realer Rechnersysteme. Es werden grundlegende Kenntnisse aus den Bereichen Gleich- und Wechselstromnetzwerke, Halbleiter, Transistoren, CMOS, Operationsverst&auml;rker, A/D- und DA-Umsetzer vermittelt, soweit sie f&uuml;r die Informatik notwendig sind. Ausgehend von der Logik werden in diesem Modul vorrangig die Themenbereiche Schaltnetze und Schaltwerke, Logikminimierung, Gatter, Flip-Flops, Speicher, Automaten und einfacher Hardware-Entwurf behandelt.</div>', '', '<strong>Literatur:</strong>\n<ul>\n<li>H. M. Lipp: Grundlagen der Digitaltechnik, 3. Auflage, Oldenbourg Verlag 2000</li>\n<li>Th. R. McCalla: Digital Logic and Computer Design, Macmillan Publishing Company in New York 1992</li>\n<li>W. Oberschelp, G. Vossen: Rechneraufbau und Rechnerstrukturen 8. Auflage Oldenbourg-Verlag M&uuml;nchen, 2000</li>\n<li> J. Hayes: Computer Architecture and Organisation McGraw, 3. Auflage 1998</li>\n<li> H. Liebig, S. Thome: Logischer Entwurf digitaler Systeme, 3. Auflage, Springer Verlag, 1996</li>\n<li>G. Scarbata: Synthese und Analyse digitaler Schaltungen, Oldenbourg Verlag 1996</li>\n<li>A. Bleck, M. Geodecke, A. Huss, K. Waldschmidt: Praktikum des modernen VLSI-Entwurfs, Teubner Verlag 1996</li></ul>', '<a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/2013-14_WS/index.html">Homepage</a>', '086bA2.1', 1, 1, 2, '2014-05-15 14:07:36'),
(56, 'TI III - Betriebs- und Kommunikationssysteme', '<div>Das Modul Betriebs- und Kommunikationssysteme schlie&szlig;t die L&uuml;cke zwischen dem Rechner als Hardware und den Anwendungen. Themen sind daher Ein-/Ausgabe-Systeme, DMA/PIO, Unterbrechungsbehandlung, Puffer, Prozesse/Threads, virtueller Speicher, UNIX und Windows, Shells, Utilities, Peripherie und Vernetzung, Netze, Medien, Medienzugriff, Protokolle, Referenzmodelle, TCP/IP, grundlegender Aufbau des Internet.</div>', '', '<ul>\n<li>William Stallings: Betriebssysteme - Prinzipien und Umsetzung, Pearson Studium 2003</li>\n<li>James F. Kurose, Keit W. Ross: Computernetze, Pearson Studium 2002</li>\n</ul>', '<a href="https://lms.fu-berlin.de/webapps/blackboard/execute/courseMain?course_id=_43706_1">Homepage</a>', '086bA2.3', 1, 1, 2, '2014-05-15 14:11:41'),
(57, 'Seminar - Autonome Fahrzeuge', 'Das Seminar kann als Vorbereitung für eine Master- oder Diplomarbeit in der AG "Intelligente Systeme und Robotik" dienen. Folgende Themen aus dem Gebiet der Autonomen Fahrzeuge stehen zur Auswahl: Fahrplanung in dynamischen Situationen, Fahrplanung mit begrenztem Wissen, Lokalisierung mittels Landmarken, Objekterkennung im Straßenverkehr. ', '', '', '', '089bA1.19', 3, 1, 1, '2014-05-15 14:28:37'),
(59, 'Mikroprozessor-Praktikum', 'Die überwältigende Mehrheit zukünftiger Computersysteme wird durch miteinander kommunizierende, eingebettete Systeme geprägt sein. Diese finden sich in Maschinensteuerungen, Haushaltsgeräten, Kraftfahrzeugen, Flugzeugen, intelligenten Gebäuden etc. und werden zukünftig immer mehr in Netze wie dem Internet eingebunden sein. Das Praktikum wird auf die Architektur eingebetteter Systeme eingehen und die Unterschiede zu traditionellen PC-Architekturen (z.B. Echtzeitfähigkeit, Interaktion mit der Umgebung) anhand praktischer Beispiele aufzeigen. Das Praktikum basiert auf einem MSP430 Mikrocontrollersystem. Schwerpunkte des in einzelne Versuche gegliederten Praktikums sind: Registerstrukturen, Speicherorganisation, hardwarenahe Assembler- und Hochsprachenprogrammierung, I/O-System- und Timer-Programmierung, Interrupt-System, Watchdog-Logik, Analogschnittstellen, Bussystemanbindung von Komponenten, Kommunikation (seriell, CAN-Bus, Ethernet, Funk und USB), Ansteuerung von Modellen und Nutzung unterschiedlichster Sensorik', '', 'Das große MSP430 Praxisbuch, Franzis Verlag GmbH, 2000 Brian W. Kernighan, Dennis M. Ritchie: The C Programming Language, Second Edition, Prentice Hall, 1988', 'Siehe Unterlagen auf der Homepage - nur aus dem FB-Netz oder über VPN <a href="http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/2013-14_WS/index.html">Homepage</a>', '086bA2.4', 3, 1, 2, '2014-05-19 06:49:17'),
(69, 'MafI I: Logik und Diskrete Mathematik', '<ol>\n<li>Aussagenlogik und mathematische Beweistechniken</li>\n<li>Boolesche Formeln und Boolesche Funktionen, DNF und KNF, Erfüllbarkeit, Resolutionskalkül</li>\n<li>Mengenlehre: Mengen, Relationen, Äquivalenz- und Ordnungsrelationen, Funktionen</li>\n<li>Natürliche Zahlen und vollständige Induktion, Abzählbarkeit<(li>\n<li>Prädikatenlogik und mathematische Strukturen</li>\n<li>Kombinatorik: Abzählprinzipien, Binomialkoeffizienten und Stirling-Zahlen, Rekursion, Schubfachprinzip</li>\n<li>Graphentheorie: Graphen und ihre Darstellungen, Wege und Kreise in Graphen, Bäume</li></ol>', '', '<ol>\n<li>Christoph Meinel, Martin Mundhenk: Mathematische Grundlagen der Informatik, Teubner; 2. Auflage 2002</li>\n<li>Uwe Schöning: Logik für Informatiker, B.I.-Wissenschaftsverlag; 5. Auflage 2000</li>\n<li>Kenneth H. Rosen: Discrete Mathematics and its Applications, Mc-Graw Hill; 1999</li>\n<li>M. Aigner: Diskrete Mathematk, Vieweg, 5. Auflage 2004</li></ol>', '', '086bA4.1', 1, 1, 4, '2014-05-19 08:53:53'),
(70, 'MafI III: Lineare Algebra', '<ul>\n<li>Lineare Algebra: \n  <ul>\n    <li>Vektorraum, Basis und Dimension; \n    </li><li>lineare Abbildung, Matrix und Rang; \n    </li><li>Gauss-Elimination und lineare Gleichungssysteme; \n    </li><li>Determinanten, Eigenwerte und Eigenvektoren; \n    </li><li>Euklidische Vektorräume und Orthonormalisierung; \n    </li><li>Hauptachsentransformation\n  </li></ul>\n</li><li>Anwendungen der linearen Algebra in der affinen Geometrie, Statistik und Codierungstheorie (lineare Codes) \n</li><li>Grundbegriffe der Stochastik: \n  <ul>\n    <li>Diskrete und stetige Wahrscheinlichkeitsräume, Unabhängigkeit von Ereignissen; \n    </li><li>Zufallsvariable und Standardverteilungen; \n    </li><li>Erwartungswert und Varianz\n  </li></ul>\n</li></ul>', '', '<ul>\n<li>Klaus Jänich: Lineare Algebra, Springer-Lehrbuch, 10. Auflage 2004\n</li><li>Dirk Hachenberger: Mathematik für Informatiker, Pearson 2005 \n</li><li>G. Grimmett, D. Welsh: Probability - An Introduction, Oxford Science Publications 1986 \n</li><li>Kurt Meyberg, Peter Vachenauer: Höhere Mathematik 1, Springer-Verlag, 6.Auflage 2001 \n</li><li>G. Berendt: Mathematik für Informatiker, Spektrum Akademischer Verlag 1994 \n</li><li>Oliver Pretzel: Error-Correcting Codes and Finite Fields, Oxford Univ. Press 1996\n</li></ul>', 'Freischaltung der Anmeldung zu Tutorien wird rechtzeitig bekanntgegeben.', '086bA4.3', 1, 1, 4, '2014-05-19 08:56:32');
INSERT INTO `modulverwaltung_modul` (`m_id`, `m_name`, `m_inhalt`, `m_ziel`, `m_literatur`, `m_voraussetzung`, `m_lvNummer`, `m_typ`, `sp_id`, `mk_id`, `m_geaendert_am`) VALUES
(71, 'Kryptographie und Sicherheit in Verteilten Systemen', 'Diese Vorlesung gibt eine Einführung in die Kryptographie und das kryptographische Schlüsselverwaltung, sowie eine Einführung in kryptographische Protokolle und deren Anwendung im Bereich der Sicherheit in verteilten Systemen. Mathematische Werkzeuge werden im erforderlichen und einer Einführungsveranstaltung angemessenen Umfang entwickelt. Zusätzlich berührt die Vorlesung die Bedeutung von Implementierungsdetails für die Systemsicherheit. Voraussetzungen Teilnehmer müssen gutes mathematisches Verständnis sowie gute Kenntnisse in den Bereichen Rechnersicherheit und Netzwerken mitbringen. ', NULL, 'Jonathan Katz and Yehuda Lindell, Introduction to Modern Cryptography, 2008 Lindsay N. Childs, A Concrete Introduction to Higher Algebra. Springer Verlag, 1995. <br>Johannes Buchmann, Einfuehrung in die Kryptographie. Springer Verlag, 1999.<br> Weitere noch zu bestimmende Literatur und Primärquellen.', NULL, '086bA5.1', 3, 1, 2, '2014-05-19 08:59:06'),
(72, 'Zuverlässige Systeme', 'Es wird in die Grundlagen der Zuverlässigkeit und Fehlertoleranz eingeführt (Failure, Fault, Error). Die wichtigsten Fehlertoleranztechniken, spezielle Probleme in verteilten Systemen, Fehlererkennung und die unterschiedlichen Arten von Redundanz werden behandelt. Neben den Techniken zur Entwicklung und Analyse zuverlässiger und fehlertoleranter Systeme werden Methoden und Modelle zur Bewertung der Verlässlichkeit vorgestellt. Dies sind Fehlerbäume, kombinatorische Modelle, sowie Zustandsraum-basierte stochastische Modelle, wie Warteschlangen und Petri-Netze. Für diese Modelle werden analytische, sowie simulative Lösungsverfahren besprochen. Mit Hilfe quantitativer Methoden ist es möglich, verschiedene Systeme zu vergleichen, was sowohl in der Entwurfsphase als auch bei der Verbesserung zuverlässiger Systeme von hoher Bedeutung ist. Die Vorlesung wird von einer Übung begleitet, die aus einzelnen Aufgaben besteht. Ferner gibt es für Interessierte die Möglichkeit, die erworbenen Kenntnisse im Rahmen eines kleinen Projektes anzuwenden.', '', 'B. Haverkort. Performance of Computer Communication Systems - A Model-Based Approach. Wiley.K. Echtle. Fehlertoleranzverfahren, Springer-Verlag, Berlin, 1990 D. P. Siewiorek, R.S. Swarz. Reliable Computer Systems, Digital Press,1992R. Jain. The Art of Computer Systems Performance Analysis: Techniques for Experimental Design, Measurement, Simulation, and Modeling, Wiley- Interscience, 1992. Homepage http://cst.mi.fu-berlin.de/teaching/WS1213/19537-V-ZS/index.html', '<h2>Zielgruppe:</h2>\nStudierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik. \n<h2>Voraussetzungen:</h2>Nicht unbedingt nötig aber hilfreich sind Grundlagen in Stochastik.', '086bA5.2', 2, 1, 1, '2014-05-19 09:04:47'),
(73, 'Modellgetriebene Softwareentwicklung', 'Die Vorlesung beschäftigt sich mit modellgetriebener Softwareentwicklung. Wir werden, auf den bereits erworbenen Kenntnissen der UML aufbauend, zuerst grundlegende Konzepte der Metamodellierung betrachten um uns anschließend dem Bereich der domänenspezifischen Sprachen (DSL ? Domain Specific Languages) zuzuwenden. Wir betrachten den Entwurf und die Implementierung von DSLs im Rahmen des gesamten Softwareentwicklungsprozesses, angefangen von der Motivation, über Konzeption bis hin zu Kodegeneration und Ausführung. Auf der Ebene der Modelle werden wir uns mit Ansätzen der Modellanalyse, wie dem Model Checking, und der Transformation von Modellen beschäftigen. Dabei betrachten wir sowohl Modell-zu-Modell Transformationen, wie die Abbildung eines plattformunabhängigen Modells auf eine konkrete Ausführungsplattform oder verhaltensneutrale Refactorings von Modellen, als auch die Modell-zu-Text Transformation wie sie beispielsweise für die Kodeerzeugung verwendet werden. Der letzte thematische Block der Veranstaltung wird sich mit der Verwendung von Modellen zur Laufzeit beschäftigen. Wir werden uns genauer mit der Interpretation von Verhaltensmodellen auseinander setzen und den Zusammenhang zwischen Strukturmodellen und dynamischen Komponentensystemen näher beleuchten.Die Übungen werden parallel durchgeführt und sollen den theoretisch vermittelten Stoff durch praktische Anwendung der gelernten Konzepte und Ansätze besser verständlich machen. Technisch bauen wir dabei auf Java und dem Eclipse Modelling Framework (EMF) auf.', NULL, 'Tom Stahl, Markus Völter, Sven Efftinge, Arno Haase. Modellgetriebene Softwareentwicklung, 2. Auflage, ISBN-13 978-3-89864-448-8, dPunkt, 2007 - Dave Steinberg, Frank Budinsky, Marcelo Paternostro, Ed Merks. EMF: Eclipse Modeling Framework, 2nd Edition, ISBN-13: 978-0-321-33188-5, Addison-Wesley Professional, 2009- Martin Fowler, Rebecca Parsons. Domain Specific Languages, ISBN-13: 978-0-3217-1294-3, Addison-Wesley, 2010', '<h2>Zielgruppe:</h2>\nStudierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. Studierende mit Nebenfach Informatik.   \n\n<h2>Voraussetzungen:</h2>\n Grundlagen der Programmierung. Erfolgreiche Teilnahme an der Veranstaltung "Softwaretechnik".   \n\n<h2>Homepage</h2>\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungModellgetriebeneSoftwareentwicklungWS1213">https://www.inf.fu-berlin.de/w/SE/VorlesungModellgetriebeneSoftwareentwicklungWS1213</a>', '086bA5.2', 3, 1, 1, '2014-05-19 09:07:50'),
(74, 'New Trends in DB', '', '', '', '', '086bA5.3', 3, 1, 4, '2014-05-19 09:10:21'),
(75, 'Datenschutz', 'Hintergrund der Datenschutzdiskussion (USA in den 60er Jahren unter Rückgriff auf Privacy-Diskussion Ende des 19. Jahrhunderts), deutsche Regelungsmodelle in den 70ern- Aktuelle Debatte zur "Überwachungsgesellschaft"- Grundlagen des Datenschutzrechts- Technische Anforderungen- Datenschutz im öffentlichen/nichtöffentlichen Bereich- Betroffenenrechte- Kontrollsystem und Sanktionen- Spezialrechtliche Aspekte (z.B. Sicherheit, Sozialwesen, Telekommunikation, Überwachung am Arbeitsplatz)Prof. Garstka ist der frühere Berliner Datenschutzbeauftragte.', NULL, NULL, NULL, '086bA5.11', 3, 1, 4, '2014-05-19 09:13:13'),
(76, 'Seminar Echtzeitsysteme', 'Ein Echtzeitsystem ist ein informatisches System, dessen Verhalten nicht nur von den Eingaben abhängt, sondern auch von der Zeit. Dieser Zeit ist hier die physikalische Zeit ausserhalb des Systems und eben nicht die logische Zeit, wie sie ein Rechner vorgibt. Daraus ergeben sich für die Entwicklung eines Echtzeitsystems neue Anforderungen und auch Methoden, insbesondere in Bezug auf die Verwaltung von Betriebsmitteln und die Ablaufplanung. Denn nicht nur die Funktionalität ist hier wichtig, vor allem die Vorhersagbarkeit der Zeit von Ereignissen und Berechnungen sind hier wichtig. Auf Grundlage von Lehrbüchern und aktueller Forschungsarbeiten werden in diesem System diese Anforderungen und Methoden erarbeitet und vorgestellt. Zuerst betrachten wir die technische Realisierung in Echtzeitbetriebssystemen und erarbeiten die Methoden für die Ablaufplanung für aperiodische und periodische Aufgaben, sowie die Methoden für Überlastsituationen, in denen die Zeiteigenschaften nicht mehr garantiert werden können. Dann erarbeiten wir die formalen Sprachen und Methoden, mit denen Eigenschaften von Echtzeitsystemen beschrieben und validiert werden', '', '', '', '086bA1.41', 3, 1, 1, '2014-05-19 10:16:27'),
(77, 'Seminar Bildgebende Verfahren in der Medizin', 'Es werden aktuelle Themen aus dem Bereich Bildgebende Verfahren in der Medizin erarbeitet und präsentiert. Dazu zählen Anwendungen aus den Bereichen Radiographie, Computertomographie, Nuklearmedizin, Magnetresonanztomographie und Ultraschallbildgebung ', '', '', '<h2>Zielgruppe</h2>\nStudierende im Masterstudiengang\n<h2>Voraussetzungen</h2>Teilnahme an Vorlesung und Übungen Bildgebende Verfahren in der Medizin Homepage http://www.charite.de/medinfo/Studium/wahllehre.php', '089bA4.32', 3, 1, 1, '2014-05-19 10:18:29'),
(78, 'Chipkartentechnologie', '', '', 'Handbuch der Chipkarten ISBN-13: 978-3446404021 und individuell zusammengestellte wiss. Veröffentlichungen.', '<h2>Zielgruppe</h2>\nMasterstudenten/Diplomstudenten.\n<h2>Voraussetzungen:</h2>Kenntnisse in Kryptographie.', '089bA4.32', 3, 1, 4, '2014-05-19 10:21:18'),
(79, 'Seminar Vertrauenswürdige Systeme', 'Wir beschäftigen uns mit aktuellen Forschungsthemen im Bereich vertrauenswürdiger Systeme. Dabei verstehen wir vertrauenswürdige Systeme nicht nur als besonders sicherere Systeme, sondern als Systeme deren Funktionsweise transparent und für Benutzer nachvollziehbar ist. Herkömmlicherweise wird oft versucht, Sicherheit von Systemen zulasten einer Einschränkung seiner Benutzer zu etablieren: Im übertragenen Sinne ist das wie der Einsatz von dicken Stahltüren vor einem Banktresor zur Verhinderung von Diebstahl. Obwohl Panzertüren das Vertrauen eines Benutzers in das System Banktresor steigern, gilt der Umkehrschluss nicht. Aus Sicht der Bank gewähren die Stahltüren Sicherheit vor Personen denen sie ? eben nicht ? vertraut. Aus dieser Perspektive heraus ist Vertrauen ein Gegensatz zu Sicherheit: Bei hoher Systemsicherheit wird wenig Vertrauen gebraucht, bei starkem Vertrauen braucht man wenig Systemsicherheit ? Wenn niemand klaut, werden keine abgeschlossenen Türen gebraucht. Unsere Untersuchungen konzentrieren sich dabei auf die Frage, ob man durch geeignete informationstechnische Ansätze die Vertrauenswürdigkeit eines Systems so stärken kann, das restriktive Sicherheitsmechanismen unnötig werden.Auf diesem gedanklichen Fundament bewegen sich auch die zu bearbeitenden Forschungsthemen. Dabei geht es vorwiegend um die Bereiche: - Nachvollziehbarkeit von Informationsflüssen in vernetzten Umgebungen- Automatisierte Einschätzung des Wahrheitsgehalts von Informationen- Belegung der Authentizität von Informationsquellen- Mechanismen zum Aufbau und zur Verwaltung von Bewertungen und Vertrauenswerten- Nachvollziehbarkeit von Systemverwendung- Modellierung und Formalisierung von Vertrauen und Ansehen- Datenschutz und Schutz der Privatsphäre. ', '', 'Aktuelle und themenrelevante Veröffentlichungen im Rahmen von Doktorarbeiten, Fachzeitschriften und Konferenzbänden, beispielsweise:- Jennifer Golbeck (ed.). Computing with Social Trust, Human-Computer Interaction Series, DOI 10.1007/978-1-84800-356-9_1, Springer, 2009- Zaki Malik, Athman Bouguettaya, Trust Management for Service-Oriented Environments, ISBN 978-1-4419-0309-9, Springer, 2009- Karl Krukow. Towards a Theory of Trust for the Global Ubiquitous Computer, PhD Thesis, Department of Computer Science, University of Aarhus, Denmark, 2006- Jonathan M. McCune et al. (eds.). Proceedings of the 4th International Conference on Trust & Trustworthy Computing, Lecture Notes in Computer Science, Vol. 6740, Springer, 2011', 'Die Studierenden sollen zu jeweils einem Thema einen Vortrag auf Deutsch oder Englisch vorbereiten und ihn vor dem Seminar präsentieren. Anschließend findet eine kurze Diskussion zu dem Thema statt. Am Ende des Semesters ist eine schriftliche Ausarbeitung des Themas einzureichen.Es sollen aktuelle Forschungsthemen besprochen werden - als Vorbereitung für Bachelor- und Masterarbeiten nutzbar.\n\n<h2>Zielgruppe:</h2>Studierende im Master- oder Diplomstudiengang. Ab 3. Jahr Bachelorstudium. <h2>Voraussetzungen:</h2> Interesse am Thema, Fähigkeit zur eigenständigen Erarbeitung des Stoffs aus wissenschaftlichen Veröffentlichungen. \n<a href="https://www.inf.fu-berlin.de/w/SE/SeminarVertrauenswuerdigeSystemeWS1213">Homepage</a>', '089bA4.32', 3, 1, 4, '2014-05-19 10:24:44'),
(80, 'Seminar Opinion Mining and Sentiment Analysis', 'Opinion mining, also called sentiment analysis or sentiment classification is a kind of text classification. Its main task is to automatically obtain the people''s opinions towards certain object which might be a car, a product, a human or anything else. The result of the opinion mining will help not only individuals to decide upon their required object but also helps commercial sectors to improve their products, plans, marketing objectives by taking successful decisions. It also helps the government to improve the effectiveness of their service, and much more. Its importance lies in the fact that it provides the user with the related and the relevant information required automatically without bothering him to deal with a huge number of resulting documents most of which might be unrelated or even unrequited. By taking this seminar, students will learn what exactly the opinion mining and sentiment analysis is, what are the important and related areas that are working in association with opinion mining and sentiment analysis such as information retrieval, information extraction, machine learning classification algorithms and some preprocessing tasks from the area of natural language processing. ', '', '', '<h2>Zielgruppe:</h2> Studenten der Informatik im Master <h2>Voraussetzungen:</h2> Grundlagen des Information Retrievals oder Data Mining sind hilfreich', '089bA4.32', 3, 2, 4, '2014-05-19 10:27:37'),
(81, 'Text-Mining-Toolbox: Verfahren und Werkzeuge zur Textanalyse', '', '', '', '', 'E24nA1.1', 3, 1, 1, '2014-05-19 10:31:37'),
(82, 'Mustererkennung', 'Bayesche Verfahren der Mustererkennung, Clustering, Expectation Maximization, Neuronale Netze und Lernalgorithmen, Assoziative Netze, Rekurrente Netze. Computer-Vision mit neuronalen Netzen, Anwendungen in der Robotik.', '', 'wird noch bekannt gegeben', 'Grundkenntnisse in Mathematik und Datenstrukturen', '089bA1.11', 2, 1, 1, '2014-05-19 10:33:22'),
(84, 'Netzbasierte Informationssysteme', 'Der Kurs "Netzbasierte Informationssysteme" vermittelt Wissen über aktuelle Web Technologien und deren Einsatz zur Umsetzung modernen Web-basierter Informationssysteme. Die Vorlesung adressiert folgende vier Themengebiete: - Web Technologien (HTML 5, XML, Client- und Server-seitige Web Anwendungen, Web Services, Semantic Web) - Architektur, Struktur und Zugang zum Web (Web Architekturen, Web Anwendungen, Deep Web, Crawling und Indexing, ... ) - Web Suche (Information Retrieval, Suchmaschinenmethoden, Collaborative Filtering, Text/Web Mining, ...) - Corporate Semantic Web (Semantische Suche, Engineering, Kollaboration, Social-Semantic Web 3.0) In der zugehörigen Übung werden anhand von praktischen Aufgaben diese Web Technologien und Standards praktisch angewandt und die Teilnehmer lernen, wie damit moderne Web-basierte Informationssysteme implementiert werden können. Vorlesung: Dienstag, 14-16 Uhr, Takusstr. 9 SR06Übung: Mittwoch, 14-16 Uhr Takusstr. 9 SR05 ', '', 'Literatur noch nicht erfasst', 'Voraussetzungen Grundkenntnisse in Netzprogrammierung', '089bA1.12', 2, 2, 1, '2014-05-19 10:37:27'),
(85, 'Projektseminar Datenverwaltungssysteme', 'Entwicklung von Software in kleinen, unabhängigen Teams meist im Kontext von Forschungsvorhaben der Arbeitsgruppe DB&IS. Lesen wissenschaftlicher Literatur und Umsetzung in Sofwarelösungen. Regelmäßige Präsentation der Arbeitsergebnisse und des wissenschaftlichen Hintergrunds. Ein Projektseminar dient als Vorbereitung für eine Masterarbeit.', '', 'Wird jeweils individuell zusammengestellt (wiss. Veröffentlichungen)', '', '089bA1.13', 3, 2, 1, '2014-05-19 10:39:45'),
(86, 'Robotik', '<p>Der humanoide Roboter Myon (siehe <a href="http://www.neurorobotik.de/robots/myon_de.php">Neurorobotik</a>) wird 2015 in einer Bühnenproduktion der Komischen Oper mitwirken. Dafür wird er sehen, hören, sprechen, lernen und sich zielgerichtet bewegen müssen. Um diese Fähigkeiten implementieren zu können, stellt die Vorlesung aktuelle Algorithmen aus den folgenden fünf Themenblöcken vor: 1. Active Vision, 2. Sensomotorische Regelschleifen, 3. Audiosignalverarbeitung, 4. Verhaltensregelung und 5. Lernverfahren. Die vorlesungsbegleitenden Übungen werden zum Teil mit realen Robotern und Versuchsaufbauten durchgeführt. Es werden außer mathematischen Grundkenntnissen der Analysis und linearen Algebra keine speziellen Vorkenntnisse erwartet.</p>', '', '<p>Handbook of Robotics (partially online at Googlebooks) <br>\n  Robotics: modelling, planning and control,  by Bruno Siciliano, Lorenzo Sciavicco, Luigi Villani <br>\n LaValle''s Planning Algorithms <br>\nRobot Modeling and Control  </p>', '<h2>Vorausetzungen:</h2>\n<p>Students interested in robotics and the synthetic approach to artificial intelligence.   As a prerequisite, student should have basic knowledge of maths, in particular linear algebra and a bit of optimization.</p>\n', '089bA1.14', 2, 2, 1, '2014-05-19 10:42:37'),
(87, 'Seminar Datenverwaltung', ' Location-based services are now often part of every day''s life through applications such as navigation assistants in the public or private transportation domain. The underlying technology deals with many different aspects, such as location detection, information retrieval, or privacy. More recently, aspects such as user context and preferences were considered in order to send users more personalized information. This seminar aims at studying the last trends in location-based services technology. Very important: Registering in advance, attending the first session - as well as *all student talks* during the seminar - is mandatory. Zielgruppe Vertiefung im Gebiet Datenverwaltung. Voraussetzungen Mindestens eine vertiefende Veranstaltung im Bereich Datenverwaltung / Informationssysteme.', '', 'Wird noch bekannt gegeben', '', '089bA1.18', 3, 2, 1, '2014-05-19 10:44:26'),
(88, 'Seminar Data Visualization and Mining', '', '', 'Wird noch bekannt gegeben', '<h2>Zielgruppe:</h2>\nVertiefung im Gebiet Datenverwaltung', '089bA1.18', 3, 2, 1, '2014-05-19 10:45:48'),
(89, 'Algorithmen und Technologien im RoboCup', 'Aktuelle Algorithmen und Technologien im RoboCup-Forschungsumfeld werden erarbeitet und vorgestellt. Folgende Themen stehen u.a. zur Auswahl:\n<ul><li>reconstruction of real-world images</li><li>model-free reinforcement learning</li><li>footstep planning for humanoid robots</li><li>object tracking with sparse observations</li><li>multi-agent planning and coordination ', '', 'Je nach Seminarthema', '<h2>Zielgruppe:</h2>Studierende ab dem 5. Semester <h2>Voraussetzungen</h2>Interesse an künstlicher Intelligenz/Robotik', '089bA1.19', 3, 1, 1, '2014-05-19 10:49:39'),
(90, 'Expressive Klassische und Nichtklassische Logiken und deren Automatisierung', 'Im Fokus dieses Seminars stehen ausdrucksstarke klassische und nichtklassische Logiken, beispielsweise: Klassische Logik höherer Stufe, Quantifizierte Modallogiken (einschliesslich Temporallogiken), Quantifizierte Konditionale Logiken, Quantifizierte Mehrwertige Logiken, usw. \n\nDiese Logiken sind von grossem Interesse für die Informatik, die Künstliche Intelligenz, die Philosophie und die Computerlinguistik. Ihre Automatisierbarkeit ist allerdings als sehr schwierig einzustufen, was praktische Anwendungen bisher weitgehend ausschloss. \n\nWir werden die Theorie einiger solcher expressiven Logiken skizzieren und aktuelle Fortschritte hinsichtlich ihrer Mechanisierung und Automatisierung diskutieren. \n\nEs ist geplant, dass in diesem Seminar auch verschiedene externe Wissenschaftler Vorträge anbieten.', '', '', '<h2>Zielgruppe:</h2>\nStudenten mit Interesse an Logic und Deduktionssystemen\n<h2>Voraussetzungen:</h2>\nStudenten ab dem 5. Semester, Grundkenntnisse und Logik und theoretischer Informatik \n<br>\nsiehe provisorische <a href="http://page.mi.fu-berlin.de/cbenzmueller/2013-ExLog/">Webseite</a>', '089bA1.19', 3, 1, 1, '2014-05-19 10:53:08'),
(91, 'Kalibrierung und Selbstkalibrierung von Sensoren in der Robotik', 'Das Seminar kann als Vorbereitung für eine Bachelor- oder Masterarbeit in dem Forschungsprojekt "Plug and Sense" dienen. Aktuelle Themen aus dem Gebiet der Kalibrierung und Selbstkalibrierung werden erarbeitet und vorgestellt.', '', 'Wird jeweils individuell zusammengestellt (wiss. Veröffentlichungen)', 'Kenntnisse in Computer Vision und/oder Robotik', '089bA1.19', 3, 1, 1, '2014-05-19 10:54:35'),
(92, 'Seminar über Programmiersprachen', 'In diesem Seminar werden ausgewählte Konferenz- und Zeitschriftenbeiträge über Programmiersprachen in Einzel- oder Doppelreferaten von Studierenden vorgetragen. Ausgewählte Themen aus den theoretischen und praktischen Grundlagen der Programmiersprachen sowie die wissenschaftliche Fundierung von diversen weniger gängigen Programmierparadigmen wie die Aspektorientierung oder das synchrone Paradigma werden in den Vorträgen behandelt.<br>\n\nIm Anschluss an jedes Referat findet eine ausführliche Diskussion statt, an der sich möglichst alle Teilnehmer beteiligen sollen. Zur Vorbereitung auf diese Diskussion muss allen Teilnehmern eine schriftliche Ausarbeitung des Referats rechtzeitig zur Verfügung gestellt werden.', '', 'wechselnd', 'Homepage: <a href="http://www.inf.fu-berlin.de/lehre/WS13/Sem-Prog/organisation.php">Programmiersprachen</a>', '089bA1.20', 3, 1, 1, '2014-05-19 10:58:18'),
(95, 'Softwareprozesse', 'Diese Veranstaltung vertieft das Wissen über die Gestaltung von Softwareprozessen. Wir sprechen über\n<ul>\n   <li>Prozesse für hochkritische Software ("Cleanroom Software Engineering")</li>\n   <li>Prozesse für Projekte mit unklaren oder schnell veränderlichen Anforderungen ("Agile Methoden")</li>\n   <li>ein für viele Zwecke zuschneidbares Prozessmodell ("V-Modell XT")</li>\n   <li>Prozesse für die verteilte Kollaboration von Freiwilligen ("Open-Source-Entwicklung")</li>\n   <li>Prozessreife und Prozessverbesserung ("CMMI")</li>\n   <li>spezielle Vorgehensweisen dabei ("Messen und Maße")</li>\n   <li>und über ein zentrales Phänomen im Zusammenhang mit Softwarequalität und Produktivität: Fehler und Defekte</li>\n   <li>Ferner besprechen wir die Rolle von Softwarewerkzeugen im Softwareprozess und einen Überblick über taugliche Werkzeuge für die verschiedensten Zwecke.</li>\n</ul>\nDie Teilnehmenden lernen, die Tauglichkeit gewisser Prozessmerkmale für gegebene Zwecke und Situationen zu beurteilen und erwerben somit die Fähigkeit, Softwareprozesse zu analysieren und sinnvolle Verbesserungen vorzuschlagen.   ', '', '', '<h2>Zielgruppe</h2>\r\nStudierende mit Hauptfach Informatik   \r\n\r\n<h2>Voraussetzungen</h2> \r\nGrundkenntnisse in Softwaretechnik   \r\n\r\n<h2>Homepage</h2>\r\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungSoftwareprozesse2013">https://www.inf.fu-berlin.de/w/SE/VorlesungSoftwareprozesse2013</a>', '089bA1.25', 2, 1, 1, '2014-05-19 11:06:58'),
(96, 'Spezielle Aspekte der Datenverwaltung: Spatial Databases', '<strong>ENGLISH:</strong><br>The goal of this course is to acquire the background of spatial databases, the kernel of Geographic Systems. The major aspects that will be handled are: modeling and querying geospatial information, spatial access methods (SAMs), data representation, basic operations (mostly from computational geometry), and optimization. Insights into current applications such as location-based services (e.g., navigation systems) will also be given. Knowledge in databases is necessary. This course encompasses: formal lectures, exercises, as well as a practical project with PostGIS.\n<br>\n<strong>GERMAN:</strong><br>Diese Vorlesung dient der Einführung in raumbezogene Datenbanken, wie sie insbesondere in geographischen Informationssystemen (GIS) Verwendung finden. Schwerpunkte sind u.a. die Modellierung raumbezogener Daten, Anfragesprachen und Optimierung sowie raumbezogene Zugriffsmethoden und Navigationssysteme ("Location-based services"). Grundwissen in Datenbanken ist erforderlich. Die Vorlesung beinhaltet Übungsblätter und Rechnerpraktika mit PostGIS. ', '', 'Handouts are enough to understand the course. The following book will be mostly used:P. Rigaux, M. Scholl, A. Voisard.Spatial Databases - With Application to GIS. Morgan Kaufmann, May 2001. 432 p.(copies in the main library)', '<h2>Zielgruppe:</h2>Studierende im Masterstudiengang. <br>\r\n<h2>Voraussetzungen:</h2>Vorlesung: Einf. in Datenbanksysteme.\r\n<br>\r\n<h2>Sonstiges:</h2> Die Vorlesung wird in englischer Sprache gehalten.', '089bA1.26', 3, 1, 1, '2014-05-19 11:11:19'),
(97, 'Telematik', 'Telematik ist Telekommunikation mit Hilfe von Mitteln der Informatik und befasst sich mit Themen der technischen Nachrichtenübertragung, Rechnernetze, Internet-Techniken, WWW, und Netzsicherheit. Behandelte Themen sind unter anderem folgende: ?Allgemeine Grundlagen: Protokolle, Dienste, Modelle, Standards, Datenbegriff; Nachrichtentechnische Grundlagen: Signale, Codierung, Modulation, Medien; Sicherungsschicht: Datensicherung, Medienzugriff; Lokale Netze: IEEE-Standards, Ethernet, Brücken; Vermittlungsschicht: Wegewahl, Router, Internet-Protokoll (IPv4, IPv6); Transportschicht: Dienstgüte, Flussteuerung, Staukontrolle, TCP; Internet: Protokollfamilie rund um TCP/IP; Anwendungen: WWW, Sicherheitsdienste, Netzwerkmanagement; Konvergenz der Netze: neue Dienste, Dienstgüte im Internet, Multimedia. Voraussetzungen Grundkenntnisse im Bereich Rechnersysteme', '', 'Larry Peterson, Bruce S. Davie: Computernetze - Ein modernes Lehrbuch, dpunkt Verlag, Heidelberg, 2000 Krüger, G., Reschke, D.: Lehr- und Übungsbuch Telematik, Fachbuchverlag Leipzig, 2000 Kurose, J. F., Ross, K. W.: Computer Networking: A Top-Down Approach Featuring the Internet, Addi-son-Wesley Publishing Company, Wokingham, England, 2001 Siegmund, G.: Technik der Netze, 4. Auflage, Hüthig Verlag, Heidelberg, 1999 Halsall, F.: Data Communi-cations, Computer Networks and Open Systems 4. Auflage, Addison-Wesley Publishing Company, Wokingham, England, 1996 Tanenbaum, A. S.: Computer Networks, 3. Auflage, Prentice Hall, Inc., New Jersey, 1996', '', '089bA1.27', 2, 1, 1, '2014-05-19 11:13:36'),
(98, 'Übersetzerbau', 'Ein Übersetzer ist ein Programm, das Programme einer höheren Programmiersprache in eine andere Programmiersprache (im allgemeinen Maschinensprache) überführt. In der Regel erfolgt die Übersetzung in mehreren Phasen, wovon die wichtigsten die lexikalische Analyse, die Syntaxanalyse, die semantische Analyse und die Codeerzeugung sind. Mit Hilfe der lexikalischen und syntaktischen Analyse wird das Quellprogramm in eine computergerechte Repräsentation überführt (abstrakter Syntaxbaum). Diese Repräsentation wird dann als Ausgangspunkt für Optimierungen und Codeerzeugung verwendet. Die hier vorgestellten Verfahren finden an vielen Stellen in der Informatik Anwendung. Deshalb ist dieses Thema auch für solche Hörer von Interesse, die nie vorhaben, einen Übersetzer zu schreiben. Homepage http://www.inf.fu-berlin.de/lehre/WS13/Uebersetzerbau/index.html', '', 'Zur Beschaffung empfohlen: Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman: Compilers - Principles, Techniques , & Tools, Pearson International Edition, 2007 Die deutsche Version wegen Mängel in der Übersetzung nicht so sehr zu empfehlen: Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman: Compiler, Pearson Studium, 2008 Helmut Seidl: Compilerbau, TUM, SS08 Pat D Terry: Compiling with C# and Java, Pearson Education 2005 Reinhard Wilhelm, Dieter Maurer: Übersetzerbau - Theorie, Konstruktion, Generierung, Springer-Verlag, 2. Auflage 1997 Niklaus Wirth: Grundlagen und Techniken des Compilerbaus, 3. Auflage, Oldenbourg-Verlag, 2011', 'Grundkenntnisse in Automatentheorie, Formalen Sprachen, Rechnerorganisation und Programmiersprachen\n<br>\nDie Vorlesung gehört zum Studienbereich "Praktische Informatik" <a href="http://www.inf.fu-berlin.de/lehre/WS13/Uebersetzerbau/index.html">Homepage</a>', '089bA1.29', 2, 1, 1, '2014-05-19 11:16:44'),
(99, 'Seminar Datenbanksysteme: Location and Privacy', 'Anhand von wissenschaftlichen Veröffentlichungen werden aktuelle Themen der Datenbanksysteme vorgestellt und diskutiert. Den jeweiligen thematischen Schwerpunkt kann man der Ankündigung entnehmen', '', 'Wechselnd', '<h2>Voraussetzungen</h2> Grundkenntnisse aus dem Bereich Datenbanksysteme', '089bA1.33', 3, 1, 1, '2014-05-19 11:21:19'),
(100, 'Seminar Netzwerke', '', '', '', '', '089bA1.34', 3, 1, 1, '2014-05-19 11:22:27'),
(101, 'Aktuelle Forschungsthemen der Algorithmik: Advanced Algorithms II', 'Advanced algorithmic techniques for solving hard problems: - Linear Programming techniques - theory: Duality, Farkas Lemma, Simplex, Ellipsoid method, etc. - applications (how to use LP): approximation algorithms, fixed-parameter tractable algorithms, Zero_sum Games, etc. - Integer Programming techniques (Problem modelling, Branch and Bound method, Cutting Planes, etc.) - Fixed-parameter (in)tractablity, exponential time algorithms for graph problems: - bounded search trees - dynamic programming on tree decompositions - graph minors (introduction) - color coding - iterative compression, etc. - Iterative methods, heuristics, etc. Zielgruppe This is a course for graduate students (on the PhD and the master level) working in Computer Science or Discrete Mathematics. Voraussetzungen Prerequisite: Höhere Algorithmik.Participants are expected to have good knowledge in (at least one of): discrete mathematics, graph theory, algorithmic geometry, or general algorithms and complexity. The language of the course is English.', NULL, 'Understanding and Using Linear Programming, J. Matou?ek and B. Gärtner, Springer 2006. Introduction to Linear Optimization, Dimitris Bertsimas, John N. Tsitsiklis, Athena Scientific, 1997. Parameterized Complexity Theory, Flum, Grohe, Springer, 2006. Invitation to Fixed-Parameter Algorithms, Niedermeier Oxford University Press, 2006.', NULL, '089bA2.1', 3, 2, 2, '2014-05-19 11:24:35'),
(102, 'Ausgewählte Themen der Algorithmik: Datenkompression', 'Die wachsende Kapazität von Massenspeichern und Übertragungskapazitäten läuft um die Wette mit steigenden Datenmengen; daher ist Datenkompression nach wie vor ein interessantes Gebiet. \n<br><br>\n<b>Inhalt:</b>\n<ul>\n<li>Theoretische Grundlagen: Informationstheorie, Kolmogoroff-Komplexität. \n</li><li>Verschiedene Arten der Kompression: lustlose und lustbehaftetete, adaptive und progressive \n  Kompression. \n</li><li>Vektorquantisierung. \n</li><li>Kompression für verschiedenartige Daten: "reine" Binärdaten, Text, Bilder, Klänge, Geometrie. \n</li><li>Verschiedene Verfahren: unter anderem effiziente Codes, Wavelets, iterierte Funktionssysteme (IFS), gewichtete Automaten.\n</li></ul>', NULL, NULL, NULL, '089bA2.3', 3, 2, 2, '2014-05-19 11:26:47'),
(103, 'Höhere Algorithmik', '<b>Inhalt:</b> Es werden Themen wie:<br>\n<ul>\n<li>allgemeine Algorithmenentwurfsprinzipien \n</li><li>Flussprobleme in Graphen,  \n</li><li>zahlentheoretische Algorithmen (einschließlich RSA Kryptosystem), \n</li><li>String Matching, \n</li><li>NP-Vollständigkeit \n</li><li>Approximationsalgorithmen für schwere Probleme, \n</li><li>arithmetische Algorithmen und Schaltkreise sowie schnelle Fourier-Transformation\n</li></ul><br>\nbehandelt.', NULL, '<b>Literatur</b>\n<ul><li>Cormen, Leiserson, Rivest, Stein: Introduction to Algorithms, 2nd Ed. McGraw-Hill 2001</li>\n<li>Kleinberg, Tardos: Algorithm Design Addison-Wesley 2005.</li></ul>', '<b>Zielgruppe:</b> alle Masterstudenten und Bachelorstudenten die sich in Algorithmen vertiefen wollen.\n<br>\n<b>Voraussetzungen</b> Grundkenntnisse im Bereich Entwurf und Analyse von Algorithmen ', '089bA2.4', 2, 1, 2, '2014-05-19 11:29:46'),
(104, 'E-Learning-Plattformen', 'E-Learning-Plattformen umfassen Funktionen für Mitglieder- und Gruppenverwaltung, Rollenverwaltung, Gestaltung von Inhaltsbereichen, Tests und Umfragen, synchrone und asynchrone Kommunikation (Mail, Chat, Foren), Datenablage und -austausch und Vieles mehr. Sie bilden damit den Präsenzunterricht ab und implizieren somit auch ein didaktisches Lehr-Lern-Modell. Die Teilnehmer/innen des Kurses werden in verschiedenen E-learning-Plattformen kleine Kurse mit eigenen Inhalten modellieren. Die jeweils anderen Teilnehmer/innen übernehmen dann die Rolle der Lernenden. Unsere Aktivitäten in dem Kurs: Vergleich und Untersuchung aktueller E-Learning-Umgebungen wie Blackboard, ILIAS, FLE, Moodle, Claroline, etc. Aufgabe: Erstellung eines kleinen Kurses in einer dieser Plattformen und Vorbereitung und Durchführung einer Lernphase mit den anderen Teilnehmern. Die Gestaltung, Durchführung und Auswertung dieses eigenen Kurses ersetzt die sonst für die Leistungserbringung übliche schriftliche Ausarbeitung. Alternative Aufgabe: systematische Vorstellung meist einer Lernplattform und ihrer jeweiligen Charakteristika. Einige E-Learning-Plattformen haben komplexe Funktionen z.B. im Bereich der Tests und der Bewertung. Dies können ebenfalls Themen für systematische Vorträge sein. Für solche systematischen Vorträge muss für die Leistungserbringung eine Ausarbeitung vorgelegt werden. Zielgruppe Geeignet für Teilnehmer/innen aller Fachbereiche: Interessenten an multimedialem Web-basiertem Lernen; speziell: Lernkurs-Entwickler, die nach einer Plattform-unabhängigen Autorenumgebung für Web-basiertes Lernen suchen. Dieser Kurs ist Bestandteil des Moduls E-Learning/digitales Video (plus Praktikum) und des Moduls E-Learning (plus Praktikum) des neuen Lehrer-Masters und daher auch für Lehramtstudierende offen.', '', 'Information und Lernen mit Multimedia. L.J.Issing, P.Klimas, Hrsg. Beltz-Verlag. ISBN 3-671-27374-3. (Es gibt eine neuere Ausgabe!) Lernplattformen für das virtuelle Lernen. R.Schulmeister. Oldenbourg-Verlag. ISBN 3-486-27250-0 Homepage http://www.mi.fu-berlin.de/zdm/lectures/lernplatt/', '', '089bA4.6', 3, 1, 4, '2014-05-19 11:35:15'),
(105, 'Projektmanagement', 'Nahezu jeder Absolvent eines Informatikstudiums wird in seiner beruflichen Tätigkeit mit der Organisation von Entwicklungsarbeiten in Projektform in Kontakt kommen und viele der Karrierepfade von Informatikern führen über die Leitung von mehr oder weniger großen Projekten. Für alle der im Rahmen der Projektabwicklung aufretenden Probleme gibt es eine Reihe von Vorgehensweisen und Werkzeugen, die sich in der Praxis als erfolgreich erwiesen haben. Das Project Management Institute (www.pmi.org) hat diese im "Guide to the Project Management Body of Knowledge" (PMBoK Guide) als ANSI-Standard zusammengefasst und in der inzwischen vierten Auflage veröffentlicht. Mit dieser systematischen Vorlage werden in der Vorlesung die einzelnen Prozesse in der Projektabwicklung während des typischen Lebenszyklus eines Projekts behandelt und an Hand von Beispielen aus der Praxis diskutiert.', '', '', '<a href="http://www.inf.fu-berlin.de/lehre/mhorn/PM/">Homepage</a>', '089bA1.37', 3, 1, 4, '2014-05-19 11:39:19'),
(106, 'Existenzgründungen in der IT-Industrie', 'Erfolgreiche Geschäftsmodelle - Goldene Regeln der Existenzgründung - Businessplan - Finanzierung - Rechtsform - Marketing Diese theoretischen Grundlagen werden in Form von Referaten vermittelt. Im praktischen Teil des Kurses entwickeln die Teilnehmer in Teams ein eigenes Geschäftsmodell und formulieren hierfür einen detaillierten Businessplan. Jedes Team stellt seinen Businessplan im Rahmen eines Businessplan-Wettbewerbs mit externen Gutachtern aus der Gründerbranche vor. Der Kurs wird durch Gastvorträge von Praktikern abgerundet. Literatur Miroslaw Malek und Peter K. Ibach, Entrepreneurship, dpunkt.verlag, 2004. Carl Shapiro und Hal R. Varian, Information Rules, Harvard Business School Press, 1998', '', '', '', '089bA1.27', 3, 1, 4, '2014-05-19 11:43:01'),
(107, 'Stochastic Models for System Validation', '', '', '', '', '086bA5.25', 3, 1, 2, '2014-05-19 11:44:42'),
(108, 'Wie sicher wollen wir leben? - Sicherheitsforschung im Dialog', 'Das Thema: Öffentliche Sicherheit ist ein Querschnittsthema, dass sowohl in der naturwissenschaftlich-technischen als auch geistes- und sozialwissenschaftlichen Forschung eine hohe Relevanz beinhaltet.\n\nSicherheit ist nicht nur abhängig von unseren Möglichkeiten mit technischen, natürlichen und gesellschaftlichen Bedrohungen und Herausforderungen umzugehen. Sicherheit ist ebenso abhängig von unseren Werten, Wahrnehmungen und Überzeugungen. Veränderungen wie Klimawandel, Globalisierung oder Digitalisierung zeigen, dass sich die Rahmenbedingungen verändert haben und Sicherheit heute eine gesamtgesellschaftliche Aufgabe ist.\n\nWie sicher wollen wir leben? Unter dieser Fragestellung spiegelt die Ringvorlesung das gesamte Spektrum, vom technisch Möglichen bis hin zum gesellschaftlich Akzeptierten wider und diskutiert eine neue Sicherheitskultur.', '', '', '', '086bA5.31', 3, 1, 4, '2014-05-19 11:47:07'),
(109, 'Computational Network Analysis', '<p>Das World Wide Web basiert auf formal definierten Sprachen und Protokollen, aber erst durch die Nutzung des Webs durch die Erstellung von Webseiten und den Einsatz von Anwendungen wie beispielsweise Blog-Plattformen, Social Networking Services wie Facebook und Twitter, aber auch Wikipedia entsteht der Mehrwert. Dieser Mehrwert basiert auf der Wechselbeziehung von Inhalte, die durch Millionen von Individuen und Organisationen erzeugt und genutzt werden und der zugrundliegenden Technologie.</p>\n<br>\n<p>In dieser Veranstaltung werden Sie die zentralen Konzepte und Ansätze der Analyse von sozialen und Informationsnetzwerken anhand von bestehenden Forschungserkenntnissen kennenlernen. Die praktische Anwendung des Erlernten erfolgt innerhalb eines eigenständigen Projekts..</p>\n<br>\n<p>Wir werden uns unter anderem mit folgenden Themen beschäftigen:.</p><ul>\n<li>- Networke: Basiskonzepte, Definitionen, Modelle<l i="">\n</l></li><li>- Struktur des Webs<l i="">\n</l></li><li>- Community Detection, Modularität und Overlapping Communities<l i="">\n</l></li><li>- Informationsverbreitung in Netzwerken<l i="">\n</l></li><li>- Dynamische Netzwerkanalyse<l i="">\n</l></li></ul>\n<br>\n<p>Im Rahmen des Praktikums werden sich Studierende mit einem Themenbereich aus dem Bereich der Komplexen Netzwerke auseinandersetzen und sich dazu mit bestehenden wissenschaftlichen Artikeln beschäftigen. Unter Nutzung von Beispieldatensätzen werden Studierende sich in ausgewählte Themenbereiche eigenständig einarbeiten. Zum Einsatz sollen dazu vor allem die Programmiersprache und Softwareumgebung R für statistisches Rechnen mit ihren unterschiedlichen Netzwerkbibliotheken als auch die Python Softwarepaket NetworkX kommen.</p>', NULL, NULL, '<h2>Voraussetzungen:</h2>\n<p>Studierende am Ende ihres Bachelorstudium (&gt; 4 Semester) und Studierende im Masterstudiengang Informatik oder aus verwandten Disziplinen (Mathematik, Bioinformatik)</p>\n<h2>Zusätzliche Informationen:</h2><p>Es handelt sich um eine zweiwöchige Blockveranstaltung</p>', '086bA5.92', 3, 1, 5, '2014-05-19 11:53:48'),
(110, 'Anwendungssysteme', '<p>\nDiese Veranstaltung behandelt Auswirkungen der Informatik. Sie will ein Verständnis dafür zu wecken, dass und wie Informatiksysteme in vielfältiger Weise in unser privates und professionelles Leben eingreifen und es erheblich prägen. Viele dieser Wirkungen bergen erhebliche Risiken und benötigen eine bewusste, aufgeklärte Gestaltung, bei der Informatiker/innen naturgemäß eine besondere Rolle spielen -- oder jedenfalls spielen sollten. </p><p>Als Themenbereiche werden wir beispielsweise betrachten, wie die Computerisierung unsere Privatsphäre beeinflusst, Wirtschaft und Gesellschaft im Ganzen, unsere Sicherheit und unser Arbeitsumfeld. Davor steht eine konzeptionelle Einführung, was es bedeutet Orientierungswissen zusätzlich zu Verfügungswissen zu erlangen und wie man damit umgehen sollte: kritisch mitdenken und sich in die Gestaltung der Technik einmischen.</p>', '', '<ul>\n<li>Rob Kling: "Computerization and Controversy: Value Conflicts and Social Choices", 2nd ed., Academic Press 1996</li>\n<li>Sara Baase: "A Gift of Fire: Social, Legal, and Ethical Issues for Computing and the Internet", 3rd ed., Pearson 2009</li></ul>', '<h2>Weitere Informationen:</h2>\n<p>ABV 3-wöchiger Blockkurs in den Semesterferien</p>\n<h2>Voraussetzungen:</h2><p>ALP II oder Informatik B</p>\n<h2>Zielgruppe:</h2>\n<p>Studierende im Bachelor-Studiengang Studierende im lehramtsbezogenen Bachelorstudiengang mit Informatik als Kernfach oder als Zweitfach.</p>\n<a href="https://www.inf.fu-berlin.de/w/SE/VorlesungAnwendungssysteme2013"><h2>Homepage</h2></a>', '159bA1.1', 1, 1, 1, '2014-05-21 03:50:21'),
(111, 'Softwaretechnik', '<p>Softwaretechnik (oder englisch Software Engineering) ist die Lehre von der Softwarekonstruktion im Großen, also das Grundlagenfach zur Methodik.</p>\n<p>Die Softwaretechnik ist bemüht, Antworten auf die folgenden Fragen zu geben:</p>\n<ul>\n<li>Wie findet man heraus, was eine Software für Eigenschaften haben soll (Anforderungsermittlung)?</li>\n<li>Wie beschreibt man dann diese Eigenschaften (Spezifikation)?</li>\n<li>Wie strukturiert man die Software so, dass sie sich leicht bauen und flexibel verändern lässt (Entwurf)?</li>\n<li>Wie verändert man Software, die keine solche Struktur hat oder deren Struktur man nicht (mehr) versteht (Wartung, Reengineering)?</li>\n<li>Wie deckt man Mängel in Software auf (Qualitätssicherung, Test)?</li>\n<li>Wie organisiert man die Arbeit einer Softwarefirma oder -abteilung, um regelmäßig kostengünstige und hochwertige Resultate zu erzielen (Prozessmanagement)?</li>\n<li>Welche (großenteils gemeinsamen) Probleme liegen allen diesen Fragestellungen zu Grunde und welche (größtenteils gemeinsamen) allgemeinen Lösungsansätze liegen den verwendeten Methoden und Techniken zu Grunde?</li>\n<li> \n</li></ul>\n<p>...und viele ähnliche mehr.</p>\n<p>Diese Vorlesung gibt einen Überblick über die Methoden und stellt essentielles Grundwissen für jede/n ingenieurmäßig arbeitende/n Informatiker/in dar.\n</p><p>Genauere Information siehe Verweis in</p>', '', '<p>Bernd Brügge, Allen Dutoit: Objektorientierte Softwaretechnik mit UML, Entwurfsmustern und Java, Pearson 2004. </p>\n<a href="http://www.inf.fu-berlin.de/w/SE/TeachingHome">\nhttp://www.inf.fu-berlin.de/w/SE/TeachingHome.</a>', '<h2>Weitere Informationen:</h2>\n<p>ABV 3-wöchiger Blockkurs in den Semesterferien</p>\n<h2>Voraussetzungen:</h2><p>ALP III oder Informatik B</p>\n<h2>Zielgruppe:</h2>\n<ul>\n<li>Pflichtmodul im Bachelorstudiengang Informatik </li>\n<li>Wahlpflichtmodul im Nebenfach Informatik </li>\n<li>Studierende im lehramtsbezogenen Masterstudiengang (Großer Master mit Zeitfach Informatik) können dieses Modul zusammen mit dem "Praktikum SWT (19516c)" absolvieren und ersetzen damit die Module "Netzprogrammierung" und "Embedded Internet"   </li>\n</ul>\n<a href="http://www.inf.fu-berlin.de/w/SE/VorlesungSoftwaretechnik2014">\nhttp://www.inf.fu-berlin.de/w/SE/VorlesungSoftwaretechnik2014</a>', '159bA1.2', 1, 1, 1, '2014-05-21 03:57:39'),
(112, 'Professionelle Softwareentwicklung', '', '', '', '', 'keine Angabe', 3, 1, 5, '2014-05-26 05:35:24'),
(113, 'Forschungspraktikum Indoorlokalisierung', '<div>Die Arbeitsgruppe Technische Informatik beschäftigt sich mit der \nLokalisierung von Personen oder Objekten innerhalb von Gebäuden\ndurch drahtlose Sensornetzwerke. Durch Distanzmessung im 2,4 GHz \nBand über Bestimmung der Funklaufzeiten zwischen einem mobilen, \nzu lokalisierenden Knoten und festen Ankerknoten kann über\nLokalisierungsalgorithmen eine geschätzte Position berechnet werden.\nDa die Signale Reflektionen (multi-path) und Pfadverlusten (path loss) \nunterliegen, ist es von besonderem Interesse sowohl die Hardware als \nauch die Lokalisierungsalgorithmen in verschiedenen Gebäuden unter \nverschiedenen Bedingungen zu testen. Um die Resultate bewerten zu können,\nwird der mobile Knoten während der Datenaufzeichnung auf einem Roboter \nplatziert, welcher den zur Verfügung stehenden Freiraum selbstständig \nund systematisch abfährt. Zu den Fragestellungen zählt sowohl der \nEinfluss des Gebäudeaufbaus als auch die un-/vorteilhafte Platzierung der Ankerknoten.</div>\n<br>\n<div>\nIn diesem Forschungspraktikum sollen zunächst Grundlagen im Umgang mit mobilen Robotern \n(Robot Operating System) und Grundlagen bzw. Eigenschaften der funkbasierten\nIndoorlokalisierung im drahtlosen Sensornetzwerk erlernt werden. Anschließend werden \nselbstständig Experimente in verschiedenen Gebäuden und Szenarien durchgeführt. Die\naufgezeichneten Daten werden analysiert und bewertet. Erfahrungen und Ergebnisse \nwerden zum Abschluss als Präsentationen analysiert und diskutiert.</div>', '', '', '', 'keine Angabe', 3, 1, 1, '2014-05-31 06:53:08'),
(114, 'Seminar Technische Informatik', '<div>\nDas Modul Seminar Technische Informatik vertieft anhand von aktueller Forschungsliteratur ein Thema aus dem Bereich der Technischen Informatik. Studierende sollen, basierend auf diversen Forschungsergebnissen und eigenständiger Materialsuche eine 12-15-seitige Ausarbeitung erstellen, welche wissenschaftlichen Ansprüchen an Inhalt und Aufbau genügt. Weiterhin ist ein ca. 30-minütiger Vortrag zu erstellen, der die Kernaussagen der Ausarbeitung weitergibt. Im Rahmen des Seminars werden ebenso Review-Techniken eingeübt, welche die Arbeiten der anderen Teilnehmer bewerten sollen</div>', '', '<p>je nach Thema</p>', '', '089bA3.6', 3, 1, 2, '2014-05-31 06:56:02'),
(115, 'Brückenkurs Mathematische Grundlagen', '<div>Mathematisch-logisches Denken ist eine wichtige Grundlage für die Beschäftigung mit Problemen der Informatik. Da hinsichtlich dieser Voraussetzungen in den letzten Jahren in den Informatik-Anfängervorlesungen einige Defizite deutlich wurden, wendet sich dieser Brückenkursan an alle Studienanfänger der Informatik und Bioinformatik sowie an Studierende mit dem Nebenfach Informatik, die hier noch einen persönlichen Nachholbedarf sehen und sich so besser auf die Informatik-Vorlesungen vorbereiten wollen. Die einzelnen Schwerpunkte des Brückenkurses sind: elementare Mengenlehre, Relationen und Funktionen, logische Grundlagen, Umgang mit mathematischen Formeln und das Verstehen von mathematischen Beweisen.</div>', '', '', '', 'E24nA1.1', 3, 1, 4, '2014-05-31 06:59:17'),
(116, 'Mathematik für Bioinformatiker', '<div>Aussagenlogik und mathematische BeweistechnikenMengenlehre: Mengen, Relationen, Äquivalenz- und Ordnungsrelationen, FunktionenNatürliche Zahlen und vollständige Induktion, AbzählbarkeitKombinatorik: Abzählprinzipien, Binomialkoeffizienten und Stirling-Zahlen, Rekursion, SchubfachprinzipLineare Algebra: Vektorraum, Basis und Dimension; lineare Abbildung, Matrix und Rang; Gauss-Elemination und lineare Gleichungssysteme; Determinanten, Eigenwerte und Eigenvektoren; Euklidische Vektorräume und Orthonormalisierung; Hauptachsentransformation;Anwendungen der linearen Algebra in der affinen Geometrie Zielgruppe Studierende der Bioinformatik im 1. Semester.</div>', '', '', '', 'E24nA1.1', 3, 1, 1, '2014-05-31 07:01:42'),
(117, 'Informatik A', '<div>Im Mittelpunkt stehen zunächst der Begriff des Algorithmus und der Weg von der Problemstellung über die algorithmische Lösung zum Programm. Anhand zahlreicher Beispiele werden Grundprinzipien des Algorithmenentwurfs erläutert. Die Implementierung der Algorithmen wird verbunden mit der Einführung der funktionalen Programmiersprache Haskell. Im Weiteren werden die theoretischen, technischen und organisatorischen Grundlagen von Rechnersystemen vorgestellt. Dabei werden die Themen Binärdarstellung von Informationen im Rechner, Boolesche Funktionen und ihre Berechnung durch Schaltnetze, Schaltwerke für den Aufbau von Prozessoren und das von- Neumann-Rechnermodell behandelt. </div>', '', '<ul>\n<li>S. Thompson; Haskell: The Craft of Functional Programming; Addison-Wesley\n</li><li>F. Rabhi, G. Lapalme; Algorithms: A Functional Proramming Approach; Addison-Wesley\n</li><li>G. Hutton; Programming in Haskell; Cambridge University Press\n</li><li>A. Tanenbaum, J. Goodman; Computerarchitektur; Pearson Studium\n</li></ul>', '<h2>Voraussetzungen:</h2>\n<p>Zur Vorbereitung wird der Besuch des Brückenkurses Mathematische Grundlagen für Informatik, Bioinformatik und Nebenfach Informatik empfohlen. </p>\n<h2>Zusätzliche Informationen</h2>\n<p>Freischaltung der Anmeldung zu Tutorien wird rechtzeitg bekanntgegeben</p>', 'E24nA1.1', 3, 1, 1, '2014-05-31 07:06:52'),
(118, 'Forschungsseminar Theoretische Informatik (Mittagsseminar)', '<p>Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus der Theoretischen Informatik, insbesondere Algorithmen</p>', '', '', '', 'E24nA1.1', 4, 1, 1, '2014-05-31 07:11:47'),
(119, 'Forschungsseminar Programmiersprachen', '<p>Vorträge über eigene Forschung, Bachelor-, Diplom- und Masterarbeiten, sowie Originalarbeiten aus dem Bereich Programmiersprachen</p>', '', '', '', 'E24nA1.1', 4, 1, 1, '2014-05-31 07:12:45'),
(120, 'Planung, Durchführung und Analyse eines Tutoriums', '<p>In einem vorbereitenden Kolloquium werden aktuelle Unterrichtsmethoden für Tutorien zur Mathematik und Informatik vorgestellt und diskutiert. Anschließend findet noch während der Semesterferien ein Vorstellungsgespräch mit dem Tutorenauswahlausschuss statt, in dem die Eignung als Tutor festestellt wird. Nach erfolgreicher Eignungsfeststellung wird ein Tutorium zu einer selbst gewählten Veranstaltung des Pflichtbereichs vorbereitet, durchgeführt, dokumentiert und analysiert.</p>', '', '<p>\neifert, J. W.: Visualisieren Präsentieren Moderieren. GABAL Verlag, 16. Auflage 2001 Informationen für Studenten Bitte wenden Sie sich direkt an den zuständigen Tutorenauswahlbeauftragten: Herrn Heindorf für die Mathematik bzw. Herrn Hoffmann für die Informatik. </p>\n', '<h2>Zusätzliche Informationen</h2>\n<p>Vorbesprechung am Do, 16. 7. um 14:00 im Raum 159, Takustr. 9</p>', ' 159bA1.17', 3, 1, 1, '2014-05-31 07:16:45');
INSERT INTO `modulverwaltung_modul` (`m_id`, `m_name`, `m_inhalt`, `m_ziel`, `m_literatur`, `m_voraussetzung`, `m_lvNummer`, `m_typ`, `sp_id`, `mk_id`, `m_geaendert_am`) VALUES
(122, 'Seminar Collaborative and Social Computing', '<p>Das Ziel dieses Seminars ist es Studierenden ein Verständnis für bestehende Anwendungen im Bereich Social and Collborative Computing als auch Einsichten zu bestehenden Technologien zu vermitteln. Die Besonderheit dieser Anwendungen besteht darin, dass sich ihr Mehrwert nicht durch den alleinigen Einsatz bestimmter Algorithmen ergibt, sondern erst durch deren umfassende Nutzung durch Menschen. Diese Wechselbeziehung zwischen Menschen und digitalen Artefakten führt häufig zu emergenten Eigenschaften des sozio-technischen Systems. Um nun diese Eigenschaften offenzulegen und zu verstehen ist eine gleichzeitige Betrachtung der Technologie und der menschlichen Interaktionen erforderlich. Der Bereich Social and Collaborative Computing hat sich in den letzten Jahren umfassend geändert. Anwendungen wie Wikipedia, Facebook, Twitter, Mechanical Turk oder Flickr bieten eine umfangreiches Repertoire an Interaktions¬modalitäten im täglichen Leben, aber auch im Unternehmens- und Bildungsbereich. In diesem Seminar werden wir uns mit diesen Anwendungsbereichen, aber auch ausgewählten Algorithmen zur ?Steuerung? der Mensch-Maschine-Interaktion auseinandersetzen. Die wissenschaftliche Basis der gestellten Fragen rekrutiert sich vor allem aus dem Bereich CSCW (Computer Supported Cooperative Work) und angrenzenden Bereichen wie beispielweise Data Mining und Human Computer Interaktion. In diesem Seminar erarbeiten sich Studierende die einzelnen Themen anhand von wissenschaftlichen Artikeln. Die zentralen Erkenntnisse aus diesen Artikeln werden innerhalb des Seminars präsentiert und diskutiert. Die im Laufe des Semesters gesammelten Erkenntnisse werden innerhalb eines Forschungsartikels zusammengefasst. Jede Woche werden wir uns mit einem ausgewählten Thema aus diesem Bereich auseinandersetzen, welches alle drei Perspektiven (Konzepte, Anwendungsbereiche, Technologien) behandelt. Am Ende dieser Veranstaltung sollten Studierende über folgende Kompetenzen verfügen: - Beschreiben und erklären von zentralen Konzepten in diesem Bereich, wie beispielsweise Human Computation, Crowdsourcing, Kollektive Intelligenz, Koordination, Communities of Practice - Beschreiben und vergleichen von Anwendungen im Bereich Social and Collborative Computing - Beschreiben und diskutieren der technologischen Entwicklungen im Bereich Social and Collborative Computing in den letzten Jahren - Rekonfiguren von Konzepte und Technologien aus dem Bereich Social and Collborative Computing und entwickeln von neuen Lösungen</p>', '', '', '', '089bA4.32', 3, 1, 4, '2014-05-31 07:24:50'),
(123, 'Seminar Moderne Web-Technologien', '', '', '', '', '089bA4.34', 3, 1, 4, '2014-05-31 07:25:57'),
(124, 'Arbeits- und Lebensmethodik', 'Wir werden in diesem Kurs gemeinsam die Fragen beleuchten, die über ein erfolgreiches Arbeiten in Studium und Beruf und ebenso über den Erfolg und die Zufriedenheit im privaten Leben entscheiden. Dies sind meistens weniger technische Fertigkeiten als vielmehr Fragen der Persönlichkeit: Zielstrebigkeit, Selbstbewusstsein, Fähigkeit zu Konzentration und Entspannung, Entscheidungsfähigkeit, klare Kommunikation, Selbstbild, Motivation, Durchhaltevermögen. Ziel dieses Kurses ist es, Anstöße zur und erste Fortschritte bei der gezielten und selbstgetriebenen Persönlichkeitsentwicklung zu geben. Es wird ferner erklärt, wie und warum große Teile der oft als "soft skills" bezeichneten Fertigkeiten sich fast von alleine einstellen, wenn man die obigen Fähigkeiten entwickelt.Dieser Kurs ist ein Seminar im ursprünglichen Sinne: Eine hauptsächlich als Diskussion verlaufende Veranstaltung, in der jede/r Beteiligte etwas selbst erforscht (in diesem Fall das eigene Verhalten). Das Format ist jedoch vollkommen anders als unter dem Titel "Seminar" sonst in der Informatik gewohnt: Es gibt keine Themenzuweisung, keine Vorträge, keine Ausarbeitungen. Es geht um Bildung, nicht um Ausbildung.', '', '', '<p>Die Teilnehmerzahl ist beschränkt; vorherige Anmeldung ist erforderlich.</p><br>\n<p>\nIch erwarte von allen Teilnehmern eine offene und engagierte Mitarbeit. Die Veranstaltung benötigt nur einen moderaten Zeitaufwand, aber einen erheblichen Einsatz von Willenskraft.</p>', ' 159bA1.11', 3, 1, 1, '2014-05-31 07:29:50'),
(125, 'Kurs und Praxisseminar Professionelle Softwareentwicklung ', '', '', '', '', 'keine Angabe', 3, 1, 1, '2014-05-31 07:31:46'),
(126, 'Seminar Künstliche Intelligenz', '', '', '', '', '089bA1.19', 3, 1, 1, '2014-05-31 07:34:18'),
(128, 'Betriebssysteme', '', '', '', '', 'keine ANgabe', 2, 1, 1, '2014-05-31 07:41:48'),
(130, 'Forschungsseminar Intelligente Systeme und Robotik', '', '', '', '', 'E24fA1.1', 4, 1, 1, '2014-05-31 07:44:51'),
(131, 'New Algorithms for Big Data', '<h2>Abstract:</h2><p>\nIn many modern workflows the data one deals with no longer fits in the memory of a single node, or arrives incrementally over time and is usually noisy/uncertain and typically it is all these cases. This course deals with the development and analysis of algorithms for dealing with such Big Data workflows.</p><br>\n\n<p>We will look into:</p>\n<ul>\n<li>sketching</li>\n<li>streaming</li>\n<li>dimensionality reduction</li>\n<li>big matrix algorithms</li>\n<li>sparse signals</li>\n<li>map-reduce</li>\n<li>Resilient distributed datasets</li>\n<li>random walks</li><li></ul>\n\n<p>Unlike my other courses, this one will be more theoretical but also involve hands-on programming exercises.</p>', '', '', '<h2>Prerequisites:</h2>\n<p>Must have taken Algorithms and Databases.</p>', 'keine Angabe', 3, 2, 1, '2014-05-31 07:48:44'),
(140, 'Softwareprojekt', NULL, NULL, NULL, NULL, '086bA3.4', 2, 1, 1, '2014-06-17 16:03:00'),
(142, 'Forschungsseminare', NULL, NULL, NULL, NULL, 'E24fA1.4.1', 4, 1, 1, '2014-06-17 18:52:01'),
(143, 'Proseminar Informatik', NULL, NULL, NULL, NULL, '086bA3.2', 2, 1, 1, '2014-06-21 15:32:14');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul_counter`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul_counter` (
  `mc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `i_id` bigint(20) NOT NULL,
  `mc_counter` bigint(20) NOT NULL,
  PRIMARY KEY (`mc_id`),
  KEY `i_id` (`i_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Daten für Tabelle `modulverwaltung_modul_counter`
--

INSERT INTO `modulverwaltung_modul_counter` (`mc_id`, `i_id`, `mc_counter`) VALUES
(1, 6, 1),
(2, 7, 128),
(3, 8, 0),
(4, 9, 0),
(5, 10, 0),
(6, 11, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul_huelsen`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul_huelsen` (
  `mh_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(20) NOT NULL,
  `h_id` bigint(20) NOT NULL,
  PRIMARY KEY (`mh_id`),
  KEY `m_id` (`m_id`),
  KEY `h_id` (`h_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul_kategorie`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul_kategorie` (
  `mk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mk_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mk_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `i_id` bigint(20) NOT NULL,
  PRIMARY KEY (`mk_id`),
  KEY `i_id` (`i_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Daten für Tabelle `modulverwaltung_modul_kategorie`
--

INSERT INTO `modulverwaltung_modul_kategorie` (`mk_id`, `mk_name`, `mk_kuerzel`, `i_id`) VALUES
(1, 'Algorithmen und Programmieren', 'A1', 7),
(2, 'Technische Informatik', 'A2', 7),
(3, 'Theoretische und Praktische Informatik', 'A3', 7),
(4, 'Mathematik für Informatikerinnen und Informatiker', 'A4', 7),
(5, 'Vertiefungsbereich', 'A5', 7);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul_lvs`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul_lvs` (
  `ml_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ml_sws` int(2) NOT NULL,
  `ml_anwesenheitspflicht` tinyint(1) NOT NULL,
  `ml_primary` bigint(20) DEFAULT NULL,
  `m_id` bigint(20) NOT NULL,
  `lvt_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ml_id`),
  KEY `m_id` (`m_id`),
  KEY `lvt_id` (`lvt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=324 ;

--
-- Daten für Tabelle `modulverwaltung_modul_lvs`
--

INSERT INTO `modulverwaltung_modul_lvs` (`ml_id`, `ml_sws`, `ml_anwesenheitspflicht`, `ml_primary`, `m_id`, `lvt_id`) VALUES
(6, 4, 1, 0, 140, 12),
(183, 2, 0, 0, 142, 9),
(184, 2, 1, 0, 143, 3),
(191, 4, 0, 0, 3, 1),
(192, 2, 1, 191, 3, 2),
(193, 2, 0, 0, 4, 1),
(194, 2, 1, 193, 4, 2),
(195, 2, 0, 0, 6, 1),
(196, 2, 1, 195, 6, 2),
(197, 3, 0, 0, 8, 1),
(198, 2, 1, 197, 8, 2),
(199, 3, 0, 0, 9, 1),
(200, 2, 1, 199, 9, 2),
(201, 4, 0, 0, 10, 1),
(202, 2, 1, 201, 10, 2),
(203, 4, 0, 0, 11, 1),
(204, 2, 1, 203, 11, 2),
(205, 4, 0, 0, 12, 1),
(206, 2, 1, 205, 12, 2),
(207, 2, 0, 0, 13, 1),
(208, 2, 1, 207, 13, 2),
(209, 2, 0, 0, 14, 1),
(210, 2, 1, 209, 14, 2),
(211, 2, 0, 0, 15, 1),
(212, 2, 1, 211, 15, 2),
(213, 2, 0, 0, 16, 1),
(214, 2, 1, 213, 16, 2),
(215, 2, 0, 0, 35, 1),
(216, 2, 1, 215, 35, 2),
(217, 2, 0, 0, 36, 1),
(218, 2, 1, 217, 36, 2),
(219, 4, 0, 0, 51, 1),
(220, 2, 1, 219, 51, 2),
(221, 4, 0, 0, 52, 1),
(222, 2, 1, 221, 52, 2),
(223, 2, 0, 0, 53, 1),
(224, 2, 1, 223, 53, 2),
(225, 2, 0, 0, 55, 1),
(226, 2, 1, 225, 55, 2),
(227, 2, 0, 0, 56, 1),
(228, 2, 1, 227, 56, 2),
(229, 4, 0, 0, 69, 1),
(230, 2, 1, 229, 69, 2),
(231, 4, 0, 0, 70, 1),
(232, 2, 1, 231, 70, 2),
(233, 4, 0, 0, 71, 1),
(234, 2, 1, 233, 71, 2),
(235, 4, 0, 0, 72, 1),
(236, 2, 1, 235, 72, 2),
(237, 2, 1, 1, 73, 1),
(238, 2, 1, 237, 73, 2),
(239, 2, 0, 0, 82, 1),
(240, 2, 1, 239, 82, 2),
(241, 2, 0, 0, 84, 1),
(242, 2, 1, 241, 84, 2),
(243, 2, 0, 0, 86, 1),
(244, 2, 1, 243, 86, 2),
(245, 2, 0, 0, 95, 1),
(246, 2, 1, 245, 95, 2),
(247, 2, 0, 0, 96, 1),
(248, 2, 1, 247, 96, 2),
(249, 4, 0, 0, 97, 1),
(250, 2, 1, 249, 97, 2),
(251, 4, 0, 0, 98, 1),
(252, 2, 1, 251, 98, 2),
(253, 2, 0, 0, 101, 1),
(254, 2, 1, 253, 101, 2),
(255, 4, 0, 0, 102, 1),
(256, 2, 1, 255, 102, 2),
(257, 4, 0, 0, 103, 1),
(258, 2, 1, 257, 103, 2),
(259, 2, 0, 0, 105, 1),
(260, 2, 1, 259, 105, 2),
(261, 2, 0, 0, 107, 1),
(262, 2, 1, 261, 107, 2),
(263, 2, 0, 0, 110, 1),
(264, 2, 1, 263, 110, 2),
(265, 4, 0, 0, 111, 1),
(266, 2, 1, 265, 111, 2),
(267, 4, 0, 0, 116, 1),
(268, 2, 1, 267, 116, 2),
(269, 4, 0, 0, 117, 1),
(270, 2, 1, 269, 117, 2),
(271, 4, 0, 0, 128, 1),
(272, 4, 0, 271, 128, 2),
(273, 3, 1, 0, 7, 13),
(274, 2, 0, 0, 18, 1),
(275, 2, 1, 0, 26, 4),
(276, 2, 1, 0, 27, 4),
(277, 2, 1, 0, 28, 4),
(278, 2, 1, 0, 29, 4),
(279, 2, 1, 0, 30, 4),
(280, 2, 1, 0, 31, 4),
(281, 2, 1, 0, 32, 4),
(282, 4, 1, 0, 33, 22),
(283, 2, 1, 0, 38, 10),
(284, 2, 1, 0, 40, 4),
(285, 2, 1, 0, 43, 4),
(286, 2, 0, 0, 57, 4),
(287, 4, 1, 0, 59, 13),
(288, 2, 1, 0, 74, 1),
(289, 2, 1, 0, 75, 1),
(290, 2, 1, 0, 76, 4),
(291, 2, 1, 0, 77, 4),
(292, 2, 1, 0, 78, 4),
(293, 2, 1, 0, 79, 4),
(294, 2, 1, 0, 80, 4),
(295, 2, 1, 0, 81, 13),
(296, 3, 1, 0, 85, 5),
(297, 2, 1, 0, 87, 4),
(298, 2, 1, 0, 88, 4),
(299, 2, 1, 0, 89, 4),
(300, 2, 1, 0, 90, 4),
(301, 2, 1, 0, 91, 4),
(302, 2, 1, 0, 92, 4),
(303, 2, 1, 0, 99, 4),
(304, 2, 1, 0, 100, 4),
(305, 2, 1, 0, 104, 10),
(306, 1, 1, 0, 106, 4),
(307, 2, 0, 0, 108, 1),
(308, 1, 1, 0, 108, 4),
(309, 2, 1, 0, 109, 13),
(310, 2, 0, 0, 109, 1),
(311, 2, 0, 0, 112, 10),
(312, 2, 0, 0, 112, 5),
(313, 2, 1, 0, 114, 4),
(314, 2, 1, 0, 115, 10),
(315, 2, 1, 0, 120, 20),
(316, 2, 1, 0, 120, 10),
(317, 2, 1, 0, 122, 4),
(318, 2, 1, 0, 123, 4),
(319, 3, 1, 0, 124, 10),
(320, 2, 1, 0, 125, 6),
(321, 2, 1, 0, 125, 10),
(322, 2, 1, 0, 126, 4),
(323, 2, 1, 0, 131, 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_modul_verantwortliche`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_modul_verantwortliche` (
  `mv_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(20) NOT NULL,
  `l_id` bigint(20) NOT NULL,
  PRIMARY KEY (`mv_id`),
  KEY `m_id` (`m_id`,`l_id`),
  KEY `m_id_2` (`m_id`),
  KEY `l_id` (`l_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61 ;

--
-- Daten für Tabelle `modulverwaltung_modul_verantwortliche`
--

INSERT INTO `modulverwaltung_modul_verantwortliche` (`mv_id`, `m_id`, `l_id`) VALUES
(1, 35, 103),
(4, 40, 69),
(5, 41, 177),
(6, 42, 178),
(7, 43, 32),
(14, 51, 118),
(15, 52, 54),
(16, 55, 105),
(17, 56, 69),
(19, 57, 60),
(18, 57, 137),
(22, 59, 105),
(27, 70, 57),
(28, 70, 101),
(29, 71, 178),
(30, 73, 82),
(31, 74, 177),
(32, 76, 103),
(34, 78, 178),
(35, 80, 167),
(36, 82, 137),
(38, 84, 125),
(39, 86, 77),
(40, 87, 177),
(41, 88, 177),
(42, 89, 137),
(43, 90, 25),
(44, 91, 160),
(46, 92, 44),
(45, 92, 71),
(48, 95, 130),
(49, 96, 177),
(50, 99, 177),
(51, 102, 138),
(52, 103, 6),
(53, 104, 24),
(54, 105, 114),
(55, 110, 130),
(56, 111, 130),
(57, 112, 130),
(59, 116, 57),
(58, 116, 101),
(60, 125, 130);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_planung`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_planung` (
  `p_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lv_id` bigint(20) NOT NULL,
  `s_id` bigint(20) NOT NULL,
  `r_id` bigint(20) DEFAULT NULL,
  `t_id` bigint(20) DEFAULT NULL,
  `p_max_teilnehmer` int(11) DEFAULT NULL,
  `p_startdatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `p_enddatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  KEY `lv_id` (`lv_id`),
  KEY `s_id` (`s_id`),
  KEY `t_id` (`t_id`),
  KEY `r_id` (`r_id`),
  KEY `lv_id_2` (`lv_id`),
  KEY `s_id_2` (`s_id`),
  KEY `r_id_2` (`r_id`),
  KEY `t_id_2` (`t_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=240 ;

--
-- Daten für Tabelle `modulverwaltung_planung`
--

INSERT INTO `modulverwaltung_planung` (`p_id`, `lv_id`, `s_id`, `r_id`, `t_id`, `p_max_teilnehmer`, `p_startdatum`, `p_enddatum`) VALUES
(5, 4, 3, 1, 4, NULL, NULL, NULL),
(6, 4, 3, 1, 15, NULL, NULL, NULL),
(7, 5, 3, 1, 16, NULL, NULL, NULL),
(8, 7, 3, 1, 26, NULL, NULL, NULL),
(9, 10, 3, 1, 2, NULL, NULL, NULL),
(10, 10, 3, 1, 14, NULL, NULL, NULL),
(11, 12, 3, 1, 10, NULL, NULL, NULL),
(12, 12, 3, 1, 20, NULL, NULL, NULL),
(13, 14, 3, 1, 8, NULL, NULL, NULL),
(14, 14, 3, 1, 20, NULL, NULL, NULL),
(15, 16, 3, 2, 11, NULL, NULL, NULL),
(16, 16, 3, 2, 21, NULL, NULL, NULL),
(17, 18, 3, 2, 13, NULL, NULL, NULL),
(18, 18, 3, 2, 26, NULL, NULL, NULL),
(19, 20, 3, 4, 2, 25, NULL, NULL),
(22, 22, 3, 1, 9, NULL, NULL, NULL),
(23, 24, 3, 3, 8, NULL, NULL, NULL),
(25, 29, 3, 2, 14, NULL, NULL, NULL),
(26, 30, 3, 6, 5, NULL, NULL, NULL),
(27, 31, 3, 6, 20, NULL, NULL, NULL),
(28, 32, 3, 4, 11, NULL, NULL, NULL),
(29, 28, 3, 18, 14, NULL, NULL, NULL),
(36, 34, 3, 8, 22, NULL, NULL, NULL),
(37, 34, 3, 8, 23, NULL, NULL, NULL),
(38, 35, 3, 12, 10, NULL, NULL, NULL),
(39, 35, 3, 12, 11, NULL, NULL, NULL),
(40, 36, 3, 3, 17, NULL, NULL, NULL),
(41, 36, 3, 3, 18, NULL, NULL, NULL),
(42, 37, 3, 4, 17, NULL, NULL, NULL),
(43, 38, 3, 6, 11, NULL, NULL, NULL),
(44, 40, 3, 2, 22, NULL, NULL, NULL),
(45, 41, 3, 17, 10, NULL, NULL, NULL),
(46, 42, 3, 17, 11, NULL, NULL, NULL),
(47, 43, 3, 3, 23, NULL, NULL, NULL),
(48, 44, 3, 3, 2, NULL, NULL, NULL),
(49, 44, 3, 3, 3, NULL, NULL, NULL),
(55, 67, 4, 1, 2, NULL, '20.10.2014', '09.02.2015'),
(56, 67, 4, 1, 14, NULL, '15.10.2014', '11.02.2015'),
(57, 64, 4, 1, 10, NULL, '14.10.2014', '10.02.2015'),
(58, 64, 4, 1, 22, NULL, '16.10.2014', '12.02.2015'),
(59, 68, 4, 1, 9, NULL, '14.10.2014', '10.02.2015'),
(60, 72, 4, 1, 27, NULL, '17.10.2014', '13.02.2015'),
(61, 75, 4, 1, 26, NULL, '17.10.2014', '13.02.2015'),
(62, 45, 4, 4, 17, NULL, '15.10.2014', '11.02.2015'),
(63, 63, 4, 5, 11, NULL, '14.10.2014', '10.02.2015'),
(64, 57, 4, 7, 28, NULL, '17.10.2014', '13.02.2015'),
(65, 58, 4, 8, 8, NULL, '14.10.2014', '10.02.2015'),
(66, 60, 4, 6, 11, NULL, '14.10.2014', '10.02.2015'),
(67, 62, 4, 5, 29, NULL, '17.10.2014', '13.02.2015'),
(68, 59, 4, 8, 23, NULL, '16.10.2014', '12.02.2015'),
(86, 100, 4, 8, 26, NULL, NULL, NULL),
(87, 153, 4, 1, 2, NULL, NULL, NULL),
(96, 81, 4, 1012, 16, NULL, NULL, NULL),
(97, 81, 4, 1013, 17, NULL, NULL, NULL),
(98, 82, 4, 3, 14, NULL, NULL, NULL),
(99, 82, 4, 6, 15, NULL, NULL, NULL),
(100, 90, 4, 1, 20, NULL, NULL, NULL),
(101, 90, 4, 1, 7, NULL, NULL, NULL),
(111, 92, 4, 1, 3, NULL, NULL, NULL),
(112, 92, 4, 1, 16, NULL, NULL, NULL),
(122, 136, 4, 999, 10, NULL, NULL, NULL),
(123, 137, 4, 5, 2, NULL, NULL, NULL),
(124, 137, 4, 5, 27, NULL, NULL, NULL),
(126, 104, 4, 6, 8, NULL, NULL, NULL),
(127, 151, 4, 5, 2, NULL, NULL, NULL),
(128, 150, 4, 5, 3, NULL, NULL, NULL),
(129, 151, 4, 5, 2, NULL, NULL, NULL),
(130, 141, 4, 1018, 11, NULL, NULL, NULL),
(131, 144, 4, 3, 2, NULL, NULL, NULL),
(132, 120, 4, 17, 28, NULL, NULL, NULL),
(133, 54, 4, 14, 16, NULL, NULL, NULL),
(134, 54, 4, 14, 26, NULL, NULL, NULL),
(135, 55, 4, 999, 23, NULL, NULL, NULL),
(136, 139, 4, 1011, 2, NULL, NULL, NULL),
(137, 139, 4, 1011, 26, NULL, NULL, NULL),
(142, 94, 4, 2, 21, NULL, NULL, NULL),
(143, 94, 4, 2, 11, NULL, NULL, NULL),
(145, 48, 4, 18, 27, NULL, NULL, NULL),
(147, 47, 4, 3, 4, NULL, NULL, NULL),
(149, 99, 4, 8, 2, NULL, NULL, NULL),
(151, 109, 4, 3, 13, NULL, NULL, NULL),
(153, 113, 4, 1011, 21, NULL, NULL, NULL),
(155, 142, 4, 3, 25, NULL, NULL, NULL),
(156, 142, 4, 3, 1, NULL, NULL, NULL),
(159, 114, 4, 1002, 8, NULL, NULL, NULL),
(160, 115, 4, 1003, 2, NULL, NULL, NULL),
(162, 103, 4, 4, 26, NULL, NULL, NULL),
(163, 118, 4, 5, 20, NULL, NULL, NULL),
(164, 133, 4, 6, 22, NULL, NULL, NULL),
(165, 117, 4, 4, 14, NULL, NULL, NULL),
(166, 102, 4, 4, 2, NULL, NULL, NULL),
(167, 106, 4, 1002, 9, NULL, NULL, NULL),
(168, 39, 4, 4, 20, NULL, NULL, NULL),
(169, 126, 4, 4, 3, NULL, NULL, NULL),
(171, 127, 4, 6, 10, NULL, NULL, NULL),
(173, 146, 4, 12, 8, NULL, NULL, NULL),
(175, 53, 4, 14, 10, NULL, NULL, NULL),
(176, 129, 4, 1, 8, NULL, NULL, NULL),
(177, 129, 4, 1, 19, NULL, NULL, NULL),
(179, 56, 4, 1018, 10, NULL, NULL, NULL),
(180, 148, 4, 999, 24, NULL, NULL, NULL),
(181, 149, 4, 2, 2, NULL, NULL, NULL),
(182, 97, 4, 4, 20, NULL, NULL, NULL),
(184, 131, 4, 2, 20, NULL, NULL, NULL),
(185, 131, 4, 2, 7, NULL, NULL, NULL),
(190, 122, 4, 999, 999, NULL, NULL, NULL),
(191, 52, 4, 999, 999, NULL, NULL, NULL),
(192, 123, 4, 999, 999, NULL, NULL, NULL),
(194, 160, 4, 999, 999, NULL, NULL, NULL),
(195, 167, 4, 999, 999, NULL, NULL, NULL),
(196, 168, 4, 999, 999, NULL, NULL, NULL),
(197, 169, 4, 999, 999, NULL, NULL, NULL),
(199, 177, 4, 999, 999, NULL, NULL, NULL),
(200, 51, 4, 999, 999, NULL, NULL, NULL),
(201, 158, 4, 999, 999, NULL, NULL, NULL),
(203, 181, 4, 999, 999, NULL, NULL, NULL),
(204, 170, 4, 999, 999, NULL, NULL, NULL),
(205, 175, 4, 999, 999, NULL, NULL, NULL),
(206, 171, 4, 999, 999, NULL, NULL, NULL),
(207, 159, 4, 999, 999, NULL, NULL, NULL),
(208, 179, 4, 999, 999, NULL, NULL, NULL),
(209, 176, 4, 999, 999, NULL, NULL, NULL),
(211, 183, 4, 999, 999, NULL, NULL, NULL),
(214, 166, 4, 1, 26, NULL, NULL, NULL),
(215, 172, 4, 4, 6, NULL, NULL, NULL),
(220, 173, 4, 3, 4, NULL, NULL, NULL),
(224, 180, 4, 999, 25, NULL, NULL, NULL),
(225, 180, 4, 999, 26, NULL, NULL, NULL),
(226, 182, 4, 999, 999, NULL, NULL, NULL),
(228, 173, 4, 3, 3, NULL, NULL, NULL),
(229, 165, 4, 7, 9, NULL, NULL, NULL),
(230, 165, 4, 7, 21, NULL, NULL, NULL),
(231, 4, 5, 999, 999, NULL, NULL, NULL),
(232, 80, 4, 13, 10, NULL, NULL, NULL),
(233, 80, 4, 13, 11, NULL, NULL, NULL),
(234, 80, 4, 13, 22, NULL, NULL, NULL),
(235, 80, 4, 13, 23, NULL, NULL, NULL),
(236, 43, 4, 999, 999, NULL, NULL, NULL),
(237, 40, 4, 999, 999, NULL, NULL, NULL),
(238, 38, 4, 999, 999, NULL, NULL, NULL),
(239, 37, 4, 999, 999, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_raum`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_raum` (
  `r_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `r_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `r_stockwerk` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `r_kapazitaet` int(10) DEFAULT NULL,
  `g_id` bigint(20) NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `g_id` (`g_id`),
  KEY `g_id_2` (`g_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1020 ;

--
-- Daten für Tabelle `modulverwaltung_raum`
--

INSERT INTO `modulverwaltung_raum` (`r_id`, `r_name`, `r_kuerzel`, `r_stockwerk`, `r_kapazitaet`, `g_id`) VALUES
(1, 'Großer Hörsaal', 'HS 028', '0', NULL, 1),
(2, 'Seminarraum', 'SR 005', '0', NULL, 1),
(3, 'Seminarraum', 'SR 006', '0', NULL, 1),
(4, 'Seminarraum', 'SR 049', '0', NULL, 1),
(5, 'Seminarraum', 'SR 051', '0', NULL, 1),
(6, 'Seminarraum', 'SR 053', '0', NULL, 1),
(7, 'Seminarraum', 'SR 055', '0', NULL, 1),
(8, 'Seminarraum', 'SR 046', '0', NULL, 1),
(9, 'Rechnerpool', 'K 036', '-1', NULL, 1),
(10, 'Rechnerpool', 'K 038', '-1', NULL, 1),
(11, 'Rechnerpool', 'K 048', '-1', NULL, 1),
(12, 'Multimediaraum', 'K 040', '-1', NULL, 1),
(13, 'Hardwarepraktikum', 'K 063', '-1', NULL, 1),
(14, 'Konferenzraum', '137', '1', NULL, 1),
(15, 'Rechnerpool', 'K 046', '-1', NULL, 1),
(16, 'Rechnerpool', 'K 044', '-1', NULL, 1),
(17, 'Seminarraum (Hinterhaus)', 'SR 140', '1', NULL, 2),
(18, 'Seminarraum', 'SR E.31', '0', NULL, 2),
(999, 'Kein Raum zugewiesen', 'noRoom', '0', NULL, 1),
(1000, 'Seminarraum', 'SR 007/008', '0', NULL, 3),
(1001, 'Seminarraum', 'SR 025/026', '0', NULL, 3),
(1002, 'Seminarraum', 'SR 009', '0', NULL, 3),
(1003, 'Seminarraum', 'SR 031', '0', NULL, 3),
(1004, 'Seminarraum', 'SR 032', '0', NULL, 3),
(1005, 'Seminarraum', '108/109', '1', NULL, 3),
(1006, 'Rechnerpoolraum', '006', '0', NULL, 3),
(1007, 'Rechnerpoolraum', '028', '0', NULL, 3),
(1008, 'Rechnerpoolraum', '030', '0', NULL, 3),
(1009, 'Konferenzraum', '126', '1', NULL, 3),
(1010, 'Frontalunterrichtsraum', '017', '0', NULL, 3),
(1011, 'Hörsaal', 'HS 001', '0', NULL, 4),
(1012, 'Seminarraum', 'SR 005', '0', NULL, 4),
(1013, 'Seminarraum', 'SR 119', '1', NULL, 4),
(1014, 'Seminarraum', 'SR 210', '2', NULL, 4),
(1015, 'Seminarraum (Hinterhaus)', 'SR 130', '1', NULL, 4),
(1017, 'Neuro/Mathe', 'SR 006', '0', NULL, 5),
(1018, '(vorrang Schülerlabor)', 'SR 016', '0', NULL, 5),
(1019, '(vorrang Schülerlabor)', 'SR 017', '0', NULL, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_roles`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_roles` (
  `ro_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ro_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ro_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `modulverwaltung_roles`
--

INSERT INTO `modulverwaltung_roles` (`ro_id`, `ro_name`) VALUES
(1, 'admin'),
(2, 'lecturer'),
(3, 'secretary');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_sek_sto`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_sek_sto` (
  `ss_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(20) NOT NULL,
  `sto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ss_id`),
  KEY `m_id` (`m_id`),
  KEY `sto_id` (`sto_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Daten für Tabelle `modulverwaltung_sek_sto`
--

INSERT INTO `modulverwaltung_sek_sto` (`ss_id`, `m_id`, `sto_id`) VALUES
(5, 140, 234),
(6, 142, 234);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_semester`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_semester` (
  `s_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `s_jahr` year(4) NOT NULL,
  `s_typ` tinyint(1) NOT NULL,
  `s_startdatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `s_enddatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Daten für Tabelle `modulverwaltung_semester`
--

INSERT INTO `modulverwaltung_semester` (`s_id`, `s_jahr`, `s_typ`, `s_startdatum`, `s_enddatum`) VALUES
(1, 2013, 1, NULL, '0000-00-00'),
(2, 2014, 0, NULL, '0000-00-00'),
(3, 2014, 1, NULL, '0000-00-00'),
(4, 2015, 0, NULL, '0000-00-00'),
(5, 2015, 1, NULL, '0000-00-00'),
(6, 2016, 0, NULL, NULL),
(7, 2016, 1, NULL, NULL),
(8, 2017, 0, NULL, NULL),
(9, 2017, 1, NULL, NULL),
(10, 2018, 0, NULL, NULL),
(11, 2018, 1, NULL, NULL),
(12, 2019, 0, NULL, NULL),
(13, 2019, 1, NULL, NULL),
(14, 2020, 0, NULL, NULL),
(15, 2020, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_semester_lecturer`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_semester_lecturer` (
  `sl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `l_id` bigint(20) NOT NULL,
  `p_id` bigint(20) NOT NULL,
  PRIMARY KEY (`sl_id`),
  KEY `l_id` (`l_id`),
  KEY `p_id` (`p_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=322 ;

--
-- Daten für Tabelle `modulverwaltung_semester_lecturer`
--

INSERT INTO `modulverwaltung_semester_lecturer` (`sl_id`, `l_id`, `p_id`) VALUES
(1, 54, 5),
(2, 54, 6),
(3, 103, 7),
(4, 177, 11),
(5, 147, 11),
(6, 100, 11),
(7, 177, 12),
(8, 147, 12),
(9, 100, 12),
(10, 69, 8),
(11, 118, 9),
(12, 118, 10),
(13, 57, 13),
(14, 57, 14),
(15, 178, 15),
(16, 84, 15),
(17, 178, 16),
(18, 84, 16),
(19, 138, 17),
(20, 165, 17),
(21, 138, 18),
(22, 165, 18),
(23, 130, 19),
(24, 144, 19),
(25, 72, 22),
(26, 137, 23),
(27, 60, 23),
(28, 87, 25),
(29, 101, 26),
(30, 44, 27),
(31, 142, 28),
(32, 137, 29),
(33, 44, 36),
(34, 186, 36),
(35, 44, 37),
(36, 186, 37),
(37, 138, 40),
(38, 138, 41),
(39, 138, 43),
(40, 178, 44),
(41, 178, 45),
(42, 81, 46),
(43, 130, 47),
(44, 37, 48),
(45, 72, 48),
(46, 37, 49),
(47, 72, 49),
(53, 187, 38),
(54, 187, 39),
(60, 105, 60),
(151, 130, 87),
(152, 130, 87),
(153, 114, 155),
(154, 114, 156),
(155, 130, 87),
(156, 114, 155),
(157, 114, 156),
(158, 44, 190),
(159, 71, 190),
(160, 44, 184),
(161, 44, 185),
(162, 130, 87),
(163, 114, 155),
(164, 114, 156),
(165, 44, 190),
(166, 71, 190),
(167, 44, 184),
(168, 44, 185),
(169, 6, 57),
(170, 6, 58),
(173, 57, 111),
(174, 57, 112),
(175, 6, 63),
(176, 138, 136),
(177, 138, 137),
(178, 6, 191),
(179, 6, 57),
(180, 6, 58),
(183, 57, 111),
(184, 57, 112),
(185, 6, 63),
(186, 138, 136),
(187, 138, 137),
(188, 6, 191),
(189, 169, 96),
(190, 169, 97),
(191, 169, 98),
(192, 169, 99),
(196, 25, 132),
(197, 177, 133),
(198, 177, 134),
(201, 169, 153),
(202, 177, 86),
(203, 177, 159),
(206, 177, 165),
(207, 93, 192),
(208, 177, 171),
(209, 93, 182),
(214, 177, 163),
(216, 103, 147),
(218, 103, 147),
(220, 103, 147),
(223, 10, 194),
(224, 44, 195),
(225, 57, 195),
(226, 76, 195),
(227, 44, 196),
(228, 169, 197),
(230, 284, 199),
(231, 285, 200),
(232, 287, 201),
(236, 284, 205),
(237, 169, 206),
(238, 286, 207),
(239, 104, 208),
(241, 178, 135),
(242, 178, 142),
(243, 178, 143),
(245, 125, 59),
(246, 101, 55),
(247, 101, 56),
(248, 93, 100),
(249, 93, 101),
(250, 178, 61),
(252, 178, 211),
(253, 21, 162),
(256, 44, 214),
(257, 130, 215),
(262, 130, 220),
(266, 104, 224),
(267, 104, 225),
(268, 290, 151),
(269, 290, 160),
(270, 290, 151),
(271, 290, 160),
(272, 290, 209),
(274, 289, 203),
(275, 289, 203),
(281, 289, 203),
(287, 289, 203),
(289, 130, 228),
(290, 6, 229),
(291, 101, 229),
(292, 118, 229),
(293, 138, 229),
(294, 6, 230),
(295, 101, 230),
(296, 118, 230),
(297, 138, 230),
(298, 54, 231),
(301, 60, 151),
(302, 60, 151),
(303, 60, 160),
(304, 180, 64),
(305, 60, 160),
(306, 105, 232),
(307, 105, 233),
(308, 105, 234),
(309, 105, 235),
(310, 130, 236),
(311, 178, 237),
(312, 138, 238),
(313, 282, 239),
(314, 178, 237),
(315, 138, 238),
(316, 81, 142),
(317, 81, 143),
(318, 31, 128),
(319, 31, 127),
(320, 31, 129),
(321, 31, 204);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_sprache`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_sprache` (
  `sp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sp_kuerzel` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Daten für Tabelle `modulverwaltung_sprache`
--

INSERT INTO `modulverwaltung_sprache` (`sp_id`, `sp_name`, `sp_kuerzel`) VALUES
(1, 'Deutsch', 'de'),
(2, 'Englisch', 'en'),
(3, 'Französisch', 'fr'),
(4, 'Italienisch', 'it'),
(5, 'Spanisch', 'es');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_sto_module`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_sto_module` (
  `sm_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sm_ects` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `sm_frequency` bigint(2) NOT NULL,
  `sto_id` bigint(20) NOT NULL,
  `m_id` bigint(20) NOT NULL,
  PRIMARY KEY (`sm_id`),
  KEY `sto_id` (`sto_id`,`m_id`),
  KEY `sto_id_2` (`sto_id`),
  KEY `m_id` (`m_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=143 ;

--
-- Daten für Tabelle `modulverwaltung_sto_module`
--

INSERT INTO `modulverwaltung_sto_module` (`sm_id`, `sm_ects`, `sm_frequency`, `sto_id`, `m_id`) VALUES
(3, '8', 2, 232, 3),
(4, '5', 2, 232, 4),
(5, '5', 2, 232, 6),
(6, '5', 2, 232, 7),
(7, '7', 2, 232, 8),
(8, '7', 2, 232, 9),
(9, '8', 2, 232, 10),
(10, '8', 2, 234, 11),
(11, '0', 2, 234, 12),
(12, '5', 2, 234, 13),
(13, '5', 2, 234, 14),
(14, '5', 2, 234, 15),
(15, '5', 2, 234, 16),
(17, '3', 2, 234, 18),
(25, '4', 5, 234, 26),
(26, '4', 5, 234, 27),
(27, '4', 5, 234, 28),
(28, '4', 5, 234, 29),
(29, '0', 2, 234, 30),
(30, '0', 2, 234, 31),
(31, '0', 5, 234, 32),
(32, '10', 2, 234, 33),
(34, '8', 1, 234, 35),
(35, '8', 1, 234, 36),
(37, '3', 1, 234, 38),
(39, '3', 1, 234, 40),
(40, '0', 1, 234, 41),
(41, '0', 1, 234, 42),
(42, '4', 1, 234, 43),
(50, '8', 1, 232, 51),
(51, '8', 1, 232, 52),
(52, '5', 1, 232, 53),
(54, '5', 1, 232, 55),
(55, '5', 1, 232, 56),
(56, '4', 1, 234, 57),
(58, '8', 1, 232, 59),
(68, '8', 1, 232, 69),
(69, '8', 1, 232, 70),
(70, '8', 1, 234, 71),
(71, '8', 1, 234, 72),
(72, '5', 1, 234, 73),
(73, '3', 1, 234, 74),
(74, '3', 1, 234, 75),
(75, '3', 1, 234, 76),
(76, '3', 1, 234, 77),
(77, '3', 1, 234, 78),
(78, '3', 1, 234, 79),
(79, '3', 1, 234, 80),
(80, '2', 1, 234, 81),
(81, '5', 1, 234, 82),
(83, '5', 1, 234, 84),
(84, '6', 1, 234, 85),
(85, '5', 1, 234, 86),
(86, '4', 1, 234, 87),
(87, '3', 1, 234, 88),
(88, '4', 1, 234, 89),
(89, '4', 1, 234, 90),
(90, '4', 1, 234, 91),
(91, '4', 1, 234, 92),
(94, '5', 1, 234, 95),
(95, '5', 1, 234, 96),
(96, '8', 1, 234, 97),
(97, '8', 1, 234, 98),
(98, '4', 1, 234, 99),
(99, '4', 1, 234, 100),
(100, '5', 1, 234, 101),
(101, '8', 1, 234, 102),
(102, '8', 1, 234, 103),
(103, '3', 1, 234, 104),
(104, '3', 1, 234, 105),
(105, '5', 1, 234, 106),
(106, '5', 1, 234, 107),
(107, '5', 1, 234, 108),
(108, '5', 1, 234, 109),
(109, '4', 3, 232, 110),
(110, '6', 2, 232, 111),
(111, '5', 1, 231, 112),
(112, '0', 1, 234, 113),
(113, '4', 1, 234, 114),
(114, '0', 1, 232, 115),
(115, '8', 1, 258, 116),
(116, '8', 1, 231, 117),
(117, '4', 1, 234, 118),
(118, '4', 1, 234, 119),
(119, '5', 1, 232, 120),
(121, '4', 1, 234, 122),
(122, '4', 1, 234, 123),
(123, '5', 1, 234, 124),
(124, '5', 1, 234, 125),
(125, '4', 1, 234, 126),
(127, '8', 1, 234, 128),
(129, '0', 1, 234, 130),
(130, '0', 1, 234, 131),
(139, '10', 5, 232, 140),
(141, '0', 5, 232, 142),
(142, '3', 5, 232, 143);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_studienart`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_studienart` (
  `sta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sta_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `modulverwaltung_studienart`
--

INSERT INTO `modulverwaltung_studienart` (`sta_id`, `sta_name`) VALUES
(1, 'Bachelor'),
(2, 'Master'),
(3, 'Lehramt'),
(4, 'keine Angabe');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_studienordnung`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_studienordnung` (
  `sto_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sto_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sto_kuerzel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `sto_jahr` year(4) DEFAULT NULL,
  `i_id` bigint(20) NOT NULL,
  `sta_id` bigint(20) NOT NULL,
  `sto_aktuell` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sto_id`),
  KEY `i_id` (`i_id`,`sta_id`),
  KEY `i_id_2` (`i_id`),
  KEY `sta_id` (`sta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=261 ;

--
-- Daten für Tabelle `modulverwaltung_studienordnung`
--

INSERT INTO `modulverwaltung_studienordnung` (`sto_id`, `sto_name`, `sto_kuerzel`, `sto_jahr`, `i_id`, `sta_id`, `sto_aktuell`) VALUES
(224, '60-LP-Modulangebot Informatik (StO/PO 2006)', '088a_m60', 2006, 7, 4, 0),
(225, '60-LP-Modulangebot Informatik (StO/PO 2005)', '088b_m60', 2005, 7, 4, 0),
(226, 'Modulangebot Informatik (30 LP, Studienordnung  2009)', '132b_m30', 2009, 7, 4, 0),
(227, 'Fachwissenschaft und Fachdidaktik Informatik', '207a_m38', NULL, 7, 4, 0),
(228, 'Fachwissenschaft und Fachdidaktik Informatik', '208a_m43', NULL, 7, 4, 0),
(229, 'Fachdidaktik Informatik', '236a_m11', NULL, 7, 4, 0),
(230, 'Fachdidaktik Informatik', '237a_m16', NULL, 7, 4, 0),
(231, 'Bachelor Informatik (150 LP, StO/PO 2002)', '086a_k150', 2002, 7, 1, 0),
(232, 'Bachelor Informatik (150 LP, Studienordnung  2007)', '086b_k150', 2007, 7, 1, 1),
(233, 'Kernfach Informatik (90 LP / Lehramt, Studienordnung 2009)', '087b_k90', 2009, 7, 3, 1),
(234, 'Master Informatik (1. ÄO (2014) zur StO/PO von 2008)', '089b_MA120', 2010, 7, 2, 1),
(235, '60-LP-Modulangebot Mathematik (StO/PO 2004)', '083a_m60', 2004, 8, 4, 0),
(236, 'Modulangebot Lehramt Physik 60 LP (StO 2007)', '091b_m60', 2007, 10, 3, 0),
(237, '60-LP-Modulangebot Mathematik (1. ÄO (2007) zur StO/PO 2004)', '083b_m60', 2007, 8, 4, 0),
(238, 'Bachelor Lehramt Physik (StO 2007)', '090b_k90', 2007, 10, 3, 0),
(239, 'Monobachelor Physik (StO 2006)', '182a_k150', 2006, 10, 1, 0),
(240, 'Kernfach Master Physik (StO 2009)', '352a_MA120', 2009, 10, 2, 0),
(241, 'Bachelor Lehramt Mathematik (StO/PO 2004)', '082a_k90', 2004, 8, 3, 0),
(242, 'Bachelor Lehramt Mathematik (1. ÄO (2007) zur StO/PO 2004)', '082b_k90', 2007, 8, 3, 0),
(243, 'Bachelor Lehramt Mathematik (2. ÄO (2014) zur StO/PO 2004)', '082c_k90', 2010, 8, 3, 0),
(244, 'Bachelor Mathematik (StO/PO 2001)', '084a_k120', 2001, 8, 1, 0),
(245, 'Bachelor Mathematik (1. ÄO (2005) zur StO/PO 2001)', '084b_k120', 2005, 8, 1, 0),
(246, 'Master Bioinformatik (StO/PO 2007)', '262a_MA120', 2007, 11, 2, 0),
(247, 'Bachelor Bioinformatik (StO/PO 2007)', '260a_k150', 2007, 11, 2, 0),
(248, 'Master Mathematik (StO/PO 2007)', '280a_MA120', 2007, 8, 2, 0),
(249, 'Master Mathematik (StO/PO 2011)', '280b_MA120', 2011, 8, 2, 1),
(250, 'Bachelor Mathematik (StO/PO 2013)', '084d_k120', 2013, 8, 1, 1),
(251, 'Bachelor Lehramt Physik (StO 2012)', '090c_k90', 2012, 10, 3, 1),
(252, 'Monobachelor Physik (StO 2012)', '182b_k150', 2012, 10, 1, 1),
(253, 'Kernfach Master Physik (StO 2013)', '352b_MA120', 2013, 10, 2, 1),
(254, '60-LP-Modulangebot Mathematik (StO/PO 2012)', '083c_m60', 2012, 8, 4, 0),
(255, 'Modulangebot Lehramt Physik 60 LP (StO 2012)', '091c_m60', 2012, 10, 3, 0),
(256, 'Bachelor Lehramt Mathematik (StO/PO 2012)', '082d_k90', 2012, 8, 3, 1),
(257, 'Bachelor Mathematik (StO/PO 2014)', '084c_k120', 2010, 8, 2, 0),
(258, 'Bachelor Bioinformatik (StO/PO 2014)', '260b_k150', 2010, 11, 1, 0),
(259, 'Bachelor Bioinformatik (StO/PO 2012)', '260c_k150', 2012, 11, 1, 1),
(260, 'Master Bioinformatik (StO/PO 2012)', '262b_MA120', 2012, 11, 2, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_termin`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_termin` (
  `t_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t_tag` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `t_von` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `t_bis` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1000 ;

--
-- Daten für Tabelle `modulverwaltung_termin`
--

INSERT INTO `modulverwaltung_termin` (`t_id`, `t_tag`, `t_von`, `t_bis`) VALUES
(1, 'Montag', '08', '10'),
(2, 'Montag', '10', '12'),
(3, 'Montag', '12', '14'),
(4, 'Montag', '14', '16'),
(5, 'Montag', '16', '18'),
(6, 'Montag', '18', '20'),
(7, 'Dienstag', '08', '10'),
(8, 'Dienstag', '10', '12'),
(9, 'Dienstag', '12', '14'),
(10, 'Dienstag', '14', '16'),
(11, 'Dienstag', '16', '18'),
(12, 'Dienstag', '18', '20'),
(13, 'Mittwoch', '08', '10'),
(14, 'Mittwoch', '10', '12'),
(15, 'Mittwoch', '12', '14'),
(16, 'Mittwoch', '14', '16'),
(17, 'Mittwoch', '16', '18'),
(18, 'Mittwoch', '18', '20'),
(19, 'Donnerstag', '08', '10'),
(20, 'Donnerstag', '10', '12'),
(21, 'Donnerstag', '12', '14'),
(22, 'Donnerstag', '14', '16'),
(23, 'Donnerstag', '16', '18'),
(24, 'Donnerstag', '18', '20'),
(25, 'Freitag', '08', '10'),
(26, 'Freitag', '10', '12'),
(27, 'Freitag', '12', '14'),
(28, 'Freitag', '14', '16'),
(29, 'Freitag', '16', '18'),
(30, 'Freitag', '18', '20'),
(31, 'Blockveranstaltung', '08', '10'),
(32, 'Blockveranstaltung', '10', '12'),
(33, 'Blockveranstaltung', '12', '14'),
(34, 'Blockveranstaltung', '14', '16'),
(35, 'Blockveranstaltung', '16', '18'),
(36, 'Blockveranstaltung', '18', '20'),
(999, 'Kein Termin', '', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_uebung`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_uebung` (
  `ub_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ub_lvnummer` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `ub_sws` int(2) NOT NULL,
  `ub_anwesenheitspflicht` tinyint(1) NOT NULL,
  `lv_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ub_id`),
  KEY `lv_id` (`lv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=42 ;

--
-- Daten für Tabelle `modulverwaltung_uebung`
--

INSERT INTO `modulverwaltung_uebung` (`ub_id`, `ub_lvnummer`, `ub_sws`, `ub_anwesenheitspflicht`, `lv_id`) VALUES
(1, '19100102', 2, 1, 4),
(2, '19100302', 2, 1, 5),
(3, '19100602', 2, 1, 7),
(4, '19101202', 2, 1, 10),
(5, '19101502', 2, 1, 12),
(6, '19101002', 2, 1, 14),
(7, '19104602', 2, 1, 16),
(8, '19103202', 2, 1, 18),
(9, '19103402', 2, 1, 20),
(10, '19105402', 2, 1, 22),
(11, '19103002', 2, 1, 24),
(12, '19103702', 2, 1, 26),
(13, '19104102', 2, 1, 47),
(14, '19103802', 2, 1, 48),
(15, '19100202', 2, 0, 64),
(16, '19100002', 2, 0, 67),
(17, '19100402', 2, 0, 68),
(18, '19100502', 2, 1, 72),
(19, '19100702', 2, 1, 75),
(20, '19100902', 2, 1, 90),
(21, '19101102', 2, 1, 92),
(22, '19103602', 2, 1, 94),
(23, '19105502', 2, 1, 97),
(24, '19104002', 2, 0, 99),
(25, '19104202', 2, 1, 109),
(26, '19104302', 2, 1, 113),
(27, '19104702', 2, 1, 115),
(28, '19104902', 2, 1, 126),
(29, '19104802', 2, 1, 127),
(30, '19105102', 2, 1, 129),
(31, '19105202', 2, 1, 131),
(32, '19102802', 2, 1, 136),
(33, '19102902', 2, 1, 137),
(34, '19103502', 2, 1, 139),
(35, '19104502', 1, 1, 142),
(36, '19105002', 1, 1, 146),
(37, '19101302', 2, 1, 153),
(38, '19101402', 2, 1, 155),
(39, '19000002', 2, 1, 161),
(40, '19111002', 2, 1, 164),
(41, '19112102', 2, 1, 177);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_uebung_planung`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_uebung_planung` (
  `up_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ub_id` bigint(20) NOT NULL,
  `s_id` bigint(20) NOT NULL,
  `r_id` bigint(20) DEFAULT NULL,
  `t_id` bigint(20) DEFAULT NULL,
  `l_id` bigint(20) DEFAULT NULL,
  `up_max_teilnehmer` int(11) DEFAULT NULL,
  `up_startdatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `up_enddatum` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`up_id`),
  KEY `u_id` (`ub_id`),
  KEY `s_id` (`s_id`),
  KEY `r_id` (`r_id`),
  KEY `t_id` (`t_id`),
  KEY `l_id` (`l_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

--
-- Daten für Tabelle `modulverwaltung_uebung_planung`
--

INSERT INTO `modulverwaltung_uebung_planung` (`up_id`, `ub_id`, `s_id`, `r_id`, `t_id`, `l_id`, `up_max_teilnehmer`, `up_startdatum`, `up_enddatum`) VALUES
(1, 13, 4, 4, 22, 103, NULL, NULL, NULL),
(2, 14, 4, 17, 25, 60, NULL, NULL, NULL),
(3, 20, 4, 7, 3, 101, NULL, NULL, NULL),
(4, 20, 4, 7, 4, 101, NULL, NULL, NULL),
(5, 20, 4, 7, 5, 101, NULL, NULL, NULL),
(6, 20, 4, 7, 1, 101, NULL, NULL, NULL),
(7, 20, 4, 7, 13, 101, NULL, NULL, NULL),
(8, 20, 4, 1000, 21, 101, NULL, NULL, NULL),
(9, 20, 4, 8, 4, 101, NULL, NULL, NULL),
(10, 20, 4, 8, 17, 101, NULL, NULL, NULL),
(11, 20, 4, 8, 1, 101, NULL, NULL, NULL),
(12, 21, 4, 7, 20, 57, NULL, NULL, NULL),
(13, 21, 4, 4, 21, 57, NULL, NULL, NULL),
(14, 21, 4, 4, 19, 57, NULL, NULL, NULL),
(15, 21, 4, 4, 15, 57, NULL, NULL, NULL),
(16, 21, 4, 8, 27, 57, NULL, NULL, NULL),
(17, 21, 4, 7, 23, 57, NULL, NULL, NULL),
(18, 21, 4, 17, 17, 57, NULL, NULL, NULL),
(19, 21, 4, 5, 26, 57, NULL, NULL, NULL),
(20, 22, 4, 8, 5, 178, NULL, NULL, NULL),
(21, 23, 4, 5, 3, 93, NULL, NULL, NULL),
(22, 24, 4, 8, 3, 79, NULL, NULL, NULL),
(23, 25, 4, 3, 23, 60, NULL, NULL, NULL),
(24, 26, 4, 2, 16, 125, NULL, NULL, NULL),
(25, 27, 4, 4, 9, 60, NULL, NULL, NULL),
(26, 28, 4, 4, 4, 144, NULL, NULL, NULL),
(27, 29, 4, 8, 22, 177, NULL, NULL, NULL),
(28, 30, 4, 1, 11, 118, NULL, NULL, NULL),
(29, 31, 4, 5, 13, 44, NULL, NULL, NULL),
(30, 31, 4, 6, 5, 44, NULL, NULL, NULL),
(31, 31, 4, 5, 14, 44, NULL, NULL, NULL),
(32, 33, 4, 8, 10, 138, NULL, NULL, NULL),
(33, 34, 4, 2, 8, 6, NULL, NULL, NULL),
(34, 34, 4, 4, 8, 6, NULL, NULL, NULL),
(35, 34, 4, 6, 16, 6, NULL, NULL, NULL),
(36, 35, 4, 3, 1, 114, NULL, NULL, NULL),
(37, 35, 4, 3, 25, 114, NULL, NULL, NULL),
(38, 36, 4, 5, 9, 93, NULL, NULL, NULL),
(39, 37, 4, 3, 31, 144, NULL, NULL, NULL),
(40, 37, 4, 2, 31, 144, NULL, NULL, NULL),
(41, 37, 4, 2, 33, 144, NULL, NULL, NULL),
(42, 37, 4, 3, 33, 144, NULL, NULL, NULL),
(43, 37, 4, 4, 33, 144, NULL, NULL, NULL),
(44, 37, 4, 1015, 33, 144, NULL, NULL, NULL),
(45, 37, 4, 2, 34, 144, NULL, NULL, NULL),
(46, 37, 4, 3, 34, 144, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_users`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_users` (
  `uu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `u_pwd` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `modulverwaltung_users`
--

INSERT INTO `modulverwaltung_users` (`uu_id`, `u_name`, `u_pwd`) VALUES
(1, 'esponda', '$2a$10$NWp/UXRRZE8styJQScziK.zQpXRnk4itJ3i3l0Ah/UhsW4HEbuOkS');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `modulverwaltung_user_roles`
--

CREATE TABLE IF NOT EXISTS `modulverwaltung_user_roles` (
  `ur_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uu_id` bigint(20) NOT NULL,
  `ro_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ur_id`),
  KEY `uu_id` (`uu_id`),
  KEY `ro_id` (`ro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_academic_term`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_academic_term` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_academic_term_k_uuid` (`k_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_building`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_building` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `c_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `k_creation_time` bigint(20) NOT NULL,
  `c_info` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_info_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_building_k_uuid` (`k_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Daten für Tabelle `mvs_scuttle_building`
--

INSERT INTO `mvs_scuttle_building` (`k_id`, `c_address`, `k_creation_time`, `c_info`, `c_info_title`, `k_last_modification_time`, `c_name`, `k_uuid`) VALUES
(1, 'Arnimallee 6', 1381793056563, NULL, NULL, 1398364041986, 'Pi-Gebäude', 'c48ee57a-4078-4ade-a7a1-b618be26be46'),
(2, 'Königin-Luise-Straße 24', 1381793349933, NULL, NULL, 1398364041985, NULL, '5febb5c9-c2d1-481e-b053-5c5fb2f65c9a'),
(3, 'Arnimallee 7', 1381793135472, NULL, NULL, 1398364041987, NULL, 'a95ee240-49c9-4708-9e6e-ac5fe4e9b8a1'),
(4, 'Arnimallee 3-5', 1381793005380, NULL, NULL, 1398364041987, NULL, 'd857a97a-9a60-4c5c-af6e-0b531b9e4073'),
(5, 'Takustraße 9', 1381793376446, NULL, NULL, 1398364041922, 'Institut für Informatik', 'd9d85f9c-a2c5-43c2-9e1e-ec76eca3e514');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_building_floor`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_building_floor` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `f_building` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  UNIQUE KEY `UNQ_mvs_scuttle_building_floor_0` (`c_name`,`f_building`),
  KEY `INDEX_mvs_scuttle_building_floor_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_building_floor_f_building` (`f_building`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Daten für Tabelle `mvs_scuttle_building_floor`
--

INSERT INTO `mvs_scuttle_building_floor` (`k_id`, `k_creation_time`, `k_last_modification_time`, `c_name`, `k_uuid`, `f_building`) VALUES
(1, 1381793009501, 1398364042264, 'Erdgeschoss', '38016501-e33b-4d32-81ef-14ceaa7d15f1', 4),
(2, 1381793035012, 1398364042310, '1. Obergeschoss', '61fb1bba-5fb7-4b2d-8ea7-27e69c78c3ca', 4),
(3, 1381793037980, 1398364042344, '2. Obergeschoss', '79b25025-7875-4037-82bd-ac0984fb8b97', 4),
(4, 1381793066941, 1398364042377, 'Erdgeschoss', '90c57db0-138d-4977-8859-4824b5dfdd2a', 1),
(5, 1381793090086, 1398364042413, '1. Obergeschoss', 'a099cb3f-52f5-470f-a52a-2e5a761a2d8a', 1),
(6, 1381793092862, 1398364042449, '2. Obergeschoss', 'c0b74544-6d1d-43ba-a701-8437712cce47', 1),
(7, 1381793100238, 1398364042483, 'Keller', '4aba440c-5294-4366-85cb-9916316582d3', 1),
(8, 1381793234739, 1398364042518, 'Erdgeschoss', '5ad90efd-f8eb-4b32-bc1c-06954ddf99a7', 3),
(9, 1381793327285, 1398364042553, 'Obergeschoss', '09ece9e4-5aee-4e9c-89c8-b14f33048656', 3),
(10, 1381793328477, 1398364042591, 'Keller', '408dcc55-aafd-4f6b-a83d-e30dade9dea2', 3),
(11, 1381793355053, 1398364042625, 'Erdgeschoss', 'bf7fddb9-0a64-4e13-b8ba-f39b9672da6c', 2),
(12, 1381793361775, 1398364042659, 'Obergeschoss', '8c325dd8-63aa-4ed9-9a1e-1a7cfc966064', 2),
(13, 1381793382582, 1398364042694, 'Erdgeschoss', '3ee44885-0e25-4189-9216-510d8cc47145', 5),
(14, 1381793384565, 1398364042724, 'Obergeschoss', '711bfd99-b70f-4ee4-9678-47347e0743da', 5),
(15, 1381793385845, 1398364042760, 'Keller', '6ae6d079-12dd-41e1-84bc-6dc449df6215', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_building_floor_any_feature`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_building_floor_any_feature` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `c_data` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_height` int(11) NOT NULL,
  `c_label` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_pos_x` int(11) NOT NULL,
  `c_pos_y` int(11) NOT NULL,
  `c_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `c_width` int(11) NOT NULL,
  `f_building_floor` bigint(20) NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_building_floor_any_feature_k_uuid` (`k_uuid`),
  KEY `mvs_scuttle_building_floor_any_featuref_building_floor` (`f_building_floor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_configuration`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_configuration` (
  `c_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `c_comment` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_value` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`c_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `mvs_scuttle_configuration`
--

INSERT INTO `mvs_scuttle_configuration` (`c_key`, `c_comment`, `k_creation_time`, `k_last_modification_time`, `c_value`) VALUES
('db-version', NULL, 1398364050828, 1398364050828, '2013-11-24'),
('eventobufferLink.jdbcDriver', NULL, 1398364050718, 1398364050718, 'com.mysql.jdbc.Driver'),
('eventobufferLink.jdbcPassword', NULL, 1398364050718, 1398364050718, 'eli02061985'),
('eventobufferLink.jdbcUrl', NULL, 1398364050718, 1398364050718, 'jdbc:mysql://localhost/scuttle?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8'),
('eventobufferLink.jdbcUser', NULL, 1398364050718, 1398364050718, 'root'),
('sakaiLink.jdbcDriver', 'The JDBC driver used to connect to the Sakai database.', 1398364050606, 1398364050606, 'com.mysql.jdbc.Driver'),
('sakaiLink.jdbcPassword', 'The password used to connect to the Sakai database.', 1398364050606, 1398364050606, 'eli02061985'),
('sakaiLink.jdbcUrl', 'The JDBD url that determines how to connect to the Sakai database.', 1398364050606, 1398364050606, 'jdbc:mysql://localhost/scuttle?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8'),
('sakaiLink.jdbcUser', 'The username used to connect to the Sakai database.', 1398364050606, 1398364050606, 'root'),
('sakaiWatchDog.enabled', 'Whether the sakai watchdog module should be enabled or not - possible values are yes and no.', 1398364050606, 1398364050606, 'no'),
('sakaiWatchDog.string', 'The string which is searched for in the sakaiWatchdogUrl.', 1398364050606, 1398364050606, 'Sakai works much better when JavaScript is enabled'),
('sakaiWatchDog.url', 'The url which is used to test for Sakai.', 1398364050606, 1398364050606, 'https://kvv.imp.fu-berlin.de/portal'),
('sakvv.currentAcademicTerm', 'The currenct academic term.', 1398364050597, 1398364050597, 'WS 13/14');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_day`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_day` (
  `c_index` int(11) NOT NULL,
  `c_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`c_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `mvs_scuttle_day`
--

INSERT INTO `mvs_scuttle_day` (`c_index`, `c_name`) VALUES
(1, 'Montag'),
(2, 'Dienstag'),
(3, 'Mittwoch'),
(4, 'Donnerstag'),
(5, 'Freitag'),
(6, 'Samstag'),
(7, 'Sonntag');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_event`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_event` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `f_academic_term` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_event_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_event_f_academic_term` (`f_academic_term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_event_takes_place`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_event_takes_place` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `f_event` bigint(20) DEFAULT NULL,
  `f_room` bigint(20) DEFAULT NULL,
  `f_timeslot` int(11) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  UNIQUE KEY `UNQ_mvs_scuttle_event_takes_place_0` (`f_room`,`f_timeslot`),
  KEY `INDEX_mvs_scuttle_event_takes_place_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_event_takes_place_f_timeslot` (`f_timeslot`),
  KEY `FK_mvs_scuttle_event_takes_place_f_event` (`f_event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_room`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_room` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `c_capacity` int(11) NOT NULL,
  `k_creation_time` bigint(20) NOT NULL,
  `c_height` int(11) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_pos_x` int(11) NOT NULL,
  `c_pos_y` int(11) NOT NULL,
  `c_room_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `c_width` int(11) NOT NULL,
  `f_building_floor` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  UNIQUE KEY `UNQ_mvs_scuttle_room_0` (`c_name`,`f_building_floor`),
  KEY `INDEX_mvs_scuttle_room_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_room_f_building_floor` (`f_building_floor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=258 ;

--
-- Daten für Tabelle `mvs_scuttle_room`
--

INSERT INTO `mvs_scuttle_room` (`k_id`, `c_capacity`, `k_creation_time`, `c_height`, `k_last_modification_time`, `c_name`, `c_pos_x`, `c_pos_y`, `c_room_id`, `c_type`, `k_uuid`, `c_width`, `f_building_floor`) VALUES
(1, 0, 1381794756991, 40, 1398364042788, NULL, 130, 60, '018', NULL, '0bffffb2-273a-4e3d-bd44-2023e878cdb6', 70, 13),
(2, 0, 1381794759710, 40, 1398364042833, NULL, 130, 100, '019', NULL, 'b00ca9d4-14e2-4eeb-8844-b74233981fb8', 70, 13),
(3, 0, 1381794763030, 40, 1398364042863, NULL, 130, 140, '020', NULL, '8d0c9714-9c7c-420f-8963-6d47438ce12f', 70, 13),
(4, 0, 1381794765211, 40, 1398364042892, NULL, 130, 180, '021', NULL, '0d6ed08a-1892-4399-a2db-49efb248635f', 70, 13),
(5, 0, 1381794768170, 30, 1398364042923, NULL, 130, 220, '022a', NULL, '76c41c1f-068a-49ed-a2e1-0289df81ad1c', 70, 13),
(6, 0, 1381794772241, 40, 1398364042952, NULL, 40, 100, '014', NULL, 'b7e591b0-d702-487b-9544-44ac11a9bc85', 70, 13),
(7, 0, 1381794776921, 40, 1398364042986, NULL, 40, 140, '013', NULL, '2c61bc6c-443d-49ac-a869-dfaa3433d79e', 70, 13),
(8, 0, 1381794780366, 40, 1398364043015, NULL, 40, 180, '012', NULL, '8ddb2517-1387-42b3-9646-053d089bd659', 70, 13),
(9, 0, 1381794783187, 40, 1398364043046, NULL, 40, 220, '011', NULL, '654fc375-38cc-400f-b876-32a670b455c3', 70, 13),
(10, 0, 1381794785393, 40, 1398364043076, NULL, 40, 260, '010', NULL, 'afd65b37-85e9-434e-bde1-29cfbed96969', 70, 13),
(11, 0, 1381794788127, 40, 1398364043104, NULL, 40, 300, '009', NULL, '02072196-c40a-4a3a-9c06-9a8722c7bd92', 70, 13),
(12, 0, 1381794807804, 30, 1398364043135, NULL, 130, 250, NULL, NULL, '04e05726-980d-475f-9c9d-d5b29dae21a0', 30, 13),
(13, 0, 1381794811652, 20, 1398364043163, NULL, 130, 280, NULL, NULL, 'ab82c636-a319-43e1-8c93-9c589af3ac8b', 30, 13),
(14, 0, 1381794816105, 50, 1398364043188, NULL, 160, 250, NULL, NULL, '9ba063f8-6923-4a5a-9dee-4de5ea61d807', 40, 13),
(15, 0, 1381794820133, 40, 1398364043213, NULL, 40, 340, '008', NULL, '6a189e4f-cda3-483c-a228-3be29b6ac834', 70, 13),
(16, 0, 1381794823621, 40, 1398364043245, NULL, 40, 380, '007', NULL, 'fde85eaf-1c7b-4b20-ab0f-653bde0d2ea6', 70, 13),
(17, 0, 1381794835692, 90, 1398364043274, NULL, 130, 330, '006', NULL, 'e478d503-bbe7-45f0-b0ff-8d6795082cbd', 110, 13),
(18, 0, 1381794840203, 90, 1398364043304, NULL, 240, 330, '005', NULL, '84399be7-8573-4a47-aa20-b59d4053bcaa', 120, 13),
(19, 0, 1381794858316, 40, 1398364043331, NULL, 690, 60, '040', NULL, 'df4e3aa3-894d-4b97-96e5-de5de546b8f1', 70, 13),
(20, 0, 1381794861825, 40, 1398364043356, NULL, 690, 100, '039', NULL, '886f6e15-8d8a-41b0-bb12-53245ed76cdc', 70, 13),
(21, 0, 1381794864357, 40, 1398364043383, NULL, 690, 140, '038', NULL, '7ceb6622-83c4-4be3-8965-19fc6ee9a009', 70, 13),
(22, 0, 1381794867260, 40, 1398364043412, NULL, 690, 180, '037', NULL, 'f1d49eb3-5fcb-415b-9329-99871ad51c2a', 70, 13),
(23, 0, 1381794870747, 30, 1398364043442, NULL, 690, 220, '036', NULL, 'aa3dbce1-e2a4-4c85-b135-7d3a871d07cd', 70, 13),
(24, 0, 1381794887456, 40, 1398364043471, NULL, 780, 100, '042', NULL, '135c1b5f-f611-4e51-a4fb-d56a5fa77a03', 70, 13),
(25, 0, 1381794891606, 60, 1398364043500, NULL, 780, 140, '044', NULL, 'e38e1b1b-14ee-46d5-bcc0-a26d31d06c5e', 70, 13),
(26, 0, 1381794895362, 100, 1398364043529, NULL, 780, 200, '046', NULL, 'c2dbb00c-5fc0-4754-9189-1866501f6a97', 70, 13),
(27, 0, 1381794900718, 70, 1398364043555, NULL, 490, 330, '055', NULL, '42c49835-21f5-4447-855d-aa374461fda5', 80, 13),
(28, 0, 1381794904598, 70, 1398364043583, NULL, 570, 330, '053', NULL, '8ef24f98-adbf-43f9-8939-cef8a4970d9e', 80, 13),
(29, 0, 1381794913622, 70, 1398364043609, NULL, 650, 330, '051', NULL, '1e37e8a4-9081-47e2-a3eb-69bbf7db78d0', 80, 13),
(30, 0, 1381794926538, 70, 1398364043638, NULL, 730, 330, '049', NULL, 'f54098e5-83da-48f9-a91e-244ec2c3fc43', 100, 13),
(31, 0, 1381794934616, 50, 1398364043663, NULL, 690, 250, NULL, NULL, 'f05dce4f-f86b-480c-92f1-232e85842203', 40, 13),
(32, 0, 1381794938057, 30, 1398364043688, NULL, 730, 250, NULL, NULL, '8b4e8fff-15bf-4276-8255-1b0f9b594ccd', 30, 13),
(33, 0, 1381794940781, 20, 1398364043716, NULL, 730, 280, NULL, NULL, '8f459f31-5236-4417-a0fa-4cc9f6c1ef81', 30, 13),
(34, 0, 1381795028922, 160, 1398364043743, 'Großer Hörsaal', 360, 60, '028', NULL, '124fde74-5c08-48b4-9497-3c06bbc254e1', 170, 13),
(35, 0, 1381795682787, 30, 1398364043767, NULL, 410, 350, NULL, NULL, '845e3418-95c9-4f88-ba70-1d48a218743f', 80, 13),
(36, 0, 1381795695273, 70, 1398364043790, NULL, 360, 350, NULL, NULL, '18f01f05-77fa-4896-a2cd-3cdd57675893', 50, 13),
(37, 0, 1381795869445, 30, 1398364043814, NULL, 780, 300, NULL, NULL, '2a0604c8-d48b-45e8-96b6-7a024e5f0926', 30, 13),
(38, 0, 1381796584754, 80, 1398364043838, NULL, 130, 60, 'K21', NULL, '0ffb8c99-92c1-4e5b-9d25-507b096a7695', 70, 15),
(39, 0, 1381796588120, 80, 1398364043859, NULL, 130, 140, 'K23', NULL, '56a6c412-6376-4842-8409-deefee040262', 70, 15),
(40, 0, 1381796592472, 60, 1398364043881, NULL, 130, 220, 'K25', NULL, '4d3e57d7-fee9-471e-bbcc-eafa9e1352b4', 70, 15),
(41, 0, 1381796603442, 30, 1398364043909, NULL, 40, 100, 'K16', NULL, 'aaad59ce-7ff5-4e60-9258-7b55e71f2444', 70, 15),
(42, 0, 1381796606276, 50, 1398364043929, NULL, 40, 130, 'K15', NULL, '7b0c66e8-710d-4805-8191-ab503ffac434', 70, 15),
(43, 0, 1381796640083, 80, 1398364043953, NULL, 40, 180, 'K14', NULL, 'ed108ea8-3ecd-4167-a2ef-d33fe912c967', 70, 15),
(44, 0, 1381796728373, 60, 1398364043973, NULL, 40, 260, 'K12', NULL, 'dfb95b70-a327-4275-b3f6-3ab1fe06ffa4', 70, 15),
(45, 0, 1381796733582, 40, 1398364043993, NULL, 40, 320, 'K11', NULL, 'b3df3099-417c-49fd-9b55-3a7807d55811', 70, 15),
(46, 0, 1381796757723, 70, 1398364044030, NULL, 40, 360, 'K10', NULL, '375bdfd8-8017-41fc-b5f4-d83e5201ef83', 90, 15),
(47, 0, 1381796760356, 70, 1398364044053, NULL, 130, 360, NULL, NULL, '9ccfc588-878f-43e8-84ee-a0fa4cb421ee', 30, 15),
(48, 0, 1381796764552, 70, 1398364044067, NULL, 160, 360, 'K09', NULL, '89e003ae-d88e-4df1-a2ff-59bade29390f', 80, 15),
(49, 0, 1381796768006, 70, 1398364044084, NULL, 240, 360, NULL, NULL, '67988ced-00a5-430f-80ad-5c733c66b499', 80, 15),
(50, 0, 1381796772630, 70, 1398364044100, NULL, 320, 360, 'K04', NULL, 'b2be6584-19d2-4253-948f-7b39899cc81c', 40, 15),
(51, 0, 1381796784453, 70, 1398364044116, NULL, 410, 360, 'K85', NULL, '0ea1b374-0d33-49d4-bc90-e53b0133244d', 30, 15),
(52, 0, 1381796787423, 70, 1398364044128, NULL, 440, 360, 'K84', NULL, '7433faa4-619f-431b-b88c-bfebb8e2eebd', 50, 15),
(53, 0, 1381796795230, 70, 1398364044147, NULL, 490, 360, 'K83', NULL, '73490ce7-3e86-4133-8b61-ef39523fbcae', 50, 15),
(54, 0, 1381796799270, 70, 1398364044159, NULL, 540, 360, 'K82', NULL, '5eeb353d-4ff0-4506-8cd5-42d90acf1b05', 60, 15),
(55, 0, 1381796803500, 70, 1398364044170, NULL, 600, 360, 'K81', NULL, 'de02c970-d5dc-49bc-a50f-61403b20c2e9', 50, 15),
(56, 0, 1381796810856, 70, 1398364044182, NULL, 650, 360, 'K80', NULL, 'd5a62724-cc53-4625-8f4e-882983212c3f', 50, 15),
(57, 0, 1381796814051, 70, 1398364044199, NULL, 700, 360, 'K79', NULL, '5a4d5582-063e-4cc1-a410-418a5ba2c3af', 60, 15),
(58, 0, 1381796820722, 70, 1398364044210, NULL, 760, 360, 'K77', NULL, '4e800cfc-3605-429f-be47-b38efadb3504', 90, 15),
(59, 0, 1381796844292, 80, 1398364044220, NULL, 360, 60, 'K40', NULL, 'a940109e-a1ef-417e-9e9b-bea0917717a1', 70, 15),
(60, 0, 1381796847711, 80, 1398364044229, NULL, 460, 60, 'K44', NULL, 'f0b839bb-b6d1-4c60-8cd3-945f44d61904', 70, 15),
(61, 0, 1381796850255, 80, 1398364044240, NULL, 360, 140, 'K38', NULL, 'e6dd1bc5-bee9-4034-82d8-a4859744ea33', 70, 15),
(62, 0, 1381796854101, 80, 1398364044249, NULL, 460, 140, 'K46', NULL, '6886ae8f-63f0-44f8-9222-de54e9fef7ff', 70, 15),
(63, 0, 1381796871831, 70, 1398364044260, NULL, 460, 220, 'K48', NULL, '744f9eaf-3639-43ca-8453-ceda86ad4187', 70, 15),
(64, 0, 1381796876366, 40, 1398364044271, NULL, 490, 290, 'K50', NULL, '88a8b4e5-80d8-476f-aea1-092d50d8dc7a', 70, 15),
(65, 0, 1381796880628, 40, 1398364044278, NULL, 560, 290, 'K51', NULL, '93e95fae-5c3b-427e-8b58-f12b93592e0d', 70, 15),
(66, 0, 1381796884994, 70, 1398364044286, NULL, 360, 220, 'K36', NULL, '1c1472bb-4941-4a53-a2d4-87428fb69357', 70, 15),
(67, 0, 1381796892174, 40, 1398364044294, NULL, 330, 290, 'K35', NULL, 'a76d4e61-e917-42e5-87b9-2cfee55d944d', 70, 15),
(68, 0, 1381796896570, 40, 1398364044301, NULL, 260, 290, 'K34', NULL, '7109a4e5-0d59-442a-aab1-96012024436b', 70, 15),
(69, 0, 1381796904805, 80, 1398364044308, NULL, 690, 60, 'K63', NULL, '9c1f21f9-a066-46a5-ab12-15f757de0eb1', 70, 15),
(70, 0, 1381796908699, 40, 1398364044315, NULL, 690, 140, 'K62', NULL, 'e4eb4a16-407c-465d-8c90-81e3731b559a', 70, 15),
(71, 0, 1381796912320, 40, 1398364044323, NULL, 690, 180, 'K61', NULL, '8a840408-dcc9-4e78-b44e-097264ce9f34', 70, 15),
(72, 0, 1381796915550, 60, 1398364044330, NULL, 690, 220, 'K60', NULL, '799db9ff-778c-4d6b-a85d-2486162926af', 70, 15),
(73, 0, 1381796931355, 60, 1398364044338, NULL, 780, 250, 'K75', NULL, '9c19ba67-f50c-4bdd-a844-1953c1c2c2cb', 70, 15),
(74, 0, 1381796936564, 30, 1398364044345, NULL, 780, 220, 'K73', NULL, '29b7036b-ab8a-49d6-8fe1-02237be9cad3', 30, 15),
(75, 0, 1381796940198, 30, 1398364044352, NULL, 810, 220, 'K74', NULL, '6010e028-d77b-4cb0-b002-7b4e661d8783', 40, 15),
(76, 0, 1381796942999, 40, 1398364044359, NULL, 780, 180, 'K72', NULL, '8a0a27fc-82e3-49a5-baa3-729db1746f75', 70, 15),
(77, 0, 1381796951033, 80, 1398364044365, NULL, 780, 100, 'K69', NULL, 'f4cff50b-88ba-4d26-9a6d-7e7fbae33a9a', 70, 15),
(78, 0, 1381796962857, 70, 1398364044372, NULL, 360, 360, NULL, NULL, 'cbdafd2b-c559-4d12-ad4b-1acbe9b076be', 50, 15),
(79, 0, 1381796980158, 50, 1398364044380, NULL, 130, 280, NULL, NULL, '604e684f-e201-4b30-b298-05798b2ffffe', 30, 15),
(80, 0, 1381796983105, 50, 1398364044390, NULL, 160, 280, NULL, NULL, '7cc96a1c-c0a4-412f-b79c-f44697542a99', 40, 15),
(81, 0, 1381796992040, 50, 1398364044398, NULL, 730, 280, NULL, NULL, 'c5225ed6-b7a8-489f-af04-f0a7d017b07e', 30, 15),
(82, 0, 1381796994895, 50, 1398364044406, NULL, 690, 280, NULL, NULL, '085801e4-cbd4-436e-a226-81ce40c789a2', 40, 15),
(83, 0, 1381797015777, 50, 1398364044413, NULL, 780, 310, 'K76', NULL, '76bb0c12-05d5-4175-a129-b3c476c6afe8', 70, 15),
(84, 0, 1381797053882, 30, 1398364044423, NULL, 430, 60, 'K42', NULL, '6dc46b9a-1841-42c4-a69a-a0bb6970800d', 30, 15),
(85, 0, 1381797107654, 30, 1398364044430, NULL, 200, 300, NULL, NULL, '3c58a2d6-7f8d-42a1-943b-5456ae7e92ef', 40, 15),
(86, 0, 1381797110613, 30, 1398364044438, NULL, 650, 300, NULL, NULL, '536875c0-0f36-4fb4-96d1-c3d82d549fb1', 40, 15),
(87, 0, 1381797710733, 40, 1398364044448, NULL, 120, 140, '122', NULL, '957621dd-3d23-4edc-81ca-462d5895eba5', 70, 14),
(88, 0, 1381797713275, 40, 1398364044459, NULL, 120, 180, '123', NULL, 'cc0b1b39-532f-4c72-bfc2-f4fedb24974a', 70, 14),
(89, 0, 1381797716471, 40, 1398364044467, NULL, 120, 220, '124', NULL, '170f1edc-f313-4bbf-91fe-a8f3d15b10cc', 70, 14),
(90, 0, 1381797719295, 60, 1398364044478, NULL, 120, 260, '125', NULL, '13e61140-a3b9-4228-b90c-dd63c7599d4d', 70, 14),
(91, 0, 1381797730038, 40, 1398364044487, NULL, 30, 260, '114', NULL, '002cc893-352f-4c37-a5f2-c4cd4848e62f', 70, 14),
(92, 0, 1381797733301, 40, 1398364044496, NULL, 30, 300, '113', NULL, '3c7bd9b0-ec03-4710-bd2c-f6b46effb609', 70, 14),
(93, 0, 1381797737262, 40, 1398364044505, NULL, 30, 340, '112', NULL, '13e64fc9-e11c-4c0d-9118-01d3d7e7fea0', 70, 14),
(94, 0, 1381797739781, 40, 1398364044513, NULL, 30, 380, '111', NULL, '36c66469-b4d3-4533-a6aa-e8e10d7a5ec4', 70, 14),
(95, 0, 1381797750570, 40, 1398364044520, NULL, 30, 420, '110', NULL, 'cdc1edc3-cc8c-4c43-a0ca-b36927df5f28', 70, 14),
(96, 0, 1381797770269, 60, 1398364044529, NULL, 240, 400, '106', NULL, 'd0f4f379-ab08-497b-b91b-7f7e3d3a6745', 40, 14),
(97, 0, 1381797772879, 60, 1398364044539, NULL, 280, 400, '105', NULL, '0710968f-8d88-4691-b131-c0ce8380c5ae', 40, 14),
(98, 0, 1381797776017, 60, 1398364044548, NULL, 320, 400, '104', NULL, 'ded9b444-ac9b-45f9-ba44-8597d1a55bef', 40, 14),
(99, 0, 1381797785783, 40, 1398364044558, NULL, 120, 100, '121', NULL, '5e134ac6-b1f3-4790-a13d-2d676c54fde7', 70, 14),
(100, 0, 1381797792645, 40, 1398364044566, NULL, 690, 100, '150', NULL, '7fec62d1-bb45-40e6-8290-e63e1e9b9262', 70, 14),
(101, 0, 1381797794906, 40, 1398364044576, NULL, 690, 140, '149', NULL, 'fff137a7-98c4-45b1-9513-166eaeeac290', 70, 14),
(102, 0, 1381797800803, 40, 1398364044587, NULL, 690, 180, '148', NULL, '764cedb7-edef-4576-ac3f-2cd6480325c1', 70, 14),
(103, 0, 1381797803435, 40, 1398364044595, NULL, 690, 220, '147', NULL, 'efed1551-fbac-4150-8c48-43bc1f03f404', 70, 14),
(104, 0, 1381797806268, 60, 1398364044602, NULL, 690, 260, '146', NULL, '8c3726d6-1e6f-4821-8085-631200576753', 70, 14),
(105, 0, 1381797812456, 40, 1398364044611, NULL, 780, 140, '154', NULL, '0e32d181-6fed-45f0-9ccc-f5dcb28fa80f', 70, 14),
(106, 0, 1381797814751, 40, 1398364044619, NULL, 780, 180, '155', NULL, 'adc5dd04-4704-448f-a6df-30edc4bed4ab', 70, 14),
(107, 0, 1381797817361, 40, 1398364044630, NULL, 780, 220, '156', NULL, '3735c453-72f9-495c-8651-ed1149e0d63c', 70, 14),
(108, 0, 1381797820152, 40, 1398364044638, NULL, 780, 260, '157', NULL, '11d0f471-9c94-462b-ba88-1ffdcc761f63', 70, 14),
(109, 0, 1381797823145, 40, 1398364044646, NULL, 780, 300, '158', NULL, 'a7d7832a-c22a-45ec-8d1a-b2808cbab548', 70, 14),
(110, 0, 1381797826363, 40, 1398364044899, NULL, 780, 340, '159', NULL, '6c6036b3-8d7a-4888-924a-3e6809e700dd', 70, 14),
(111, 0, 1381797829042, 40, 1398364044911, NULL, 780, 380, '160', NULL, 'a8461f51-5915-47bf-a471-521ea93c91f7', 70, 14),
(112, 0, 1381797834743, 40, 1398364044919, NULL, 780, 420, '161', NULL, 'ee333ee9-bc58-440c-bd3d-9c630769f6fa', 70, 14),
(113, 0, 1381797838275, 60, 1398364044926, NULL, 360, 400, NULL, NULL, 'eef34325-9d45-4a1c-93ef-807791e9c7b4', 40, 14),
(114, 0, 1381797840615, 60, 1398364044933, NULL, 400, 400, '170', NULL, '39a449d8-8222-4b82-89c3-70b57eefec60', 40, 14),
(115, 0, 1381797843225, 60, 1398364044940, NULL, 440, 400, '169', NULL, 'aadc9ac4-6a28-4ab3-a550-89eae7b93154', 40, 14),
(116, 0, 1381797845318, 60, 1398364044951, NULL, 480, 400, '168', NULL, '1955387b-7089-4660-bd41-b26da5cdeae1', 40, 14),
(117, 0, 1381797847489, 60, 1398364044960, NULL, 520, 400, '167', NULL, 'dec56300-0e5c-4e86-b454-8cb1760bd376', 40, 14),
(118, 0, 1381797849907, 60, 1398364044967, NULL, 560, 400, '166', NULL, '3fb495d0-4968-4718-b93c-a64f9318413d', 40, 14),
(119, 0, 1381797857377, 60, 1398364044978, NULL, 600, 400, '165', NULL, '676252b8-44eb-4ed7-a6d1-ae0c70dd7598', 40, 14),
(120, 0, 1381797860640, 60, 1398364044986, NULL, 640, 400, '164', NULL, '1b3c379a-79d7-4f45-bd06-74367a1acb4f', 40, 14),
(121, 0, 1381797863251, 60, 1398364044994, NULL, 680, 400, '163', NULL, '27b19aa4-f98c-41d9-80ab-74e1d3a6de81', 40, 14),
(122, 0, 1381797866671, 60, 1398364045002, NULL, 720, 400, '162', NULL, '02895f00-f0b9-40c5-9f79-90d403966f2f', 40, 14),
(123, 0, 1381797884039, 50, 1398364045014, NULL, 720, 320, NULL, NULL, 'c3bf324b-b7e4-47cc-84d6-6b42e27efbf8', 40, 14),
(124, 0, 1381797886697, 50, 1398364045022, NULL, 690, 320, NULL, NULL, '332903d2-97eb-4aaa-a2c4-bfead0c07724', 30, 14),
(125, 0, 1381797891747, 50, 1398364045030, NULL, 120, 320, NULL, NULL, 'eafe5e6a-4acb-4a31-a545-f056987f2c8b', 40, 14),
(126, 0, 1381797894504, 50, 1398364045040, NULL, 160, 320, NULL, NULL, 'ee879438-9720-4491-b464-56a0bbd138a7', 30, 14),
(127, 0, 1381797900364, 30, 1398364045050, NULL, 190, 340, NULL, NULL, '3d22d54b-915a-4a6d-a739-23089d48f8f9', 50, 14),
(128, 0, 1381797903526, 30, 1398364045058, NULL, 640, 340, NULL, NULL, '42d183ce-22b6-4d45-93fa-428666dc8ab5', 50, 14),
(129, 0, 1381797918005, 150, 1398364045067, NULL, 360, 100, NULL, NULL, 'bdd01685-a7a2-4d87-91d9-3f5136792e45', 160, 14),
(130, 0, 1381797925970, 50, 1398364045077, NULL, 360, 250, '135', NULL, 'a5835d7c-4456-404d-b98b-9d19d0039298', 70, 14),
(131, 0, 1381797932595, 50, 1398364045084, NULL, 450, 250, '136', NULL, 'bec714b6-5353-44bc-99d1-6d3f5cd640c7', 70, 14),
(132, 0, 1381797937702, 70, 1398364045091, NULL, 360, 300, '134', NULL, 'b192c6fd-7d78-43aa-88e1-941afb16de49', 70, 14),
(133, 0, 1381797942641, 70, 1398364045099, NULL, 450, 300, '137', NULL, '2d338bbe-130f-4bb1-a70d-7043ed791d03', 70, 14),
(134, 0, 1381797972106, 60, 1398364045110, NULL, 200, 400, '107', NULL, '484fff38-d868-4146-a4a6-287d05920ba6', 40, 14),
(135, 0, 1381797975143, 60, 1398364045118, NULL, 160, 400, '108', NULL, '19d46a78-f3cc-4e1a-93da-dc35f9233c78', 40, 14),
(136, 0, 1381797977574, 60, 1398364045126, NULL, 120, 400, '109', NULL, 'e7294787-4ed3-4973-b43c-b29afba4c9eb', 40, 14),
(137, 0, 1381798023025, 40, 1398364045135, NULL, 30, 140, '117', NULL, '7b1d03dc-f2cc-468d-841d-1b86aae42e0f', 70, 14),
(138, 0, 1381798025973, 40, 1398364045145, NULL, 30, 220, '115', NULL, 'cf64c45d-0592-4954-9906-a60b002ddee0', 70, 14),
(139, 0, 1381798029964, 40, 1398364045153, NULL, 30, 180, '116', NULL, 'b5fc364b-2d4e-4f03-9f31-c91ad831b615', 70, 14),
(140, 0, 1381798635769, 80, 1398364045162, NULL, 130, 20, '017', NULL, 'e74c5aa1-e608-4d18-b695-5baf510cd598', 80, 4),
(141, 0, 1381798647128, 80, 1398364045169, NULL, 360, 20, '025/026', NULL, 'c22c4400-7f79-4424-9e7e-eba73930d89d', 80, 4),
(142, 0, 1381798650716, 60, 1398364045176, NULL, 410, 100, '027', NULL, 'f6af32c8-8a8f-403f-87a2-5c70542a7318', 30, 4),
(143, 0, 1381798653911, 60, 1398364045184, NULL, 360, 100, '024', NULL, 'e878b297-1e30-485c-986e-caf478ab134a', 30, 4),
(144, 0, 1381798657140, 60, 1398364045192, NULL, 180, 100, '016', NULL, 'f72fb9ff-c92e-4bfa-b5de-8ac3e2e141a4', 30, 4),
(145, 0, 1381798661698, 60, 1398364045199, NULL, 130, 100, '015', NULL, '7befad9b-8934-4cc8-95d7-5e77d8c8e3b0', 40, 4),
(146, 0, 1381798666118, 50, 1398364045207, NULL, 410, 160, '028', NULL, 'a1ad37f9-4b7d-48fd-b3c0-f6e70c5d66f1', 30, 4),
(147, 0, 1381798669301, 30, 1398364045214, NULL, 400, 210, '029', NULL, 'c77e6b57-664d-406f-9d82-fe3cd02e7583', 40, 4),
(148, 0, 1381798673499, 30, 1398364045222, NULL, 330, 160, '022', NULL, '3cbe34cc-a18f-4031-8f8b-e540c7ccae1b', 60, 4),
(149, 0, 1381798682836, 30, 1398364045229, NULL, 300, 210, '021', NULL, 'd80cfcd9-f41f-4e87-ade9-82f869493214', 60, 4),
(150, 0, 1381798692288, 50, 1398364045237, NULL, 130, 240, '011', NULL, 'dc045cab-f936-4982-9c75-01bfbea595a4', 60, 4),
(151, 0, 1381798700015, 30, 1398364045245, NULL, 150, 210, '013', NULL, '9cffa5ce-c3d6-404b-9bf2-836f780a7493', 40, 4),
(152, 0, 1381798706371, 30, 1398364045253, NULL, 210, 210, '018', NULL, '87a04168-a214-4963-8045-fa9711bcf42f', 60, 4),
(153, 0, 1381798709443, 50, 1398364045261, NULL, 130, 290, '010', NULL, '67acf45d-809b-4e34-9ca9-bc577d3f5051', 60, 4),
(154, 0, 1381798713503, 50, 1398364045269, NULL, 130, 340, '009', NULL, 'e3af788c-6c55-498f-bcad-30b36c571fce', 60, 4),
(155, 0, 1381798717136, 90, 1398364045277, NULL, 130, 390, '008', NULL, '688b6084-57db-45f7-89e4-771afe0772b4', 60, 4),
(156, 0, 1381798720016, 50, 1398364045284, 'Kleiner PC-Pool', 140, 480, '006', NULL, '1a6477da-9a37-472e-bc41-c4041747c7c3', 50, 4),
(157, 0, 1381798736532, 30, 1398364045293, NULL, 190, 500, NULL, NULL, '740224c6-0d28-4f31-b8a2-e4b7a9c467d6', 20, 4),
(158, 0, 1381798740357, 50, 1398364045306, NULL, 330, 480, '033', NULL, 'a20dc65b-2570-4d15-8edd-6e34735d9eeb', 80, 4),
(159, 0, 1381798743619, 90, 1398364045320, NULL, 410, 440, '032', NULL, '9811b323-7c4d-4573-9bef-4d4275c0905d', 80, 4),
(160, 0, 1381798746803, 100, 1398364045330, NULL, 410, 340, '031', NULL, '3aefc044-d5a8-4330-ad2f-18f1ebe7d9e6', 80, 4),
(161, 0, 1381798749559, 100, 1398364045338, NULL, 410, 240, '030', NULL, '15d0c56a-7fa0-4700-8754-aea681cfe504', 80, 4),
(162, 0, 1381798871342, 20, 1398364045346, NULL, 290, 500, NULL, NULL, '264cb550-c515-4642-91fe-ec0f5e67a80f', 40, 4),
(163, 0, 1381798874919, 30, 1398364045357, 'Kopierraum', 150, 160, '015a', NULL, 'daee9048-eef3-411c-88c4-dd4d0e65003a', 20, 4),
(164, 0, 1381798881253, 30, 1398364045366, 'Hochspannung', 180, 160, '014', NULL, '302e291a-a9f8-4468-a69d-deac48b07c8a', 20, 4),
(165, 0, 1381798888475, 30, 1398364045374, NULL, 200, 160, '012', NULL, '0fd37bbc-eb3a-4781-92d4-744edeac398a', 40, 4),
(166, 0, 1381798892176, 30, 1398364045383, NULL, 240, 160, '019', NULL, 'a7c2afab-2e34-4e00-a4f1-347583c26779', 30, 4),
(167, 0, 1381798902571, 30, 1398364045397, 'Hausmeister', 300, 160, '020', NULL, 'b8ed6b97-faf8-46ac-acdc-7f01b27586e8', 30, 4),
(168, 0, 1381798986463, 110, 1398364045409, 'Aufenthaltsraum', 210, 420, '001', NULL, '0ff076b8-1246-45fa-ac6d-0f85481fac7a', 80, 4),
(169, 0, 1381799359458, 80, 1398364045419, NULL, 360, 20, NULL, NULL, '3ae5e325-0e91-460a-ab8a-222cde11551c', 40, 5),
(170, 0, 1381799363798, 80, 1398364045430, NULL, 400, 20, NULL, NULL, '40001b9f-b6d4-4fd3-8ed6-9e762f863585', 40, 5),
(171, 0, 1381799367446, 60, 1398364045440, NULL, 360, 100, NULL, NULL, '97a978b6-daa0-44f9-8b11-c2965ed3e30e', 30, 5),
(172, 0, 1381799370706, 60, 1398364045450, NULL, 410, 100, NULL, NULL, '0df32b01-b991-4ac1-bdbb-ee769c8216ac', 30, 5),
(173, 0, 1381799375727, 60, 1398364045461, NULL, 410, 160, NULL, NULL, 'dfe1a14a-8474-4b9c-b3ad-8c4a2264e131', 30, 5),
(174, 0, 1381799381934, 40, 1398364045469, NULL, 300, 160, NULL, NULL, '647ec9d5-a881-4f6d-87df-30df1ffb21f9', 50, 5),
(175, 0, 1381799384240, 40, 1398364045477, NULL, 350, 160, NULL, NULL, 'f2e0c636-5af1-4fdb-8590-ad1550e2be6b', 40, 5),
(176, 0, 1381799391924, 80, 1398364045486, NULL, 130, 20, NULL, NULL, '508356e1-eea9-43c1-a0a0-49436eb41048', 40, 5),
(177, 0, 1381799394421, 80, 1398364045494, NULL, 170, 20, NULL, NULL, '9a60e27f-5477-435a-9a42-eee3b53b467a', 40, 5),
(178, 0, 1381799398651, 60, 1398364045502, NULL, 130, 100, NULL, NULL, '44eb02e6-edf1-4a2b-9efe-b4e315719508', 30, 5),
(179, 0, 1381799400968, 60, 1398364045511, NULL, 180, 100, NULL, NULL, 'a3a8b0de-c1e8-4b81-ba02-434abc1aff3a', 30, 5),
(180, 0, 1381799412050, 40, 1398364045522, NULL, 180, 160, NULL, NULL, '7099221e-3373-4c4d-9b0c-bf0e3b2f2281', 50, 5),
(181, 0, 1381799414873, 40, 1398364045531, NULL, 230, 160, NULL, NULL, '10314593-218d-4bf9-8495-2e717793679c', 40, 5),
(182, 0, 1381799421658, 40, 1398364045542, NULL, 150, 210, NULL, NULL, '32087ba4-9dd8-402e-922d-4a2dee5f0a86', 40, 5),
(183, 0, 1381799427958, 40, 1398364045551, NULL, 210, 210, NULL, NULL, '9c855de9-08e4-4e29-8db8-c9063af06a1f', 60, 5),
(184, 0, 1381799431098, 40, 1398364045561, NULL, 300, 210, NULL, NULL, '2bcbf73d-b69f-459e-9e61-d373546cf14b', 50, 5),
(185, 0, 1381799433392, 40, 1398364045571, NULL, 350, 210, NULL, NULL, '6f914785-f678-468d-9e25-7fa6b2cdf769', 40, 5),
(186, 0, 1381799515351, 50, 1398364045579, NULL, 380, 250, NULL, NULL, 'c8216dfd-6761-49d0-93b6-2f1e8426d5ae', 50, 5),
(187, 0, 1381799520512, 50, 1398364045588, NULL, 130, 250, NULL, NULL, 'f2602e0c-d13a-4775-b1ac-b9ca86ad16b7', 60, 5),
(188, 0, 1381799523661, 50, 1398364045597, NULL, 130, 300, NULL, NULL, '80175a1d-5d4c-479a-9d90-bc8a34b22c7f', 60, 5),
(189, 0, 1381799527599, 90, 1398364045606, NULL, 130, 350, NULL, NULL, '35fb9701-daae-41fe-9cb0-916d48d9e37f', 60, 5),
(190, 0, 1381799531311, 50, 1398364045614, NULL, 130, 440, NULL, NULL, '17f48481-c379-4a5b-bd4b-39c2701a0569', 60, 5),
(191, 0, 1381799534405, 50, 1398364045623, NULL, 140, 490, NULL, NULL, '75e657b3-439c-45dc-b593-03f16493b8e4', 70, 5),
(192, 0, 1381799537600, 50, 1398364045632, NULL, 210, 490, NULL, NULL, 'c36e249f-58bd-452d-a99f-38be9223aff9', 50, 5),
(193, 0, 1381799541301, 40, 1398364045642, NULL, 260, 490, NULL, NULL, 'b7a0708c-b7de-4381-9a1c-6a9b1d475c1e', 70, 5),
(194, 0, 1381799548659, 50, 1398364045650, NULL, 330, 490, NULL, NULL, 'fa7eb1ce-cc11-48e3-935c-42ac7b4e2e94', 50, 5),
(195, 0, 1381799551314, 50, 1398364045660, NULL, 380, 490, NULL, NULL, '4d0f3a64-be89-4e1f-a3a7-7ecc44fc9e9d', 50, 5),
(196, 0, 1381799554993, 50, 1398364045672, NULL, 430, 490, NULL, NULL, '257db1f1-c584-42a9-a823-57c3873e7518', 50, 5),
(197, 0, 1381799563512, 50, 1398364045684, NULL, 380, 300, NULL, NULL, 'df26d77f-e79a-45ce-8e35-ac79a2d34c13', 50, 5),
(198, 0, 1381799567740, 50, 1398364045693, NULL, 380, 350, NULL, NULL, '41b8ff53-a6ae-4e74-8291-82cf30926ac6', 50, 5),
(199, 0, 1381799576514, 40, 1398364045702, NULL, 380, 400, NULL, NULL, '0044db04-a216-4b13-add5-825aa661949f', 50, 5),
(200, 0, 1381799581891, 40, 1398364045710, NULL, 210, 430, NULL, NULL, '8e7cdf2c-c840-432a-9e5a-d91ce934ef51', 50, 5),
(201, 0, 1381799586065, 40, 1398364045719, NULL, 260, 430, NULL, NULL, 'bd9e7834-61de-4abc-80e1-b3871c8c2cec', 30, 5),
(202, 0, 1381799590184, 30, 1398364045731, NULL, 380, 440, NULL, NULL, '8cd81701-ab4d-4940-8a38-8c70e1e91ff5', 30, 5),
(203, 0, 1381799596630, 50, 1398364045912, NULL, 450, 250, NULL, NULL, '0ba14002-03a4-47e6-8613-c0b1a428c503', 50, 5),
(204, 0, 1381799599734, 50, 1398364045924, NULL, 450, 300, NULL, NULL, 'edf1dbcb-480c-4026-88ca-a3ecd6169355', 50, 5),
(205, 0, 1381799603446, 50, 1398364045934, NULL, 450, 350, NULL, NULL, 'c6a49cd6-7829-4e20-9449-0885715b3b6b', 50, 5),
(206, 0, 1381799615316, 40, 1398364045943, NULL, 450, 400, NULL, NULL, 'ff53b7e7-95cc-4475-aa69-56375271abb9', 50, 5),
(207, 0, 1381799618072, 50, 1398364045953, NULL, 450, 440, NULL, NULL, '4552c8ab-3ae6-4f40-92f9-0998c3037cba', 50, 5),
(208, 0, 1381800168066, 80, 1398364045969, 'Bibliothek', 90, 170, '028', NULL, '4022f13d-3653-4aec-9568-8db81f6a9939', 80, 1),
(209, 0, 1381800172271, 120, 1398364045980, 'Lesesaal II', 170, 130, '026', NULL, 'd1c8a49e-aa5f-495b-a314-f3069232433d', 230, 1),
(210, 0, 1381800193871, 120, 1398364046001, 'Hörsaal', 90, 250, '001', NULL, 'ef737f72-a78b-41af-b674-42075152ae9b', 120, 1),
(211, 0, 1381800196311, 40, 1398364046015, NULL, 90, 370, NULL, NULL, '4373d7ee-6d02-4387-b1df-76436706f4c0', 40, 1),
(212, 0, 1381800213670, 40, 1398364046026, NULL, 170, 370, NULL, NULL, 'd72d27f2-3a8b-4afd-9b17-cd662bd9ee56', 40, 1),
(213, 0, 1381800221556, 20, 1398364046039, NULL, 90, 410, NULL, NULL, '3c176a38-d136-4633-b641-47cc38da66fc', 30, 1),
(214, 0, 1381800230950, 50, 1398364046051, NULL, 170, 410, '006', NULL, '310f254e-c9a8-48a9-8f47-d009f1cb6679', 80, 1),
(215, 0, 1381800238566, 50, 1398364046060, NULL, 170, 480, '005', NULL, '8733e742-33c7-4afe-a031-6bd03355cae7', 80, 1),
(216, 0, 1381800249005, 50, 1398364046069, NULL, 250, 410, '007', NULL, '0786a5a0-5e06-44bc-b117-2348985b59c2', 40, 1),
(217, 0, 1381800253529, 50, 1398364046077, NULL, 290, 410, '009', NULL, 'd393a4bb-57d5-460b-bd34-521ebbac0ff3', 40, 1),
(218, 0, 1381800255902, 50, 1398364046087, NULL, 330, 410, '012', NULL, '64445c30-4ac5-472d-b0df-fda411a179cd', 40, 1),
(219, 0, 1381800258118, 50, 1398364046098, NULL, 250, 480, '006', NULL, '727581a8-f6bd-4e70-a7c4-c2d8fa329592', 40, 1),
(220, 0, 1381800260255, 50, 1398364046107, NULL, 290, 480, '010', NULL, '1a7d2961-5632-4136-b1de-bb9d9e0e7939', 40, 1),
(221, 0, 1381800262899, 50, 1398364046118, NULL, 330, 480, '011', NULL, '598a465d-18c9-42f3-87a3-d74ff7f570fc', 40, 1),
(222, 0, 1381800269110, 50, 1398364046181, NULL, 370, 480, '015', NULL, '8650e2a3-69d6-406b-beb2-2253bf133c2f', 30, 1),
(223, 0, 1381800271484, 50, 1398364046193, 'Heizung', 400, 480, '017', NULL, 'ff4eebc2-8e0d-4350-a4ec-022834acf8e0', 20, 1),
(224, 0, 1381800274084, 50, 1398364046202, NULL, 420, 480, NULL, NULL, '265795b0-88d4-4561-a429-b48fbb9a0dad', 20, 1),
(225, 0, 1381800284389, 50, 1398364046213, NULL, 370, 410, '016', NULL, '470edbf8-a08b-4010-9ac9-eeb9b3612b44', 30, 1),
(226, 0, 1381800290316, 40, 1398364046221, NULL, 360, 370, NULL, NULL, 'e2cb4e59-6a35-436c-981b-d88f2ab1f339', 80, 1),
(227, 0, 1381800302478, 40, 1398364046230, NULL, 520, 480, NULL, NULL, '18ff36b3-596a-42d2-93c8-0d2e7228f32a', 50, 1),
(228, 0, 1381800305516, 40, 1398364046239, NULL, 570, 480, NULL, NULL, '2c6e766b-317f-49c4-8fd0-cdce2e1c5eb6', 60, 1),
(229, 0, 1381800324170, 50, 1398364046247, NULL, 400, 130, '030', NULL, '13c2c5e2-d36a-4b99-81b1-79a1f24b6ddd', 40, 1),
(230, 0, 1381801258178, 110, 1398364046257, NULL, 120, 270, NULL, NULL, '15cda559-9d04-4462-8ad2-98aa91b1f83a', 80, 8),
(231, 0, 1381801278936, 70, 1398364046267, NULL, 240, 380, NULL, NULL, '29c90fcd-9cc4-43ce-8313-a5a8e2a96f34', 50, 8),
(232, 0, 1381801282129, 70, 1398364046276, NULL, 290, 380, NULL, NULL, '1e9a36ce-d5fa-477f-8d7c-3389d429da6e', 50, 8),
(233, 0, 1381801285324, 70, 1398364046285, NULL, 340, 380, NULL, NULL, '445783a6-0e2f-4816-a6f4-f80c5036d164', 50, 8),
(234, 0, 1381801296304, 150, 1398364046294, NULL, 290, 10, NULL, NULL, '8ded6578-41d1-4654-bd4f-991fd43a615e', 100, 8),
(235, 0, 1381801300029, 70, 1398364046303, NULL, 240, 10, NULL, NULL, '8b8a2bc2-42d0-48d0-90bd-1b6388578650', 50, 8),
(236, 0, 1381801303177, 60, 1398364046312, NULL, 240, 100, NULL, NULL, '1f99fc04-29b1-4ae5-bb17-374ecf56b3aa', 50, 8),
(237, 0, 1381801309973, 60, 1398364046321, NULL, 190, 100, NULL, NULL, '96477a43-7108-428b-8e4b-9f7974ad2a74', 50, 8),
(238, 0, 1381801315508, 110, 1398364046331, NULL, 120, 160, NULL, NULL, 'b7f8bd10-1814-4921-941e-f82691b94d56', 80, 8),
(239, 0, 1381801322441, 40, 1398364046345, NULL, 160, 120, NULL, NULL, '7d1d4d60-5289-4be0-bc38-753007d6dc52', 30, 8),
(240, 0, 1381801325285, 40, 1398364046355, NULL, 120, 120, NULL, NULL, 'fab3f681-2b30-4888-bad2-18c186dc9f1b', 40, 8),
(241, 0, 1381801337826, 70, 1398364046367, NULL, 140, 10, NULL, NULL, '0a6a4ae1-9ec5-4d36-94d1-eead31bfd598', 100, 8),
(242, 0, 1381801350630, 70, 1398364046378, NULL, 240, 470, NULL, NULL, '6e39de5d-7dd4-4051-a2cf-77ce55cab8a9', 150, 8),
(243, 0, 1381801370434, 60, 1398364046388, NULL, 10, 320, NULL, NULL, '2536fa55-c34b-483e-9f61-e15b9580b826', 80, 8),
(244, 0, 1381801377170, 60, 1398364046399, NULL, 10, 260, NULL, NULL, 'e24603fc-a1ee-48e0-9c0c-de4286ec16e2', 80, 8),
(245, 0, 1381801381512, 100, 1398364046409, NULL, 10, 160, NULL, NULL, '75858ff0-a9ea-4beb-beee-3840c64d3e5a', 80, 8),
(246, 0, 1381801388622, 30, 1398364046419, NULL, 40, 130, NULL, NULL, '83dec1e2-d036-445b-b5ee-56d3a213596b', 50, 8),
(247, 0, 1381801390838, 30, 1398364046432, NULL, 40, 100, NULL, NULL, '3d898ea5-b73d-4350-8930-de446310cc34', 50, 8),
(248, 0, 1381801396271, 90, 1398364046441, NULL, 40, 10, NULL, NULL, 'e45d1f29-c6a1-47a5-b93f-f58100ec9866', 50, 8),
(249, 0, 1381801409469, 30, 1398364046455, NULL, 40, 380, NULL, NULL, '0bb5a71d-b92e-410c-a65d-c95d0feb6d4b', 50, 8),
(250, 0, 1381801412044, 30, 1398364046465, NULL, 40, 410, NULL, NULL, '8d3d21a4-8c90-435e-af49-541809cac723', 50, 8),
(251, 0, 1381801418547, 30, 1398364046478, NULL, 40, 440, NULL, NULL, '4be42e50-52ae-4c92-9e70-48e269f5d3df', 50, 8),
(252, 0, 1381801425961, 30, 1398364046489, NULL, 40, 470, NULL, NULL, 'b8383d32-1c20-4186-87e5-289bf516ce4b', 50, 8),
(253, 0, 1381801430236, 40, 1398364046498, NULL, 40, 500, NULL, NULL, '9871c918-068f-488c-99f5-c5302d39149e', 50, 8),
(254, 0, 1381801441576, 40, 1398364046514, NULL, 150, 470, NULL, NULL, 'a9b4caeb-bc88-439a-8e56-2e76df073b65', 40, 8),
(255, 0, 1381803040285, 120, 1398364046523, 'Katalograum', 360, 250, '025', NULL, '746c5959-330f-428d-bd94-596a30bd2a75', 80, 1),
(256, 0, 1381803081391, 80, 1398364046556, 'Aufsichtsloge', 440, 330, '020', NULL, '6e72e479-095f-4b8d-8b84-b99937b8ca24', 80, 1),
(257, 0, 1381803092844, 110, 1398364046573, 'Lesesaal', 520, 330, '022', NULL, 'b7e30269-a0e7-4d28-ab6c-065dcfb76ee8', 110, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_room_any_feature`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_room_any_feature` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `c_data` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_pos_x` int(11) NOT NULL,
  `c_pos_y` int(11) NOT NULL,
  `c_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `f_room` bigint(20) NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_room_any_feature_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_room_any_feature_f_room` (`f_room`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=301 ;

--
-- Daten für Tabelle `mvs_scuttle_room_any_feature`
--

INSERT INTO `mvs_scuttle_room_any_feature` (`k_id`, `k_creation_time`, `c_data`, `k_last_modification_time`, `c_pos_x`, `c_pos_y`, `c_type`, `k_uuid`, `f_room`) VALUES
(1, 1381795908337, NULL, 1398364046583, 0, 10, 'door r180', 'e25690d9-f032-447d-b034-828a2291c586', 37),
(2, 1381795914233, NULL, 1398364046623, 0, 0, 'door r270', 'ff8df62b-dcbe-43b5-a37e-0f270880471a', 37),
(3, 1381795918519, NULL, 1398364046639, 20, 0, 'door', '1d6ce60b-b541-4f5e-838b-6d26b9b4bba5', 37),
(4, 1381795920419, NULL, 1398364046648, 20, 10, 'door r90', '2698f59f-9339-4591-bc1c-23b0ba48ee41', 37),
(5, 1381795931759, NULL, 1398364046659, 10, 150, 'door r180', '768f0629-3503-4a42-8c15-9a82dd560709', 34),
(6, 1381795935734, NULL, 1398364046671, 20, 150, 'door r90', 'a1f4e975-0faa-4552-9ad7-518f42d921f4', 34),
(7, 1381795938241, NULL, 1398364046681, 150, 150, 'door r90', '8058e1d5-0b78-4d22-9020-4b481d32ba18', 34),
(8, 1381795940355, NULL, 1398364046692, 140, 150, 'door r180', '41497bb7-6b28-4b79-a447-321d310c4fa1', 34),
(9, 1381795946914, NULL, 1398364046702, 10, 0, 'door r270', 'b848c5ab-a7dd-4b56-906c-fc4a9aadde9d', 27),
(10, 1381795949556, NULL, 1398364046712, 10, 0, 'door r270', '57b0800b-14e6-4886-95b5-37c14a6ca52b', 28),
(11, 1381795952133, NULL, 1398364046723, 10, 0, 'door r270', 'decfddf3-4c43-44c4-929f-4d8da3c2fee6', 29),
(12, 1381795956230, NULL, 1398364046737, 10, 0, 'door r270', '843b9719-464f-4558-b1b1-b7ef3ab79240', 30),
(13, 1381795966649, NULL, 1398364046747, 60, 20, 'door', 'ac97b7c0-c6b6-4b62-9e63-c7fabab1c1ba', 20),
(14, 1381795968749, NULL, 1398364046756, 60, 20, 'door', '7f00048f-5b7d-4b16-9b73-863d9a814d67', 21),
(15, 1381795971015, NULL, 1398364046768, 60, 20, 'door', '56c4c9c1-be6e-4951-9ab6-76df794aff1c', 19),
(16, 1381795974295, NULL, 1398364046783, 0, 20, 'door r270', '45d3ff2c-4745-4282-8d5a-796861dbdb65', 24),
(17, 1381795978899, NULL, 1398364046793, 0, 20, 'door r270', 'f7f13cd5-043b-4d02-9e1e-c5709f09f6e8', 25),
(18, 1381795984388, NULL, 1398364046806, 60, 20, 'door', '80001181-965d-4b72-a29a-32ca33052c2b', 22),
(19, 1381795992939, NULL, 1398364046816, 60, 10, 'door', '08a77175-8bf7-4cd5-954e-80f1371e76fe', 23),
(20, 1381795999429, NULL, 1398364046826, 0, 80, 'door r180', '2ede8434-eae9-47c8-88c6-f474477e7e3c', 26),
(21, 1381796010510, NULL, 1398364046836, 10, 40, 'door r180', '69ea6a09-c548-49c6-a9df-4687d2479277', 31),
(22, 1381796015495, NULL, 1398364046846, 20, 40, 'door r90', '47f61cba-380b-4803-b36a-e3fbeaadf466', 14),
(23, 1381796020703, NULL, 1398364046856, 10, 20, 'door r180', '1b06ed22-bc6a-42c7-b928-db614a26a928', 35),
(24, 1381796022696, NULL, 1398364046866, 20, 20, 'door r90', '38dedd77-cdcf-4c47-ab9e-80b9da71e1b3', 35),
(25, 1381796039289, NULL, 1398364046875, 60, 20, 'door r90', '9837afba-ee39-46df-b9f0-ec982e539a2d', 35),
(26, 1381796041549, NULL, 1398364046886, 50, 20, 'door r180', '8dbfee0d-5072-4932-8f85-951209f213f1', 35),
(27, 1381796046522, NULL, 1398364046896, 10, 0, 'door r270', '6a1a44c6-89a0-4ae2-b099-768b7e7ef28f', 35),
(28, 1381796049088, NULL, 1398364046906, 20, 0, 'door', '68e80325-6fd8-45a1-bc47-4187391bc450', 35),
(29, 1381796050593, NULL, 1398364046916, 50, 0, 'door r270', '77c1732b-6c69-4f83-b9b5-19756da23b11', 35),
(30, 1381796053218, NULL, 1398364046925, 60, 0, 'door', 'df6eeda7-a04e-4035-89e8-b63f004f59c8', 35),
(31, 1381796060338, NULL, 1398364046935, 10, 0, 'door r270', '501e65e7-902e-4aab-9c09-09f38b5b009a', 18),
(32, 1381796071046, NULL, 1398364046945, 10, 0, 'door r270', 'da9a6394-f63e-404e-a8d1-e3e647faa4f9', 17),
(33, 1381796074725, NULL, 1398364046960, 90, 0, 'door', 'e596cbac-eda8-4390-9e97-42208f8ed59b', 17),
(34, 1381796080509, NULL, 1398364046970, 100, 0, 'door', '542fda22-9b9e-4e61-b8d5-51461c0087bf', 18),
(35, 1381796093558, NULL, 1398364046981, 30, 0, 'door', '6d47afe3-9451-483f-a1b5-b2e278acaa75', 36),
(36, 1381796096359, NULL, 1398364046991, 40, 40, 'door r90', '56dc0759-229a-429b-a944-3a46a293fe7b', 36),
(37, 1381796109208, NULL, 1398364047004, 0, 20, 'door r270', '4c2e7dc2-12fe-492e-90cb-6b48dc468de0', 1),
(38, 1381796115395, NULL, 1398364047016, 0, 10, 'door r270', 'a0435675-f565-4b4f-bf12-12fcbf1a270a', 2),
(39, 1381796120896, NULL, 1398364047028, 0, 10, 'door r270', 'acfe3413-3e64-4b74-8df6-6070c612e59b', 3),
(40, 1381796124204, NULL, 1398364047039, 0, 10, 'door r270', '586342d4-8719-4fee-8cdf-d14ec2fdd4a9', 4),
(41, 1381796128264, NULL, 1398364047050, 0, 10, 'door r270', 'db1d35f6-9e5e-4970-8b1a-9283aff52fb8', 5),
(42, 1381796134632, NULL, 1398364047063, 60, 10, 'door', 'db3d2d44-fb30-46fe-9207-08ef59355517', 6),
(43, 1381796137264, NULL, 1398364047074, 50, 0, 'door r270', 'f0ae4a17-29c9-4359-bf57-1e579d46b18b', 7),
(44, 1381796144836, NULL, 1398364047084, 60, 10, 'door', '3afc8d18-787e-4959-89e5-72c64f7bdc69', 7),
(45, 1381796149374, NULL, 1398364047094, 50, 0, 'door r270', '124fd779-690a-4670-a0d5-915e9d0a1c23', 8),
(46, 1381796155501, NULL, 1398364047106, 60, 10, 'door', '44c7ac36-1292-4a72-a207-f5b49d6dd03b', 8),
(47, 1381796164343, NULL, 1398364047124, 60, 10, 'door', '4fd93b83-c98a-4e02-adec-9f2a1cfcb8ba', 9),
(48, 1381796167483, NULL, 1398364047136, 60, 10, 'door', '67dea9e5-d266-4052-86bb-c1b6823722d6', 10),
(49, 1381796173591, NULL, 1398364047149, 60, 20, 'door r90', '7c7f127e-d087-47a1-bbff-a428f95594fb', 11),
(50, 1381796182625, NULL, 1398364047164, 60, 20, 'door r90', '271e3428-a602-4989-a4b0-37e5519f4661', 15),
(51, 1381796184504, NULL, 1398364047178, 60, 20, 'door r90', 'e48bf8cf-4de2-41ce-afc6-e6d30deb6c6f', 16),
(52, 1381796205160, NULL, 1398364047191, 10, 10, 'door r180', 'e9545e32-fa75-40b9-b7ac-2e01471e169b', 13),
(53, 1381796208387, NULL, 1398364047202, 10, 10, 'door r90', '41c79a2b-ac5c-41e9-9fbb-c88580469038', 33),
(54, 1381796211200, NULL, 1398364047213, 0, 10, 'door r180', '27bbab00-7cb4-4357-8b48-7147ff3a6027', 12),
(55, 1381796217739, NULL, 1398364047224, 20, 10, 'door r90', 'd470729d-9795-467b-9363-5ddd4d7a1274', 32),
(56, 1381796239676, NULL, 1398364047238, 60, 0, 'door r270', 'ad659e7a-12c6-4257-bc93-0565914511f3', 34),
(57, 1381796242846, NULL, 1398364047249, 70, 0, 'door', '51281c38-3616-4546-8f80-871a84bbb893', 34),
(58, 1381796244243, NULL, 1398364047261, 90, 0, 'door r270', '6e0f4565-279b-43d9-b062-c5aefd4e36b7', 34),
(59, 1381796250273, NULL, 1398364047275, 100, 0, 'door', '3692e7a5-83df-40d5-9bcd-997c13fb0f76', 34),
(60, 1381797135646, NULL, 1398364047288, 10, 20, 'door r90', '728a5b4a-9edc-4d13-bc24-40aff4166b81', 84),
(61, 1381797143972, NULL, 1398364047300, 60, 60, 'door r90', 'c536b81c-3784-479d-9bba-8d05dbcc8fb6', 59),
(62, 1381797146390, NULL, 1398364047314, 0, 60, 'door r180', 'b1115a73-a3cd-4ddf-a3c9-cb6b6c19d9b3', 60),
(63, 1381797152231, NULL, 1398364047327, 60, 60, 'door r90', 'bcb48afa-f296-4bb2-a55d-a9ccbecb169c', 60),
(64, 1381797153986, NULL, 1398364047337, 60, 50, 'door', '28454c6a-9e27-43a2-8fe5-5f2f4c42ffa2', 60),
(65, 1381797156684, NULL, 1398364047347, 0, 60, 'door r180', 'ebc340db-61ae-4c03-85c9-a80f8068a8d7', 59),
(66, 1381797158631, NULL, 1398364047358, 0, 50, 'door r270', '005bcc11-f9f7-4aa2-933e-38530a238b6f', 59),
(67, 1381797163006, NULL, 1398364047371, 0, 10, 'door r270', '2e1a68ad-9a61-48bb-96f8-3d9baa89a0b1', 61),
(68, 1381797165279, NULL, 1398364047383, 0, 20, 'door r180', 'a8f91f6e-742d-4a4c-9e4b-268c9d745766', 61),
(69, 1381797169026, NULL, 1398364047395, 0, 60, 'door r180', '684d2ea7-aa45-424f-9cd7-7fd8406791a0', 61),
(70, 1381797171184, NULL, 1398364047406, 0, 50, 'door r270', 'a482658b-9397-43d2-9a71-fb28e600af94', 61),
(71, 1381797177506, NULL, 1398364047417, 60, 60, 'door r90', '9ef5caa2-0651-4fde-aea1-5472fa93c0a0', 61),
(72, 1381797179576, NULL, 1398364047430, 60, 10, 'door', '54db9bfd-c122-4987-b54e-f7cc0a10d677', 61),
(73, 1381797181051, NULL, 1398364047440, 0, 10, 'door r270', '014e1a5b-af80-45b0-92ac-2889ee251c81', 62),
(74, 1381797183559, NULL, 1398364047451, 0, 60, 'door r180', 'b365be79-f23d-4d59-9df8-c3b3484d0c20', 62),
(75, 1381797187116, NULL, 1398364047463, 0, 10, 'door r270', '028f7c88-9450-4fe6-8099-20897f3dc6e4', 63),
(76, 1381797190230, NULL, 1398364047474, 0, 50, 'door r180', 'd24faed4-2e87-4a0f-8e51-8e208c67120e', 63),
(77, 1381797192334, NULL, 1398364047489, 60, 50, 'door r90', 'fd50c10d-760e-47a2-8eab-c438737a9f07', 66),
(78, 1381797194855, NULL, 1398364047502, 60, 10, 'door', 'e452cf3a-3f14-4ac6-9166-2a9451e4d4d1', 66),
(79, 1381797196474, NULL, 1398364047515, 0, 10, 'door r270', 'ec515711-351b-4fa1-8c51-1e75bc249f9f', 66),
(80, 1381797198837, NULL, 1398364047527, 0, 20, 'door r180', '562ced2f-c105-44ce-b4f3-ce3cc5ba6b0c', 66),
(81, 1381797202685, NULL, 1398364047540, 0, 50, 'door r180', '4755c459-144c-4ff9-a5f1-976f4643f50c', 66),
(82, 1381797205678, NULL, 1398364047554, 0, 40, 'door r270', 'e43ec683-1d10-453f-8348-8334dc384c56', 66),
(83, 1381797208411, NULL, 1398364047570, 60, 10, 'door', 'f7284b56-be28-4ff7-822f-623555e70df9', 63),
(84, 1381797209862, NULL, 1398364047581, 60, 20, 'door r90', '1a700029-c25f-4cbc-a99a-f05cedc0664e', 63),
(85, 1381797211686, NULL, 1398364047592, 60, 40, 'door', 'aa88b4a7-fe15-4ef8-9124-663383182b50', 63),
(86, 1381797214555, NULL, 1398364047604, 60, 50, 'door r90', '8bb370d6-82fc-4e5d-b098-9ee582ecba77', 63),
(87, 1381797217400, NULL, 1398364047615, 60, 10, 'door', 'b8c26b67-a209-4ff6-ae20-c7252972d586', 62),
(88, 1381797218695, NULL, 1398364047626, 60, 20, 'door r90', 'e0e542ca-20e0-4a70-8009-989c2630ec5f', 62),
(89, 1381797221281, NULL, 1398364047643, 60, 60, 'door r90', 'cba6e350-c36c-4dcb-a9b6-1af12e815283', 62),
(90, 1381797223095, NULL, 1398364047656, 60, 50, 'door', 'ee4fbf8b-e4b4-4dcf-934b-eb4838600d56', 62),
(91, 1381797237831, NULL, 1398364047669, 60, 60, 'door r90', '001c521d-2205-47b4-84cb-22578cd21394', 69),
(92, 1381797242409, NULL, 1398364047680, 60, 10, 'door', '7fc64ce5-3fbd-49b2-ad4e-dd62b827f2ef', 70),
(93, 1381797250159, NULL, 1398364047691, 60, 10, 'door', '7272e690-6119-4b4a-a39d-342723068269', 71),
(94, 1381797254053, NULL, 1398364047702, 60, 10, 'door', '0603f4a3-ae74-421d-9d83-1b9733026f8f', 72),
(95, 1381797259746, NULL, 1398364047713, 0, 10, 'door r180', 'df4a6539-c103-4058-a6dd-1c3b2ea33bfb', 74),
(96, 1381797265211, NULL, 1398364047724, 0, 10, 'door r180', '2453b73c-a378-4204-a665-d5adaaa6d6f6', 76),
(97, 1381797272007, NULL, 1398364047740, 0, 20, 'door r270', '490a11e6-9e74-4950-bad6-1723142d5bcb', 77),
(98, 1381797278308, NULL, 1398364047755, 0, 20, 'door r270', 'd98e2c1c-6a22-4acc-ba5c-4b772dc92cbf', 73),
(99, 1381797285260, NULL, 1398364047767, 0, 20, 'door r180', '6eda3046-4912-45a9-8bcb-a7ea3d81dbf5', 83),
(100, 1381797290685, NULL, 1398364047782, 10, 0, 'door r270', '1621c813-f792-4b19-8aff-12ce0cce9b28', 58),
(101, 1381797297603, NULL, 1398364047793, 70, 0, 'door r270', 'ade4c025-d78f-4417-b2d4-f27b91bcccea', 46),
(102, 1381797328979, NULL, 1398364047806, 60, 10, 'door r90', '60244507-5b84-413d-9b0b-decf55b4108e', 41),
(103, 1381797333963, NULL, 1398364047817, 0, 60, 'door r180', '8d21efa7-2e21-4677-a769-c0e105da154b', 38),
(104, 1381797339802, NULL, 1398364047830, 0, 20, 'door r270', '78a20e23-f146-4394-9001-90029f4767eb', 38),
(105, 1381797355068, NULL, 1398364047841, 60, 10, 'door', '1aa82c86-5ee2-48c2-89e6-734416aa342c', 39),
(106, 1381797356721, NULL, 1398364047856, 60, 20, 'door r90', '296214f3-87f1-4c5b-a259-593efd5a9e46', 39),
(107, 1381797364822, NULL, 1398364047866, 60, 50, 'door', '1d63e9b6-1d04-4082-b572-b09716eec1bc', 39),
(108, 1381797366206, NULL, 1398364047878, 60, 60, 'door r90', 'd1e4e894-b5a6-4e5f-b0c5-926f5c6f52bc', 39),
(109, 1381797369997, NULL, 1398364047893, 0, 20, 'door r270', '88ae3dbe-66b2-4215-b749-538c9e1192f4', 40),
(110, 1381797376363, NULL, 1398364047907, 60, 10, 'door', 'e7898536-4171-49ce-9cbb-55f1a233742e', 40),
(111, 1381797378085, NULL, 1398364047923, 60, 20, 'door r90', '518216f1-5100-41f9-9951-3742de2569ba', 40),
(112, 1381797391394, NULL, 1398364047938, 60, 10, 'door r90', '531e1309-d40e-45e5-9f2b-a9879151c80c', 45),
(113, 1381797394736, NULL, 1398364047951, 60, 20, 'door', '70b27f7f-d6ef-474b-ac00-62317f485472', 44),
(114, 1381797400630, NULL, 1398364047963, 60, 10, 'door', 'd671b634-f7ec-467f-8141-6557a8f1ced8', 43),
(115, 1381797402003, NULL, 1398364047975, 60, 60, 'door r90', '1844341f-096d-4554-9c43-d63d5d2e8d66', 43),
(116, 1381797409304, NULL, 1398364047990, 0, 10, 'door r270', '56469fe1-ee8f-4a27-bb1f-7389dbb568a8', 39),
(117, 1381797414917, NULL, 1398364048005, 0, 60, 'door r180', '52332578-344e-423e-8309-3a185dccc669', 39),
(118, 1381797423603, NULL, 1398364048016, 60, 30, 'door r90', 'f2ee8a3b-0636-481f-b7a6-3d9dfee8ae47', 42),
(119, 1381797428564, NULL, 1398364048027, 10, 0, 'door r270', 'cf510315-0d29-493a-925b-80bccd518889', 47),
(120, 1381797434156, NULL, 1398364048039, 10, 0, 'door r270', '5c182d25-8351-484e-a1e3-2c66fe6cda79', 48),
(121, 1381797439353, NULL, 1398364048050, 60, 0, 'door r270', 'a61e0cfb-151a-435a-b54a-a7bc046716b6', 49),
(122, 1381797445146, NULL, 1398364048065, 10, 0, 'door r270', 'bda45f69-9ea4-4b6f-90a2-03476f84eee9', 50),
(123, 1381797451651, NULL, 1398364048077, 10, 0, 'door', '9564c841-0f8e-4d53-83b8-cdd25a62a8a3', 51),
(124, 1381797456024, NULL, 1398364048090, 30, 0, 'door r270', '66428d96-3cba-44bb-8e06-e9806dc68c54', 52),
(125, 1381797466386, NULL, 1398364048110, 10, 0, 'door r270', '74e877ab-607d-4c79-9dd0-d9c5f319781a', 53),
(126, 1381797469841, NULL, 1398364048124, 10, 0, 'door r270', 'dc18e75c-8718-4ef7-ba65-f68272a85d0e', 54),
(127, 1381797476422, NULL, 1398364048140, 30, 0, 'door', 'd51068cb-96fb-4f27-b905-936423b65f4f', 55),
(128, 1381797479099, NULL, 1398364048152, 10, 0, 'door r270', '0a6818c3-5d62-4a0e-aad1-4118f66485ca', 56),
(129, 1381797483466, NULL, 1398364048165, 10, 0, 'door r270', 'cff9cbac-7304-41f9-a415-de166a159ac8', 57),
(130, 1381797489257, NULL, 1398364048177, 10, 30, 'door r180', '73b84438-bc15-410e-b802-4abeb09a654b', 64),
(131, 1381797491463, NULL, 1398364048189, 50, 30, 'door r90', '6117a098-9086-4609-9690-7caaa4b138d2', 67),
(132, 1381797510869, NULL, 1398364048200, 20, 30, 'door r180', '554ac0c8-9cbb-419a-bc03-cece28b5f5a1', 68),
(133, 1381797516944, NULL, 1398364048212, 40, 30, 'door r90', '2592c545-2120-4e9a-88cc-d5daaef7efb6', 65),
(134, 1381797524447, NULL, 1398364048225, 10, 40, 'door r180', '79599418-9368-4a64-ab4c-af7f43b591d8', 82),
(135, 1381797526496, NULL, 1398364048238, 10, 40, 'door r90', '9e07fb41-363c-4927-ab3c-b93e29c646ea', 81),
(136, 1381797530457, NULL, 1398364048250, 10, 40, 'door r180', 'e228581f-c30e-4179-af53-05b1174a946f', 79),
(137, 1381797534977, NULL, 1398364048263, 20, 40, 'door r90', 'a3849077-949a-4bab-8c57-a188e5551ac1', 80),
(138, 1381797538307, NULL, 1398364048275, 10, 20, 'door r90', 'ee78a8e0-106e-4f55-8080-39950ced0fdd', 85),
(139, 1381797540895, NULL, 1398364048288, 10, 20, 'door r180', '189648b1-36e1-41d3-b9ee-460aa3e43268', 86),
(140, 1381797553664, NULL, 1398364048299, 30, 0, 'door', 'd55317e7-4e14-4d20-9ef2-ee33ca16fca8', 78),
(141, 1381798045861, NULL, 1398364048311, 60, 30, 'door r90', '834cb2e9-5116-46f9-91ef-126d8489e97b', 130),
(142, 1381798047897, NULL, 1398364048323, 0, 30, 'door r180', '7653ec26-55d7-453f-b257-6e9b63f0b4f6', 131),
(143, 1381798059588, NULL, 1398364048336, 40, 60, 'door r90', 'afaf0645-5891-46c0-bbca-052fe8c11f9b', 133),
(144, 1381798062241, NULL, 1398364048348, 20, 60, 'door r180', '63e12379-5ed5-4d39-8db5-c8cb2c5dc6dc', 132),
(145, 1381798068227, NULL, 1398364048359, 10, 40, 'door r90', '1874c050-9ae6-44f6-9853-3a341a8bda2b', 126),
(146, 1381798072142, NULL, 1398364048372, 10, 40, 'door r180', '21799746-508e-4806-81a5-7387572f2eb8', 125),
(147, 1381798075764, NULL, 1398364048387, 20, 40, 'door r90', 'd9bb517f-4462-4a1d-bb88-515c8610280a', 123),
(148, 1381798077789, NULL, 1398364048404, 10, 40, 'door r180', '2708e857-1d65-4d84-81c2-aa2b0c2d2cdb', 124),
(149, 1381798087397, NULL, 1398364048418, 0, 20, 'door r180', '2fa73796-62ba-4aa4-a3c3-1cd6f93aab69', 99),
(150, 1381798092865, NULL, 1398364048431, 0, 20, 'door r180', 'f02ef889-c892-49bc-bfd6-cb8c22745b5c', 87),
(151, 1381798095926, NULL, 1398364048444, 0, 20, 'door r180', 'd9ffded2-0449-47f5-be26-aee084a30329', 88),
(152, 1381798098176, NULL, 1398364048457, 0, 20, 'door r180', '25444c25-d844-46a0-a1ef-7800a9141898', 89),
(153, 1381798102888, NULL, 1398364048468, 0, 10, 'door r180', 'ff63912d-eff3-4960-851a-f58f7ddf7865', 90),
(154, 1381798112945, NULL, 1398364048480, 60, 10, 'door', 'af2673bd-73d8-4d52-8c3f-791a59fe0d7f', 91),
(155, 1381798137876, NULL, 1398364048492, 10, 30, 'door r180', '9e742ce6-8255-49be-81c9-4eb1b1e45799', 111),
(156, 1381798140294, NULL, 1398364048503, 10, 30, 'door r180', 'd3cb2da6-0121-4c61-a90f-63d49bbe63ac', 110),
(157, 1381798147122, NULL, 1398364048516, 0, 10, 'door r270', '73adc2ac-d032-4105-a31c-b5a50e59dd5f', 110),
(158, 1381798156923, NULL, 1398364048533, 0, 20, 'door r180', '9557aa16-53f9-4421-a5d6-d808fe002112', 112),
(159, 1381798170331, NULL, 1398364048544, 0, 10, 'door r180', 'd7140307-3de8-4578-9266-8253532cf41c', 111),
(160, 1381798174562, NULL, 1398364048557, 0, 10, 'door r270', 'f263b23d-dea4-4a3c-9eaf-938366a4599c', 109),
(161, 1381798178421, NULL, 1398364048569, 0, 10, 'door r270', '43c202ad-0944-4b64-a7cf-db1721a24f7a', 108),
(162, 1381798182224, NULL, 1398364048584, 0, 10, 'door r270', 'ba4dd9c5-44d6-40de-9b09-16d0d723dc3a', 107),
(163, 1381798184598, NULL, 1398364048599, 0, 10, 'door r270', 'd4e947b9-55ff-4b6a-bc19-6526e3d6f375', 106),
(164, 1381798189831, NULL, 1398364048611, 0, 10, 'door r270', '963e4635-33aa-417c-90a0-9d1cbfbb8610', 105),
(165, 1381798197276, NULL, 1398364048625, 10, 30, 'door r180', 'ffe895d5-508d-405b-b8f7-0f37a6e75e47', 105),
(166, 1381798199257, NULL, 1398364048637, 10, 30, 'door r180', '4c6eb566-5684-4f6c-b21d-4d87f9ea171d', 106),
(167, 1381798218921, NULL, 1398364048650, 50, 30, 'door r90', 'dc0720bd-61f3-47de-ae2f-40c77e6ce9a8', 137),
(168, 1381798223071, NULL, 1398364048666, 50, 30, 'door r90', '7a11515a-8107-454c-beed-c1c2cd26fdcc', 139),
(169, 1381798228550, NULL, 1398364048678, 60, 10, 'door', '2b99e33b-e133-4e92-b895-3a86cb7f58a3', 137),
(170, 1381798229990, NULL, 1398364048690, 60, 10, 'door', 'f8e8d1bd-216a-43b3-9b1c-b66c8063c8fa', 139),
(171, 1381798232971, NULL, 1398364048704, 60, 10, 'door', '747eb85d-5c4b-4e6d-9dea-672a88f7759e', 138),
(172, 1381798234997, NULL, 1398364048716, 60, 10, 'door', '8149f9d8-d8ac-4353-bbfe-71928901a2f9', 92),
(173, 1381798239272, NULL, 1398364048728, 60, 10, 'door', '4cf20920-befa-43b9-a80c-1f02ea97839a', 93),
(174, 1381798240374, NULL, 1398364048740, 60, 20, 'door r90', '3be16ed6-a5c0-4350-bfc2-3bfec3b1ab76', 94),
(175, 1381798242872, NULL, 1398364048753, 60, 20, 'door r90', '8ec46ec8-a0dd-4ba1-9af7-0a1b5f9504a3', 95),
(176, 1381798247068, NULL, 1398364048766, 10, 0, 'door r270', '7e7fca34-7b4b-41e3-8cb8-70bc4280c93c', 136),
(177, 1381798252053, NULL, 1398364048780, 10, 0, 'door r270', '921dfa40-70b2-4257-bf47-b52eaca6aa0a', 135),
(178, 1381798254482, NULL, 1398364048794, 10, 0, 'door r270', '789fc5dc-be11-4048-826d-d7da70ceafd6', 134),
(179, 1381798258521, NULL, 1398364048806, 10, 0, 'door r270', 'c0643876-c99b-4008-b967-4619d49afb26', 96),
(180, 1381798260918, NULL, 1398364048818, 10, 0, 'door r270', '34cb1586-e305-443f-927e-1ce54ae2cfc9', 97),
(181, 1381798265946, NULL, 1398364048831, 10, 0, 'door r270', 'f4bee919-c201-4e94-99db-cc8b8dfd1d65', 98),
(182, 1381798269377, NULL, 1398364048843, 20, 0, 'door', '219250b2-403f-4063-84a0-cef59774596d', 122),
(183, 1381798270953, NULL, 1398364048855, 20, 0, 'door', 'ca473c31-d90d-403d-b054-532b7e590320', 121),
(184, 1381798272493, NULL, 1398364048868, 20, 0, 'door', '7547d56c-f159-404d-817d-25e5791c4cfe', 120),
(185, 1381798275262, NULL, 1398364048884, 20, 0, 'door', 'd94d357e-33ce-439e-adf1-e06f8fc499c7', 119),
(186, 1381798277387, NULL, 1398364048897, 20, 0, 'door', '977e8cf7-f778-4220-b68b-0c0fc7879380', 118),
(187, 1381798289695, NULL, 1398364048912, 10, 0, 'door r270', '3b0f5b75-38a1-4718-8168-c0ea5011779c', 115),
(188, 1381798322568, NULL, 1398364048924, 10, 0, 'door r270', 'fd71aad5-589b-429b-a778-8731eee48cde', 117),
(189, 1381798324762, NULL, 1398364048936, 10, 0, 'door r270', 'fcae0804-d249-4858-9ea2-5f3b9eeb5bab', 116),
(190, 1381798329407, NULL, 1398364048953, 10, 0, 'door r270', '901fcc5e-a775-41ae-a701-9721c145aa68', 114),
(191, 1381798332873, NULL, 1398364048969, 20, 0, 'door', 'f1f7cade-b38c-4549-8b8e-711559fa6c0e', 113),
(192, 1381798339554, NULL, 1398364048983, 60, 20, 'door r90', '65f9b5a0-2ca2-4b74-b9ae-45efda1db2e1', 100),
(193, 1381798347994, NULL, 1398364048996, 60, 10, 'door r90', '359eb821-008d-46ff-a50e-33b49b324485', 101),
(194, 1381798352133, NULL, 1398364049009, 60, 10, 'door r90', '0e09b165-6eeb-4296-979a-d9dce87854f1', 102),
(195, 1381798355080, NULL, 1398364049026, 60, 10, 'door r90', 'a964a8e4-f906-4c9a-800a-a7cdac421a41', 103),
(196, 1381798359616, NULL, 1398364049038, 60, 10, 'door r90', '647e0bac-2599-4d5d-ad78-a103ae0bc217', 104),
(197, 1381798374588, NULL, 1398364049052, 30, 20, 'door r90', '067f0da4-f5b5-4503-8252-267661833499', 128),
(198, 1381798380258, NULL, 1398364049068, 10, 20, 'door r180', 'c9bf5d6c-17ce-49a1-8d39-317d2b3675af', 127),
(199, 1381798922821, NULL, 1398364049083, 40, 70, 'door r90', '24d15d15-4acf-43a3-b6e8-43c614536dfb', 140),
(200, 1381798926208, NULL, 1398364049098, 30, 70, 'door r180', '167c3646-a02e-4338-88fe-4eb799b4f755', 141),
(201, 1381798927976, NULL, 1398364049113, 40, 70, 'door r90', '8339ad4f-a077-4ca5-8232-e4014a5fbe4a', 141),
(202, 1381798932542, NULL, 1398364049128, 20, 30, 'door r90', '2331c34d-bf51-4491-b8f0-12d174e43d81', 143),
(203, 1381798934252, NULL, 1398364049148, 0, 20, 'door r270', '75ceb257-787a-4e26-a90c-58fb2990fdf1', 142),
(204, 1381798940619, NULL, 1398364049161, 30, 40, 'door r90', '2f953bd8-371c-47f2-882c-d887901986eb', 145),
(205, 1381798942228, NULL, 1398364049174, 0, 30, 'door r270', '27e58ed0-7767-4f4c-a771-bc96b2b20493', 144),
(206, 1381798947324, NULL, 1398364049186, 10, 0, 'door r270', '9db0a340-32a6-4dd4-badf-82bc5894a350', 162),
(207, 1381798951228, NULL, 1398364049199, 20, 0, 'door', 'ad3af502-ccaa-4797-bde8-2267f43cbbba', 162),
(208, 1381798954155, NULL, 1398364049211, 10, 10, 'door r180', '54b4154a-65a5-476f-8c25-e8ce96376b35', 162),
(209, 1381798955964, NULL, 1398364049224, 20, 10, 'door r90', '818d84bf-e9da-460e-bb3b-cf7ae601d3af', 162),
(210, 1381798959906, NULL, 1398364049236, 40, 0, 'door', '1c257228-6713-486d-a62c-61b15ad76368', 156),
(211, 1381798962591, NULL, 1398364049249, 0, 0, 'door r270', '5a3fc540-e6b7-4811-a849-0df12c0286fe', 157),
(212, 1381799010921, NULL, 1398364049263, 0, 40, 'door r270', '1c29d745-1207-41c1-bd7e-6caa06302802', 168),
(213, 1381799013217, NULL, 1398364049280, 70, 40, 'door', 'dcd53337-5477-40ba-a951-04d39be0b98d', 168),
(214, 1381799019583, NULL, 1398364049293, 0, 30, 'door r270', '1a1da780-30e6-4051-936a-cd18d85976c8', 159),
(215, 1381799023364, NULL, 1398364049307, 20, 0, 'door', '5d2900df-a465-4f73-8ff1-18add4b379ed', 158),
(216, 1381799027683, NULL, 1398364049322, 0, 40, 'door r270', '6fb2b533-ddad-4c0d-ae8e-b597a72dab6b', 160),
(217, 1381799033128, NULL, 1398364049336, 0, 40, 'door r270', '1e219f32-140d-42e2-9c33-1ebe06cab379', 161),
(218, 1381799035503, NULL, 1398364049351, 0, 50, 'door r180', '8fa88d81-ebc2-4528-850b-3e79bb294e92', 161),
(219, 1381799037943, NULL, 1398364049366, 0, 50, 'door r180', 'f8a46614-8503-4a8e-bfdc-973e1f9f3768', 160),
(220, 1381799047708, NULL, 1398364049384, 10, 20, 'door r180', '5610c4bb-34dc-4210-af3f-0a33d5300c72', 166),
(221, 1381799051657, NULL, 1398364049401, 10, 20, 'door r90', 'e776ca8b-cdd5-44b9-a213-ba57e038a5bf', 167),
(222, 1381799068060, NULL, 1398364049416, 20, 20, 'door r90', '7616872d-ba47-4a5b-9d46-f1fcc4df1f5d', 148),
(223, 1381799072525, NULL, 1398364049429, 0, 20, 'door r180', 'f5720eef-ab68-4c93-94f4-cec181b915c9', 165),
(224, 1381799075979, NULL, 1398364049442, 20, 0, 'door', 'd8c4825b-f59d-4e01-9f66-4b8e19cc2e40', 152),
(225, 1381799079051, NULL, 1398364049456, 30, 0, 'door r270', 'a9e2c564-93ad-48d6-831c-d47d423bb96b', 149),
(226, 1381799086015, NULL, 1398364049472, 0, 0, 'door r270', 'c09aab99-7e57-4e66-83dc-c62578b9bb40', 147),
(227, 1381799090020, NULL, 1398364049484, 0, 30, 'door r180', '102d1ca5-e6d9-4b06-a504-99d95a838ae7', 146),
(228, 1381799096106, NULL, 1398364049497, 30, 0, 'door', 'd6488f3b-fea9-4f9e-a2ce-9242d821c757', 151),
(229, 1381799100415, NULL, 1398364049511, 0, 10, 'door r270', 'ec7223ae-90cb-4d4e-ac71-19dad209eb0f', 164),
(230, 1381799104141, NULL, 1398364049528, 10, 0, 'door', 'ffc15c33-587f-434e-a1bb-45f0dec8afed', 163),
(231, 1381799111428, NULL, 1398364049544, 50, 30, 'door r90', 'd8ff6a54-a0df-4ef0-912b-9341b5a85e1b', 150),
(232, 1381799114748, NULL, 1398364049557, 50, 10, 'door', '7ef1b4c0-1a1f-451a-a140-dfddfe929fc9', 153),
(233, 1381799120442, NULL, 1398364049575, 30, 0, 'door', 'd44493f7-af88-44ac-bba9-b6648bc8a91e', 153),
(234, 1381799123567, NULL, 1398364049588, 50, 30, 'door r90', 'd9d1a9c5-b3de-4c3c-83cf-1cc24c5f5733', 154),
(235, 1381799131814, NULL, 1398364049605, 50, 70, 'door r90', 'd905a63f-ebc9-43d1-898c-ac9339899c83', 155),
(236, 1381799134592, NULL, 1398364049617, 50, 10, 'door', '41de7eba-6418-4f7e-813b-3cb9651545b3', 155),
(237, 1381799140127, NULL, 1398364049634, 0, 50, 'door r180', '846c7db6-5fb9-4bc4-9597-00f76648f119', 168),
(238, 1381799145168, NULL, 1398364049647, 70, 50, 'door r90', 'd954f44e-42be-4e60-b99c-b661213acc65', 168),
(239, 1381800423227, NULL, 1398364049661, 50, 110, 'door r180', '8cf53d78-fc20-4212-b23e-4c72f2ce7151', 210),
(240, 1381800425251, NULL, 1398364049677, 60, 110, 'door r90', '1397fab2-cbe5-4570-bb14-fefc5f8ed37c', 210),
(241, 1381800430381, NULL, 1398364049690, 110, 100, 'door r90', 'bcbec0eb-e0c7-408e-8e7a-65b2692cee6b', 210),
(242, 1381800453026, NULL, 1398364049704, 10, 40, 'door r180', '9b76e91b-618d-4c77-993a-3e88f123d2c6', 216),
(243, 1381800455008, NULL, 1398364049717, 10, 40, 'door r180', 'df17b463-4dfc-45fa-b81f-fed916673c58', 217),
(244, 1381800458347, NULL, 1398364049731, 10, 40, 'door r180', 'f31b3ef7-f4ad-4ad0-b604-a4baf6868415', 218),
(245, 1381800460001, NULL, 1398364049744, 10, 40, 'door r180', 'dc4b44ea-07c3-44f4-9675-ab7373dd951f', 225),
(246, 1381800464050, NULL, 1398364049758, 10, 0, 'door r270', 'da97bc76-dd64-4970-9382-4bf17fe182c5', 219),
(247, 1381800466830, NULL, 1398364049774, 10, 0, 'door r270', 'c557a41a-6ec7-4926-ae5a-31ab5ab5ca38', 220),
(248, 1381800469881, NULL, 1398364049786, 10, 0, 'door r270', 'f76a1f12-1251-4b11-a908-5bcd5bac474f', 221),
(249, 1381800474367, NULL, 1398364049800, 0, 10, 'door r270', '53fb2671-85f2-4120-b149-e1699d0beb1a', 220),
(250, 1381800479947, NULL, 1398364049813, 0, 10, 'door r270', '017f8bac-e3ab-4afe-b56e-8f7a499e1beb', 221),
(251, 1381800487012, NULL, 1398364049826, 10, 0, 'door r270', '2d8e55b1-2224-4c0d-b9ef-0deb82e86de1', 222),
(252, 1381800491479, NULL, 1398364049839, 10, 0, 'door', 'f2866fa8-8372-47d2-945a-9b133295afc9', 223),
(253, 1381800493686, NULL, 1398364049853, 0, 0, 'door r270', '2ea1afa1-1151-4e26-9cd9-b168f5d0260b', 224),
(254, 1381800502369, NULL, 1398364049870, 30, 10, 'door', '5e5576af-129c-4806-9696-0152fa4bf900', 211),
(255, 1381800505012, NULL, 1398364049888, 0, 10, 'door r270', 'a894c122-5ccd-4460-a39f-fe948d63b67f', 212),
(256, 1381800513149, NULL, 1398364049902, 70, 10, 'door', '5b6a92df-956c-496c-88bb-0c533995a3b3', 208),
(257, 1381800515677, NULL, 1398364049917, 70, 20, 'door r90', 'c2556793-015f-49af-a928-f2493b4c78b7', 208),
(258, 1381800521213, NULL, 1398364049936, 200, 110, 'door r180', '6286e276-95e2-4df1-8264-383df4bacc21', 209),
(259, 1381800523418, NULL, 1398364049953, 210, 110, 'door r90', '74bbaaa8-15ec-464c-acb8-0ff6efc7bd7f', 209),
(260, 1381800529157, NULL, 1398364049966, 10, 40, 'door r180', '011e5f1e-653d-42b4-a824-4cf749b8e48f', 229),
(261, 1381800565943, NULL, 1398364049984, 220, 60, 'door', '1c5f199b-fc23-48d6-9555-766e82f1725f', 209),
(262, 1381800567339, NULL, 1398364050000, 220, 70, 'door r90', '77cbd02c-ffc7-4d62-84f6-0a5ea7d20c63', 209),
(263, 1381800594305, NULL, 1398364050014, 70, 20, 'door r90', '4b13d1ab-541d-49fa-8415-2acaa94ac4b5', 226),
(264, 1381800597938, NULL, 1398364050028, 60, 40, 'door r90', '815b232f-b14c-4387-ad55-b322b07a6e0d', 214),
(265, 1381800602259, NULL, 1398364050041, 50, 0, 'door', 'fc5acd6e-fa21-4fe6-9fa5-6a47c08de454', 214),
(266, 1381800605715, NULL, 1398364050055, 30, 0, 'door', 'a98b8a9e-4181-4384-9ba3-3ddfe1eda2f7', 215),
(267, 1381800609210, NULL, 1398364050069, 30, 0, 'door', '753a2659-c102-4fce-af31-338501648868', 227),
(268, 1381800614397, NULL, 1398364050086, 0, 10, 'door r270', 'ff121545-9c09-4834-b05b-a8d280bb547d', 228),
(269, 1381800620764, NULL, 1398364050099, 20, 0, 'door', '81641208-1567-4d6f-a197-6883cf1fbca8', 213),
(270, 1381801515095, NULL, 1398364050117, 70, 10, 'door', 'd7e9c28c-4fa8-457b-8769-77e010b34659', 245),
(271, 1381801517661, NULL, 1398364050131, 70, 80, 'door r90', 'a58fcba2-eb4b-48b1-8d81-73b3c82159fd', 245),
(272, 1381801522871, NULL, 1398364050153, 70, 40, 'door r90', '16ce3e8c-6738-4fa8-b1db-5bf43a0fc0a6', 244),
(273, 1381801527494, NULL, 1398364050171, 70, 40, 'door r90', 'd823ea22-a0df-4049-9c03-7386e83c4f3d', 243),
(274, 1381801531702, NULL, 1398364050184, 0, 80, 'door r270', 'c847cd17-dd13-413a-9223-40e9ccfae888', 230),
(275, 1381801537990, NULL, 1398364050207, 30, 100, 'door r180', '9eb8fb35-c60e-4e87-be3f-a8c2061455e7', 238),
(276, 1381801540127, NULL, 1398364050221, 40, 100, 'door r90', '9888ab64-28c4-4423-8a5d-ec915f6c7fa5', 238),
(277, 1381801545178, NULL, 1398364050239, 0, 50, 'door r180', 'be3b8597-3033-442b-bb49-23ad0db865c5', 238),
(278, 1381801549937, NULL, 1398364050256, 0, 10, 'door r270', '155dff59-4225-45a9-bca7-e7a2d6e197bb', 240),
(279, 1381801555135, NULL, 1398364050274, 10, 0, 'door', '976321f8-4c0f-4ef9-a2a3-5f06532ae2ac', 239),
(280, 1381801564226, NULL, 1398364050291, 0, 10, 'door r270', '0ac81476-d311-47dc-9b34-b82e6ba09601', 237),
(281, 1381801568399, NULL, 1398364050305, 40, 10, 'door', 'dd6f686c-b1d4-4b88-84ea-761d78426930', 237),
(282, 1381801571112, NULL, 1398364050320, 30, 0, 'door', '9215faf3-e1d6-4499-83d9-3c7c95c95586', 236),
(283, 1381801573641, NULL, 1398364050334, 30, 60, 'door r90', '004da4a8-4d8f-4e2b-a225-8b252f8ed4d9', 235),
(284, 1381801575812, NULL, 1398364050349, 0, 70, 'door r270', 'ff5e7d66-4cf5-4f6c-aa06-0bb80d35ff04', 234),
(285, 1381801579761, NULL, 1398364050366, 80, 60, 'door r90', 'd73de9bd-a0a8-47ce-a6b1-f65a830e70fa', 241),
(286, 1381801585590, NULL, 1398364050380, 40, 70, 'door r90', 'd43eb106-1488-4c4f-8881-a53be6b295cf', 248),
(287, 1381801591236, NULL, 1398364050394, 40, 10, 'door r90', '7292706f-af44-4a20-9e8d-0a409946f2a3', 247),
(288, 1381801596107, NULL, 1398364050410, 40, 10, 'door', 'f9de1bcf-c0b3-4709-a47a-0eb14276f62e', 246),
(289, 1381801601553, NULL, 1398364050426, 40, 10, 'door', 'ea5726e5-872e-4c4d-b681-38121b96751b', 249),
(290, 1381801602903, NULL, 1398364050444, 40, 10, 'door', '705b84af-09ce-4dee-bfa6-d987e4a389e0', 250),
(291, 1381801606513, NULL, 1398364050461, 40, 10, 'door', 'c70072af-19c9-4318-878b-1cd012c564f1', 251),
(292, 1381801610284, NULL, 1398364050476, 40, 10, 'door', '04142464-a736-4c9b-b726-2aafe2534eb5', 252),
(293, 1381801614085, NULL, 1398364050491, 40, 0, 'door', '04b578f8-e8d5-4394-901a-9639c004e1d4', 253),
(294, 1381801617404, NULL, 1398364050506, 20, 0, 'door', 'fda4c824-cc80-474d-839d-631d9fa6614c', 254),
(295, 1381801620149, NULL, 1398364050522, 10, 60, 'door r180', '57c59ad1-4a42-400b-b4ef-42c6f5c232a5', 231),
(296, 1381801622106, NULL, 1398364050536, 10, 60, 'door r180', 'd521a48b-429b-4961-b33e-c1406bcd11a4', 232),
(297, 1381801624110, NULL, 1398364050550, 10, 60, 'door r180', 'cce7ed12-d75f-4f4e-a3e0-394ceb007a74', 233),
(298, 1381801630015, NULL, 1398364050569, 60, 0, 'door r270', '9a63c51e-1965-44be-bbaa-0bb3f3e986c6', 242),
(299, 1381803108886, NULL, 1398364050583, 0, 90, 'door r180', '7da6bb27-bc8f-49d9-97e2-5a0f376d6840', 257),
(300, 1381803116132, NULL, 1398364050597, 70, 10, 'door', '51f49a4c-78d8-4269-9242-f3a7a4597597', 256);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_room_feature`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_room_feature` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_room_feature_k_uuid` (`k_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_room_has_feature`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_room_has_feature` (
  `c_amount` int(11) NOT NULL,
  `f_feature` bigint(20) NOT NULL,
  `f_room` bigint(20) NOT NULL,
  PRIMARY KEY (`f_feature`,`f_room`),
  KEY `FK_mvs_scuttle_room_has_feature_f_room` (`f_room`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_room_label`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_room_label` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `c_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `mvs_scuttle_room` bigint(20) NOT NULL,
  PRIMARY KEY (`k_id`),
  UNIQUE KEY `c_label` (`c_label`),
  KEY `INDEX_mvs_scuttle_room_label_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_room_label_mvs_scuttle_room` (`mvs_scuttle_room`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_sakai_uptime`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_sakai_uptime` (
  `TIME` datetime NOT NULL,
  `c_up` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_sakvv_room_to_mvs_scuttle_room`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_sakvv_room_to_mvs_scuttle_room` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_sakai_location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_sakvv_haus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_sakvv_id` bigint(20) DEFAULT NULL,
  `c_sakvv_raum` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `f_room` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_sakvv_room_to_mvs_scuttle_room_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_sakvv_room_to_mvs_scuttle_room_f_room` (`f_room`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_singleton_event`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_singleton_event` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `c_end` datetime NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `c_start_time` datetime NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `mvs_scuttle_academic_term` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_singleton_event_k_uuid` (`k_uuid`),
  KEY `FK_mvs_scuttle_singleton_event_mvs_scuttle_academic_term` (`mvs_scuttle_academic_term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_timeslot`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_timeslot` (
  `c_index` int(11) NOT NULL,
  `c_begin` smallint(6) NOT NULL,
  `c_end` smallint(6) NOT NULL,
  `c_is_visible` tinyint(1) NOT NULL DEFAULT '0',
  `c_num` int(11) NOT NULL,
  `f_day` int(11) NOT NULL,
  PRIMARY KEY (`c_index`),
  KEY `FK_mvs_scuttle_timeslot_f_day` (`f_day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `mvs_scuttle_timeslot`
--

INSERT INTO `mvs_scuttle_timeslot` (`c_index`, `c_begin`, `c_end`, `c_is_visible`, `c_num`, `f_day`) VALUES
(1, 0, 60, 0, 0, 1),
(2, 60, 120, 0, 1, 1),
(3, 120, 180, 0, 2, 1),
(4, 180, 240, 0, 3, 1),
(5, 240, 300, 0, 4, 1),
(6, 300, 360, 0, 5, 1),
(7, 360, 420, 0, 6, 1),
(8, 420, 480, 1, 7, 1),
(9, 480, 540, 1, 8, 1),
(10, 540, 600, 1, 9, 1),
(11, 600, 660, 1, 10, 1),
(12, 660, 720, 1, 11, 1),
(13, 720, 780, 1, 12, 1),
(14, 780, 840, 1, 13, 1),
(15, 840, 900, 1, 14, 1),
(16, 900, 960, 1, 15, 1),
(17, 960, 1020, 1, 16, 1),
(18, 1020, 1080, 1, 17, 1),
(19, 1080, 1140, 1, 18, 1),
(20, 1140, 1200, 0, 19, 1),
(21, 1200, 1260, 0, 20, 1),
(22, 1260, 1320, 0, 21, 1),
(23, 1320, 1380, 0, 22, 1),
(24, 1380, 1440, 0, 23, 1),
(25, 0, 60, 0, 0, 2),
(26, 60, 120, 0, 1, 2),
(27, 120, 180, 0, 2, 2),
(28, 180, 240, 0, 3, 2),
(29, 240, 300, 0, 4, 2),
(30, 300, 360, 0, 5, 2),
(31, 360, 420, 0, 6, 2),
(32, 420, 480, 1, 7, 2),
(33, 480, 540, 1, 8, 2),
(34, 540, 600, 1, 9, 2),
(35, 600, 660, 1, 10, 2),
(36, 660, 720, 1, 11, 2),
(37, 720, 780, 1, 12, 2),
(38, 780, 840, 1, 13, 2),
(39, 840, 900, 1, 14, 2),
(40, 900, 960, 1, 15, 2),
(41, 960, 1020, 1, 16, 2),
(42, 1020, 1080, 1, 17, 2),
(43, 1080, 1140, 1, 18, 2),
(44, 1140, 1200, 0, 19, 2),
(45, 1200, 1260, 0, 20, 2),
(46, 1260, 1320, 0, 21, 2),
(47, 1320, 1380, 0, 22, 2),
(48, 1380, 1440, 0, 23, 2),
(49, 0, 60, 0, 0, 3),
(50, 60, 120, 0, 1, 3),
(51, 120, 180, 0, 2, 3),
(52, 180, 240, 0, 3, 3),
(53, 240, 300, 0, 4, 3),
(54, 300, 360, 0, 5, 3),
(55, 360, 420, 0, 6, 3),
(56, 420, 480, 1, 7, 3),
(57, 480, 540, 1, 8, 3),
(58, 540, 600, 1, 9, 3),
(59, 600, 660, 1, 10, 3),
(60, 660, 720, 1, 11, 3),
(61, 720, 780, 1, 12, 3),
(62, 780, 840, 1, 13, 3),
(63, 840, 900, 1, 14, 3),
(64, 900, 960, 1, 15, 3),
(65, 960, 1020, 1, 16, 3),
(66, 1020, 1080, 1, 17, 3),
(67, 1080, 1140, 1, 18, 3),
(68, 1140, 1200, 0, 19, 3),
(69, 1200, 1260, 0, 20, 3),
(70, 1260, 1320, 0, 21, 3),
(71, 1320, 1380, 0, 22, 3),
(72, 1380, 1440, 0, 23, 3),
(73, 0, 60, 0, 0, 4),
(74, 60, 120, 0, 1, 4),
(75, 120, 180, 0, 2, 4),
(76, 180, 240, 0, 3, 4),
(77, 240, 300, 0, 4, 4),
(78, 300, 360, 0, 5, 4),
(79, 360, 420, 0, 6, 4),
(80, 420, 480, 1, 7, 4),
(81, 480, 540, 1, 8, 4),
(82, 540, 600, 1, 9, 4),
(83, 600, 660, 1, 10, 4),
(84, 660, 720, 1, 11, 4),
(85, 720, 780, 1, 12, 4),
(86, 780, 840, 1, 13, 4),
(87, 840, 900, 1, 14, 4),
(88, 900, 960, 1, 15, 4),
(89, 960, 1020, 1, 16, 4),
(90, 1020, 1080, 1, 17, 4),
(91, 1080, 1140, 1, 18, 4),
(92, 1140, 1200, 0, 19, 4),
(93, 1200, 1260, 0, 20, 4),
(94, 1260, 1320, 0, 21, 4),
(95, 1320, 1380, 0, 22, 4),
(96, 1380, 1440, 0, 23, 4),
(97, 0, 60, 0, 0, 5),
(98, 60, 120, 0, 1, 5),
(99, 120, 180, 0, 2, 5),
(100, 180, 240, 0, 3, 5),
(101, 240, 300, 0, 4, 5),
(102, 300, 360, 0, 5, 5),
(103, 360, 420, 0, 6, 5),
(104, 420, 480, 1, 7, 5),
(105, 480, 540, 1, 8, 5),
(106, 540, 600, 1, 9, 5),
(107, 600, 660, 1, 10, 5),
(108, 660, 720, 1, 11, 5),
(109, 720, 780, 1, 12, 5),
(110, 780, 840, 1, 13, 5),
(111, 840, 900, 1, 14, 5),
(112, 900, 960, 1, 15, 5),
(113, 960, 1020, 1, 16, 5),
(114, 1020, 1080, 1, 17, 5),
(115, 1080, 1140, 1, 18, 5),
(116, 1140, 1200, 0, 19, 5),
(117, 1200, 1260, 0, 20, 5),
(118, 1260, 1320, 0, 21, 5),
(119, 1320, 1380, 0, 22, 5),
(120, 1380, 1440, 0, 23, 5),
(121, 0, 60, 0, 0, 6),
(122, 60, 120, 0, 1, 6),
(123, 120, 180, 0, 2, 6),
(124, 180, 240, 0, 3, 6),
(125, 240, 300, 0, 4, 6),
(126, 300, 360, 0, 5, 6),
(127, 360, 420, 0, 6, 6),
(128, 420, 480, 1, 7, 6),
(129, 480, 540, 1, 8, 6),
(130, 540, 600, 1, 9, 6),
(131, 600, 660, 1, 10, 6),
(132, 660, 720, 1, 11, 6),
(133, 720, 780, 1, 12, 6),
(134, 780, 840, 1, 13, 6),
(135, 840, 900, 1, 14, 6),
(136, 900, 960, 1, 15, 6),
(137, 960, 1020, 1, 16, 6),
(138, 1020, 1080, 1, 17, 6),
(139, 1080, 1140, 1, 18, 6),
(140, 1140, 1200, 0, 19, 6),
(141, 1200, 1260, 0, 20, 6),
(142, 1260, 1320, 0, 21, 6),
(143, 1320, 1380, 0, 22, 6),
(144, 1380, 1440, 0, 23, 6),
(145, 0, 60, 0, 0, 7),
(146, 60, 120, 0, 1, 7),
(147, 120, 180, 0, 2, 7),
(148, 180, 240, 0, 3, 7),
(149, 240, 300, 0, 4, 7),
(150, 300, 360, 0, 5, 7),
(151, 360, 420, 0, 6, 7),
(152, 420, 480, 1, 7, 7),
(153, 480, 540, 1, 8, 7),
(154, 540, 600, 1, 9, 7),
(155, 600, 660, 1, 10, 7),
(156, 660, 720, 1, 11, 7),
(157, 720, 780, 1, 12, 7),
(158, 780, 840, 1, 13, 7),
(159, 840, 900, 1, 14, 7),
(160, 900, 960, 1, 15, 7),
(161, 960, 1020, 1, 16, 7),
(162, 1020, 1080, 1, 17, 7),
(163, 1080, 1140, 1, 18, 7),
(164, 1140, 1200, 0, 19, 7),
(165, 1200, 1260, 0, 20, 7),
(166, 1260, 1320, 0, 21, 7),
(167, 1320, 1380, 0, 22, 7),
(168, 1380, 1440, 0, 23, 7);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_timeslot_mvs_scuttle_event_takes_place`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_timeslot_mvs_scuttle_event_takes_place` (
  `Timeslot_c_index` int(11) NOT NULL,
  `events_k_id` bigint(20) NOT NULL,
  PRIMARY KEY (`Timeslot_c_index`,`events_k_id`),
  KEY `scuttletimeslotscuttleevent_takes_placeevents_k_id` (`events_k_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_user`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_user` (
  `k_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `k_creation_time` bigint(20) NOT NULL,
  `k_last_modification_time` bigint(20) NOT NULL,
  `c_role` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `c_user_login_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `k_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `c_pw_hash` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `c_pw_salt` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`k_id`),
  KEY `INDEX_mvs_scuttle_user_k_uuid` (`k_uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `mvs_scuttle_user`
--

INSERT INTO `mvs_scuttle_user` (`k_id`, `k_creation_time`, `k_last_modification_time`, `c_role`, `c_user_login_id`, `k_uuid`, `c_pw_hash`, `c_pw_salt`) VALUES
(1, 1398364050768, 1398364050768, 'admin', 'root', '358e07f1-cd1c-42e9-a092-ed034a0612ba', 'a0c214d6df6d5aae47348bdb38719221b84daaa53875c730ef31e2f99dc4a219', '79!4@$?g1/Md>I_+-><UT6,2NG~''Z*zF');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mvs_scuttle_user_privileges`
--

CREATE TABLE IF NOT EXISTS `mvs_scuttle_user_privileges` (
  `f_user` bigint(20) DEFAULT NULL,
  `c_privilege` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `FK_mvs_scuttle_user_privileges_f_user` (`f_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `modulverwaltung_institut`
--
ALTER TABLE `modulverwaltung_institut`
  ADD CONSTRAINT `fb` FOREIGN KEY (`fb_id`) REFERENCES `modulverwaltung_fachbereich` (`fb_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_klausur`
--
ALTER TABLE `modulverwaltung_klausur`
  ADD CONSTRAINT `KlausrTyp` FOREIGN KEY (`kt_id`) REFERENCES `modulverwaltung_klausur_typ` (`kt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `KlausurModul` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `KlausurSemester` FOREIGN KEY (`s_id`) REFERENCES `modulverwaltung_semester` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_klausur_ibfk_2` FOREIGN KEY (`r_id`) REFERENCES `modulverwaltung_raum` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_lehrender`
--
ALTER TABLE `modulverwaltung_lehrender`
  ADD CONSTRAINT `LType` FOREIGN KEY (`lt_id`) REFERENCES `modulverwaltung_lehrender_typ` (`lt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_lehrveranstaltung`
--
ALTER TABLE `modulverwaltung_lehrveranstaltung`
  ADD CONSTRAINT `LvMod` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `LvType` FOREIGN KEY (`lvt_id`) REFERENCES `modulverwaltung_lv_typ` (`lvt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul`
--
ALTER TABLE `modulverwaltung_modul`
  ADD CONSTRAINT `ModKategorie` FOREIGN KEY (`mk_id`) REFERENCES `modulverwaltung_modul_kategorie` (`mk_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `ModSprache` FOREIGN KEY (`sp_id`) REFERENCES `modulverwaltung_sprache` (`sp_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul_counter`
--
ALTER TABLE `modulverwaltung_modul_counter`
  ADD CONSTRAINT `modulverwaltung_modul_counter_ibfk_1` FOREIGN KEY (`i_id`) REFERENCES `modulverwaltung_institut` (`i_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul_huelsen`
--
ALTER TABLE `modulverwaltung_modul_huelsen`
  ADD CONSTRAINT `modulverwaltung_modul_huelsen_ibfk_2` FOREIGN KEY (`h_id`) REFERENCES `modulverwaltung_huelsen` (`h_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_modul_huelsen_ibfk_3` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul_kategorie`
--
ALTER TABLE `modulverwaltung_modul_kategorie`
  ADD CONSTRAINT `modulverwaltung_modul_kategorie_ibfk_1` FOREIGN KEY (`i_id`) REFERENCES `modulverwaltung_institut` (`i_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul_lvs`
--
ALTER TABLE `modulverwaltung_modul_lvs`
  ADD CONSTRAINT `modulverwaltung_modul_lvs_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_modul_lvs_ibfk_2` FOREIGN KEY (`lvt_id`) REFERENCES `modulverwaltung_lv_typ` (`lvt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_modul_verantwortliche`
--
ALTER TABLE `modulverwaltung_modul_verantwortliche`
  ADD CONSTRAINT `LehrenderVerantwortlich` FOREIGN KEY (`l_id`) REFERENCES `modulverwaltung_lehrender` (`l_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ModVerantwortlich` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_planung`
--
ALTER TABLE `modulverwaltung_planung`
  ADD CONSTRAINT `PlanungLv` FOREIGN KEY (`lv_id`) REFERENCES `modulverwaltung_lehrveranstaltung` (`lv_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `PlanungRaum` FOREIGN KEY (`r_id`) REFERENCES `modulverwaltung_raum` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `PlanungSemester` FOREIGN KEY (`s_id`) REFERENCES `modulverwaltung_semester` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `PlanungTermin` FOREIGN KEY (`t_id`) REFERENCES `modulverwaltung_termin` (`t_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_raum`
--
ALTER TABLE `modulverwaltung_raum`
  ADD CONSTRAINT `RaumGebaeude` FOREIGN KEY (`g_id`) REFERENCES `modulverwaltung_gebaeude` (`g_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_sek_sto`
--
ALTER TABLE `modulverwaltung_sek_sto`
  ADD CONSTRAINT `modulverwaltung_sek_sto_ibfk_1` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_sek_sto_ibfk_2` FOREIGN KEY (`sto_id`) REFERENCES `modulverwaltung_studienordnung` (`sto_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_semester_lecturer`
--
ALTER TABLE `modulverwaltung_semester_lecturer`
  ADD CONSTRAINT `modulverwaltung_semester_lecturer_ibfk_1` FOREIGN KEY (`l_id`) REFERENCES `modulverwaltung_lehrender` (`l_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_semester_lecturer_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `modulverwaltung_planung` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_sto_module`
--
ALTER TABLE `modulverwaltung_sto_module`
  ADD CONSTRAINT `ModulSto` FOREIGN KEY (`m_id`) REFERENCES `modulverwaltung_modul` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `StoModul` FOREIGN KEY (`sto_id`) REFERENCES `modulverwaltung_studienordnung` (`sto_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_studienordnung`
--
ALTER TABLE `modulverwaltung_studienordnung`
  ADD CONSTRAINT `StoInst` FOREIGN KEY (`i_id`) REFERENCES `modulverwaltung_institut` (`i_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `StoSta` FOREIGN KEY (`sta_id`) REFERENCES `modulverwaltung_studienart` (`sta_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_uebung`
--
ALTER TABLE `modulverwaltung_uebung`
  ADD CONSTRAINT `modulverwaltung_uebung_ibfk_1` FOREIGN KEY (`lv_id`) REFERENCES `modulverwaltung_lehrveranstaltung` (`lv_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_uebung_planung`
--
ALTER TABLE `modulverwaltung_uebung_planung`
  ADD CONSTRAINT `modulverwaltung_uebung_planung_ibfk_6` FOREIGN KEY (`ub_id`) REFERENCES `modulverwaltung_uebung` (`ub_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_uebung_planung_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `modulverwaltung_semester` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_uebung_planung_ibfk_3` FOREIGN KEY (`r_id`) REFERENCES `modulverwaltung_raum` (`r_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_uebung_planung_ibfk_4` FOREIGN KEY (`t_id`) REFERENCES `modulverwaltung_termin` (`t_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_uebung_planung_ibfk_5` FOREIGN KEY (`l_id`) REFERENCES `modulverwaltung_lehrender` (`l_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints der Tabelle `modulverwaltung_user_roles`
--
ALTER TABLE `modulverwaltung_user_roles`
  ADD CONSTRAINT `modulverwaltung_user_roles_ibfk_1` FOREIGN KEY (`uu_id`) REFERENCES `modulverwaltung_users` (`uu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulverwaltung_user_roles_ibfk_2` FOREIGN KEY (`ro_id`) REFERENCES `modulverwaltung_roles` (`ro_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `mvs_scuttle_building_floor`
--
ALTER TABLE `mvs_scuttle_building_floor`
  ADD CONSTRAINT `FK_mvs_scuttle_building_floor_f_building` FOREIGN KEY (`f_building`) REFERENCES `mvs_scuttle_building` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_building_floor_any_feature`
--
ALTER TABLE `mvs_scuttle_building_floor_any_feature`
  ADD CONSTRAINT `mvs_scuttle_building_floor_any_featuref_building_floor` FOREIGN KEY (`f_building_floor`) REFERENCES `mvs_scuttle_building_floor` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_event`
--
ALTER TABLE `mvs_scuttle_event`
  ADD CONSTRAINT `FK_mvs_scuttle_event_f_academic_term` FOREIGN KEY (`f_academic_term`) REFERENCES `mvs_scuttle_academic_term` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_event_takes_place`
--
ALTER TABLE `mvs_scuttle_event_takes_place`
  ADD CONSTRAINT `FK_mvs_scuttle_event_takes_place_f_event` FOREIGN KEY (`f_event`) REFERENCES `mvs_scuttle_event` (`k_id`),
  ADD CONSTRAINT `FK_mvs_scuttle_event_takes_place_f_room` FOREIGN KEY (`f_room`) REFERENCES `mvs_scuttle_room` (`k_id`),
  ADD CONSTRAINT `FK_mvs_scuttle_event_takes_place_f_timeslot` FOREIGN KEY (`f_timeslot`) REFERENCES `mvs_scuttle_timeslot` (`c_index`);

--
-- Constraints der Tabelle `mvs_scuttle_room`
--
ALTER TABLE `mvs_scuttle_room`
  ADD CONSTRAINT `FK_mvs_scuttle_room_f_building_floor` FOREIGN KEY (`f_building_floor`) REFERENCES `mvs_scuttle_building_floor` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_room_any_feature`
--
ALTER TABLE `mvs_scuttle_room_any_feature`
  ADD CONSTRAINT `FK_mvs_scuttle_room_any_feature_f_room` FOREIGN KEY (`f_room`) REFERENCES `mvs_scuttle_room` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_room_has_feature`
--
ALTER TABLE `mvs_scuttle_room_has_feature`
  ADD CONSTRAINT `FK_mvs_scuttle_room_has_feature_f_feature` FOREIGN KEY (`f_feature`) REFERENCES `mvs_scuttle_room_feature` (`k_id`),
  ADD CONSTRAINT `FK_mvs_scuttle_room_has_feature_f_room` FOREIGN KEY (`f_room`) REFERENCES `mvs_scuttle_room` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_room_label`
--
ALTER TABLE `mvs_scuttle_room_label`
  ADD CONSTRAINT `FK_mvs_scuttle_room_label_mvs_scuttle_room` FOREIGN KEY (`mvs_scuttle_room`) REFERENCES `mvs_scuttle_room` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_sakvv_room_to_mvs_scuttle_room`
--
ALTER TABLE `mvs_scuttle_sakvv_room_to_mvs_scuttle_room`
  ADD CONSTRAINT `FK_mvs_scuttle_sakvv_room_to_mvs_scuttle_room_f_room` FOREIGN KEY (`f_room`) REFERENCES `mvs_scuttle_room` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_singleton_event`
--
ALTER TABLE `mvs_scuttle_singleton_event`
  ADD CONSTRAINT `FK_mvs_scuttle_singleton_event_mvs_scuttle_academic_term` FOREIGN KEY (`mvs_scuttle_academic_term`) REFERENCES `mvs_scuttle_academic_term` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_timeslot`
--
ALTER TABLE `mvs_scuttle_timeslot`
  ADD CONSTRAINT `FK_mvs_scuttle_timeslot_f_day` FOREIGN KEY (`f_day`) REFERENCES `mvs_scuttle_day` (`c_index`);

--
-- Constraints der Tabelle `mvs_scuttle_timeslot_mvs_scuttle_event_takes_place`
--
ALTER TABLE `mvs_scuttle_timeslot_mvs_scuttle_event_takes_place`
  ADD CONSTRAINT `scuttletimeslotscuttleeventtakesplaceTmeslotcindex` FOREIGN KEY (`Timeslot_c_index`) REFERENCES `mvs_scuttle_timeslot` (`c_index`),
  ADD CONSTRAINT `scuttletimeslotscuttleevent_takes_placeevents_k_id` FOREIGN KEY (`events_k_id`) REFERENCES `mvs_scuttle_event_takes_place` (`k_id`);

--
-- Constraints der Tabelle `mvs_scuttle_user_privileges`
--
ALTER TABLE `mvs_scuttle_user_privileges`
  ADD CONSTRAINT `FK_mvs_scuttle_user_privileges_f_user` FOREIGN KEY (`f_user`) REFERENCES `mvs_scuttle_user` (`k_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
