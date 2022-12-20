DROP TABLE IF EXISTS Desempate;
DROP TABLE IF EXISTS Substituicao;
DROP TABLE IF EXISTS Golo;
DROP TABLE IF EXISTS Cartao;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Partida;
DROP TABLE IF EXISTS Jornada;
DROP TABLE IF EXISTS Estadio;
DROP TABLE IF EXISTS Jogador;
DROP TABLE IF EXISTS Selecao;
DROP TABLE IF EXISTS Grupo;

CREATE TABLE Grupo(
    letra CHAR(1) CHECK (letra = "A" OR letra = "B" OR letra = "C" OR letra = "D" OR letra = "E" OR letra = "F" OR letra = "G" OR letra = "H" ),
    PRIMARY KEY (letra)
);

CREATE TABLE Selecao(
    nome_selecao VARCHAR(50),
    pontuacao_grupo NUMERIC NOT NULL CHECK (pontuacao_grupo >= 0 AND pontuacao_grupo <=9),
    posicao_grupo NUMERIC NOT NULL CHECK (posicao_grupo >= 1 AND posicao_grupo <=4),
    letra VARCHAR(1) NOT NULL,
    UNIQUE (posicao_grupo,letra),
    FOREIGN KEY (letra) REFERENCES Grupo(letra) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(nome_selecao)
);

CREATE TABLE Jogador(
    numero_jogador NUMERIC,
    nome_selecao VARCHAR(50),
    nome_jogador VARCHAR(50) NOT NULL,
    contagem_pessoal NUMERIC NOT NULL CHECK (contagem_pessoal >= 0),
    FOREIGN KEY (nome_selecao) REFERENCES Selecao(nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (numero_jogador, nome_selecao)
);

CREATE TABLE Estadio(
    nome_estadio VARCHAR(50),
    sede VARCHAR(50) NOT NULL,
    capacidade NUMERIC NOT NULL CHECK (capacidade > 0),
    PRIMARY KEY (nome_estadio)
);

CREATE TABLE Jornada(
    numero_jornada NUMERIC CHECK (numero_jornada >= 1 AND numero_jornada <= 8),
    nome_fase VARCHAR(50) NOT NULL CHECK (nome_fase = "grupos" OR nome_fase = "oitavas de final" OR nome_fase = "quartas de final" OR nome_fase = "semifinais" OR nome_fase = "jogo para o 3º lugar" OR nome_fase = "final"),
    PRIMARY KEY(numero_jornada)
);

CREATE TABLE Partida(
    id_partida NUMERIC,
    golos_marcados_selecao1 NUMERIC NOT NULL CHECK (golos_marcados_selecao1 >= 0),
    golos_marcados_selecao2 NUMERIC NOT NULL CHECK (golos_marcados_selecao2 >= 0),
    data DATE NOT NULL,
    hora TIME NOT NULL,
    duracao NUMERIC NOT NULL CHECK(duracao = 90 OR duracao = 120),
    nome_estadio VARCHAR(50) NOT NULL,
    numero_jornada NUMERIC NOT NULL,
    nome_selecao_1 VARCHAR(50) NOT NULL,
    nome_selecao_2 VARCHAR(50) NOT NULL,
    CHECK (nome_selecao_1 <> nome_selecao_2),
    UNIQUE (nome_selecao_1,nome_selecao_2,data),
    FOREIGN KEY (nome_estadio) REFERENCES Estadio(nome_estadio) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (numero_jornada) REFERENCES Jornada(numero_jornada) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (nome_selecao_1) REFERENCES Selecao(nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (nome_selecao_2) REFERENCES Selecao(nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_partida)
);

CREATE TABLE Evento(
    id_evento NUMERIC,
    minuto NUMERIC NOT NULL CHECK (minuto > 0),
    id_partida NUMERIC NOT NULL,
    UNIQUE (minuto,id_partida),
    FOREIGN KEY (id_partida) REFERENCES Partida(id_partida) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_evento)
);

CREATE TABLE Cartao(
    id_evento NUMERIC,
    cor VARCHAR(8) NOT NULL CHECK (cor = "amarela" OR cor = "vermelha"),
    numero_jogador NUMERIC NOT NULL,
    nome_selecao VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (numero_jogador, nome_selecao) REFERENCES Jogador(numero_jogador, nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,  
    PRIMARY KEY (id_evento)
);

CREATE TABLE Golo(
    id_evento NUMERIC,
    tipo VARCHAR(50) NOT NULL CHECK (tipo = "default" OR tipo = "autogolo" OR tipo = "penalti"),
    numero_jogador NUMERIC NOT NULL,
    nome_selecao VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (numero_jogador, nome_selecao) REFERENCES Jogador(numero_jogador, nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_evento)
);

CREATE TABLE Substituicao(
    id_evento NUMERIC,
    numero_jogador_entra NUMERIC NOT NULL,
    nome_selecao_entra VARCHAR(50) NOT NULL,
    numero_jogador_sai NUMERIC NOT NULL,
    nome_selecao_sai VARCHAR(50) NOT NULL,
    CHECK (nome_selecao_entra = nome_selecao_sai),
    CHECK (numero_jogador_entra <> numero_jogador_sai),
    FOREIGN KEY (numero_jogador_entra, nome_selecao_entra) REFERENCES Jogador(numero_jogador, nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (numero_jogador_sai, nome_selecao_sai) REFERENCES Jogador(numero_jogador, nome_selecao) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_evento)
);

CREATE TABLE Desempate (
    id_desempate NUMERIC,
    penalties_selecao1 NUMERIC NOT NULL CHECK (penalties_selecao1 >= 0),
    penalties_selecao2 NUMERIC NOT NULL CHECK (penalties_selecao2 >= 0),
    id_partida NUMERIC NOT NULL,
    CHECK (penalties_selecao1 <> penalties_selecao2),
    CHECK (ABS(penalties_selecao1 - penalties_selecao2) <= 3),
    FOREIGN KEY (id_partida) REFERENCES Partida(id_partida) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_desempate)
);