/* Creacion de entidades */
CREATE TABLE `persona` (
  `idPersona` int(10) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `telefono` float NOT NULL,
  `documento` float NOT NULL
);

CREATE TABLE `admin` (
  `codigoAd` varchar(25) NOT NULL,
  `IdPersona` int(10) NOT NULL
); 

CREATE TABLE `empleado` (
  `codigoEm` varchar(25) NOT NULL,
  `area` varchar(25) NOT NULL,
  `idPersona` int(11) NOT NULL
); 

CREATE TABLE `cliente` (
  `codigoC` varchar(25) NOT NULL,
  `puntos` int(10) NOT NULL,
  `idPersona` int(10) NOT NULL
); 
CREATE TABLE `proveedor` (
  `NIT` varchar(25) NOT NULL,
  `empresa` varchar(25) NOT NULL,
  `idPersona` int(10) NOT NULL
);
CREATE TABLE `producto` (
  `codigo` varchar(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `categoría` varchar(25) NOT NULL,
  `marca` varchar(25) DEFAULT NULL,
  `precioEntrada` int(15) NOT NULL,
  `precioSalida` int(15) NOT NULL
);
CREATE TABLE `ubicacion` (
  `codigo` varchar(25) NOT NULL,
  `categoria` varchar(25) NOT NULL,
  `zona` varchar(25) NOT NULL
);

CREATE TABLE `tipooperacion` (
  `tipo` varchar(25) NOT NULL
); 
CREATE TABLE `operacin` (
  `codigo` varchar(25) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  `nFactura` int(25) DEFAULT NULL,
  `estado` varchar(25) NOT NULL,
  `codigoAd` varchar(25) NOT NULL,
  `codigoEm` varchar(25) NOT NULL
);

CREATE TABLE `detalleop` (
  `codigoOp` varchar(25) NOT NULL,
  `codigoPro` varchar(25) NOT NULL,
  `descripcionPro` varchar(50) NOT NULL,
  `cantidad` int(25) NOT NULL,
  `descripción` varchar(150) NOT NULL,
  `ubicacionActual` varchar(25) NOT NULL,
  `ubicacionDest` varchar(25) NOT NULL
);
CREATE TABLE `venta` (
  `numeroVenta` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `descuento` int(25) NOT NULL,
  `total` int(11) NOT NULL
); 
CREATE TABLE `detalleventa` (
  `numeroVenta` int(11) NOT NULL,
  `codigoPro` varchar(25) NOT NULL,
  `descripcionPro` varchar(50) NOT NULL,
  `cantidad` int(15) NOT NULL,
  `preciounitario` int(15) NOT NULL,
  `subtotal` int(15) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
);
CREATE TABLE `reporteventas` (
  `numeroReporte` int(11) NOT NULL,
  `codigoC` varchar(25) NOT NULL,
  `codigoVenta` int(11) NOT NULL
);
CREATE TABLE `inventario` (
  `codigoUb` varchar(20) NOT NULL,
  `codigoPro` varchar(20) NOT NULL,
  `cantidad` int(20) NOT NULL,
  `codigoOperacion` varchar(20) NOT NULL
); 
CREATE TABLE `proveedorprovee` (
  `NIt` varchar(15) NOT NULL,
  `codigoPro` varchar(15) NOT NULL
); 

ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`);
ALTER TABLE `persona`
  MODIFY `idPersona` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `admin`
  ADD PRIMARY KEY (`codigoAd`),
  ADD KEY `IdPersona` (`IdPersona`);
  
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codigoC`),
  ADD KEY `idPersona` (`idPersona`);

ALTER TABLE `empleado`
  ADD PRIMARY KEY (`codigoEm`),
  ADD KEY `idPersona` (`idPersona`);

ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`NIT`),
  ADD KEY `idPersona` (`idPersona`);

ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo`);

ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`codigo`);  

ALTER TABLE `tipooperacion`
  ADD PRIMARY KEY (`tipo`);

ALTER TABLE `operacin`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `tipo` (`tipo`,`codigoAd`,`codigoEm`),
  ADD KEY `codigoAd` (`codigoAd`),
  ADD KEY `codigoEm` (`codigoEm`);

ALTER TABLE `venta`
  ADD PRIMARY KEY (`numeroVenta`);  
ALTER TABLE `venta`
  MODIFY `numeroVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;  

ALTER TABLE `reporteventas`
  ADD PRIMARY KEY (`numeroReporte`),
  ADD KEY `codigoC` (`codigoC`,`codigoVenta`),
  ADD KEY `codigoVenta` (`codigoVenta`);  
ALTER TABLE `reporteventas`
  MODIFY `numeroReporte` int(11) NOT NULL AUTO_INCREMENT;  

ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`IdPersona`) REFERENCES `persona` (`idPersona`);

 ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`); 

ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

 ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`); 

ALTER TABLE `detalleop`
  ADD KEY `codigoOp` (`codigoOp`),
  ADD KEY `codigoPro` (`codigoPro`),
  ADD KEY `ubicacionActual` (`ubicacionActual`),
  ADD KEY `ubicacionDest` (`ubicacionDest`);

ALTER TABLE `detalleop`
  ADD CONSTRAINT `detalleop_ibfk_1` FOREIGN KEY (`codigoOp`) REFERENCES `operacin` (`codigo`),
  ADD CONSTRAINT `detalleop_ibfk_2` FOREIGN KEY (`codigoPro`) REFERENCES `producto` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleop_ibfk_3` FOREIGN KEY (`ubicacionActual`) REFERENCES `ubicacion` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleop_ibfk_4` FOREIGN KEY (`ubicacionDest`) REFERENCES `ubicacion` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `detalleventa`
  ADD KEY `numeroVenta` (`numeroVenta`),
  ADD KEY `codigoPro` (`codigoPro`);


ALTER TABLE `inventario`
  ADD KEY `codigoUb` (`codigoUb`),
  ADD KEY `codigoPro` (`codigoPro`),
  ADD KEY `codigoOperacion` (`codigoOperacion`);
  
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`codigoUb`) REFERENCES `ubicacion` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`codigoPro`) REFERENCES `producto` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventario_ibfk_3` FOREIGN KEY (`codigoOperacion`) REFERENCES `operacin` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proveedorprovee`
  ADD KEY `NIt` (`NIt`,`codigoPro`),
  ADD KEY `codigoPro` (`codigoPro`);

ALTER TABLE `proveedorprovee`
  ADD CONSTRAINT `proveedorprovee_ibfk_1` FOREIGN KEY (`codigoPro`) REFERENCES `producto` (`codigo`),
  ADD CONSTRAINT `proveedorprovee_ibfk_2` FOREIGN KEY (`NIt`) REFERENCES `proveedor` (`NIT`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `operacin`
  ADD CONSTRAINT `operacin_ibfk_1` FOREIGN KEY (`codigoAd`) REFERENCES `admin` (`codigoAd`),
  ADD CONSTRAINT `operacin_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `tipooperacion` (`tipo`),
  ADD CONSTRAINT `operacin_ibfk_3` FOREIGN KEY (`codigoEm`) REFERENCES `empleado` (`codigoEm`);

ALTER TABLE `reporteventas`
  ADD CONSTRAINT `reporteventas_ibfk_1` FOREIGN KEY (`codigoC`) REFERENCES `cliente` (`codigoC`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporteventas_ibfk_2` FOREIGN KEY (`codigoVenta`) REFERENCES `venta` (`numeroVenta`) ON DELETE CASCADE ON UPDATE CASCADE;
  

ALTER TABLE `detalleventa`
  ADD CONSTRAINT `detalleventa_ibfk_1` FOREIGN KEY (`codigoPro`) REFERENCES `producto` (`codigo`),
  ADD CONSTRAINT `detalleventa_ibfk_2` FOREIGN KEY (`numeroVenta`) REFERENCES `venta` (`numeroVenta`) ON DELETE CASCADE ON UPDATE CASCADE;













