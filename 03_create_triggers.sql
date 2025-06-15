use Ecommerce_DB
go

create or alter trigger TR_EliminarUsuario on Usuarios
instead of delete
as
begin
	begin try
		update Usuarios set Activo = 0
		where IDUsuario in (select IDUsuario from deleted);
		print('Usuario eliminado correctamente.')
	end try
	begin catch
		raiserror('Error al intentar eliminar el Usuario', 16, 1)
	end catch
end

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
					select @CantProductosUnicos = count(*) from DetalleDePedidos where IdPedido = (select IdPedido from inserted)
					Declare @aux tinyint = 0; 
					While (@aux < @CantProductosUnicos)
						--Inicio While
						begin 
							--Trae el ID del producto, salteando las filas que le pasa la variable auxiliar
							Declare @IdProducto int; 
							select @IdProducto = IdProducto 
							from DetalleDePedidos 
							order by IdProducto
							offset @aux row fetch next 1 row only;

							--Usando el ID anterior sacamos la cantidad para después sumarla en el update siguiente 
							Declare @cantidadProducto smallint; 
							select @cantidadProducto = Cantidad from DetalleDePedidos where IdPedido = @IdProducto

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
on DetalleDePedidos
after insert, update
as
begin
    begin try
        --  actualiza subtotal
        update DetalleDePedidos
		set Subtotal = Cantidad * PrecioUnitario
		where exists (
		select 1
		from inserted
		where inserted.IDPedido = DetalleDePedidos.IDPedido
		and inserted.IDProducto = DetalleDePedidos.IDProducto
		)

        -- actualiza precio total del pedido
        update Pedidos
        set PrecioTotal = (
            select sum(Subtotal)
            from DetalleDePedidos
            where DetalleDePedidos.IDPedido = Pedidos.IDPedido
        )
        where IDPedido in (
            select IDPedido
            from inserted
        );

        -- si es insert resto el stock directamente
        if not exists (select 1 from Deleted)
        begin
            declare @IDProducto int
			declare @Cantidad int

            select top 1 @IDProducto = idproducto, @Cantidad = cantidad
            from inserted;

            update Productos
            set Stock = Stock - @Cantidad
            where IDProducto = @IDProducto;
        end
        else
        begin
            -- si es update, calculo la diferencia entre cantidad nueva y vieja
            declare @IDProductoActualizado int
			declare @Cantidad_Nueva int
			declare @Cantidad_Vieja int

            select top 1 
                @IDProductoActualizado = inserted.idproducto,
                @Cantidad_Nueva = inserted.cantidad,
                @Cantidad_Vieja = deleted.cantidad
            from inserted
            inner join Deleted on inserted.idpedido = deleted.idpedido
			and inserted.idproducto = deleted.idproducto

            update Productos
            set Stock = Stock - (@Cantidad_Nueva - @Cantidad_Vieja)
            where IDProducto = @IDProductoActualizado
        end
    end try
    begin catch
        raiserror('Error en trigger TR_ActualizarSubtotalPrecioTotalYStock', 16, 1);
    end catch
end;