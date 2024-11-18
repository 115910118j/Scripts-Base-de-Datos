-- CAMBIO DE BASE DE DATOS
USE Gestion_Escolar
GO
-- APLICACION DE FORMATO ANSI AL NULL
SET ANSI_NULLS ON
GO
-- MODIFICACION DE COMPORTAMIENTO DE CADENAS
SET QUOTED_IDENTIFIER ON
GO
-- PROCEDIMIENTO DE ELIMINAR ADMINISTRADOR
CREATE PROCEDURE SP_ELIMINAR_ADMINISTRADOR(
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

        -- VERIFICO SI LA TABLA POSEE MAS DE UN REGISTRO
        -- Corregido: Usando una subconsulta para el conteo
        IF (SELECT COUNT(*) FROM DBO.Administrador) >= 2
        BEGIN
            -- SI EL ADMINISTRADOR EXISTE (ID_ADMINISTRADOR > 0)
            IF @ID_ADMINISTRADOR > 0
            BEGIN
                -- Procedemos a eliminar
                DELETE FROM Administrador 
                WHERE AdminID = @ID_ADMINISTRADOR;
                SET @IDRETURN = @ID_ADMINISTRADOR; -- Devolvemos el ID del registro eliminado
                SET @ERRORID = 0;
                SET @ERRORDESCRIPCION = 'Administrador eliminado exitosamente';
            END
            ELSE
            BEGIN
                -- Mantenemos los valores retornados por SP_BUSCAR_ADMINISTRADOR
                SET @IDRETURN = -1;
                -- ERRORID y ERRORDESCRIPCION ya fueron establecidos por SP_BUSCAR_ADMINISTRADOR
            END
        END
        ELSE
        BEGIN
            --SETEAMOS ERROR
            SET @IDRETURN = -1
            SET @ERRORID = -2 -- DAME EL NUMERO DE ID DE ERROR
            SET @ERRORDESCRIPCION = 'CANTIDAD DE ADMINISTRADORES INSUFICIENTES PARA ELIMINAR' --DESCRIBIMOS EL ERROR
        END
    END TRY
    BEGIN CATCH
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END
GO