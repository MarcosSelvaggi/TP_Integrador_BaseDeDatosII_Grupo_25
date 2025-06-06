use Ecommerce_DB
go

create view VW_ClientesEstados as
select
	C.IdCliente,
	C.Nombre + ', ' + C.Apellido as 'Nombre y Apellido',
	C.CorreoElectronico,
	R.Descripcion as 'Rol',
	C.Estado
from
	Clientes C
inner join Rol R on C.IdRol = R.IdRol;

select * from VW_ClientesEstados