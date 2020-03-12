--CARGA TABELA AUXILIAR. BUSCAR NO ORACLE (INET).
SELECT    aer_cod AS COD_DEPENDENCIA, 
          TO_CHAR( data_recebimento, 'RRRR') AS ANO_REFERENCIA, 
          TO_CHAR( data_recebimento, 'MM') AS MES_REFERENCIA, 
          SUM (peso) / 1000 AS PES_CARGA 
FROM      viw_tempo_medio_recebimento 
WHERE     data_recebimento > TO_DATE('31/12/2011','DD/MM/RRRR')
GROUP BY  aer_cod 
       ,  TO_CHAR( data_recebimento, 'RRRR')
       ,  TO_CHAR( data_recebimento, 'MM')


--TEM QUE EXTRAIR DO ORACLE E COLAR NO SQL SERVE...

BEGIN TRAN

DELETE
  FROM [DM_DA].[dbo].[AUX_DADOS_CARGA_TECA]


Insert into DM_DA].[dbo].AUX_DADOS_CARGA_TECA (COD_DEPENDENCIA,ANO_REFERENCIA,MES_REFERENCIA,PES_CARGA) values ('013','2012','11',3544.7201026);                  


COMMIT TRAN



--CARGA TABELA PRINCIPAL...
BEGIN TRAN

DELETE FROM  [DM_DA].[dbo].[TAB_TECA_PESO_ANO]

INSERT INTO [DM_DA].[dbo].[TAB_TECA_PESO_ANO]
SELECT TOP 2000 [COD_DEPENDENCIA] AS COD_AEROPORTO
      ,(SELECT top 1 sgl_aeroporto FROM [DM_DA].[dbo].[TAB_TECA_PESO_ANO_bkp] WHERE cod_aeroporto = [COD_DEPENDENCIA]) as sgl_aeroporto
      ,[ANO_REFERENCIA] AS ANO_RECEBIMENTO
      ,[MES_REFERENCIA] AS MES_RECEBIMENTO
      ,[PES_CARGA] as PESO_TOTAL
  FROM [DM_DA].[dbo].[AUX_DADOS_CARGA_TECA]

COMMIT TRAN

/*=====================================================================================*/

/*=====================================================================================*/

--CARGA DE DADOS DA TABELA ATUALIZA_TECAMANAGER
BEGIN TRY
	BEGIN TRAN ATUALIZA_TECAMANAGER

	--DELETA DADOS RESUMIDOS
	DELETE FROM  [DM_DA].[dbo].[TAB_TECA_PESO_ANO]

	--DELETE DADOS MIGRADOS DO TECAMANAGER
	DELETE FROM DM_DA.[dbo].[AUX_DADOS_CARGA_TECA]
	
	--INSERE DADOS MIGRADOS DO TECAMANAGER
	INSERT INTO DM_DA.[dbo].[AUX_DADOS_CARGA_TECA]
	SELECT	COD_DEPENDENCIA,
			ANO_REFERENCIA,
			MES_REFERENCIA,
			REPLACE(PES_CARGA,',','.') PESO
	FROM OPENQUERY(TECAMANAGER, '
	SELECT    aer_cod AS COD_DEPENDENCIA, 
			  TO_CHAR( data_recebimento, ''RRRR'') AS ANO_REFERENCIA, 
			  TO_CHAR( data_recebimento, ''MM'') AS MES_REFERENCIA, 
			  SUM (peso) / 1000 AS PES_CARGA 
	FROM      IFRTECABC.VIW_TEMPO_MEDIO_RECEBIMENTO
	WHERE     data_recebimento > TO_DATE(''31/12/2011'',''DD/MM/RRRR'')
	GROUP BY  aer_cod 
		   ,  TO_CHAR( data_recebimento, ''RRRR'')
		   ,  TO_CHAR( data_recebimento, ''MM'')' )

	
	--CONSOLIDA AS INFORMAÇÕES
	INSERT INTO [DM_DA].[dbo].[TAB_TECA_PESO_ANO]
	SELECT [COD_DEPENDENCIA] AS COD_AEROPORTO
		  ,(SELECT top 1 [sig_aeroporto] FROM [IFRCORP].[dbo].[AEROPORTO_SS] WHERE cod_aeroporto = [COD_DEPENDENCIA]) as sgl_aeroporto
		  ,[ANO_REFERENCIA] AS ANO_RECEBIMENTO
		  ,[MES_REFERENCIA] AS MES_RECEBIMENTO
		  ,[PES_CARGA] as PESO_TOTAL
	  FROM [DM_DA].[dbo].[AUX_DADOS_CARGA_TECA]

	--CONFIRMA MUDANÇA
	COMMIT TRAN ATUALIZA_TECAMANAGER
END TRY
BEGIN CATCH
	ROLLBACK TRAN ATUALIZA_TECAMANAGER
END CATCH

/*=====================================================================================*/

/*=====================================================================================*/
