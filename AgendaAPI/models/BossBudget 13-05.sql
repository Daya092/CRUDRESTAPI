-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: bossbudget
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `creditos`
--

DROP TABLE IF EXISTS `creditos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditos` (
  `idCreditos` int NOT NULL,
  `idPresupuesto` int NOT NULL,
  `RangoInicial` date DEFAULT NULL,
  `RangoFinal` date DEFAULT NULL,
  `MontoTotal` decimal(10,0) DEFAULT NULL,
  `idTipoDeCredito` int NOT NULL,
  PRIMARY KEY (`idCreditos`),
  KEY `idPresupuesto` (`idPresupuesto`),
  KEY `idTipoDeCredito` (`idTipoDeCredito`),
  CONSTRAINT `creditos_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`),
  CONSTRAINT `creditos_ibfk_2` FOREIGN KEY (`idTipoDeCredito`) REFERENCES `tipodecredito` (`idTipoDeCredito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditos`
--

LOCK TABLES `creditos` WRITE;
/*!40000 ALTER TABLE `creditos` DISABLE KEYS */;
INSERT INTO `creditos` VALUES (1,1,'2021-03-07','2025-01-01',5000,1),(2,2,'2020-12-06','2026-02-01',10000,2),(3,3,'2023-08-05','2027-03-01',7500,3),(4,4,'2018-09-04','2028-04-01',12500,4),(5,5,'2003-07-03','2029-05-01',15000,5),(6,6,'2021-05-02','2030-06-01',17500,6),(7,7,'2019-01-01','2031-07-01',20000,7);
/*!40000 ALTER TABLE `creditos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas` (
  `idCuentas` int NOT NULL,
  `Banco` text,
  `Monto` decimal(10,0) DEFAULT NULL,
  `idPresupuesto` int NOT NULL,
  PRIMARY KEY (`idCuentas`),
  KEY `idPresupuesto` (`idPresupuesto`),
  CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES (1,'Banco A',5000,1),(2,'Banco B',10000,2),(3,'Banco C',15000,3),(4,'Banco D',20000,4),(5,'Banco E',25000,5),(6,'Banco F',30000,6),(7,'Banco G',35000,7);
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallepresupuesto`
--

DROP TABLE IF EXISTS `detallepresupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallepresupuesto` (
  `idPresupuesto` int DEFAULT NULL,
  `categoria` enum('Casa','Comida','Trabajo','Otros') NOT NULL,
  `tipo_movimiento` enum('Ingreso','Gasto') NOT NULL,
  `destino` enum('presupuestado','real') NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  KEY `idPresupuesto` (`idPresupuesto`),
  CONSTRAINT `detallepresupuesto_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallepresupuesto`
--

LOCK TABLES `detallepresupuesto` WRITE;
/*!40000 ALTER TABLE `detallepresupuesto` DISABLE KEYS */;
/*!40000 ALTER TABLE `detallepresupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gastos`
--

DROP TABLE IF EXISTS `gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gastos` (
  `idGastos` int NOT NULL,
  `idPresupuesto` int NOT NULL,
  `FechaDeRegistro` date DEFAULT NULL,
  `Monto` decimal(10,0) DEFAULT NULL,
  `TipoDeMonto` enum('Efectivo','Tarjeta Debito','Tarjeta credito','Cheque','Billeteras virtuales') DEFAULT NULL,
  PRIMARY KEY (`idGastos`),
  KEY `idPresupuesto` (`idPresupuesto`),
  CONSTRAINT `gastos_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastos`
--

LOCK TABLES `gastos` WRITE;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
INSERT INTO `gastos` VALUES (1,1,'2021-01-02',8441,'Efectivo'),(2,2,'2022-02-04',98754,'Tarjeta credito'),(3,3,'2023-03-06',56487,'Cheque'),(4,4,'2024-04-08',454874,'Cheque'),(5,5,'2025-05-10',198783,'Efectivo'),(6,6,'2026-06-12',457774,'Billeteras virtuales'),(7,7,'2027-07-14',56330,'Cheque');
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos`
--

DROP TABLE IF EXISTS `ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresos` (
  `idIngresos` int NOT NULL,
  `idPresupuesto` int NOT NULL,
  `FechaDeRegistro` date DEFAULT NULL,
  `Monto` decimal(10,0) DEFAULT NULL,
  `TipoDeMonto` enum('Efectivo','Tarjeta Debito','Tarjeta credito','Cheque','Billeteras virtuales') DEFAULT NULL,
  PRIMARY KEY (`idIngresos`),
  KEY `idPresupuesto` (`idPresupuesto`),
  CONSTRAINT `ingresos_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresos`
--

LOCK TABLES `ingresos` WRITE;
/*!40000 ALTER TABLE `ingresos` DISABLE KEYS */;
INSERT INTO `ingresos` VALUES (1,1,'2021-01-02',465451,'Efectivo'),(2,2,'2022-02-04',8971,'Tarjeta credito'),(3,3,'2023-03-06',5477,'Cheque'),(4,4,'2024-04-08',97000,'Efectivo'),(5,5,'2025-05-10',14547,'Cheque'),(6,6,'2026-06-12',99700,'Billeteras virtuales'),(7,7,'2027-07-14',3421,'Tarjeta credito');
/*!40000 ALTER TABLE `ingresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagodecredito`
--

DROP TABLE IF EXISTS `pagodecredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagodecredito` (
  `idPagoDeCredito` int NOT NULL,
  `TipoDePago` varchar(50) DEFAULT NULL,
  `idCreditos` int NOT NULL,
  `AccionRealizada` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPagoDeCredito`),
  KEY `idCreditos` (`idCreditos`),
  CONSTRAINT `pagodecredito_ibfk_1` FOREIGN KEY (`idCreditos`) REFERENCES `creditos` (`idCreditos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagodecredito`
--

LOCK TABLES `pagodecredito` WRITE;
/*!40000 ALTER TABLE `pagodecredito` DISABLE KEYS */;
INSERT INTO `pagodecredito` VALUES (1,'Efectivo',1,NULL),(2,'Tarjeta débito',2,NULL),(3,'Efectivo',3,NULL),(4,'Tarjeta crédito',4,NULL),(5,'Cheque',5,NULL),(6,'Cheque',6,NULL),(7,'Tarjeta crédito',7,NULL);
/*!40000 ALTER TABLE `pagodecredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presupuesto`
--

DROP TABLE IF EXISTS `presupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presupuesto` (
  `idPresupuesto` int NOT NULL,
  `Fecha` date DEFAULT NULL,
  `idTipoPresupuesto` int NOT NULL,
  `Dinero` decimal(10,0) DEFAULT NULL,
  `Ahorros` decimal(10,0) DEFAULT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  PRIMARY KEY (`idPresupuesto`),
  KEY `idTipoPresupuesto` (`idTipoPresupuesto`),
  KEY `NombreUsuario` (`NombreUsuario`),
  CONSTRAINT `presupuesto_ibfk_2` FOREIGN KEY (`idTipoPresupuesto`) REFERENCES `tipopresupuesto` (`idTipoPresupuesto`),
  CONSTRAINT `presupuesto_ibfk_3` FOREIGN KEY (`NombreUsuario`) REFERENCES `usuario` (`NombreUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presupuesto`
--

LOCK TABLES `presupuesto` WRITE;
/*!40000 ALTER TABLE `presupuesto` DISABLE KEYS */;
INSERT INTO `presupuesto` VALUES (1,'2024-01-01',1,10000,5000,'jpérez1010101'),(2,'2024-02-01',2,20000,10000,'agarcía2020202'),(3,'2024-03-01',3,15000,7500,'lmartínez3030303'),(4,'2024-04-01',4,25000,12500,'mrodríguez4040404'),(5,'2024-05-01',5,30000,15000,'phernández5050505'),(6,'2024-06-01',6,35000,17500,'llópez6060606'),(7,'2024-07-01',7,40000,20000,'csánchez7070707');
/*!40000 ALTER TABLE `presupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recordatorios`
--

DROP TABLE IF EXISTS `recordatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recordatorios` (
  `idRecordatorios` int NOT NULL,
  `Comentario` varchar(120) DEFAULT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  PRIMARY KEY (`idRecordatorios`),
  KEY `NombreUsuario` (`NombreUsuario`),
  CONSTRAINT `recordatorios_ibfk_1` FOREIGN KEY (`NombreUsuario`) REFERENCES `usuario` (`NombreUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recordatorios`
--

LOCK TABLES `recordatorios` WRITE;
/*!40000 ALTER TABLE `recordatorios` DISABLE KEYS */;
INSERT INTO `recordatorios` VALUES (1,'Pagar tarjeta de crédito','jpérez1010101'),(2,'Renovar seguro de vida','agarcía2020202'),(3,'Agendar cita médica','lmartínez3030303'),(4,'Revisar estado de cuenta','mrodríguez4040404'),(5,'Comprar regalos de cumpleaños','phernández5050505'),(6,'Preparar documentos de impuestos','llópez6060606'),(7,'Renovar licencia de conducir','csánchez7070707');
/*!40000 ALTER TABLE `recordatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefonos`
--

DROP TABLE IF EXISTS `telefonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefonos` (
  `idTelefono` int NOT NULL,
  `Numero` varchar(15) DEFAULT NULL,
  `NombreUsuario` varchar(50) NOT NULL,
  PRIMARY KEY (`idTelefono`),
  KEY `NombreUsuario` (`NombreUsuario`),
  CONSTRAINT `telefonos_ibfk_1` FOREIGN KEY (`NombreUsuario`) REFERENCES `usuario` (`NombreUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefonos`
--

LOCK TABLES `telefonos` WRITE;
/*!40000 ALTER TABLE `telefonos` DISABLE KEYS */;
INSERT INTO `telefonos` VALUES (1,'3278945610','jpérez1010101'),(2,'3105478798','agarcía2020202'),(3,'3011554879','lmartínez3030303'),(4,'3099889784','mrodríguez4040404'),(5,'3009745221','phernández5050505'),(6,'3053041187','llópez6060606'),(7,'3105449284','csánchez7070707');
/*!40000 ALTER TABLE `telefonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipodecredito`
--

DROP TABLE IF EXISTS `tipodecredito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipodecredito` (
  `idTipoDeCredito` int NOT NULL,
  `TipoDeCredito` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTipoDeCredito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipodecredito`
--

LOCK TABLES `tipodecredito` WRITE;
/*!40000 ALTER TABLE `tipodecredito` DISABLE KEYS */;
INSERT INTO `tipodecredito` VALUES (1,'Hipotecario'),(2,'Automotriz'),(3,'Personal'),(4,'Educativo'),(5,'Comercial'),(6,'Agrícola'),(7,'Turístico');
/*!40000 ALTER TABLE `tipodecredito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopresupuesto`
--

DROP TABLE IF EXISTS `tipopresupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipopresupuesto` (
  `idTipoPresupuesto` int NOT NULL,
  `TipoDePresupuesto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTipoPresupuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopresupuesto`
--

LOCK TABLES `tipopresupuesto` WRITE;
/*!40000 ALTER TABLE `tipopresupuesto` DISABLE KEYS */;
INSERT INTO `tipopresupuesto` VALUES (1,'Anual'),(2,'Mensual'),(3,'Quincenal'),(4,'Semanal'),(5,'Diario'),(6,'Proyecto'),(7,'Emergencia');
/*!40000 ALTER TABLE `tipopresupuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposderecordatorios`
--

DROP TABLE IF EXISTS `tiposderecordatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposderecordatorios` (
  `idTiposDeRecordatorios` int NOT NULL,
  `TipoDeRecordatorio` varchar(50) DEFAULT NULL,
  `idRecordatorios` int NOT NULL,
  PRIMARY KEY (`idTiposDeRecordatorios`),
  KEY `idRecordatorios` (`idRecordatorios`),
  CONSTRAINT `tiposderecordatorios_ibfk_1` FOREIGN KEY (`idRecordatorios`) REFERENCES `recordatorios` (`idRecordatorios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposderecordatorios`
--

LOCK TABLES `tiposderecordatorios` WRITE;
/*!40000 ALTER TABLE `tiposderecordatorios` DISABLE KEYS */;
INSERT INTO `tiposderecordatorios` VALUES (1,'Pago',1),(2,'Renovación',2),(3,'Salud',3),(4,'Revisión',4),(5,'Compra',5),(6,'Documentación',6),(7,'Licencia',7);
/*!40000 ALTER TABLE `tiposderecordatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Correo` varchar(120) NOT NULL,
  `Nombres` varchar(70) DEFAULT NULL,
  `Apellidos` varchar(70) DEFAULT NULL,
  `Contraseña` varchar(60) NOT NULL,
  `Profesion` varchar(40) DEFAULT NULL,
  `FechaDeNacimiento` date DEFAULT NULL,
  `Expectativas` text,
  `NombreUsuario` varchar(50) NOT NULL,
  `Foto` blob,
  `rol` enum('admi','userN') NOT NULL DEFAULT 'userN',
  PRIMARY KEY (`Correo`),
  UNIQUE KEY `NombreUsuario` (`NombreUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('ana.garcia@mail.com','Ana','García','abcdef','Abogada','1985-07-22','Crecimiento profesional','agarcía2020202',NULL,'userN'),('carlos.sanchez@mail.com','Carlos','Sánchez','654321','Profesor','1988-12-25','Educación continua','csánchez7070707',NULL,'userN'),('juan.perez@mail.com','Juan','Pérez','123456','Ingeniero','1980-05-10','Superación personal','jpérez1010101',NULL,'userN'),('lucia.lopez@mail.com','Lucía','López','pass123','Diseñadora','1982-09-09','Desarrollo personal','llópez6060606',NULL,'admi'),('luis.martinez@mail.com','Luis','Martínez','password','Doctor','1978-03-15','Estabilidad económica','lmartínez3030303',NULL,'userN'),('marta.rodriguez@mail.com','Marta','Rodríguez','qwerty','Contadora','1990-01-05','Viajar por el mundo','mrodríguez4040404',NULL,'admi'),('pedro.hernandez@mail.com','Pedro','Hernández','123abc','Arquitecto','1975-11-30','Innovación en su campo','phernández5050505',NULL,'userN');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-13 15:20:16
