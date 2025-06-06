use Ecommerce_DB
go

insert into Rol values ('Administrador')
insert into Rol values ('Usuario')

insert into Clientes (CorreoElectronico, Contraseña, IdRol, Estado, FechaCreacion, Documento, Nombre, Apellido, NumTelefono, Direccion) values
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