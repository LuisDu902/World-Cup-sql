CREATE TRIGGER gatilho1
BEFORE INSERT ON Golo
FOR EACH ROW 
BEGIN
    UPDATE Jogador SET contagem_pessoal = contagem_pessoal + 1
    WHERE Jogador.numero_jogador = new.numero_jogador AND Jogador.nome_selecao = new.nome_selecao AND new.tipo = "default";
END;
