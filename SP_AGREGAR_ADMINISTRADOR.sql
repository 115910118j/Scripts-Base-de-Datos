USE [Gestion_Escolar]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGAR_ADMINISTRADOR]    Script Date: 11/16/2024 6:21:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDIMIENTO DE AGREGAR ADMINISTRADOR
ALTER PROCEDURE [dbo].[SP_AGREGAR_ADMINISTRADOR](
	
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
        -- VERIFICAR SI EL ADMINISTRADOR EXISTE Y AGREGAR EL ADMINISTRADOR
        IF EXISTS (SELECT * FROM Administrador WHERE Cedula = @Cedula)
        BEGIN
            SET @IDRETURN = -1;
            SET @ERRORID = 1; -- ERROR: EL ADMINISTRADOR EXISTE 
            SET @ERRORDESCRIPCION = 'ERROR DESDE BD: NOMBRE DE USUARIO YA REGISTRADO';
        END
        ELSE
        BEGIN
            -- INSERTAR NUEVO ADMINISTRADOR
            INSERT INTO Administrador
                (Usuario, Pswd, Nombre, Apellido, Cedula)
            VALUES 
                (@Usuario, @Pswd, @Nombre, @Apellido, @Cedula);
 
            --CAPTURAR EL ID DE NUEVO ADMINISTRADOR
            SET @IDRETURN = SCOPE_IDENTITY();
            SET @ERRORID = 0; -- Sin error
            SET @ERRORDESCRIPCION = 'Inserción exitosa';
        END
    END TRY
    BEGIN CATCH
        -- Captura de errores y asignación a las variables de salida
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END