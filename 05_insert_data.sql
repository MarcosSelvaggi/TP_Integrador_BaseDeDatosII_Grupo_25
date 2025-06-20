use Ecommerce_DB
go

insert into Rol values ('Administrador')
insert into Rol values ('Usuario')

insert into Usuarios (IDRol, Email, Contraseña, FechaDeCreacion, Activo) values
(1, 'juanperez@gmail.com', 'abc123', '2024-01-01', 1),
(1, 'mariagonzalez@gmail.com', 'def456', '2024-01-02', 1),
(2, 'carloslopez@gmail.com', 'ghi789', '2024-01-03', 1),
(1, 'analuna@gmail.com', 'jkl012', '2024-01-04', 1),
(1, 'lucasmartinez@gmail.com', 'mno345', '2024-01-05', 0),
(2, 'patricioruiz@gmail.com', 'pqr678', '2024-01-06', 1),
(1, 'celinadiaz@gmail.com', 'stu901', '2024-01-07', 1),
(1, 'federicoalvarez@gmail.com', 'vwx234', '2024-01-08', 1),
(1, 'andrealuna@gmail.com', 'yz1234', '2024-01-09', 1),
(1, 'matiasnavarro@gmail.com', '567890', '2024-01-10', 1);

insert into Clientes (IDUsuario, NumeroDocumento, TipoDocumento, NumeroTelefono, Nombre, Apellido) values
(1, '12345678', 'DNI', '1234567890', 'Juan', 'Perez'),
(2, '87654321', 'DNI', '2345678901', 'Maria', 'Gonzalez'),
(3, '22334455', 'DNI', '3456789012', 'Carlos', 'Lopez'),
(4, '99887766', 'DNI', '4567890123', 'Ana', 'Luna'),
(5, '55667788', 'DNI', '5678901234', 'Lucas', 'Martinez'),
(6, '11223344', 'DNI', '6789012345', 'Patricio', 'Ruiz'),
(7, '66554433', 'DNI', '7890123456', 'Celina', 'Diaz'),
(8, '33445566', 'DNI', '8901234567', 'Federico', 'Alvarez'),
(9, '44556677', 'DNI', '9012345678', 'Andrea', 'Luna'),
(10, '77889900', 'DNI', '9123456789', 'Matias', 'Navarro');

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

insert into Productos (Nombre, Stock, PrecioSinImpuestos, PrecioConImpuestos, Impuestos, Activo, IDCategoria, IDMarca) values
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

insert into EstadoDePedidos values 
('En Proceso'), 
('Confirmado'), 
('Completado'),
('Cancelada');

insert into MetodosDePago values 
('Tarjeta'), 
('Mercado Pago'),
('Efectivo'),
('Transferencia'); 

insert into EstadoDeEnvios (FechaDeEnvio, Descripcion) values 
(getdate(), 'Por llevar al correo'),
(getdate(), 'En camino'), 
(getdate(), 'Entregado'),
(getdate(), 'Retrasado');

insert into DetalleDePagos (IDMetodoPago, FechaDePago, EstadoPago, Detalles) values 
(1, '2025-05-01', 'Aprobado', 'Pago con tarjeta - Pedido 1'),
(3, '2025-05-03', 'Pendiente', 'Pago en efectivo - Pedido 2'),
(2, '2025-04-28', 'Aprobado', 'Pago con Mercado Pago - Pedido 3'),
(4, '2025-04-30', 'Fallido', 'Transferencia bancaria - Pedido 4'),
(2, '2025-05-05', 'Pendiente', 'Mercado Pago - Pedido 5'),
(3, '2025-05-06', 'Aprobado', 'Pago en efectivo - Pedido 6'),
(1, '2025-05-07', 'Aprobado', 'Pago con tarjeta - Pedido 7'),
(2, '2025-05-01', 'Aprobado', 'Pago con Mercado Pago - Pedido 8'),
(4, '2025-04-25', 'Pendiente', 'Transferencia - Pedido 9'),
(3, '2025-05-02', 'Aprobado', 'Pago en efectivo - Pedido 10'),
(1, '2025-05-08', 'Fallido', 'Tarjeta rechazada - Pedido 11'),
(3, '2025-05-09', 'Aprobado', 'Pago en efectivo - Pedido 12'),
(2, '2025-05-10', 'Aprobado', 'Mercado Pago - Pedido 13'),
(4, '2025-05-11', 'Aprobado', 'Transferencia confirmada - Pedido 14'),
(1, '2025-05-12', 'Aprobado', 'Pago con tarjeta - Pedido 15'),
(4, '2025-05-13', 'Pendiente', 'Transferencia - Pedido 16'),
(3, '2025-05-14', 'Fallido', 'Billete falso - Pedido 17'),
(2, '2025-05-15', 'Aprobado', 'Mercado Pago - Pedido 18'),
(2, '2025-05-16', 'Aprobado', 'Mercado Pago - Pedido 19'),
(1, '2025-05-17', 'Aprobado', 'Tarjeta débito - Pedido 20');

insert into Pedidos (IDCliente, IDEnvio, IDEstadoPedido, FechaDePedido, PrecioTotal, IDPago) values
(5, 3, 2, '2025-05-01', 2499.99, 1),
(1, 2, 1, '2025-05-03', 850.50, 2),
(7, 1, 3, '2025-04-28', 1450.00, 3),
(3, 3, 4, '2025-04-30', 125.75, 4),
(9, 2, 1, '2025-05-05', 3120.00, 5),
(2, 1, 2, '2025-05-06', 455.40, 6),
(6, 2, 3, '2025-05-07', 988.80, 7),
(4, 3, 2, '2025-05-01', 740.10, 8),
(10, 1, 1, '2025-04-25', 1599.99, 9),
(8, 2, 3, '2025-05-02', 112.99, 10),
(1, 1, 4, '2025-05-08', 275.00, 11),
(5, 2, 1, '2025-05-09', 310.20, 12),
(7, 3, 2, '2025-05-10', 1720.00, 13),
(9, 2, 3, '2025-05-11', 499.99, 14),
(2, 1, 1, '2025-05-12', 640.00, 15),
(6, 3, 2, '2025-05-13', 210.10, 16),
(3, 1, 4, '2025-05-14', 380.45, 17),
(10, 2, 1, '2025-05-15', 2000.00, 18),
(8, 1, 3, '2025-05-16', 890.75, 19),
(4, 3, 2, '2025-05-17', 325.60, 20);
--SIN SUBTOTAL
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (1, 1, 1, 423500);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (1, 3, 2, 114950);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (2, 5, 3, 1815);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (3, 4, 1, 42350);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (3, 6, 1, 1694);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (4, 10, 1, 9680);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (5, 2, 1, 338800);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (6, 7, 1, 30250);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (7, 8, 2, 21780);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (8, 5, 6, 1815);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (9, 9, 1, 60500);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (10, 10, 3, 9680);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (2, 1, 3, 100);
insert into DetalleDePedidos (IDPedido, IDProducto, Cantidad, PrecioUnitario) values (2, 3, 2, 1000);

