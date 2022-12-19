/*
Interrogação 6
--------------
Mostre a percentagem de partidas dos playoffs que foram a desempate.
Evidencie a quantidade de partidas dos playoffs e a quantidade de partidas que foram a desempate.
*/

.mode columns
.headers on
.nullvalue NULL

select A.partidas_playoffs, B.partidas_desempate,
 B.partidas_desempate*1.0/A.partidas_playoffs * 100 as PERCENTAGEM from 

(select count(*) as PARTIDAS_PLAYOFFS from partida
where numero_jornada > 3) as A,

(select count(*) as PARTIDAS_DESEMPATE from Desempate) as B
