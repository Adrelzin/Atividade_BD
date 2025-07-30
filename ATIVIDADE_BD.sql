CREATE DATABASE IF NOT EXISTS ATIVIDADE_BD;
USE ATIVIDADE_BD;

#1
CREATE TABLE IF NOT EXISTS usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) UNIQUE NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	senha VARCHAR(255) NOT NULL,
	senha_original VARCHAR(255)
);

#2
CREATE TABLE IF NOT EXISTS noticias (
	id INT AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(200) NOT NULL,
	conteudo TEXT NOT NULL,
	data_publicacao DATETIME,
	autor VARCHAR(100)
);

#3
CREATE TABLE IF NOT EXISTS plantas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	descricao TEXT,
	data_plantio DATE,
	observacoes TEXT,
	usuario_id INT NOT NULL,
	data_criacao DATETIME,
	imagem VARCHAR(255),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

#4
CREATE TABLE IF NOT EXISTS eventos_calendario (
	id INT AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	descricao TEXT,
	data_inicio DATETIME NOT NULL,
	data_fim DATETIME,
	cor VARCHAR(7) DEFAULT '#28a745',
	usuario_id INT NOT NULL,
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

#5
CREATE TABLE IF NOT EXISTS produtos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	categoria VARCHAR(100) NOT NULL,
	descricao TEXT,
	imagem VARCHAR(255),
	estoque INT DEFAULT 0,
	ativo BOOLEAN DEFAULT TRUE,
	data_criacao DATETIME
);

#6
CREATE TABLE IF NOT EXISTS pedidos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT NOT NULL,
	total DECIMAL(10,2) NOT NULL,
	status VARCHAR(50) DEFAULT 'pendente',
	data_pedido DATETIME,
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

#7
CREATE TABLE IF NOT EXISTS itens_pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
	pedido_id INT NOT NULL,
	produto_id INT NOT NULL,
	quantidade INT NOT NULL,
	preco_unitario DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
	FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

#8
CREATE TABLE IF NOT EXISTS enderecos_usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT NOT NULL,
	logradouro VARCHAR(255) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estado VARCHAR(50) NOT NULL,
	cep VARCHAR(15) NOT NULL,
	complemento VARCHAR(100),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

#9
CREATE TABLE IF NOT EXISTS categorias_plantas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL UNIQUE,
	descricao TEXT,
	cor_identificacao VARCHAR(7) DEFAULT '#4CAF50',
	icone VARCHAR(50),
	data_criacao DATETIME
);

#10
CREATE TABLE IF NOT EXISTS favoritos_usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT NOT NULL,
	produto_id INT NOT NULL,
	data_adicionado DATETIME,
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
	FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE,
	UNIQUE KEY unique_user_product_favorite (usuario_id, produto_id)
);
