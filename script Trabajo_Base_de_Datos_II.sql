use Master 
go 
if NOT EXISTS (Select * From sys.databases WHERE name = 'Trabajo_Base_de_Datos_II')
begin 
Create Database Trabajo_Base_de_Datos_II; 
end; 
go 
Use Trabajo_Base_de_Datos_II



