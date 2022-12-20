/*
Interrogação 10
---------------
Mostre o nº de jogos ganho por cada seleção, ordenando pelo nome da seleção.
*/

.mode columns
.headers on
.nullvalue NULL

SELECT SELECAO, count(*) AS VITÓRIAS
FROM
(SELECT PARTIDA, SELECAO
FROM
(SELECT id_partida AS PARTIDA, nome_selecao_1 AS SELECAO, golos_marcados_selecao1 AS GOLOS
FROM Partida
WHERE golos_marcados_selecao1 <> golos_marcados_selecao2
UNION
SELECT id_partida AS PARTIDA, nome_selecao_2 AS SELECAO, golos_marcados_selecao2 AS GOLOS
FROM Partida
WHERE golos_marcados_selecao1 <> golos_marcados_selecao2)
GROUP BY PARTIDA
HAVING max(GOLOS))
GROUP BY SELECAO
ORDER BY SELECAO;