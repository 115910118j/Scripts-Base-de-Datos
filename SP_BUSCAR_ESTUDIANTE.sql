--CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
--APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
--MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
--PROCEDIMIENTO DE BUSCAR ESTUDIANTE
CREATE PROCEDURE [dbo].[SP_BUSCAR_ESTUDIANTE](
    @Cedula NVARCHAR(20),
    @IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT * FROM Estudiante WHERE Cedula = @Cedula)
        BEGIN
            -- Obtener el ID del estudiante
            SELECT @IDRETURN = EstudianteID 
            FROM Estudiante 
            WHERE Cedula = @Cedula;

            -- Retornar toda la información del estudiante
            SELECT 
                EstudianteID, Usuario, Pswd, Nombres, Apellidos,
                Cedula, Direccion, Genero, Email, FechaNacimiento,
                PrimerMatricula, NombrePadre, ApellidosPadre, TelefonoPadre
            FROM Estudiante 
            WHERE Cedula = @Cedula;

            SET @ERRORID = 0; -- Sin error
            SET @ERRORDESCRIPCION = 'Estudiante encontrado exitosamente';
        END
        ELSE
        BEGIN
            -- El estudiante no está registrado
            SET @IDRETURN = -1;
            SET @ERRORID = -1;
            SET @ERRORDESCRIPCION = 'El estudiante no está registrado';
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