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
GO
--Trigger encargado de actualizar el Subtotal, el PrecioTotal y el Stock
create or alter trigger TR_ActualizarSubtotalPrecioTotalYStock
on DetallePedidos
after insert, update
as
begin
    begin try
		-- Actualiza Subtotal en DetallePedidos
		update dp
		set Subtotal = dp.Cantidad * dp.PrecioUnitario
		from DetallePedidos dp
		inner join inserted i on dp.IdPedido = i.IdPedido and dp.IdProducto = i.IdProducto

		-- Actualiza PrecioTotal en Pedidos
		update p
		set PrecioTotal = (
			select sum(Subtotal)
			from DetallePedidos
			where IdPedido = p.IdPedido
		)
		from Pedidos p
		inner join inserted i on p.IdPedido = i.IdPedido

		-- Actualiza Stock en Productos
		update pr
		set pr.Stock = pr.Stock - i.Cantidad
		from Productos pr
		inner join inserted i 
		on pr.IdProducto = i.IdProducto;
    end try
    begin catch
		raiserror('Error en trigger ActualizarSubtotalYPrecioTotal', 16, 1)
	end catch
end;
