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

			if @IDRol = 2
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
	@IdMetodoPago tinyint, 
	@EstadoDePago VARCHAR(50)
	) as 
BEGIN
	begin try 
		Begin transaction 
			--Obtenemos el ID del último pago ingresado y le sumamos 1 para poder ingresarlo en el detalle de la tabla Detalles Pagos
			Declare @IdDetallePagos int 
			select top 1 @IdDetallePagos = IDPago from DetalleDePagos order by IDPago desc 
			Set @IdDetallePagos = @IdDetallePagos + 1 

			--Obtenemos la descripción del método de pago para poder usarlo en el detalle de la tabla detalle pagos 
			Declare @MetodoPago Varchar(50) 
			select @MetodoPago = Descripcion from MetodosDePago where IDMetodoPago = @IdMetodoPago

			Insert into DetalleDePagos (IDMetodoPago, FechaDePago, EstadoPago, Detalles) 
			values (@IdMetodoPago, GETDATE(), @EstadoDePago, CONCAT('Pago con ', @MetodoPago, ' Pedido - ', @IdDetallePagos)) 
			
			--Después de ingresar el detalle pago se usa el scope_identity para saber cuál es el IDPago que se ingresó último
			insert into Pedidos (IDCliente, IDEnvio, IDEstadoPedido, FechaDePedido, PrecioTotal, IDPago)
			values (@IdCliente, 1, 1, GETDATE(), 0, SCOPE_IDENTITY())

		--Si no hay excepciones se confirma la transacción caso contrario se hace un rollback de la misma 
		Commit transaction
		print('Se registro el pedido correctamente')
	end try
	begin catch 
		Rollback transaction
		raiserror('Error al registrar el pedido', 16, 2)
	end catch 
END
GO
exec sp_registrarPedido 2, 1, 'Pendiente'
select * from pedidos
select * from DetalleDePagos

go 
select * from DetalleDePagos
select * from Pedidos

GO
create or alter procedure SP_InsertarProducto(
    @IdCategoria int,
    @IdMarca int,
    @Nombre varchar(100),
    @Stock int,
    @PrecioSinImpuestos money,
    @PorcentajeImpuestos tinyint,
    @Activo bit)
as
begin
    begin try
		begin transaction
			declare @PrecioConImpuestos money
			--Calcula el PrecioConImpuestos
			set @PrecioConImpuestos = @PrecioSinImpuestos * (1 + (@PorcentajeImpuestos / 100.0))
			--Inserta el Producto con sus datos y el PrecioConImpuestos calculado
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
exec SP_InsertarProducto 1, 1, 'Silla de escritorio', 10, 10000, 21, 1
