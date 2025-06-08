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
	IdRol tinyint primary key identity (1,1),
	Descripcion VARCHAR(25) not null unique
)

create table Clientes(
	IdCliente int primary key identity(1,1),
	CorreoElectronico NVARCHAR(100) not null unique, 
	Contraseña NVARCHAR(50) not null,
	IdRol tinyint not null foreign key references Rol(IdRol),
	Activo bit not null default 1, 
	FechaCreacion date not null default Getdate(),
	Documento int not null unique, 
	Nombre VARCHAR(100) not null, 
	Apellido VARCHAR(100) not null,
	NumTelefono VARCHAR(20) not null, 
	Direccion VARCHAR(100) not null
)

create table Categorias(
	IdCategoria int primary key identity(1, 1),
	Nombre varchar(50) not null unique
)

create table Marcas(
	IdMarca int primary key identity(1, 1),
	Nombre varchar(50) not null unique
)

create table Productos(
	IdProducto int primary key identity(1, 1),
        IdCategoria int not null foreign key references Categorias(IdCategoria),
	IdMarca int not null foreign key references Marcas(IdMarca),
	Nombre varchar(100) not null,
	Stock int not null check (Stock >= 0),
	PrecioSinIva money not null,
	PrecioConIva money not null,
	PorcentajeIVA tinyint not null check (PorcentajeIVA between 0 and 100),
	Activo bit not null default 1
)
	
create table EstadosPedidos (
    IdEstadoPedido tinyint primary key identity(1,1),
    Descripcion varchar(100) not null unique
)

create table MetodosPagos (
    IdMetodoPago tinyint primary key identity(1,1),
    Descripcion varchar(50) not null unique
)

create table EstadosEnvio (
    IdEnvio tinyint primary key identity(1,1),
    Descripcion varchar(100) not null unique
)

create table Pedidos (
    IdPedido bigint primary key identity(1,1),
    IdCliente int foreign key references Clientes(IdCliente),
    FechaPedido date not null default Getdate(),
    IdEstadoPedido tinyint foreign key references EstadosPedidos(IdEstadoPedido),
    IdMetodoPago tinyint foreign key references MetodosPagos(IdMetodoPago),
    IdEnvio TINYINT foreign key references EstadosEnvio(IdEnvio),
    PrecioTotal money not null
)

create table DetallePedidos (
    IdPedido bigint not null foreign key references Pedidos(IdPedido),
    IdProducto int not null foreign key references Productos(IdProducto),
    Cantidad tinyint not null check (Cantidad >= 1),
    PrecioUnitario money not null,
    Subtotal money not null,
    primary key (IdPedido, IdProducto)
)
