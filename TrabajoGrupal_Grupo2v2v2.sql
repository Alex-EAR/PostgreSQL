--######################################################################
--					CREACIÓN DE TABLAS
--######################################################################
--ENTIDADES:

create table obraSocial(
	nombreO varchar not null unique,
	direccion varchar,
	constraint oSocial_pk primary key(nombreO)
);
create table paciente(
	cuil varchar unique,
	nombre varchar,
	apellido varchar,
	fNac date,
	domicilio varchar,
	localidad varchar,
	cTutor varchar,
	nombreO varchar,
	constraint pers_pk primary key(cuil),
	constraint cTutor_fk foreign key(cTutor) references paciente(cuil) match simple on update cascade on delete cascade,
	constraint nombreO_fk foreign key(nombreO) references obraSocial(nombreO) on update cascade on delete cascade
);
create table provincia(
	cod integer not null,
	constraint prov_pk primary key(cod)
);
create table especialista(
	nroM integer not null unique,
	cuil varchar(15) not null,
	nombre varchar,
	apellido varchar,
	fNac varchar(10),
	domicilio varchar,
	localidad varchar,
	codP integer,
	constraint esp_pk primary key(cuil),
	constraint codP_fk foreign key(codP) references provincia(cod) on update cascade on delete cascade
);
create table terapia(
	nombre varchar not null unique,
	tiempo varchar(8),
	constraint terapia_pk primary key(nombre)
);
--TELÉFONOS:
create table telfOS(
	nombreO varchar,
	telefono varchar unique,
	primary key(nombreO, telefono)
);
create table telfPers(
	cuil varchar(15),
	telefono varchar unique,
	primary key(cuil, telefono)
);
--RELACIONES:
create table cubre(
	nombreT varchar not null,
	nombreO varchar not null,
	porcentaje float,
	primary key (nombreT,nombreO)
);
create table realiza(
	nombreT varchar not null,
	cuil varchar(15) not null,
	monto float,
	primary key(nombreT,cuil)
);
create table solicita(
	cuilP varchar(15) not null, -- cuil de paciente
	nombreT varchar not null,
	cuilE varchar(15) not null,	-- cuil de especialista
	fecha varchar(10),
	hora varchar(8),
	asistencia boolean,
	primary key(cuilP,nombreT,cuilE)
); --CONSULTAR!!!
--######################################################################
--					INSERCIÓN DE TUPLAS
--######################################################################
insert into obraSocial values
('Jerárquicos Salud','Santa Fe 1421 N'),
('Obra Social Provincia','Entre Ríos 1584 S'),
('Forjar Salud','Av. Córdoba 1512 NE'),
('CIMAC','25 de Mayo 2643 SO'),
('Galeno Argentina','Medoza 3642 E');
insert into paciente values
('32-54.862.791-5','Pissano','Fernández','1968/05/16','Sta. Cecilia de plata 1725 O','Capital',null,'Jerárquicos Salud'),
('51-12.030.261-9','Mario','Castañeda','1962/07/29','Manuel Berlgrano 1423 N','Santa Lucía',null,'CIMAC'),
('91-12.549.561-2','René','García Miranda','1970/03/12','Meglioli 1526 N','Rivadavia',null,'Forjar Salud'),
('25-15.648.923-7','Pepperoni','Roquefort','2000/04/17','Manuel Berlgrano 1423 N','Santa Lucía','51-12.030.261-9','CIMAC'),
('16-94.562.145-5','Tronx','García','20006/08/06','Meglioli 1526 N','Rivadavia','91-12.549.561-2','Galeno Argentina');
insert into provincia values
(1),
(22),
(8),
(42),
(69);
insert into especialista values
(10,'20-20.032.045-0','María','González','1995/09/2','Paso de los toros 1810 S','Rivadavia',22),
(25,'61-14.856.215-5','Lalo','Garza','1976/01/10','Mozanvique 1531 N','Chimbas',1),
(43,'35-54.212.548-1','Ricardo','Brust','1967/03/26','Tulún 1643 S','Rawson',69),
(13,'24-24.586.215-6','Mónica','Villaseñor','1966/11/29','Comandante Cabot 3475 NE','Pocito',8),
(55,'61-21.454.895-5','Gerardo','Reyero','1962/10/2','Saturnino Sarassa 1636 S','Sarmiento',8),
(73,'45-57.865.285-8','Mónica','Rial','1975/10/5','Talcahuano 1734 SO','Rivadavia',42);
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
('45-57.865.285-8','264-5115522');
insert into cubre values
('Terapia Ocupacional','Jerárquicos Salud',0.45),
('Kinesioterapia','Forjar Salud',0.35),
('Limpieza de Colon','CIMAC',0.17),
('Fisioterapia','Galeno Argentina',0.39),
('Terapia de conversión','Jerárquicos Salud',0.41);
insert into realiza values
('Terapia Ocupacional','61-14.856.215-5'),
('Kinesioterapia','35-54.212.548-1'),
('Limpieza de Colon','24-24.586.215-6'),
('Fisioterapia','61-21.454.895-5'),
('Terapia de conversión','45-57.865.285-8');
insert into solicita values
('32-54.862.791-5','Kinesioterapia','35-54.212.548-1','2023/07/29','08:30:00',true),
('51-12.030.261-9','Fisioterapia','61-21.454.895-5','2023/06/31','10:00:00',false),
('91-12.549.561-2','Terapia Ocupacional','61-14.856.215-5','2023/06/15','11:30:00',true),
('25-15.648.923-7','Limpieza de Colon','24-24.586.215-6','2023/07/15','10:30:00',true),
('16-94.562.145-5','Terapia de conversión','45-57.865.285-8','2023/07/20','09:30:00',true);
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
to especialista

--######################################################################
--					IMPLEMENTACIÓN DE CONSULTAS
--######################################################################
create index listado_espec
on especialista(codP)

--1
select *
from paciente
order by localidad

--2
select *
from paciente
where cuil in (
			select cuilP
			from solicita
			where nombreT = 'Fisioterapia'
)

--5
select nombre, apellido
from especialista natural join realiza
where nombreT = 'Terapia Ocupacional'
intersect
select nombre, apellido
from especialista natural join realiza
where nombreT = 'Kinesioterapia'

--6
select nombre, apellido
from paciente
where not exists(
				select nombre
				from terapia
				where not exists(
								select *
								from solicita
								where solicita.cuilP = paciente.cuil
								and solicita.nombreT = terapia.nombre
	)
)

--######################################################################
--					CREACIÓN DE TABLA VIRTUAL
--######################################################################