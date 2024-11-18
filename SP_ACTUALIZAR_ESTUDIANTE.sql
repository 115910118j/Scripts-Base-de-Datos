--CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
--APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
--MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTO DE ACTUALIZAR ADMINISTRADOR
CREATE PROCEDURE SP_ACTUALIZAR_ADMINISTRADOR (
    @Usuario NVARCHAR(127),
    @Pswd NVARCHAR(255),
    @Nombre NVARCHAR(127),
    @Apellido NVARCHAR(255),
	@Cedula NVARCHAR(20),
	@IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- Utilizamos el SP de búsqueda para verificar si existe
        DECLARE @ID_ADMINISTRADOR INT
        
        EXEC SP_BUSCAR_ADMINISTRADOR
            @Cedula = @Cedula,
            @IDRETURN = @ID_ADMINISTRADOR OUTPUT,
            @ERRORID = @ERRORID OUTPUT,
            @ERRORDESCRIPCION = @ERRORDESCRIPCION OUTPUT;

        -- Si el ADMINISTRADOR existe (ID_ADMINISTRADOR > 0)
        IF @ID_ADMINISTRADOR > 0
        BEGIN
            UPDATE Administrador
            SET 
                Usuario = COALESCE(@Usuario, Usuario),
                Pswd = COALESCE(@Pswd, Pswd),
                Nombre = COALESCE(@Nombre, Nombre),
                Apellido = COALESCE(@Apellido, Apellido),
                Cedula = COALESCE(@Cedula, Cedula)
            WHERE AdminID = @ID_ADMINISTRADOR;

            SET @IDRETURN = @ID_ADMINISTRADOR;
            SET @ERRORID = 0;
            SET @ERRORDESCRIPCION = 'Actualización de datos exitosa';
        END
        -- No necesitamos un ELSE porque SP_BUSCAR_ADMINISTRADOR ya estableció los valores de error
    END TRY
    BEGIN CATCH
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END
GO