USE [Gestion_Escolar]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGAR_ESTUDIANTE]    Script Date: 11/16/2024 6:05:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- PROCEDIMIENTO DE AGREGAR ESTUDIANTE
ALTER PROCEDURE [dbo].[SP_AGREGAR_ESTUDIANTE] (
    @Usuario NVARCHAR(127),
    @Pswd NVARCHAR(255),
    @Nombres NVARCHAR(127),
    @Apellidos NVARCHAR(255),
	@Cedula NVARCHAR(20),
    @Direccion NVARCHAR(MAX),
    @Genero NVARCHAR(10),
    @Email NVARCHAR(100),
    @FechaNacimiento DATETIME,
	@NombrePadre NVARCHAR(127),
	@ApellidosPadre NVARCHAR(127),
	@TelefonoPadre NVARCHAR(11),
	@IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- VERIFICAR SI EL ESTUDIANTE EXISTE Y AGREGAR EL ESTUDIANTE
        IF EXISTS (SELECT * FROM dbo.Estudiante WHERE Cedula = @Cedula)
        BEGIN
            SET @IDRETURN = -1;
            SET @ERRORID = 1; -- ERROR: EL ESTUDIANTE EXISTE 
            SET @ERRORDESCRIPCION = 'ERROR DESDE BD: CEDULA YA REGISTRADA';
        END
        ELSE
        BEGIN
            -- Insertar nuevo estudiante
            INSERT INTO dbo.Estudiante
                (Usuario, Pswd, Nombres, Apellidos, Cedula, Direccion, Genero, 
				Email, FechaNacimiento, NombrePadre, ApellidosPadre, TelefonoPadre)
            VALUES 
                (@Usuario, @Pswd, @Nombres, @Apellidos, @Cedula, @Direccion, 
				@Genero, @Email, @FechaNacimiento, @NombrePadre, @ApellidosPadre, 
				@TelefonoPadre);
 
            -- Capturar el ID del nuevo estudiante
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
