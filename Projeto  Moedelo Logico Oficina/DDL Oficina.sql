-- Criando banco de dados Oficina
DROP DATABASE Oficina;
CREATE DATABASE Oficina;
USE Oficina;

-- Criando tabela cliente
CREATE TABLE cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Pnome VARCHAR(10)NOT NULL,
    Sobrenome VARCHAR(10)NOT NULL,
    endereco VARCHAR(255),
    CNH CHAR(11) NOT NULL,
    CONSTRAINT unique_cnh_cliente UNIQUE(CNH)
);

ALTER TABLE cliente AUTO_INCREMENT=1;

-- Criando tabela veiculo
CREATE TABLE veiculo(
	idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(15),
    tipoDeVeiculo ENUM('carro','moto') NOT NULL,
    modeloCarro ENUM('Ret','Sedam','SUV'),
    modeloMoto ENUM('CG','CB','50c'),
    nPlaca CHAR(7) NOT NULL,
    CONSTRAINT unique_placa_veiculo UNIQUE(nPlaca)
);

ALTER TABLE veiculo AUTO_INCREMENT=1;

-- Criando tabela OrdemServico
CREATE TABLE ordemServico(
	idServico INT AUTO_INCREMENT PRIMARY KEY,
    Serv_Status ENUM('Aprovado','Cancelado','Em analise','Executado','Finalizado') NOT NULL DEFAULT 'Em analise',
    dataEmissao DATE NOT NULL,
    dataConclusao DATE,
    Quantidade INT DEFAULT 1
);

ALTER TABLE ordemServico AUTO_INCREMENT=1;

-- Criando tabela mecanico
CREATE TABLE mecanico(
	idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    idMServico INT,
    Pnome VARCHAR(10)NOT NULL,
    Sobrenome VARCHAR(10)NOT NULL,
	CPF CHAR(11),
    especialidade ENUM('carros', 'estética automotiva', 'motocicletas') NOT NULL,
    CONSTRAINT unique_cpf_mecanico UNIQUE (CPF),
    CONSTRAINT fk_servico_mecanico FOREIGN KEY(idMServico) REFERENCES mecanico(idMecanico)
    ON UPDATE CASCADE
);

ALTER TABLE mecanico  AUTO_INCREMENT=1;

-- Criando tabela peca
CREATE TABLE peca(
	idPeca INT AUTO_INCREMENT NOT NULL,
    idPveiculo INT,
    Pnome VARCHAR(40) NOT NULL,
    PRIMARY KEY(idPeca, idPveiculo),
    CONSTRAINT fk_peca_veiculo FOREIGN KEY(idPveiculo) REFERENCES veiculo(idVeiculo)
    ON UPDATE CASCADE
);

ALTER TABLE peca AUTO_INCREMENT=1;

-- Criando tabela de Relacionamento
CREATE TABLE pecaServico(
	idPSpeca INT, 
    idPSservico INT,
    valor FLOAT NOT NULL,
    PRIMARY KEY(idPSpeca, idPSservico),
    CONSTRAINT fk_peca_peca FOREIGN KEY (idPSpeca) REFERENCES peca(idPeca),
    CONSTRAINT fk_peca_servico FOREIGN KEY (idPSservico) REFERENCES ordemServico(idServico)
    ON UPDATE CASCADE
);


CREATE TABLE clienteVeiculo(
	idCVcliente INT, 
    idCVveiculo INT,
    renavam CHAR(11) NOT NULL,
    PRIMARY KEY(idCVcliente, idCVveiculo),
    CONSTRAINT fk_cliente_cliente FOREIGN KEY (idCVcliente) REFERENCES cliente(idCliente),
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCVveiculo) REFERENCES veiculo(idVeiculo)
    ON UPDATE CASCADE
);


