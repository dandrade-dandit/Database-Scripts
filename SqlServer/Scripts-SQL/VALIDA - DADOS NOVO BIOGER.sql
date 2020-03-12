--******************************************************
SELECT      SIG_AEROPORTO
      ,		NUM_VOO
      ,		DTH_EFETIVA_POUSO
      ,		COD_CIA_AEREA
      ,		COD_STATUS
      ,		 COUNT(1) AS TOTAL
  FROM      dbo.IEOP_DESEMBARQUE_TEMP
GROUP
    BY		SIG_AEROPORTO
      ,		NUM_VOO
      ,		DTH_EFETIVA_POUSO
      ,		COD_CIA_AEREA
      ,		COD_STATUS
HAVING  COUNT(1) > 1
ORDER BY 6 DESC

--******************************************************
SELECT      COUNT(1) AS TOTAL
  FROM      dbo.IEOP_DESEMBARQUE_TEMP
--******************************************************
SELECT      *
  FROM      dbo.IEOP_DESEMBARQUE_TEMP
WHERE		SIG_AEROPORTO = 'SBGL'
   AND      NUM_VOO = 0
   AND      CONVERT(VARCHAR(8), DTH_EFETIVA_POUSO, 112) = '20020822'
   AND		COD_CIA_AEREA = 745
   AND		COD_STATUS = 47975
--******************************************************
--******************************************************
SELECT      SIG_AEROPORTO
      ,		NUM_VOO
      ,		DTH_EFETIVA_DECOLAGEM
      ,		COD_CIA_AEREA
      ,		COD_STATUS
      ,		COUNT(1) AS TOTAL
  FROM      dbo.IEOP_EMBARQUE_TEMP
GROUP
    BY		SIG_AEROPORTO
      ,		NUM_VOO
      ,		DTH_EFETIVA_DECOLAGEM
      ,		COD_CIA_AEREA
      ,		COD_STATUS
HAVING		COUNT(1) > 1
ORDER BY 6 DESC

--******************************************************
SELECT      COUNT(1) AS TOTAL
  FROM      dbo.IEOP_EMBARQUE_TEMP
--******************************************************
SELECT      *
  FROM      dbo.IEOP_EMBARQUE_TEMP
WHERE		SIG_AEROPORTO = 'SBGL'
   AND      NUM_VOO = 0
   AND      CONVERT(VARCHAR(8), DTH_EFETIVA_DECOLAGEM, 112) = '20020822'
   AND		COD_CIA_AEREA = 745
   AND		COD_STATUS = 47975
--******************************************************
--******************************************************
SELECT      SIG_AEROPORTO
      ,		COD_STATUS
      ,		COD_MOVIMENTO
      ,		DTH_MOVIMENTO
      ,		COUNT(1) AS TOTAL
  FROM      dbo.IEOP_MOVIMENTACAO_TEMP
GROUP
    BY		SIG_AEROPORTO
      ,		COD_STATUS
      ,		COD_MOVIMENTO
      ,		DTH_MOVIMENTO
HAVING  COUNT(1) > 1
ORDER BY 5 DESC

--******************************************************
SELECT      COUNT(1) AS TOTAL
  FROM      dbo.IEOP_MOVIMENTACAO_TEMP
--******************************************************
SELECT      *
  FROM      dbo.IEOP_MOVIMENTACAO_TEMP
WHERE		SIG_AEROPORTO = 'SBGL'
   AND      CONVERT(VARCHAR(8), DTH_MOVIMENTO, 112) = '20020822'
   AND		COD_MOVIMENTO = 745
   AND		COD_STATUS = 47975
--******************************************************

SELECT	REM.NR_CHG_VOO, REM.DH_CHG_EFE, REM.CD_COM, REM.CD_STA 
  FROM	[S-RJBN135\PRDSBGL01].[integracao].[dbo].[INTEGRACAO_SISO_BIOGER_DES_NEW] REM
     ,	dbo.IEOP_DESEMBARQUE_TEMP SEDE
 WHERE	REM.SIGLA_AEROPORTO = SEDE.SIG_AEROPORTO COLLATE Latin1_General_CI_AI
   AND	REM.NR_CHG_VOO = SEDE.NUM_VOO COLLATE Latin1_General_CI_AI
   AND	REM.DH_CHG_EFE = SEDE.DTH_EFETIVA_POUSO 
   AND	REM.CD_COM = SEDE.COD_CIA_AEREA 
   AND	REM.CD_STA = SEDE.COD_STATUS
   AND  DH_CHG_EFE < '20110715'