/*
Gatilho 3
---------
Quando uma seleção é eliminada na fase eliminatória, acrescentá-la à tabela dos 
Perdedores.
*/

DROP TABLE IF EXISTS Perdedores;

CREATE TABLE Perdedores (
    nome_selecao VARCHAR(50) PRIMARY KEY
);

CREATE TRIGGER gatilho3
AFTER INSERT ON Partida
FOR EACH ROW
WHEN new.numero_jornada > 3 AND new.golos_marcados_selecao1 <> new.golos_marcados_selecao2
BEGIN 
    INSERT INTO Perdedores SELECT NOME
    FROM
    (SELECT NOME, MIN(GOLOS) FROM (
        SELECT p.nome_selecao_1 AS NOME, p.golos_marcados_selecao1 AS GOLOS
        FROM Partida AS p
        WHERE new.id_partida = p.id_partida

        UNION

        SELECT p.nome_selecao_2 AS NOME, p.golos_marcados_selecao2 AS GOLOS
        FROM Partida AS p
        WHERE new.id_partida = p.id_partida));
END;
