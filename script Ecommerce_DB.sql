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
	IdCliente int not null foreign key references Usuarios(IdCliente), 
	Nombre VARCHAR(100) not null, 
	Apellido VARCHAR(100) not null,
	NumTelefono VARCHAR(20) not null, 
	Direccion VARCHAR(100) not null
)