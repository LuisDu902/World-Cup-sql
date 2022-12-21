/*
Interrogação 8
--------------
Houve algum jogador que esteve envolvido nalgum evento de todas as partidas que disputou? 
Mostre o nome da seleção, para além do nome e do número do jogador. 
Ordene pelo nome da seleção e número do jogador.
*/

.mode columns
.headers ON
.nullvalue NULL

DROP VIEW IF EXISTS PartidaComGolos;
DROP VIEW IF EXISTS PartidaComCartao;
DROP VIEW IF EXISTS PartidaComSubstituicao;
DROP VIEW IF EXISTS NumeroPartidas;

---------------------------------------------------------
CREATE VIEW PartidaComGolos AS

SELECT PARTIDA, NUMERO, NOME, SELECAO
FROM(
SELECT e.id_partida AS PARTIDA, j.numero_jogador AS NUMERO, j.nome_jogador AS NOME, j.nome_selecao AS SELECAO
FROM Partida p 
    JOIN Jogador j ON
        (p.nome_selecao_1 = j.nome_selecao OR p.nome_selecao_2 = j.nome_selecao)
    JOIN (Golo g JOIN Evento e USING(id_evento)) ON
        (j.nome_selecao = g.nome_selecao 
        AND 
        j.numero_jogador = g.numero_jogador 
        AND 
         e.id_partida = p.id_partida)
GROUP BY 1,2
)
GROUP BY 1,2;

---------------------------------------------------------
CREATE VIEW PartidaComCartao AS

SELECT PARTIDA,NUMERO, NOME, SELECAO
FROM(
SELECT e.id_partida AS PARTIDA, j.numero_jogador AS NUMERO, j.nome_jogador AS NOME, j.nome_selecao AS SELECAO
FROM Partida p 
    JOIN Jogador j ON 
        (p.nome_selecao_1 = j.nome_selecao OR p.nome_selecao_2 = j.nome_selecao)
    JOIN (Cartao c JOIN Evento e USING(id_evento)) ON 
        (j.nome_selecao = c.nome_selecao 
        AND 
        j.numero_jogador = c.numero_jogador 
        AND 
        e.id_partida = p.id_partida)
GROUP BY 1,2
)
GROUP BY 1,2;

---------------------------------------------------------
CREATE VIEW PartidaComSubstituicao AS

SELECT p.id_partida AS PARTIDA, s.numero_jogador_entra AS NUMERO, j.nome_jogador AS NOME, s.nome_selecao_entra AS SELECAO
FROM (Substituicao s JOIN Evento e ON (s.id_evento = e.id_evento)) 
    JOIN Partida p ON (e.id_partida = p.id_partida) 
    JOIN JOGADOR j ON (j.numero_jogador = s.numero_jogador_entra AND j.nome_selecao = s.nome_selecao_entra) 
GROUP BY 1, 2, 3

UNION

SELECT p.id_partida PARTIDA, s.numero_jogador_sai NUMERO, j.nome_jogador NOME, s.nome_selecao_sai SELECAO
FROM (Substituicao s JOIN Evento e ON (s.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida) JOIN JOGADOR j ON (j.numero_jogador = s.numero_jogador_sai AND j.nome_selecao = s.nome_selecao_sai) 
GROUP BY 1, 2, 3;

---------------------------------------------------------
CREATE VIEW NumeroPartidas AS

SELECT SELECAO, NR_PARTIDAS_1+NR_PARTIDAS_2 AS NR_PARTIDAS_TOTAL
FROM

(SELECT nome_selecao_1 SELECAO, COUNT(*) NR_PARTIDAS_1
FROM Partida
GROUP BY 1)

NATURAL JOIN 

(SELECT nome_selecao_2 SELECAO, COUNT(*) NR_PARTIDAS_2
FROM Partida
GROUP BY 1);

---------------------------------------------------------
SELECT SELECAO, NUMERO, NOME

FROM

(SELECT NUMERO,NOME, SELECAO, COUNT(*) PARTIDAS_COM_EVENTO

FROM
    (SELECT * FROM PartidaComGolos
     UNION
     SELECT * FROM PartidaComSubstituicao
     UNION
     SELECT * FROM PartidaComCartao)

GROUP BY NOME,SELECAO)

JOIN (SELECT * FROM NumeroPartidas) 
USING(SELECAO)
WHERE PARTIDAS_COM_EVENTO = NR_PARTIDAS_TOTAL
ORDER BY SELECAO, NUMERO;
