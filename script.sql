CREATE DATABASE taller;

CREATE TABLE tipoDocumento (
    idTipoDoc int NOT NULL IDENTITY(1,1),
	nombre varchar(100) NOT NULL,
	sigla varchar(50) NOT NULL,
	CONSTRAINT PK_TipoDoc PRIMARY KEY (idTipoDoc),
);

CREATE TABLE persona (
    idPersona bigint NOT NULL IDENTITY(1,1),
	idTipoDoc int NOT NULL,
	numeroDoc varchar(50) NOT NULL,
	telefono numeric(18, 0) NOT NULL,
	nombre1 varchar(50) NOT NULL,
	nombre2 varchar(50) ,
	apellido1 varchar(50) NOT NULL,
	apellido2 varchar(50) ,
	email varchar(100) NOT NULL,
	direccion varchar(max) NOT NULL,
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Persona PRIMARY KEY (idPersona),
	CONSTRAINT FK_PersonaTipoDoc FOREIGN KEY (idTipoDoc)
    REFERENCES tipoDocumento(idTipoDoc)
);


CREATE TABLE vehiculo (
    idVehiculo bigint NOT NULL IDENTITY(1,1),
	placa varchar(30) NOT NULL,
	marca varchar(50) NOT NULL,
	telefono numeric(18, 0) NOT NULL,
	modelo varchar(50) NOT NULL,
	idPersona bigint NOT NULL,	
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Vehiculo PRIMARY KEY (idVehiculo),
	CONSTRAINT FK_VehiculoPersona FOREIGN KEY (idPersona)
    REFERENCES persona(idPersona)
);

CREATE TABLE rol (
    idRol int NOT NULL IDENTITY(1,1),
	nombre varchar(50) NOT NULL,	
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Rol PRIMARY KEY (idRol)
);

CREATE TABLE rolpersona (
    idRolPersona bigint NOT NULL IDENTITY(1,1),
	idPersona bigint NOT NULL,
	idRol int NOT NULL,	
	estado varchar(10) NOT NULL,	
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_RolPersona PRIMARY KEY (idRolPersona),
	CONSTRAINT FK_RolPersonaRol FOREIGN KEY (idRol)
    REFERENCES rol(idRol),
	CONSTRAINT FK_PesonaRolPersona FOREIGN KEY (idPersona)
    REFERENCES persona(idPersona)
);



CREATE TABLE servicio (
    idServicio int NOT NULL IDENTITY(1,1),
	nombre varchar(100) NOT NULL,
	precioMin int NOT NULL,		
	precioMax int NOT NULL,		
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Servicio PRIMARY KEY (idServicio)
);

CREATE TABLE mantenimiento (
    idMantenimiento bigint NOT NULL IDENTITY(1,1),
	idVehiculo bigint NOT NULL,
	idMecanico bigint NOT NULL,
	presupuesto int NOT NULL,
	tiempo varchar(50) NOT NULL,		
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Mantenimiento PRIMARY KEY (idMantenimiento),
	CONSTRAINT FK_ManteniVehiculo FOREIGN KEY (idVehiculo)
    REFERENCES vehiculo(idVehiculo),
	CONSTRAINT FK_ManteniMecanico FOREIGN KEY (idMecanico)
    REFERENCES persona(idPersona)
);

CREATE TABLE serviMantenimiento (
    idServiManteni bigint NOT NULL IDENTITY(1,1),
	idMantenimiento bigint NOT NULL,
	idServicio int NOT NULL,
	estado varchar(50) NOT NULL,
	precio int NOT NULL,			
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_ServiManteni PRIMARY KEY (idServiManteni),
	CONSTRAINT FK_serviManteniServ FOREIGN KEY (idServicio)
    REFERENCES servicio(idServicio),
	CONSTRAINT FK_ManteServiMantenimi FOREIGN KEY (idMantenimiento)
    REFERENCES mantenimiento(idMantenimiento)
);

CREATE TABLE repuesto (
    idRepuesto bigint NOT NULL IDENTITY(1,1),
	nombre varchar(200) NOT NULL,
	marca varchar(100) NOT NULL,		
	precio int NOT NULL,		
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_Repuesto PRIMARY KEY (idRepuesto)
);

CREATE TABLE repuestoManteni (
    idRepuestoManteni bigint NOT NULL IDENTITY(1,1),
	idMantenimiento bigint NOT NULL,
	idRepuesto bigint NOT NULL,
	estado varchar(50) NOT NULL,				
	fechaRegistro date NOT NULL,
	fechaCambio date NOT NULL,
	registrador bigint NOT NULL,
	CONSTRAINT PK_RepuestoManteni PRIMARY KEY (idRepuestoManteni),
	CONSTRAINT FK_RepuestoManteniRep FOREIGN KEY (idRepuesto)
    REFERENCES repuesto(idRepuesto),
	CONSTRAINT FK_ManteRepuestoManteni FOREIGN KEY (idMantenimiento)
    REFERENCES mantenimiento(idMantenimiento)
);



CREATE LOGIN usuario_taller WITH PASSWORD = 'usuario_taller';

USE taller;
CREATE USER usuario_taller FOR LOGIN usuario_taller;



insert into tipoDocumento (nombre, sigla) values('Cedula de Ciudadanía', 'CC');
insert into tipoDocumento (nombre, sigla) values('Pasaporte', 'PS');
insert into tipoDocumento (nombre, sigla) values('Cedula de Extranjería', 'CE');

INSERT INTO [rol]
           ([idRol], [fechaCambio]
           ,[fechaRegistro]
           ,[nombre]
           ,[registrador])
     VALUES
           (1, GETDATE()
           ,GETDATE()
           ,'MECANICO'
           ,1);
		   
INSERT INTO [dbo].[rol]
           ([idRol], [fechaCambio]
           ,[fechaRegistro]
           ,[nombre]
           ,[registrador])
     VALUES
           (2, GETDATE()
           ,GETDATE()
           ,'CLIENTE'
           ,1)	
		   
		   
   