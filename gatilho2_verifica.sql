.mode columns
.headers ON
.nullvalue NULL

SELECT * FROM Partida WHERE numero_jornada >= 4;

INSERT INTO Partida VALUES (1,2,2,'2022-11-20','16:00:00',90,"Al-Bayt",4,"Estados Unidos","Equador");
INSERT INTO Partida VALUES (2,2,2,'2022-11-20','16:00:00',90,"Al-Bayt",4,"Brasil","Japão");
INSERT INTO Partida VALUES (3,2,2,'2022-11-20','16:00:00',90,"Al-Bayt",4,"Senegal","Marrocos");

SELECT * FROM Partida WHERE numero_jornada >= 4;