-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2023 a las 16:19:54
-- Versión del servidor: 8.2.0
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CURSO`
--

CREATE TABLE `CURSO` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `idprograma` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `CURSO`
--

INSERT INTO `CURSO` (`id`, `descripcion`, `idprograma`) VALUES
(1, 'ALGORITMIA', 1),
(2, 'ANALISIS DE SISTEMAS', 1),
(3, 'MATERIALES Y PROCESOS', 2),
(4, 'TERMODINAMICA', 2),
(5, 'DOGMATICA JURIDICA', 3),
(6, 'PDICOBIOLOGIA', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `EQUIPO`
--

CREATE TABLE `EQUIPO` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `idsala` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `EQUIPO`
--

INSERT INTO `EQUIPO` (`id`, `descripcion`, `idsala`) VALUES
(1, 'EQUIPO 01', 1),
(2, 'EQUIPO 02', 1),
(3, 'EQUIPO 03', 2),
(4, 'EQUIPO 04', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ESTUDIANTE`
--

CREATE TABLE `ESTUDIANTE` (
  `id` int NOT NULL,
  `documento` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `idprograma` int NOT NULL,
  `idsemestre` int NOT NULL,
  `idjornada` int NOT NULL,
  `estado` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `ESTUDIANTE`
--

INSERT INTO `ESTUDIANTE` (`id`, `documento`, `nombre`, `apellido`, `idprograma`, `idsemestre`, `idjornada`, `estado`) VALUES
(1, '1010107814', 'JOHAN CAMILO', 'MUELAS VERAZA', 1, 2, 3, 'ACTIVO'),
(2, '111222333', 'GABRIEL', 'CARDONA', 1, 2, 3, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `FACULTAD`
--

CREATE TABLE `FACULTAD` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `FACULTAD`
--

INSERT INTO `FACULTAD` (`id`, `descripcion`) VALUES
(1, 'INGENIERIA'),
(2, 'DERECHO'),
(3, 'PSICOLOGIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `INVITADO`
--

CREATE TABLE `INVITADO` (
  `id` int NOT NULL,
  `identificacion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `idprograma` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JORNADA`
--

CREATE TABLE `JORNADA` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `JORNADA`
--

INSERT INTO `JORNADA` (`id`, `descripcion`) VALUES
(1, 'DIURNA'),
(2, 'NOCTURNA'),
(3, 'MIXTA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PROFESOR`
--

CREATE TABLE `PROFESOR` (
  `id` int NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `cedula` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `PROFESOR`
--

INSERT INTO `PROFESOR` (`id`, `nombre`, `apellido`, `cedula`, `estado`) VALUES
(1, 'VICTOR', 'MOSQUERA', '123456789', 'ACTIVO'),
(2, 'JORGE', 'PINCAY', '123123123', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PROGRAMA`
--

CREATE TABLE `PROGRAMA` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `idfacultad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `PROGRAMA`
--

INSERT INTO `PROGRAMA` (`id`, `descripcion`, `idfacultad`) VALUES
(1, 'INGENIERIA DE SISTEMAS', 1),
(2, 'INGENIERIA INDUSTRIAL', 1),
(3, 'DERECHO', 2),
(4, 'PSICOLOGIA', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `REGISTROESTUDIANTE`
--

CREATE TABLE `REGISTROESTUDIANTE` (
  `id` int NOT NULL,
  `idregistrosala` int NOT NULL,
  `idestudiante` int DEFAULT NULL,
  `idequipo` int DEFAULT NULL,
  `idinvitado` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `REGISTROSALA`
--

CREATE TABLE `REGISTROSALA` (
  `id` int NOT NULL,
  `idprofesor` int NOT NULL,
  `fechainicial` date NOT NULL,
  `fechafinal` date NOT NULL,
  `idfacultad` int NOT NULL,
  `idcurso` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SALA`
--

CREATE TABLE `SALA` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `SALA`
--

INSERT INTO `SALA` (`id`, `descripcion`) VALUES
(1, 'SALA 01'),
(2, 'SALA 02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SEMESTRE`
--

CREATE TABLE `SEMESTRE` (
  `id` int NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `SEMESTRE`
--

INSERT INTO `SEMESTRE` (`id`, `descripcion`, `estado`) VALUES
(1, 'I', 'ACTIVO'),
(2, 'II', 'ACTIVO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `CURSO`
--
ALTER TABLE `CURSO`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idprograma` (`idprograma`);

--
-- Indices de la tabla `EQUIPO`
--
ALTER TABLE `EQUIPO`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idsala` (`idsala`);

--
-- Indices de la tabla `ESTUDIANTE`
--
ALTER TABLE `ESTUDIANTE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idprograma` (`idprograma`),
  ADD KEY `idsemestre` (`idsemestre`),
  ADD KEY `idjornada` (`idjornada`);

--
-- Indices de la tabla `FACULTAD`
--
ALTER TABLE `FACULTAD`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `INVITADO`
--
ALTER TABLE `INVITADO`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idprograma` (`idprograma`);

--
-- Indices de la tabla `JORNADA`
--
ALTER TABLE `JORNADA`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `PROFESOR`
--
ALTER TABLE `PROFESOR`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `PROGRAMA`
--
ALTER TABLE `PROGRAMA`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idfacultad` (`idfacultad`);

--
-- Indices de la tabla `REGISTROESTUDIANTE`
--
ALTER TABLE `REGISTROESTUDIANTE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idregistrosala` (`idregistrosala`),
  ADD KEY `idestudiante` (`idestudiante`),
  ADD KEY `idequipo` (`idequipo`),
  ADD KEY `idinvitado` (`idinvitado`);

--
-- Indices de la tabla `REGISTROSALA`
--
ALTER TABLE `REGISTROSALA`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idprofesor` (`idprofesor`),
  ADD KEY `idfacultad` (`idfacultad`),
  ADD KEY `idcurso` (`idcurso`);

--
-- Indices de la tabla `SALA`
--
ALTER TABLE `SALA`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `SEMESTRE`
--
ALTER TABLE `SEMESTRE`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `CURSO`
--
ALTER TABLE `CURSO`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `FACULTAD`
--
ALTER TABLE `FACULTAD`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `JORNADA`
--
ALTER TABLE `JORNADA`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `PROFESOR`
--
ALTER TABLE `PROFESOR`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `PROGRAMA`
--
ALTER TABLE `PROGRAMA`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `SALA`
--
ALTER TABLE `SALA`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `SEMESTRE`
--
ALTER TABLE `SEMESTRE`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `CURSO`
--
ALTER TABLE `CURSO`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`idprograma`) REFERENCES `PROGRAMA` (`id`);

--
-- Filtros para la tabla `EQUIPO`
--
ALTER TABLE `EQUIPO`
  ADD CONSTRAINT `equipo_ibfk_1` FOREIGN KEY (`idsala`) REFERENCES `SALA` (`id`);

--
-- Filtros para la tabla `ESTUDIANTE`
--
ALTER TABLE `ESTUDIANTE`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`idprograma`) REFERENCES `PROGRAMA` (`id`),
  ADD CONSTRAINT `estudiante_ibfk_2` FOREIGN KEY (`idsemestre`) REFERENCES `SEMESTRE` (`id`),
  ADD CONSTRAINT `estudiante_ibfk_3` FOREIGN KEY (`idjornada`) REFERENCES `JORNADA` (`id`);

--
-- Filtros para la tabla `INVITADO`
--
ALTER TABLE `INVITADO`
  ADD CONSTRAINT `invitado_ibfk_1` FOREIGN KEY (`idprograma`) REFERENCES `PROGRAMA` (`id`);

--
-- Filtros para la tabla `PROGRAMA`
--
ALTER TABLE `PROGRAMA`
  ADD CONSTRAINT `programa_ibfk_1` FOREIGN KEY (`idfacultad`) REFERENCES `FACULTAD` (`id`);

--
-- Filtros para la tabla `REGISTROESTUDIANTE`
--
ALTER TABLE `REGISTROESTUDIANTE`
  ADD CONSTRAINT `registroestudiante_ibfk_1` FOREIGN KEY (`idregistrosala`) REFERENCES `REGISTROSALA` (`id`),
  ADD CONSTRAINT `registroestudiante_ibfk_2` FOREIGN KEY (`idestudiante`) REFERENCES `ESTUDIANTE` (`id`),
  ADD CONSTRAINT `registroestudiante_ibfk_3` FOREIGN KEY (`idequipo`) REFERENCES `EQUIPO` (`id`),
  ADD CONSTRAINT `registroestudiante_ibfk_4` FOREIGN KEY (`idinvitado`) REFERENCES `INVITADO` (`id`);

--
-- Filtros para la tabla `REGISTROSALA`
--
ALTER TABLE `REGISTROSALA`
  ADD CONSTRAINT `registrosala_ibfk_1` FOREIGN KEY (`idprofesor`) REFERENCES `PROFESOR` (`id`),
  ADD CONSTRAINT `registrosala_ibfk_2` FOREIGN KEY (`idfacultad`) REFERENCES `FACULTAD` (`id`),
  ADD CONSTRAINT `registrosala_ibfk_3` FOREIGN KEY (`idcurso`) REFERENCES `CURSO` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
