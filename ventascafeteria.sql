-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2022 a las 10:53:50
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ventascafeteria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IDCategoria` int(11) NOT NULL,
  `Descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`IDCategoria`, `Descripcion`) VALUES
(1, 'Alimentos'),
(2, 'Bebidas'),
(3, 'Dulcería');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `IDPersona` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Cedula` varchar(50) DEFAULT NULL,
  `IdRol` int(5) DEFAULT NULL,
  `Celular` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`IDPersona`, `Nombre`, `Apellido`, `Cedula`, `IdRol`, `Celular`) VALUES
(1, 'Angela', 'Beltran', '1004006369', 1, 2147483647),
(2, 'Pilar', 'Beltran', '1004006368', 2, 2147483647);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IDProducto` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Referencia` varchar(50) NOT NULL,
  `Precio` double NOT NULL,
  `Peso` int(11) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `FechaCreacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`IDProducto`, `Nombre`, `Referencia`, `Precio`, `Peso`, `IdCategoria`, `Stock`, `FechaCreacion`) VALUES
(1, 'Pasteles', 'ABC132', 23000, 20, 1, 21, '2022-11-07 00:00:00'),
(3, 'Empanada', 'AS1321', 1300, 1, 1, 20, '2022-11-02 00:00:00'),
(4, 'Palito de queso', 'AS1321', 1500, 1, 1, 20, '2022-11-02 00:00:00'),
(5, 'Empanada', 'AS1321', 1300, 1, 1, 20, '2022-11-02 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IdRol` int(6) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IdRol`, `Descripcion`) VALUES
(1, 'Admin'),
(2, 'otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosistema`
--

CREATE TABLE `usuariosistema` (
  `IdUsuario` int(11) NOT NULL,
  `Idpersona` int(11) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Sesion` bit(2) NOT NULL,
  `Activo` bit(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuariosistema`
--

INSERT INTO `usuariosistema` (`IdUsuario`, `Idpersona`, `Usuario`, `Password`, `Sesion`, `Activo`) VALUES
(1, 1, 'angela', '81dc9bdb52d04dc20036dbd8313ed055', b'00', b'01'),
(2, 2, 'pilar', '81dc9bdb52d04dc20036dbd8313ed055', b'00', b'01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_token`
--

CREATE TABLE `usuarios_token` (
  `IdToken` int(11) NOT NULL,
  `UsuarioId` int(11) NOT NULL,
  `Token` varchar(250) NOT NULL,
  `Estado` int(11) NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios_token`
--

INSERT INTO `usuarios_token` (`IdToken`, `UsuarioId`, `Token`, `Estado`, `Fecha`) VALUES
(6, 1, '290b4caddca97b699ec3690b3c3bb883', 1, '2022-11-07 21:50:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `IdVenta` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `IdPersona` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `ValorVenta` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`IdVenta`, `IdProducto`, `IdPersona`, `Cantidad`, `ValorVenta`) VALUES
(1, 1, 1, 1, 2000);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IDCategoria`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`IDPersona`),
  ADD KEY `IdRol` (`IdRol`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IDProducto`),
  ADD KEY `IdCategoria` (`IdCategoria`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IdRol`);

--
-- Indices de la tabla `usuariosistema`
--
ALTER TABLE `usuariosistema`
  ADD PRIMARY KEY (`IdUsuario`),
  ADD KEY `Idpersona` (`Idpersona`);

--
-- Indices de la tabla `usuarios_token`
--
ALTER TABLE `usuarios_token`
  ADD PRIMARY KEY (`IdToken`),
  ADD KEY `UsuarioId` (`UsuarioId`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`IdVenta`),
  ADD KEY `IdProducto` (`IdProducto`),
  ADD KEY `IdPersona` (`IdPersona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IDCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `IDPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IDProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `IdRol` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuariosistema`
--
ALTER TABLE `usuariosistema`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios_token`
--
ALTER TABLE `usuarios_token`
  MODIFY `IdToken` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categoria` (`IDCategoria`);

--
-- Filtros para la tabla `usuariosistema`
--
ALTER TABLE `usuariosistema`
  ADD CONSTRAINT `usuariosistema_ibfk_1` FOREIGN KEY (`Idpersona`) REFERENCES `persona` (`IDPersona`);

--
-- Filtros para la tabla `usuarios_token`
--
ALTER TABLE `usuarios_token`
  ADD CONSTRAINT `usuarios_token_ibfk_1` FOREIGN KEY (`UsuarioId`) REFERENCES `usuariosistema` (`IdUsuario`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IDProducto`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`IdPersona`) REFERENCES `persona` (`IDPersona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
