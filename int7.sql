/*
Interrogação 7
--------------
Obtenha o saldo de golos de cada seleção na fase de grupos.
Mostre a letra do grupo, o nome da seleção, o número de golos sofridos, o número de golos marcados, e o saldo pedido.
Ordene por grupo, e nome da seleção.
*/

.mode columns
.headers on
.nullvalue NULL

Select s.letra as GRUPO, A.nome as NOME, A.gm + B.gm as GOLOS_MARCADOS, A.gs + B.gs as GOLOS_SOFRIDOS, (A.gm + B.gm)-(A.gs + B.gs) as SALDO

From

(Select nome_selecao_1 as nome, sum(golos_marcados_selecao1) as gm, sum(golos_marcados_selecao2) as gs
 From Partida p join Jornada j on (p.numero_jornada = j.numero_jornada)
 Where j.nome_fase = "grupos"
 Group by nome_selecao_1
 Order by id_partida) as A,

(Select nome_selecao_2 as nome, sum(golos_marcados_selecao2) as gm, sum(golos_marcados_selecao1) as gs
 From Partida p join Jornada j on (p.numero_jornada = j.numero_jornada)
 Where j.nome_fase = "grupos"
 Group by nome_selecao_2
 Order by id_partida) as B, 

Selecao s

Where A.nome = B.nome and A.nome = s.nome_selecao

Order by 1, 2;