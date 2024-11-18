--CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
--APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
--MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDIMIENTO DE ACTUALIZAR PROFESOR
CREATE PROCEDURE SP_ACTUALIZAR_PROFESOR (
    @NombreUsuario NVARCHAR(127),
    @PSWD NVARCHAR(255),
    @Curso INT,
    @Nombre NVARCHAR(127),
    @Apellidos NVARCHAR(127),
    @Materias NVARCHAR(31),
    @Direccion NVARCHAR(255),
    @Cedula NVARCHAR(20),
    @FechaNacimiento DATETIME,
    @Telefono NVARCHAR(31),
    @Calificacion NVARCHAR(127),
    @Genero NVARCHAR(15),
    @Correo NVARCHAR(255),
    @IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- Utilizamos el SP de búsqueda para verificar si existe
        DECLARE @ID_PROFESOR INT
        
        EXEC SP_BUSCAR_PROFESOR 
            @Cedula = @Cedula,
            @IDRETURN = @ID_PROFESOR OUTPUT,
            @ERRORID = @ERRORID OUTPUT,
            @ERRORDESCRIPCION = @ERRORDESCRIPCION OUTPUT;

        -- Si el profesor existe (ID_PROFESOR > 0)
        IF @ID_PROFESOR > 0
        BEGIN
            UPDATE Profesor
            SET 
                NombreUsuario = COALESCE(@NombreUsuario, NombreUsuario),
                PSWD = COALESCE(@PSWD, PSWD),
                Curso = COALESCE(@Curso, Curso),
                Nombre = COALESCE(@Nombre, Nombre),
                Apellidos = COALESCE(@Apellidos, Apellidos),
                Materias = COALESCE(@Materias, Materias),
                Direccion = COALESCE(@Direccion, Direccion),
                Cedula = COALESCE(@Cedula, Cedula),
                FechaNacimiento = COALESCE(@FechaNacimiento, FechaNacimiento),
                Telefono = COALESCE(@Telefono, Telefono),
                Calificacion = COALESCE(@Calificacion, Calificacion),
                Genero = COALESCE(@Genero, Genero),
                Correo = COALESCE(@Correo, Correo)
            WHERE IDProfesor = @ID_PROFESOR;

            SET @IDRETURN = @ID_PROFESOR;
            SET @ERRORID = 0;
            SET @ERRORDESCRIPCION = 'Actualización de datos del profesor exitosa';
        END
        -- No necesitamos un ELSE porque SP_BUSCAR_PROFESOR ya estableció los valores de error
    END TRY
    BEGIN CATCH
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END