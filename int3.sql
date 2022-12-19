/*
Interrogação 3
--------------
Liste os estádios nos quais houve menos do que 9 partidas,
ordenados por número de partidas e por capacidade,
caso o número de partidas seja igual.
*/

.mode columns
.headers on
.nullvalue NULL

select e.nome_estadio as NOME_ESTADIO, count(*) as N_PARTIDAS, capacidade as CAPACIDADE
from estadio as e join partida as p
on e.nome_estadio = p.nome_estadio
group by e.nome_estadio
having count(*) < 9
order by N_PARTIDAS asc, e.capacidade desc;

