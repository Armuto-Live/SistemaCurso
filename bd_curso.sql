-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-12-2022 a las 16:29:39
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_curso`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_COMBO_ROL` ()   SELECT
rol.rol_id,
rol.rol_nombre
FROM
rol$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_USUARIO` ()   BEGIN
DECLARE CANTIDAD int;
SET @CANTIDAD:=0;
SELECT
	@CANTIDAD:=@CANTIDAD+1 AS posicion ,
	usuario.usu_id,
    usuario.usu_nombre,
    usuario.usu_sexo,
    usuario.rol_id,
    usuario.usu_estatus,
    rol.rol_nombre
FROM
usuario
INNER JOIN rol ON usuario.rol_id=rol.rol_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESTATUS_USUARIO` (IN `IDUSUARIO` INT, IN `ESTATUS` VARCHAR(20))   UPDATE usuario SET
usuario.usu_estatus=ESTATUS
WHERE usuario.usu_id=IDUSUARIO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USUARIO` (IN `USU` VARCHAR(20), IN `CONTRA` VARCHAR(250), IN `SEXO` CHAR(1), IN `ROL` INT)   BEGIN
 DECLARE CANTIDAD INT;
 SET @CANTIDAD:=(SELECT COUNT(*) FROM usuario WHERE usuario.usu_nombre=BINARY USU);
 IF @CANTIDAD=0 THEN
 	INSERT INTO usuario(usuario.usu_nombre,usuario.usu_contrasena,usuario.usu_sexo,usuario.rol_id,usuario.usu_estatus) VALUES (USU,CONTRA,SEXO,ROL,'ACTIVO');
    SELECT 1;
 ELSE
 	SELECT 2;
 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VERIFICAR_USUARIO` (IN `USUARIO` VARCHAR(20))   SELECT 
usuario.usu_id,
usuario.usu_nombre,
usuario.usu_contrasena,
usuario.usu_sexo,
usuario.rol_id,
usuario.usu_estatus,
rol.rol_nombre
FROM
usuario
INNER JOIN rol ON usuario.rol_id=rol.rol_id
WHERE usuario.usu_nombre= BINARY USUARIO$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(38) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'INVITADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nombre` varchar(20) NOT NULL,
  `usu_contrasena` varchar(255) NOT NULL,
  `usu_sexo` char(1) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `usu_estatus` enum('ACTIVO','INACTIVO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `usu_nombre`, `usu_contrasena`, `usu_sexo`, `rol_id`, `usu_estatus`) VALUES
(1, 'curso', '$2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G', 'M', 1, 'ACTIVO'),
(158, 'prueba', '$2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G', 'M', 2, 'INACTIVO'),
(159, 'hit', '$2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G', 'M', 1, 'INACTIVO'),
(160, 'armuto', '$2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G', 'M', 1, 'ACTIVO'),
(161, 'test', '$2y$10$ZZxbxvXG7lARZWOBj5G2heOo4wkhgn2brciWYDgz2tVz56wDgSIvi', 'M', 2, 'ACTIVO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
