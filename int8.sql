/*
Interrogação 8
--------------
Houve algum jogador que esteve envolvido nalgum evento de todas as partidas que disputou?
Mostre o nome da seleção, para além do nome e do número do jogador.
Ordene pelo nome da seleção e número do jogador.
*/

.mode columns
.headers on
.nullvalue NULL

Drop View If Exists PartidaComGolos;
Drop View If Exists PartidaComCartao;
Drop View If Exists PartidaComSubstituicao;
Drop View If Exists NumeroPartidas;

---------------------------------------------------------

Create View PartidaComGolos As

select PARTIDA, NUMERO, NOME, SELECAO
from(
select id_partida PARTIDA, j.numero_jogador NUMERO, j.nome_jogador NOME, j.nome_selecao SELECAO
from Partida p 
    join Jogador j on 
        (p.nome_selecao_1 = j.nome_selecao or  p.nome_selecao_2 = j.nome_selecao)
    join Golo g on 
        (j.nome_selecao = g.nome_selecao 
        and 
        j.numero_jogador = g.numero_jogador 
        and 
        g.id_evento/1000 = p.id_partida)
group by 1,2
)
group by 1,2;

---------------------------------------------------------

Create View PartidaComCartao As

select PARTIDA,NUMERO, NOME, SELECAO
from(
select id_partida PARTIDA, j.numero_jogador NUMERO,j.nome_jogador NOME, j.nome_selecao SELECAO
from Partida p 
    join Jogador j on 
        (p.nome_selecao_1 = j.nome_selecao or  p.nome_selecao_2 = j.nome_selecao)
    join Cartao c on 
        (j.nome_selecao = c.nome_selecao 
        and 
        j.numero_jogador = c.numero_jogador 
        and 
        c.id_evento/1000 = p.id_partida)
group by 1,2
)
group by 1,2;

---------------------------------------------------------

Create View PartidaComSubstituicao As

select PARTIDA, NUMERO,NOME, SELECAO
from(
select id_partida PARTIDA, j.numero_jogador NUMERO,j.nome_jogador NOME, j.nome_selecao SELECAO
from Partida p 
    join Jogador j on 
        (p.nome_selecao_1 = j.nome_selecao or  p.nome_selecao_2 = j.nome_selecao)
    join Substituicao s on 
        ((j.nome_selecao = s.nome_selecao_entra
        and 
        j.numero_jogador = s.numero_jogador_entra) or
         (j.nome_selecao = s.nome_selecao_sai
        and 
        j.numero_jogador = s.numero_jogador_sai))
        and 
        s.id_evento/1000 = p.id_partida
group by 1,2
)
group by 1,2;

---------------------------------------------------------

Create View NumeroPartidas As

select SELECAO, NR_PARTIDAS_1+NR_PARTIDAS_2 NR_PARTIDAS_TOTAL
from

(select nome_selecao_1 SELECAO, count(*) NR_PARTIDAS_1
from Partida
group by 1)

NATURAL JOIN 

(select nome_selecao_2 SELECAO, count(*) NR_PARTIDAS_2
from Partida
group by 1);


---------------------------------------------------------

SELECT SELECAO, NUMERO, NOME

FROM

(Select NUMERO,NOME, SELECAO, COUNT(*) PARTIDAS_COM_EVENTO

from
(
Select * from PartidaComGolos
UNION
Select * from PartidaComSubstituicao
UNION
Select * from PartidaComCartao)

GROUP BY NOME,SELECAO)

JOIN
(SELECT * FROM NumeroPartidas) 

USING(SELECAO)

WHERE PARTIDAS_COM_EVENTO = NR_PARTIDAS_TOTAL

ORDER BY SELECAO, NUMERO
