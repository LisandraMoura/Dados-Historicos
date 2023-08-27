-- 1 . duas consultas realizando duas operações diferentes sobre conjuntos (união,
-- interseção ou diferença);

-- União de todos os CPF que acessaram o acervo e criaram um forum
select CPF from user_acervo
union
select CPF from user_cria_forum;

-- Encontrar todos os CPF que acessaram o acervo mas não criaram um forum
Select CPF from user_acessa_forum EXCEPT 
select CPF from user_cria_forum;
-- ---------------------------------------------------------------------------------
-- 2 . duas consultas aninhadas pela cláusula FROM

-- Número médio de acessos por usuários no acervo

select AVG(acessos_por_usuario.contagem) as medias_acessos
from(
	select user_acervo.CPF, count(user_acervo.ID_Acervo) as contagem
    from user_acervo
    group by user_acervo.CPF)
as acessos_por_usuario
LIMIT 0,1000;

-- foruns com maior número de artigos do que a média

select f.ID_forum, f.nome_forum, count(a.ID_artigos) as num_artigos
	from Forum f
    join Artigos a
    on f.ID_forum = a.ID_Forum
    group by f.ID_forum, f.nome_forum
    having count(a.ID_artigos) > (
		select AVG(num_artigos)
        from (
			select ID_forum, count(ID_artigos) as num_artigos
            from Artigos
            group by ID_forum)
		as artigos_por_forum);
        
 -- ---------------------------------------------------------------------------------       
-- 3 . quatro consultas envolvendo os operadores como IN, SOME, ANY, ALL, EXISTS e UNIQUE; 

-- Encontrando todos os usuários que acessaram o acervo e criaram forum
select *
from User
where CPF in(
	Select CPF
    from user_cria_forum);
    
-- Encontrando acercos que foram acessados mais de uma vez
select ID_acervo, titulo
from acervo
where(
	select count(*)
    from user_acervo
    where acervo.ID_acervo = user_acervo.ID_Acervo)
    > any (
    select count(*)
    from user_acervo
    group by ID_acervo);

-- Encontrando documentos no acervo que forama acessados mais vezes do que qualquer outro 
select ID_acervo, titulo
from acervo
where (
	select count(*)
    from user_acervo
    where acervo.ID_acervo = user_acervo.ID_Acervo)
    > all (
    select count(*)
    from user_acervo
    group by ID_acervo);
    
-- Usuários que não acessaram o fórum
select *
from user u
where not exists (
	select 1
    from user_acessa_forum uf
    where u.CPF = uf.CPF);
    
-- ---------------------------------------------------------------------------------    
-- 4 . duas consultas aninhadas correlacionadas.

-- Usuarios que não acessaram o acervo
select u.CPF, u.Nome
from user u
where not exists(
select 1
from user_acervo ua
where ua.CPF = u.CPF);

-- Número de vezes de um acervo acessado em comparação com a média geral
select a.ID_acervo, a.titulo,
	(select count(*)
    from user_acervo ua
    where ua.ID_Acervo = a.ID_acervo) as acessos_individuais,
    (select avg(acessos)
    from (
		select count(*) as acessos
        from user_acervo
        group by ID_acervo) sub) as media_acessos
from acervo a;

-- ---------------------------------------------------------------------------------
-- 5. duas consultas escalares

-- total usuarios
select count(*)
from user;

-- data mais recente de acesso ao acervo
select MAX(data_acesso)
from user_acervo;

-- 6 . uma consulta envolvendo a operação de junção definida na cláusula FROM

-- Usuários que criaram foruns
select f.nome_forum, f.data_publi, u.Nome as criador_nome
from forum f
join user_cria_forum ucf
on f.ID_forum = ucf.ID_forum
join user u 
on ucf.CPF = u.CPF;

-- ---------------------------------------------------------------------------------
-- Consultas com OUTER JOIN:

SELECT u.Nome, c.texto 
FROM User u 
LEFT OUTER JOIN User_Faz_Comentario ufc ON u.CPF = ufc.CPF
LEFT OUTER JOIN Comentario c ON ufc.ID_Com = c.ID_Com;

SELECT f.nome_Forum, a.NomeArtigo 
FROM Forum f
LEFT OUTER JOIN Artigos a ON f.ID_Forum = a.ID_Forum;

-- A primeira consulta retorna o nome do usuário e o texto do comentário. Ela faz isso juntando as tabelas de usuários e comentários com base no CPF do usuário.
-- A segunda consulta retorna o nome do fórum e o nome do artigo. Ela faz isso juntando as tabelas de fóruns e artigos com base no ID do fórum.

-- ---------------------------------------------------------------------------------
-- Consultas com agrupamentos e agregações:

SELECT u.Nome, COUNT(c.ID_Com) 
FROM User u 
JOIN User_Faz_Comentario ufc ON u.CPF = ufc.CPF
JOIN Comentario c ON ufc.ID_Com = c.ID_Com
GROUP BY u.Nome;

SELECT f.nome_Forum, COUNT(a.ID_artigos) 
FROM Forum f
JOIN Artigos a ON f.ID_Forum = a.ID_Forum
GROUP BY f.nome_Forum;

-- A primeira consulta retorna o nome do usuário e a quantidade de comentários que ele fez.
-- A segunda consulta retorna o nome do fórum e a quantidade de artigos publicados nele.

-- ---------------------------------------------------------------------------------
-- Consulta com cláusula HAVING:

SELECT u.Nome, COUNT(c.ID_Com) AS NumComentarios
FROM User u
JOIN User_Faz_Comentario ufc ON u.CPF = ufc.CPF
JOIN Comentario c ON ufc.ID_Com = c.ID_Com
JOIN Forum_Coment fc ON c.ID_Com = fc.ID_Com
JOIN Forum f ON fc.ID_forum = f.ID_forum
WHERE f.Data_publi > '2022-01-01'
GROUP BY u.Nome
HAVING COUNT(c.ID_Com) >= 1;

-- Esta consulta retorna os nomes e a quantidade de comentários feitos por usuários que fizeram, ao menos, 1 comentário em fóruns que foram publicados após 2022-01-01.
-- Operações de inserção:

INSERT INTO User (CPF, Nome, Senha, Data_nasc) VALUES ('12345678900', 'NovoUsuario', 'senha123', '2000-01-01');

INSERT INTO User_Faz_Comentario (CPF, ID_Com) SELECT '12345678900', ID_Com FROM Comentario WHERE texto LIKE '%palavra-chave%';

-- A primeira operação insere um novo usuário na tabela de usuários.
-- A segunda operação insere um novo registro na tabela User_Faz_Comentario para o usuário recém-criado e um comentário existente que contém uma palavra-chave específica.

-- ----------------------------------------------

-- Operações de deleção:

DELETE FROM User WHERE Nome = 'NovoUsuario';

DELETE FROM User_Faz_Comentario WHERE CPF IN (SELECT CPF FROM User WHERE Nome = 'Novousuario');

-- A primeira operação exclui um usuário da tabela de usuários.
-- A segunda operação exclui todos os registros na tabela User_Faz_Comentario para o usuário que foi excluído.

-- ----------------------------------------------
-- Operações de modificação:

UPDATE User SET Senha = 'nova_senha123' WHERE Nome = 'UsuarioExistente';

UPDATE Comentario SET texto = 'Novo comentário' WHERE ID_Com IN (SELECT ID_Com FROM User_Faz_Comentario WHERE CPF IN (SELECT CPF FROM User WHERE Nome = 'UsuarioExistente'));

-- A primeira operação atualiza a senha de um usuário existente.
-- A segunda operação atualiza o texto de um comentário feito por um usuário existente.

-- ----------------------------------------------
-- Criação de visões:

CREATE VIEW UsuariosAtivos AS SELECT Nome, COUNT(ufc.ID_Com) as NumComentarios FROM User u JOIN User_Faz_Comentario ufc ON u.CPF = ufc.CPF GROUP BY Nome;

CREATE VIEW ForunsPopulares AS SELECT nome_Forum, COUNT(a.ID_artigos) as NumArtigos FROM Forum f JOIN Artigos a ON f.ID_Forum = a.ID_Forum GROUP BY nome_Forum;

-- A primeira visão mostra a quantidade de comentários feitos por cada usuário.
-- A segunda visão mostra a quantidade de artigos publicados em cada fórum.


