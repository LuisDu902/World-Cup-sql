/*
Interrogação 5
--------------
Liste os jogadores com “r” na terceira ou na antepenúltima posição no nome, que marcaram golos.
Ordene pelo nome da selecao e nome do jogador
*/

.mode columns
.headers on
.nullvalue NULL

Select nome_selecao,numero_jogador,nome_jogador
from Jogador
where (nome_jogador like '__r%' or nome_jogador like '%r__')
and contagem_pessoal <> 0
order by 1,3
