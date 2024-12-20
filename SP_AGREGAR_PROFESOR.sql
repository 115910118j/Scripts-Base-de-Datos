USE [Gestion_Escolar]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGAR_PROFESOR]    Script Date: 11/16/2024 6:04:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_AGREGAR_PROFESOR] (
    @NombreUsuario NVARCHAR(127),
    @Pswd NVARCHAR(255),
    @Curso INT,
	@Nombre NVARCHAR(127),
    @Apellidos NVARCHAR(127),
	@Materias NVARCHAR(31),
    @Direccion NVARCHAR(255),
	@Cedula NVARCHAR(20),
	@FechaNacimiento DATETIME,
	@Telefono NVARCHAR(31),
	@Calificacion NVARCHAR(127),
    @Genero NVARCHAR(10),
    @Correo NVARCHAR(100),
	@IDRETURN INT OUTPUT,
    @ERRORID INT OUTPUT,
    @ERRORDESCRIPCION NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
    BEGIN TRY
        -- VERIFICAR SI EL PROFESOR EXISTE Y AGREGAR EL PROFESOR
        IF EXISTS (SELECT * FROM Profesor WHERE Cedula = @Cedula)
        BEGIN
            SET @IDRETURN = -1;
            SET @ERRORID = 1; -- ERROR: EL PROFESOR EXISTE 
            SET @ERRORDESCRIPCION = 'ERROR DESDE BD: CEDULA YA REGISTRADO';
        END
        ELSE
        BEGIN
            -- INSERTAR NUEVO PROFESOR
            INSERT INTO Profesor
                (NombreUsuario, PSWD, Curso, Nombre, Apellidos, Materias, Direccion,
				Cedula, FechaNacimiento, Telefono, Calificacion, Genero,Correo)
            VALUES 
                (@NombreUsuario, @Pswd, @Curso, @Nombre, @Apellidos, @Materias, 
				@Direccion, @Cedula, @FechaNacimiento, @Telefono, @Calificacion, 
				@Genero,@Correo);
 
            -- Capturar el ID del nuevo estudiante
            SET @IDRETURN = SCOPE_IDENTITY();
            SET @ERRORID = 0; -- Sin error
            SET @ERRORDESCRIPCION = 'Inserción exitosa';
        END
    END TRY
    BEGIN 
	CATCH
        -- Captura de errores y asignación a las variables de salida
        SET @IDRETURN = -1;
        SET @ERRORID = ERROR_NUMBER();
        SET @ERRORDESCRIPCION = ERROR_MESSAGE();
    END CATCH
END