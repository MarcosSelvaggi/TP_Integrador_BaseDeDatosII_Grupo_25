use Ecommerce_DB
go

create or alter view VW_ClientesEstados as
select
    U.IDUsuario,
    C.Nombre + ', ' + C.Apellido as 'Nombre y Apellido',
    U.Email,
    R.Descripcion AS Rol,
    U.Activo
from
    Usuarios U
inner join Clientes C on C.IDUsuario = U.IDUsuario
inner join Rol R on U.IDRol = R.IDRol;
go 
select * from VW_ClientesEstados
go

create or alter view VW_PedidosPorMetodosDePago as 
select 
	MP.Descripcion ,count(*) as 'Cantidad'
	from DetalleDePagos DP 
	Inner join MetodosDePago MP on DP.IDMetodoPago = MP.IdMetodoPago
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