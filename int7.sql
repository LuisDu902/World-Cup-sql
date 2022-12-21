/*
Interrogação 7
--------------
Obtenha o saldo de golos de cada seleção na fase de grupos.
Mostre a letra do grupo, o nome da seleção, o número de golos marcados, o número de golos sofridos, e o saldo pedido.
Ordene por grupo, e nome da seleção.
*/

.mode columns
.headers ON
.nullvalue NULL

SELECT s.letra AS GRUPO, A.nome AS SELECAO, A.gm + B.gm AS GOLOS_MARCADOS, A.gs + B.gs AS GOLOS_SOFRIDOS, (A.gm + B.gm)-(A.gs + B.gs) AS SALDO

FROM

(SELECT nome_selecao_1 AS nome, SUM(golos_marcados_selecao1) AS gm, SUM(golos_marcados_selecao2) AS gs
 FROM Partida p JOIN Jornada j ON (p.numero_jornada = j.numero_jornada)
 WHERE j.nome_fase = "grupos"
 GROUP BY nome_selecao_1) AS A,

(SELECT nome_selecao_2 AS nome, SUM(golos_marcados_selecao2) AS gm, SUM(golos_marcados_selecao1) AS gs
 FROM Partida p JOIN Jornada j ON (p.numero_jornada = j.numero_jornada)
 WHERE j.nome_fase = "grupos"
 GROUP BY nome_selecao_2) AS B, 

Selecao s

WHERE A.nome = B.nome and A.nome = s.nome_selecao

Order by 1, 2;