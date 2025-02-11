USE GEACrpt
go


--****

USE GEACrpt
go

SELECT [dependencia]
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS sigla_dep
      ,[conta]
      ,CASE [conta]
          WHEN '311060012' THEN 'ÁGUA E ESGOTO'
          WHEN '311060023' THEN 'ENERGIA ELÉTRICA'
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


--******

SELECT TOP 1000 --5501646
       [ldr_entity_id]
      ,[dependencia]
      ,[conta]
      ,[programa]
      ,[projeto]
      ,[custo]
      ,[udak_surr_key]
      ,[processing_yr]
      ,[amt_class_type]
      ,[curr_type]
      ,[curr_code]
      ,[equiv_curr_code]
      ,[dr_cr_code]
      ,[date_created]
      ,[date_last_maintained]
      ,[date_last_posted]
      ,[ldr_amt_0]
      ,[ldr_amt_1]
      ,[ldr_amt_2]
      ,[ldr_amt_3]
      ,[ldr_amt_4]
      ,[ldr_amt_5]
      ,[ldr_amt_6]
      ,[ldr_amt_7]
      ,[ldr_amt_8]
      ,[ldr_amt_9]
      ,[ldr_amt_10]
      ,[ldr_amt_11]
      ,[ldr_amt_12]
      ,[ldr_amt_13]
      ,[chgstamp]
      ,[bal_id]
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   /*AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )*/
   AND [processing_yr] IN ('2011', '2012', '2013', '2014')
   
   
/*
--DEPENDENCIAS
SELECT [cd_aerop] 
	  ,[no_aerop] 
	  ,[recv_entity_id] 
	  ,[cd_regional] 
	  ,[cd_aerop_num]
	  ,[date_created] 
	  ,[user_id_created]
	  ,[date_changed]
	  ,[user_id_changed]
	  ,[inactive_ind]
	  ,[active_date]
	  ,[chgstamp] 
 FROM GEACutcx.dbo.cor_aeroporto_u

--CONTAS
SELECT TOP 1000 [grupo1]
      ,[grupo1_descp]
      ,[grupo2]
      ,[grupo2_descp]
      ,[grupo3]
      ,[grupo3_descp]
      ,[grupo4]
      ,[grupo4_descp]
      ,[conta]
      ,[conta_descp]
      ,[status]
      ,[ENABLED]
  FROM [GEACrpt].[dbo].[dvw_contas]
 WHERE conta = '120010028'
 
 
 --VALOR ORÇADO NO ANO E MES
 SELECT dependencia
     , conta
     , processing_yr
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10) orçado_out_2014	
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10 + ldr_amt_11 + ldr_amt_12) orçado_2014	
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )
   AND [processing_yr] IN ('2014') --'2011', '2012', '2013', '2014')
   AND conta = '311060034'
   AND curr_type = 'T'
   --AND dr_cr_code = 'D'
   AND amt_class_type = 'GESTOR'
GROUP BY
      dependencia
     , conta
     , processing_yr


--VALOR REALIZADO NO ANO
SELECT dependencia
     , conta
     , processing_yr
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10) orçado_out_2014	
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10 + ldr_amt_11 + ldr_amt_12) orçado_2014	
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )
   AND [processing_yr] IN ('2014') --'2011', '2012', '2013', '2014')
   AND conta = '311060034'
   AND curr_type = 'T'
   AND amt_class_type = 'ACTUAL'
GROUP BY
      dependencia
     , conta
     , processing_yr


--VALOR ORÇADO E REALIZADO
SELECT dependencia
     , conta
     , processing_yr
     , amt_class_type
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10) orçado_out_2013	
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10 + ldr_amt_11 + ldr_amt_12) orçado_2013	
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )
   AND [processing_yr] IN ('2014') --'2011', '2012', '2013', '2014')
   AND conta = '311060067'
   AND curr_type = 'T'
   --AND dr_cr_code = 'D'
   --AND amt_class_type = 'ACTUAL'
GROUP BY
      dependencia
     , conta
     , processing_yr
     , amt_class_type

---
SELECT dependencia
     --, conta
     , processing_yr
     , amt_class_type
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10) orçado_out_2013	
     , SUM(ldr_amt_1 + ldr_amt_2 + ldr_amt_3 + ldr_amt_4 + ldr_amt_5 + ldr_amt_6 + ldr_amt_7 + ldr_amt_8 + ldr_amt_9 + ldr_amt_10 + ldr_amt_11 + ldr_amt_12) orçado_2013	
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal] WITH (NOLOCK)
 WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )
   AND [processing_yr] IN ('2012') --'2011', '2012', '2013', '2014')
   --AND conta IN ('211070018')
   AND curr_type = 'T'
   --AND dr_cr_code = 'C'
   --AND amt_class_type = 'ACTUAL'
GROUP BY
      dependencia
     --, conta
     , processing_yr
     , amt_class_type


--*************************************
--REALIZADO
--*************************************
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dependencia]
      ,[processing_yr]
      ,[grupo]
      --,[sub_grupo]
      ,SUM ( [ldr_amt_1] + [ldr_amt_2] + [ldr_amt_3] + [ldr_amt_4] + [ldr_amt_5] + [ldr_amt_6] + [ldr_amt_7] + [ldr_amt_8] + [ldr_amt_9] + [ldr_amt_10])-- + [ldr_amt_11] + [ldr_amt_12]) AS TOTAL_ATE_O_MES
  FROM [GEACrpt].[dbo].[gvw_ldr_acct_bal_dre_gerencial]
  WHERE [ldr_entity_id] = 'INFRA'
   AND [dependencia] IN ( SELECT [cd_aerop_num]
							FROM GEACutcx.dbo.cor_aeroporto_u
							WHERE [cd_aerop] = 'SBCZ' )
   AND [processing_yr] IN ('2014') --'2011', '2012', '2013', '2014')
   --AND [grupo] IN ( 'DESPESAS', 'DEDUCOES')
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[grupo]
      --,[sub_grupo]
  ORDER BY 3


--****************************************************
--CONSULTA PARA GERAR EXCEL...
--****************************************************
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dependencia] AS DEP
      ,(SELECT TOP 1 a.[cd_aerop] FROM GEACutcx.dbo.cor_aeroporto_u a WHERE a.[cd_aerop_num] = [dependencia]) AS SIGLA_DEP
      ,[processing_yr] AS ANO
      ,[grupo] AS GRUPO_CONTA
      --,[sub_grupo]
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
   AND [processing_yr] IN ('2011', '2012', '2013', '2014')
   --AND [grupo] IN ( 'DESPESAS', 'DEDUCOES')
   AND sub_grupo NOT IN ('Depreciacoes e Amortizacoes', 'Provisão p/Prováveis Perdas')
  GROUP BY [dependencia]
      ,[processing_yr]
      ,[grupo]
      --,[sub_grupo]
  ORDER BY 1, 3, 4
*/