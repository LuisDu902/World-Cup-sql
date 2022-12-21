CREATE TRIGGER gatilho1
AFTER INSERT ON Golo
FOR EACH ROW 
BEGIN
    
    UPDATE Jogador SET contagem_pessoal = contagem_pessoal + 1
    
    WHERE Jogador.numero_jogador = new.numero_jogador AND 
          Jogador.nome_selecao = new.nome_selecao AND 
          new.tipo = "default";
    
    --------------------------------------------------------------------------------------------------
    
    UPDATE Partida 
    SET golos_marcados_selecao1 = golos_marcados_selecao1 +
        (Partida.nome_selecao_1 = new.nome_selecao AND new.tipo = "default") + 
        (Partida.nome_selecao_2 = new.nome_selecao AND new.tipo = "autogolo"),

        golos_marcados_selecao2 = golos_marcados_selecao2 + 
        (Partida.nome_selecao_2 = new.nome_selecao AND new.tipo = "default") + 
        (Partida.nome_selecao_1 = new.nome_selecao AND new.tipo = "autogolo")
    
    WHERE (SELECT id_partida FROM Golo join Evento using(id_evento) 
           WHERE Golo.id_evento = new.id_evento) = Partida.id_partida;

    --------------------------------------------------------------------------------------------------

    UPDATE Desempate 
    SET penalties_selecao1 = penalties_selecao1 + 
        ((SELECT nome_selecao_1 FROM Partida 
        WHERE Desempate.id_partida = Partida.id_partida) = new.nome_selecao AND new.tipo = "penalti"),
        
        penalties_selecao2 = penalties_selecao2 + 
        ((SELECT nome_selecao_2 FROM Partida 
        WHERE Desempate.id_partida = Partida.id_partida) = new.nome_selecao AND new.tipo = "penalti")

    WHERE (SELECT id_partida FROM 
            Golo join Evento using(id_evento) WHERE Golo.id_evento = new.id_evento) = Desempate.id_partida;
END;
