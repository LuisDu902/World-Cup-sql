/*
Interrogação 10
---------------
Mostre o nº de jogos ganho por cada seleção, ordenando pelo nome da seleção.
*/

.mode columns
.headers ON
.nullvalue NULL
DROP VIEW IF EXISTS Empates;
DROP VIEW IF EXISTS GolosDefault;
DROP VIEW IF EXISTS Autogolos;

---------------------------------------------------------
CREATE VIEW Empates As

SELECT id_partida AS PARTIDA
FROM Partida
WHERE golos_marcados_selecao1 = golos_marcados_selecao2;

---------------------------------------------------------
CREATE VIEW GolosDefault As

SELECT p.id_partida AS partida, g.nome_selecao AS selecao, COUNT(g.id_evento) AS golos_reais
FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida)
WHERE p.id_partida NOT IN (SELECT * FROM Empates)
      AND
      (p.id_partida, g.nome_selecao) NOT IN
         (SELECT p.id_partida, g.nome_selecao
         FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida)
         WHERE g.tipo = "autogolo")
         
GROUP BY p.id_partida, g.nome_selecao;

--------------------------------------------------------------------------------------------------------------------
CREATE VIEW Autogolos As

SELECT B.partida AS partida, B.selecao AS selecao, A.total_golos - B.autogolos AS golos_reais
FROM
(SELECT p.id_partida AS partida, g.nome_selecao AS selecao, COUNT(g.id_evento) AS total_golos
FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida)
GROUP BY p.id_partida, g.nome_selecao) AS A,

(SELECT p.id_partida AS partida, g.nome_selecao AS selecao, COUNT(g.id_evento) AS autogolos
FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) JOIN Partida p ON (e.id_partida = p.id_partida)
WHERE g.tipo = "autogolo"
GROUP BY p.id_partida, g.nome_selecao) AS B

WHERE A.partida = B.partida AND A.selecao = B.selecao AND A.partida NOT IN (SELECT * FROM Empates);

---------------------------------------------------------------------------------------------------------------------
SELECT selecao AS SELECAO, COUNT(*) AS VITÓRIAS

FROM
(SELECT partida, selecao, MAX(golos_reais)
 FROM
    (SELECT * FROM GolosDefault
     UNION
     SELECT * FROM Autogolos)
 GROUP BY 1)

GROUP BY 1
ORDER BY 1;