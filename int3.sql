/*
Interrogação 3
--------------
Liste os jogadores com “r” na terceira ou na antepenúltima posição no nome, que marcaram golos, cuja seleção jogou em estádios onde se disputaram no mínimo 9 partidas.
Ordene alfabeticamente pelo nome da seleção e decrescentemente pelo número do jogador.
*/

.mode columns
.headers ON
.nullvalue NULL
DROP VIEW IF EXISTS Estadios;
DROP VIEW IF EXISTS Jogadores;
DROP VIEW IF EXISTS Selecoes;

---------------------------------------------------------
CREATE VIEW Estadios AS

SELECT e.nome_estadio AS NOME_ESTADIO, COUNT(*) AS N_PARTIDAS
FROM Estadio AS e JOIN Partida AS p ON (e.nome_estadio = p.nome_estadio)
GROUP BY e.nome_estadio
HAVING COUNT(*) >= 9;

---------------------------------------------------------
CREATE VIEW Jogadores AS

SELECT nome_selecao AS SELECAO, numero_jogador AS NUM, nome_jogador AS NOME
FROM Jogador
WHERE (nome_jogador LIKE '__r%' OR nome_jogador LIKE '%r__')
AND contagem_pessoal <> 0;

---------------------------------------------------------
CREATE VIEW Selecoes AS

SELECT nome_selecao_1 AS SELECAO
FROM Partida
WHERE nome_estadio IN (SELECT NOME_ESTADIO FROM Estadios)

UNION

SELECT nome_selecao_2 AS SELECAO
FROM Partida
WHERE nome_estadio IN (SELECT NOME_ESTADIO FROM Estadios);

---------------------------------------------------------
SELECT * FROM Jogadores
WHERE SELECAO IN (SELECT * from Selecoes)
ORDER BY 1 ASC, 2 DESC;