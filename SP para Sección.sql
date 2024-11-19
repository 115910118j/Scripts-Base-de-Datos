-- SP para insertar una nueva secci�n
CREATE PROCEDURE InsertarSecci�n
    @Grupo INT, -- N�mero del grupo (1, 2, etc.)
    @Secci�n NVARCHAR(1) -- Letra de la secci�n (A, B, etc.)
AS
BEGIN
    INSERT INTO Secci�n (Grupo, Secci�n)
    VALUES (@Grupo, @Secci�n); -- Inserta los valores proporcionados

    SELECT SCOPE_IDENTITY() AS NuevaSecci�nID; -- Devuelve el ID reci�n generado
END;
GO

-- Probar InsertarSecci�n
EXEC InsertarSecci�n @Grupo = 3, @Secci�n = 'C';
GO

-- SP para actualizar una secci�n
CREATE PROCEDURE ActualizarSecci�n
    @Secci�nID INT, -- ID de la secci�n que se quiere actualizar
    @Grupo INT, -- Nuevo n�mero del grupo
    @Secci�n NVARCHAR(1) -- Nueva letra de la secci�n
AS
BEGIN
    UPDATE Secci�n
    SET Grupo = @Grupo, Secci�n = @Secci�n
    WHERE Secci�nID = @Secci�nID; -- Actualiza la fila con el ID proporcionado

    SELECT * FROM Secci�n WHERE Secci�nID = @Secci�nID; -- Devuelve la fila actualizada como confirmaci�n
END;
GO

-- Probar ActualizarSecci�n
EXEC ActualizarSecci�n @Secci�nID = 1, @Grupo = 2, @Secci�n = 'D';
GO

-- SP para eliminar una secci�n
CREATE PROCEDURE EliminarSecci�n
    @Secci�nID INT -- ID de la secci�n que se quiere eliminar
AS
BEGIN
    DELETE FROM Secci�n
    WHERE Secci�nID = @Secci�nID; -- Elimina la fila con el ID proporcionado

    SELECT 'Secci�n eliminada correctamente' AS Mensaje; -- Mensaje de confirmaci�n
END;
GO

-- Probar EliminarSecci�n
EXEC EliminarSecci�n @Secci�nID = 1;
GO

-- SP para consultar todas las secciones
CREATE PROCEDURE ConsultarSecciones
AS
BEGIN
    SELECT * FROM Secci�n; -- Devuelve todas las filas de la tabla Secci�n
END;
GO

-- Probar ConsultarSecciones
EXEC ConsultarSecciones;
GO

-- SP para consultar una secci�n espec�fica por ID
CREATE PROCEDURE ConsultarSecci�nPorID
    @Secci�nID INT -- ID de la secci�n que quieres consultar
AS
BEGIN
    SELECT * 
    FROM Secci�n
    WHERE Secci�nID = @Secci�nID; -- Devuelve la fila que coincide con el ID proporcionado
END;
GO

-- Probar ConsultarSecci�nPorID
EXEC ConsultarSecci�nPorID @Secci�nID = 2;
GO
