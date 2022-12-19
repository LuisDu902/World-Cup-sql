DROP TABLE IF EXISTS Perdedores;

CREATE TABLE Perdedores (
    nome_selecao VARCHAR(50) PRIMARY KEY
);

CREATE TRIGGER gatilho3
after insert on Partida
for each row
when new.numero_jornada > 3 and new.golos_marcados_selecao1 <> new.golos_marcados_selecao2

begin 
insert into Perdedores Select NOME

From
(Select NOME, min(GOLOS) from (

Select p.nome_selecao_1 as NOME, p.golos_marcados_selecao1 as GOLOS
From Partida as p
Where new.id_partida = p.id_partida

Union

Select p.nome_selecao_2 as NOME, p.golos_marcados_selecao2 as GOLOS
From Partida as p
Where new.id_partida = p.id_partida));
end;
