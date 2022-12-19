/*
Interrogação 1
--------------
Selecione o/s melhor/es marcador/es na fase eliminatória, de cada seleção que não recebeu nenhum vermelho durante toda a competição.
Mostre o nome da seleção, o número e nome do jogador, para além do número de golos marcados pelo mesmo (excetuando os autogolos).
Ordene pelo nome da seleção, e nome do jogador
*/

.mode columns
.headers on
.nullvalue NULL
Drop View If Exists SelecoesSemVermelhos;
Drop View If Exists MelhoresMarcadores;
Drop View If Exists NumeroGolos;

---------------------------------------------------------
Create View SelecoesSemVermelhos As

Select nome_selecao as NOME_SELECAO
From Selecao
Where nome_selecao not in

(Select Distinct NOME
From
(Select nome_selecao as NOME, numero_jogador as NUM,  cor, count(*) as c
From Cartao
Group by nome_selecao, numero_jogador, cor)

Where cor = "vermelha" or (cor = "amarela" and c >= 2))

Group by 1;

-----------------------------------------------------------------------------------------------------------
Create View NumeroGolos As

Select nome_selecao as NOME_SELECAO, numero_jogador as NUM_JOGADOR, count(*) as NUM_GOLOS
From (Golo g Join Evento e on (g.id_evento = e.id_evento)) Join Partida p on (e.id_partida = p.id_partida)
Where p.numero_jornada > 3
Group by nome_selecao, numero_jogador;

-------------------------------------------------------------------------------------------------------------------
Create View MelhoresMarcadores As

Select Distinct A.NOME_SELECAO, A.NUM_JOGADOR, A.NUM_GOLOS
From (Select * From NumeroGolos) A
Where not exists (Select * From NumeroGolos B Where A.NOME_SELECAO = B.NOME_SELECAO and B.NUM_GOLOS > A.NUM_GOLOS);

-------------------------------------------------------------------------------------------------------------------
Select C.NOME_SELECAO, C.NUM_JOGADOR, nome_jogador as NOME_JOGADOR, C.NUM_GOLOS
From
(Select * From (Select * From SelecoesSemVermelhos) join (Select * From MelhoresMarcadores) using(NOME_SELECAO)) as C
Join
Jogador j on (j.numero_jogador = C.NUM_JOGADOR and j.nome_selecao = C.NOME_SELECAO)
Order by 1, 3;