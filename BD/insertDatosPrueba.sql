INSERT INTO `facultad` (`id`, `descripcion`) VALUES
(1, 'INGENIERIA'),
(2, 'DERECHO'),
(3, 'PSICOLOGIA');

INSERT INTO `jornada` (`id`, `descripcion`) VALUES
(1, 'DIURNA'),
(2, 'NOCTURNA'),
(3, 'MIXTA');

INSERT INTO `semestre` (`id`, `descripcion`, `estado`) VALUES
(1, 'I', 'ACTIVO'),
(2, 'II', 'ACTIVO');

INSERT INTO `profesor` (`id`, `nombre`, `apellido`, `cedula`, `estado`) VALUES
(1, 'VICTOR', 'MOSQUERA', '123456789', 'ACTIVO'),
(2, 'JORGE', 'PINCAY', '123123123', 'ACTIVO');

INSERT INTO `sala` (`id`, `descripcion`) VALUES
(1, 'SALA 01'),
(2, 'SALA 02');

INSERT INTO `programa` (`id`, `descripcion`, `idfacultad`) VALUES
(1, 'INGENIERIA DE SISTEMAS', 1),
(2, 'INGENIERIA INDUSTRIAL', 1),
(3, 'DERECHO', 2),
(4, 'PSICOLOGIA', 3);

INSERT INTO `curso` (`id`, `descripcion`, `idprograma`) VALUES
(1, 'ALGORITMIA', 1),
(2, 'ANALISIS DE SISTEMAS', 1),
(3, 'MATERIALES Y PROCESOS', 2),
(4, 'TERMODINAMICA', 2),
(5, 'DOGMATICA JURIDICA', 3),
(6, 'PDICOBIOLOGIA', 4);

INSERT INTO `equipo` (`id`, `descripcion`, `idsala`) VALUES
(1, 'EQUIPO 01', 1),
(2, 'EQUIPO 02', 1),
(3, 'EQUIPO 03', 2),
(4, 'EQUIPO 04', 2);

INSERT INTO `estudiante` (`id`, `documento`, `nombre`, `apellido`, `idprograma`, `idsemestre`, `idjornada`, `estado`) VALUES
(1, '1010107814', 'JOHAN CAMILO', 'MUELAS VERAZA', 1, 2, 3, 'ACTIVO'),
(2, '111222333', 'GABRIEL', 'CARDONA', 1, 2, 3, 'ACTIVO');









