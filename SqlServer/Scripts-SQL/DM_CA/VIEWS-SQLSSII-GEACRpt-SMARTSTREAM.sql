USE [GEACrpt]
GO

/****** Object:  View [dbo].[gvw_resumo_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[gvw_resumo_da] as
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'RECEITAS' AS GRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal_dre_gerencial]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'RECEITA%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'OBU' AS GRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal_dre_gerencial]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'OBU%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DESPESAS' AS GRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal_dre_gerencial]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DESPESAS%'
   --AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DEDUCOES' AS GRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DEDUCOES%'
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]









GO

/****** Object:  View [dbo].[gvw_resumo_da_det_agua_luz]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--select * from gvw_resumo_da_det_agua_luz

CREATE view [dbo].[gvw_resumo_da_det_agua_luz] as
SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'ÁGUA E ESGOTO' as desc_conta
      ,[processing_yr]
      ,'REALIZADO' tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM (
		SELECT [dependencia]
			  ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
			  ,[processing_yr]
			  ,'DESPESAS' AS GRUPO_CONTA
			  ,[sub_grupo] AS SUBGRUPO_CONTA
			  ,[conta_descp] AS DESC_CONTA
			  ,conta
			  ,SUM([ldr_amt_1]) AS [ldr_amt_1]
			  ,SUM([ldr_amt_2]) AS [ldr_amt_2]
			  ,SUM([ldr_amt_3]) AS [ldr_amt_3]
			  ,SUM([ldr_amt_4]) AS [ldr_amt_4]
			  ,SUM([ldr_amt_5]) AS [ldr_amt_5]
			  ,SUM([ldr_amt_6]) AS [ldr_amt_6]
			  ,SUM([ldr_amt_7]) AS [ldr_amt_7]
			  ,SUM([ldr_amt_8]) AS [ldr_amt_8]
			  ,SUM([ldr_amt_9]) AS [ldr_amt_9]
			  ,SUM([ldr_amt_10]) AS [ldr_amt_10]
			  ,SUM([ldr_amt_11]) AS [ldr_amt_11]
			  ,SUM([ldr_amt_12]) AS [ldr_amt_12]
			  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
		  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
		  WHERE [ldr_entity_id] = 'INFRA'
		   AND [dependencia] IN ( SELECT [cd_aerop_num]
									FROM GEACutcx.dbo.cor_aeroporto_u
									WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
															'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
															'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
															'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
															'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
															'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
															'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
		   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
		   AND [grupo] IN ('DESPESAS')
		   AND sub_grupo IN ('Utilidades e Servicos Publicos')
		   AND conta_descp IN ('ÁGUA E ESGOTO')
		  GROUP BY [dependencia]
			  ,[processing_yr]
			  ,[sub_grupo]
			  ,[conta_descp]
			  ,conta) AS det_despesas
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
UNION
SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'ENERGIA ELÉTRICA' as desc_conta
      ,[processing_yr]
      ,'REALIZADO' tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM (
		SELECT [dependencia]
			  ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
			  ,[processing_yr]
			  ,'DESPESAS' AS GRUPO_CONTA
			  ,[sub_grupo] AS SUBGRUPO_CONTA
			  ,[conta_descp] AS DESC_CONTA
			  ,conta
			  ,SUM([ldr_amt_1]) AS [ldr_amt_1]
			  ,SUM([ldr_amt_2]) AS [ldr_amt_2]
			  ,SUM([ldr_amt_3]) AS [ldr_amt_3]
			  ,SUM([ldr_amt_4]) AS [ldr_amt_4]
			  ,SUM([ldr_amt_5]) AS [ldr_amt_5]
			  ,SUM([ldr_amt_6]) AS [ldr_amt_6]
			  ,SUM([ldr_amt_7]) AS [ldr_amt_7]
			  ,SUM([ldr_amt_8]) AS [ldr_amt_8]
			  ,SUM([ldr_amt_9]) AS [ldr_amt_9]
			  ,SUM([ldr_amt_10]) AS [ldr_amt_10]
			  ,SUM([ldr_amt_11]) AS [ldr_amt_11]
			  ,SUM([ldr_amt_12]) AS [ldr_amt_12]
			  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
		  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
		  WHERE [ldr_entity_id] = 'INFRA'
		   AND [dependencia] IN ( SELECT [cd_aerop_num]
									FROM GEACutcx.dbo.cor_aeroporto_u
									WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
															'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
															'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
															'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
															'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
															'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
															'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
		   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
		   AND [grupo] IN ('DESPESAS')
		   AND sub_grupo IN ('Utilidades e Servicos Publicos')
		   AND conta_descp IN ('ENERGIA ELÉTRICA')
		  GROUP BY [dependencia]
			  ,[processing_yr]
			  ,[sub_grupo]
			  ,[conta_descp]
			  ,conta) AS det_despesas
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]


GO

/****** Object:  View [dbo].[gvw_resumo_da_det_despesas]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











--select * from gvw_resumo_da_det_agua_luz

CREATE view [dbo].[gvw_resumo_da_det_despesas] as
SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'INVESTIMENTO/OBU' as desc_conta
      ,[processing_yr]
      ,'REALIZADO' tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM (
		SELECT [dependencia]
			  ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
			  ,[processing_yr]
			  ,'DESPESAS' AS GRUPO_CONTA
			  ,[sub_grupo] AS SUBGRUPO_CONTA
			  ,[conta_descp] AS DESC_CONTA
			  ,conta
			  ,SUM([ldr_amt_1]) AS [ldr_amt_1]
			  ,SUM([ldr_amt_2]) AS [ldr_amt_2]
			  ,SUM([ldr_amt_3]) AS [ldr_amt_3]
			  ,SUM([ldr_amt_4]) AS [ldr_amt_4]
			  ,SUM([ldr_amt_5]) AS [ldr_amt_5]
			  ,SUM([ldr_amt_6]) AS [ldr_amt_6]
			  ,SUM([ldr_amt_7]) AS [ldr_amt_7]
			  ,SUM([ldr_amt_8]) AS [ldr_amt_8]
			  ,SUM([ldr_amt_9]) AS [ldr_amt_9]
			  ,SUM([ldr_amt_10]) AS [ldr_amt_10]
			  ,SUM([ldr_amt_11]) AS [ldr_amt_11]
			  ,SUM([ldr_amt_12]) AS [ldr_amt_12]
			  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
		  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
		  WHERE [ldr_entity_id] = 'INFRA'
		   AND [dependencia] IN ( SELECT [cd_aerop_num]
									FROM GEACutcx.dbo.cor_aeroporto_u
									WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
															'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
															'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
															'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
															'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
															'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
															'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
		   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
		   AND [grupo] LIKE 'OBU%'
		   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
		  GROUP BY [dependencia]
			  ,[processing_yr]
			  ,[sub_grupo]
			  ,[conta_descp]
			  ,conta) AS det_despesas
 WHERE [conta] IN (SELECT DISTINCT conta
					  FROM [GEACrpt].[dbo].[dvw_contas]
					 WHERE grupo1_descp = 'DESPESAS'
					   AND grupo2_descp IN ('DESPESAS NAO OPERACIONAIS', 'DESPESAS OPERACIONAIS', 'OUTRAS')
					   AND grupo3_descp IN ('EXPANSÃO MODERNIZ AEROPORTOS'))
					   /*(  conta NOT LIKE '31114%' OR conta NOT LIKE '31401%' OR conta NOT LIKE '31403%' OR conta NOT LIKE '31404%' OR 
							conta NOT IN ('314050016','314050027', '314060010', '314060021', '314060032', '314060043', '314070014', '314070025', '314080018', '341010054', '314010054', '314010065', '314080029')) -- 'Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas' */
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
UNION ALL
SELECT	[dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'CUSTEIO' as desc_conta
      ,[processing_yr]
      ,'REALIZADO' tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM (
		SELECT [dependencia]
			  ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
			  ,[processing_yr]
			  ,'DESPESAS' AS GRUPO_CONTA
			  ,[sub_grupo] AS SUBGRUPO_CONTA
			  ,[conta_descp] AS DESC_CONTA
			  ,conta
			  ,SUM([ldr_amt_1]) AS [ldr_amt_1]
			  ,SUM([ldr_amt_2]) AS [ldr_amt_2]
			  ,SUM([ldr_amt_3]) AS [ldr_amt_3]
			  ,SUM([ldr_amt_4]) AS [ldr_amt_4]
			  ,SUM([ldr_amt_5]) AS [ldr_amt_5]
			  ,SUM([ldr_amt_6]) AS [ldr_amt_6]
			  ,SUM([ldr_amt_7]) AS [ldr_amt_7]
			  ,SUM([ldr_amt_8]) AS [ldr_amt_8]
			  ,SUM([ldr_amt_9]) AS [ldr_amt_9]
			  ,SUM([ldr_amt_10]) AS [ldr_amt_10]
			  ,SUM([ldr_amt_11]) AS [ldr_amt_11]
			  ,SUM([ldr_amt_12]) AS [ldr_amt_12]
			  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
		  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
		  WHERE [ldr_entity_id] = 'INFRA'
		   AND [dependencia] IN ( SELECT [cd_aerop_num]
									FROM GEACutcx.dbo.cor_aeroporto_u
									WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
															'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
															'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
															'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
															'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
															'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
															'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
		   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
		   AND [grupo] LIKE 'DESPESA%'
		   --AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
		  GROUP BY [dependencia]
			  ,[processing_yr]
			  ,[sub_grupo]
			  ,[conta_descp]
			  ,conta) AS det_despesas
 WHERE [conta] IN (SELECT DISTINCT conta
					  FROM [GEACrpt].[dbo].[dvw_contas]
					 WHERE grupo1 = '3'
					   AND grupo2_descp IN ('DESPESAS NAO OPERACIONAIS', 'DESPESAS OPERACIONAIS', 'OUTRAS')
					   AND grupo3_descp NOT IN ('EXPANSÃO MODERNIZ AEROPORTOS')
					   --AND [grupo4_descp] IN ('UTILIDADES - SERVIÇOS PÚBLICOS', 'SERVIÇOS CONTRATADOS E LOCAÇÕES', 'MATERIAIS DE CONSUMO', 'DESPESAS GERAIS', 'DESPESAS FINANCEIRAS', 'DIVERSOS RESPONSÁVEIS')
					   )
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
/*UNION ALL
SELECT	[dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'CUSTEIO' as desc_conta
      ,[processing_yr]
      ,'REALIZADO' tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM (
		SELECT [dependencia]
			  ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
			  ,[processing_yr]
			  ,'DESPESAS' AS GRUPO_CONTA
			  ,[sub_grupo] AS SUBGRUPO_CONTA
			  ,[conta_descp] AS DESC_CONTA
			  ,conta
			  ,SUM([ldr_amt_1]) AS [ldr_amt_1]
			  ,SUM([ldr_amt_2]) AS [ldr_amt_2]
			  ,SUM([ldr_amt_3]) AS [ldr_amt_3]
			  ,SUM([ldr_amt_4]) AS [ldr_amt_4]
			  ,SUM([ldr_amt_5]) AS [ldr_amt_5]
			  ,SUM([ldr_amt_6]) AS [ldr_amt_6]
			  ,SUM([ldr_amt_7]) AS [ldr_amt_7]
			  ,SUM([ldr_amt_8]) AS [ldr_amt_8]
			  ,SUM([ldr_amt_9]) AS [ldr_amt_9]
			  ,SUM([ldr_amt_10]) AS [ldr_amt_10]
			  ,SUM([ldr_amt_11]) AS [ldr_amt_11]
			  ,SUM([ldr_amt_12]) AS [ldr_amt_12]
			  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
		  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
		  WHERE [ldr_entity_id] = 'INFRA'
		   AND [dependencia] IN ( SELECT [cd_aerop_num]
									FROM GEACutcx.dbo.cor_aeroporto_u
									WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
															'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
															'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
															'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
															'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
															'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
															'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
		   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
		   AND [grupo] LIKE 'DEDUCOES%'
		   --AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
		  GROUP BY [dependencia]
			  ,[processing_yr]
			  ,[sub_grupo]
			  ,[conta_descp]
			  ,conta) AS det_despesas
 WHERE [conta] IN (SELECT DISTINCT conta
					  FROM [GEACrpt].[dbo].[dvw_contas]
					 WHERE grupo1 = '3'
					   AND grupo2_descp IN ('DESPESAS NAO OPERACIONAIS', 'DESPESAS OPERACIONAIS', 'OUTRAS')
					   AND grupo3_descp NOT IN ('EXPANSÃO MODERNIZ AEROPORTOS')
					   --AND [grupo4_descp] IN ('UTILIDADES - SERVIÇOS PÚBLICOS', 'SERVIÇOS CONTRATADOS E LOCAÇÕES', 'MATERIAIS DE CONSUMO', 'DESPESAS GERAIS', 'DESPESAS FINANCEIRAS', 'DIVERSOS RESPONSÁVEIS')
					   )
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]*/

/*
--ANTIGO ATÉ 11/02/2015


SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'INVESTIMENTO' as desc_conta
      ,[processing_yr]
      ,CASE [amt_class_type]
          WHEN 'ACTUAL' THEN 'REALIZADO'
          WHEN 'GESTOR' THEN 'ORÇADO'
          ELSE 'OUTROS'
       END tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [conta] IN (SELECT DISTINCT conta
					  FROM [GEACrpt].[dbo].[dvw_contas]
					 WHERE grupo1_descp in ('DESPESAS OPERACIONAIS')
					   AND grupo2_descp IN ('DESPESAS NAO OPERACIONAIS', 'DESPESAS OPERACIONAIS', 'OUTRAS')
					   AND grupo3_descp IN ('EXPANSÃO MODERNIZ AEROPORTOS')
					   AND conta_descp NOT IN ('OBU - RECURSOS DE APORTE DE CAPITAL'))
					   /*(  conta NOT LIKE '31114%' OR conta NOT LIKE '31401%' OR conta NOT LIKE '31403%' OR conta NOT LIKE '31404%' OR 
							conta NOT IN ('314050016','314050027', '314060010', '314060021', '314060032', '314060043', '314070014', '314070025', '314080018', '341010054', '314010054', '314010065', '314080029')) -- 'Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas' */
   AND curr_type = 'T'
   AND dr_cr_code = 'D'
   AND [amt_class_type] IN ('ACTUAL', 'GESTOR')
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
      ,[amt_class_type]
UNION ALL
SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,'CUSTEIO' as desc_conta
      ,[processing_yr]
      ,CASE [amt_class_type]
          WHEN 'ACTUAL' THEN 'REALIZADO'
          WHEN 'GESTOR' THEN 'ORÇADO'
          ELSE 'OUTROS'
       END tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [conta] IN (SELECT DISTINCT conta
					  FROM [GEACrpt].[dbo].[dvw_contas]
					 WHERE grupo1_descp IN ('DESPESAS OPERACIONAIS')
					   AND grupo2_descp IN ('DESPESAS NAO OPERACIONAIS', 'DESPESAS OPERACIONAIS', 'OUTRAS')
					   AND grupo3_descp NOT IN ('EXPANSÃO MODERNIZ AEROPORTOS')
					   AND [grupo4_descp] NOT IN ('ANULAÇÃO RECEITA EXERC ANTERIORES','DESPESAS FINANCEIRAS', 'INDENIZAÇÕES PDITA','PERDAS DE CAP - IMOBILIZADO, INVESTIMENTO E INTANG', 'DEPRECIAÇÕES E AMORTIZACOES')
					   AND (conta NOT LIKE '31114%' AND conta NOT LIKE '31401%' AND conta NOT LIKE '31403%' AND conta NOT LIKE '31404%' AND conta NOT IN ('314050016','314050027', '314060010', '314060021', '314060032', '314060043', '314070014', '314070025', '314080018', '341010054', '314010054', '314010065', '314080029'))
					   )
   AND curr_type = 'T'
   AND dr_cr_code = 'D'
   AND [amt_class_type] IN ('ACTUAL', 'GESTOR')
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
      ,[amt_class_type]

*/
      
/*SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,CASE [conta]
          WHEN '311060012' THEN 'INVESTIMENTO'
          WHEN '311060023' THEN 'CUSTEIO'
          ELSE 'OUTROS'
       END desc_conta
      ,[processing_yr]
      ,CASE [amt_class_type]
          WHEN 'ACTUAL' THEN 'REALIZADO'
          WHEN 'GESTOR' THEN 'ORÇADO'
          ELSE 'OUTROS'
       END tipo
      ,SUM([ldr_amt_1]) AS JAN
      ,SUM([ldr_amt_2]) AS FEV
      ,SUM([ldr_amt_3]) AS MAR
      ,SUM([ldr_amt_4]) AS ABR
      ,SUM([ldr_amt_5]) AS MAI
      ,SUM([ldr_amt_6]) AS JUN
      ,SUM([ldr_amt_7]) AS JUL
      ,SUM([ldr_amt_8]) AS AGO
      ,SUM([ldr_amt_9]) AS "SET"
      ,SUM([ldr_amt_10]) AS "OUT"
      ,SUM([ldr_amt_11]) AS NOV
      ,SUM([ldr_amt_12]) AS DEZ
      ,SUM([ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014')
   AND [conta] IN ('311060012', '311060023')
   AND curr_type = 'T'
   AND dr_cr_code = 'D'
   AND [amt_class_type] IN ('ACTUAL', 'GESTOR')
GROUP BY [dependencia]
      ,[conta]
      ,[processing_yr]
      ,[amt_class_type]
*/










GO

/****** Object:  View [dbo].[gvw_resumo_da_det_despesas_receitas_teca]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--select * from gvw_resumo_da_det_agua_luz

CREATE view [dbo].[gvw_resumo_da_det_despesas_receitas_teca] as
SELECT	(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = RECEITAS.dependencia) AS sigla_dep
     ,	RECEITAS.ano
     ,	DESPESAS.grupo_despesa
     ,	DESPESAS.total_despesa
     ,	RECEITAS.grupo_receita
     ,  RECEITAS.total_receita
FROM (
	SELECT [dependencia]
		  ,'RECEITA' AS grupo_receita
		  ,[processing_yr] as ano
		  , SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) total_receita
	  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
	 where conta in ( '411070014', '411070025', '411080018', '411080029', '411090012', '411090023', '413010012', '413010023', '413010249', '411150022', '411150011', '411160026', '411160015', '413010341' )
	   and [processing_yr] > 2011
	 group
		by [dependencia]
		  ,[processing_yr]
	) AS RECEITAS LEFT OUTER JOIN
	(
  SELECT   [dependencia]
		  ,[grupo] as grupo_despesa
		  ,[processing_yr] as ano
		  ,SUM(TOTAL) AS total_despesa
	  FROM (
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010012', '311010023', '311010034', '311010045', '311010056', '311010067', '311010078', '311010089', '311010090', '311010114', '311010125', '311010136', '311010158', '311020016','311020027', '311020049', 
			                  '311020050', '311020061', '311020072', '311020083', '311020094', '311020107',	'311020118', '311020130', '311020141', '311020185', '311030010', '311030021', '311030032', '311030043','311030054', '311030065', 
			                  '311030076', '311030087', '311030098', '311030101', '311030112', '311030123',	'311030134', '311030145', '311030156', '311030178', '311030189', '311030225', '311030236', '311030247','311030258', '311030269', 
			                  '311030270', '311030281', '311030292', '311030305', '311040014', '311040025',	'311040036', '311040047', '311040058', '311040069', '311040070', '311040081', '311040138', '311040149','311040150', '311040161', 
			                  '311040207', '311040218', '311040229', '311040230', '311050018', '311050029',	'311050041', '311050063', '311050121', '311050223', '311050245', '311050256', '311050267', '311050278','311050289', '311050290', 
			                  '311050303', '311050314', '311050325', '311050347', '311050369', '311050370',	'311050381', '311060012', '311060023', '311060034', '311060045', '311060067', '311060078', '311070016','311070027', '311070049', 
			                  '311070050', '311070072', '311070083', '311070107', '311070118', '311070129',	'311070130', '311070141', '311070209', '311070210', '311070232', '311070243', '311070254', '311070265','311070276', '311070287', 
			                  '311070298', '311070301', '311070323', '311070334', '311070356', '311070367',	'311070389', '311070390', '311070403', '311070458', '311070481', '311070516', '311070527', '311070538')
			   and custo in ( '111115', '112107', '112118', '112129', '112130', '116121' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			/*SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010012')
			   and custo in ( '111115' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010023')
			   and custo in ( '112107' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010034')
			   and custo in ( '112118' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010045')
			   and custo in ( '112129' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010056')
			   and custo in ( '112130' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in ( '311010067')
			   and custo in ( '116121' )
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]	  
			UNION ALL
			SELECT [dependencia]
				  ,[grupo]
				  ,[processing_yr]
				  ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12] ) TOTAL
			  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
			 where conta in (  '311010078', '311010089', '311010090', '311010114', '311010125', '311010136', '311010158', '311020016','311020027', '311020049', '311020050', '311020061', '311020072', '311020083', '311020094', '311020107',
							'311020118', '311020130', '311020141', '311020185', '311030010', '311030021', '311030032', '311030043','311030054', '311030065', '311030076', '311030087', '311030098', '311030101', '311030112', '311030123',
							'311030134', '311030145', '311030156', '311030178', '311030189', '311030225', '311030236', '311030247','311030258', '311030269', '311030270', '311030281', '311030292', '311030305', '311040014', '311040025',
							'311040036', '311040047', '311040058', '311040069', '311040070', '311040081', '311040138', '311040149','311040150', '311040161', '311040207', '311040218', '311040229', '311040230', '311050018', '311050029',
							'311050041', '311050063', '311050121', '311050223', '311050245', '311050256', '311050267', '311050278','311050289', '311050290', '311050303', '311050314', '311050325', '311050347', '311050369', '311050370',
							'311050381', '311060012', '311060023', '311060034', '311060045', '311060067', '311060078', '311070016','311070027', '311070049', '311070050', '311070072', '311070083', '311070107', '311070118', '311070129',
							'311070130', '311070141', '311070209', '311070210', '311070232', '311070243', '311070254', '311070265','311070276', '311070287', '311070298', '311070301', '311070323', '311070334', '311070356', '311070367',
							'311070389', '311070390', '311070403', '311070458', '311070481', '311070516', '311070527', '311070538')
			   and [processing_yr] > 2011
			 GROUP BY [dependencia]
				  ,[grupo]
				  ,[processing_yr]*/
		) AS DES_TMP
	GROUP BY [dependencia]
		  ,[grupo] 
		  ,[processing_yr] 
	) AS DESPESAS
ON   (RECEITAS.dependencia = DESPESAS.dependencia
  AND	RECEITAS.ano = DESPESAS.ano)


GO

/****** Object:  View [dbo].[gvw_resumo_det_conta_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[gvw_resumo_det_conta_da] as
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'RECEITAS' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,[conta_descp] AS DESC_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'RECEITA%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'OBU' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,[conta_descp] AS DESC_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'OBU%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DESPESAS' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,[conta_descp] AS DESC_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DESPESAS%'
   --AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DEDUCOES' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,[conta_descp] AS DESC_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DEDUCOES%'
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]











GO

/****** Object:  View [dbo].[gvw_resumo_det_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













CREATE VIEW [dbo].[gvw_resumo_det_da] as
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'RECEITAS' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'RECEITA%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'OBU' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'OBU%'
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DESPESAS' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
  FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DESPESAS%'
   --AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
UNION
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,'DEDUCOES' AS GRUPO_CONTA
      ,[sub_grupo] AS SUBGRUPO_CONTA
      ,SUM ( [ldr_amt_1] ) AS REALIZADO_JAN
      ,SUM ( [ldr_amt_2] ) AS REALIZADO_FEV
      ,SUM ( [ldr_amt_3] ) AS REALIZADO_MAR
      ,SUM ( [ldr_amt_4] ) AS REALIZADO_ABR
      ,SUM ( [ldr_amt_5] ) AS REALIZADO_MAI
      ,SUM ( [ldr_amt_6] ) AS REALIZADO_JUN
      ,SUM ( [ldr_amt_7] ) AS REALIZADO_JUL
      ,SUM ( [ldr_amt_8] ) AS REALIZADO_AGO
      ,SUM ( [ldr_amt_9] ) AS REALIZADO_SET
      ,SUM ( [ldr_amt_10]) AS REALIZADO_OUT
      ,SUM ( [ldr_amt_11]) AS REALIZADO_NOV
      ,SUM ( [ldr_amt_12]) AS REALIZADO_DEZ
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10] + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_REALIZADO_ANO
FROM [GEACrpt].[dbo].[gvw_resumo_det_det_da]
WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] IN (   'SBAR','SBBE','SBBG','SBBH','SBBI','SBBR','SBBV','SBCF','SBCG','SBCJ',
													'SBCM','SBCP','SBCR','SBCT','SBCY','SBCZ','SBEG','SBFI','SBFL','SBFZ',
													'SBGL','SBGO','SBGR','SBHT','SBIL','SBIZ','SBJC','SBJP','SBJR','SBJU',
													'SBJV','SBKG','SBKP','SBLO','SBMA','SBME','SBMK','SBMO','SBMQ','SBMT',
													'SBNF','SBNT','SBPA','SBPB','SBPJ','SBPK','SBPL','SBPP','SBPR','SBPV',
													'SBRB','SBRF','SBRJ','SBSJ','SBSL','SBSN','SBSP','SBSV','SBTE','SBTF',
												    'SBTT','SBUF','SBUG','SBUL','SBUP','SBUR','SBVT')  )
   AND [processing_yr] IN ('2011', '2012', '2013', '2014','2015','2016','2017')
   AND [grupo] LIKE 'DEDUCOES%'
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[sub_grupo]
      ,[conta_descp]












GO

/****** Object:  View [dbo].[gvw_resumo_det_det_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*-------------------------------------------------------------------------------------------------------*/
CREATE VIEW [dbo].[gvw_resumo_det_det_da] 
AS
SELECT ldr_entity_id, dependencia, conta, 
	   (select top 1 conta_descp from [GEACrpt].[dbo].[dvw_contas] WITH (nolock) where conta = bal.conta) conta_descp,
	   programa, projeto, custo, processing_yr, amt_class_type, curr_type,
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_0 * - 1 ELSE ldr_amt_0 END AS ldr_amt_0, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_1 * - 1 ELSE ldr_amt_1 END AS ldr_amt_1,
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_2 * - 1 ELSE ldr_amt_2 END AS ldr_amt_2, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_3 * - 1 ELSE ldr_amt_3 END AS ldr_amt_3, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_4 * - 1 ELSE ldr_amt_4 END AS ldr_amt_4, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_5 * - 1 ELSE ldr_amt_5 END AS ldr_amt_5, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_6 * - 1 ELSE ldr_amt_6 END AS ldr_amt_6, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_7 * - 1 ELSE ldr_amt_7 END AS ldr_amt_7, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_8 * - 1 ELSE ldr_amt_8 END AS ldr_amt_8, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_9 * - 1 ELSE ldr_amt_9 END AS ldr_amt_9, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_10 * - 1 ELSE ldr_amt_10 END AS ldr_amt_10, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_11 * - 1 ELSE ldr_amt_11 END AS ldr_amt_11, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_12 * - 1 ELSE ldr_amt_12 END AS ldr_amt_12, 
       CASE WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT LIKE '41402%') THEN ldr_amt_13 * - 1 ELSE ldr_amt_13 END AS ldr_amt_13, 
       CASE WHEN (bal.conta LIKE '3%' AND bal.conta NOT LIKE '313%') THEN 'DESPESAS' 
            WHEN (bal.conta LIKE '313%') THEN 'OBU' 
            WHEN (bal.conta LIKE '4%' AND bal.conta NOT LIKE '41302%' AND bal.conta NOT LIKE '41303%' AND bal.conta NOT IN ('414020012', '414020023')) THEN 'RECEITA BRUTA' 
            WHEN (bal.conta LIKE '41302%' OR bal.conta LIKE '41303%' OR bal.conta = '414020012' OR bal.conta = '414020023') THEN 'DEDUCOES' 
       END AS grupo, 
       CASE WHEN (bal.conta LIKE '31101%')                          THEN 'Pessoal' 
            WHEN (bal.conta LIKE '31102%')                          THEN 'Encargos Diretos com Pessoal' 
            WHEN (bal.conta LIKE '31103%')                          THEN 'Encargos Indiretos com Pessoal' 
            WHEN (bal.conta LIKE '31104%')                          THEN 'Material de Consumo' 
            WHEN (bal.conta LIKE '31105%')                          THEN 'Servicos Contratados e Locacoes' 
            WHEN (bal.conta LIKE '31106%')                          THEN 'Utilidades e Servicos Publicos' 
            WHEN (bal.conta LIKE '31107%')                          THEN 'Despesas Gerais' 
            WHEN (bal.conta LIKE '31113%' AND bal.conta <> '311130026') THEN 'Impostos, Taxas e Contribuicoes' 
            WHEN (bal.conta = '311130026' OR bal.conta LIKE '31402%')   THEN 'Provisao IRPJ e CSLL' 
            WHEN (bal.conta LIKE '31114%')                          THEN 'Depreciacoes e Amortizacoes' 
            WHEN (bal.conta LIKE '31115%' OR bal.conta LIKE '315%' OR bal.conta LIKE '316%' OR 
                  bal.conta LIKE '317%'   OR bal.conta LIKE '32%')      THEN 'Outras' 
            WHEN (bal.conta LIKE '312%')                            THEN 'Financeiras' 
            WHEN (bal.conta LIKE '313%')                            THEN 'OBU' 
            --WHEN (bal.conta LIKE '31401%' OR bal.conta LIKE '31403%' OR bal.conta LIKE '31404%')                         THEN 'Provisão p/Prováveis Perdas' 
            WHEN (bal.conta LIKE '31401%' OR bal.conta LIKE '31403%' 
									  OR bal.conta LIKE '31404%' or bal.conta IN ('314050016','314050027', '314060010', '314060021', '314060032', '314060043', '314070014', 
																		   '314070025', '314080018', '341010054', '314010054', '314010065', '314080029'))  THEN 'Provisão p/Prováveis Perdas'          
            WHEN (bal.conta LIKE '41101%' OR bal.conta LIKE '41102%' OR bal.conta = '413010067' OR bal.conta = '413010078')  THEN 'Pouso' 
            WHEN (bal.conta LIKE '41103%' OR bal.conta LIKE '41104%' OR bal.conta = '413010045' OR bal.conta = '413010056')  THEN 'Permanencia' 
            WHEN (bal.conta LIKE '41105%' OR bal.conta LIKE '41106%' OR bal.conta = '413010216' OR bal.conta = '413010227')  THEN 'Embarque' 
            WHEN (bal.conta LIKE '41107%' OR bal.conta LIKE '41108%' OR bal.conta LIKE '41109%' OR 
                  bal.conta IN ('411150011', '411150022', '411160015', '411160026', '413010330', '413010341', '413010352') OR
                  bal.conta = '413010012' OR bal.conta = '413010023' OR (bal.conta BETWEEN '413010238' AND '413010250')) THEN 'Armazenagem e Capatazia'
            WHEN (bal.conta LIKE '41110%' OR bal.conta LIKE '41111%' OR bal.conta LIKE '41112%' OR bal.conta LIKE '41113%' OR 
                  bal.conta in( '413010409', '413010410', '413010421', '413010432' ) OR
                 (bal.conta BETWEEN '413010090' AND '413010125') )                                               THEN 'Navegacao Aerea'
            WHEN (bal.conta LIKE '41201%' OR bal.conta LIKE '41202%' OR bal.conta LIKE '41203%' OR bal.conta LIKE '41204%' OR bal.conta LIKE '41250%' OR
                  bal.conta IN ('412050045', '413010034', '413010089', '413010454', '413010625', '413010498', '413010534', '413010614',
                            '413010578', '413010603', '413010512', '413010669', '413010556', '413010647', '413010681', '413010705', '412060016',
                            '412060027', '413010772', '413010794') OR
					(bal.conta BETWEEN '413010136' AND '413010205') OR (bal.conta BETWEEN '413010261' AND '413010294')
                 OR (bal.conta BETWEEN '413010454' AND '413010750') OR (bal.conta BETWEEN '311150488' AND '311150762')) THEN 'Comerciais' 
            WHEN ((bal.conta LIKE '41205%' AND bal.conta <> '412050045') OR (bal.conta BETWEEN '413010307' AND '413010329') OR
                   bal.conta IN ('415040016', '415040050', '415040083', '415060014'))                            THEN 'Outros Servicos' 
            WHEN (bal.conta LIKE '41302%' OR bal.conta = '414020012' OR bal.conta = '413021020')                         THEN 'Cofins' 
            WHEN (bal.conta LIKE '41303%' OR bal.conta = '414020023' OR bal.conta = '413031024')                         THEN 'Pasep' 
            WHEN (bal.conta LIKE '414%' AND bal.conta NOT IN ('414020012', '414020023'))                             THEN 'Receitas Financeiras' 
            WHEN (bal.conta LIKE '415%' AND bal.conta NOT IN ('415040016', '415040050', '415040083', '415060014', '415040141', '415040152') OR
                  bal.conta LIKE '416%' OR bal.conta LIKE '42%' 
                  OR bal.conta IN ('413010385', '413010396', '415040163', '415040174'))							 THEN 'Eventuais' 
            WHEN (bal.conta IN ('415040141', '415040152'))                                                       THEN 'Recuperação de despesas' 
            WHEN (bal.conta IN ('318010014', '318020018', '318010028'))                                          THEN 'Participação dos empregados no lucro(PLR)' 
            WHEN (bal.conta IN ('411170019', '411170020', '411180013', '411180024', '413010374', '413010363'))   THEN 'Conexão' 
       END AS sub_grupo
FROM   DBSglep.dbo.ldr_acct_bal bal WITH (nolock)
WHERE  (ldr_entity_id = 'INFRA') AND (bal.conta LIKE '3%' AND bal.conta NOT LIKE '33%' AND bal.conta NOT LIKE '34%' AND bal.conta NOT LIKE '39%' OR
        bal.conta LIKE '4%' AND bal.conta NOT LIKE '41304%' AND bal.conta NOT LIKE '41305%' AND bal.conta NOT LIKE '49%') AND (amt_class_type = 'ACTUAL') AND (curr_type = 'E1')



GO

/****** Object:  View [dbo].[gvw_resumo_det_rank_2_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[gvw_resumo_det_rank_2_da]
as
SELECT	SIGLA_DEP
	 ,	ANO
	 ,	DESC_CONTA
	 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(SUM_REALIZADO_ANO) DESC)
		   WHEN 1 THEN DESC_CONTA
		   WHEN 2 THEN DESC_CONTA
		   WHEN 3 THEN DESC_CONTA
		   WHEN 4 THEN DESC_CONTA
		   WHEN 5 THEN DESC_CONTA
		   ELSE 'OUTROS'
		END DESC_CONTA_RANK_TOP5
	 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(SUM_REALIZADO_ANO) DESC) AS RANK
	 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(SUM_REALIZADO_ANO) DESC)
		   WHEN 1 THEN 1
		   WHEN 2 THEN 2
		   WHEN 3 THEN 3
		   WHEN 4 THEN 4
		   WHEN 5 THEN 5
		   ELSE 6
				END RANK_TOP5
	 ,	SUM(SUM_REALIZADO_ANO) SUM_REALIZADO_ANO
FROM (
	SELECT	SIGLA_DEP
		 ,	ANO
		 ,	CASE DESC_CONTA
				WHEN 'ADICIONAL DE TRANSFERÊNCIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL NOTURNO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL POR TEMPO DE SERVICO' THEN 'EFETIVO/PESSOAL'
				WHEN 'AJUDA DE CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'FUNÇÃO GRATIFICADA' THEN 'EFETIVO/PESSOAL'
				WHEN 'HONORÁRIOS DA DIRETORIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'HORAS EXTRAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'OUTROS ADICIONAIS' THEN 'EFETIVO/PESSOAL'
				WHEN 'REMUNERAÇÃO GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'SALÁRIOS' THEN 'EFETIVO/PESSOAL'
				WHEN 'LICENÇA PRÊMIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'REMUNERAÇÃO DE CONSELHEIROS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PESSOAL GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'PESSOAL GLOBAL INCORP' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL DE INSALUBRIDADE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL DE PERICULOSIDADE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL POR FORMAÇÃO ACADÊMICA' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL DE TRANSFERÊNCIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL NOTURNO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL POR TEMPO DE SERVICO' THEN 'EFETIVO/PESSOAL'
				WHEN 'AJUDA DE CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'FUNÇÃO GRATIFICADA' THEN 'EFETIVO/PESSOAL'
				WHEN 'HONORÁRIOS DA DIRETORIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'HORAS EXTRAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'OUTROS ADICIONAIS' THEN 'EFETIVO/PESSOAL'
				WHEN 'REMUNERAÇÃO GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'SALÁRIOS' THEN 'EFETIVO/PESSOAL'
				WHEN 'LICENÇA PRÊMIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'REMUNERAÇÃO DE CONSELHEIROS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PESSOAL GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'PESSOAL GLOBAL INCORP' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL DE INSALUBRIDADE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL DE PERICULOSIDADE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ADICIONAL POR FORMAÇÃO ACADÊMICA' THEN 'EFETIVO/PESSOAL'
				WHEN '13º  SALÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ABONO PECUNIÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INFRAPREV' THEN 'EFETIVO/PESSOAL'
				WHEN 'AVISO PRÊVIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS SOBRE 13º SALÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS SOBRE FÉRIAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'FÉRIAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'FGTS' THEN 'EFETIVO/PESSOAL'
				WHEN 'INSS' THEN 'EFETIVO/PESSOAL'
				WHEN 'SALÁRIO EDUCAÇÃO' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE ACIDENTE DO TRABALHO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC DIRETOS C/PESSOAL GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC DIRETOS C/PESSOAL GLOBAL INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS DIRETOS C/ PESSOAL REQUISITADO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO SENTENÇA TRABALHISTA' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO - 40% FGTS' THEN 'EFETIVO/PESSOAL'
				WHEN 'INCENTIVO FINANCEIRO - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'AVISO PRÉVIO - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO - 40% FGTS - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'LICENÇA MATERNIDADE - PRORROGAÇÃO' THEN 'EFETIVO/PESSOAL'
				WHEN '13º  SALÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ABONO PECUNIÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INFRAPREV' THEN 'EFETIVO/PESSOAL'
				WHEN 'AVISO PRÊVIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS SOBRE 13º SALÁRIO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS SOBRE FÉRIAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'FÉRIAS' THEN 'EFETIVO/PESSOAL'
				WHEN 'FGTS' THEN 'EFETIVO/PESSOAL'
				WHEN 'INSS' THEN 'EFETIVO/PESSOAL'
				WHEN 'SALÁRIO EDUCAÇÃO' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE ACIDENTE DO TRABALHO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC DIRETOS C/PESSOAL GLOBAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC DIRETOS C/PESSOAL GLOBAL INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENCARGOS DIRETOS C/ PESSOAL REQUISITADO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO SENTENÇA TRABALHISTA' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO - 40% FGTS' THEN 'EFETIVO/PESSOAL'
				WHEN 'INCENTIVO FINANCEIRO - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'AVISO PRÉVIO - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'INDENIZAÇÃO - 40% FGTS - PDVI' THEN 'EFETIVO/PESSOAL'
				WHEN 'LICENÇA MATERNIDADE - PRORROGAÇÃO' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL EXC PR F PROF' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL PR FORM PROF' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL EXC PFP INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO CRECHE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL COM PFP INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE VIDA EM GRUPO-PART.EMPREGADO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PAT-REFEIÇÕES PRONTAS' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAT - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGR ASSIST MED HOSP COMPL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAMHC - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROG.ASSIST.ODONT-SERV.ODONTOLÓGICO' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAO - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA DE VALE-TRANSPORTE - ÔNIBUS URBANO (PVTOU' THEN 'EFETIVO/PESSOAL'
				WHEN 'PDVI - PROGR ASSIST MED HOSP COMPL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PDVI - PAMHC - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PVTOU - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE VIDA EM GRUPO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - AQUISIÇÃO PASSAGENS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - CURSOS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - DIÁRIAS E HOSPEDAGENS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - MATERIAIS DE CONSUMO' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO FUNERAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'CESTA BÁSICA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - AJUDA DE CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - GRATIFICAÇÃO DE INSTRUTORIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO MATERIAL ESCOLAR' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - LANCHES E REFEIÇÕES' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - REPROGRAFIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA DE VALE-TRANSPORTE - ÔNIBUS FRETADO (PVTO' THEN 'EFETIVO/PESSOAL'
				WHEN '(-) PVTOF - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INFRAPREV' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA QUALIDADE DE VIDA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA AUXÍLIO COMBUSTÍVEL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PROGRAMA AUXÍLIO COMBUSTÍVEL - PART. TRAB. C' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO FARMÁCIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'DESPESA DE MUDANÇA COM TRANSFERENCIA DE EMPREGADO ' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL EXC PR F PROF' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL PR FORM PROF' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL EXC PFP INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO CRECHE' THEN 'EFETIVO/PESSOAL'
				WHEN 'ENC IND C/PESS GLOBAL COM PFP INC.' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE VIDA EM GRUPO-PART.EMPREGADO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PAT-REFEIÇÕES PRONTAS' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAT - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGR ASSIST MED HOSP COMPL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAMHC - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROG.ASSIST.ODONT-SERV.ODONTOLÓGICO' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PAO - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA DE VALE-TRANSPORTE - ÔNIBUS URBANO (PVTOU' THEN 'EFETIVO/PESSOAL'
				WHEN 'PDVI - PROGR ASSIST MED HOSP COMPL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PDVI - PAMHC - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PVTOU - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'SEGURO DE VIDA EM GRUPO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - AQUISIÇÃO PASSAGENS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - CURSOS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - DIÁRIAS E HOSPEDAGENS' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - MATERIAIS DE CONSUMO' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO FUNERAL' THEN 'EFETIVO/PESSOAL'
				WHEN 'CESTA BÁSICA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - AJUDA DE CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - GRATIFICAÇÃO DE INSTRUTORIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO MATERIAL ESCOLAR' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - LANCHES E REFEIÇÕES' THEN 'EFETIVO/PESSOAL'
				WHEN 'PFP - REPROGRAFIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA DE VALE-TRANSPORTE - ÔNIBUS FRETADO (PVTO' THEN 'EFETIVO/PESSOAL'
				WHEN '(-) PVTOF - PARTIC.TRABALHADOR CUSTO' THEN 'EFETIVO/PESSOAL'
				WHEN 'INFRAPREV' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA QUALIDADE DE VIDA' THEN 'EFETIVO/PESSOAL'
				WHEN 'PROGRAMA AUXÍLIO COMBUSTÍVEL' THEN 'EFETIVO/PESSOAL'
				WHEN '( - ) PROGRAMA AUXÍLIO COMBUSTÍVEL - PART. TRAB. C' THEN 'EFETIVO/PESSOAL'
				WHEN 'AUXÍLIO FARMÁCIA' THEN 'EFETIVO/PESSOAL'
				WHEN 'DESPESA DE MUDANÇA COM TRANSFERENCIA DE EMPREGADO ' THEN 'EFETIVO/PESSOAL'
				ELSE DESC_CONTA
			END DESC_CONTA
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA) AS TMP
GROUP
   BY	SIGLA_DEP
	 ,	ANO
	 ,	DESC_CONTA


/*
	 ,	ANO
		 ,	DESC_CONTA
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	   --AND  SUBGRUPO_CONTA IN ('Pessoal', 'Material de Consumo', 'Servicos Contratados e Locacoes', 'Utilidades e Servicos Publicos', 'Despesas Gerais')
	   --AND  DESC_CONTA NOT IN ('FUNÇÃO GRATIFICADA', 'REMUNERAÇÃO GLOBAL', 'ADICIONAL POR TEMPO DE SERVICO', 'ADICIONAL DE PERICULOSIDADE', 'ADICIONAL POR FORMAÇÃO ACADÊMICA')
	   --AND	ANO = YEAR(GETDATE())
	   --AND  SIGLA_DEP = 'SBBG' --
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  
	--HAVING  SUM(TOTAL_REALIZADO_ANO) > 0
*/


GO

/****** Object:  View [dbo].[gvw_resumo_det_rank_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[gvw_resumo_det_rank_da]
as
	SELECT	SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN DESC_CONTA
		       WHEN 2 THEN DESC_CONTA
		       WHEN 3 THEN DESC_CONTA
		       WHEN 4 THEN DESC_CONTA
		       WHEN 5 THEN DESC_CONTA
		       ELSE 'OUTROS'
		    END DESC_CONTA_RANK_TOP5
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN 1
		       WHEN 2 THEN 2
		       WHEN 3 THEN 3
		       WHEN 4 THEN 4
		       WHEN 5 THEN 5
		       ELSE 6
		    END RANK_TOP5
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  



/*
	 ,	ANO
		 ,	DESC_CONTA
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	   --AND  SUBGRUPO_CONTA IN ('Pessoal', 'Material de Consumo', 'Servicos Contratados e Locacoes', 'Utilidades e Servicos Publicos', 'Despesas Gerais')
	   --AND  DESC_CONTA NOT IN ('FUNÇÃO GRATIFICADA', 'REMUNERAÇÃO GLOBAL', 'ADICIONAL POR TEMPO DE SERVICO', 'ADICIONAL DE PERICULOSIDADE', 'ADICIONAL POR FORMAÇÃO ACADÊMICA')
	   --AND	ANO = YEAR(GETDATE())
	   --AND  SIGLA_DEP = 'SBBG' --
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  
	--HAVING  SUM(TOTAL_REALIZADO_ANO) > 0
*/

GO

/****** Object:  View [dbo].[gvw_resumo_det_rank_mes_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[gvw_resumo_det_rank_mes_da]
as
	SELECT	SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN DESC_CONTA
		       WHEN 2 THEN DESC_CONTA
		       WHEN 3 THEN DESC_CONTA
		       WHEN 4 THEN DESC_CONTA
		       WHEN 5 THEN DESC_CONTA
		       ELSE 'OUTROS'
		    END DESC_CONTA_RANK_TOP5
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN 1
		       WHEN 2 THEN 2
		       WHEN 3 THEN 3
		       WHEN 4 THEN 4
		       WHEN 5 THEN 5
		       ELSE 6
		    END RANK_TOP5
		 ,	SUM(REALIZADO_JAN) AS SUM_REALIZADO_JAN
		 ,	SUM(REALIZADO_FEV) AS SUM_REALIZADO_FEV
		 ,	SUM(REALIZADO_MAR) AS SUM_REALIZADO_MAR
		 ,	SUM(REALIZADO_ABR) AS SUM_REALIZADO_ABR
		 ,	SUM(REALIZADO_MAI) AS SUM_REALIZADO_MAI
		 ,	SUM(REALIZADO_JUN) AS SUM_REALIZADO_JUN
		 ,	SUM(REALIZADO_JUL) AS SUM_REALIZADO_JUL
		 ,	SUM(REALIZADO_AGO) AS SUM_REALIZADO_AGO
		 ,	SUM(REALIZADO_SET) AS SUM_REALIZADO_SET
		 ,	SUM(REALIZADO_OUT) AS SUM_REALIZADO_OUT
		 ,	SUM(REALIZADO_NOV) AS SUM_REALIZADO_NOV
		 ,	SUM(REALIZADO_DEZ) AS SUM_REALIZADO_DEZ   
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  



/*
	 ,	ANO
		 ,	DESC_CONTA
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	   --AND  SUBGRUPO_CONTA IN ('Pessoal', 'Material de Consumo', 'Servicos Contratados e Locacoes', 'Utilidades e Servicos Publicos', 'Despesas Gerais')
	   --AND  DESC_CONTA NOT IN ('FUNÇÃO GRATIFICADA', 'REMUNERAÇÃO GLOBAL', 'ADICIONAL POR TEMPO DE SERVICO', 'ADICIONAL DE PERICULOSIDADE', 'ADICIONAL POR FORMAÇÃO ACADÊMICA')
	   --AND	ANO = YEAR(GETDATE())
	   --AND  SIGLA_DEP = 'SBBG' --
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  
	--HAVING  SUM(TOTAL_REALIZADO_ANO) > 0
*/


GO

/****** Object:  View [dbo].[gvw_resumo_det_rank_receitas_da]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[gvw_resumo_det_rank_receitas_da]
as
	SELECT	SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN DESC_CONTA
		       WHEN 2 THEN DESC_CONTA
		       WHEN 3 THEN DESC_CONTA
		       WHEN 4 THEN DESC_CONTA
		       WHEN 5 THEN DESC_CONTA
		       ELSE 'OUTROS'
		    END DESC_CONTA_RANK_TOP5
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN 1
		       WHEN 2 THEN 2
		       WHEN 3 THEN 3
		       WHEN 4 THEN 4
		       WHEN 5 THEN 5
		       ELSE 6
		    END RANK_TOP5
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'RECEITAS'
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  



/*
	 ,	ANO
		 ,	DESC_CONTA
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	   --AND  SUBGRUPO_CONTA IN ('Pessoal', 'Material de Consumo', 'Servicos Contratados e Locacoes', 'Utilidades e Servicos Publicos', 'Despesas Gerais')
	   --AND  DESC_CONTA NOT IN ('FUNÇÃO GRATIFICADA', 'REMUNERAÇÃO GLOBAL', 'ADICIONAL POR TEMPO DE SERVICO', 'ADICIONAL DE PERICULOSIDADE', 'ADICIONAL POR FORMAÇÃO ACADÊMICA')
	   --AND	ANO = YEAR(GETDATE())
	   --AND  SIGLA_DEP = 'SBBG' --
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  
	--HAVING  SUM(TOTAL_REALIZADO_ANO) > 0
*/



GO

/****** Object:  View [dbo].[gvw_resumo_det_rank_receitas_da_2]    Script Date: 04/02/2015 13:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[gvw_resumo_det_rank_receitas_da_2] as
	SELECT	SIGLA_DEP
		 ,	ANO
		 ,	UPPER(SUBGRUPO_CONTA) AS SUBGRUPO_CONTA
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN UPPER(SUBGRUPO_CONTA)
		       WHEN 2 THEN UPPER(SUBGRUPO_CONTA)
		       WHEN 3 THEN UPPER(SUBGRUPO_CONTA)
		       WHEN 4 THEN UPPER(SUBGRUPO_CONTA)
		       WHEN 5 THEN UPPER(SUBGRUPO_CONTA)
		       ELSE 'OUTROS'
		    END SUBGRUPO_CONTA_RANK_TOP5
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	CASE RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC)
		       WHEN 1 THEN 1
		       WHEN 2 THEN 2
		       WHEN 3 THEN 3
		       WHEN 4 THEN 4
		       WHEN 5 THEN 5
		       ELSE 6
		    END RANK_TOP5
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'RECEITAS'
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	SUBGRUPO_CONTA  



/*
	 ,	ANO
		 ,	DESC_CONTA
		 ,  RANK() OVER (PARTITION BY SIGLA_DEP, ANO ORDER BY SUM(TOTAL_REALIZADO_ANO) DESC) AS RANK
		 ,	SUM(TOTAL_REALIZADO_ANO) AS SUM_REALIZADO_ANO
	  FROM	gvw_resumo_det_conta_da WITH (nolock) 
	 WHERE	GRUPO_CONTA = 'DESPESAS'
	   --AND  SUBGRUPO_CONTA IN ('Pessoal', 'Material de Consumo', 'Servicos Contratados e Locacoes', 'Utilidades e Servicos Publicos', 'Despesas Gerais')
	   --AND  DESC_CONTA NOT IN ('FUNÇÃO GRATIFICADA', 'REMUNERAÇÃO GLOBAL', 'ADICIONAL POR TEMPO DE SERVICO', 'ADICIONAL DE PERICULOSIDADE', 'ADICIONAL POR FORMAÇÃO ACADÊMICA')
	   --AND	ANO = YEAR(GETDATE())
	   --AND  SIGLA_DEP = 'SBBG' --
	 GROUP
		BY  SIGLA_DEP
		 ,	ANO
		 ,	DESC_CONTA  
	--HAVING  SUM(TOTAL_REALIZADO_ANO) > 0
*/



GO

