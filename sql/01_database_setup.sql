/* ============================================================
   Formula 1 Driver Talent Evaluation Framework
   File: 01_database_setup.sql

   Purpose:
   Creates the database schema including all tables,
   primary keys and foreign key relationships.

   Author: Adarsh Sharma
============================================================ */

/*Creating Database*/

CREATE DATABASE f1;
USE f1;

/*Creating Tables*/

-- drivers table
CREATE TABLE `drivers` (
  `driverId` int NOT NULL,
  `driverRef` varchar(50) DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `forename` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`driverId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- constructors table
CREATE TABLE `constructors` (
  `constructorId` int NOT NULL,
  `constructorRef` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`constructorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- qualifying table
CREATE TABLE `qualifying` (
  `qualifyId` int NOT NULL,
  `raceId` int DEFAULT NULL,
  `driverId` int DEFAULT NULL,
  `constructorId` int DEFAULT NULL,
  `number` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `q1` varchar(20) DEFAULT NULL,
  `q2` varchar(20) DEFAULT NULL,
  `q3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`qualifyId`),
  KEY `fk_qualifying_constructor` (`constructorId`),
  KEY `idx_qualifying_driver` (`driverId`),
  KEY `idx_qualifying_race` (`raceId`),
  CONSTRAINT `fk_qualifying_constructor` FOREIGN KEY (`constructorId`) REFERENCES `constructors` (`constructorId`),
  CONSTRAINT `fk_qualifying_driver` FOREIGN KEY (`driverId`) REFERENCES `drivers` (`driverId`),
  CONSTRAINT `fk_qualifying_race` FOREIGN KEY (`raceId`) REFERENCES `races` (`raceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- results table
CREATE TABLE `results` (
  `resultId` int NOT NULL,
  `raceId` int DEFAULT NULL,
  `driverId` int DEFAULT NULL,
  `constructorId` int DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `grid` int DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `positionText` varchar(20) DEFAULT NULL,
  `positionOrder` int DEFAULT NULL,
  `points` decimal(5,2) DEFAULT NULL,
  `laps` int DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `milliseconds` varchar(20) DEFAULT NULL,
  `fastestLap` varchar(10) DEFAULT NULL,
  `ranking` varchar(10) DEFAULT NULL,
  `fastestLapTime` varchar(20) DEFAULT NULL,
  `fastestLapSpeed` varchar(20) DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  PRIMARY KEY (`resultId`),
  KEY `fk_results_status` (`statusId`),
  KEY `idx_results_driver` (`driverId`),
  KEY `idx_results_race` (`raceId`),
  KEY `idx_results_constructor` (`constructorId`),
  CONSTRAINT `fk_results_constructor` FOREIGN KEY (`constructorId`) REFERENCES `constructors` (`constructorId`),
  CONSTRAINT `fk_results_driver` FOREIGN KEY (`driverId`) REFERENCES `drivers` (`driverId`),
  CONSTRAINT `fk_results_race` FOREIGN KEY (`raceId`) REFERENCES `races` (`raceId`),
  CONSTRAINT `fk_results_status` FOREIGN KEY (`statusId`) REFERENCES `status` (`statusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- races table
CREATE TABLE `races` (
  `raceId` int NOT NULL,
  `year` int DEFAULT NULL,
  `round` int DEFAULT NULL,
  `circuitId` int DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `fp1_date` varchar(20) DEFAULT NULL,
  `fp1_time` varchar(20) DEFAULT NULL,
  `fp2_date` varchar(20) DEFAULT NULL,
  `fp2_time` varchar(20) DEFAULT NULL,
  `fp3_date` varchar(20) DEFAULT NULL,
  `fp3_time` varchar(20) DEFAULT NULL,
  `quali_date` varchar(20) DEFAULT NULL,
  `quali_time` varchar(20) DEFAULT NULL,
  `sprint_date` varchar(20) DEFAULT NULL,
  `sprint_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`raceId`),
  KEY `fk_races_circuit` (`circuitId`),
  KEY `idx_races_year` (`year`),
  CONSTRAINT `fk_races_circuit` FOREIGN KEY (`circuitId`) REFERENCES `circuits` (`circuitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- status table
CREATE TABLE `status` (
  `statusId` int NOT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`statusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
