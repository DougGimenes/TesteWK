CREATE DATABASE `testewk`;

CREATE TABLE `testewk`.`clientes` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Cidade` VARCHAR(50) NULL,
  `UF` CHAR(2) NULL,
  PRIMARY KEY (`Codigo`));
  
CREATE TABLE `testewk`.`produtos` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(100) NOT NULL,
  `PrecoVenda` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`Codigo`));
  
CREATE TABLE `testewk`.`pedidos` (
  `NumPedido` INT NOT NULL AUTO_INCREMENT,
  `DataEmissao` DATETIME NOT NULL,
  `CodCliente` INT NOT NULL,
  `ValorTotal` DECIMAL(19,2) NULL,
  PRIMARY KEY (`NumPedido`),
  INDEX `CodCliente_idx` (`CodCliente` ASC) VISIBLE,
  CONSTRAINT `CodCliente`
    FOREIGN KEY (`CodCliente`)
    REFERENCES `testewk`.`clientes` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `testewk`.`itens` (
  `CodItem` INT NOT NULL AUTO_INCREMENT,
  `NumPedido` INT NOT NULL,
  `CodProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `ValorUnitario` DECIMAL(19,2) NOT NULL,
  `ValorTotal` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`CodItens`),
  INDEX `CodProduto_idx` (`CodProduto` ASC) VISIBLE,
  INDEX `NumPedido_idx` (`NumPedido` ASC) VISIBLE,
  CONSTRAINT `CodProduto`
    FOREIGN KEY (`CodProduto`)
    REFERENCES `testewk`.`produtos` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NumPedido`
    FOREIGN KEY (`NumPedido`)
    REFERENCES `testewk`.`pedidos` (`NumPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO testewk.produtos(Descricao, PrecoVenda) VALUES 
  ('Coca-Cola Lata', 3.5), 
  ('Guaraná Antartica Lata', 3.5), 
  ('Fanta Uva Lata', 4), 
  ('Fanta Laranja Lata', 4), 
  ('Fanta Maracuja Lata', 4), 
  ('Batata Frita Ruffles', 5.3), 
  ('Cheetos Onda Req.', 4.7), 
  ('Doritos', 6.99), 
  ('Pão de Forma Kim', 5.49), 
  ('Pão de Forma Panco', 6.39), 
  ('Coca-Cola 2L', 7), 
  ('Guaraná Antartica 2L', 6.49), 
  ('Fanta Laranja 2L', 7.7), 
  ('Farofa Temperada 500g', 12.99), 
  ('Farinha de Trigo 1Kg', 5.99), 
  ('Farinha de Rosca 1Kg', 6.89), 
  ('Fermento quimico', 3.4), 
  ('Alcool 70%', 9.99), 
  ('Fermento Biológico Seco', 0.5), 
  ('Agua 5L', 20);
  
INSERT INTO Clientes(Nome, Cidade, UF) VALUES
  ('Douglas', 'São Paulo', 'SP'),
  ('Carolina', 'São Paulo', 'SP'),
  ('Diego', 'Caraguatatuba', 'SP'),
  ('Wander', 'Maringá', 'PR'),
  ('Sônia', 'Taubaté', 'SP'),
  ('Rosangela', 'Taubaté', 'SP'),
  ('Maria', 'Taubaté', 'SP'),
  ('Darc', 'Campinas', 'SP'),
  ('Antonio', 'Caraguatatuba', 'SP'),
  ('Leonilde', 'Caraguatatuba', 'SP'),
  ('Vanda', 'Taubaté', 'SP'),
  ('Ricardo', 'São José dos Campos', 'SP'),
  ('Wagner', 'Curitiba', 'PR'),
  ('Monica', 'Campinas', 'SP'),
  ('Julia', 'Pindamonhangaba', 'SP'),
  ('Marcelo', 'São Caetano', 'SP'),
  ('Rodrigo', 'São Paulo', 'SP'),
  ('Marcela', 'Curitiba', 'PR'),
  ('João', 'Taubaté', 'SP'),
  ('Victor', 'Taubaté', 'SP');
