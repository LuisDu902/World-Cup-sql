/*
Interrogação 4
--------------
Selecione a média de cartões dos jogadores da seleção com maior número de substituições.
Mostre o nome da seleção, o número total de cartões, o número de jogadores da seleção e a média pedida, arredondada a 3 casas decimais.
*/

.mode columns
.headers on
.nullvalue NULL

Select A.nome_selecao as NOME_SELECAO, NUM_CARTOES, NUM_JOGADORES, round(NUM_CARTOES*1.0/NUM_JOGADORES, 3) as MEDIA
From 

(Select nome_selecao, max(total_subs)
 From (Select nome_selecao_entra as nome_selecao, count(*) as total_subs
      From Substituicao
      Group by nome_selecao_entra)) as A, 

(Select nome_selecao, count(*) as NUM_CARTOES
 From Cartao
 Group by nome_selecao) as B, 

(Select nome_selecao, count(*) as NUM_JOGADORES
 From Jogador
 Group by nome_selecao) as C

Where A.nome_selecao = B.nome_selecao and A.nome_selecao = C.nome_selecao;