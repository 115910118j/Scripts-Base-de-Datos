--CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
--APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
--MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
--PROCEDIMIENTO DE BUSCAR PROFESOR
CREATE PROCEDURE [dbo].[SP_BUSCAR_PROFESOR](
    @Cedula NVARCHAR(20),
    @IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT * FROM Profesor WHERE Cedula = @Cedula)
        BEGIN
            -- Obtener el ID del profesor
            SELECT @IDRETURN = IDProfesor 
            FROM Profesor 
            WHERE Cedula = @Cedula;
            
            -- Retornar toda la información del profesor
            SELECT 
                NombreUsuario, PSWD, Curso, Nombre,
                Apellidos, Materias, Direccion, Cedula, FechaNacimiento,
                Telefono, Calificacion, Genero, Correo, FechaInicio
            FROM Profesor 
            WHERE Cedula = @Cedula;

            SET @ERRORID = 0; -- Sin error
            SET @ERRORDESCRIPCION = 'Profesor encontrado exitosamente';
        END
        ELSE
        BEGIN
            -- El profesor no está registrado
            SET @IDRETURN = -1;
            SET @ERRORID = -1;
            SET @ERRORDESCRIPCION = 'El profesor no está registrado';
        END
    END TRY
    BEGIN CATCH
        -- Captura de errores y asignación a las variables de salida
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END
GO