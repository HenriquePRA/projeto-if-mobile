--VW-1
CREATE OR REPLACE VIEW VW_1
AS SELECT PLANO.IDPLANO, PLANO.DESCRICAO, COUNT(CHIP.IDPLANO) AS QUANT_PLANOS_ATIVOS,(COUNT(CHIP.*)*PLANO.VALOR) AS VALOR_ARRECADADO
FROM PLANO JOIN CHIP
ON PLANO.IDPLANO = CHIP.IDPLANO
GROUP BY PLANO.IDPLANO, CHIP.ATIVO, CHIP.IDPLANO
HAVING CHIP.ATIVO = 'S';

--VW-3
CREATE OR REPLACE VIEW VW_3
AS
SELECT CLIENTE.IDCLIENTE, CLIENTE.NOME, ESTADO.UF, CHIP.IDNUMERO,PLANO.DESCRICAO, TO_CHAR(current_date - datacadastro, 'MM/YYYY') AS Tempo_na_empresa
FROM CLIENTE JOIN CIDADE
ON CLIENTE.IDCIDADE = CIDADE.IDCIDADE
JOIN ESTADO
ON ESTADO.UF = CIDADE.UF
JOIN CLIENTE_CHIP
ON CLIENTE.IDCLIENTE = CLIENTE_CHIP.IDCLIENTE
JOIN CHIP
ON CHIP.IDNUMERO = CLIENTE_CHIP.IDNUMERO
JOIN PLANO
ON CHIP.IDPLANO = PLANO.IDPLANO
WHERE CLIENTE.CANCELADO = 'N'