CREATE DATABASE ScriptGCT;
USE ScriptGCT;

CREATE TABLE empresa (
    id_empresa INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    razao_social VARCHAR(120) NULL,
    cnpj CHAR(18) NULL,
    numero_imovel INT NULL,
    cep CHAR(9) NULL,
    email VARCHAR(150) NULL,
    telefone VARCHAR(13) NULL,
    complemento VARCHAR(450) NULL
);

CREATE TABLE funcionario (
    id_funcionario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nome VARCHAR(120) NULL,
    email VARCHAR(150) NULL,
    senha VARCHAR(150) NULL,
    cargo VARCHAR(90) NULL,
    cpf CHAR(14) NULL,
    permissao INT NOT NULL,
    fk_gerente INT,
    fk_empresa INT NOT NULL,
    FOREIGN KEY (fk_gerente) REFERENCES funcionario(id_funcionario) ON DELETE CASCADE,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE
);

CREATE TABLE servidor (
    id_servidor INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nome VARCHAR(60) NULL,
    codigo VARCHAR(50) NULL,
    tipo VARCHAR(100) NULL,
    descricao VARCHAR(200) NULL,
    status TINYINT NULL,
    fk_empresa INT NOT NULL,
    prioridade INT NULL,
    localizacao VARCHAR(200) NOT NULL,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE
);

CREATE TABLE unidade_medida (
    id_unidade_medida INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    sigla CHAR(5) NULL
);

CREATE TABLE modelo_componente (
    id_modelo_componente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    modelo VARCHAR(50) NULL,
    fabricante VARCHAR(60) NULL
);

CREATE TABLE componente (
    id_componente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    tipo_componente VARCHAR(60) NULL,
    fk_modelo_componente INT NOT NULL,
    fk_servidor INT NOT NULL,
    FOREIGN KEY (fk_modelo_componente) REFERENCES modelo_componente(id_modelo_componente) ON DELETE CASCADE,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor) ON DELETE CASCADE
);

CREATE TABLE chamados (
    id_chamados INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    titulo VARCHAR(60) NULL,
    descricao VARCHAR(200) NULL,
    data_hora DATETIME NULL,
    status VARCHAR(30) NULL,
    link VARCHAR(200),
    fk_componente INT NOT NULL,
    fk_empresa INT NOT NULL,
    FOREIGN KEY (fk_componente) REFERENCES componente(id_componente) ON DELETE CASCADE,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE
);

CREATE TABLE registro (
    id_registro INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    valor_registro FLOAT NULL,
    data_registro DATETIME NULL,
    fk_componente INT NOT NULL,
    fk_medida INT NOT NULL,
    FOREIGN KEY (fk_componente) REFERENCES componente(id_componente) ON DELETE CASCADE,
    FOREIGN KEY (fk_medida) REFERENCES unidade_medida(id_unidade_medida) ON DELETE CASCADE
);

CREATE TABLE anomalia (
    id_anomalia INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    solucao VARCHAR(450),
    fk_chamados INT NOT NULL,
    FOREIGN KEY (fk_chamados) REFERENCES chamados(id_chamados) ON DELETE CASCADE
);

-- Cadastro de Empresas
INSERT INTO empresa (razao_social, cnpj, numero_imovel, cep, email, telefone) 
VALUES 
('Pague Seguro',"61.186.888/0093-01", 763, '09260-640', 'pagueSeguro@gmail.com', '123123123'),
('SPTECH', "61.186.888/0093-01", 298,'09260-640', 'sptech@gmail.com', '456456456'),
('Amazon', "61.186.888/0093-01", 234,'09260-640', 'amazon@gmail.com', '889877677');

-- Cadastro de Gerentes
INSERT INTO funcionario (nome, email, senha, cargo, cpf, permissao, fk_gerente, fk_empresa)
VALUES 
('Gabriel', 'gabriel@gmail.com', '12345', 'Gerente', '690.969.360-43', 1, null, 1),
('Fernando Brandão', 'fernado@gmail.com', '12345', 'Presidente', '226.146.010-47', 1, null, 2),
('Cláudio', 'claudio@gmail.com', '12345', 'Gerente', '810.791.190-35', 1, null, 3);

-- Cadastro de Funcionários
INSERT INTO funcionario (nome, email, senha, cargo, cpf, permissao, fk_gerente, fk_empresa)
VALUES 
('Cleiton Rodrigues', 'cleiton@gmail.com', '12345', 'Analísta Junior', '514.184.580-07', 2, 1, 1),
('Carlos Souza', 'carlos@gmail.com', '12345', 'Analísta Sênior', '541.886.660-56', 1, 2, 2),
('Pedro Henrique', 'pedro@gmail.com', '12345', 'Analísta Sênior', '091.045.750-67', 1, 3, 3);

-- Cadastro de Servidores 
INSERT INTO servidor (nome, codigo, tipo, status, descricao, fk_empresa, localizacao)
VALUES 
('SERVER-AHRL1NB', 'XPTO-0987', 'Servidor Principal',1, 'Servidor responsável por executar X tarefa', 1, 'Sede empresa 012 - Port 3'),
('SERVER-9HJD2AL', 'XP-9384', 'Servidor de Backup',1, 'Servidor responsável por backups', 1, 'Sede empresa 234 - Comp A'),
('SERVER-UHD71P6', 'LOC-0284', 'Servidor de Homologação',1, 'Servidor responsável por Homologações ', 1, 'Sede empresa 102 - Port 1');

UPDATE servidor SET status = 0 WHERE id_servidor = 2;

-- Cadastro de Modelo de Componentes
INSERT INTO modelo_componente (modelo, fabricante)
VALUES
('Intel Core i7 13700K', 'Intel'),
('AMD Ryzen 7 7800X', 'AMD'),
('Apple M1 Max', 'Apple'),
('DDR4 3200MHz 16GB', 'Corsair'),
('DDR5 4800MHz 32GB', 'G.Skill'),
('LPDDR5 6400MHz 64GB', 'Samsung'),
('Samsung 980 Pro 1TB', 'Samsung'),
('WD Black SN850 2TB', 'Western Digital'),
('Seagate FireCuda 530 4TB', 'Seagate');

-- Cadastro de Componentes
INSERT INTO componente (tipo_componente, fk_modelo_componente, fk_servidor) 
VALUES 
('CPU', 1, 1),
('RAM', 5, 1),
('Disco', 8, 1),
('CPU', 1, 2),
('RAM',5, 2),
('Disco', 8, 2);

INSERT INTO unidade_medida (sigla) VALUES
('%'),
('GB'),
('GHz'),
('s'),
('UN');

-- Chamados
INSERT INTO chamados (titulo, descricao, data_hora, status, fk_componente, fk_empresa) 
VALUES
("Alerta uso da CPU", "Uso da CPU está em 90%", '2023-09-09T14:00:00', 'Aberto', 1, 1),
("Alerta uso da RAM", "Uso da RAM está em 80%", '2023-09-09T14:00:00', 'Aberto', 2, 1),
("Alerta uso da CPU", "Uso da CPU está em 90%", '2023-09-09T14:00:00', 'Aberto', 4, 1),
("Alerta uso da RAM", "Uso da RAM está em 80%", '2023-09-09T14:00:00', 'Aberto', 5, 1),
("Alerta uso da CPU", "Uso da CPU está em 90%", '2023-10-09T14:05:32', 'Aberto', 1, 1),
("Alerta uso da RAM", "Uso da RAM está em 80%", '2023-10-09T14:05:32', 'Aberto', 2, 1),
("Alerta uso da Disco", "Uso da Disco está em 75%", '2023-10-09T14:05:32', 'Aberto', 3, 1),
("Alerta uso da CPU", "Uso da CPU está em 90%", '2023-10-09T14:05:32', 'Aberto', 4, 1),
("Alerta uso da RAM", "Uso da RAM está em 80%", '2023-10-09T14:05:32', 'Aberto', 5, 1);

CREATE VIEW vw_registro_geral AS 
SELECT 
    registro.data_registro,
    registro.valor_registro,
    unidade_medida.sigla,
    componente.tipo_componente,
    componente.fk_servidor
    
FROM registro
    INNER JOIN unidade_medida ON 
        registro.fk_medida = unidade_medida.id_unidade_medida
    INNER JOIN componente ON
        registro.fk_componente = componente.id_componente;

CREATE VIEW vw_registro_RAM AS 
SELECT * FROM vw_registro_geral 
  WHERE tipo_componente LIKE 'RAM';

CREATE VIEW vw_registro_CPU AS 
SELECT * FROM vw_registro_geral 
  WHERE tipo_componente LIKE 'CPU';

CREATE VIEW vw_registro_Disco AS 
SELECT * FROM vw_registro_geral 
  WHERE tipo_componente LIKE 'Disco';

CREATE VIEW vw_registro_componente AS
SELECT registro.*, tipo_componente
        FROM registro, componente;

CREATE TABLE processo (
    id INT PRIMARY KEY IDENTITY(1,1),
    pid INT,
    nome VARCHAR(200),
    uso_cpu FLOAT,
    uso_memoria FLOAT, 
    bytes_utilizados FLOAT,
    swap_utilizada FLOAT,
    data_registro DATETIME,
    fk_servidor INT NOT NULL,
    FOREIGN KEY (fk_servidor) REFERENCES servidor(id_servidor) ON DELETE CASCADE
);

DROP VIEW vw_processos_consumidores;

CREATE VIEW vw_processos_consumidores AS
SELECT * FROM processo 
 WHERE uso_cpu > 20 ORDER BY uso_cpu;
