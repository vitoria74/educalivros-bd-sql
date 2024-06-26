CREATE TABLE Usuario (
    Endereco VARCHAR,
    CPF CHAR PRIMARY KEY, 
    fk_Avaliacao_ID VARCHAR
    fk_Plano_Premium_CPF CHAR 
    
);

CREATE PROCEDURE UpdateUsuario(IN p_CPF CHAR, IN p_Endereco VARCHAR, IN p_Avaliacao_ID VARCHAR, IN p_Plano_Premium_CPF CHAR)
BEGIN
    UPDATE Usuario
    SET Endereco = p_Endereco,
        fk_Avaliacao_ID = p_Avaliacao_ID,
        fk_Plano_Premium_CPF = p_Plano_Premium_CPF
    WHERE CPF = p_CPF;
END;


CREATE PROCEDURE DeleteUsuario(IN p_CPF CHAR)
BEGIN
    DELETE FROM Usuario WHERE CPF = p_CPF;
END;

CREATE TABLE Professor (
    Departamento VARCHAR,
    _IP_Identificacao_do_professor CHAR,
    Disciplina VARCHAR,
    fk_Usuario_CPF CHAR,
    PRIMARY KEY (_IP_Identificacao_do_professor, fk_Usuario_CPF)
);

CREATE PROCEDURE UpdateProfessor(IN p_IP_Identificacao CHAR, IN p_CPF CHAR, IN p_Departamento VARCHAR, IN p_Disciplina VARCHAR)
BEGIN
    UPDATE Professor
    SET Departamento = p_Departamento,
        Disciplina = p_Disciplina
    WHERE _IP_Identificacao_do_professor = p_IP_Identificacao AND fk_Usuario_CPF = p_CPF;
END;


CREATE PROCEDURE DeleteProfessor(IN p_IP_Identificacao CHAR, IN p_CPF CHAR)
BEGIN
    DELETE FROM Professor WHERE _IP_Identificacao_do_professor = p_IP_Identificacao AND fk_Usuario_CPF = p_CPF;
END;

CREATE TABLE Aluno (
matricula char PRIMARY KEY, 
_cr__coeficiente_de_rendimento double, 
faltas_BD integer,
faltas_SO integer,
faltas_Redes integer,
cpfaluno VARCHAR 
foreign key (cpfaluno) references usuario(cpf)
);

CREATE TABLE Cliente_Externo_ (
    E_mail VARCHAR,
    fk_Usuario_CPF CHAR,
    PRIMARY KEY (E_mail, fk_Usuario_CPF)
);

CREATE TABLE Livro (
    Quant_Estoque SMALLINT,
    ISBN CHAR,
    Titulo VARCHAR,
    fk_Produto_ID CHAR,
    fk_Editora_Codigo CHAR,
    fk_Editora_Nome VARCHAR,
    fk_Editora_E_mail VARCHAR,
    PRIMARY KEY (ISBN, fk_Produto_ID)
);

CREATE PROCEDURE UpdateLivro(IN p_ISBN CHAR, IN p_fk_Produto_ID CHAR, IN p_Quant_Estoque SMALLINT, IN p_Titulo VARCHAR)
BEGIN
    UPDATE Livro
    SET Quant_Estoque = p_Quant_Estoque,
        Titulo = p_Titulo
    WHERE ISBN = p_ISBN AND fk_Produto_ID = p_fk_Produto_ID;
END;

CREATE PROCEDURE DeleteLivro(IN p_ISBN CHAR, IN p_fk_Produto_ID CHAR)
BEGIN
    DELETE FROM Livro WHERE ISBN = p_ISBN AND fk_Produto_ID = p_fk_Produto_ID;
END;

ALTER TABLE Livro ADD COLUMN Nota_Media FLOAT; 
CREATE TABLE AudioBook ( 
  	ISBN CHAR,
    Titulo VARCHAR,
    fk_Produto_ID CHAR,
    fk_Editora_Codigo CHAR,
    fk_Editora_Nome VARCHAR,
    fk_Editora_E_mail VARCHAR,
    PRIMARY KEY (ISBN, fk_Produto_ID)
);

CREATE TABLE Ebook ( 
  	ISBN CHAR,
    Titulo VARCHAR,
    fk_Produto_ID CHAR,
    fk_Editora_Codigo CHAR,
    fk_Editora_Nome VARCHAR,
    fk_Editora_E_mail VARCHAR,
    PRIMARY KEY (ISBN, fk_Produto_ID)
);

CREATE TABLE Entrega (
    Frete FLOAT,
    Status VARCHAR,
    Endereco VARCHAR,
    Numero SMALLINT PRIMARY KEY,
    fk_Pedido_Numero SMALLINT
);

CREATE TABLE Autor (
    P_Nome VARCHAR,
    S_Nome VARCHAR, 
    Numero_de_Vendas SMALLINT
);

CREATE TABLE editora (
    codigo VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    uf VARCHAR(2),
    pais VARCHAR(100),
    e_mail VARCHAR(100) UNIQUE
) ;

CREATE TABLE Categoria (
    ID CHAR PRIMARY KEY,
    Nome VARCHAR,
    Descricao VARCHAR,
    Numero_de_livros SMALLINT,
    Numero_de_livros_vendidos SMALLINT
    
);

CREATE TABLE Avaliacao (
    ID CHAR PRIMARY KEY,
    Nome CHARACTER,
    Data DATE,
    Comentarios VARCHAR,
    Nota FLOAT
);

CREATE TABLE Pedido (
    Data DATE,
    status VARCHAR,
    Cartao CHAR,
    Dinheiro CHAR,
    Valor FLOAT,
    Produto VARCHAR,
    Numero SMALLINT PRIMARY KEY,
    fk_Usuario_CPF CHAR
);

CREATE TABLE Plano_Premium (
    desconto FLOAT,
    CPF CHAR PRIMARY KEY
);

CREATE TABLE Material_Escolar (
    Caderno FLOAT,
    Bolsa FLOAT,
    Codigo_Barra CHAR, 
    Caderno_vendido SMALLINT, 
    Bolsa_vendida SMALLINT,
    fk_Produto_ID CHAR, 
    PRIMARY KEY (Codigo_Barra, fk_Produto_ID)
);

CREATE TABLE Jogos_Tabuleiro ( 
  Nome_Jogo VARCHAR,
  Codigo_Barra CHAR,
  fk_Produto_ID CHAR,
  PRIMARY KEY (Codigo_Barra, fk_Produto_ID)
);

CREATE TABLE Produto (
    ID CHAR PRIMARY KEY,
    Nome VARCHAR, 
    Numero_de_Vendas SMALLINT
);

CREATE TABLE faz (
    fk_Avaliacao_ID CHAR,
    fk_Usuario_CPF CHAR
);

CREATE TABLE escrito (
    fk_Livro_ISBN CHAR,
    fk_Livro_fk_Produto_ID CHAR
);

CREATE TABLE pertence (
    fk_Categoria_ID CHAR,
    fk_Livro_ISBN CHAR,
    fk_Livro_fk_Produto_ID CHAR
);

CREATE TABLE obtem (
    fk_Produto_ID CHAR,
    fk_Pedido_Numero SMALLINT
);

CREATE TABLE recebe (
    fk_Avaliacao_ID CHAR,
    fk_Livro_ISBN CHAR, 
    fk_Livro_fk_Produto_ID Char
);

CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY 'senha_admin';
CREATE USER 'usuario_comum'@'localhost' IDENTIFIED BY 'senha_comum';

CREATE ROLE admin_role;
CREATE ROLE comum_role;

GRANT ALL PRIVILEGES ON testDB.* TO admin_role;
GRANT SELECT, INSERT ON testDB.avaliação TO comum_role;

GRANT admin_role TO 'usuario_admin'@'localhost';
GRANT comum_role TO 'usuario_comum'@'localhost';

SET DEFAULT ROLE admin_role FOR 'usuario_admin'@'localhost';
SET DEFAULT ROLE comum_role FOR 'usuario_comum'@'localhost';

REVOKE ALL PRIVILEGES ON testDB.* FROM 'usuario_admin'@'localhost';
REVOKE ALL PRIVILEGES ON testDB.* FROM 'usuario_comum'@'localhost';

INSERT INTO Usuario (Endereco, CPF, fk_Avaliacao_ID) VALUES
('Rua A, 123', '12345678901', 'AVL001'),
('Avenida B, 456', '98765432109', 'AVL002'),
('Rua C, 789', '24681357902', 'AVL003'),
('Rua D, 321', '13579246804', 'AVL004'),
('Avenida E, 654', '36925814706', 'AVL005');

INSERT INTO Professor (Departamento, _IP_Identificacao_do_professor, Disciplina, fk_Usuario_CPF) VALUES
('Ciência da Computação', 'PRF001', 'Introdução à Programação', '12345678901'),
('Matemática', 'PRF002', 'Álgebra Linear', '98765432109'),
('Engenharia Civil', 'PRF003', 'Mecânica dos Solos', '24681357902'),
('Letras', 'PRF004', 'Literatura Brasileira', '13579246804'),
('Medicina', 'PRF005', 'Anatomia Humana', '36925814706');

INSERT INTO Aluno (Matricula, _CR__coeficiente_de_rendimento, Faltas, fk_Usuario_CPF) VALUES
('2023001', 8.5, 2, '12345678901'),
('2023002', 7.2, 5, '98765432109'),
('2023003', 9.0, 1, '24681357902'),
('2023004', 6.8, 3, '13579246804'),
('2023005', 8.0, 0, '36925814706');

INSERT INTO Cliente_Externo_ (fk_Usuario_CPF) VALUES
('12345678901'),
('98765432109'),
('24681357902'),
('13579246804'),
('36925814706');

INSERT INTO Livro (Quant_Estoque, ISBN, Titulo, fk_Produto_ID, fk_Editora_Codigo, fk_Editora_Nome, fk_Editora_E_mail) VALUES
(100, '978-0142420591', '1984', 'LIV001', 'EDI001', 'Penguin Books', 'penguin@example.com'),
(50, '978-0553212457', 'Moby Dick', 'LIV002', 'EDI002', 'Bantam', 'bantam@example.com'),
(80, '978-0486280615', 'Romeu e Julieta', 'LIV003', 'EDI003', 'Dover Publications', 'dover@example.com'),
(120, '978-0451524935', 'Dom Quixote', 'LIV004', 'EDI004', 'Signet', 'signet@example.com'),
(70, '978-1983397910', 'Crime e Castigo', 'LIV005', 'EDI005', 'Independently published', 'independent@example.com');

INSERT INTO AudioBook (ISBN, Titulo, fk_Produto_ID, fk_Editora_Codigo, fk_Editora_Nome, fk_Editora_E-mail) VALUES --Vitória
( '978-0307277671', 'Jogador Número 1', 'AUD001', 'EDI001', 'Penguin Books', 'penguin@example.com'),
( '978-0143039434', 'Blade Runner', 'AUD002', 'EDI002', 'Bantam', 'bantam@example.com'),
( '978-0553801477', 'O Hobbit', 'AUD003', 'EDI003', 'Dover Publications', 'dover@example.com'),
( '978-0747532699', 'Jogos Vorazes', 'AUD004', 'EDI004', 'Signet', 'signet@example.com'),
( '978-0061120084', 'O Senhor dos Anéis', 'AUD005', 'EDI005', 'Independently published', 'independent@example.com');

INSERT INTO Ebook (ISBN, Titulo, fk_Produto_ID, fk_Editora_Codigo, fk_Editora_Nome, fk_Editora_E-mail) VALUES --Vitória
( '978-0-306-40615-7', 'Dominando Python: Do Básico ao Avançado', 'EBO001', 'EDI001', 'Penguin Books', 'penguin@example.com'),
( '978-0143039434-5', 'Desenvolvimento Web Moderno: Práticas e Técnicas Essenciais', 'EBO002','EDI002', 'Bantam', 'bantam@example.com'),
( '978-0-14-044425-4', 'JavaScript Ninja: Domine a Arte da Programação Front-End', 'EBO003', 'EDI003', 'Dover Publications', 'dover@example.com'),
( '978-0-06-231500-7', 'Algoritmos e Estruturas de Dados: Uma Abordagem Prática', 'EBO004', 'EDI004', 'Signet', 'signet@example.com'),
( '978-0-385-35139-7', 'A Arte de Programar em C++: Conceitos e Aplicações', 'EBO005', 'EDI005', 'Independently published', 'independent@example.com');

INSERT INTO Entrega (Frete, Status, Endereco) VALUES
(10.50, 'Entregue', 'Rua X, 789'),
(8.75, 'Pendente', 'Avenida Y, 456'),
(12.20, 'Em Trânsito', 'Rua Z, 123'),
(15.80, 'Entregue', 'Avenida W, 654'),
(9.99, 'Pendente', 'Rua V, 321');

INSERT INTO Autor (P_Nome, S_Nome, Numero_de_Vendas) VALUES
('George', 'Orwell', 12),
('Herman', 'Melville', 58),
('William', 'Shakespeare', 63),
('Miguel', 'de Cervantes', 23),
('Fyodor', 'Dostoevsky', 13);

INSERT INTO Editora (Codigo, Nome, Endereco, E_mail) VALUES
('EDI001', 'Penguin Books', '123 Penguin Street', 'penguin@example.com'),
('EDI002', 'Bantam', '456 Bantam Avenue', 'bantam@example.com'),
('EDI003', 'Dover Publications', '789 Dover Lane', 'dover@example.com'),
('EDI004', 'Signet', '321 Signet Road', 'signet@example.com'),
('EDI005', 'Independently published', '654 Independent Street', 'independent@example.com');

INSERT INTO Categoria (ID, Nome, Descricao, Numero_de_livros, Numero_de_livros_vendidos) VALUES
('CAT001', 'Ficção Científica', 'Livros sobre viagens no tempo, universos alternativos, etc.', 20, 74),
('CAT002', 'Romance', 'Livros sobre histórias de amor e relacionamentos', 30, 10),
('CAT003', 'Fantasia', 'Livros sobre mundos imaginários, magia, etc.', 25, 12),
('CAT004', 'Suspense', 'Livros que criam tensão e mistério', 15, 15),
('CAT005', 'Autoajuda', 'Livros que oferecem conselhos e orientações para a vida', 10, 16);

INSERT INTO Avaliacao (ID, Nome, Data, Comentarios, Nota) VALUES
('AVL001', 'Senhor dos Aneis', '2024-04-25', 'Ótimo livro, recomendo!', 4.5),
('AVL002', 'Star Wars', '2024-04-20', 'Muito bom, adorei a trama!', 4.2),
('AVL003', 'Harry Potter', '2024-04-18', 'Minha magia favorita é Avada Kedavra', 4.8),
('AVL004', 'Jujutsu Kaisen', '2024-04-15', 'O Go/jo vai voltar', 4.9),
('AVL005', 'Haikyu', '2024-04-10', 'Melhor anime de Esportes', 4.7);

INSERT INTO Pedido (Numero, Data, status, Cartao, Dinheiro, Valor, Produto, fk_Usuario_CPF) VALUES
(1001, '2024-04-25', 'Entregue', '1234 5678 9012 3456', NULL, 50.00, 'Livro', '12345678901'),
(1002, '2024-04-20', 'Pendente', '9876 5432 1098 7654', NULL, 30.00, 'Acessório', '98765432109'),
(1003, '2024-04-18', 'Entregue', '2468 1357 9024 6813', NULL, 25.00, 'Eletrônico', '24681357902'),
(1004, '2024-04-15', 'Pendente', '1357 9246 8041 3579', NULL, 20.00, 'Roupa', '13579246804'),
(1005, '2024-04-10', 'Entregue', '3692 5814 7063 9258', NULL, 15.00, 'Brinquedo', '36925814706');

INSERT INTO Plano_Premium (desconto) VALUES
(0.15);

INSERT INTO Material_Escolar (Caderno, Bolsa, Codigo_Barra,Caderno_vendido, Bolsa_vendida, fk_Produto_ID) VALUES
(12.50, 20.00,'456545458',25 ,21 , 'PRO001'),
(15.00, 25.00,'12345678',12 ,45 ,'PRO002'),
(10.75, 18.50,'7418529',32 ,45 , 'PRO003'),
(18.20, 30.00,'85245695',56 ,89 ,'PRO004'),
(22.50, 35.50,'15975385',21 ,78 , 'PRO005');

INSERT INTO Jogos_Tabuleiro (Nome_Jogo, Codigo_Barra, fk_Produto_ID) VALUES 
('Jogo da Vida', '8590123456789', 'JOG001'),
('Monopoly', '7245632198745', 'JOG002'),
('Lince', '6359874123654', 'JOG003'),
('Banco Imobiliário', '8023659841523', 'JOG004'),
('War', '1478963258745', 'JOG005');

INSERT INTO Produto (ID, Nome,Numero_de_Vendas ) VALUES
('PRO001', 'Caderno Tempestade', 74),
('PRO002', 'Caderno Wolverine', 32 ),
('PRO003', 'Caderno Deadpool', 69),
('PRO004', 'Caderno Ciclope', 36),
('PRO005', 'Caderno Gambit', 22);

INSERT INTO escrito (fk_Livro_ISBN, fk_Livro_fk_Produto_ID) VALUES
('978-0142420591', 'LIV001'),
('978-0553212457', 'LIV002'),
('978-0486280615', 'LIV003'),
('978-0451524935', 'LIV004'),
('978-1983397910', 'LIV005');

INSERT INTO pertence (fk_Categoria_ID, fk_Livro_ISBN, fk_Livro_fk_Produto_ID) VALUES
('CAT001', '978-0142420591', 'LIV001'),
('CAT002', '978-0553212457', 'LIV002'),
('CAT003', '978-0486280615', 'LIV003'),
('CAT004', '978-0451524935', 'LIV004'),
('CAT005', '978-1983397910', 'LIV005');

INSERT INTO recebe (fk_Avaliacao_ID, fk_Livro_ISBN, fk_Livro_fk_Produto_ID) VALUES
('AVL001', '978-0142420591', 'LIV001'),
('AVL002', '978-0553212457', 'LIV002'),
('AVL003', '978-0486280615', 'LIV003'),
('AVL004', '978-0451524935', 'LIV004'),
('AVL005', '978-1983397910', 'LIV005');

INSERT INTO obtem (fk_Produto_ID) VALUES
('PRO001'),
('PRO002'),
('PRO003'),
('PRO004'),
('PRO005'); 

CREATE OR REPLACE FUNCTION atualizar_nota_media()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Livro
    SET Nota_Media = (
        SELECT AVG(Nota)
        FROM Avaliacao
        JOIN recebe ON Avaliacao.ID = recebe.fk_Avaliacao_ID
        WHERE recebe.fk_Livro_ISBN = NEW.fk_Livro_ISBN
        AND recebe.fk_Livro_fk_Produto_ID = NEW.fk_Livro_fk_Produto_ID
    )
    WHERE ISBN = NEW.fk_Livro_ISBN AND fk_Produto_ID = NEW.fk_Livro_fk_Produto_ID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_nota_media
AFTER INSERT OR UPDATE ON Avaliacao
FOR EACH ROW
EXECUTE FUNCTION atualizar_nota_media();

CREATE OR REPLACE FUNCTION atualizar_quantidade_estoque()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Livro
    SET Quant_Estoque = Quant_Estoque - 1
    WHERE fk_Produto_ID = NEW.fk_Produto_ID
    AND ISBN = (SELECT fk_Livro_ISBN FROM obtem WHERE fk_Produto_ID = NEW.fk_Produto_ID);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_quantidade_estoque
AFTER INSERT ON Pedido
FOR EACH ROW
EXECUTE FUNCTION atualizar_quantidade_estoque();

CREATE OR REPLACE FUNCTION atualizar_nota_media_livro(isbn_livro CHAR, produto_id CHAR) 
RETURNS VOID AS $$
BEGIN
    UPDATE Livro
    SET Nota_Media = (
        SELECT AVG(Nota)
        FROM Avaliacao
        JOIN recebe ON Avaliacao.ID = recebe.fk_Avaliacao_ID
        WHERE recebe.fk_Livro_ISBN = isbn_livro
        AND recebe.fk_Livro_fk_Produto_ID = produto_id
    )
    WHERE ISBN = isbn_livro AND fk_Produto_ID = produto_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE inserir_avaliacao(
    p_ID CHAR,
    p_Nome VARCHAR,
    p_Data DATE,
    p_Comentarios VARCHAR,
    p_Nota FLOAT,
    p_fk_Livro_ISBN CHAR,
    p_fk_Livro_fk_Produto_ID CHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Avaliacao (ID, Nome, Data, Comentarios, Nota)
    VALUES (p_ID, p_Nome, p_Data, p_Comentarios, p_Nota);

    INSERT INTO recebe (fk_Avaliacao_ID, fk_Livro_ISBN, fk_Livro_fk_Produto_ID)
    VALUES (p_ID, p_fk_Livro_ISBN, p_fk_Livro_fk_Produto_ID);

    PERFORM atualizar_nota_media_livro(p_fk_Livro_ISBN, p_fk_Livro_fk_Produto_ID);
END;
$$;

CALL inserir_avaliacao('AVL006', 'Novo Livro', '2024-05-01', 'Muito bom!', 4.7, '978-0142420591', 'LIV001'); -- Exemplo para stored procedure acima

CREATE OR REPLACE FUNCTION atualizar_quantidade_estoque(produto_id CHAR) 
RETURNS VOID AS $$
BEGIN
    UPDATE Livro
    SET Quant_Estoque = Quant_Estoque - 1
    WHERE fk_Produto_ID = produto_id
    AND ISBN = (SELECT fk_Livro_ISBN FROM obtem WHERE fk_Produto_ID = produto_id);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE inserir_pedido(
    p_Numero SMALLINT,
    p_Data DATE,
    p_Status VARCHAR,
    p_Cartao CHAR,
    p_Dinheiro CHAR,
    p_Valor FLOAT,
    p_Produto VARCHAR,
    p_fk_Usuario_CPF CHAR,
    p_fk_Produto_ID CHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Pedido (Numero, Data, Status, Cartao, Dinheiro, Valor, Produto, fk_Usuario_CPF)
    VALUES (p_Numero, p_Data, p_Status, p_Cartao, p_Dinheiro, p_Valor, p_Produto, p_fk_Usuario_CPF);

    INSERT INTO obtem (fk_Produto_ID, fk_Pedido_Numero)
    VALUES (p_fk_Produto_ID, p_Numero);

    PERFORM atualizar_quantidade_estoque(p_fk_Produto_ID);
END;
$$;

CALL inserir_pedido(1006, '2024-05-01', 'Pendente', '1234 5678 9012 3456', NULL, 45.00, 'Livro', '12345678901', 'PRO001'); -- Exemplo pro stored procedure acima

SELECT * FROM Jogos_Tabuleiro;

SELECT * FROM Ebook;

SELECT * FROM AudioBook; 

CREATE OR REPLACE FUNCTION atualizar_estoque()
RETURNS TRIGGER AS $$
DECLARE
    prev_vendas INT;
BEGIN
    SELECT "N_de_Vendas" INTO prev_vendas FROM livro WHERE isbn = NEW.isbn;
    
    IF NEW."N_de_Vendas" > prev_vendas THEN
        UPDATE livro 
        SET quant_estoque = quant_estoque - (NEW."N_de_Vendas" - prev_vendas)
        WHERE isbn = NEW.isbn;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_atualizar_estoque
AFTER UPDATE OF "N_de_Vendas" ON livro
FOR EACH ROW
EXECUTE FUNCTION atualizar_estoque();

CREATE VIEW livro_resumo AS
SELECT
  isbn,
  quant_estoque,
  "N_de_Vendas"
FROM livro;


CREATE VIEW autor_vendas_recomendacao AS
SELECT
  numero_de_vendas,
  Recomendação
FROM autor;

CREATE ROLE usuario_comum_aluno LOGIN PASSWORD 'senha_usuario_comum' NOSUPERUSER NOCREATEDB NOCREATEROLE;

GRANT USAGE ON SCHEMA public TO usuario_comum_aluno;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE aluno TO usuario_comum_aluno;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, UPDATE, DELETE ON TABLE aluno TO usuario_comum_aluno;

ALTER DEFAULT PRIVILEGES FOR ROLE usuario_comum_aluno IN SCHEMA public
  GRANT SELECT, UPDATE, DELETE ON TABLE aluno TO usuario_comum_aluno;

CREATE ROLE professor_admin LOGIN PASSWORD 'senha_professor_admin' SUPERUSER CREATEDB CREATEROLE;

GRANT USAGE ON SCHEMA public TO professor_admin;
GRANT ALL PRIVILEGES ON TABLE professor TO professor_admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLE professor TO professor_admin;
ALTER DEFAULT PRIVILEGES FOR ROLE professor_admin IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLE professor TO professor_admin;
