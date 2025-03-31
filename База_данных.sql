-- MySQL Script generated by MySQL Workbench
-- Дата: [укажите дату]
-- Model: УправлениеАвтопарком    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema УправлениеАвтопарком
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `УправлениеАвтопарком` DEFAULT CHARACTER SET utf8 ;
USE `УправлениеАвтопарком` ;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Диспетчеры`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Диспетчеры` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Диспетчеры` (
  `idДиспетчера` INT NOT NULL AUTO_INCREMENT,
  `Имя` VARCHAR(50) NOT NULL,
  `Фамилия` VARCHAR(50) NOT NULL,
  `Телефон` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Дата_найма` DATE NOT NULL,
  PRIMARY KEY (`idДиспетчера`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Типы_обслуживания`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Типы_обслуживания` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Типы_обслуживания` (
  `idТипа_обслуживания` INT NOT NULL AUTO_INCREMENT,
  `Название_услуги` VARCHAR(100) NOT NULL,
  `Описание` TEXT NULL,
  PRIMARY KEY (`idТипа_обслуживания`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Транспортные_средства`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Транспортные_средства` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Транспортные_средства` (
  `idТранспортного_средства` INT NOT NULL AUTO_INCREMENT,
  `Государственный_номер` VARCHAR(20) NOT NULL,
  `Модель` VARCHAR(50) NOT NULL,
  `Год_выпуска` INT NOT NULL,
  `Тип_топлива` VARCHAR(20) NOT NULL,
  `Текущий_пробег` INT NOT NULL,
  `Статус` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idТранспортного_средства`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Датчики`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Датчики` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Датчики` (
  `idДатчика` INT NOT NULL AUTO_INCREMENT,
  `Тип_датчика` VARCHAR(50) NOT NULL,
  `Дата_установки` DATE NOT NULL,
  `idТранспортного_средства` INT NOT NULL,
  PRIMARY KEY (`idДатчика`),
  INDEX `fk_Датчики_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  CONSTRAINT `fk_Датчики_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Мониторинг`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Мониторинг` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Мониторинг` (
  `idМониторинга` INT NOT NULL AUTO_INCREMENT,
  `idДатчика` INT NOT NULL,
  `Время_записи` TIMESTAMP NOT NULL,
  `Уровень_топлива` FLOAT NULL,
  `Скорость` FLOAT NULL,
  `Местоположение` VARCHAR(100) NULL,
  `Состояние_двигателя` BOOLEAN NULL,
  PRIMARY KEY (`idМониторинга`),
  INDEX `fk_Мониторинг_Датчики1_idx` (`idДатчика` ASC) VISIBLE,
  CONSTRAINT `fk_Мониторинг_Датчики1`
    FOREIGN KEY (`idДатчика`)
    REFERENCES `УправлениеАвтопарком`.`Датчики` (`idДатчика`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Маршруты`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Маршруты` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Маршруты` (
  `idМаршрута` INT NOT NULL AUTO_INCREMENT,
  `Начальная_точка` VARCHAR(100) NOT NULL,
  `Конечная_точка` VARCHAR(100) NOT NULL,
  `Расстояние` FLOAT NOT NULL,
  `Оценочное_время` TIME NOT NULL,
  `idТранспортного_средства` INT NOT NULL,
  `idДиспетчера` INT NOT NULL,
  PRIMARY KEY (`idМаршрута`),
  INDEX `fk_Маршруты_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  INDEX `fk_Маршруты_Диспетчеры1_idx` (`idДиспетчера` ASC) VISIBLE,
  CONSTRAINT `fk_Маршруты_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Маршруты_Диспетчеры1`
    FOREIGN KEY (`idДиспетчера`)
    REFERENCES `УправлениеАвтопарком`.`Диспетчеры` (`idДиспетчера`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Клиенты`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Клиенты` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Клиенты` (
  `idКлиента` INT NOT NULL AUTO_INCREMENT,
  `Имя` VARCHAR(50) NOT NULL,
  `Фамилия` VARCHAR(50) NOT NULL,
  `Телефон` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(100) NULL,
  `Адрес` VARCHAR(200) NULL,
  PRIMARY KEY (`idКлиента`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Заказы`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Заказы` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Заказы` (
  `idЗаказа` INT NOT NULL AUTO_INCREMENT,
  `Адрес_доставки` VARCHAR(200) NOT NULL,
  `Дата_заказа` DATE NOT NULL,
  `Статус` VARCHAR(20) NOT NULL,
  `idТранспортного_средства` INT NOT NULL,
  `idДиспетчера` INT NOT NULL,
  `idКлиента` INT NOT NULL,
  PRIMARY KEY (`idЗаказа`),
  INDEX `fk_Заказы_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  INDEX `fk_Заказы_Диспетчеры1_idx` (`idДиспетчера` ASC) VISIBLE,
  INDEX `fk_Заказы_Клиенты1_idx` (`idКлиента` ASC) VISIBLE,
  CONSTRAINT `fk_Заказы_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Заказы_Диспетчеры1`
    FOREIGN KEY (`idДиспетчера`)
    REFERENCES `УправлениеАвтопарком`.`Диспетчеры` (`idДиспетчера`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Заказы_Клиенты1`
    FOREIGN KEY (`idКлиента`)
    REFERENCES `УправлениеАвтопарком`.`Клиенты` (`idКлиента`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Водители`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Водители` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Водители` (
  `idВодителя` INT NOT NULL AUTO_INCREMENT,
  `Имя` VARCHAR(50) NOT NULL,
  `Фамилия` VARCHAR(50) NOT NULL,
  `Номер_водительского_удостоверения` VARCHAR(20) NOT NULL,
  `Телефон` VARCHAR(15) NOT NULL,
  `idТранспортного_средства` INT NULL,
  PRIMARY KEY (`idВодителя`),
  INDEX `fk_Водители_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  CONSTRAINT `fk_Водители_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Отчеты`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Отчеты` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Отчеты` (
  `idОтчета` INT NOT NULL AUTO_INCREMENT,
  `Дата_отчета` DATE NOT NULL,
  `Тип_отчета` VARCHAR(50) NOT NULL,
  `idТранспортного_средства` INT NOT NULL,
  `Детали` TEXT NULL,
  PRIMARY KEY (`idОтчета`),
  INDEX `fk_Отчеты_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  CONSTRAINT `fk_Отчеты_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `УправлениеАвтопарком`.`Техническое_обслуживание`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `УправлениеАвтопарком`.`Техническое_обслуживание` ;

CREATE TABLE IF NOT EXISTS `УправлениеАвтопарком`.`Техническое_обслуживание` (
  `idТехнического_обслуживания` INT NOT NULL AUTO_INCREMENT,
  `Дата_обслуживания` DATE NOT NULL,
  `idТранспортного_средства` INT NOT NULL,
  `idТипа_обслуживания` INT NOT NULL,
  `Стоимость` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`idТехнического_обслуживания`),
  INDEX `fk_Техническое_обслуживание_Транспортные_средства1_idx` (`idТранспортного_средства` ASC) VISIBLE,
  INDEX `fk_Техническое_обслуживание_Типы_обслуживания1_idx` (`idТипа_обслуживания` ASC) VISIBLE,
  CONSTRAINT `fk_Техническое_обслуживание_Транспортные_средства1`
    FOREIGN KEY (`idТранспортного_средства`)
    REFERENCES `УправлениеАвтопарком`.`Транспортные_средства` (`idТранспортного_средства`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Техническое_обслуживание_Типы_обслуживания1`
    FOREIGN KEY (`idТипа_обслуживания`)
    REFERENCES `УправлениеАвтопарком`.`Типы_обслуживания` (`idТипа_обслуживания`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
