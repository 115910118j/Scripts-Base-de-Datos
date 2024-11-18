-- CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
-- APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
-- MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTO DE ELIMINAR ESTUDIANTE
CREATE PROCEDURE SP_ELIMINAR_ESTUDIANTE(
    @Cedula NVARCHAR(20),
    @IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- Utilizamos el SP de búsqueda para verificar si existe
        DECLARE @ID_ESTUDIANTE INT
        
        EXEC SP_BUSCAR_ESTUDIANTE 
            @Cedula = @Cedula,
            @IDRETURN = @ID_ESTUDIANTE OUTPUT,
            @ERRORID = @ERRORID OUTPUT,
            @ERRORDESCRIPCION = @ERRORDESCRIPCION OUTPUT;

        -- Si el estudiante existe (ID_ESTUDIANTE > 0)
        IF @ID_ESTUDIANTE > 0
        BEGIN
            -- Procedemos a eliminar
            DELETE FROM Estudiante 
            WHERE EstudianteID = @ID_ESTUDIANTE;

            SET @IDRETURN = @ID_ESTUDIANTE; -- Devolvemos el ID del registro eliminado
            SET @ERRORID = 0;
            SET @ERRORDESCRIPCION = 'Estudiante eliminado exitosamente';
        END
        ELSE
        BEGIN
            -- Mantenemos los valores retornados por SP_BUSCAR_ESTUDIANTE
            SET @IDRETURN = -1;
            -- ERRORID y ERRORDESCRIPCION ya fueron establecidos por SP_BUSCAR_ESTUDIANTE
        END
    END TRY
    BEGIN CATCH
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END
GO
