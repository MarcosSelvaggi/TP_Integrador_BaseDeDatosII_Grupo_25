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

select * from pedidos
select DP.IDPedido, DP.IDProducto, P.Nombre, DP.Cantidad, DP.PrecioUnitario, P.Stock
from DetalleDePedidos DP 
Inner join  Productos P on DP.IDProducto = P.IDProducto
-- Trigger que se encarga de devolver el stock cuando se cancela un pedido
go
create or alter trigger TR_DevolverStock on Pedidos
after update 
as 
--Inicio TR 
BEGIN 
	--El trigger sólo se lleva a cabo si el pedido fue Cancelado y si no estaba cancelado anteriormente 
	if((select IdEstadoPedido from inserted) = 4 and (select IdEstadoPedido from deleted) != (select IdEstadoPedido from inserted))
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
							select @IdProducto = IdProducto from DetalleDePedidos where IDPedido = (select IDPedido from inserted)
							order by IdProducto offset @aux row fetch next 1 row only;

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
			print('Se ha cancelado el pedido satisfactoriamente y se han devuelto los productos.')
		end
		--Fin If 
END 
--Fin TR
update pedidos set IDEstadoPedido = 4 where IDPedido = 10


Go
--Trigger encargado de actualizar el Subtotal, el PrecioTotal y el Stock
create or alter trigger TR_ActualizarSubtotalPrecioTotalYStock
on DetalleDePedidos
after insert, update
as
begin
    begin try
        begin transaction

        -- Actualiza subtotal
        update DetalleDePedidos
        set Subtotal = Cantidad * PrecioUnitario
        where exists (
            select 1
            from inserted
            where inserted.IDPedido = DetalleDePedidos.IDPedido
              and inserted.IDProducto = DetalleDePedidos.IDProducto
        )

        -- Actualiza precio total del pedido
        update Pedidos
        set PrecioTotal = (
            select sum(Subtotal)
            from DetalleDePedidos
            where DetalleDePedidos.IDPedido = Pedidos.IDPedido
        )
        where IDPedido in (
            select IDPedido
            from inserted
        )

        -- Si es Insert resto el stock directamente
        if not exists (select 1 from deleted)
        begin
            declare @IDProducto int;
            declare @Cantidad int;

            select top 1 @IDProducto = IDProducto, @Cantidad = Cantidad
            from inserted;

            -- Validación de stock suficiente antes de restar
            if exists (
                select 1
                from Productos
                where IDProducto = @IDProducto
                  and (Stock - @Cantidad) < 0
            )
            begin
                print('Stock insuficiente para realizar la operación (Insert).');
                rollback transaction;
                return;
            end

            -- Restar stock
            update Productos
            set Stock = Stock - @Cantidad
            where IDProducto = @IDProducto;
        end
        else
        begin
            -- Si es Update, calculo la diferencia entre cantidad nueva y vieja
            declare @IDProductoActualizado int;
            declare @Cantidad_Nueva int;
            declare @Cantidad_Vieja int;
            declare @Diferencia int;

            select top 1
                @IDProductoActualizado = inserted.IDProducto,
                @Cantidad_Nueva = inserted.Cantidad,
                @Cantidad_Vieja = deleted.Cantidad
            from inserted
            inner join deleted on inserted.IDPedido = deleted.IDPedido
                and inserted.IDProducto = deleted.IDProducto;

            set @Diferencia = @Cantidad_Nueva - @Cantidad_Vieja;

            -- Validación de stock suficiente antes de ajustar
            if exists (
                select 1
                from Productos
                where IDProducto = @IDProductoActualizado
                  and (Stock - @Diferencia) < 0
            )
            begin
                print('Stock insuficiente para realizar la operación (Update).');
                rollback transaction;
                return;
            end

            -- Ajustar stock
            update Productos
            set Stock = Stock - @Diferencia
            where IDProducto = @IDProductoActualizado;
        end

        commit transaction

    end try
    begin catch
        rollback transaction;
        raiserror('Error en trigger TR_ActualizarSubtotalPrecioTotalYStock', 16, 1);
    end catch
end;
