/*
Interrogação 1
--------------
Mostre a média de golos de todas as seleções que não se apuraram para a fase eliminatória.
*/

.mode columns
.headers ON
.nullvalue NULL

SELECT AVG(soma_golos) AS MEDIA_GOLOS_SELECOES_ELIMINADAS 
FROM (SELECT SUM(contagem_pessoal) AS soma_golos 
      FROM (SELECT * 
            FROM Selecao 
            WHERE posicao_grupo > 2) AS Selecoes_elim
      JOIN Jogador ON Selecoes_elim.nome_selecao = Jogador.nome_selecao
      GROUP BY Jogador.nome_selecao);
