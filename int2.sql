/*
Interrogação 2
--------------
Obtenha as seleções que ficaram no pódio (1º, 2º e 3º lugares), ordenadamente.
Mostre o nome da seleção e o número respetivo de vitórias em toda a competição.
*/

.mode columns
.headers on
.nullvalue NULL

Select g.nome_selecao as PODIO

From (Golo g join Evento e on (g.id_evento = e.id_evento)) join Partida p on (e.id_partida = p.id_partida)

Where p.id_partida in (Select p.id_partida
                       From Partida p join Jornada j on (p.numero_jornada = j.numero_jornada)
                       Where j.nome_fase = "final" or j.nome_fase = "jogo para o 3º lugar")

Group by g.nome_selecao
Order by p.data DESC, count(g.id_evento) DESC
Limit 3;
