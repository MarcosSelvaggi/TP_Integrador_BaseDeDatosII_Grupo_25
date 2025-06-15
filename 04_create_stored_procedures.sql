use Ecommerce_DB
go

create procedure SP_AgregarCliente (
	@CorreoElectronico NVARCHAR(100),
    @Contraseña VARCHAR(50),
    @IdRol TINYINT,
    @Estado BIT,
    @FechaCreacion DATE,
    @Documento INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @NumTelefono VARCHAR(20),
    @Direccion VARCHAR(100)
	) as
begin
	begin try
		insert into
		Clientes (CorreoElectronico, Contraseña, IdRol, Activo, FechaCreacion, Documento, Nombre, Apellido, NumTelefono, Direccion)
        values (
            @CorreoElectronico, @Contraseña, @IdRol, @Estado, @FechaCreacion, @Documento, @Nombre, @Apellido, @NumTelefono, @Direccion);

        print('Cliente agregado correctamente.');
    end try
    begin catch
        raiserror('Error al agregar el cliente',16, 1);
    end catch
end
go
exec SP_AgregarCliente 'lologuitar@gmail.com', '123456', 1, 1, '2025-09-09', 123456789, 'Moloc', 'Suarez', '212314', 'Calle bella 14';
go

create or alter procedure sp_registrarPedido(
	@IdCliente int, 
	@IdMetodoPago tinyint 
	) as 
BEGIN
	begin try 
		insert into Pedidos 
		values (@IdCliente, GETDATE(), 1, @IdMetodoPago, 1, 0)
	end try
	begin catch 
		raiserror('Error al registrar el pedido', 16, 2)
	end catch 
END
GO
exec sp_registrarPedido 2, 1 

GO
create or alter procedure SP_InsertarProducto
    @IdCategoria int,
    @IdMarca int,
    @Nombre varchar(100),
    @Stock int,
    @PrecioSinImpuestos money,
    @PorcentajeImpuestos tinyint,
    @Activo bit
as
begin
    begin try
		begin transaction
			declare @PrecioConImpuestos money
			--Calcula el PrecioConIva
			set @PrecioConImpuestos = @PrecioSinImpuestos * (1 + (@PorcentajeImpuestos / 100.0))
			--Inserta el Producto con sus datos y el PrecioConIva calculado
			insert into Productos (IdCategoria, IdMarca, Nombre, Stock, PrecioSinImpuestos, PrecioConImpuestos, Impuestos, Activo)
			values (@IdCategoria, @IdMarca, @Nombre, @Stock, @PrecioSinImpuestos, @PrecioConImpuestos, @PorcentajeImpuestos, @Activo)

			commit transaction
			print 'Producto insertado correctamente.'
    end try
    begin catch
        raiserror('Error al insertar el producto', 16, 1)
        rollback transaction
    end catch
end;
GO
exec SP_InsertarProducto 1, 1, 'Silla de escritorio', 10, 100, 21, 1
