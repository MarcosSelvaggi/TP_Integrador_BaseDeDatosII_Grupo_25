use Master 
go 
if NOT EXISTS (Select * From sys.databases WHERE name = 'Ecommerce_DB')
begin 
Create Database Ecommerce_DB ; 
end; 
go 
Use Ecommerce_DB
go

create table Rol(
	IdRol tinyint not null primary key identity (1,1),
	Descripcion VARCHAR(25) not null
)

create table Clientes(
	IdCliente int not null primary key identity(1,1),
	CorreoElectronico NVARCHAR(100) not null unique, 
	Contraseña VARCHAR(50) not null,
	IdRol tinyint not null foreign key references Rol(IdRol),
	Estado bit not null, 
	FechaCreacion date not null,
	Documento int not null unique, 
	Nombre VARCHAR(100) not null, 
	Apellido VARCHAR(100) not null,
	NumTelefono VARCHAR(20) not null unique, 
	Direccion VARCHAR(100) not null
)

create table Categorias(
	IdCategoria int not null primary key identity(1, 1),
	Nombre varchar(50) not null unique
)

create table Marcas(
	IdMarca int not null primary key identity(1, 1),
	Nombre varchar(50) not null unique
)

create table Productos(
	IdProducto int not null primary key identity(1, 1),
	Nombre varchar(100) not null,
	Stock int not null,
	PrecioSinIva money not null,
	PrecioConIva money not null,
	PorcentajeIVA tinyint not null,
	Activo bit not null,
	IdCategoria int not null foreign key references Categorias(IdCategoria),
	IdMarca int not null foreign key references Marcas(IdMarca)
)
	
create table EstadosPedidos (
    IdEstadoPedido tinyint primary key,
    Descripcion varchar(100)
)

create table MetodosPagos (
    IdMetodoPago tinyint primary key,
    Descripcion varchar(50)
)

create table EstadoEnvio (
    IdEnvio tinyint primary key,
    Descripcion varchar(100)
)

create table Pedidos (
    IdPedido bigint primary key,
    IdCliente int foreign key references Clientes(IdCliente),
    FechaPedido date not null default Getdate(),
    IdEstadoPedido tinyint foreign key references EstadosPedidos(IdEstadoPedido),
    IdMetodoPago tinyint foreign key references MetodosPagos(IdMetodoPago),
    IdEnvio TINYINT foreign key references EstadoEnvio(IdEnvio),
	PrecioTotal money not null
)

create table DetallePedidos (
    IdPedido bigint foreign key references Pedidos(IdPedido),
    IdProducto int foreign key references Productos(IdProducto),
    Cantidad tinyint not null,
    PrecioUnitario money not null,
	Subtotal money not null,
    primary key (IdPedido, IdProducto)
)
