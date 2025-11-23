drop database veterinaria;
CREATE DATABASE veterinaria;
USE veterinaria;

CREATE TABLE persona (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_documento ENUM('CC', 'CE') NOT NULL,
  documento VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  direccion VARCHAR(150),
  correo VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (documento)
);

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE usuario (
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(45) NOT NULL,
  contrasenha VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE especialidad (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE veterinario (
  id INT NOT NULL AUTO_INCREMENT,
  tarjeta_profesional VARCHAR(45) NOT NULL,
  especialidad INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id),
  FOREIGN KEY (especialidad) REFERENCES especialidad(id)
);

CREATE TABLE tipo_animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cliente_id INT NOT NULL,
  tipo_animal_id INT NOT NULL,
  anho_nacimiento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tipo_animal_id) REFERENCES tipo_animal(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE producto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  precio_compra DOUBLE NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE precios_producto (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nit VARCHAR(45) NOT NULL,
  razon_social VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE compra (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  proveedor_id INT NOT NULL,
  fecha_compra DATE NOT NULL,
  fecha_registro DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE detalle_compra (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  compra_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id),
  FOREIGN KEY (compra_id) REFERENCES compra(id)
);

CREATE TABLE servicio (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE paquete (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE detalle_paquete (
  id INT NOT NULL AUTO_INCREMENT,
  paquete_servicio ENUM('servicio','producto') NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  paquete_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (paquete_id) REFERENCES paquete(id)
);

CREATE TABLE venta (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  cliente_id INT NOT NULL,
  fecha_venta DATE NOT NULL,
  fecha_ingreso DATETIME NOT NULL,
  total VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE detalle_venta (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_venta ENUM('producto','paquete','servicio') NOT NULL,
  codigo INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  venta_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (venta_id) REFERENCES venta(id)
);

CREATE TABLE citas (
  id INT NOT NULL AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  animal_id INT NOT NULL,
  fecha_inicio DATETIME NOT NULL,
  fecha_fin DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  vendedor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (vendedor_id) REFERENCES usuario(id),
  FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
  FOREIGN KEY (animal_id) REFERENCES animal(id)
);

-- =============================
-- INSERTS PARA BASE VETERINARIA
-- =============================

-- PERSONA
INSERT INTO persona (tipo_documento, documento, nombre, apellido, direccion, correo, fecha_nacimiento) VALUES
('CC', '1001001001', 'Carlos', 'Ramírez', 'Cra 10 #20-30', 'carlos@mail.com', '1985-03-12'),
('CC', '1002002002', 'María', 'González', 'Av 5 #11-22', 'maria@mail.com', '1990-07-21'),
('CC', '1003003003', 'Juan', 'Pérez', 'Calle 8 #40-15', 'juanp@mail.com', '1979-01-30'),
('CC', '1004004004', 'Ana', 'Torres', 'Cra 15 #30-45', 'ana.vet@mail.com', '1988-11-02'),
('CE', '9005005005', 'Luis', 'Martínez', 'Av 30 #10-05', 'luis.vet@mail.com', '1992-05-17'),
('CC', '1006006006', 'Paola', 'Suárez', 'Calle 60 #25-10', 'paola@mail.com', '2000-09-05');

-- CLIENTE
INSERT INTO cliente (id) VALUES
(1), (2), (3);

-- USUARIO
INSERT INTO usuario (id, usuario, contrasenha) VALUES
(1, 'carlosR', 'pass123'),
(4, 'anaVet', 'vetpass'),
(5, 'luisVet', 'luispass');

-- ESPECIALIDAD
INSERT INTO especialidad (nombre) VALUES
('Medicina General'),
('Cirugía'),
('Dermatología');

-- VETERINARIO
INSERT INTO veterinario (id, tarjeta_profesional, especialidad) VALUES
(4, 'TP-001', 1),
(5, 'TP-002', 2);

-- TIPO ANIMAL
INSERT INTO tipo_animal (nombre) VALUES
('Perro'),
('Gato'),
('Conejo'),
('Hamster'),
('Loro'),
('Tortuga');

-- ANIMAL
INSERT INTO animal (nombre, cliente_id, tipo_animal_id, anho_nacimiento) VALUES
('Firulais', 1, 1, 2018),
('Misu', 2, 2, 2020),
('Rocky', 1, 1, 2016),
('Lola', 3, 3, 2019),
('Max', 3, 1, 2017),
('Kiwi', 2, 5, 2021);

-- PRODUCTO
INSERT INTO producto (nombre, descripcion, precio_compra, stock) VALUES
('Shampoo Veterinario', 'Control de pulgas y garrapatas', 15000, 20),
('Collar Antipulgas', 'Protección por 3 meses', 20000, 15),
('Vitaminas Mascotas', 'Fortalecimiento sistema inmune', 18000, 30),
('Juguete Perro', 'Pelota resistente', 8000, 25),
('Arena para gatos', 'Absorbente y ecológica', 12000, 40),
('Pechera pequeña', 'Cómoda y ajustable', 14000, 10);

-- PRECIOS PRODUCTO
INSERT INTO precios_producto (producto_id, nombre, precio) VALUES
(1, 'Shampoo Premium', 25000),
(2, 'Collar XL', 28000),
(3, 'Vitaminas Plus', 35000),
(4, 'Pelota Pro', 15000),
(5, 'Arena Premium', 20000),
(6, 'Pechera Deluxe', 22000);

-- PROVEEDOR
INSERT INTO proveedor (nit, razon_social, correo) VALUES
('900123456', 'Mascotiendas SAS', 'ventas@mascotiendas.com'),
('900654321', 'VetDistribuciones SA', 'contacto@vetdis.com'),
('901001001', 'AnimalCare Ltda', 'info@animalcare.com'),
('901002002', 'PetWorld SAS', 'servicio@petworld.com'),
('902003003', 'Distribuidora PetPlus', 'compras@petplus.com'),
('903004004', 'SuperVet Suministros', 'ventas@supervet.com');

-- COMPRA
INSERT INTO compra (usuario_id, proveedor_id, fecha_compra, fecha_registro, total) VALUES
(1, 1, '2025-01-05', '2025-01-05 10:30:00', 80000),
(4, 2, '2025-01-10', '2025-01-10 14:20:00', 65000),
(5, 3, '2025-01-12', '2025-01-12 09:15:00', 50000),
(1, 4, '2025-01-15', '2025-01-15 16:00:00', 120000),
(4, 5, '2025-01-20', '2025-01-20 11:45:00', 70000),
(5, 6, '2025-01-25', '2025-01-25 13:00:00', 90000);

-- DETALLE COMPRA
INSERT INTO detalle_compra (producto_id, cantidad, subtotal, compra_id) VALUES
(1, 2, 30000, 1),
(2, 1, 20000, 1),
(3, 1, 18000, 2),
(4, 3, 24000, 3),
(5, 2, 24000, 4),
(6, 4, 56000, 4);

-- SERVICIO
INSERT INTO servicio (nombre, precio) VALUES
('Consulta General', '40000'),
('Vacunación', '60000'),
('Desparasitación', '35000'),
('Cirugía menor', '150000'),
('Control dermatológico', '80000'),
('Limpieza dental', '70000');

-- PAQUETE
INSERT INTO paquete (nombre, precio) VALUES
('Paquete Básico', '80000'),
('Paquete Premium', '150000'),
('Paquete Vacunación', '90000'),
('Paquete Salud Total', '200000'),
('Paquete Estética', '100000'),
('Paquete Cirugía', '300000');

-- DETALLE PAQUETE
INSERT INTO detalle_paquete (paquete_servicio, cantidad, subtotal, paquete_id) VALUES
('servicio', 1, 40000, 1),
('producto', 2, 30000, 1),
('servicio', 1, 150000, 6),
('producto', 1, 80000, 2),
('servicio', 2, 160000, 4),
('servicio', 1, 70000, 5);

-- VENTA
INSERT INTO venta (usuario_id, cliente_id, fecha_venta, fecha_ingreso, total) VALUES
(1, 1, '2025-02-01', '2025-02-01 10:00:00', '70000'),
(4, 2, '2025-02-02', '2025-02-02 11:30:00', '120000'),
(5, 3, '2025-02-03', '2025-02-03 09:50:00', '60000'),
(1, 2, '2025-02-04', '2025-02-04 14:00:00', '90000'),
(4, 1, '2025-02-05', '2025-02-05 16:20:00', '40000'),
(5, 3, '2025-02-06', '2025-02-06 13:15:00', '150000');

-- DETALLE VENTA
INSERT INTO detalle_venta (tipo_venta, codigo, cantidad, subtotal, venta_id) VALUES
('producto', 1, 1, 25000, 1),
('servicio', 1, 1, 40000, 1),
('paquete', 2, 1, 150000, 2),
('producto', 5, 2, 40000, 4),
('servicio', 3, 1, 35000, 5),
('paquete', 6, 1, 300000, 6);

-- CITAS
INSERT INTO citas (veterinario_id, animal_id, fecha_inicio, fecha_fin, total, vendedor_id) VALUES
(4, 1, '2025-02-10 09:00:00', '2025-02-10 09:30:00', 40000, 1),
(5, 2, '2025-02-11 10:00:00', '2025-02-11 10:45:00', 80000, 4),
(4, 3, '2025-02-12 14:00:00', '2025-02-12 14:30:00', 35000, 5),
(5, 5, '2025-02-13 15:00:00', '2025-02-13 15:30:00', 70000, 1),
(4, 4, '2025-02-14 16:00:00', '2025-02-14 16:45:00', 60000, 4),
(5, 6, '2025-02-15 11:00:00', '2025-02-15 11:30:00', 50000, 5);



