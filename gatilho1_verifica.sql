.mode columns
.headers ON
.nullvalue NULL

INSERT INTO Partida VALUES
(1,0,0,'2022-11-20','16:00:00',120,"Al-Bayt",4,"Brasil","Equador");

INSERT INTO Desempate VALUES
(1,0,0,1);

INSERT INTO Evento VALUES 
(1,1,1),
(2,2,1),
(3,3,1),
(4,4,1),
(5,121,1),
(6,122,1),
(7,123,1);


SELECT * FROM Jogador WHERE nome_selecao = "Brasil" AND (numero_jogador = 16 OR numero_jogador = 1 OR numero_jogador = 11);
SELECT * FROM Jogador WHERE nome_selecao = "Equador" AND (numero_jogador = 2 OR numero_jogador = 6 OR numero_jogador = 3);
SELECT * FROM Partida WHERE id_partida = 1;
SELECT * FROM Desempate WHERE id_desempate = 1;

INSERT INTO Golo VALUES      -- Partida : Brasil (0-0) Equador | Desempate : Brasil (0-0) Equador --
(1,"default",16,"Brasil"),   -- Partida : Brasil (1-0) Equador | Desempate : Brasil (0-0) Equador --
(2,"autogolo",1,"Brasil"),   -- Partida : Brasil (1-1) Equador | Desempate : Brasil (0-0) Equador --
(3,"autogolo",2,"Equador"),  -- Partida : Brasil (2-1) Equador | Desempate : Brasil (0-0) Equador --
(4,"default",3,"Equador"),   -- Partida : Brasil (2-2) Equador | Desempate : Brasil (0-0) Equador --
(5,"penalti",16,"Brasil"),   -- Partida : Brasil (2-2) Equador | Desempate : Brasil (1-0) Equador --
(6,"penalti",6,"Equador"),   -- Partida : Brasil (2-2) Equador | Desempate : Brasil (1-1) Equador --
(7,"penalti",11,"Brasil");   -- Partida : Brasil (2-2) Equador | Desempate : Brasil (2-1) Equador --

SELECT * FROM Jogador WHERE nome_selecao = "Brasil" AND (numero_jogador = 16 OR numero_jogador = 1 OR numero_jogador = 11);
SELECT * FROM Jogador WHERE nome_selecao = "Equador" AND (numero_jogador = 2 OR numero_jogador = 6 OR numero_jogador = 3);
SELECT * FROM Partida WHERE id_partida = 1;
SELECT * FROM Desempate WHERE id_desempate = 1;