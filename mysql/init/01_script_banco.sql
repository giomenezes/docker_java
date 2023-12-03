DROP DATABASE IF EXISTS gct_individual;
CREATE DATABASE IF NOT EXISTS `gct_individual` DEFAULT CHARACTER SET utf8 ;
USE `gct_individual`;


CREATE TABLE IF NOT EXISTS `empresa` (
  `id_empresa` INT NOT NULL auto_increment,
  `razao_social` VARCHAR(120) NULL,
  `cnpj` CHAR(18) NULL,
  `numero_imovel` INT NULL,
  `cep` CHAR(9) NULL,
  `email` VARCHAR(150) NULL,
  `telefone` VARCHAR(13) NULL,
  `complemento` VARCHAR(450) NULL,
  PRIMARY KEY (`id_empresa`)
);

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT NOT NULL primary key auto_increment,
  `nome` VARCHAR(120) NULL,
  `email` VARCHAR(150) NULL,
  `senha` VARCHAR(150) NULL,
  `cargo` VARCHAR(90) NULL,
  `cpf` CHAR(14) NULL,
  `permissao` INT NOT NULL,
  `fk_gerente` INT,
  `fk_empresa` INT NOT NULL,
  FOREIGN KEY (`fk_gerente`) REFERENCES funcionario(`id_funcionario`) ON DELETE CASCADE,
  FOREIGN KEY (`fk_empresa`) REFERENCES empresa(`id_empresa`) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `servidor` (
  `id_servidor` INT NOT NULL auto_increment,
  `nome` VARCHAR(60) NULL,
  `codigo` VARCHAR(50) NULL,
  `tipo` VARCHAR(100) NULL,
  `descricao` VARCHAR(200) NULL,
  `status` TINYINT NULL,
  `fk_empresa` INT NOT NULL,
  `prioridade` INT NULL,
  `localizacao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_servidor`),
  FOREIGN KEY (`fk_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE
);

-- Cadastro de Empresas
INSERT INTO `empresa` (`razao_social`, `cnpj`, `numero_imovel`, `cep`, `email`, `telefone`) 
VALUES ('Pague Seguro',"61.186.888/0093-01", 763, '09260-640', 'pagueSeguro@gmail.com', '123123123')
	, ('SPTECH', "61.186.888/0093-01", 298,'09260-640', 'sptech@gmail.com', '456456456')
	, ('Amazon', "61.186.888/0093-01", 234,'09260-640', 'amazon@gmail.com', '889877677');
Select * from `empresa`;


-- Cadastro de Gerentes
INSERT INTO `funcionario` (`nome`, `email`, `senha`, `cargo`, `cpf`, `permissao`, `fk_gerente`, `fk_empresa`)
VALUES ('Gabriel', 'gabriel@gmail.com', '12345', 'Gerente', '690.969.360-43', '1', null, 1)
	, ('Fernando Brandão', 'fernado@gmail.com', '12345', 'Presidente', '226.146.010-47', '1', null, 2)
    , ('Cláudio', 'claudio@gmail.com', '12345', 'Gerente', '810.791.190-35', '1', null, 3);


-- Cadastro de Funcionários
INSERT INTO `funcionario` (`nome`, `email`, `senha`, `cargo`, `cpf`, `permissao`, `fk_gerente`, `fk_empresa`)
values ('Cleiton Rodrigues', 'cleiton@gmail.com', '12345', 'Analísta Junior', "514.184.580-07", '2', 1, 1)
	, ('Carlos Souza', 'carlos@gmail.com', '12345', 'Analísta Sênior', "541.886.660-56", '1', 2, 2)
    , ('Pedro Henrique', 'pedro@gmail.com', '12345', 'Analísta Sênior', "091.045.750-67", '1', 3, 3);

SELECT * FROM `funcionario`;

-- Cadastro de Servidores 
INSERT INTO `servidor` (`nome`, `codigo`, `tipo`,`status`, `descricao`, `fk_empresa`, `localizacao`)
VALUES ('SERVER-AHRL1NB', 'XPTO-0987', 'Servidor Principal',1, 'Servidor responsável por executar X tarefa', 1, 'Sede empresa 012 - Port 3')
	, ('SERVER-9HJD2AL', 'XP-9384', 'Servidor de Backup',1, 'Servidor responsável por backups', 1, 'Sede empresa 234 - Comp A')
    , ('SERVER-UHD71P6', 'LOC-0284', 'Servidor de Homologação',1, 'Servidor responsável por Homologações ', 1, 'Sede empresa 102 - Port 1');

UPDATE servidor set `status` = 0 WHERE id_servidor in(2);

CREATE TABLE IF NOT EXISTS `processo` (
	id INT PRIMARY KEY AUTO_INCREMENT,
	pid INT,
    nome VARCHAR(200),
    uso_cpu DOUBLE,
    uso_memoria DOUBLE, 
    bytes_utilizados DOUBLE,
    swap_utilizada DOUBLE,
    data_registro DATETIME,
    fk_servidor INT NOT NULL,
    FOREIGN KEY (`fk_servidor`) REFERENCES servidor(`id_servidor`) ON DELETE CASCADE
);

CREATE OR REPLACE VIEW `vw_processos_consumidores` AS
 SELECT * FROM processo 
 WHERE uso_cpu > 20 
 ORDER BY uso_cpu;

