CREATE TABLE Secci�n (
    Secci�nID INT IDENTITY(1,1) PRIMARY KEY, -- Llave primaria con incremento autom�tico
    Grupo INT NOT NULL, -- N�mero del grupo (1 o 2)
    Secci�n NVARCHAR(1) NOT NULL -- Letra de la secci�n (A o B)
);
INSERT INTO Secci�n (Grupo, Secci�n)
VALUES
(1, 'A'), -- Grupo 1, Secci�n A
(1, 'B'), -- Grupo 1, Secci�n B
(2, 'A'), -- Grupo 2, Secci�n A
(2, 'B'); -- Grupo 2, Secci�n B

SELECT * FROM Secci�n;
