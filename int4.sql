/*
Interrogação 4
--------------
Selecione a média de cartões dos jogadores da seleção com maior número de substituições.
Mostre o nome da seleção, o número total de cartões, o número de jogadores da seleção e a média pedida, arredondada a 3 casas decimais.
*/

.mode columns
.headers ON
.nullvalue NULL

SELECT A.nome_selecao AS NOME_SELECAO, NUM_CARTOES, NUM_JOGADORES, ROUND(NUM_CARTOES*1.0/NUM_JOGADORES, 3) AS MEDIA
FROM 

(SELECT nome_selecao, MAX(total_subs)
 FROM (SELECT nome_selecao_entra AS nome_selecao, COUNT(*) AS total_subs
      FROM Substituicao
      GROUP BY nome_selecao_entra)) AS A, 

(SELECT nome_selecao, COUNT(*) AS NUM_CARTOES
 FROM Cartao
 GROUP BY nome_selecao) AS B, 

(SELECT nome_selecao, COUNT(*) AS NUM_JOGADORES
 FROM Jogador
 GROUP BY nome_selecao) AS C

WHERE A.nome_selecao = B.nome_selecao AND A.nome_selecao = C.nome_selecao;