-- SP para insertar una nueva sección
CREATE PROCEDURE InsertarSección
    @Grupo INT, -- Número del grupo (1, 2, etc.)
    @Sección NVARCHAR(1) -- Letra de la sección (A, B, etc.)
AS
BEGIN
    INSERT INTO Sección (Grupo, Sección)
    VALUES (@Grupo, @Sección); -- Inserta los valores proporcionados

    SELECT SCOPE_IDENTITY() AS NuevaSecciónID; -- Devuelve el ID recién generado
END;
GO

-- Probar InsertarSección
EXEC InsertarSección @Grupo = 3, @Sección = 'C';
GO

-- SP para actualizar una sección
CREATE PROCEDURE ActualizarSección
    @SecciónID INT, -- ID de la sección que se quiere actualizar
    @Grupo INT, -- Nuevo número del grupo
    @Sección NVARCHAR(1) -- Nueva letra de la sección
AS
BEGIN
    UPDATE Sección
    SET Grupo = @Grupo, Sección = @Sección
    WHERE SecciónID = @SecciónID; -- Actualiza la fila con el ID proporcionado

    SELECT * FROM Sección WHERE SecciónID = @SecciónID; -- Devuelve la fila actualizada como confirmación
END;
GO

-- Probar ActualizarSección
EXEC ActualizarSección @SecciónID = 1, @Grupo = 2, @Sección = 'D';
GO

-- SP para eliminar una sección
CREATE PROCEDURE EliminarSección
    @SecciónID INT -- ID de la sección que se quiere eliminar
AS
BEGIN
    DELETE FROM Sección
    WHERE SecciónID = @SecciónID; -- Elimina la fila con el ID proporcionado

    SELECT 'Sección eliminada correctamente' AS Mensaje; -- Mensaje de confirmación
END;
GO

-- Probar EliminarSección
EXEC EliminarSección @SecciónID = 1;
GO

-- SP para consultar todas las secciones
CREATE PROCEDURE ConsultarSecciones
AS
BEGIN
    SELECT * FROM Sección; -- Devuelve todas las filas de la tabla Sección
END;
GO

-- Probar ConsultarSecciones
EXEC ConsultarSecciones;
GO

-- SP para consultar una sección específica por ID
CREATE PROCEDURE ConsultarSecciónPorID
    @SecciónID INT -- ID de la sección que quieres consultar
AS
BEGIN
    SELECT * 
    FROM Sección
    WHERE SecciónID = @SecciónID; -- Devuelve la fila que coincide con el ID proporcionado
END;
GO

-- Probar ConsultarSecciónPorID
EXEC ConsultarSecciónPorID @SecciónID = 2;
GO
