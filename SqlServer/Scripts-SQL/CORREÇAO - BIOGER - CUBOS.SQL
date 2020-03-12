--***************************************************************************************
--E Q U I P A M E N T O S
--***************************************************************************************
SELECT	COUNT(1)
FROM	dbo.BIOGER_RPE_EMB
WHERE	SIGLA_EQUIPAMENTO NOT IN (SELECT SIGLA_EQUIPAMENTO FROM TAB_EQUIPAMENTO)

INSERT INTO TAB_EQUIPAMENTO
SELECT	DISTINCT SIGLA_EQUIPAMENTO, NME_EQUIPAMENTO
FROM	dbo.BIOGER_RPE_EMB
WHERE	SIGLA_EQUIPAMENTO NOT IN (SELECT SIGLA_EQUIPAMENTO FROM TAB_EQUIPAMENTO)

SELECT	COUNT(1)
FROM	dbo.BIOGER_RPE_DES
WHERE	SIGLA_EQUIPAMENTO NOT IN (SELECT SIGLA_EQUIPAMENTO FROM TAB_EQUIPAMENTO)

INSERT INTO TAB_EQUIPAMENTO
SELECT	DISTINCT SIGLA_EQUIPAMENTO, NME_EQUIPAMENTO
FROM	dbo.BIOGER_RPE_DES
WHERE	SIGLA_EQUIPAMENTO NOT IN (SELECT SIGLA_EQUIPAMENTO FROM TAB_EQUIPAMENTO)


--***************************************************************************************
--C I A    A É R E A
--***************************************************************************************


