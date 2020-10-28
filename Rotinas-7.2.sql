-- 7.2 (b)
CREATE OR REPLACE FUNCTION FN_GERA_NUMERO_TELEFONE(DDD VARCHAR, PREFIXO VARCHAR)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS $$
DECLARE
NOVO_NUMERO VARCHAR;
SUFIXO_NUMERO VARCHAR;
NUMEROS RECORD;

BEGIN
	--PEGANDO TODOS AS OCORRENCIAS DA TABELA CHIP
	--SELECT * INTO NUMEROS FROM CHIP;
	--MÉTODO QUE VAI GERAR OS ÚLTIMOS 4 DIGITOS DO NÚMERO
	SELECT FLOOR(RANDOM() *10000)::VARCHAR INTO SUFIXO_NUMERO;
	--CONCATENANDO DDD+PREFIXO+SUFIXO GERADO DE FORMA RANDOM
	SELECT CONCAT(DDD,PREFIXO,SUFIXO_NUMERO) INTO NOVO_NUMERO;
	
	FOR NUMEROS IN SELECT IDNUMERO FROM CHIP LOOP
		IF NUMEROS.IDNUMERO = NOVO_NUMERO THEN
			RAISE EXCEPTION 'NUMERO JÁ REGISTRADO NA BASE';
			
		END IF;
	END LOOP;
	RETURN NOVO_NUMERO;
END$$;
	
SELECT FN_GERA_NUMERO_TELEFONE('83','99852');