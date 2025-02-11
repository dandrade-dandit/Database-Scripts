/****** Script for SelectTopNRows command from SSMS  ******/
SELECT	TOP 1000 --*
     	MES_VOO
     ,  DIA_VOO
     ,  DATEPART(HOUR, DATA_HORA_VOO) HORA_LEITURA
     ,  COUNT(1) 
  FROM	[GEACupax].[dbo].[viw_pax_coletados2] with (nolock)
 WHERE	MES_VOO = '06'
   --AND  DIA_VOO = '01'
   --AND  CONVERT(VARCHAR(10), DATA_HORA_VOO, 108) BETWEEN '19:00:01' AND '19:15:00'
 GROUP
    BY  MES_VOO
     ,  DIA_VOO
     ,  DATEPART(HOUR, DATA_HORA_VOO) 
 ORDER
    BY  2, 3