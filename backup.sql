-- MariaDB dump 10.19  Distrib 10.5.22-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_stephluc
-- ------------------------------------------------------
-- Server version	10.6.16-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Consoles`
--

DROP TABLE IF EXISTS `Consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Consoles` (
  `consoleID` int(11) NOT NULL AUTO_INCREMENT,
  `consoleType` varchar(255) NOT NULL,
  PRIMARY KEY (`consoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consoles`
--

LOCK TABLES `Consoles` WRITE;
/*!40000 ALTER TABLE `Consoles` DISABLE KEYS */;
INSERT INTO `Consoles` VALUES (1,'PS5'),(2,'XBOX'),(3,'PC'),(4,'Nintendo Switch'),(5,'Wii');
/*!40000 ALTER TABLE `Consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerAccounts`
--

DROP TABLE IF EXISTS `CustomerAccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerAccounts` (
  `customerEmail` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `customerDOB` date NOT NULL,
  PRIMARY KEY (`customerEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerAccounts`
--

LOCK TABLES `CustomerAccounts` WRITE;
/*!40000 ALTER TABLE `CustomerAccounts` DISABLE KEYS */;
INSERT INTO `CustomerAccounts` VALUES ('','','','0000-00-00'),('cloud99@aol.com','Darcy','Wiggins','1985-12-05'),('dmenace@aol.com','Katy','Combs','1996-03-28'),('evan@usa.com','Evan','Cumberbatch','2000-02-29'),('jonbovi@aol.com','Jon','Bovi','1989-01-01'),('poohwin@aol.com','Nettie','Shannon','2000-02-28'),('rssbob@aol.com','Shaun','Mitchell','1976-04-04');
/*!40000 ALTER TABLE `CustomerAccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerSales`
--

DROP TABLE IF EXISTS `CustomerSales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerSales` (
  `saleID` int(11) NOT NULL AUTO_INCREMENT,
  `systemID` int(11) NOT NULL,
  `customerEmail` varchar(255) NOT NULL,
  `timeIn` datetime NOT NULL,
  `timeOut` datetime DEFAULT NULL,
  PRIMARY KEY (`saleID`),
  KEY `systemID` (`systemID`),
  KEY `customerEmail` (`customerEmail`),
  CONSTRAINT `CustomerSales_ibfk_1` FOREIGN KEY (`systemID`) REFERENCES `GameSystems` (`systemID`) ON DELETE CASCADE,
  CONSTRAINT `CustomerSales_ibfk_2` FOREIGN KEY (`customerEmail`) REFERENCES `CustomerAccounts` (`customerEmail`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerSales`
--

LOCK TABLES `CustomerSales` WRITE;
/*!40000 ALTER TABLE `CustomerSales` DISABLE KEYS */;
INSERT INTO `CustomerSales` VALUES (1,1,'jonbovi@aol.com','2024-02-08 11:00:00',NULL),(2,2,'cloud99@aol.com','2024-02-08 15:00:00','2024-02-08 19:00:00'),(3,1,'cloud99@aol.com','2024-02-07 12:00:00','2024-02-07 13:00:00');
/*!40000 ALTER TABLE `CustomerSales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL AUTO_INCREMENT,
  `statusIn` tinyint(1) NOT NULL DEFAULT 0,
  `position` varchar(255) NOT NULL,
  `hourlyWage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,1,'Manager',25.50),(2,1,'Lounge Worker',20.00),(3,0,'Lounge Worker',20.00);
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GameSystems`
--

DROP TABLE IF EXISTS `GameSystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GameSystems` (
  `systemID` int(11) NOT NULL AUTO_INCREMENT,
  `loungeID` int(11) NOT NULL,
  `inUse` tinyint(1) NOT NULL DEFAULT 0,
  `systemType` int(11) NOT NULL,
  PRIMARY KEY (`systemID`),
  KEY `loungeID` (`loungeID`),
  KEY `systemType` (`systemType`),
  CONSTRAINT `GameSystems_ibfk_1` FOREIGN KEY (`loungeID`) REFERENCES `Lounges` (`loungeID`) ON DELETE CASCADE,
  CONSTRAINT `GameSystems_ibfk_2` FOREIGN KEY (`systemType`) REFERENCES `Consoles` (`consoleID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GameSystems`
--

LOCK TABLES `GameSystems` WRITE;
/*!40000 ALTER TABLE `GameSystems` DISABLE KEYS */;
INSERT INTO `GameSystems` VALUES (1,1,1,1),(2,2,1,2),(3,1,0,1),(4,2,0,2),(5,3,0,3);
/*!40000 ALTER TABLE `GameSystems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lounges`
--

DROP TABLE IF EXISTS `Lounges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lounges` (
  `loungeID` int(11) NOT NULL AUTO_INCREMENT,
  `loungeLimit` int(11) NOT NULL,
  `activeConsoles` int(11) NOT NULL,
  PRIMARY KEY (`loungeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lounges`
--

LOCK TABLES `Lounges` WRITE;
/*!40000 ALTER TABLE `Lounges` DISABLE KEYS */;
INSERT INTO `Lounges` VALUES (1,5,2),(2,10,2),(3,8,1),(4,12,0);
/*!40000 ALTER TABLE `Lounges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoungesEmployees`
--

DROP TABLE IF EXISTS `LoungesEmployees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoungesEmployees` (
  `rentalInvoiceID` int(11) NOT NULL AUTO_INCREMENT,
  `loungeID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `dateinfo` date NOT NULL,
  PRIMARY KEY (`rentalInvoiceID`),
  KEY `loungeID` (`loungeID`),
  KEY `employeeID` (`employeeID`),
  CONSTRAINT `LoungesEmployees_ibfk_1` FOREIGN KEY (`loungeID`) REFERENCES `Lounges` (`loungeID`) ON DELETE CASCADE,
  CONSTRAINT `LoungesEmployees_ibfk_2` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoungesEmployees`
--

LOCK TABLES `LoungesEmployees` WRITE;
/*!40000 ALTER TABLE `LoungesEmployees` DISABLE KEYS */;
INSERT INTO `LoungesEmployees` VALUES (1,1,1,'2024-02-08'),(2,1,1,'2024-02-08'),(3,3,2,'2024-02-08'),(4,4,3,'2024-02-07');
/*!40000 ALTER TABLE `LoungesEmployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Action'),(2,'Comedy'),(3,'Romance'),(4,'Horror'),(5,'Sci-Fi');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(999) DEFAULT NULL,
  `favoriteGenre` int(11) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `uid` (`uid`),
  KEY `favoriteGenre` (`favoriteGenre`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`),
  CONSTRAINT `profiles_ibfk_2` FOREIGN KEY (`favoriteGenre`) REFERENCES `genres` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'email@email.com','test','description',1),(4,'email@email.edu',NULL,NULL,NULL),(2,'email@me.com','','',2),(3,'redGREENblue@gmail.com',NULL,NULL,NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_shows`
--

DROP TABLE IF EXISTS `profiles_shows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles_shows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `sid` (`sid`),
  CONSTRAINT `profiles_shows_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `profiles` (`uid`),
  CONSTRAINT `profiles_shows_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `shows` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles_shows`
--

LOCK TABLES `profiles_shows` WRITE;
/*!40000 ALTER TABLE `profiles_shows` DISABLE KEYS */;
INSERT INTO `profiles_shows` VALUES (1,1,2),(2,1,1),(3,2,2),(6,1,3),(7,1,4),(9,1,5),(10,1,6),(11,1,7),(12,2,8),(13,3,9),(14,3,10),(15,3,11),(16,3,12),(18,1,13),(19,3,14);
/*!40000 ALTER TABLE `profiles_shows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shows`
--

DROP TABLE IF EXISTS `shows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shows` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `gid` int(11) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `gid` (`gid`),
  CONSTRAINT `shows_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `genres` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shows`
--

LOCK TABLES `shows` WRITE;
/*!40000 ALTER TABLE `shows` DISABLE KEYS */;
INSERT INTO `shows` VALUES (1,'Avengers: Endgame',1),(2,'10 Things I Hate About You',3),(3,'The Shining',4),(4,'Barbie',2),(5,'500 Days of Summer',3),(6,'How to Lose a Guy in Ten Days',3),(7,'50 First Dates',3),(8,'Skinamarinc',4),(9,'ABCD',3),(10,'3D',1),(11,'ASDASD',1),(12,'QWEASDA',1),(13,'Test Title',4),(14,'123',1);
/*!40000 ALTER TABLE `shows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'email@email.com','password'),(2,'email@me.com','password'),(3,'redGREENblue@gmail.com','123'),(4,'email@email.edu','password');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-04 14:59:10
