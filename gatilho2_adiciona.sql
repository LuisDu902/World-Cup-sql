CREATE TRIGGER gatilho2
before insert on Partida
for each row
when new.nome_selecao_1 in (select nome_selecao from Selecao where posicao_grupo > 2)
or new.nome_selecao_2 in (select nome_selecao from Selecao where posicao_grupo > 2)
begin
    select raise(abort,"Uma seleção eliminada na fase de grupos não pode participar de uma partida da fase eliminatoria");
end;