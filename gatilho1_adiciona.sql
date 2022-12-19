CREATE TRIGGER gatilho1
before insert on Golo
for each row 
begin
    update Jogador set contagem_pessoal = contagem_pessoal + 1
    where Jogador.numero_jogador = new.numero_jogador and Jogador.nome_selecao = new.nome_selecao
        and new.tipo = "default";
end;
