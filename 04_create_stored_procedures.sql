use Ecommerce_DB
go

create procedure SP_AgregarCliente (
	@CorreoElectronico NVARCHAR(100),
    @Contraseña VARCHAR(50),
    @IdRol TINYINT,
    @Estado BIT,
    @FechaCreacion DATE,
    @Documento INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @NumTelefono VARCHAR(20),
    @Direccion VARCHAR(100)
	) as
begin
	begin try
		insert into
		Clientes (CorreoElectronico, Contraseña, IdRol, Estado, FechaCreacion, Documento, Nombre, Apellido, NumTelefono, Direccion)
        values (
            @CorreoElectronico, @Contraseña, @IdRol, @Estado, @FechaCreacion, @Documento, @Nombre, @Apellido, @NumTelefono, @Direccion);

        print('Cliente agregado correctamente.');
    end try
    begin catch
        raiserror('Error al agregar el cliente',16, 1);
    end catch
end

exec SP_AgregarCliente 'lologuitar@gmail.com', '123456', 1, 1, '2025-09-09', 123456789, 'Moloc', 'Suarez', '212314', 'Calle bella 14';