use Ecommerce_DB
go

insert into Rol values ('Administrador')
insert into Rol values ('Usuario')

insert into Clientes (CorreoElectronico, Contraseña, IdRol, Activo, FechaCreacion, Documento, Nombre, Apellido, NumTelefono, Direccion) values
('juanperez@gmail.com', 'abc123', 1, 1, '2024-01-01', 12345678, 'Juan', 'Perez', '1234567890', 'Calle Falsa 123'),
('mariagonzalez@gmail.com', 'def456', 1, 1, '2024-01-02', 87654321, 'Maria', 'Gonzalez', '2345678901', 'Av Siempre Viva 742'),
('carloslopez@gmail.com', 'ghi789', 2, 1, '2024-01-03', 22334455, 'Carlos', 'Lopez', '3456789012', 'Mitre 1024'),
('analuna@gmail.com', 'jkl012', 1, 1, '2024-01-04', 99887766, 'Ana', 'Luna', '4567890123', 'Belgrano 315'),
('lucasmartinez@gmail.com', 'mno345', 1, 0, '2024-01-05', 55667788, 'Lucas', 'Martinez', '5678901234', 'San Martin 223'),
('patricioruiz@gmail.com', 'pqr678', 2, 1, '2024-01-06', 11223344, 'Patricio', 'Ruiz', '6789012345', 'Colon 444'),
('celinadiaz@gmail.com', 'stu901', 1, 1, '2024-01-07', 66554433, 'Celina', 'Diaz', '7890123456', 'Independencia 666'),
('federicoalvarez@gmail.com', 'vwx234', 1, 1, '2024-01-08', 33445566, 'Federico', 'Alvarez', '8901234567', 'Saavedra 321'),
('andrealuna@gmail.com', 'yz1234', 1, 1, '2024-01-09', 44556677, 'Andrea', 'Luna', '9012345678', 'Alsina 222'),
('matiasnavarro@gmail.com', '567890', 1, 1, '2024-01-10', 77889900, 'Matias', 'Navarro', '9123456789', 'Rivadavia 1050');

insert into Categorias (Nombre) values
('Electrónica'),
('Hogar'),
('Deportes'),
('Juguetería'),
('Indumentaria'),
('Computación'),
('Alimentos'),
('Bebidas'),
('Perfumería'),
('Libros');

insert into Marcas (Nombre) values
('Samsung'),
('LG'),
('Sony'),
('Philips'),
('Nike'),
('Adidas'),
('HP'),
('Lenovo'),
('Coca-Cola'),
('Pepsi');

insert into Productos (Nombre, Stock, PrecioSinIva, PrecioConIva, PorcentajeIVA, Activo, IdCategoria, IdMarca) values
('Smart TV 50"', 20, 350000, 423500, 21, 1, 1, 1),
('Notebook HP 14"', 15, 280000, 338800, 21, 1, 6, 7),
('Zapatillas Nike Air', 30, 95000, 114950, 21, 1, 5, 5),
('Camisa Adidas', 50, 35000, 42350, 21, 1, 5, 6),
('Coca-Cola 2.25L', 200, 1500, 1815, 21, 1, 8, 9),
('Pepsi 2.25L', 150, 1400, 1694, 21, 1, 8, 10),
('Auriculares Sony', 40, 25000, 30250, 21, 1, 1, 3),
('Pelota Adidas', 60, 18000, 21780, 21, 1, 3, 6),
('Perfume Philips', 25, 50000, 60500, 21, 1, 9, 4),
('Libro "SQL para Todos"', 100, 8000, 9680, 21, 1, 10, 2);

insert into EstadosPedidos values 
('En Proceso'), 
('Confirmado'), 
('Completado'),
('Cancelada');

insert into MetodosPagos values 
('Tarjeta'), 
('Mercado Pago'),
('Efectivo'),
('Transferencia'); 

insert into EstadosEnvio values 
('Por llevar al correo'),
('En camino'), 
('Entregado'),
('Retrasado'); 

--Me los dió así, después los acomodo (O no)
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (5, '2025-05-01', 2, 1, 3, 2499.99);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (1, '2025-05-03', 1, 3, 2, 850.50);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (7, '2025-04-28', 3, 2, 1, 1450.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (3, '2025-04-30', 4, 4, 3, 125.75);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (9, '2025-05-05', 1, 2, 2, 3120.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (2, '2025-05-06', 2, 3, 1, 455.40);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (6, '2025-05-07', 3, 1, 2, 988.80);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (4, '2025-05-01', 2, 2, 3, 740.10);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (10, '2025-04-25', 1, 4, 1, 1599.99);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (8, '2025-05-02', 3, 3, 2, 112.99);

INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (1, '2025-05-08', 4, 1, 1, 275.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (5, '2025-05-09', 1, 3, 2, 310.20);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (7, '2025-05-10', 2, 2, 3, 1720.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (9, '2025-05-11', 3, 4, 2, 499.99);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (2, '2025-05-12', 1, 1, 1, 640.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (6, '2025-05-13', 2, 4, 3, 210.10);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (3, '2025-05-14', 4, 3, 1, 380.45);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (10, '2025-05-15', 1, 2, 2, 2000.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (8, '2025-05-16', 3, 2, 1, 890.75);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (4, '2025-05-17', 2, 1, 3, 325.60);

INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (1, '2025-05-18', 4, 3, 2, 760.99);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (5, '2025-05-19', 2, 2, 1, 1045.45);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (7, '2025-05-20', 1, 1, 3, 1880.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (9, '2025-05-21', 3, 4, 2, 575.75);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (2, '2025-05-22', 4, 3, 1, 120.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (6, '2025-05-23', 1, 4, 3, 1350.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (3, '2025-05-24', 2, 2, 2, 560.60);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (10, '2025-05-25', 3, 1, 1, 980.80);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (8, '2025-05-26', 2, 4, 2, 210.00);
INSERT INTO Pedidos (IdCliente, FechaPedido, IdEstadoPedido, IdMetodoPago, IdEnvio, PrecioTotal) VALUES (4, '2025-05-27', 1, 3, 3, 745.20);

--Detalle de Pedidos SIN Subtotal
insert into DetallePedidos (IdPedido, IdProducto, Cantidad, PrecioUnitario) values 
(2, 1, 3, 100),
(2, 3, 2, 1000);