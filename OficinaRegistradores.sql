CREATE TABLE OficinaRegistradora (
    IDUsuario INT IDENTITY(1,1) PRIMARY KEY, -- Identificador �nico con incremento autom�tico
    NombreUsuario NVARCHAR(127) NOT NULL, -- Nombre de usuario
    Contrase�a NVARCHAR(255) NOT NULL, -- Contrase�a
    PrimerNombre NVARCHAR(31) NOT NULL, -- Primer nombre
    Apellido NVARCHAR(31) NOT NULL, -- Apellido
    Direcci�n NVARCHAR(255) NOT NULL, -- Direcci�n
    N�meroEmpleado INT NOT NULL, -- N�mero de empleado
    FechaNacimiento DATE NOT NULL, -- Fecha de nacimiento
    Tel�fono NVARCHAR(31) NOT NULL, -- N�mero de tel�fono
    T�tulos NVARCHAR(127) NOT NULL, -- Nivel acad�mico
    G�nero NVARCHAR(7) NOT NULL, -- G�nero
    CorreoElectr�nico NVARCHAR(255) NOT NULL, -- Direcci�n de correo electr�nico
    FechaIngreso DATETIME NOT NULL DEFAULT GETDATE() -- Fecha de ingreso
);

--EXEC sp_rename 'OficinaRegistradora.Calificaci�n', 'T�tulos', 'COLUMN';

--SELECT COLUMN_NAME, DATA_TYPE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME = 'OficinaRegistradora';

--ALTER TABLE OficinaRegistradora
--ALTER COLUMN G�nero NVARCHAR(10) NOT NULL; -- Cambiamos el tama�o a 10 caracteres

INSERT INTO OficinaRegistradora (
    NombreUsuario, Contrase�a, PrimerNombre, Apellido, Direcci�n, N�meroEmpleado,
    FechaNacimiento, Tel�fono, T�tulos, G�nero, CorreoElectr�nico
)
VALUES
('juan.staff', 'clave123', 'Juan', 'P�rez', 'Calle 95 87 64', 1212121,
 '1990-06-05', '3056874914', 'Maestr�a', 'Masculino', 'jstaff@cweb.com'),
('maria.staff', 'clave456', 'Mar�a', 'L�pez', 'Calle 33 45 12', 1212122,
 '1988-03-10', '3056874915', 'Licenciatura', 'Femenino', 'mstaff@cweb.com');

 SELECT * FROM OficinaRegistradora;
