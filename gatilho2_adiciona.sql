/*
Gatilho 2
---------
Não deixar inserir uma seleção na fase eliminatória que já tenha sido eliminada na fase 
de grupos.
*/

CREATE TRIGGER gatilho2
BEFORE INSERT ON Partida
FOR EACH ROW
WHEN new.nome_selecao_1 IN (SELECT nome_selecao FROM Selecao WHERE posicao_grupo > 2)
OR new.nome_selecao_2 IN (SELECT nome_selecao FROM Selecao WHERE posicao_grupo > 2)
BEGIN
    SELECT RAISE(ABORT,"Uma seleção eliminada na fase de grupos não pode participar de uma partida da fase eliminatória");
END;
