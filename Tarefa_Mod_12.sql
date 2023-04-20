/* 
Criando o banco de dados pigma
*/

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS pigma;

-- Usar o banco de dados por padrão
USE pigma;

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
    data_instalacao DATE,
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
    temp_entrada_ar_quente DECIMAL(2),
    umidade_graos DECIMAL(2),
    temp_amb_graos DECIMAL(2),
    temp_amb_externa DECIMAL(2),
    umidade_amb_externa DECIMAL(2),
    rpm_extrator_de_graos INT,
    temp_saida_ar_quente DECIMAL(2),
    status_incendio BOOL,
    FOREIGN KEY (id_local) REFERENCES locais_leitura(id_local),
    FOREIGN KEY (id_equipam) REFERENCES equipamentos(id_equipam)
)
COMMENT "Tabela que armazena os dados de leitura capturados pelos equipamentos acoplados aos secadores";
