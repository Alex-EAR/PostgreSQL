--######################################################################
--					CREACIÓN DE TABLAS
--######################################################################
--ENTIDADES:
create table obraSocial(
	nomOS varchar,
	direccion varchar,
	constraint oSocial_pk primary key(nomOS)
);
create table localidad(
	nomLoc varchar,
	constraint localidad_pk primary key(nomLoc)
);
create table paciente(
	cuilPac varchar,
	nomPac varchar,
	apePac varchar,
	fNac date,
	domicilio varchar,
	nomLoc varchar not null,
	cuilTutor varchar,
	nomOS varchar,
	constraint pers_pk primary key(cuilPac),
	constraint cTutor_fk foreign key(cuilTutor) references paciente(cuilPac) match simple on update cascade on delete cascade,
	constraint nombreO_fk foreign key(nomOS) references obraSocial(nomOS) on update cascade on delete cascade,
	constraint nomLoc_fk foreign key(nomLoc) references localidad(nomLoc) on update cascade on delete cascade
);
create table provincia(
	codProv integer,
	nomProv varchar,
	constraint prov_pk primary key(codProv)
);
create table especialista(
	nroM integer not null,
	cuilEsp varchar(15),
	nomEsp varchar,
	apeEsp varchar,
	fNac varchar(10),
	domicilio varchar,
	nomLoc varchar not null,
	codProv integer,
	constraint esp_pk primary key(cuilEsp),
	constraint codP_fk foreign key(codProv) references provincia(codProv) on update cascade on delete cascade,
	constraint nomLoc_fk foreign key(nomLoc) references localidad(nomLoc) on update cascade on delete cascade
);
create table terapia(
	nomTerapia varchar,
	tiempo varchar(8),
	constraint terapia_pk primary key(nomTerapia)
);
--TELÉFONOS:
create table telfOS(
	nomOS varchar,
	telefono varchar,
	primary key(nomOS, telefono)
);
create table telfPers(
	cuil varchar(15),	--cuil de Personas y Especialista
	telefono varchar,
	primary key(cuil, telefono)
);
--RELACIONES:
create table cubre(
	nomTerapia varchar,
	nomOS varchar,
	porcentaje float,
	primary key (nomTerapia,nomOS)
);
create table realiza(
	nomTerapia varchar,
	cuilEsp varchar(15),
	monto float,
	primary key(nomTerapia,cuilEsp)
);
create table solicita(
	cuilPac varchar(15), -- cuil de paciente
	nomTerapia varchar,
	cuilEsp varchar(15),	-- cuil de especialista
	fecha varchar(10),
	hora varchar(8),
	asistencia boolean,
	primary key(cuilPac,nomTerapia,cuilEsp,fecha)
);
--######################################################################
--					INSERCIÓN DE TUPLAS
--######################################################################
insert into obraSocial values
('Jerárquicos Salud','Santa Fe 1421 N'),
('Obra Social Provincia','Entre Ríos 1584 S'),
('Forjar Salud','Av. Córdoba 1512 NE'),
('CIMAC','25 de Mayo 2643 SO'),
('Galeno Argentina','Medoza 3642 E');
insert into localidad values
('Santa Lucía'),
('Rivadavia'),
('Chimbas'),
('Rawson'),
('Pocito'),
('Sarmiento'),
('Capital');
insert into paciente values
('32-54.862.791-5','Pissano','Fernández','1968/05/16','Sta. Cecilia de plata 1725 O','Capital',null,'Jerárquicos Salud'),
('51-12.030.261-9','Mario','Castañeda','1962/07/29','Manuel Berlgrano 1423 N','Santa Lucía',null,'CIMAC'),
('91-12.549.561-2','René','García Miranda','1970/03/12','Meglioli 1526 N','Rivadavia',null,'Forjar Salud'),
('25-15.648.923-7','Pepperoni','Roquefort','2000/04/17','Manuel Berlgrano 1423 N','Santa Lucía','51-12.030.261-9','CIMAC'),
('16-94.562.145-5','Tronx','García','20006/08/06','Meglioli 1526 N','Rivadavia','91-12.549.561-2','Galeno Argentina');
insert into provincia values
(1,'San Juan'),
(22,'Mendoza'),
(8,'Jujuy'),
(42,'Formosa'),
(69,'Santa Fe');
insert into especialista values
(25,'61-14.856.215-5','Lalo','Garza','1976/01/10','Mozanvique 1531 N','Chimbas',1),
(43,'35-54.212.548-1','Ricardo','Brust','1967/03/26','Tulún 1643 S','Rawson',69),
(13,'24-24.586.215-6','Mónica','Villaseñor','1966/11/29','Comandante Cabot 3475 NE','Pocito',8),
(55,'61-21.454.895-5','Gerardo','Reyero','1962/10/2','Saturnino Sarassa 1636 S','Sarmiento',8),
(73,'45-57.865.285-8','Mónica','Rial','1975/10/5','Talcahuano 1734 SO','Rivadavia',42),
(10,'20-20.032.045-0','María','González','1995/09/2','Paso de los toros 1810 S','Rivadavia',22);
insert into terapia values
('Kinesioterapia','10:00:00'),
('Técnicas miofasciales','02:30:00'),
('Terapia de conversión','15:30:00'),
('Limpieza de Colon','00:15:00'),
('Fisioterapia','5:15:00'),
('Terapia Ocupacional','2:15:00');
insert into telfOS values
('Jerárquicos Salud','264-4156589'),
('Jerárquicos Salud','264-4598965'),
('Forjar Salud','264-5625486'),
('CIMAC','264-4568952'),
('Galeno Argentina','264-4561895');
insert into telfPers values
('32-54.862.791-5','264-4156235'),
('51-12.030.261-9','264-5875654'),
('91-12.549.561-2','264-4589645'),
('25-15.648.923-7','264-5872315'),
('91-12.549.561-2','264-5892322'),
('61-14.856.215-5','264-5655123'),
('35-54.212.548-1','264-4445621'),
('24-24.586.215-6','264-4511235'),
('61-21.454.895-5','264-5562115'),
('45-57.865.285-8','264-5115522'),
('20-20.032.045-0','264-4159223'),
('20-20.032.045-0','264-5551239');
insert into cubre values
('Terapia Ocupacional','Jerárquicos Salud',0.45),
('Kinesioterapia','Forjar Salud',0.35),
('Limpieza de Colon','CIMAC',0.17),
('Fisioterapia','Galeno Argentina',0.39),
('Terapia de conversión','Jerárquicos Salud',0.41);
insert into realiza values
('Kinesioterapia','61-14.856.215-5'),
('Terapia Ocupacional','61-14.856.215-5'),
('Kinesioterapia','35-54.212.548-1'),
('Limpieza de Colon','24-24.586.215-6'),
('Fisioterapia','61-21.454.895-5'),
('Terapia de conversión','45-57.865.285-8'),
('Limpieza de Colon','20-20.032.045-0'),
('Terapia de conversión','20-20.032.045-0'),
('Técnicas miofasciales','20-20.032.045-0');
insert into solicita values
('32-54.862.791-5','Kinesioterapia','35-54.212.548-1','2023/07/29','08:30:00',true),
('91-12.549.561-2','Fisioterapia','61-21.454.895-5','2023/06/31','10:00:00',false),
('91-12.549.561-2','Terapia Ocupacional','61-14.856.215-5','2023/06/15','11:30:00',true),
('25-15.648.923-7','Limpieza de Colon','24-24.586.215-6','2023/07/15','10:30:00',true),
('16-94.562.145-5','Terapia de conversión','45-57.865.285-8','2023/07/20','09:30:00',true),
('91-12.549.561-2','Limpieza de Colon','20-20.032.045-0','2023/06/28','09:20:00',false),
('25-15.648.923-7','Terapia de conversión','20-20.032.045-0','2023/06/26','13:00:00',true),
('51-12.030.261-9','Limpieza de Colon','20-20.032.045-0','2023/07/1','07:45:00',true),
('91-12.549.561-2','Kinesioterapia','35-54.212.548-1','2023/07/15','11:30:00',true),
('91-12.549.561-2','Técnicas miofasciales','20-20.032.045-0','2023/06/29','10:30:00',false),
('91-12.549.561-2','Terapia de conversión','45-57.865.285-8','2023/07/30','14:30:00',true);
--######################################################################
--					CREACIÓN DE USUARIOS
--######################################################################
create user DBA

grant select, insert, update, delete  
on all tables 
in schema public TO DBA;

create user Director 

grant select 
on all tables 
in schema public TO Director;

create user especialista 

grant select, insert, update, delete
on persona
to especialista;
--######################################################################
--					IMPLEMENTACIÓN DE CONSULTAS
--######################################################################
create index listado_espec
on especialista(codProv);

--1
select *
from paciente
order by nomLoc;

--2
select *
from paciente
where cuilPac in (
					select cuilPac
					from solicita
					where nomTerapia = 'Fisioterapia');

--3
select * from paciente
where cuilPac in(
				select cuilPac from solicita
				where cuilEsp = '20-20.032.045-0'
				except
				select cuilPac from solicita
				where cuilEsp <> '20-20.032.045-0'
);

--4
select terapia.*, solicitudes 
from terapia join (
					select nomTerapia, count(nomTerapia) as solicitudes 
					from solicita
					group by nomTerapia
					order by solicitudes asc
					limit 5) as p
on terapia.nomTerapia = p.nomTerapia
order by solicitudes;

--5
select nomEsp, apeEsp
from (
		select cuilEsp, nomEsp, apeEsp
		from especialista natural join realiza
		where nomTerapia = 'Terapia Ocupacional'
		intersect
		select cuilEsp, nomEsp, apeEsp
		from especialista natural join realiza
		where nomTerapia = 'Kinesioterapia') as p;

--6
select nomPac, apePac
from paciente
where not exists(
				select nomTerapia
				from terapia
				where not exists(
								select *
								from solicita
								where solicita.cuilPac = paciente.cuilPac
								and solicita.nomTerapia = terapia.nomTerapia
	)
);

--######################################################################
--					CREACIÓN DE TABLA VIRTUAL
--######################################################################
create view DatosPaciente
as select *
from paciente;

select *
from DatosPaciente;

create user especialista; 

grant select, insert, update, delete
on DatosPaciente
to especialista;

--######################################################################
--					CREACIÓN Y RECUPERACIÓN DE BACKUP
--######################################################################
--1.- Creación de backup:

--Para crear el backup de la base de datos, utilizamos el comando “pg_dump” en la línea de
--comandos. Nos ubicamos en la carpeta donde está instalado PostgreSQL, utilizamos el nombre
--de usuaro y el nombre de la base de datos, y luego la dirección de la carpeta donde se va a
--guardar el archivo de backup, en este caso lo nombramos “backup.sql”.

--	C:\Program Files\PostgreSQL\15\bin>pg_dump -U postgres -d TrabajoGrupalFinal > C:\Users\R\Desktop\Escritorio\backup.sql
--	Contraseña:

--Nos va a pedir la contraseña del usuario, la ingresamos y generara el archivo.



--2.- Recuperación de backup:

--Para realizar la restauración, utilizamos “psql”, con el nombre de usuario y el nombre de la
--base de datos donde vamos a cargar el backup, la cual ya debe estar creada en pgadmin.

--	C:\Program Files\PostgreSQL\15\bin>psql -U postgres -d BdBackup -1 -f C:\Users\R\Desktop\Escritorio\backup.sql
--	Contraseña para usuario postgres:

--Ingresamos la contraseña y se cargara el backup en pgadmin.