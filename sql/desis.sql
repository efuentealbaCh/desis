-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-01-2026 a las 19:04:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `desis`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodega`
--

CREATE TABLE `bodega` (
  `bode_codigo` int(11) NOT NULL,
  `bode_nombre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bodega`
--

INSERT INTO `bodega` (`bode_codigo`, `bode_nombre`) VALUES
(1, 'Bodega Santiago'),
(2, 'Bodega Temuco');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `mate_codigo` int(11) NOT NULL,
  `mate_nombre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`mate_codigo`, `mate_nombre`) VALUES
(1, 'Plástico'),
(2, 'Metal'),
(3, 'Madera'),
(4, 'Vidrio'),
(5, 'Textil');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `mone_codigo` int(11) NOT NULL,
  `mone_nombre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`mone_codigo`, `mone_nombre`) VALUES
(1, 'Dolares'),
(2, 'CLP'),
(3, 'Euros'),
(4, 'Reales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prod_codigo` varchar(15) NOT NULL,
  `mone_codigo` int(11) NOT NULL,
  `prod_nombre` varchar(50) NOT NULL,
  `prod_precio` decimal(10,0) NOT NULL,
  `prod_material` varchar(500) NOT NULL,
  `prod_descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_materiales`
--

CREATE TABLE `producto_materiales` (
  `prod_codigo` varchar(15) NOT NULL,
  `mate_codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `sucu_codigo` int(11) NOT NULL,
  `bode_codigo` int(11) NOT NULL,
  `sucu_nombre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`sucu_codigo`, `bode_codigo`, `sucu_nombre`) VALUES
(1, 1, 'Sucursal Santiago Centro'),
(2, 1, 'Sucursal Providencia'),
(3, 2, 'Sucursal Fundo del Carmen'),
(4, 2, 'Sucursal Padre la casas');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD PRIMARY KEY (`bode_codigo`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`mate_codigo`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`mone_codigo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prod_codigo`),
  ADD KEY `mone_codigo` (`mone_codigo`);

--
-- Indices de la tabla `producto_materiales`
--
ALTER TABLE `producto_materiales`
  ADD KEY `prod_codigo` (`prod_codigo`),
  ADD KEY `mate_codigo` (`mate_codigo`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`sucu_codigo`),
  ADD KEY `bode_codigo` (`bode_codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bodega`
--
ALTER TABLE `bodega`
  MODIFY `bode_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `mate_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `mone_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `sucu_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`mone_codigo`) REFERENCES `moneda` (`mone_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto_materiales`
--
ALTER TABLE `producto_materiales`
  ADD CONSTRAINT `producto_materiales_ibfk_1` FOREIGN KEY (`mate_codigo`) REFERENCES `materiales` (`mate_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_materiales_ibfk_2` FOREIGN KEY (`prod_codigo`) REFERENCES `producto` (`prod_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `sucursal_ibfk_1` FOREIGN KEY (`bode_codigo`) REFERENCES `bodega` (`bode_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
