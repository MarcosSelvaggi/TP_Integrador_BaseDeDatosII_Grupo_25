use Ecommerce_DB
go

create trigger TR_EliminarCliente on Clientes
instead of delete
as
begin
	begin try
		update Clientes set Estado = 0
		where IdCliente in (select IdCliente from deleted);
		print('Cliente desactivado correctamente.')
	end try
	begin catch
		raiserror('Error al intentar desactivar el cliente', 16, 1)
	end catch
end

delete Clientes where IdCliente = 15