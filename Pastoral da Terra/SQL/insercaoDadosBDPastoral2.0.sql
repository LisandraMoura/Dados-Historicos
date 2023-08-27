INSERT INTO User (CPF, Nome, Senha, data_nasc) VALUES
('12345678901', 'João Silva', 'senha123', '1980-05-10'),
('23456789012', 'Maria Oliveira', 'senha456', '1990-03-15'),
('34567890123', 'Pedro Alves', 'senha789', '1975-07-20');

INSERT INTO Pesquisador (CPF, ID_pes) VALUES
('12345678901', 1),
('23456789012', 2);

INSERT INTO Funcionario (CPF, ID_func) VALUES
('34567890123', 1);

INSERT INTO Acervo (ID_acervo, pal_chave, titulo, data_publi, autor) VALUES
(1, 'palavra1,palavra2,palavra3', 'Título 1', '2000-01-01', 'Autor 1'),
(2, 'palavra4,palavra5,palavra6', 'Título 2', '2005-05-05', 'Autor 2');


INSERT INTO Opera (ID_acervo, ID_func) VALUES
(1, 1),
(2, 1);

INSERT INTO Sessao (ID_sessao, data_Acesso, CPF) VALUES
(1, '2023-08-22', '12345678901'),
(2, '2023-08-22', '23456789012');

INSERT INTO Log_Acervo (ID_sessao, Atividade) VALUES
(1, 'atualização'),
(2, 'inserção');

INSERT INTO User_Acervo (CPF, Data_acesso, ID_Acervo) VALUES
('12345678901', '2023-08-22', 1),
('23456789012', '2023-08-22', 2);

INSERT INTO Foto (ID_acervo, PNG) VALUES
(1, 'DUMMY_PNG_1'),
(2, 'DUMMY_PNG_2');

INSERT INTO Doc_Of (ID_acervo, pdf) VALUES
(1, 'DUMMY_PDF_1'),
(2, 'DUMMY_PDF_2');

INSERT INTO Recorte (ID_acervo, PNG) VALUES
(1, 'DUMMY_PNG_1'),
(2, 'DUMMY_PNG_2');

INSERT INTO Forum (ID_forum, nome_forum, data_publi) VALUES
(1, 'Fórum 1', '2023-01-01'),
(2, 'Fórum 2', '2023-02-01');

INSERT INTO User_Acessa_Forum (CPF, data_acesso, ID_forum) VALUES
('12345678901', '2023-08-22', 1),
('23456789012', '2023-08-22', 2);

INSERT INTO User_Cria_Forum (CPF, ID_forum) VALUES
('12345678901', 1),
('23456789012', 2);

INSERT INTO Artigos (ID_artigos, ID_forum, nomeArtigo, palavra_chave, orientador, instituição, PDF) VALUES
(1, 1, 'Artigo 1', 'chave1,chave2,chave3', 'Dr. A', 'Instituto A', 'DUMMY_PDF_1'),
(2, 2, 'Artigo 2', 'chave4,chave5,chave6', 'Dr. B', 'Instituto B', 'DUMMY_PDF_2');

INSERT INTO Autores (ID_artigo, CPF, ID_pes, autor) VALUES
(1, '12345678901', 1, 'Autor 1'),
(2, '23456789012', 2, 'Autor 2');

INSERT INTO Comentario (ID_com, texto) VALUES
(1, 'Comentário 1'),
(2, 'Comentário 2');

INSERT INTO Forum_Coment (ID_forum, ID_com) VALUES
(1, 1),
(2, 2);

INSERT INTO User_Faz_Comentario (CPF, ID_com) VALUES
('12345678901', 1),
('23456789012', 2);



















