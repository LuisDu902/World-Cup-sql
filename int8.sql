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
select e.id_partida PARTIDA, j.numero_jogador NUMERO, j.nome_jogador NOME, j.nome_selecao SELECAO
from Partida p 
    join Jogador j on 
        (p.nome_selecao_1 = j.nome_selecao or  p.nome_selecao_2 = j.nome_selecao)
    join (Golo g join Evento e using(id_evento)) on 
        (j.nome_selecao = g.nome_selecao 
        and 
        j.numero_jogador = g.numero_jogador 
        and 
         e.id_partida = p.id_partida)
group by 1,2
)
group by 1,2;

---------------------------------------------------------
Create View PartidaComCartao As

select PARTIDA,NUMERO, NOME, SELECAO
from(
select e.id_partida PARTIDA, j.numero_jogador NUMERO,j.nome_jogador NOME, j.nome_selecao SELECAO
from Partida p 
    join Jogador j on 
        (p.nome_selecao_1 = j.nome_selecao or  p.nome_selecao_2 = j.nome_selecao)
    join (Cartao c join Evento e using(id_evento)) on 
        (j.nome_selecao = c.nome_selecao 
        and 
        j.numero_jogador = c.numero_jogador 
        and 
        e.id_partida = p.id_partida)
group by 1,2
)
group by 1,2;

---------------------------------------------------------
Create View PartidaComSubstituicao As

Select p.id_partida PARTIDA, s.numero_jogador_entra NUMERO, j.nome_jogador NOME, s.nome_selecao_entra SELECAO
From (Substituicao s join Evento e on (s.id_evento = e.id_evento)) 
    Join Partida p on (e.id_partida = p.id_partida) 
    JOIN JOGADOR j ON (j.numero_jogador = s.numero_jogador_entra and j.nome_selecao = s.nome_selecao_entra) 
Group by 1, 2, 3

Union

Select p.id_partida PARTIDA, s.numero_jogador_sai NUMERO, j.nome_jogador NOME, s.nome_selecao_sai SELECAO
From (Substituicao s join Evento e on (s.id_evento = e.id_evento)) Join Partida p on (e.id_partida = p.id_partida) JOIN JOGADOR j ON (j.numero_jogador = s.numero_jogador_sai and j.nome_selecao = s.nome_selecao_sai) 
Group by 1, 2, 3;

---------------------------------------------------------
Create View NumeroPartidas As

select SELECAO, NR_PARTIDAS_1+NR_PARTIDAS_2 AS NR_PARTIDAS_TOTAL
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