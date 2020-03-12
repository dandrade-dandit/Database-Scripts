--******************************************************
SELECT      SIGLA_AEROPORTO
      ,    NR_CHG_VOO
      ,    DH_CHG_EFE
      ,  CD_COM
      ,  CD_STA
      ,    COUNT(1) AS TOTAL
  FROM      dbo.INTEGRACAO_SISO_BIOGER_DES
GROUP
    BY  SIGLA_AEROPORTO
      ,    NR_CHG_VOO
      ,    DH_CHG_EFE
      ,  CD_COM
      ,  CD_STA
HAVING  COUNT(1) > 1
ORDER BY 6 DESC

--******************************************************
SELECT      *
  FROM      dbo.INTEGRACAO_SISO_BIOGER_DES
WHERE  SIGLA_AEROPORTO = 'SBGL'
   AND      NR_CHG_VOO = 0
   AND      CONVERT(VARCHAR(8), DH_CHG_EFE, 112) = '20020822'
   AND  CD_COM = 745
   AND  CD_STA = 47975
--******************************************************
--******************************************************
SELECT      SIGLA_AEROPORTO
      ,		NR_PAR_VOO
      ,		DH_PAR_EFE
      ,		CD_COM
      ,		CD_STA
      ,		COUNT(1) AS TOTAL
  FROM      dbo.INTEGRACAO_SISO_BIOGER_EMB
GROUP
    BY		SIGLA_AEROPORTO
      ,		NR_PAR_VOO
      ,		DH_PAR_EFE
      ,		CD_COM
      ,		CD_STA
HAVING		COUNT(1) > 1
ORDER BY 6 DESC

--******************************************************
SELECT      *
  FROM      dbo.INTEGRACAO_SISO_BIOGER_DES
WHERE  SIGLA_AEROPORTO = 'SBGL'
   AND      NR_CHG_VOO = 0
   AND      CONVERT(VARCHAR(8), DH_CHG_EFE, 112) = '20020822'
   AND  CD_COM = 745
   AND  CD_STA = 47975
--******************************************************
--******************************************************
SELECT      SIGLA_AEROPORTO
      ,		CD_STA
      ,		CD_MOV
      ,		HR_MOV
      ,		COUNT(1) AS TOTAL
  FROM      dbo.INTEGRACAO_SISO_BIOGER_MOV
GROUP
    BY		SIGLA_AEROPORTO
      ,		CD_STA
      ,		CD_MOV
      ,		HR_MOV
HAVING  COUNT(1) > 1
ORDER BY 5 DESC

--******************************************************
SELECT      *
  FROM      dbo.INTEGRACAO_SISO_BIOGER_DES
WHERE  SIGLA_AEROPORTO = 'SBGL'
   AND      NR_CHG_VOO = 0
   AND      CONVERT(VARCHAR(8), DH_CHG_EFE, 112) = '20020822'
   AND  CD_COM = 745
   AND  CD_STA = 47975
--******************************************************