-- SP para insertar un nuevo registro en OficinaRegistradora
CREATE PROCEDURE InsertarOficinaRegistradora
    @NombreUsuario NVARCHAR(127),
    @Contraseña NVARCHAR(255),
    @PrimerNombre NVARCHAR(31),
    @Apellido NVARCHAR(31),
    @Dirección NVARCHAR(255),
    @NúmeroEmpleado INT,
    @FechaNacimiento DATE,
    @Teléfono NVARCHAR(31),
    @Títulos NVARCHAR(127),
    @Género NVARCHAR(10),
    @CorreoElectrónico NVARCHAR(255)
AS
BEGIN
    INSERT INTO OficinaRegistradora (
        NombreUsuario, Contraseña, PrimerNombre, Apellido, Dirección, NúmeroEmpleado,
        FechaNacimiento, Teléfono, Títulos, Género, CorreoElectrónico
    )
    VALUES (
        @NombreUsuario, @Contraseña, @PrimerNombre, @Apellido, @Dirección, @NúmeroEmpleado,
        @FechaNacimiento, @Teléfono, @Títulos, @Género, @CorreoElectrónico
    );

    SELECT SCOPE_IDENTITY() AS NuevoID; -- Devuelve el ID recién generado
END;
GO

-- Probar InsertarOficinaRegistradora
EXEC InsertarOficinaRegistradora 
    @NombreUsuario = 'juan.staff',
    @Contraseña = 'clave123',
    @PrimerNombre = 'Juan',
    @Apellido = 'Pérez',
    @Dirección = 'Calle 95 87 64',
    @NúmeroEmpleado = 1212121,
    @FechaNacimiento = '1990-06-05',
    @Teléfono = '3056874914',
    @Títulos = 'Maestría',
    @Género = 'Masculino',
    @CorreoElectrónico = 'jstaff@cweb.com';
GO

-- SP para actualizar un registro en OficinaRegistradora
CREATE PROCEDURE ActualizarOficinaRegistradora
    @IDUsuario INT,
    @NombreUsuario NVARCHAR(127),
    @Contraseña NVARCHAR(255),
    @PrimerNombre NVARCHAR(31),
    @Apellido NVARCHAR(31),
    @Dirección NVARCHAR(255),
    @NúmeroEmpleado INT,
    @FechaNacimiento DATE,
    @Teléfono NVARCHAR(31),
    @Títulos NVARCHAR(127),
    @Género NVARCHAR(10),
    @CorreoElectrónico NVARCHAR(255)
AS
BEGIN
    UPDATE OficinaRegistradora
    SET 
        NombreUsuario = @NombreUsuario,
        Contraseña = @Contraseña,
        PrimerNombre = @PrimerNombre,
        Apellido = @Apellido,
        Dirección = @Dirección,
        NúmeroEmpleado = @NúmeroEmpleado,
        FechaNacimiento = @FechaNacimiento,
        Teléfono = @Teléfono,
        Títulos = @Títulos,
        Género = @Género,
        CorreoElectrónico = @CorreoElectrónico
    WHERE IDUsuario = @IDUsuario;

    SELECT * FROM OficinaRegistradora WHERE IDUsuario = @IDUsuario; -- Devuelve la fila actualizada
END;
GO

-- Probar ActualizarOficinaRegistradora
EXEC ActualizarOficinaRegistradora 
    @IDUsuario = 1,
    @NombreUsuario = 'juan.staff',
    @Contraseña = 'clave456',
    @PrimerNombre = 'Juan',
    @Apellido = 'Gómez',
    @Dirección = 'Calle 45 78 10',
    @NúmeroEmpleado = 1212122,
    @FechaNacimiento = '1990-06-10',
    @Teléfono = '3056874915',
    @Títulos = 'Doctorado',
    @Género = 'Masculino',
    @CorreoElectrónico = 'jgomez@cweb.com';
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

-- SP para consultar un registro específico en OficinaRegistradora
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
