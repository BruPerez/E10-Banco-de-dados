/******************************************************************************************
 *         					        E03 - SQL    										  *
 ******************************************************************************************
 * Data: 09/01/2022 													            	  *
 * Autor: Bruna Perez																	  *
 * Descri��o: Consultando dados															  *
 ******************************************************************************************/

USE E03_SQL;

-- -----------------------------------------------------
-- Listar o nome de todos os clientes
-- -----------------------------------------------------
SELECT nome FROM Clientes;
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar o nome de todas as ag�ncias criadas ap�s 1975 (editei pq eu criei as empresas em outras datas)
-- -----------------------------------------------------
SELECT nome, DataCriacao FROM agencias
WHERE DataCriacao > '1975-07-14';
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar as contas que s�o poupan�a
-- -----------------------------------------------------
SELECT * FROM Contas WHERE TipoConta = 'Poupanca';
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar as contas criadas na ag�ncia central
-- -----------------------------------------------------
SELECT * FROM Contas WHERE IdAgencia = '1';
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar as transa��es realizadas a partir da conta do 'Jo�o'
-- -----------------------------------------------------
SELECT t.idConta, t.Valor, t.TipoTransicao, t.ContaOrigem, 
t.idConta, c.IdCliente 
FROM Transacoes t, Contas c
WHERE t.ContaOrigem = '1' 
AND c.IdCliente = '1';
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar as transa��es realizadas pelo 'Bruna' para a conta do 'Maria'
-- -----------------------------------------------------
SELECT * FROM Transacoes t 
WHERE t.ContaOrigem = '0' 
AND t.idConta= '2';
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Listar as ag�ncias que possuem pelo menos 3 contas
-- -----------------------------------------------------
SELECT a.Nome, COUNT(Contas.IdConta) numContas FROM Agencias a
JOIN contas ON Contas.IdConta = a.idAgencia
GROUP BY a.Nome
HAVING COUNT(Contas.IdConta) >= 3;
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Listar as contas com pelo menos 4 transa��es
-- -----------------------------------------------------

SELECT c.IdConta, Clientes.Nome, COUNT(Transacoes.idTransacoes) numTransacoes FROM Contas c 
JOIN Transacoes ON Transacoes.ContaOrigem = c.IdConta
JOIN Clientes ON Clientes.idCliente = c.IdCliente
GROUP BY C.IdConta, Clientes.Nome
HAVING COUNT(Transacoes.idTransacoes) >= 4;

-- -----------------------------------------------------
-- Listar os clientes que n�o realizaram transa��es
-- -----------------------------------------------------

SELECT c.Nome, COUNT(Transacoes.idTransacoes) numTransacoes FROM Clientes c
JOIN Contas ON Contas.IdCliente = c.idCliente
LEFT JOIN Transacoes ON Transacoes.ContaOrigem = Contas.IdConta
GROUP BY c.Nome
HAVING COUNT(Transacoes.idTransacoes) = 0;