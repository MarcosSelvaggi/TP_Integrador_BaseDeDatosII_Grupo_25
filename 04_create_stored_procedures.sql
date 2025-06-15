use Ecommerce_DB
go

create or alter procedure SP_AgregarUsuario
	@IDRol tinyint,
    @Email nvarchar(100),
    @Contraseña nvarchar(100),
    @Activo bit,
    @NumeroDocumento varchar(50),
    @TipoDocumento varchar(20),
	@NumeroTelefono varchar(20),
    @Nombre varchar(100),
    @Apellido varchar(100)
as
begin
    begin try
		begin transaction

			insert into Usuarios (IDRol, Email, Contraseña, Activo)
			values (@IDRol, @Email, @Contraseña, @Activo);

			declare @IDUsuario int = scope_identity();

			if @IDRol = 1
			begin
				insert into Clientes (IDUsuario, NumeroDocumento, TipoDocumento, NumeroTelefono, Nombre, Apellido)
				values (@IDUsuario, @NumeroDocumento, @TipoDocumento, @NumeroTelefono, @Nombre, @Apellido);
			end

		commit transaction

        print ('Usuario agregado correctamente.');

    end try
    begin catch
		rollback transaction;
        raiserror('Error al agregar el usuario', 16, 1);
    end catch
end
go
exec SP_AgregarUsuario 1, 'pepeguy@gmail.com', 'juju1234', 1, 123456789, 'Argentino', '123456', 'Pepe', 'Lopez';

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
