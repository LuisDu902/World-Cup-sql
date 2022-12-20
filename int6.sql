/*
Interrogação 6
--------------
Mostre a percentagem de partidas dos playoffs que foram a desempate.
Evidencie a quantidade de partidas dos playoffs e a quantidade de partidas que foram a desempate.
*/

.mode columns
.headers ON
.nullvalue NULL

SELECT A.partidas_playoffs, B.partidas_desempate,
 B.partidas_desempate*1.0/A.partidas_playoffs * 100 AS PERCENTAGEM FROM 

(SELECT COUNT(*) AS PARTIDAS_PLAYOFFS FROM partida
WHERE numero_jornada > 3) AS A,

(SELECT COUNT(*) AS PARTIDAS_DESEMPATE FROM Desempate) AS B
