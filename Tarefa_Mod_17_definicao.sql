/* 
Criando o banco de dados pigma
*/

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS bd_pigma;

-- Usar o banco de dados por padrão
USE bd_pigma;

-- Criação das tabelas
CREATE TABLE IF NOT EXISTS clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255),
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    municipio VARCHAR(255),
    uf VARCHAR(2),
    nome_responsavel VARCHAR(255),
    email_responsavel VARCHAR(255),
    telefone_responsavel VARCHAR(11),
    data_contratacao DATE,
    integracao VARCHAR(255),
    ativo BOOL
)
COMMENT "Tabela que armazena os dados das empresas contratantes";


CREATE TABLE IF NOT EXISTS secadores (
	id_secador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    marca VARCHAR(255),
    modelo VARCHAR(255),
    data_fabricacao DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
)
COMMENT "Tabela que armazena os dados do secador ao qual o equipamento foi acoplado";


CREATE TABLE IF NOT EXISTS equipamentos (
	id_equipam INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(255),
    data_instalacao DATE,
    id_secador INT,
    ativo BOOL,
    FOREIGN KEY (id_secador) REFERENCES secadores(id_secador)
)
COMMENT "Tabela que armazena os dados dos equipamentos fabricados";


CREATE TABLE IF NOT EXISTS locais_leitura (
	id_local INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    tipo_local VARCHAR(255),
    latitude VARCHAR(255),
    longitude VARCHAR(255),
    municipio VARCHAR(255),
    uf VARCHAR(2),
    ativo BOOL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
)
COMMENT "Tabela que armazena a localização na qual cada equipamento está acoplado";


CREATE TABLE IF NOT EXISTS leitura_dados (
	id_leitura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_local INT,
    id_equipam INT,
    data_leitura DATE,
    hora_leitura TIME,
    temp_entrada_ar_quente DECIMAL(10,2),
    umidade_graos DECIMAL(10,2),
    temp_amb_graos DECIMAL(10,2),
    temp_amb_externa DECIMAL(10,2),
    umidade_amb_externa DECIMAL(10,2),
    rpm_extrator_de_graos INT,
    temp_saida_ar_quente DECIMAL(10,2),
    FOREIGN KEY (id_local) REFERENCES locais_leitura(id_local),
    FOREIGN KEY (id_equipam) REFERENCES equipamentos(id_equipam)
)
COMMENT "Tabela que armazena os dados de leitura capturados pelos equipamentos acoplados aos secadores";


/*
Adicionando dados ao banco bd_pigma
gerado com dados fictícios
*/

-- Definir database como padrão 
USE bd_pigma;

-- Inserir dados na tabela clientes
INSERT INTO bd_pigma.clientes (id_cliente, razao_social, cnpj, endereco, municipio, uf, nome_responsavel, email_responsavel, telefone_responsavel, data_contratacao, integracao, ativo)
	VALUES  (default, "Cooperativa dos Amigos", 20308458000101, "Av. Brasil, 4040, Centro", "Toledo", "PR", "João Mello", "joao.mello@coopamigos.com.br", 45998887766, "2022-03-05", "BRF", 1),
			(default, "Cooperativa Irmãos", 55863958000101, "Av. Paraná, 6523, Industrial", "Cascavel", "PR", "Maria Silva", "maria.silva@coopirmaos.com.br", 45985635253, "2022-08-10", "Seara", 1),
            (default, "Cooperativa da Soja", 15463987000101, "Av. Toledo, 153, Jardim", "Assis Chateaubriand", "PR", "José Jozue", "jose.jozue@coopsoja.com.br", 45988631523, "2022-06-12", "CVale", 1);
            
-- Inserir dados na tabela secadores
INSERT INTO bd_pigma.secadores (id_secador, id_cliente, marca, modelo, data_fabricacao)
	VALUES  (default, 1, "Ylong", "YLSH", "2020-03-01"),
			(default, 1, "Ylong", "YLSH", "2020-10-01"),
            (default, 2, "Satake", "NSDR30", "2019-02-01"),
            (default, 2, "Satake", "NSDR30", "2018-10-01"),
			(default, 3, "MySilo", "AI", "2021-08-10"),
            (default, 3, "MySilo", "AI", "2021-06-15");

-- Inserir dados na tabela equipamentos
INSERT INTO bd_pigma.equipamentos (id_equipam, modelo, data_instalacao, id_secador, ativo)
	VALUES  (default, "A23", "2023-03-01", 1, 1),
			(default, "A23", "2023-03-02", 2, 1),
            (default, "A23", "2023-03-15", 3, 1),
            (default, "A23", "2023-03-16", 4, 1),
			(default, "A23", "2023-03-22", 5, 1),
            (default, "A23", "2023-03-23", 6, 1),
            (default, "A23", NULL, NULL, 0);

-- Inserir dados na tabela locais_leitura
INSERT INTO bd_pigma.locais_leitura (id_local, id_cliente, tipo_local, latitude, longitude, municipio, uf, ativo)
	VALUES  (default, 1, "Matriz", "-25.9925050", "-52.5796860", "Toledo", "PR", 0),
			(default, 1, "Filial", "-24.8589030", "-53.0138216", "Toledo", "PR", 1),
            (default, 2, "Matriz", "-24.8736518", "-53.0598591", "Cascavel", "PR", 1),
            (default, 2, "Matriz", "-25.3594148", "-52.580362", "Assis Chateaubriand", "PR", 1);
            
-- Inserir dados na tabela leitura_dados
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-03-28", "09:17:50", 62.75, 16.7, 25, 27.2, 71.9, 42.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-03-28", "09:18:00", 62.75, 16.7, 26.25, 27.2, 71.9, 42.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-03-28", "09:18:10", 62.5, 16.7, 25.75, 27.2, 71.5, 42.0, 33.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-03-28", "09:18:20", 62.5, 16.7, 25.76, 27.2, 71.4, 42.0, 33.75);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-03-28", "09:18:30", 62.5, 16.7, 25.25, 27.2, 71.5, 42.0, 33.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-03-28", "09:18:40", 62.5, 16.7, 24.5, 27.1, 71.4, 42.0, 33.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-03-29", "09:18:50", 62.75, 16.7, 24.6, 27.1, 71.4, 42.0, 68.3);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-03-29", "09:19:00", 62.75, 16.7, 25.24, 27.2, 71.7, 42.0, 32.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-03-29", "09:19:10", 62.5, 16.7, 25.25, 26.9, 71.9, 42.0, 32.75);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-03-29", "09:19:20", 62.25, 16.7, 25.26, 26.3, 71.10, 42.0, 32.76);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-03-29", "09:19:30", 62.5, 16.7, 24.5, 26.4, 72.1, 42.0, 32.77);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-03-29", "09:19:40", 62.75, 16.7, 24.6, 26.5, 72.2, 42.0, 32.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-03-30", "09:19:50", 62.75, 16.7, 24.5, 26.6, 71.9, 42.0, 32.75);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-03-30", "09:20:00", 62.5, 16.7, 24.25, 26.7, 71.10, 42.0, 57.6);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-03-30", "09:20:10", 62.5, 16.7, 24.25, 26.8, 72.3, 42.0, 32.75);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-03-30", "09:20:20", 62.5, 16.7, 24.75, 26.9, 72.6, 42.0, 32.76);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-03-30", "09:20:30", 62.75, 16.7, 24.25, 26.9, 72.2, 42.0, 32.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-03-30", "09:20:40", 62.75, 16.7, 24.75, 26.9, 72.3, 42.0, 32.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-03-31", "09:20:50", 62.75, 16.7, 24.5, 26.9, 72.2, 42.0, 84.3);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-03-31", "09:21:00", 63.0, 16.7, 24.6, 26.9, 72.3, 42.0, 32.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-03-31", "09:21:10", 47.5, 15.2, 31.5, 28.5, 65.6, 20.0, 35.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-03-31", "09:21:20", 47.5, 15.2, 31.5, 28.5, 65.2, 20.0, 35.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-03-31", "09:21:30", 47.5, 15.2, 31.6, 28.5, 65.3, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-03-31", "09:21:40", 47.75, 15.2, 31.75, 28.4, 65.2, 20.0, 49.2);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-04-01", "09:21:50", 47.5, 15.2, 31.75, 28.4, 65.4, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-04-01", "09:22:00", 47.5, 15.2, 31.25, 28.4, 65.6, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-04-01", "09:22:10", 48.0, 15.2, 31.26, 28.2, 65.6, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-04-01", "09:22:20", 48.5, 15.2, 31.25, 28.2, 65.8, 20.0, 34.26);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-04-01", "09:22:30", 48.75, 15.2, 31.25, 28.2, 65.9, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-04-01", "09:22:40", 50.25, 15.2, 30.75, 28.2, 65.9, 20.0, 76.2);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-04-02", "09:22:50", 50.5, 15.2, 31.25, 28.2, 65.7, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-04-02", "09:23:00", 51.5, 15.2, 31.25, 28.1, 65.6, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-04-02", "09:23:10", 52.25, 15.2, 30.75, 28.1, 65.8, 20.0, 34.26);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-04-02", "09:23:20", 53.25, 15.2, 31.5, 28.0, 65.9, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-04-02", "09:23:30", 53.75, 15.2, 31.6, 28.0, 67.1, 20.0, 63.2);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-04-02", "09:23:40", 54.5, 15.2, 31.5, 28.1, 67.2, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-04-03", "09:23:50", 55.5, 15.2, 31.75, 28.1, 66.8, 20.0, 34.25);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-04-03", "09:24:00", 56.5, 15.2, 31.25, 28.1, 66.7, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-04-03", "09:24:10", 56.5, 15.2, 31.25, 28.1, 66.6, 20.0, 86.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-04-03", "09:24:20", 57.75, 15.2, 31.5, 28.1, 66.7, 20.0, 96.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-04-03", "09:24:30", 58.25, 15.2, 30.75, 28.1, 66.5, 20.0, 34.75);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-04-03", "09:24:40", 58.75, 15.2, 30.76, 28.1, 66.6, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 1, "2023-04-04", "09:24:50", 59.25, 15.2, 30.77, 28.0, 65.9, 20.0, 64.1);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 2, 2, "2023-04-04", "09:25:00", 59.75, 15.2, 30.5, 28.0, 66.2, 20.0, 64.2);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 3, "2023-04-04", "09:25:10", 59.75, 15.2, 30.25, 28.0, 66.5, 20.0, 34.5);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 3, 4, "2023-04-04", "09:25:20", 59.75, 15.2, 30.5, 28.0, 66.5, 20.0, 59.6);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 5, "2023-04-04", "09:25:30", 60.75, 15.2, 30.75, 28.0, 66.5, 20.0, 59.7);
INSERT INTO bd_pigma.leitura_dados VALUES (default, 4, 6, "2023-04-04", "09:25:40", 60.75, 15.2, 30.76, 28.0, 66.5, 20.0, 35.25);


