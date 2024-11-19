CREATE TABLE OficinaRegistradora (
    IDUsuario INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único con incremento automático
    NombreUsuario NVARCHAR(127) NOT NULL, -- Nombre de usuario
    Contraseña NVARCHAR(255) NOT NULL, -- Contraseña
    PrimerNombre NVARCHAR(31) NOT NULL, -- Primer nombre
    Apellido NVARCHAR(31) NOT NULL, -- Apellido
    Dirección NVARCHAR(255) NOT NULL, -- Dirección
    NúmeroEmpleado INT NOT NULL, -- Número de empleado
    FechaNacimiento DATE NOT NULL, -- Fecha de nacimiento
    Teléfono NVARCHAR(31) NOT NULL, -- Número de teléfono
    Títulos NVARCHAR(127) NOT NULL, -- Nivel académico
    Género NVARCHAR(7) NOT NULL, -- Género
    CorreoElectrónico NVARCHAR(255) NOT NULL, -- Dirección de correo electrónico
    FechaIngreso DATETIME NOT NULL DEFAULT GETDATE() -- Fecha de ingreso
);

--EXEC sp_rename 'OficinaRegistradora.Calificación', 'Títulos', 'COLUMN';

--SELECT COLUMN_NAME, DATA_TYPE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME = 'OficinaRegistradora';

--ALTER TABLE OficinaRegistradora
--ALTER COLUMN Género NVARCHAR(10) NOT NULL; -- Cambiamos el tamaño a 10 caracteres

INSERT INTO OficinaRegistradora (
    NombreUsuario, Contraseña, PrimerNombre, Apellido, Dirección, NúmeroEmpleado,
    FechaNacimiento, Teléfono, Títulos, Género, CorreoElectrónico
)
VALUES
('juan.staff', 'clave123', 'Juan', 'Pérez', 'Calle 95 87 64', 1212121,
 '1990-06-05', '3056874914', 'Maestría', 'Masculino', 'jstaff@cweb.com'),
('maria.staff', 'clave456', 'María', 'López', 'Calle 33 45 12', 1212122,
 '1988-03-10', '3056874915', 'Licenciatura', 'Femenino', 'mstaff@cweb.com');

 SELECT * FROM OficinaRegistradora;
