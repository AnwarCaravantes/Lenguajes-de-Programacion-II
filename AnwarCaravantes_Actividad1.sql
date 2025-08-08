--Actividad #1 Creacion de Base de Datos // Lenguajes de Progamacion II
--Autor: Anwar D. Caravantes
--Fecha: Agosto 2025


-- Insertamos los datos del cat�logo de centros
create database UNI


-- Creamos la tablas de centros, puestos, empleados y directivos
use UNI

create table Centro(
	Numero_Centro varchar (10) primary key,
	Nombre_Centro varchar (100) not null,
	Ciudad varchar (50) not null
	)

create table Puesto(
	Numero_Puesto varchar (10) primary key,
	Nombre_Puesto varchar (50) not null,
	Descripcion_Puesto varchar (100) not null
	)


create table Empleado(
	Numero_Empleado int identity (1,1) primary key,
	Nombre varchar (50) not null,
	Apellido_Paterno varchar (50) not null,
	Apellido_Materno varchar (50) not null,
	Fecha_Nacimiento date not null,
	RFC AS (
		UPPER(
		SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Apellido_Paterno, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), 1, 1) + 
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Apellido_Paterno, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), PATINDEX('%[aeiou]%', REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Apellido_Paterno, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U')), 1) +
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Apellido_Materno, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), 1, 1) +
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Nombre, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), 1, 1) +
        RIGHT(YEAR(Fecha_Nacimiento), 2) + 
        FORMAT(MONTH(Fecha_Nacimiento), '00') + 
        FORMAT(DAY(Fecha_Nacimiento), '00')
		)
	),
	Es_Directivo bit not null,
	Numero_Centro varchar (10),
	Numero_Puesto varchar (10),
	foreign key (Numero_Centro) references Centro(Numero_Centro),
	foreign key (Numero_Puesto) references Puesto(Numero_Puesto)
	)

create table Directivo(
	Numero_Empleado int primary key,
	Centro_Supervisa varchar (10),
	Prestacion_Combustible bit,
	foreign key (Numero_Empleado) references Empleado(Numero_Empleado)
	)

-- Insertamos los datos de las tablas de centro, puestos, empleados y directivo

insert into Centro (Numero_Centro, Nombre_Centro, Ciudad) values
('000201', 'Tiendas �ngel Flores Ropa', 'Culiac�n'),
('000202', 'Tiendas �ngel Flores Muebles', 'Culiac�n'),
('000203', 'Tiendas �ngel Flores Cajas', 'Culiac�n'),
('049001', 'La Primavera Ropa', 'Culiac�n'),
('049002', 'La Primavera Muebles', 'Culiac�n'),
('049003', 'La Primavera Cajas', 'Culiac�n');

insert into Puesto (Numero_Puesto, Nombre_Puesto, Descripcion_Puesto) values
('PU001', 'Cajero', 'Responsable de la caja principal'),
('PU002', 'Gerente de Ventas', 'Supervisora de equipo de ventas'),
('PU003', 'Encargado de Almac�n', 'Control de inventario y pedidos'),
('PU004', 'Vendedor', 'Atenci�n al cliente en piso de ventas'),
('PU005', 'Contador', 'Manejo de finanzas y n�minas');

insert into Empleado (Nombre, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, Es_Directivo, Numero_Centro, Numero_Puesto) values
('Juan', 'Mart�nez', 'L�pez', '1995-05-15', 0, '000203', 'PU001'),
('Mar�a', 'G�mez', 'Ram�rez', '1992-11-20', 1, '049001', 'PU002'),
('Carlos', 'Hern�ndez', 'P�rez', '1985-08-10', 0, '000202', 'PU003'),
('Laura', 'D�az', 'Morales', '2000-02-25', 0, '049002', 'PU004'),
('Pedro', 'S�nchez', 'Torres', '1978-07-07', 0, '000201', 'PU005');

insert into Directivo (Numero_Empleado, Centro_Supervisa, Prestacion_Combustible) values
-- Directivo Maria G�mez Ram�rez (Gerente de Ventas)
(2, '049003', 1); 



--Para mostrar las tablas
select * from Centro

select * from Puesto

select * from Empleado

select * from Directivo

-- Para mostrar la tabla del reporte final como nos indica la activdad
select
	E.Numero_Empleado,
	concat (E.Nombre, ' ', E.Apellido_Paterno, ' ', E.Apellido_Materno) as 'Nombre_Completo',
	E.Fecha_Nacimiento,
	E.RFC,
	C.Nombre_Centro,
	P.Nombre_Puesto,
	case 
		when E.Es_Directivo = 1 then 'Si'
		else 'No'
	end as '�Es Directivo?'
from
	Empleado as E
inner join
	Centro as C on E.Numero_Centro = C.Numero_Centro
inner join
	Puesto as P on E.Numero_Puesto = P.Numero_Puesto;