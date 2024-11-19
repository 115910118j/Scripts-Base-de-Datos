CREATE TABLE Sección (
    SecciónID INT IDENTITY(1,1) PRIMARY KEY, -- Llave primaria con incremento automático
    Grupo INT NOT NULL, -- Número del grupo (1 o 2)
    Sección NVARCHAR(1) NOT NULL -- Letra de la sección (A o B)
);
INSERT INTO Sección (Grupo, Sección)
VALUES
(1, 'A'), -- Grupo 1, Sección A
(1, 'B'), -- Grupo 1, Sección B
(2, 'A'), -- Grupo 2, Sección A
(2, 'B'); -- Grupo 2, Sección B

SELECT * FROM Sección;
