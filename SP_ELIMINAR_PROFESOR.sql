-- CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
-- APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
-- MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDIMIENTO DE ELIMINAR PROFESOR
CREATE PROCEDURE SP_ELIMINAR_PROFESOR(
    @Cedula NVARCHAR(20),
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
            -- Procedemos a eliminar
            DELETE FROM Profesor 
            WHERE IDProfesor = @ID_PROFESOR;

            SET @IDRETURN = @ID_PROFESOR; -- Devolvemos el ID del registro eliminado
            SET @ERRORID = 0;
            SET @ERRORDESCRIPCION = 'Profesor eliminado exitosamente';
        END
        ELSE
        BEGIN
            -- Mantenemos los valores retornados por SP_BUSCAR_PROFESOR
            SET @IDRETURN = -1;
            -- ERRORID y ERRORDESCRIPCION ya fueron establecidos por SP_BUSCAR_PROFESOR
        END
    END TRY
    BEGIN CATCH
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END