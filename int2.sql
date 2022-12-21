/*
Interrogação 2
--------------
Mostre as seleções que ficaram no pódio (1º, 2º e 3º lugares), ordenadamente. 
*/

.mode columns
.headers ON
.nullvalue NULL

SELECT g.nome_selecao AS PODIO
FROM (Golo g JOIN Evento e ON (g.id_evento = e.id_evento)) 
    JOIN Partida p ON (e.id_partida = p.id_partida)
    WHERE p.id_partida IN (SELECT p.id_partida
                           FROM Partida p JOIN Jornada j ON (p.numero_jornada = j.numero_jornada)
                           WHERE j.nome_fase = "final" OR j.nome_fase = "jogo para o 3º lugar")
GROUP BY g.nome_selecao
ORDER BY p.data DESC, COUNT(g.id_evento) DESC
LIMIT 3;
