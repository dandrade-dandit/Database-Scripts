--TABELA ARR
--CREATE TABLE ARR_TEMP AS
SELECT DATA,AEROPO,NUMVOO,CLASSE, COUNT(1) CONTADOR
FROM ARR
GROUP BY DATA,AEROPO,NUMVOO,CLASSE
HAVING COUNT(1) > 1
/

--CREATE TABLE ARR_DADOS_ORIGINAIS AS
SELECT *
FROM ARR
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM ARR_TEMP)
/

SELECT COUNT(*)
FROM ARR
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM ARR_TEMP)
/

DELETE
FROM ARR
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM ARR_TEMP)
/

COMMIT;

ALTER TABLE ARR ADD PRIMARY KEY (DATA,AEROPO,NUMVOO,CLASSE)
/

DECLARE
	--CRIA CURSOR COM TODAS AS MATRICULAS COM STATUS 2(DESLIGADO).
	CURSOR C_MAT IS
	SELECT DATA           
	,AEROPO         
	,NSTATUS        
	,NUMVOO         
	,CLASSE         
	,TIPO           
	,PAXDOM         
	,PAXINT         
	,BAGDOM         
	,BAGINT         
	,BAGTDOM        
	,BAGTINT        
	,CRGDOM         
	,CRGINT         
	,CRGTDOM        
	,CRGTINT        
	,CORDOM         
	,CORINT         
	,CORTDOM        
	,CORTINT        
	,HORAREAL       
	,CATEGORIA
	,NATUREZA       
	FROM ARR_DADOS_ORIGINAIS
	ORDER BY
		DATA           
	,	AEROPO         
	,	NUMVOO         
	,	CLASSE;
	
	--V_COUNT NUMBER;
	--PRAGINHA EXCEPTION;
	--PRAGMA EXCEPTION_INIT (PRAGINHA, -2291);
BEGIN
	
	--V_COUNT := 0;
	FOR X IN C_MAT LOOP
		BEGIN
			INSERT INTO ARR VALUES (X.DATA           
						,X.AEROPO         
						,X.NSTATUS        
						,X.NUMVOO         
						,X.CLASSE         
						,X.TIPO           
						,X.PAXDOM         
						,X.PAXINT         
						,X.BAGDOM         
						,X.BAGINT         
						,X.BAGTDOM        
						,X.BAGTINT        
						,X.CRGDOM         
						,X.CRGINT         
						,X.CRGTDOM        
						,X.CRGTINT        
						,X.CORDOM         
						,X.CORINT         
						,X.CORTDOM        
						,X.CORTINT        
						,X.HORAREAL       
						,X.CATEGORIA
						,X.NATUREZA);
			
			COMMIT;
		
		
			RAISE DUP_VAL_ON_INDEX;
		EXCEPTION
			-- WHEN PRAGINHA THEN
			WHEN DUP_VAL_ON_INDEX THEN
			ROLLBACK;
		END;
		--V_COUNT := V_COUNT + 1;
	END LOOP;

END;
--FIM DA EXECUÇÃO.
/

--TABELA DEP
--CREATE TABLE DEP_TEMP AS
SELECT DATA,AEROPO,NUMVOO,CLASSE, COUNT(1) CONTADOR
FROM DEP
GROUP BY DATA,AEROPO,NUMVOO,CLASSE
HAVING COUNT(1) > 1
/

--CREATE TABLE DEP_DADOS_ORIGINAIS AS
SELECT *
FROM DEP
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM DEP_TEMP)
/

SELECT COUNT(*)
FROM DEP
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM DEP_TEMP)
/

DELETE
FROM DEP
WHERE (DATA,AEROPO,NUMVOO,CLASSE) IN (SELECT DATA,AEROPO,NUMVOO,CLASSE FROM DEP_TEMP)
/

COMMIT;

ALTER TABLE DEP ADD PRIMARY KEY (DATA,AEROPO,NUMVOO,CLASSE)
/

DECLARE
	--CRIA CURSOR COM TODAS AS MATRICULAS COM STATUS 2(DESLIGADO).
	CURSOR C_MAT IS
	SELECT DATA   
	,AEROPO       
	,NSTATUS      
	,NUMVOO       
	,CLASSE       
	,TIPO       
	,PAXBDOM        
	,PAXBINT        
	,PAXPDOM        
	,PAXPINT        
	,EMBDOM         
	,EMBINT         
	,COLO           
	,TRANSITO       
	,CONEXAODOM
	,CONEXAOINT
	,EXTRA          
	,BAGDOM         
	,BAGINT         
	,CRGDOM         
	,CRGINT         
	,CORDOM         
	,CORINT         
	,HORAREAL       
	,CATEGORIA      
	,NATUREZA       
	FROM DEP_DADOS_ORIGINAIS
	ORDER BY          
		DATA           
	,	AEROPO         
	,	NUMVOO         
	,	CLASSE;
	
	--V_COUNT NUMBER;
	--PRAGINHA EXCEPTION;
	--PRAGMA EXCEPTION_INIT (PRAGINHA, -2291);
BEGIN
	
	--V_COUNT := 0;
	FOR X IN C_MAT LOOP
		BEGIN
			INSERT INTO DEP VALUES (X.DATA           
						,X.AEROPO       
						,X.NSTATUS      
						,X.NUMVOO       
						,X.CLASSE       
						,X.TIPO         
						,X.PAXBDOM      
						,X.PAXBINT      
						,X.PAXPDOM      
						,X.PAXPINT      
						,X.EMBDOM       
						,X.EMBINT       
						,X.COLO         
						,X.TRANSITO     
						,X.CONEXAODOM   
						,X.CONEXAOINT   
						,X.EXTRA        
						,X.BAGDOM       
						,X.BAGINT       
						,X.CRGDOM       
						,X.CRGINT       
						,X.CORDOM    
						,X.CORINT    
						,X.HORAREAL  
						,X.CATEGORIA 
						,X.NATUREZA  
						);
			
			COMMIT;
		
		
			RAISE DUP_VAL_ON_INDEX;
		EXCEPTION
			-- WHEN PRAGINHA THEN
			WHEN DUP_VAL_ON_INDEX THEN
			ROLLBACK;
		END;
		--V_COUNT := V_COUNT + 1;
	END LOOP;

END;
--FIM DA EXECUÇÃO.
/




DECLARE
	CURSOR C_MAT IS
	SELECT DATA           
	,AEROPO         
	,NSTATUS        
	,NUMVOO         
	,CLASSE         
	,TIPO           
	,PAXDOM         
	,PAXINT         
	,BAGDOM         
	,BAGINT         
	,BAGTDOM        
	,BAGTINT        
	,CRGDOM         
	,CRGINT         
	,CRGTDOM        
	,CRGTINT        
	,CORDOM         
	,CORINT         
	,CORTDOM        
	,CORTINT        
	,HORAREAL       
	,CATEGORIA
	,NATUREZA       
	FROM ARR_DADOS_ORIGINAIS
	ORDER BY
		DATA           
	,	AEROPO         
	,	NUMVOO         
	,	CLASSE;
	
	
	V_DATA       	DATE;
	V_AEROPO        VARCHAR2(4); 
	V_NUMVOO        VARCHAR2(7); 
	V_CLASSE 	VARCHAR2(2);
	
	V_DATA_OLD     	DATE;
	V_AEROPO_OLD    VARCHAR2(4); 
	V_NUMVOO_OLD    VARCHAR2(7); 
	V_CLASSE_OLD	VARCHAR2(2);
	
BEGIN
	
	V_DATA_OLD := '01/01/2001';  
	V_AEROPO_OLD := 'A';
	V_NUMVOO_OLD := 'A';
	V_CLASSE_OLD := 'A';
	
	FOR X IN C_MAT LOOP
		V_DATA := X.DATA;  
		V_AEROPO := X.AEROPO;
		V_NUMVOO := X.NUMVOO;
		V_CLASSE := X.CLASSE;
		IF NOT (V_DATA = V_DATA_OLD AND V_AEROPO = V_AEROPO_OLD AND V_NUMVOO = V_NUMVOO_OLD AND V_CLASSE = V_CLASSE_OLD) THEN
			INSERT INTO ARR_DADOS_ORIGINAIS2
					 VALUES (X.DATA           
						,X.AEROPO         
						,X.NSTATUS        
						,X.NUMVOO         
						,X.CLASSE         
						,X.TIPO           
						,X.PAXDOM         
						,X.PAXINT         
						,X.BAGDOM         
						,X.BAGINT         
						,X.BAGTDOM        
						,X.BAGTINT        
						,X.CRGDOM         
						,X.CRGINT         
						,X.CRGTDOM        
						,X.CRGTINT        
						,X.CORDOM         
						,X.CORINT         
						,X.CORTDOM        
						,X.CORTINT        
						,X.HORAREAL       
						,X.CATEGORIA
						,X.NATUREZA);
			
			COMMIT;
		END IF;		
		
		V_DATA_OLD := V_DATA;  
		V_AEROPO_OLD := V_AEROPO;
		V_NUMVOO_OLD := V_NUMVOO;
		V_CLASSE_OLD := V_CLASSE;
		
	END LOOP;

END;
--FIM DA EXECUÇÃO.
/
