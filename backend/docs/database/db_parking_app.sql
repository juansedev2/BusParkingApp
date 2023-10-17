-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-10-2023 a las 16:29:47
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_parking_app`
--
CREATE DATABASE IF NOT EXISTS `db_parking_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_parking_app`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `consultarBuses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarBuses` ()   BEGIN
SELECT id, id_parqueadero, id_punto_origen, id_punto_destino, tiempo_estadia, hora_salida_origen, hora_llegada_destino FROM buses;
END$$

DROP PROCEDURE IF EXISTS `consultarBusesPorParqueadero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarBusesPorParqueadero` (IN `bus_id_param` INT)   BEGIN
SELECT P.id as "parqueadero_id", B.id as "bus_id", B.tiempo_estadia, B.hora_llegada_destino, B.hora_salida_origen
FROM parqueaderos P
INNER JOIN buses B
ON P.id = B.id_parqueadero
WHERE B.id_parqueadero = bus_id_param;
END$$

DROP PROCEDURE IF EXISTS `consultarBusesPorParqueaderoTodos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarBusesPorParqueaderoTodos` ()   BEGIN
SELECT P.id as "parqueadero_id", P.ocupacion_actual, P.capacidad_actual, P.capacidad_maxima, B.tiempo_estadia, B.id as "bus_id"
FROM parqueaderos P
INNER JOIN buses B
ON P.id = B.id_parqueadero;
END$$

DROP PROCEDURE IF EXISTS `consultarMunicipios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarMunicipios` ()   BEGIN
SELECT id, nombre FROM municipios;
END$$

DROP PROCEDURE IF EXISTS `consultarMunicipiosParqueaderos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarMunicipiosParqueaderos` ()   BEGIN
SELECT P.id, P.id_municipio, P.ubicacion, M.nombre, P.ubicacion, P.ocupacion_actual, P.capacidad_actual, P.capacidad_maxima
FROM parqueaderos AS P 
INNER JOIN municipios AS M
ON P.id_municipio = M.id;
END$$

DROP PROCEDURE IF EXISTS `consultarParqueaderos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarParqueaderos` ()   BEGIN
SELECT id, id_municipio, ocupacion_actual, capacidad_actual, capacidad_maxima, ubicacion FROM parqueaderos;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buses`
--
-- Creación: 11-10-2023 a las 01:18:22
-- Última actualización: 17-10-2023 a las 21:14:45
--

DROP TABLE IF EXISTS `buses`;
CREATE TABLE `buses` (
  `id` int(11) NOT NULL,
  `id_parqueadero` int(11) NOT NULL,
  `id_punto_origen` int(11) NOT NULL,
  `id_punto_destino` int(11) DEFAULT NULL,
  `tiempo_estadia` int(11) NOT NULL,
  `hora_salida_origen` timestamp NULL DEFAULT NULL,
  `hora_llegada_destino` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `buses`:
--   `id_parqueadero`
--       `parqueaderos` -> `id`
--   `id_punto_destino`
--       `parqueaderos` -> `id`
--   `id_punto_origen`
--       `parqueaderos` -> `id`
--

--
-- Volcado de datos para la tabla `buses`
--

INSERT INTO `buses` (`id`, `id_parqueadero`, `id_punto_origen`, `id_punto_destino`, `tiempo_estadia`, `hora_salida_origen`, `hora_llegada_destino`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 2, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:26:01', '2023-10-17 02:51:54'),
(2, 21, 21, NULL, 3, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:27:26', '2023-10-17 02:51:54'),
(3, 1, 1, NULL, 8, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:28:30', '2023-10-17 02:51:54'),
(4, 10, 2, NULL, 1, '2023-10-17 16:00:29', '2023-10-17 15:00:29', '2023-10-11 01:40:11', '2023-10-17 21:14:45'),
(5, 3, 3, NULL, 3, '2023-10-18 03:44:14', '2023-10-18 03:44:14', '2023-10-11 01:40:24', '2023-10-17 03:44:14'),
(6, 4, 4, NULL, 4, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:40:33', '2023-10-17 02:51:54'),
(7, 5, 5, NULL, 5, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:40:41', '2023-10-17 02:51:54'),
(8, 6, 6, NULL, 6, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:40:49', '2023-10-17 02:51:54'),
(9, 7, 7, NULL, 7, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:40:56', '2023-10-17 02:51:54'),
(10, 8, 8, NULL, 8, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:41:04', '2023-10-17 02:51:54'),
(11, 9, 9, NULL, 9, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:41:12', '2023-10-17 02:51:54'),
(12, 10, 10, NULL, 10, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:41:23', '2023-10-17 02:51:54'),
(13, 11, 11, NULL, 11, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:45:21', '2023-10-17 02:51:54'),
(14, 12, 12, NULL, 12, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:45:33', '2023-10-17 02:51:54'),
(15, 13, 13, NULL, 13, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:45:44', '2023-10-17 02:51:54'),
(16, 14, 14, NULL, 14, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:45:57', '2023-10-17 02:51:54'),
(17, 15, 15, NULL, 15, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:46:06', '2023-10-17 02:51:54'),
(18, 16, 16, NULL, 16, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:46:16', '2023-10-17 02:51:54'),
(19, 17, 17, NULL, 17, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:46:31', '2023-10-17 02:51:54'),
(20, 18, 18, NULL, 18, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:46:44', '2023-10-17 02:51:54'),
(21, 19, 19, NULL, 19, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:46:55', '2023-10-17 02:51:54'),
(22, 20, 20, NULL, 20, '2023-10-17 01:29:42', '2023-10-17 01:29:42', '2023-10-11 01:47:07', '2023-10-17 02:51:54');

--
-- Disparadores `buses`
--
DROP TRIGGER IF EXISTS `antes_actualizar_bus_actualizar_parqueadero`;
DELIMITER $$
CREATE TRIGGER `antes_actualizar_bus_actualizar_parqueadero` BEFORE UPDATE ON `buses` FOR EACH ROW BEGIN
    -- Verifica si el campo id_parqueadero ha sido modificado
    IF OLD.id_parqueadero <> NEW.id_parqueadero THEN
        -- Verifica si la capacidad actual del parqueadero nuevo es igual a cero
        IF (SELECT capacidad_actual FROM parqueaderos WHERE id = NEW.id_parqueadero) = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La capacidad actual del parqueadero nuevo es cero, no se permite la actualización del campo id_parqueadero.';
        ELSE
            -- Aumenta la capacidad actual del parqueadero anterior en 1
            UPDATE parqueaderos
            SET capacidad_actual = capacidad_actual + 1
            WHERE id = OLD.id_parqueadero;

            -- Reduce la ocupación actual del parqueadero anterior en 1
            UPDATE parqueaderos
            SET ocupacion_actual = ocupacion_actual - 1
            WHERE id = OLD.id_parqueadero;

            -- Aumenta la ocupación actual del nuevo parqueadero en 1
            UPDATE parqueaderos
            SET ocupacion_actual = ocupacion_actual + 1
            WHERE id = NEW.id_parqueadero;

            -- Reduce la capacidad actual del parqueadero nuevo en 1
            UPDATE parqueaderos
            SET capacidad_actual = capacidad_actual - 1
            WHERE id = NEW.id_parqueadero;
        END IF;
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `antes_eliminar_bus`;
DELIMITER $$
CREATE TRIGGER `antes_eliminar_bus` BEFORE DELETE ON `buses` FOR EACH ROW BEGIN
    -- Disminuye en 1 el campo ocupacion_actual del parqueadero
    UPDATE parqueaderos
    SET ocupacion_actual = ocupacion_actual - 1
    WHERE id = OLD.id_parqueadero;

    -- Aumenta en 1 el campo capacidad_actual del parqueadero
    UPDATE parqueaderos
    SET capacidad_actual = capacidad_actual + 1
    WHERE id = OLD.id_parqueadero;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `antes_insertar_bus_verificar_ocupacion`;
DELIMITER $$
CREATE TRIGGER `antes_insertar_bus_verificar_ocupacion` BEFORE INSERT ON `buses` FOR EACH ROW BEGIN
    DECLARE parqueadero_ocupacion INT;
    DECLARE parqueadero_capacidad INT;
    
    -- Obtiene la ocupación actual y la capacidad del parqueadero 
    SELECT ocupacion_actual, capacidad_actual INTO parqueadero_ocupacion, parqueadero_capacidad
    FROM parqueaderos
    WHERE id = NEW.id_parqueadero;
    
    -- Verifica si la ocupación actual es mayor que la capacidad actual
    IF parqueadero_capacidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La ocupación del parqueadero es igual o menor a cero, no se permite la inserción del bus.';
    ELSE
        -- Incrementa la ocupación actual del parqueadero en 1
        UPDATE parqueaderos
        SET ocupacion_actual = ocupacion_actual + 1
        WHERE id = NEW.id_parqueadero;

        -- Reduce la capacidad actual del parqueadero en 1
        UPDATE parqueaderos
        SET capacidad_actual = capacidad_actual - 1
        WHERE id = NEW.id_parqueadero;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--
-- Creación: 08-10-2023 a las 01:42:46
--

DROP TABLE IF EXISTS `municipios`;
CREATE TABLE `municipios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `ubicacion` point DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `municipios`:
--

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id`, `nombre`, `ubicacion`, `created_at`, `updated_at`) VALUES
(1, 'Chocontá', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(2, 'Tibiritá', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(3, 'Jerusalén', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(4, 'Ricaurte', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(5, 'Puerto Salgar', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(6, 'La vega', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(7, 'Útica', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(8, 'Villeta', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(9, 'Guasca', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(10, 'Choachí', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(11, 'Pacho', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(12, 'Yacopí', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(13, 'Cogua', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(14, 'Cota', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(15, 'Sopó', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(16, 'Tocancipá', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(17, 'Facatativa', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(18, 'El colegio', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(19, 'Simijica', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(20, 'Ubaté', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41'),
(21, 'Bogotá D.C', NULL, '2023-10-08 23:45:41', '2023-10-08 23:45:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parqueaderos`
--
-- Creación: 10-10-2023 a las 02:39:24
-- Última actualización: 17-10-2023 a las 21:14:45
--

DROP TABLE IF EXISTS `parqueaderos`;
CREATE TABLE `parqueaderos` (
  `id` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `ocupacion_actual` int(11) NOT NULL,
  `capacidad_actual` int(11) NOT NULL,
  `capacidad_maxima` int(11) NOT NULL,
  `ubicacion` point NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `parqueaderos`:
--   `id_municipio`
--       `municipios` -> `id`
--

--
-- Volcado de datos para la tabla `parqueaderos`
--

INSERT INTO `parqueaderos` (`id`, `id_municipio`, `ocupacion_actual`, `capacidad_actual`, `capacidad_maxima`, `ubicacion`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 0, 2, 0x000000000101000000b62bf4c132961440f04fa912656b52c0, '2023-10-10 02:44:14', '2023-10-17 01:29:42'),
(2, 2, 0, 3, 3, 0x000000000101000000bf4868cbb9341440155454fd4a6052c0, '2023-10-10 02:44:14', '2023-10-17 21:14:45'),
(3, 3, 1, 1, 2, 0x00000000010100000077d844662e40124084f068e388ac52c0, '2023-10-10 02:44:14', '2023-10-17 03:44:14'),
(4, 4, 1, 1, 2, 0x00000000010100000098f90e7ee220114054e57b4622b152c0, '2023-10-10 02:44:14', '2023-10-11 01:40:33'),
(5, 5, 1, 1, 2, 0x000000000101000000b534b74258dd154047551344dda952c0, '2023-10-10 02:44:14', '2023-10-11 01:40:41'),
(6, 6, 1, 2, 3, 0x0000000001010000008b70935165f813407009c03fa59552c0, '2023-10-10 02:44:14', '2023-10-11 01:40:49'),
(7, 7, 1, 1, 2, 0x000000000101000000ca6c904946be144098a59d9acb9e52c0, '2023-10-10 02:44:14', '2023-10-11 01:40:56'),
(8, 8, 1, 3, 4, 0x00000000010100000032ad4d637b0d14404b21904b1c9e52c0, '2023-10-10 02:44:14', '2023-10-11 01:41:04'),
(9, 9, 1, 2, 3, 0x000000000101000000d7c22cb4737a1340914259f8fa7752c0, '2023-10-10 02:44:14', '2023-10-11 01:41:12'),
(10, 10, 2, 0, 2, 0x000000000101000000ae2d3c2f151b12400bee073c307b52c0, '2023-10-10 02:44:14', '2023-10-17 21:14:45'),
(11, 11, 1, 1, 2, 0x0000000001010000006214048f6f8f1440c5758c2b2e8a52c0, '2023-10-10 02:44:14', '2023-10-11 01:45:21'),
(12, 12, 1, 1, 2, 0x00000000010100000043739d465ada1540e4839ecdaa9552c0, '2023-10-10 02:44:14', '2023-10-11 01:45:33'),
(13, 13, 1, 1, 2, 0x0000000001010000002c29779fe34314400f99f221a87e52c0, '2023-10-10 02:44:14', '2023-10-11 01:45:44'),
(14, 14, 1, 2, 3, 0x00000000010100000015c5abac6d3a1340e3344415fe8652c0, '2023-10-10 02:44:14', '2023-10-11 01:45:57'),
(15, 15, 1, 3, 4, 0x000000000101000000af7d01bd70a71340295b24ed467c52c0, '2023-10-10 02:44:14', '2023-10-11 01:46:06'),
(16, 16, 1, 3, 4, 0x00000000010100000029e78bbd17df1340f1475167ee7952c0, '2023-10-10 02:44:14', '2023-10-11 01:46:16'),
(17, 17, 1, 3, 4, 0x00000000010100000037195586714713402a0307b4749752c0, '2023-10-10 02:44:14', '2023-10-11 01:46:31'),
(18, 18, 1, 1, 2, 0x00000000010100000014799274cd541240130ce71a669c52c0, '2023-10-10 02:44:14', '2023-10-11 01:46:44'),
(19, 19, 1, 1, 2, 0x000000000101000000bf45274bad071640658d7a88467652c0, '2023-10-10 02:44:14', '2023-10-11 01:46:55'),
(20, 20, 1, 2, 3, 0x0000000001010000000490dac4c93d1540274a42226d7452c0, '2023-10-10 02:44:14', '2023-10-15 02:21:43'),
(21, 21, 1, 7, 8, 0x000000000101000000e52b8194d8b51240e222f774758952c0, '2023-10-10 02:44:14', '2023-10-15 02:21:43');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_parqueadero` (`id_parqueadero`),
  ADD KEY `id_punto_origen` (`id_punto_origen`),
  ADD KEY `id_punto_destino` (`id_punto_destino`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `parqueaderos`
--
ALTER TABLE `parqueaderos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_municipio` (`id_municipio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `buses`
--
ALTER TABLE `buses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `parqueaderos`
--
ALTER TABLE `parqueaderos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `buses`
--
ALTER TABLE `buses`
  ADD CONSTRAINT `fk_id_parqueadero` FOREIGN KEY (`id_parqueadero`) REFERENCES `parqueaderos` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_punto_destino` FOREIGN KEY (`id_punto_destino`) REFERENCES `parqueaderos` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_punto_origen` FOREIGN KEY (`id_punto_origen`) REFERENCES `parqueaderos` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `parqueaderos`
--
ALTER TABLE `parqueaderos`
  ADD CONSTRAINT `fk_id_municipio` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
