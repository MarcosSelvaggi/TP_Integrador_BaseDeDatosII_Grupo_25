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

insert into Rol values ('Administrador')
insert into Rol values ('Usuario')

create table Usuarios(
	IdCliente int not null primary key identity(1,1),
	CorreoElectronico NVARCHAR(100) not null, 
	Contraseña VARCHAR(50) not null,
	IdRol tinyint not null foreign key references Rol(IdRol),
	Estado bit not null, 
	FechaCreacion date not null
)

create table DatosUsuarios(
	Documento int not null primary key, 
	IdCliente int not null unique foreign key references Usuarios(IdCliente), 
	Nombre VARCHAR(100) not null, 
	Apellido VARCHAR(100) not null,
	NumTelefono VARCHAR(20) not null, 
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
	Precio money not null,
	Stock int not null,
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
    IdCliente int foreign key references Usuarios(IdCliente),
    FechaPedido date not null default Getdate(),
    IdEstadoPedido tinyint foreign key references EstadosPedidos(IdEstadoPedido),
    IdMetodoPago tinyint foreign key references MetodosPagos(IdMetodoPago),
    IdEnvio TINYINT foreign key references EstadoEnvio(IdEnvio)
)

create table DetallePedidos (
    IdCliente int foreign key references Usuarios(IdCliente),
    IdPedido bigint foreign key references Pedidos(IdPedido),
    IdProducto int foreign key references Productos(IdProducto),
    Cantidad tinyint,
    PrecioUnitario money,
    primary key (IdCliente, IdPedido)
    --primary key (IdPedido, IdProducto)
)
