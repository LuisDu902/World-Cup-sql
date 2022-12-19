.mode columns
.headers on
.nullvalue NULL

/*
Interrogação 6
--------------
Mostre a percentagem de partidas dos playoffs que foram a desempate.
Evidencie a quantidade de partidas dos playoffs e a quantidade de partidas que foram a desempate.
*/

select a.partidas_playoffs, b.partidas_desempate,
 b.partidas_desempate*1.0/a.partidas_playoffs * 100 as PERCENTAGEM from 

(select count(*) as PARTIDAS_PLAYOFFS from partida
where numero_jornada > 3) as a,

(select count(*) as PARTIDAS_DESEMPATE from Desempate) as b