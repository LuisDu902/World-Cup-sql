/*
Interrogação 10
---------------
Mostre o nº de jogos ganho por cada seleção, ordenando pelo nome da seleção.
*/

.mode columns
.headers on
.nullvalue NULL
Drop View If Exists Empates;
Drop View If Exists GolosDefault;
Drop View If Exists Autogolos;

---------------------------------------------------------
Create View Empates As

Select id_partida as PARTIDA
From Partida
Where golos_marcados_selecao1 = golos_marcados_selecao2;

---------------------------------------------------------
Create View GolosDefault As

Select p.id_partida as partida, g.nome_selecao as selecao, count(g.id_evento) as golos_reais
From (Golo g join Evento e on (g.id_evento = e.id_evento)) join Partida p on (e.id_partida = p.id_partida)
Where p.id_partida not in (Select * from Empates)
        and
     (p.id_partida, g.nome_selecao) not in
        (Select p.id_partida, g.nome_selecao
         From (Golo g join Evento e on (g.id_evento = e.id_evento)) join Partida p on (e.id_partida = p.id_partida)
         Where g.tipo = "autogolo")
         
Group by p.id_partida, g.nome_selecao;

--------------------------------------------------------------------------------------------------------------------
Create View Autogolos As

Select B.partida as partida, B.selecao as selecao, A.total_golos - B.autogolos as golos_reais
From
(Select p.id_partida as partida, g.nome_selecao as selecao, count(g.id_evento) as total_golos
From (Golo g join Evento e on (g.id_evento = e.id_evento)) join Partida p on (e.id_partida = p.id_partida)
Group by p.id_partida, g.nome_selecao) as A,

(Select p.id_partida as partida, g.nome_selecao as selecao, count(g.id_evento) as autogolos
From (Golo g join Evento e on (g.id_evento = e.id_evento)) join Partida p on (e.id_partida = p.id_partida)
Where g.tipo = "autogolo"
Group by p.id_partida, g.nome_selecao) as B

Where A.partida = B.partida and A.selecao = B.selecao and A.partida not in (Select * from Empates);

---------------------------------------------------------------------------------------------------------------------
Select selecao as SELECAO, count(*) as VITÓRIAS

From
(Select partida, selecao, max(golos_reais)
 From
    (Select * From GolosDefault
     UNION
     Select * From Autogolos)
 Group by 1)

Group by 1
Order by 1;