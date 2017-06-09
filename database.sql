-- MySQL Script generated by MySQL Workbench
-- Fri 09 Jun 2017 03:48:51 AM MDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema captcheck
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema captcheck
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `captcheck` DEFAULT CHARACTER SET utf8 ;
USE `captcheck` ;

-- -----------------------------------------------------
-- Table `captcheck`.`answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `captcheck`.`answers` (
  `aid` INT NOT NULL AUTO_INCREMENT,
  `aname` VARCHAR(45) NOT NULL,
  `aimg` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`aid`),
  UNIQUE INDEX `aid_UNIQUE` (`aid` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `captcheck`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `captcheck`.`sessions` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `skey` VARCHAR(60) NOT NULL,
  `aid` INT NOT NULL,
  `expired` TINYINT(1) NOT NULL DEFAULT 0,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `sid_UNIQUE` (`sid` ASC),
  INDEX `fk_sessions_answers1_idx` (`aid` ASC),
  CONSTRAINT `fk_sessions_answers1`
    FOREIGN KEY (`aid`)
    REFERENCES `captcheck`.`answers` (`aid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `captcheck`.`scrambled_answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `captcheck`.`scrambled_answers` (
  `sid` INT NOT NULL,
  `aid` INT NOT NULL,
  `acode` VARCHAR(20) NOT NULL,
  INDEX `fk_sessions_has_answers_answers1_idx` (`aid` ASC),
  INDEX `fk_sessions_has_answers_sessions1_idx` (`sid` ASC),
  CONSTRAINT `fk_sessions_has_answers_sessions1`
    FOREIGN KEY (`sid`)
    REFERENCES `captcheck`.`sessions` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sessions_has_answers_answers1`
    FOREIGN KEY (`aid`)
    REFERENCES `captcheck`.`answers` (`aid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `captcheck`.`answers`
-- -----------------------------------------------------
START TRANSACTION;
USE `captcheck`;
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (1, 'heart', 'heart');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (2, 'envelope', 'envelope');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (3, 'building', 'building');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (4, 'camera', 'camera');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (5, 'cloud', 'cloud');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (6, 'circle', 'circle');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (7, 'girl', 'female');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (8, 'boy', 'male');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (9, 'paper', 'file-o');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (10, 'smartphone', 'mobile');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (11, 'moon', 'moon-o');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (12, 'pencil', 'pencil');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (13, 'paint brush', 'paint-brush');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (14, 'airplane', 'plane');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (15, 'printer', 'print');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (16, 'puzzle piece', 'puzzle-piece');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (17, 'picture', 'picture-o');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (18, 'sun', 'sun-o');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (19, 'star', 'star');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (20, 'square', 'square');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (21, 'tree', 'tree');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (22, 'umbrella', 'umbrella');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (23, 'snowflake', 'snowflake-o');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (24, 'basket', 'shopping-basket');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (25, 'globe', 'globe');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (26, 'flag', 'flag');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (27, 'cube', 'cube');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (28, 'lightning', 'bolt');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (29, 'truck', 'truck');
INSERT INTO `captcheck`.`answers` (`aid`, `aname`, `aimg`) VALUES (30, 'gear', 'cog');

COMMIT;