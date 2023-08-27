CREATE TABLE User (
  CPF VARCHAR(11) PRIMARY KEY,
  Nome VARCHAR(255),
  Senha VARCHAR(255),
  data_nasc DATE
);

CREATE TABLE Sessao (
  ID_sessao INT PRIMARY KEY,
  data_Acesso DATE,
  CPF VARCHAR(11),
  FOREIGN KEY (CPF) REFERENCES User(CPF)
);

CREATE TABLE Pesquisador (
  CPF VARCHAR(11),
  ID_pes INT,
  PRIMARY KEY (CPF, ID_pes),
  FOREIGN KEY (CPF) REFERENCES User(CPF)
);
CREATE TABLE Funcionario (
  CPF VARCHAR(11),
  ID_func INT PRIMARY KEY,
  FOREIGN KEY (CPF) REFERENCES User(CPF)
);

CREATE TABLE Acervo (
  ID_acervo INT PRIMARY KEY,
  pal_chave VARCHAR(255),
  titulo VARCHAR(255),
  data_publi DATE,
  autor VARCHAR(255)
);

CREATE TABLE Opera (
  ID_acervo INT,
  CPF VARCHAR(11),
  ID_func INT,
  PRIMARY KEY (ID_acervo, ID_func),
  FOREIGN KEY (ID_acervo) REFERENCES Acervo(ID_acervo),
  FOREIGN KEY (CPF, ID_func) REFERENCES Funcionario(CPF, ID_func)
);



CREATE TABLE Log_Acervo (
  ID_sessao INT,
  Atividade ENUM('atualização', 'exclusão', 'inserção'),
  FOREIGN KEY (ID_sessao) REFERENCES Sessao(ID_sessao)
);

CREATE TABLE User_Acervo (
  CPF VARCHAR(11),
  Data_acesso DATE,
  ID_Acervo INT,
  FOREIGN KEY (CPF) REFERENCES User(CPF),
  FOREIGN KEY (ID_Acervo) REFERENCES Acervo(ID_acervo)
);


CREATE TABLE Foto (
  ID_acervo INT,
  PNG BLOB,
  FOREIGN KEY (ID_acervo) REFERENCES Acervo(ID_acervo)
);

CREATE TABLE Doc_Of (
  ID_acervo INT,
  pdf BLOB,
  FOREIGN KEY (ID_acervo) REFERENCES Acervo(ID_acervo)
);

CREATE TABLE Recorte (
  ID_acervo INT,
  PNG BLOB,
  FOREIGN KEY (ID_acervo) REFERENCES Acervo(ID_acervo)
);

CREATE TABLE Forum (
  ID_forum INT PRIMARY KEY,
  nome_forum VARCHAR(255),
  data_publi DATE
);

CREATE TABLE User_Acessa_Forum (
  CPF VARCHAR(11),
  data_acesso DATE,
  ID_forum INT,
  FOREIGN KEY (CPF) REFERENCES User(CPF),
  FOREIGN KEY (ID_forum) REFERENCES Forum(ID_forum)
);

CREATE TABLE User_Cria_Forum (
  CPF VARCHAR(11),
  ID_forum INT,
  FOREIGN KEY (CPF) REFERENCES User(CPF),
  FOREIGN KEY (ID_forum) REFERENCES Forum(ID_forum)
);
CREATE TABLE Artigos (
  ID_artigos INT PRIMARY KEY,
  ID_forum INT,
  nomeArtigo VARCHAR(255),
  palavra_chave VARCHAR(255),
  orientador VARCHAR(255),
  instituição VARCHAR(255),
  PDF BLOB,
  FOREIGN KEY (ID_forum) REFERENCES Forum(ID_forum)
);

CREATE TABLE Autores (
  ID_artigo INT,
  CPF VARCHAR(11),
  ID_pes INT,
  autor VARCHAR(255),
  FOREIGN KEY (ID_artigo) REFERENCES Artigos(ID_artigos),
  FOREIGN KEY (CPF, ID_pes) REFERENCES Pesquisador(CPF, ID_pes)
);


CREATE TABLE Comentario (
  ID_com INT PRIMARY KEY,
  texto TEXT
);

CREATE TABLE Forum_Coment (
  ID_forum INT,
  ID_com INT,
  FOREIGN KEY (ID_forum) REFERENCES Forum(ID_forum),
  FOREIGN KEY (ID_com) REFERENCES Comentario(ID_com)
);

CREATE TABLE User_Faz_Comentario (
  CPF VARCHAR(11),
  ID_com INT,
  FOREIGN KEY (CPF) REFERENCES User(CPF),
  FOREIGN KEY (ID_com) REFERENCES Comentario(ID_com)
);







