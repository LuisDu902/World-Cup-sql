.mode columns
.headers on
.nullvalue NULL

/*
Interrogação 5
--------------
Jogadores com “r” na terceira ou na antepenúltima posição no nome que marcaram golos ordenados por selecao, nome 
(mostrar nome_selecao, numero_jogador, nome_jogador)
*/

Select nome_selecao,numero_jogador,nome_jogador
from Jogador
where (nome_jogador like '__r%' or nome_jogador like '%r__')
and contagem_pessoal <> 0
order by 1,3