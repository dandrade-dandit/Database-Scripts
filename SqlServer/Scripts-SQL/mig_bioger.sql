USE BIOGER


select	COUNT(1)
  --DELETE
  from	BIOGER_RPE_DES
 where  SIGLA_AEROPORTO IN ('SBJP')
   and  DATA_HORA_EFETIVA_POUSO >= '20120101'


select	COUNT(1)
  --DELETE
  from	BIOGER_DADOS_DIARIOS_DES
 where  DATA_HORA_EFETIVA_POUSO < '20130301'

INSERT INTO BIOGER_RPE_DES
SELECT * 
--delete
  FROM BIOGER_RPE_DES_MIG
 --where  SIGLA_AEROPORTO IN ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')

TRUNCATE TABLE BIOGER_RPE_DES_MIG

--------------------------------
select	COUNT(1)
  --DELETE
  from	BIOGER_RPE_EMB
 where  SIGLA_AEROPORTO IN ('SBJP')
   and  DATA_HORA_EFETIVA_DECOLAGEM >= '20120101'
 
select	COUNT(1)
  --DELETE
  from	BIOGER_DADOS_DIARIOS_EMB
 where  DATA_HORA_EFETIVA_DECOLAGEM < '20130301'
 
INSERT INTO BIOGER_RPE_EMB
SELECT * 
--delete
FROM BIOGER_RPE_EMB_MIG
 --where  SIGLA_AEROPORTO IN ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')

TRUNCATE TABLE BIOGER_RPE_EMB_MIG

--------------------------------
select	COUNT(1)
  --DELETE
  from	BIOGER_RPE_MOV
 where  SIGLA_AEROPORTO  IN ('SBJP')
   and  DATA_HORA_MOV >= '20120101'
 
select	COUNT(1)
  --DELETE
  from	BIOGER_DADOS_DIARIOS_MOV
 where  DATA_HORA_MOV < '20130301'
 
INSERT INTO BIOGER_RPE_MOV
SELECT * 
--delete
FROM BIOGER_RPE_MOV_MIG
 --where  SIGLA_AEROPORTO IN ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')

TRUNCATE TABLE BIOGER_RPE_MOV_MIG

--***************************************************************************************
--
--***************************************************************************************
SELECT	COUNT(1)
--DELETE
  FROM	BIOGER.dbo.BIOGER_RPE_MOV
 WHERE	CD_STA IN (
        SELECT	CD_STA
		  FROM  BIOGER.dbo.BIOGER_RPE_DES
		 WHERE  YEAR(DATA_HORA_EFETIVA_POUSO) = 2013
		   AND  MONTH(DATA_HORA_EFETIVA_POUSO) = 3
		   AND  SIGLA_AEROPORTO  in ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')
     )
   AND  SIGLA_AEROPORTO  in ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')
   AND  MONTH(DATA_HORA_MOV) = 3
   AND  YEAR(DATA_HORA_MOV) = 2013
--*****************************************************
SELECT	COUNT(1)
--DELETE
  FROM	BIOGER.dbo.BIOGER_RPE_MOV
 WHERE	CD_STA IN (
        SELECT	CD_STA
		  FROM  BIOGER.dbo.BIOGER_RPE_EMB
		 WHERE  YEAR(DATA_HORA_EFETIVA_DECOLAGEM) = 2013
		   AND  MONTH(DATA_HORA_EFETIVA_DECOLAGEM) = 3
		   AND  SIGLA_AEROPORTO  in ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')
     )
   AND  SIGLA_AEROPORTO  in ('SBPR', 'SBPA', 'SBMT', 'SBJC', 'SBCF', 'SBCG')
   AND  MONTH(DATA_HORA_MOV) = 3
   AND  YEAR(DATA_HORA_MOV) = 2013
   
--******************************************************
SELECT	COUNT(1)
--DELETE
  FROM  BIOGER.dbo.BIOGER_RPE_DES
 WHERE  YEAR(DATA_HORA_EFETIVA_POUSO) = 2012
   --AND  MONTH(DATA_HORA_EFETIVA_POUSO) = 8
   AND  SIGLA_AEROPORTO  in ('SBGO', 'SBJC')
   
   
--*******************************************************
SELECT	COUNT(1)
--DELETE
  FROM  BIOGER.dbo.BIOGER_RPE_EMB
 WHERE  YEAR(DATA_HORA_EFETIVA_DECOLAGEM) = 2012
   --AND  MONTH(DATA_HORA_EFETIVA_DECOLAGEM) = 8
   AND  SIGLA_AEROPORTO  in ('SBGO', 'SBJC')
   
   
--***************************************************************************************
--
--***************************************************************************************

SELECT	COUNT(1)
--DELETE
  FROM	BIOGER_RPE_DES_MIG
 WHERE  SIGLA_AEROPORTO = 'SBJU'
 
SELECT	COUNT(1)
--DELETE
  FROM	BIOGER_RPE_EMB_MIG
 WHERE  SIGLA_AEROPORTO = 'SBJU'
 
SELECT	COUNT(1)
--DELETE
  FROM	BIOGER_RPE_MOV_MIG
 WHERE  SIGLA_AEROPORTO = 'SBJU'  
 
--***************************************************************************************
--
--***************************************************************************************
UPDATE	[BIOGER].[dbo].[BIOGER_LOGS_CARGA_SISO]
   SET	[flg_migrado] = 1
 WHERE	dta_migracao > '20121201'