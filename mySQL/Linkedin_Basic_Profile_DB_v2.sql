-- MySQL Script generated by MySQL Workbench
-- Tue Oct 16 14:56:08 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema linkedin_bp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema linkedin_bp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `linkedin_bp` DEFAULT CHARACTER SET utf8 ;
USE `linkedin_bp` ;

-- -----------------------------------------------------
-- Table `linkedin_bp`.`Basic_Profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkedin_bp`.`Basic_Profile` (
  `local id` INT NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(12) NOT NULL,
  `first-name` TEXT(45) NULL,
  `last-name` TEXT(45) NULL,
  `maiden-name` TEXT(45) NULL,
  `formatted-name` TEXT(45) NULL,
  `headline` TEXT(100) NULL,
  `current-share` INT NULL,
  `num-connections-capped` INT NULL,
  `specialties` TEXT(45) NULL,
  `vanityName` TEXT(45) NULL,
  `api-standar-profile-request` MEDIUMTEXT NULL,
  `public-profile-url` MEDIUMTEXT NULL,
  `lastModified` INT NULL,
  `summary` LONGTEXT NULL,
  PRIMARY KEY (`local id`, `id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `linkedin_bp`.`Location_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkedin_bp`.`Location_Table` (
  `id` VARCHAR(12) NOT NULL,
  `location(name)` TEXT(45) NULL,
  `location(country_code)` TEXT(20) NULL,
  `Basic_Profile_local id` INT NOT NULL,
  `Basic_Profile_id` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Location_Table_Basic_Profile_idx` (`Basic_Profile_local id` ASC, `Basic_Profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Table_Basic_Profile`
    FOREIGN KEY (`Basic_Profile_local id` , `Basic_Profile_id`)
    REFERENCES `linkedin_bp`.`Basic_Profile` (`local id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `linkedin_bp`.`Position_Fields`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkedin_bp`.`Position_Fields` (
  `id` VARCHAR(12) NOT NULL,
  `title` TEXT(45) NULL,
  `summary` LONGTEXT NULL,
  `start-date` DATE NULL,
  `end-date` DATE NULL,
  `is-current` TINYINT NULL,
  `company` TEXT(45) NOT NULL,
  `Basic_Profile_local id` INT NOT NULL,
  `Basic_Profile_id` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Position_Fields_Basic_Profile1_idx` (`Basic_Profile_local id` ASC, `Basic_Profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_Position_Fields_Basic_Profile1`
    FOREIGN KEY (`Basic_Profile_local id` , `Basic_Profile_id`)
    REFERENCES `linkedin_bp`.`Basic_Profile` (`local id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `linkedin_bp`.`Company_Fields`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkedin_bp`.`Company_Fields` (
  `id(company)` VARCHAR(12) NOT NULL,
  `name` TEXT(45) NULL,
  `type` TEXT(10) NULL,
  `industry` TEXT(45) NULL,
  `ticker` TEXT(10) NULL,
  `Position_Fields_id` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id(company)`),
  INDEX `fk_Company_Fields_Position_Fields1_idx` (`Position_Fields_id` ASC) VISIBLE,
  CONSTRAINT `fk_Company_Fields_Position_Fields1`
    FOREIGN KEY (`Position_Fields_id`)
    REFERENCES `linkedin_bp`.`Position_Fields` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `linkedin_bp`.`industry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `linkedin_bp`.`industry` (
  `id` VARCHAR(12) NOT NULL,
  `code` INT(4) NULL,
  `groups` TEXT(45) NULL,
  `description` TEXT(80) NULL,
  `Basic_Profile_local id` INT NOT NULL,
  `Basic_Profile_id` VARCHAR(12) NOT NULL,
  `Company_Fields_id(company)` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_industry_Basic_Profile1_idx` (`Basic_Profile_local id` ASC, `Basic_Profile_id` ASC) VISIBLE,
  INDEX `fk_industry_Company_Fields1_idx` (`Company_Fields_id(company)` ASC) VISIBLE,
  CONSTRAINT `fk_industry_Basic_Profile1`
    FOREIGN KEY (`Basic_Profile_local id` , `Basic_Profile_id`)
    REFERENCES `linkedin_bp`.`Basic_Profile` (`local id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_industry_Company_Fields1`
    FOREIGN KEY (`Company_Fields_id(company)`)
    REFERENCES `linkedin_bp`.`Company_Fields` (`id(company)`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
