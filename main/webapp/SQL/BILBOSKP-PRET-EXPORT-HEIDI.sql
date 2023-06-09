-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para bilboskpdb
CREATE DATABASE IF NOT EXISTS `bilboskpdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `bilboskpdb`;

-- Volcando estructura para tabla bilboskpdb.cupon
CREATE TABLE IF NOT EXISTS `cupon` (
  `idCupon` int(11) NOT NULL AUTO_INCREMENT,
  `idSuscriptor` int(11) NOT NULL,
  `fechaCaducidad` datetime NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'Disponible',
  `reembolsable` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idCupon`) USING BTREE,
  KEY `fk_cupon_suscriptor` (`idSuscriptor`),
  CONSTRAINT `fk_cupon_suscriptor` FOREIGN KEY (`idSuscriptor`) REFERENCES `suscriptor` (`idSuscriptor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.cupon: ~0 rows (aproximadamente)
DELETE FROM `cupon`;

-- Volcando estructura para tabla bilboskpdb.escenario
CREATE TABLE IF NOT EXISTS `escenario` (
  `nombreEscenario` varchar(50) NOT NULL,
  `idSala` int(11) NOT NULL DEFAULT 0,
  `descripcion` varchar(255) DEFAULT NULL,
  `imagen` varchar(255) NOT NULL,
  `esJsp` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`nombreEscenario`) USING BTREE,
  KEY `idSala` (`idSala`),
  CONSTRAINT `escenario_ibfk_1` FOREIGN KEY (`idSala`) REFERENCES `salaonline` (`idSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.escenario: ~7 rows (aproximadamente)
DELETE FROM `escenario`;
INSERT INTO `escenario` (`nombreEscenario`, `idSala`, `descripcion`, `imagen`, `esJsp`) VALUES
	('ComedorNave', 10, 'Comedor de la nave', 'comedor_nave', 0),
	('Dormitorio', 1, 'Qué hacía yo en un dormitorio?', 'dormitorio', 0),
	('Entrada', 1, 'Esta sala tiene unas rocas que bloquean la puerta. Talvez pueda moverlas con algo.', 'entrada', 0),
	('LobbyNave', 10, 'Lobby de la nave', 'lobby_nave', 0),
	('MesaNave', 10, 'inicio de la escape room', 'mesa_nave', 0),
	('Nave', 1, 'Increible pensar que este era un lugar de culto, antes...', 'nave', 0),
	('PanelCodigo', 10, 'Panel codigo', 'panel_codigo', 1);

-- Volcando estructura para tabla bilboskpdb.escenarios_inicio
CREATE TABLE IF NOT EXISTS `escenarios_inicio` (
  `nombreEscenario` varchar(50) NOT NULL DEFAULT '',
  `idSala` int(11) DEFAULT NULL,
  PRIMARY KEY (`nombreEscenario`),
  KEY `idSala` (`idSala`),
  CONSTRAINT `FK_escenarios_inicio_escenario` FOREIGN KEY (`nombreEscenario`) REFERENCES `escenario` (`nombreEscenario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_escenarios_inicio_salaonline` FOREIGN KEY (`idSala`) REFERENCES `salaonline` (`idSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.escenarios_inicio: ~2 rows (aproximadamente)
DELETE FROM `escenarios_inicio`;
INSERT INTO `escenarios_inicio` (`nombreEscenario`, `idSala`) VALUES
	('Dormitorio', 1),
	('MesaNave', 10);

-- Volcando estructura para tabla bilboskpdb.escenario_flecha
CREATE TABLE IF NOT EXISTS `escenario_flecha` (
  `nombreEscenario` varchar(50) DEFAULT NULL,
  `nombreEscenarioDestino` varchar(50) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `posicionX` int(3) unsigned NOT NULL COMMENT '%',
  `posicionY` int(3) unsigned NOT NULL COMMENT '%',
  `dimensionX` int(3) unsigned NOT NULL COMMENT '%',
  `dimensionY` int(3) unsigned NOT NULL COMMENT '%',
  KEY `escenario` (`nombreEscenario`) USING BTREE,
  KEY `escenarioDestino` (`nombreEscenarioDestino`) USING BTREE,
  CONSTRAINT `FK_escenario_flecha_escenario` FOREIGN KEY (`nombreEscenario`) REFERENCES `escenario` (`nombreEscenario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_escenario_flecha_escenario_2` FOREIGN KEY (`nombreEscenarioDestino`) REFERENCES `escenario` (`nombreEscenario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.escenario_flecha: ~6 rows (aproximadamente)
DELETE FROM `escenario_flecha`;
INSERT INTO `escenario_flecha` (`nombreEscenario`, `nombreEscenarioDestino`, `imagen`, `posicionX`, `posicionY`, `dimensionX`, `dimensionY`) VALUES
	('MesaNave', 'ComedorNave', 'derecha', 90, 40, 4, 8),
	('MesaNave', 'LobbyNave', 'izquierda', 5, 40, 4, 8),
	('LobbyNave', 'MesaNave', 'derecha', 90, 40, 4, 8),
	('ComedorNave', 'MesaNave', 'izquierda', 5, 40, 4, 8),
	('MesaNave', 'PanelCodigo', '', 58, 35, 20, 20),
	('PanelCodigo', 'MesaNave', 'izquierda', 10, 40, 4, 8);

-- Volcando estructura para tabla bilboskpdb.horario
CREATE TABLE IF NOT EXISTS `horario` (
  `idSalaFisica` int(6) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `disponible` tinyint(4) NOT NULL DEFAULT 1,
  KEY `idSalaFisica` (`idSalaFisica`),
  CONSTRAINT `FK__salafisica` FOREIGN KEY (`idSalaFisica`) REFERENCES `salafisica` (`idSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.horario: ~18 rows (aproximadamente)
DELETE FROM `horario`;
INSERT INTO `horario` (`idSalaFisica`, `fechaHora`, `disponible`) VALUES
	(1, '2023-05-14 10:00:00', 1),
	(1, '2023-05-14 12:00:00', 1),
	(1, '2023-05-14 14:00:00', 1),
	(1, '2023-05-15 10:00:00', 1),
	(1, '2023-05-15 12:00:00', 1),
	(1, '2023-05-15 14:00:00', 1),
	(1, '2023-05-16 10:00:00', 1),
	(1, '2023-05-16 12:00:00', 1),
	(1, '2023-05-16 14:00:00', 1),
	(1, '2023-05-17 10:00:00', 1),
	(1, '2023-05-17 12:00:00', 1),
	(1, '2023-05-17 14:00:00', 1),
	(1, '2023-05-18 10:00:00', 1),
	(1, '2023-05-18 12:00:00', 1),
	(1, '2023-05-18 14:00:00', 1),
	(1, '2023-05-19 10:00:00', 1),
	(1, '2023-05-19 12:00:00', 1),
	(1, '2023-05-19 14:00:00', 1);

-- Volcando estructura para tabla bilboskpdb.objeto
CREATE TABLE IF NOT EXISTS `objeto` (
  `idObjeto` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEscenario` varchar(50) DEFAULT NULL,
  `nombre` varchar(30) NOT NULL,
  `idObjetoADesbloquear` int(11) DEFAULT NULL,
  `descripcion` varchar(255) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `visibleInicio` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'boolean 1-0',
  `visibleInventario` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'booleano si se agrega al inventario el objeto',
  `desapareceAlUsar` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'boolean 1-0',
  `dimensionX` int(3) NOT NULL COMMENT '%',
  `dimenxionY` int(3) NOT NULL COMMENT '%',
  `posicionX` int(3) NOT NULL COMMENT '%',
  `posicionY` int(3) NOT NULL COMMENT '%',
  PRIMARY KEY (`idObjeto`) USING BTREE,
  UNIQUE KEY `nombre` (`nombre`),
  KEY `idObjetoDesbloquea` (`idObjetoADesbloquear`) USING BTREE,
  KEY `nombreEscenario` (`nombreEscenario`),
  CONSTRAINT `FK_objeto_escenario` FOREIGN KEY (`nombreEscenario`) REFERENCES `escenario` (`nombreEscenario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `objeto_ibfk_2` FOREIGN KEY (`idObjetoADesbloquear`) REFERENCES `objeto` (`idObjeto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.objeto: ~14 rows (aproximadamente)
DELETE FROM `objeto`;
INSERT INTO `objeto` (`idObjeto`, `nombreEscenario`, `nombre`, `idObjetoADesbloquear`, `descripcion`, `imagen`, `visibleInicio`, `visibleInventario`, `desapareceAlUsar`, `dimensionX`, `dimenxionY`, `posicionX`, `posicionY`) VALUES
	(1, 'Dormitorio', 'Llave dorada', NULL, 'Esta llave parece vieja, deberían poder abrir una de las antiguas puertas de este lugar', 'llaveDorada.png', 0, 1, 1, 0, 0, 0, 0),
	(2, 'Dormitorio', 'Rosa roja', NULL, 'Una bonita rosa, es como si hubiera estado aquí mucho tiempo, pero no parece haberse marchitado', 'rosa.png', 1, 1, 1, 0, 0, 0, 0),
	(3, 'Dormitorio', 'Aguja minutero', NULL, 'Un Minutero, esto sin duda debe servir para desbloquear algo…', 'minutero.png', 1, 1, 1, 10, 25, 30, 40),
	(4, 'Dormitorio', 'Aguja segundero', NULL, 'El Segundero, todo reloj debe tener siempre dos manijas', 'segundero.png', 1, 1, 1, 0, 0, 0, 0),
	(5, 'Dormitorio', 'Explosivo', NULL, '¿Esto es una bomba? Estaré loco pero si uso esto, fijo salgo de aquí, vivo o muerto...', 'explosivo.png', 1, 1, 1, 0, 0, 0, 0),
	(6, 'Dormitorio', 'Maquina de humo', NULL, 'Una maquina de humo.', 'maquinaHumo.png', 1, 1, 1, 0, 0, 0, 0),
	(7, 'Dormitorio', 'Llave plateada', NULL, 'Llave plateada casi intacta. Tiene un estilo antiguo particular pero parece moderna.', 'llavePlateada.png', 1, 1, 1, 0, 0, 0, 0),
	(8, 'Dormitorio', 'PuertaConfesionario', NULL, 'Está cerrada.', '\r\n', 1, 0, 0, 0, 0, 0, 0),
	(9, 'Dormitorio', 'JudasCama', 9, 'Qué extraño muñeco, ¿qué podría hacer aquí?', 'judasCama.png', 1, 0, 1, 0, 0, 15, 20),
	(10, 'Dormitorio', 'Nota', NULL, 'Una nota vieja. Creo que es sobre una reunión de la secta a esta hora, no dice una fecha específica, pero estoy seguro que debe ser en este lugar.', 'nota.png', 1, 1, 0, 0, 0, 0, 0),
	(11, 'Dormitorio', 'Periodico', NULL, 'Vaya, un periodico ¿Que dira?', 'periodico.png', 1, 1, 0, 0, 0, 0, 0),
	(12, 'Dormitorio', 'CuerdaAbajo', NULL, 'Creo que deberia mirar a donde lleva esta cuerda.', 'cuerdaAbajo.png', 1, 0, 1, 0, 0, 0, 0),
	(13, 'Dormitorio', 'CuerdaArriba', 1, 'Creo que deberia mirar a donde lleva esta cuerda.', 'cuerdaArriba.png', 1, 0, 1, 0, 0, 0, 0),
	(14, 'Dormitorio', 'CuerdaSuelo', NULL, 'Creo que no me servirá de nada', 'cuerdaSuelo.png', 0, 0, 1, 0, 0, 0, 0);

-- Volcando estructura para tabla bilboskpdb.partidafisica
CREATE TABLE IF NOT EXISTS `partidafisica` (
  `idPartida` int(11) NOT NULL AUTO_INCREMENT,
  `idReserva` int(11) DEFAULT NULL,
  `idSalaFisica` int(11) NOT NULL DEFAULT 0,
  `puntaje` int(11) NOT NULL,
  `numeroJugadores` varchar(3) NOT NULL,
  `nombreGrupo` varchar(255) NOT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime NOT NULL,
  PRIMARY KEY (`idPartida`) USING BTREE,
  KEY `idSalaFisica` (`idSalaFisica`),
  KEY `idReserva` (`idReserva`),
  CONSTRAINT `FK_partidafisica_reserva` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_partidafisica_salafisica` FOREIGN KEY (`idSalaFisica`) REFERENCES `salafisica` (`idSala`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.partidafisica: ~3 rows (aproximadamente)
DELETE FROM `partidafisica`;
INSERT INTO `partidafisica` (`idPartida`, `idReserva`, `idSalaFisica`, `puntaje`, `numeroJugadores`, `nombreGrupo`, `fechaInicio`, `fechaFin`) VALUES
	(1, 1, 1, 2000, '6', 'Los exploradores', '2023-04-09 10:00:00', '2023-04-09 09:25:00'),
	(2, 2, 1, 1000, '8', 'Los Mosqueteros', '2023-04-10 14:59:00', '2023-04-09 13:37:00'),
	(3, 3, 1, 1500, '4', 'La banda', '2023-04-14 15:00:00', '2023-04-09 14:25:00');

-- Volcando estructura para tabla bilboskpdb.partidaonline
CREATE TABLE IF NOT EXISTS `partidaonline` (
  `idPartida` int(11) NOT NULL AUTO_INCREMENT,
  `idSalaOnline` int(11) NOT NULL DEFAULT 0,
  `idAnfitrion` int(11) NOT NULL,
  `puntaje` int(11) NOT NULL,
  `numeroJugadores` varchar(3) NOT NULL,
  `nombreGrupo` varchar(255) NOT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime NOT NULL,
  `visibleRanking` tinyint(4) DEFAULT 1 COMMENT '1 visible 0 invisible',
  PRIMARY KEY (`idPartida`) USING BTREE,
  KEY `idSalaOnline` (`idSalaOnline`),
  KEY `idAnfitrion` (`idAnfitrion`),
  CONSTRAINT `FK_partidaonline_salaonline` FOREIGN KEY (`idSalaOnline`) REFERENCES `salaonline` (`idSala`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_partidaonline_suscriptor` FOREIGN KEY (`idAnfitrion`) REFERENCES `suscriptor` (`idSuscriptor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.partidaonline: ~88 rows (aproximadamente)
DELETE FROM `partidaonline`;
INSERT INTO `partidaonline` (`idPartida`, `idSalaOnline`, `idAnfitrion`, `puntaje`, `numeroJugadores`, `nombreGrupo`, `fechaInicio`, `fechaFin`, `visibleRanking`) VALUES
	(1, 2, 1, 2000, '6', 'Los mosqueteros', '2023-04-09 22:51:02', '2023-04-09 23:51:04', 1),
	(2, 1, 1, 1800, '3', 'Los mosqueteros', '2023-04-09 22:51:02', '2023-04-09 23:51:04', 1),
	(3, 3, 5, 1700, '2', 'Los solitarios', '2023-04-13 12:00:00', '2023-04-13 13:45:00', 1),
	(6, 3, 3, 1400, '5', 'Los aventureros', '2023-04-09 15:30:00', '2023-04-09 17:45:00', 1),
	(7, 1, 2, 1400, '4', 'Los exploradores', '2023-04-10 10:00:00', '2023-04-10 12:30:00', 1),
	(8, 3, 4, 800, '3', 'Los valientes', '2023-04-11 18:00:00', '2023-04-11 19:45:00', 1),
	(9, 2, 1, 1200, '6', 'Los caballeros', '2023-04-12 21:00:00', '2023-04-13 00:15:00', 1),
	(11, 1, 4, 600, '2', 'Los cazadores', '2023-04-13 12:00:00', '2023-04-13 14:30:00', 1),
	(204, 3, 12, 2700, '8', 'SO3', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(205, 3, 12, 2700, '8', 'SO3', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(206, 10, 12, 1200, '8', 'SO1', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(207, 10, 12, 2700, '8', 'SO1', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(208, 10, 12, 2700, '8', 'SO1', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(209, 2, 12, 2700, '8', 'SO1', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(212, 2, 12, 3600, '8', 'SO2', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(213, 2, 12, 3600, '8', 'SO2', '2023-05-06 00:00:00', '2023-05-06 00:00:00', 1),
	(214, 3, 12, 2700, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:00:00', 1),
	(216, 3, 12, 2700, '8', 'SO1', '2023-05-07 00:00:00', '2023-05-07 00:00:00', 1),
	(217, 9, 12, 1380, '8', 'SO1', '2023-05-07 00:00:00', '2023-05-07 00:00:00', 1),
	(218, 1, 12, 2700, '8', 'SO1', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(219, 1, 12, 2700, '8', 'SO1', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(220, 10, 12, 2700, '8', 'SO1', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(221, 1, 12, 2700, '8', 'SO1', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(300, 10, 4, 2700, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:00:00', 1),
	(301, 10, 2, 5400, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:45:00', 1),
	(302, 10, 7, 3000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:00:00', 1),
	(303, 10, 5, 3000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:30:00', 1),
	(304, 10, 5, 6000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:45:00', 1),
	(305, 10, 1, 2000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:30:00', 1),
	(306, 3, 12, 2700, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:30:00', 1),
	(307, 10, 3, 1500, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:55:00', 1),
	(308, 10, 6, 3000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 01:25:00', 1),
	(309, 10, 6, 7000, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:10:00', 1),
	(310, 10, 6, 3500, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:50:00', 1),
	(311, 10, 6, 3600, '8', 'SO3', '2023-05-07 00:00:00', '2023-05-07 00:55:00', 1),
	(312, 10, 12, 0, '8', 'SO10', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(313, 10, 12, 0, '8', 'SO10', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(314, 10, 12, 0, '8', 'SO10', '2023-05-08 00:00:00', '2023-05-08 00:00:00', 1),
	(316, 10, 8, 0, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(338, 9, 11, 7500, '4', 'Grupo A', '2023-05-08 12:00:00', '2023-05-08 12:30:00', 1),
	(339, 9, 11, 5000, '3', 'Grupo B', '2023-05-08 14:00:00', '2023-05-08 15:00:00', 1),
	(340, 9, 11, 3000, '5', 'Grupo C', '2023-05-08 17:00:00', '2023-05-08 19:00:00', 1),
	(341, 9, 11, 4000, '2', 'Grupo D', '2023-05-08 15:30:00', '2023-05-08 16:00:00', 1),
	(342, 9, 11, 2500, '6', 'Grupo E', '2023-05-08 18:00:00', '2023-05-08 19:30:00', 1),
	(343, 9, 11, 1500, '3', 'Grupo F', '2023-05-08 13:00:00', '2023-05-08 14:00:00', 1),
	(344, 9, 11, 2000, '5', 'Grupo G', '2023-05-08 16:00:00', '2023-05-08 18:00:00', 1),
	(345, 9, 12, 1200, '2', 'Grupo H', '2023-05-08 14:30:00', '2023-05-08 15:00:00', 1),
	(346, 5, 11, 7500, '5', '', '2023-05-09 09:30:00', '2023-05-09 10:15:00', 1),
	(347, 5, 11, 6750, '4', '', '2023-05-09 11:00:00', '2023-05-09 11:45:00', 1),
	(348, 5, 11, 6000, '3', '', '2023-05-09 12:30:00', '2023-05-09 13:00:00', 1),
	(349, 5, 11, 5250, '5', '', '2023-05-09 14:00:00', '2023-05-09 14:45:00', 1),
	(350, 5, 11, 4500, '4', '', '2023-05-09 15:30:00', '2023-05-09 16:00:00', 1),
	(351, 5, 11, 3750, '3', '', '2023-05-09 17:00:00', '2023-05-09 17:30:00', 1),
	(352, 5, 11, 3000, '5', '', '2023-05-09 18:00:00', '2023-05-09 18:45:00', 1),
	(353, 5, 11, 2250, '4', '', '2023-05-09 19:30:00', '2023-05-09 20:00:00', 1),
	(354, 5, 11, 1500, '3', '', '2023-05-09 21:00:00', '2023-05-09 21:30:00', 1),
	(355, 5, 11, 750, '5', '', '2023-05-09 22:00:00', '2023-05-09 22:45:00', 1),
	(356, 10, 8, 1800, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(357, 10, 8, 1800, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(358, 10, 8, 2300, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(359, 10, 8, 2300, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(360, 10, 8, 2300, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(361, 10, 8, 2300, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(362, 10, 8, 2300, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(363, 10, 8, 2297, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(364, 10, 8, 2297, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(365, 10, 8, 2297, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(366, 10, 8, 2296, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(367, 10, 8, 7297, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(368, 10, 8, 7297, '8', 'SO10', '2023-05-09 00:00:00', '2023-05-09 00:00:00', 1),
	(369, 10, 8, 6781, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(370, 10, 8, 6782, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(371, 10, 8, 6783, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(372, 10, 8, 6785, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(373, 10, 8, 0, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(374, 10, 8, 6700, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(375, 10, 8, 6787, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(376, 10, 8, 6754, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(377, 10, 8, 6794, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(378, 10, 8, 0, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(379, 10, 8, 6795, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(380, 10, 8, 6686, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(381, 10, 8, 6778, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(382, 10, 8, 6758, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(383, 10, 8, 6784, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(384, 10, 8, 6796, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(385, 10, 8, 6796, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1),
	(386, 10, 8, 6777, '8', 'SO10', '2023-05-10 00:00:00', '2023-05-10 00:00:00', 1);

-- Volcando estructura para tabla bilboskpdb.pista
CREATE TABLE IF NOT EXISTS `pista` (
  `idPista` int(11) NOT NULL AUTO_INCREMENT,
  `idPuzzle` int(11) NOT NULL DEFAULT 0,
  `descripcion` varchar(255) NOT NULL,
  `penalizacion` int(4) DEFAULT NULL,
  PRIMARY KEY (`idPista`),
  KEY `Índice 2` (`idPuzzle`),
  CONSTRAINT `FK_pista_puzzle` FOREIGN KEY (`idPuzzle`) REFERENCES `puzzle` (`idPuzzle`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.pista: ~0 rows (aproximadamente)
DELETE FROM `pista`;

-- Volcando estructura para tabla bilboskpdb.puzzle
CREATE TABLE IF NOT EXISTS `puzzle` (
  `idPuzzle` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEscenario` varchar(50) NOT NULL,
  `idTipoPuzzle` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `puntuacion` int(4) NOT NULL,
  PRIMARY KEY (`idPuzzle`),
  KEY `nombreEscenario` (`nombreEscenario`),
  KEY `idTipo` (`idTipoPuzzle`) USING BTREE,
  CONSTRAINT `FK_puzzle_escenario` FOREIGN KEY (`nombreEscenario`) REFERENCES `escenario` (`nombreEscenario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_puzzle_puzzle_tipos` FOREIGN KEY (`idTipoPuzzle`) REFERENCES `puzzle_tipos` (`idTipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.puzzle: ~1 rows (aproximadamente)
DELETE FROM `puzzle`;
INSERT INTO `puzzle` (`idPuzzle`, `nombreEscenario`, `idTipoPuzzle`, `descripcion`, `puntuacion`) VALUES
	(1, 'MesaNave', 4, '1826', 1826);

-- Volcando estructura para tabla bilboskpdb.puzzle_objeto
CREATE TABLE IF NOT EXISTS `puzzle_objeto` (
  `idPuzzle` int(11) NOT NULL DEFAULT 0,
  `idObjeto` int(11) NOT NULL DEFAULT 0,
  KEY `FK_requerimiento_objeto` (`idObjeto`),
  KEY `FK_requerimiento_puzzle` (`idPuzzle`),
  CONSTRAINT `FK_requerimiento_objeto` FOREIGN KEY (`idObjeto`) REFERENCES `objeto` (`idObjeto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_requerimiento_puzzle` FOREIGN KEY (`idPuzzle`) REFERENCES `puzzle` (`idPuzzle`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.puzzle_objeto: ~0 rows (aproximadamente)
DELETE FROM `puzzle_objeto`;

-- Volcando estructura para tabla bilboskpdb.puzzle_tipos
CREATE TABLE IF NOT EXISTS `puzzle_tipos` (
  `idTipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`idTipo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.puzzle_tipos: ~4 rows (aproximadamente)
DELETE FROM `puzzle_tipos`;
INSERT INTO `puzzle_tipos` (`idTipo`, `nombre`) VALUES
	(2, 'Abrir puerta'),
	(4, 'Clave'),
	(3, 'Click objeto'),
	(1, 'Usar Objeto');

-- Volcando estructura para vista bilboskpdb.rankingfisico
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `rankingfisico` (
	`idSala` INT(11) NOT NULL,
	`‘sala’` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nombreGrupo` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`puntaje` INT(11) NOT NULL,
	`‘fecha’` DATETIME NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista bilboskpdb.rankingonline
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `rankingonline` (
	`idSala` INT(11) NOT NULL,
	`sala jugada` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nombreGrupo` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`puntaje` INT(11) NOT NULL,
	`fecha` DATETIME NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla bilboskpdb.reserva
CREATE TABLE IF NOT EXISTS `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `idSuscriptor` int(11) DEFAULT NULL,
  `idSalaFisica` int(11) DEFAULT NULL,
  `numJugadores` int(1) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`idReserva`),
  KEY `idSuscriptor` (`idSuscriptor`),
  KEY `idSalaFisica` (`idSalaFisica`),
  CONSTRAINT `FK_reserva_salafisica` FOREIGN KEY (`idSalaFisica`) REFERENCES `salafisica` (`idSala`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_reserva_suscriptor` FOREIGN KEY (`idSuscriptor`) REFERENCES `suscriptor` (`idSuscriptor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.reserva: ~3 rows (aproximadamente)
DELETE FROM `reserva`;
INSERT INTO `reserva` (`idReserva`, `idSuscriptor`, `idSalaFisica`, `numJugadores`, `fechaHora`, `estado`) VALUES
	(1, 11, 1, 6, '2023-05-30 10:00:00', 1),
	(2, 8, 1, 8, '2023-05-30 12:00:00', 1),
	(3, 1, 1, 6, '2023-06-03 15:00:00', 1);

-- Volcando estructura para tabla bilboskpdb.salafisica
CREATE TABLE IF NOT EXISTS `salafisica` (
  `idSala` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `dificultad` varchar(255) NOT NULL,
  `tematica` varchar(30) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `tiempoMax` int(3) unsigned NOT NULL COMMENT 'Minutos',
  `jugadoresMin` int(2) unsigned NOT NULL DEFAULT 1,
  `jugadoresMax` int(2) unsigned NOT NULL DEFAULT 8,
  `edad_recomendada` int(2) unsigned NOT NULL DEFAULT 18,
  `direccion` varchar(255) NOT NULL,
  `telefono` int(9) unsigned NOT NULL,
  PRIMARY KEY (`idSala`) USING BTREE,
  CONSTRAINT `jugadoresMax` CHECK (`jugadoresMax` >= 1),
  CONSTRAINT `jugadoresMin` CHECK (`jugadoresMin` <= `jugadoresMax` and `jugadoresMin` >= 1)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.salafisica: ~2 rows (aproximadamente)
DELETE FROM `salafisica`;
INSERT INTO `salafisica` (`idSala`, `nombre`, `dificultad`, `tematica`, `descripcion`, `tiempoMax`, `jugadoresMin`, `jugadoresMax`, `edad_recomendada`, `direccion`, `telefono`) VALUES
	(1, 'Misterio en la mansión', 'Media', 'Misterio', 'Investiga una mansión abandonada y resuelve los enigmas que esconde su oscuro pasado.', 60, 6, 8, 18, 'Calle Mayor 25', 987654321),
	(2, 'Escape de ciudad 17', 'Difícil', 'Suspenso', 'Te has despertado encerrado en una prisión de máxima seguridad sin recordar cómo llegaste allí. Deberás trabajar en equipo para encontrar la forma de escapar antes de que los guardias descubran tu plan.', 90, 6, 8, 18, 'Avenida de la Libertad 10', 123456789);

-- Volcando estructura para tabla bilboskpdb.salaonline
CREATE TABLE IF NOT EXISTS `salaonline` (
  `idSala` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `dificultad` varchar(255) NOT NULL,
  `tematica` varchar(30) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `tiempoMax` int(3) unsigned NOT NULL COMMENT 'Minutos',
  `jugadoresMin` int(2) unsigned NOT NULL DEFAULT 1,
  `jugadoresMax` int(2) unsigned NOT NULL DEFAULT 8,
  `edad_recomendada` int(2) unsigned NOT NULL DEFAULT 18,
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idSala`) USING BTREE,
  CONSTRAINT `jugadoresMax` CHECK (`jugadoresMax` >= 1),
  CONSTRAINT `jugadoresMin` CHECK (`jugadoresMin` <= `jugadoresMax` and `jugadoresMin` >= 1)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.salaonline: ~6 rows (aproximadamente)
DELETE FROM `salaonline`;
INSERT INTO `salaonline` (`idSala`, `nombre`, `dificultad`, `tematica`, `descripcion`, `tiempoMax`, `jugadoresMin`, `jugadoresMax`, `edad_recomendada`, `disponible`) VALUES
	(1, 'Perdidos de la mano de Dios', 'Media', 'Terror', 'Vas de camino en medio del bosque, donde eres abducido por un loco perteneciente a una secta. Te das cuenta que ahora estás en un bosque, perdido de la mano de Dios…', 60, 1, 8, 16, 0),
	(2, 'El Gimnasio Infernal', 'Difícil', 'Suspenso', 'En un gimnasio de élite, un grupo de crossfiteros debe luchar contra una conspiración interna, encontrar al impostor entre ellos y superar pruebas físicas y mentales para escapar antes de que sea muy tarde.', 60, 2, 8, 18, 0),
	(3, 'Hasta la luz del Alba', 'Media', 'Misterio', 'Un grupo de amigos se encuentran la escena de una cabaña abandonada en el medio del bosque, curiosamente encuentran pistas sobre los que solían habitarla, y la tragedia que les precedió. Terminan siendo víctima de algo más allá de la comprensión humana.', 45, 1, 8, 18, 0),
	(5, 'El Museo Maldito', 'Difícil', 'Terror', 'Un grupo de investigadores debe resolver el misterio detrás de una serie de extraños sucesos en un museo abandonado. Descubrirán que el lugar está maldito y tendrán que enfrentarse a las fuerzas sobrenaturales para sobrevivir.', 90, 3, 8, 18, 0),
	(9, 'El Asesino del Ajedrez', 'Media', 'Misterio', 'En un torneo de ajedrez de élite, uno de los jugadores es encontrado muerto en su habitación de hotel. El resto de los participantes deberán resolver el crimen antes de que el asesino ataque de nuevo.', 60, 4, 8, 16, 0),
	(10, 'Traición en el Espacio', 'Fácil', 'Sci-fi', 'Como tripulante de una nave espacial, tienes la misión de descubrir al impostor que se encuentra entre la tripulación. Resuelve acertijos y tareas mientras tratas de encontrar pistas para descubrir al impostor antes de que sea demasiado tarde.', 30, 1, 8, 16, 1);

-- Volcando estructura para vista bilboskpdb.salas_mas_jugadas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `salas_mas_jugadas` (
	`idSala` INT(11) NOT NULL,
	`nombre` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`dificultad` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`tematica` VARCHAR(30) NOT NULL COLLATE 'utf8mb4_general_ci',
	`descripcion` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`tiempoMax` INT(3) UNSIGNED NOT NULL COMMENT 'Minutos',
	`jugadoresMin` INT(2) UNSIGNED NOT NULL,
	`jugadoresMax` INT(2) UNSIGNED NOT NULL,
	`edad_recomendada` INT(2) UNSIGNED NOT NULL,
	`disponible` TINYINT(1) NOT NULL,
	`cantidad_partidas_jugadas` BIGINT(21) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla bilboskpdb.suscriptor
CREATE TABLE IF NOT EXISTS `suscriptor` (
  `idSuscriptor` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL,
  `alias` varchar(15) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `fech_nac` date NOT NULL,
  `telefono` int(9) unsigned DEFAULT NULL,
  `imagen` varchar(255) NOT NULL DEFAULT 'defaults/1.png',
  `activo` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`idSuscriptor`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.suscriptor: ~13 rows (aproximadamente)
DELETE FROM `suscriptor`;
INSERT INTO `suscriptor` (`idSuscriptor`, `email`, `pass`, `alias`, `nombre`, `apellidos`, `fech_nac`, `telefono`, `imagen`, `activo`) VALUES
	(1, 'JuanjoElCamioneroExtremo@gmail.co.uk', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Juanjo', 'Juanjo', 'Perez Agujeros', '1987-10-10', 177565252, 'defaults/1.png', 1),
	(2, 'aceitunocantero@hotmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Aceitunito', 'Eneko', 'Figeroa Cantero', '1979-04-17', 125265112, 'defaults/8.png', 1),
	(3, 'rosamargarita@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'RosaMarg', 'Rosa', 'Margarita', '1995-02-28', 987654321, 'defaults/7.png', 1),
	(4, 'aventurasconpepe@yahoo.es', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Pepe', 'José', 'González', '1985-07-12', 741258963, 'defaults/6.png', 1),
	(5, 'exploradoraindigo@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'IndigoExplorer', 'Lucía', 'Gómez', '1998-11-05', 365874123, 'defaults/5.png', 1),
	(6, 'travesiasalvaje@hotmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Salva', 'Pedro', 'Ramírez', '1972-09-20', 987654789, 'defaults/4.png', 1),
	(7, 'aventurasenelamazonas@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'AmazonAdventure', 'María', 'López', '1988-03-15', 741236985, 'defaults/2.png', 1),
	(8, 'admin@bilboskp.com', '2ed389e3d996321973b9f6662acbe71099b61bd87a983cdd8c9a22b8b175fb81', 'admin', 'bilbo', 'skp', '1999-10-09', 0, 'defaults/3.png', 1),
	(11, 'miguelAn@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'MiguelAngel', 'Miguel', 'Angel', '1983-10-10', 0, 'defaults/7.png', 1),
	(12, 'joseManuel@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'José', 'José', 'Muñoz', '2023-10-10', 0, 'defaults/1.png', 1),
	(24, 'juanca@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'juan carlos', 'juan carlos', 'juan carlos', '2023-05-02', 123, 'defaults/6.png', 1),
	(26, 'pret@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'pret', 'pret', 'pret', '2023-05-08', 1234567, 'defaults/7.png', 1),
	(33, 'marco@gmail.com', '7c8ccc86c11654af029457d90fdd9d013ce6fb011ee8fdb1374832268cc8d967', 'marco', 'marco', 'marco', '2023-02-08', 6000000, 'defaults/6.png', 1);

-- Volcando estructura para vista bilboskpdb.suscriptoresenpartida
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `suscriptoresenpartida` (
	`alias` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nombreGrupo` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`nombre` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fechaInicio` DATETIME NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla bilboskpdb.suscriptor_partidaonline
CREATE TABLE IF NOT EXISTS `suscriptor_partidaonline` (
  `idSuscriptor` int(11) NOT NULL,
  `idPartidaonline` int(11) NOT NULL,
  KEY `idPartida` (`idPartidaonline`) USING BTREE,
  KEY `idSuscriptor` (`idSuscriptor`),
  CONSTRAINT `FK_suscriptor_partidaonline_partidaonline` FOREIGN KEY (`idPartidaonline`) REFERENCES `partidaonline` (`idPartida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_suscriptor_partidaonline_suscriptor` FOREIGN KEY (`idSuscriptor`) REFERENCES `suscriptor` (`idSuscriptor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla bilboskpdb.suscriptor_partidaonline: ~0 rows (aproximadamente)
DELETE FROM `suscriptor_partidaonline`;

-- Volcando estructura para vista bilboskpdb.rankingfisico
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `rankingfisico`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rankingfisico` AS (
	select idSala, sf.nombre as ‘sala’, nombreGrupo, puntaje, fechaInicio as  ‘fecha’ 
from partidafisica pf, salafisica sf
where pf.idSalaFisica=sf.idSala) ;

-- Volcando estructura para vista bilboskpdb.rankingonline
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `rankingonline`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `rankingonline` AS (
    SELECT idSala, so.nombre as 'sala jugada', nombreGrupo, puntaje , fechaInicio AS 'fecha'
    from partidaonline pao, salaonline so
    where  pao.idSalaOnline=so.idSala AND pao.visibleRanking=1 ORDER BY puntaje desc
	 ) ;

-- Volcando estructura para vista bilboskpdb.salas_mas_jugadas
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `salas_mas_jugadas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `salas_mas_jugadas` AS SELECT s.*, COUNT(p.idPartida) AS cantidad_partidas_jugadas FROM salaonline s LEFT JOIN partidaonline p ON s.idSala = p.idSalaOnline GROUP BY s.idSala ORDER BY cantidad_partidas_jugadas DESC ;

-- Volcando estructura para vista bilboskpdb.suscriptoresenpartida
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `suscriptoresenpartida`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `suscriptoresenpartida` AS (
	select alias, nombreGrupo, so.nombre, fechaInicio
	from suscriptor_partidaonline supao, suscriptor su, salaonline so, partidaonline po
    where supao.idSuscriptor=su.idSuscriptor and supao.idPartidaonline=po.idPartida and po.idSalaOnline=so.idSala) ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
