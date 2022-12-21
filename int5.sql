/*
Interrogação 5
--------------
Liste o primeiro evento, da segunda parte, da última partida que cada seleção disputou.
Mostre a data e hora da partida, o nome da seleção, o tipo de evento, e o minuto em que ocorreu.
Ordene por ordem cronológica.
*/

.mode columns
.headers ON
.nullvalue NULL

DROP VIEW IF EXISTS PrimeiroEventoSegundaParte;
DROP VIEW IF EXISTS UltimaPartida;

---------------------------------------------------------
CREATE VIEW PrimeiroEventoSegundaParte AS

SELECT * 
FROM (SELECT id_partida AS PARTIDA, nome_selecao AS SELECAO, "Cartão" AS TIPO, minuto AS MINUTO
      FROM Evento e JOIN Cartao c ON (e.id_evento = c.id_evento)

      UNION

      SELECT id_partida AS PARTIDA, nome_selecao_entra AS SELECAO, "Substituição" AS TIPO, minuto AS MINUTO
      FROM Evento e JOIN Substituicao s ON (e.id_evento = s.id_evento)

      UNION

      SELECT id_partida as PARTIDA, nome_selecao AS SELECAO, "Golo" AS TIPO, minuto AS MINUTO
      FROM Evento e JOIN Golo g ON (e.id_evento = g.id_evento))
WHERE MINUTO > 45 AND MINUTO <= 90
GROUP BY PARTIDA, SELECAO
HAVING min(MINUTO);

---------------------------------------------------------
CREATE VIEW UltimaPartida AS
SELECT *
FROM (SELECT id_partida as PARTIDA, data, hora, nome_selecao_1 AS SELECAO
     FROM Partida

     UNION

     SELECT id_partida as PARTIDA, data, hora, nome_selecao_2 AS SELECAO
     FROM Partida)
GROUP BY SELECAO
HAVING max(data)
ORDER BY PARTIDA;

---------------------------------------------------------
SELECT B.data AS DATA, B.hora AS HORA, B.SELECAO, A.TIPO, A.MINUTO
FROM (SELECT * FROM PrimeiroEventoSegundaParte) AS A JOIN (SELECT * FROM UltimaPartida) AS B
WHERE A.PARTIDA = B.PARTIDA AND A.SELECAO = B.SELECAO
ORDER BY 1, 2, 5;