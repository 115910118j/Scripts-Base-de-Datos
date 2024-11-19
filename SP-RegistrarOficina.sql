-- SP para insertar un nuevo registro en OficinaRegistradora
CREATE PROCEDURE InsertarOficinaRegistradora
    @NombreUsuario NVARCHAR(127),
    @Contrase�a NVARCHAR(255),
    @PrimerNombre NVARCHAR(31),
    @Apellido NVARCHAR(31),
    @Direcci�n NVARCHAR(255),
    @N�meroEmpleado INT,
    @FechaNacimiento DATE,
    @Tel�fono NVARCHAR(31),
    @T�tulos NVARCHAR(127),
    @G�nero NVARCHAR(10),
    @CorreoElectr�nico NVARCHAR(255)
AS
BEGIN
    INSERT INTO OficinaRegistradora (
        NombreUsuario, Contrase�a, PrimerNombre, Apellido, Direcci�n, N�meroEmpleado,
        FechaNacimiento, Tel�fono, T�tulos, G�nero, CorreoElectr�nico
    )
    VALUES (
        @NombreUsuario, @Contrase�a, @PrimerNombre, @Apellido, @Direcci�n, @N�meroEmpleado,
        @FechaNacimiento, @Tel�fono, @T�tulos, @G�nero, @CorreoElectr�nico
    );

    SELECT SCOPE_IDENTITY() AS NuevoID; -- Devuelve el ID reci�n generado
END;
GO

-- Probar InsertarOficinaRegistradora
EXEC InsertarOficinaRegistradora 
    @NombreUsuario = 'juan.staff',
    @Contrase�a = 'clave123',
    @PrimerNombre = 'Juan',
    @Apellido = 'P�rez',
    @Direcci�n = 'Calle 95 87 64',
    @N�meroEmpleado = 1212121,
    @FechaNacimiento = '1990-06-05',
    @Tel�fono = '3056874914',
    @T�tulos = 'Maestr�a',
    @G�nero = 'Masculino',
    @CorreoElectr�nico = 'jstaff@cweb.com';
GO

-- SP para actualizar un registro en OficinaRegistradora
CREATE PROCEDURE ActualizarOficinaRegistradora
    @IDUsuario INT,
    @NombreUsuario NVARCHAR(127),
    @Contrase�a NVARCHAR(255),
    @PrimerNombre NVARCHAR(31),
    @Apellido NVARCHAR(31),
    @Direcci�n NVARCHAR(255),
    @N�meroEmpleado INT,
    @FechaNacimiento DATE,
    @Tel�fono NVARCHAR(31),
    @T�tulos NVARCHAR(127),
    @G�nero NVARCHAR(10),
    @CorreoElectr�nico NVARCHAR(255)
AS
BEGIN
    UPDATE OficinaRegistradora
    SET 
        NombreUsuario = @NombreUsuario,
        Contrase�a = @Contrase�a,
        PrimerNombre = @PrimerNombre,
        Apellido = @Apellido,
        Direcci�n = @Direcci�n,
        N�meroEmpleado = @N�meroEmpleado,
        FechaNacimiento = @FechaNacimiento,
        Tel�fono = @Tel�fono,
        T�tulos = @T�tulos,
        G�nero = @G�nero,
        CorreoElectr�nico = @CorreoElectr�nico
    WHERE IDUsuario = @IDUsuario;

    SELECT * FROM OficinaRegistradora WHERE IDUsuario = @IDUsuario; -- Devuelve la fila actualizada
END;
GO

-- Probar ActualizarOficinaRegistradora
EXEC ActualizarOficinaRegistradora 
    @IDUsuario = 1,
    @NombreUsuario = 'juan.staff',
    @Contrase�a = 'clave456',
    @PrimerNombre = 'Juan',
    @Apellido = 'G�mez',
    @Direcci�n = 'Calle 45 78 10',
    @N�meroEmpleado = 1212122,
    @FechaNacimiento = '1990-06-10',
    @Tel�fono = '3056874915',
    @T�tulos = 'Doctorado',
    @G�nero = 'Masculino',
    @CorreoElectr�nico = 'jgomez@cweb.com';
GO

-- SP para eliminar un registro en OficinaRegistradora
CREATE PROCEDURE EliminarOficinaRegistradora
    @IDUsuario INT
AS
BEGIN
    DELETE FROM OficinaRegistradora
    WHERE IDUsuario = @IDUsuario;

    SELECT 'Usuario eliminado correctamente' AS Mensaje;
END;
GO

-- Probar EliminarOficinaRegistradora
EXEC EliminarOficinaRegistradora @IDUsuario = 1;
GO

-- SP para consultar todos los registros en OficinaRegistradora
CREATE PROCEDURE ConsultarOficinaRegistradora
AS
BEGIN
    SELECT * FROM OficinaRegistradora;
END;
GO

-- Probar ConsultarOficinaRegistradora
EXEC ConsultarOficinaRegistradora;
GO

-- SP para consultar un registro espec�fico en OficinaRegistradora
CREATE PROCEDURE ConsultarOficinaRegistradoraPorID
    @IDUsuario INT
AS
BEGIN
    SELECT * 
    FROM OficinaRegistradora
    WHERE IDUsuario = @IDUsuario;
END;
GO

-- Probar ConsultarOficinaRegistradoraPorID
EXEC ConsultarOficinaRegistradoraPorID @IDUsuario = 2;
GO
