-- MySQL Script generated by MySQL Workbench
-- 10/30/15 00:26:38
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema divertrip
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema divertrip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `divertrip` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `divertrip` ;

-- -----------------------------------------------------
-- Table `divertrip`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`login` (
  `user_name` VARCHAR(10) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`user_name`, `password`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`administrador` (
  `idAdministrador` INT(11) NOT NULL AUTO_INCREMENT,
  `last_access` DATETIME NOT NULL,
  `Login_user_name` VARCHAR(10) NOT NULL,
  `Login_password` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idAdministrador`),
  INDEX `fk_Administrador_Login1_idx` (`Login_user_name` ASC, `Login_password` ASC),
  CONSTRAINT `fk_Administrador_Login1`
    FOREIGN KEY (`Login_user_name` , `Login_password`)
    REFERENCES `divertrip`.`login` (`user_name` , `password`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`categoria` (
  `idCategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`direccion` (
  `idDireccion` INT(11) NOT NULL AUTO_INCREMENT,
  `latitud` VARCHAR(45) NULL DEFAULT NULL,
  `longitud` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idDireccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`estado` (
  `idEstado` INT(11) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`patrocinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`patrocinador` (
  `idPatrocinador` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(12) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `Login_user_name` VARCHAR(10) NOT NULL,
  `Login_password` VARCHAR(10) NOT NULL,
  `Estado_idEstado` INT(11) NOT NULL,
  PRIMARY KEY (`idPatrocinador`, `Estado_idEstado`),
  INDEX `fk_Patrocinador_Login_idx` (`Login_user_name` ASC, `Login_password` ASC),
  INDEX `fk_Patrocinador_Estado1_idx` (`Estado_idEstado` ASC),
  CONSTRAINT `fk_Patrocinador_Estado1`
    FOREIGN KEY (`Estado_idEstado`)
    REFERENCES `divertrip`.`estado` (`idEstado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Patrocinador_Login`
    FOREIGN KEY (`Login_user_name` , `Login_password`)
    REFERENCES `divertrip`.`login` (`user_name` , `password`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`evento` (
  `idEvento` INT(11) NOT NULL AUTO_INCREMENT,
  `name_event` VARCHAR(45) NULL,
  `description_event` VARCHAR(45) NULL DEFAULT NULL,
  `start_event` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `Categoria_idCategoria` INT(11) NOT NULL,
  `Direccion_idDireccion` INT(11) NOT NULL,
  `Patrocinador_idPatrocinador` INT(11) NOT NULL,
  `image` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idEvento`),
  INDEX `fk_Eventos_Categoria1_idx` (`Categoria_idCategoria` ASC),
  INDEX `fk_Eventos_Direccion1_idx` (`Direccion_idDireccion` ASC),
  INDEX `fk_Eventos_Patrocinador1_idx` (`Patrocinador_idPatrocinador` ASC),
  CONSTRAINT `fk_Eventos_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `divertrip`.`categoria` (`idCategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Eventos_Direccion1`
    FOREIGN KEY (`Direccion_idDireccion`)
    REFERENCES `divertrip`.`direccion` (`idDireccion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Eventos_Patrocinador1`
    FOREIGN KEY (`Patrocinador_idPatrocinador`)
    REFERENCES `divertrip`.`patrocinador` (`idPatrocinador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`preferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`preferencia` (
  `idPreferencia` INT(11) NOT NULL AUTO_INCREMENT,
  `language` VARCHAR(45) NULL DEFAULT NULL,
  `notification` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idPreferencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(12) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `latitud` VARCHAR(45) NULL DEFAULT NULL,
  `longitud` VARCHAR(45) NULL DEFAULT NULL,
  `Login_user_name` VARCHAR(10) NOT NULL,
  `Login_password` VARCHAR(10) NOT NULL,
  `Preferencia_idPreferencia` INT(11) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Turista_Login1_idx` (`Login_user_name` ASC, `Login_password` ASC),
  INDEX `fk_Turista_Preferencia1_idx` (`Preferencia_idPreferencia` ASC),
  CONSTRAINT `fk_Turista_Login1`
    FOREIGN KEY (`Login_user_name` , `Login_password`)
    REFERENCES `divertrip`.`login` (`user_name` , `password`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Turista_Preferencia1`
    FOREIGN KEY (`Preferencia_idPreferencia`)
    REFERENCES `divertrip`.`preferencia` (`idPreferencia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`filtro_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`filtro_usuario` (
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Categoria_idCategoria` INT(11) NOT NULL,
  PRIMARY KEY (`Categoria_idCategoria`, `Usuario_idUsuario`),
  INDEX `fk_Filto_Usuario_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Filto_Usuario_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `divertrip`.`categoria` (`idCategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Filto_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `divertrip`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`ha_logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`ha_logins` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userId` INT(11) NOT NULL,
  `loginProvider` VARCHAR(50) NOT NULL,
  `loginProviderIdentifier` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `loginProvider_2` (`loginProvider` ASC, `loginProviderIdentifier` ASC),
  INDEX `loginProvider` (`loginProvider` ASC),
  INDEX `loginProviderIdentifier` (`loginProviderIdentifier` ASC),
  INDEX `userId` (`userId` ASC),
  INDEX `id` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`lugar_emblematico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`lugar_emblematico` (
  `idLugar_Emblematico` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `Direccion_idDireccion` INT(11) NOT NULL,
  PRIMARY KEY (`idLugar_Emblematico`),
  INDEX `fk_Lugar_Emblematico_Direccion1_idx` (`Direccion_idDireccion` ASC),
  CONSTRAINT `fk_Lugar_Emblematico_Direccion1`
    FOREIGN KEY (`Direccion_idDireccion`)
    REFERENCES `divertrip`.`direccion` (`idDireccion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `divertrip`.`usuario_busca_lugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `divertrip`.`usuario_busca_lugar` (
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Lugar_Emblematico_idLugar_Emblematico` INT(11) NOT NULL,
  INDEX `fk_Usuario_busca_lugar_Usuario1_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_Usuario_busca_lugar_Lugar_Emblematico1_idx` (`Lugar_Emblematico_idLugar_Emblematico` ASC),
  CONSTRAINT `fk_Usuario_busca_lugar_Lugar_Emblematico1`
    FOREIGN KEY (`Lugar_Emblematico_idLugar_Emblematico`)
    REFERENCES `divertrip`.`lugar_emblematico` (`idLugar_Emblematico`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_busca_lugar_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `divertrip`.`usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
