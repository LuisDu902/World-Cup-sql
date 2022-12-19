/*
Interrogação 3
--------------
Liste os jogadores com “r” na terceira ou na antepenúltima posição no nome, que marcaram golos, cuja seleção jogou em estádios onde se disputaram no mínimo 9 partidas.
Ordene alfabeticamente pelo nome da seleção e decrescentemente pelo número do jogador.
*/

.mode columns
.headers on
.nullvalue NULL
Drop View if exists Estadios;
Drop View if exists Jogadores;
Drop View if exists Selecoes;

---------------------------------------------------------
Create View Estadios As

Select e.nome_estadio as NOME_ESTADIO, count(*) as N_PARTIDAS
From Estadio as e join Partida as p on (e.nome_estadio = p.nome_estadio)
Group by e.nome_estadio
Having count(*) >= 9;

---------------------------------------------------------
Create View Jogadores As

Select nome_selecao as SELECAO, numero_jogador as NUM, nome_jogador as NOME
From Jogador
Where (nome_jogador like '__r%' or nome_jogador like '%r__')
and contagem_pessoal <> 0;

---------------------------------------------------------
Create View Selecoes As

Select nome_selecao_1 as SELECAO
From Partida
Where nome_estadio in (Select NOME_ESTADIO From Estadios)

Union

Select nome_selecao_2 as SELECAO
From Partida
Where nome_estadio in (Select NOME_ESTADIO From Estadios);

---------------------------------------------------------
Select * From Jogadores
Where SELECAO in (Select * from Selecoes)
Order by 1 ASC, 2 DESC;