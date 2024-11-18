--CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
--APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
--MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
--PROCEDIMIENTO DE BUSCAR ADMINISTRADOR
CREATE PROCEDURE SP_BUSCAR_ADMINISTRADOR(
    @Cedula NVARCHAR(20),
    @IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT * FROM Administrador WHERE Cedula = @Cedula)
        BEGIN
            -- Obtener el ID del administrador
            SELECT @IDRETURN = AdminID 
            FROM Administrador 
            WHERE Cedula = @Cedula;

            -- Retornar toda la información del administrador
            SELECT 
                Usuario, Pswd, Nombre, Apellido,
                Cedula, FechaInicio
            FROM Administrador 
            WHERE Cedula = @Cedula;

            SET @ERRORID = 0; -- Sin error
            SET @ERRORDESCRIPCION = 'Administrador encontrado exitosamente';
        END
        ELSE
        BEGIN
            -- El administrador no está registrado
            SET @IDRETURN = -1;
            SET @ERRORID = -1;
            SET @ERRORDESCRIPCION = 'El administrador no está registrado';
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