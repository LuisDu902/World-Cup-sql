.mode columns
.headers on
.nullvalue NULL

/*
Interrogação 9
--------------
Mostrar a média de golos de todas as seleções que não se apuraram para a fase eliminatoria 
*/

select avg(soma_golos) as MEDIA_GOLOS_SELECOES_ELIMINADAS from 
(select sum(contagem_pessoal) as soma_golos from 
(select * from Selecao where 
nome_selecao not in (select nome_selecao_1 from Partida where numero_jornada = 4)
and 
nome_selecao not in (select nome_selecao_2 from Partida where numero_jornada = 4)) as Selecoes_elim
join Jogador on Selecoes_elim.nome_selecao = Jogador.nome_selecao
group by Jogador.nome_selecao)




 