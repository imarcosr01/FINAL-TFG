-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: taller_informatica
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `id_alumno` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_clase` int DEFAULT NULL,
  `numero_identificacion` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE KEY `IDX_7b531713758a0929f530395112` (`numero_identificacion`),
  KEY `FK_88ab082d488dd481da8e83495f8` (`id_clase`),
  CONSTRAINT `FK_88ab082d488dd481da8e83495f8` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumnos_grupo`
--

DROP TABLE IF EXISTS `alumnos_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos_grupo` (
  `id_grupo` int NOT NULL,
  `id_alumno` int NOT NULL,
  PRIMARY KEY (`id_grupo`,`id_alumno`),
  KEY `FK_d0e3fd7690be28c40a6230d9544` (`id_alumno`),
  CONSTRAINT `FK_b9e31db7e0f599e8625885ac526` FOREIGN KEY (`id_grupo`) REFERENCES `grupos_trabajo` (`id_grupo`),
  CONSTRAINT `FK_d0e3fd7690be28c40a6230d9544` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorias_elementos`
--

DROP TABLE IF EXISTS `categorias_elementos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias_elementos` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `id_padre` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `IDX_eab37d4ced124a7f0093874b5f` (`nombre`),
  KEY `FK_1f900778fa544857cfc13e24cb5` (`id_padre`),
  CONSTRAINT `FK_1f900778fa544857cfc13e24cb5` FOREIGN KEY (`id_padre`) REFERENCES `categorias_elementos` (`id_categoria`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clase`
--

DROP TABLE IF EXISTS `clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clase` (
  `id_clase` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `curso_escolar` char(9) NOT NULL,
  PRIMARY KEY (`id_clase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clases`
--

DROP TABLE IF EXISTS `clases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clases` (
  `id_clase` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nombre` varchar(255) NOT NULL,
  `curso_escolar` char(9) NOT NULL,
  PRIMARY KEY (`id_clase`),
  UNIQUE KEY `IDX_d88a4c5d0f9f04123744e8a291` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementos`
--

DROP TABLE IF EXISTS `elementos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementos` (
  `id_elemento` int NOT NULL AUTO_INCREMENT,
  `codigo_qr` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `stock_total` int NOT NULL DEFAULT '0',
  `stock_disponible` int NOT NULL DEFAULT '0',
  `id_categoria` int NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id_elemento`),
  UNIQUE KEY `IDX_50bcf92515ed3f6288a78338de` (`codigo_qr`),
  KEY `FK_0bbb70fc2182e002ed7a2b944f3` (`id_categoria`),
  CONSTRAINT `FK_0bbb70fc2182e002ed7a2b944f3` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_elementos` (`id_categoria`) ON DELETE RESTRICT,
  CONSTRAINT `elementos_chk_1` CHECK ((`stock_total` >= 0)),
  CONSTRAINT `elementos_chk_2` CHECK ((`stock_disponible` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_trabajo`
--

DROP TABLE IF EXISTS `grupo_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_trabajo` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `id_clase` int DEFAULT NULL,
  `id_profesor` int DEFAULT NULL,
  PRIMARY KEY (`id_grupo`),
  KEY `FK_d74b2f26994ba65914e506d24f3` (`id_clase`),
  KEY `FK_69db38949ddb456b99f750c3450` (`id_profesor`),
  CONSTRAINT `FK_69db38949ddb456b99f750c3450` FOREIGN KEY (`id_profesor`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `FK_d74b2f26994ba65914e506d24f3` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupos_trabajo`
--

DROP TABLE IF EXISTS `grupos_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos_trabajo` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `id_profesor` int DEFAULT NULL,
  `id_clase` int DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id_grupo`),
  KEY `FK_3674da77b2f22627ef24a7352b9` (`id_clase`),
  KEY `FK_a499b5b2cd11b034ebd6a5f84b1` (`id_profesor`),
  CONSTRAINT `FK_3674da77b2f22627ef24a7352b9` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`),
  CONSTRAINT `FK_a499b5b2cd11b034ebd6a5f84b1` FOREIGN KEY (`id_profesor`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horarios_taller`
--

DROP TABLE IF EXISTS `horarios_taller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios_taller` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes') NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time GENERATED ALWAYS AS (addtime(`hora_inicio`,_utf8mb4'00:55:00')) STORED,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_horario`),
  UNIQUE KEY `dia_semana` (`dia_semana`,`hora_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=511 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencias` (
  `id_incidencia` int NOT NULL AUTO_INCREMENT,
  `descripcion` text NOT NULL,
  `solucionada` tinyint(1) DEFAULT '0',
  `id_profesor` int NOT NULL,
  `id_elemento` int NOT NULL,
  `id_clase` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_incidencia`),
  KEY `id_profesor` (`id_profesor`),
  KEY `id_elemento` (`id_elemento`),
  KEY `id_clase` (`id_clase`),
  CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidencias_ibfk_2` FOREIGN KEY (`id_elemento`) REFERENCES `elementos` (`id_elemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidencias_ibfk_3` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `fecha_prestamo` datetime DEFAULT CURRENT_TIMESTAMP,
  `devuelto` tinyint(1) DEFAULT '0',
  `id_profesor` int NOT NULL,
  `id_alumno` int DEFAULT NULL,
  `id_grupo` int DEFAULT NULL,
  `id_clase` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_prestamo`),
  KEY `id_profesor` (`id_profesor`),
  KEY `id_alumno` (`id_alumno`),
  KEY `id_grupo` (`id_grupo`),
  KEY `id_clase` (`id_clase`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `prestamos_ibfk_3` FOREIGN KEY (`id_grupo`) REFERENCES `grupos_trabajo` (`id_grupo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `prestamos_ibfk_4` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prestamos_elementos`
--

DROP TABLE IF EXISTS `prestamos_elementos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos_elementos` (
  `id_prestamo` int NOT NULL,
  `id_elemento` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_prestamo`,`id_elemento`),
  KEY `id_elemento` (`id_elemento`),
  CONSTRAINT `prestamos_elementos_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prestamos_elementos_ibfk_2` FOREIGN KEY (`id_elemento`) REFERENCES `elementos` (`id_elemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prestamos_elementos_chk_1` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `id_horario` int NOT NULL,
  `hora_fin` time GENERATED ALWAYS AS (addtime(`hora_inicio`,_utf8mb4'00:55:00')) STORED,
  `id_profesor` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `es_recurrente` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_reserva`),
  UNIQUE KEY `fecha` (`fecha`,`hora_inicio`),
  KEY `id_profesor` (`id_profesor`),
  KEY `id_horario` (`id_horario`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`id_horario`) REFERENCES `horarios_taller` (`id_horario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `rol` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rol` enum('administrador','profesor') NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `IDX_446adfc18b35418aac32ae0b7b` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-25 18:57:38
