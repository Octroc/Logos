CREATE DATABASE logos;

USE logos;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    tipo ENUM('aluno', 'professor', 'admin') DEFAULT 'aluno',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE simulados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    criado_por INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE questoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    simulado_id INT,
    enunciado TEXT NOT NULL,
    alternativa_a VARCHAR(255) NOT NULL,
    alternativa_b VARCHAR(255) NOT NULL,
    alternativa_c VARCHAR(255) NOT NULL,
    alternativa_d VARCHAR(255) NOT NULL,
    alternativa_correta CHAR(1) NOT NULL,
    FOREIGN KEY (simulado_id) REFERENCES simulados(id) ON DELETE CASCADE
);

CREATE TABLE resumos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    conteudo TEXT NOT NULL,
    criado_por INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE exercicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    enunciado TEXT NOT NULL,
    resposta TEXT NOT NULL,
    criado_por INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE resultados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    simulado_id INT,
    acertos INT NOT NULL,
    total_questoes INT NOT NULL,
    data_realizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (simulado_id) REFERENCES simulados(id) ON DELETE CASCADE
);

CREATE TABLE livros_didaticos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    descricao TEXT,
    ano_publicacao YEAR,
    disciplina VARCHAR(100),
    arquivo_url VARCHAR(500),  -- Link para download ou visualização do livro,
    FOREIGN KEY (criado_por) REFERENCES usuarios(id) ON DELETE SET NULL
);
