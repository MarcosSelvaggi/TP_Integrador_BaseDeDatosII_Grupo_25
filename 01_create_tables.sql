use Master 
go 
if NOT EXISTS (Select * From sys.databases WHERE name = 'Ecommerce_DB')
begin 
Create Database Ecommerce_DB ; 
end; 
go 
Use Ecommerce_DB
go


create table Rol (
    IDRol tinyint primary key identity(1,1),
    Descripcion varchar(100) not null unique
)

create table Usuarios (
    IDUsuario int primary key identity(1,1),
    IDRol tinyint not null foreign key references Rol(IDRol),
    Email nvarchar(100) not null unique,
    Contraseña nvarchar(100) not null,
    FechaDeCreacion datetime not null default Getdate(),
    Activo bit not null default 1
)

create table Clientes (
    IDCliente int primary key identity(1,1),
    IDUsuario int not null foreign key references Usuarios(IDUsuario),
    NumeroDocumento varchar(50) not null unique,
    TipoDocumento varchar(20) not null,
    NumeroTelefono varchar(20) not null,
    Nombre varchar(100) not null,
    Apellido varchar(100) not null
)

create table Direcciones (
    IDDireccion int primary key identity(1,1),
    IDCliente int not null foreign key references Clientes(IDCliente),
    Direccion varchar(255) not null,
    Nombre varchar(100) not null
)

create table Categorias (
    IDCategoria int primary key identity(1,1),
    Nombre varchar(100) not null unique
)

create table Marcas (
    IDMarca int primary key identity(1,1),
    Nombre varchar(100) not null unique
)

create table Productos (
    IDProducto int primary key identity(1,1),
    IDMarca int not null foreign key references Marcas(IDMarca),
    IDCategoria int not null foreign key references Categorias(IDCategoria),
    Nombre varchar(100) not null unique,
    Stock int not null check (stock >= 0),
    PrecioSinImpuestos money not null,
    PrecioConImpuestos money null,
    Impuestos tinyint not null default 21 check (Impuestos between 0 and 100),
    Activo bit not null default 1
)

create table EstadoDePedidos (
    IDEstadoPedido tinyint primary key identity(1,1),
    Descripcion varchar(100) not null unique
)

create table MetodosDePago (
    IDMetodoPago tinyint primary key identity(1,1),
    Descripcion varchar(100) not null unique
)

create table DetalleDePagos (
    IDPago int primary key identity(1,1),
    IDMetodoPago tinyint not null foreign key references MetodosDePago(IDMetodoPago),
    FechaDePago datetime not null,
    EstadoPago varchar(50) not null,
    Detalles varchar(255) not null
)

create table EstadoDeEnvios (
    IDEnvio int primary key identity(1,1),
    FechaDeEnvio datetime not null,
    Descripcion varchar(255) not null
)

create table Pedidos (
    IDPedido int primary key identity(1,1),
    IDCliente int not null foreign key references Clientes(IDCliente),
    IDEnvio int not null foreign key references EstadoDeEnvios(IDEnvio),
    IDEstadoPedido tinyint not null foreign key references EstadoDePedidos(IDEstadoPedido),
    FechaDePedido datetime not null default Getdate(),
    PrecioTotal money null,
    IDPago int not null foreign key references DetalleDePagos(IDPago)
)

create table DetalleDePedidos (
    IDPedido int not null foreign key references Pedidos(IDPedido),
    IDProducto int not null foreign key references Productos(IDProducto),
    Cantidad int not null check (Cantidad >= 1),
    PrecioUnitario money not null,
    Subtotal money null,
    Impuestos tinyint not null default 21 check (Impuestos between 0 and 100),
    primary key (IDPedido, IDProducto)
)
