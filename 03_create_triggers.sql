use Ecommerce_DB
go

create trigger TR_EliminarCliente on Clientes
instead of delete
as
begin
	begin try
		update Clientes set Activo = 0
		where IdCliente in (select IdCliente from deleted);
		print('Cliente desactivado correctamente.')
	end try
	begin catch
		raiserror('Error al intentar desactivar el cliente', 16, 1)
	end catch
end

delete Clientes where IdCliente = 15

go

create or alter trigger TR_InsertarDetallePedido on DetallePedidos 
after insert 
as 
--Inicio TR 
BEGIN
	--Inicio de transacción 
	begin transaction 
		--Inicio de Try
		begin try
			update Pedidos set PrecioTotal = PrecioTotal + (select Subtotal from inserted) 
			where IdPedido = (select IdPedido from inserted) ;

			update Productos set Stock = Stock - (select cantidad from inserted)
			where IdProducto = (select IdProducto from inserted);
		end try 
		--Inicio de catch 
		begin catch 
			rollback
			raiserror('Error al intentar agregar el pedido al historial', 16, 3)
			return 
		end catch 
		--Fin de catch
		commit transaction
END 
--Fin TR 

go
create or alter trigger TR_DevolverStock on Pedidos
after update 
as 
--Inicio TR 
BEGIN 
	if((select IdEstadoPedido from inserted) = 4)
		--Inicio If
		Begin
			--Inicio transacción
			begin transaction 
				--Inicio try
				begin try 
					Declare @CantProductosUnicos tinyint; 
					select @CantProductosUnicos = count(*) from DetallePedidos where IdPedido = (select IdPedido from inserted)
					Declare @aux tinyint = 0; 
					While (@aux < @CantProductosUnicos)
						--Inicio While
						begin 
							--Trae el ID del producto, salteando las filas que le pasa la variable auxiliar
							Declare @IdProducto int; 
							select @IdProducto = IdProducto 
							from DetallePedidos 
							order by IdProducto
							offset @aux row fetch next 1 row only;

							--Usando el ID anterior sacamos la cantidad para después sumarla en el update siguiente 
							Declare @cantidadProducto smallint; 
							select @cantidadProducto = Cantidad from DetallePedidos where IdPedido = @IdProducto

							update Productos set stock = stock + @cantidadProducto where IdProducto = @IdProducto
							
							set @aux = @aux + 1; 
						end 
				end try 
				--Inicio catch 
				begin catch 
				rollback 
				raiserror('Error al cancelar el pedido', 16, 4);
				return
				end catch 
				--Fin catch
			commit transaction 
			print('Se ha cancelado el pedido satisfactoriamente y se hacen devuelto los productos.')
		end
		--Fin If 
END 
--Fin TR