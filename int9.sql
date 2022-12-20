/*
Interrogação 9
--------------
Selecione o/s melhor/es marcador/es na fase eliminatória, de cada seleção que não recebeu nenhum vermelho durante toda a competição.
Mostre o nome da seleção, o número e nome do jogador, para além do número de golos marcados pelo mesmo (excetuando os autogolos).
Ordene pelo nome da seleção, e número do jogador
*/

.mode columns
.headers ON
.nullvalue NULL
DROP VIEW IF EXISTS SelecoesSemVermelhos;
DROP VIEW IF EXISTS MelhoresMarcadores;
DROP VIEW IF EXISTS NumeroGolos;

---------------------------------------------------------
CREATE VIEW SelecoesSemVermelhos AS

SELECT nome_selecao AS NOME_SELECAO
FROM Selecao
WHERE nome_selecao NOT IN

(SELECT DISTINCT NOME
FROM
(SELECT nome_selecao AS NOME, numero_jogador AS NUM,  cor, COUNT(*) AS c
FROM Cartao
GROUP BY nome_selecao, numero_jogador, cor)

WHERE cor = "vermelha" OR (cor = "amarela" AND c >= 2))

GROUP BY 1;

---------------------------------------------------------
CREATE VIEW NumeroGolos AS

SELECT nome_selecao AS NOME_SELECAO, numero_jogador AS NUM_JOGADOR, COUNT(*) AS NUM_GOLOS
FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida)
WHERE p.numero_jornada > 3 AND g.tipo <> "autogolo"
GROUP BY nome_selecao, numero_jogador;

---------------------------------------------------------
CREATE VIEW MelhoresMarcadores AS

SELECT DISTINCT A.NOME_SELECAO, A.NUM_JOGADOR, A.NUM_GOLOS
FROM (SELECT * FROM NumeroGolos) A
WHERE NOT EXISTS (SELECT * FROM NumeroGolos B WHERE A.NOME_SELECAO = B.NOME_SELECAO AND B.NUM_GOLOS > A.NUM_GOLOS);

---------------------------------------------------------
SELECT C.NOME_SELECAO, C.NUM_JOGADOR, nome_jogador AS NOME_JOGADOR, C.NUM_GOLOS
FROM
(SELECT * FROM (SELECT * FROM SelecoesSemVermelhos) JOIN (SELECT * FROM MelhoresMarcadores) USING(NOME_SELECAO)) AS C
JOIN
Jogador j ON (j.numero_jogador = C.NUM_JOGADOR AND j.nome_selecao = C.NOME_SELECAO)
ORDER BY 1, 2;