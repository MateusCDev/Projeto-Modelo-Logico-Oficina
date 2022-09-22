USE Oficina;

SHOW TABLES;

INSERT INTO cliente(Pnome, Sobrenome, endereco, CNH)
			VALUES('Mateus','Cesar','Rua: A Conjunto Stanta Cruz 12, BR-BA/Candeias','30146087717'),
				  ('Duda','Araujo','Rua: A Conjunto Stanta Cruz 12, BR-BA/Candeias','87269016401'),
                  ('Tereza','jesus','Rua: B Conjunto Stanta Cruz 14, BR-BA/Candeias','73663197382');

SELECT * FROM cliente;     

INSERT INTO veiculo(marca, tipoDeVeiculo, modeloCarro, modeloMoto, nPlaca)
			VALUES('Honda', 'carro', 'SUV', null, 'CXW7597'),
				  ('Yamaha', 'moto', null, 'CG', 'LWG5802'),
                  ('Ford', 'carro', 'Sedam', null, 'JVO4082');
                  
SELECT * FROM veiculo;                     
                
INSERT INTO ordemServico(Serv_Status, dataEmissao, dataConclusao, Quantidade)
			VALUES(default,20220520,null,default),
				  ('Aprovado',20220520,20220605,5),
                  ('Cancelado',20220520,null,default);
                  
SELECT * FROM ordemServico;   

INSERT INTO mecanico(idMServico, Pnome, Sobrenome, CPF, especialidade)
			VALUES(1,'Miguel','Juarez','78760783036','carros'),
                  (2,'Alexandre','Meireles','50102891052','motocicletas'),
                  (3,'Ferreiro','Juares','09551986075','estética automotiva');
                  
 SELECT * FROM mecanico;                  
            
 INSERT INTO peca(idPveiculo,Pnome)
			VALUES(1,'motor'),
				  (2,'pedal'),
                  (3,'Tinta Automotiva');
                  
SELECT * FROM mecanico;                

INSERT INTO pecaServico(idPSpeca,idPSservico,valor)
			VALUES(1,1,5000),
				  (2,2,300),
                  (3,3,25.99); 

SELECT * FROM pecaServico;  

INSERT INTO clienteVeiculo(idCVcliente,idCVveiculo,renavam)
			VALUES(1,1,07381061431),
				  (1,2,66385404649),
                  (2,3,37278595650);
                  
SELECT * FROM clienteVeiculo;

-- Veiculo pertence a qual cliente?
SELECT  tipoDeVeiculo, marca, renavam , concat(Pnome,' ',Sobrenome) AS NomeCompleto 
	FROM cliente, veiculo,  clienteVeiculo
    WHERE idCliente = idCVcliente AND idVeiculo = idCVveiculo
    ORDER BY NomeCompleto;
 
-- Quantos servicos foram aprovado e qual responsavel do servico?
SELECT count(idServico) AS NumeroDeServicos, concat(Pnome,' ',Sobrenome) AS NomedoMecanico, especialidade
	FROM mecanico, ordemServico 
    WHERE Serv_Status = 'Aprovado' AND idServico= idMServico;
    
-- Valor das pecas e seu total referente a quantidade onde a quantidade seja maior que 1 ?
SELECT Pnome AS Peca, valor , Quantidade ,valor*Quantidade AS ValorTotal 
	FROM peca, ordemServico, pecaServico
    WHERE idPeca = idPSpeca AND idServico = idPSservico
    GROUP BY Quantidade
    HAVING Quantidade > 1;
  
 -- Relacao de servicos e Clientes?
 SELECT * FROM ordemServico 
		LEFT OUTER JOIN cliente ON idCliente = idServico
UNION
 SELECT * FROM ordemServico      
        RIGHT OUTER JOIN cliente ON idCliente = idServico;