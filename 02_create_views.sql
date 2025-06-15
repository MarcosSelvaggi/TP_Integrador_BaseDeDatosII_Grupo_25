use Ecommerce_DB
go

create view VW_ClientesEstados as
select
	C.IdCliente,
	C.Nombre + ', ' + C.Apellido as 'Nombre y Apellido',
	C.CorreoElectronico,
	R.Descripcion as 'Rol',
	C.Activo
from
	Clientes C
inner join Rol R on C.IdRol = R.IdRol;
go 
select * from VW_ClientesEstados
go

create or alter view VW_PedidosPorMetodosDePago as 
select 
	MP.Descripcion ,count(*) as 'Cantidad'
	from Pedidos P 
	Inner join MetodoDePagos MP on P.IdMetodoPago = MP.IdMetodoPago
	group by MP.Descripcion
GO 
Select * from VW_PedidosPorMetodosDePago
GO

--Vista de Productos más vendidos
create or alter view VW_ProductosMasVendidos as
select 
    p.IdProducto,
    p.Nombre,
    sum(dp.Cantidad) as TotalVendido
from DetalleDePedidos dp
inner join Productos p on p.IdProducto = dp.IdProducto
group by p.IdProducto, p.Nombre
GO
select * from VW_ProductosMasVendidos