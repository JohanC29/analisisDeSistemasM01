-- Creación de tablas básicas sin dependencias
CREATE TABLE FACULTAD (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE JORNADA (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE SEMESTRE (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL
);

CREATE TABLE PROFESOR (
  `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `cedula` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL
);

CREATE TABLE SALA (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL
);

-- Creación de tablas con dependencias 
CREATE TABLE PROGRAMA (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL,
  idfacultad INT NOT NULL,
  FOREIGN KEY (idfacultad) REFERENCES FACULTAD(id)
);

CREATE TABLE CURSO (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL,
  idprograma INT NOT NULL,
  FOREIGN KEY (idprograma) REFERENCES PROGRAMA(id)
);

CREATE TABLE ESTUDIANTE (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `documento` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `idprograma` int(11) NOT NULL,
  `idsemestre` int(11) NOT NULL,
  `idjornada` int(11) NOT NULL,
  `estado` varchar(255) NOT NULL,
  FOREIGN KEY (idprograma) REFERENCES PROGRAMA(id),
  FOREIGN KEY (idsemestre) REFERENCES SEMESTRE(id),
  FOREIGN KEY (idjornada) REFERENCES JORNADA(id)
);

CREATE TABLE INVITADO (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `identificacion` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `idprograma` int(11) NOT NULL,
  FOREIGN KEY (idprograma) REFERENCES PROGRAMA(id)
);

CREATE TABLE EQUIPO (
  id INT PRIMARY KEY AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `idsala` int(11) DEFAULT NULL,
  FOREIGN KEY (idsala) REFERENCES SALA(id)
);

CREATE TABLE REGISTROSALA (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `idprofesor` int(11) NOT NULL,
  `fechainicial` DATETIME NOT NULL,
  `fechafinal` DATETIME NOT NULL,
  `idfacultad` int(11) NOT NULL,
  `idcurso` int(11) NOT NULL,
  idsala int(11) not null,
  fechacreacion not null DATETIME DEFAULT NOW(),
  FOREIGN KEY (idprofesor) REFERENCES PROFESOR(id),
  FOREIGN KEY (idfacultad) REFERENCES FACULTAD(id),
  FOREIGN KEY (idcurso) REFERENCES CURSO(id),
  FOREIGN KEY (idsala) REFERENCES SALA(id)
);

CREATE TABLE REGISTROESTUDIANTE (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `idregistrosala` int(11) NOT NULL,
  `idestudiante` int(11) DEFAULT NULL,
  `idequipo` int(11) DEFAULT NULL,
  `idinvitado` int(11) DEFAULT NULL,
  fechacreacion DATETIME DEFAULT NOW(),
  FOREIGN KEY (idregistrosala) REFERENCES REGISTROSALA(id),
  FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(id),
  FOREIGN KEY (idequipo) REFERENCES EQUIPO(id),
  FOREIGN KEY (idinvitado) REFERENCES INVITADO(id)
);

--- Tablas modulo de protatiles 
CREATE TABLE dependencia (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL
);

CREATE TABLE ubicacion (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL
);

CREATE TABLE funcionario (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `documento` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `iddependencia` int(11) NOT NULL,
  `estado` varchar(255) NOT NULL,
  FOREIGN KEY (iddependencia) REFERENCES dependencia(id)
);

CREATE TABLE usuariolistanegra (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `idfuncionario` int(11),
  `idestudiante` int(11) DEFAULT NULL,
  `idprofesor` int(11) DEFAULT NULL,
  fechacreacion DATETIME DEFAULT NOW(),
  FOREIGN KEY (idfuncionario) REFERENCES funcionario(id),
  FOREIGN KEY (idestudiante) REFERENCES estudiante(id),
  FOREIGN KEY (idprofesor) REFERENCES profesor(id)
);

CREATE TABLE registroportatil (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `idfuncionario` int(11) ,
  `idestudiante` int(11) DEFAULT NULL,
  `idprofesor` int(11) DEFAULT NULL,
  celular varchar(255) not null,
  fechasolicitud DATETIME not null DEFAULT NOW(),
  `idequipo` int(11) DEFAULT NULL,
  usuarioasigna varchar(255),
  fechaasigna DATETIME,
  fecharegreso DATETIME,
  FOREIGN KEY (idequipo) REFERENCES equipo(id),
  FOREIGN KEY (idfuncionario) REFERENCES funcionario(id),
  FOREIGN KEY (idestudiante) REFERENCES estudiante(id),
  FOREIGN KEY (idprofesor) REFERENCES profesor(id)
);