/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 'Data Source=[' + [dsc_enderenco_ip] + '];Initial Catalog=INTEGRACAO;Persist Security Info=True;User ID=siso_carga;Pwd=X275siso@Z;Auto Translate=False;' as ConnectionString
  FROM [BIOGER].[dbo].[BIOGER_SERVERS_SISO]
 WHERE sta_srv_primario = 1
   AND sig_aeroporto = 'SBAR'
   
   
   --Data Source=[s-arsn01\prdsbar01];Initial Catalog=INTEGRACAO;Persist Security Info=True;User ID=siso_carga;Pwd=X275siso@Z;Auto Translate=False;