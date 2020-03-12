X275siso@Z

SELECT	*
INTO		BKP_BIOGER_RPE_DES
FROM		BIOGER.dbo.BIOGER_RPE_DES    


SELECT	*
INTO		BKP_BIOGER_RPE_EMB
FROM 	BIOGER.dbo.BIOGER_RPE_EMB   


SELECT	*
INTO		BKP_BIOGER_RPE_MOV
FROM 		BIOGER.dbo.BIOGER_RPE_MOV  


-******************************************************************************************


TRUNCATE TABLE BIOGER_RPE_DES

INSERT INTO BIOGER.dbo.BIOGER_RPE_DES
SELECT SIGLA_AEROPORTO           AS SIGLA_AEROPORTO                                     
      ,NR_CHG_VOO                AS NUMERO_VOO                                        
      ,DH_CHG_NRM                AS DATA_HORA_NORMAL_POUSO                            
      ,DH_CHG_EFE                AS DATA_HORA_EFETIVA_POUSO                           
      ,CD_COM                    AS CD_COM                                            
      ,SG_COM_IAT_003            AS SIGLA_IATA_CIA_AEREA                              
      ,NR_AEN                    AS MATRICULA_AERONAVE                                
      ,TP_CHG_GRU                AS GRUPO_VOO                                         
      ,TP_CHG_NAT                AS NATUREZA_VOO                                      
      ,TP_CHG                    AS CLASSE_VOO                                        
      ,TP_CHG_CTG                AS CATEGORIA_VOO                                     
      ,TP_CHG_CTG_VIN            AS CATEGORIA_VOO_VINCULADO                           
      ,SG_EQP                    AS SIGLA_EQUIPAMENTO                                 
      ,QT_DEC_DES_DOM            AS DESEMB_PASSAGEIRO_DOM                             
      ,QT_DEC_DES_INT            AS DESEMB_PASSAGEIRO_INT                             
      ,QT_DEC_DES_BAG_DOM        AS DESEMB_BAGAGEM_DOM                                
      ,QT_DEC_DES_BAG_INT        AS DESEMB_BAGAGEM_INT                                
      ,QT_DEC_DES_CAR_DOM        AS DESEMB_CARGA_DOM                                  
      ,QT_DEC_DES_CAR_INT        AS DESEMB_CARGA_INT                                  
      ,QT_DEC_DES_COR_DOM        AS DESEMB_CORREIO_DOM                                
      ,QT_DEC_DES_COR_INT        AS DESEMB_CORREIO_INT                                
      ,QT_DEC_TRA_BAG_DOM        AS TRANSITO_BAGAGEM_DOM                              
      ,QT_DEC_TRA_BAG_INT        AS TRANSITO_BAGAGEM_INT                              
      ,QT_DEC_TRA_CAR_DOM        AS TRANSITO_CARGA_DOM                                
      ,QT_DEC_TRA_CAR_INT        AS TRANSITO_CARGA_INT                                
      ,QT_DEC_TRA_COR_DOM        AS TRANSITO_CORREIO_DOM                              
      ,QT_DEC_TRA_COR_INT        AS TRANSITO_CORREIO_INT                              
      ,QT_DEC_TRA_DOM_CX         AS TRANSITO_CONEXAO_DOM                              
      ,QT_DEC_TRA_INT_CX         AS TRANSITO_CONEXAO_INT                              
      ,CD_CHG                    AS COD_CHG_VOO                                       
      ,CD_CHG_VIN                AS DES_VIN                                           
      ,NR_BOX                    AS NR_BOX                                            
      ,TP_BOX                    AS TP_BOX                                            
      ,SIGLA_AEROPORTO_PRO       AS SIGLA_AEROPORTO_PRO                               
      ,FL_AEN_TAX                AS FL_AEN_TAX                                        
      ,FL_EQP_HLC                AS FL_EQP_HLC                                        
      ,CD_STA                    AS CD_STA                                            
      ,NOME_CIA                  AS NME_CIA_AEREA                                     
      ,NM_EQP                    AS NME_EQUIPAMENTO                                   
      ,PIS_PO                    AS DSC_PISTA_POU                                     
      ,PIS_DE                    AS DSC_PISTA_DEC                                     
			,5                         AS FLG_MIGRADO                  			                
			,getdate()                 AS DTA_MIGRACAO                                      
FROM 	BIOGER.dbo.INTEGRACAO_SISO_BIOGER_DES

INSERT INTO BIOGER.dbo.BIOGER_RPE_DES
SELECT [SIGLA_AEROPORTO]
      ,[NUMERO_VOO]
      ,[DATA_HORA_NORMAL_POUSO]
      ,[DATA_HORA_EFETIVA_POUSO]
      ,[CD_COM]
      ,[SIGLA_IATA_CIA_AEREA]
      ,[MATRICULA_AERONAVE]
      ,[GRUPO_VOO]
      ,[NATUREZA_VOO]
      ,[CLASSE_VOO]
      ,[CATEGORIA_VOO]
      ,[CATEGORIA_VOO_VINCULADO]
      ,[SIGLA_EQUIPAMENTO]
      ,[DESEMB_PASSAGEIRO_DOM]
      ,[DESEMB_PASSAGEIRO_INT]
      ,[DESEMB_BAGAGEM_DOM]
      ,[DESEMB_BAGAGEM_INT]
      ,[DESEMB_CARGA_DOM]
      ,[DESEMB_CARGA_INT]
      ,[DESEMB_CORREIO_DOM]
      ,[DESEMB_CORREIO_INT]
      ,[TRANSITO_BAGAGEM_DOM]
      ,[TRANSITO_BAGAGEM_INT]
      ,[TRANSITO_CARGA_DOM]
      ,[TRANSITO_CARGA_INT]
      ,[TRANSITO_CORREIO_DOM]
      ,[TRANSITO_CORREIO_INT]
      ,[TRANSITO_CONEXAO_DOM]
      ,[TRANSITO_CONEXAO_INT]
      ,[COD_CHG_VOO]
      ,[DES_VIN]
      ,[NR_BOX]
      ,[TP_BOX]
      ,[SIGLA_AEROPORTO_PRO]
      ,[FL_AEN_TAX]
      ,[FL_EQP_HLC]
      ,[CD_STA]
      ,[NME_CIA_AEREA]
      ,[NME_EQUIPAMENTO]
      ,[DSC_PISTA_POU]
      ,[DSC_PISTA_DEC]
      ,4
      ,[DTA_MIGRACAO]
  FROM [BIOGER].[dbo].[BKP_BIOGER_RPE_DES]    
WHERE		SIGLA_AEROPORTO IN ('SBCJ', 'SBFL', 'SBMT', 'SBSJ')

-**********************************
TRUNCATE TABLE BIOGER_RPE_EMB


INSERT INTO BIOGER.dbo.BIOGER_RPE_EMB
SELECT SIGLA_AEROPORTO             AS SIGLA_AEROPORTO               
      ,NR_PAR_VOO                  AS NUMERO_VOO                    
      ,DH_PAR_NRM                  AS DATA_HORA_NORMAL_DECOLAGEM    
      ,DH_PAR_EFE                  AS DATA_HORA_EFETIVA_DECOLAGEM   
      ,CD_COM                      AS CD_COM                        
      ,SG_COM_IAT_003              AS SIGLA_IATA_CIA_AEREA          
      ,NR_AEN                      AS MATRICULA_AERONAVE            
      ,TP_PAR_GRU                  AS GRUPO_VOO                     
      ,TP_PAR_NAT                  AS NATUREZA_VOO                  
      ,TP_PAR                      AS CLASSE_VOO                    
      ,TP_PAR_CTG                  AS CATEGORIA_VOO                 
      ,TP_PAR_CTG_VIN              AS CATEGORIA_VOO_VINCULADO       
      ,SG_EQP                      AS SIGLA_EQUIPAMENTO             
      ,QT_DEP_TFB_DOM              AS EMB_TARIFA_PAGA_BILHETE_DOM   
      ,QT_DEP_TFB_INT              AS EMB_TARIFA_PAGA_BILHETE_INT   
      ,QT_DEP_TFC_DOM              AS EMB_TARIFA_PAGA_CHECKIN_DOM   
      ,QT_DEP_TFC_INT              AS EMB_TARIFA_PAGA_CHECKIN_INT   
      ,QT_DEP_ISE_COL              AS EMB_ISENTA_COLO               
      ,QT_DEP_ISE_TRA              AS EMB_ISENTA_TRANSITO           
      ,QT_DEP_ISE_CON_DOM          AS EMB_ISENTA_CONEXAO_DOM        
      ,QT_DEP_ISE_CON_INT          AS EMB_ISENTA_CONEXAO_INT        
      ,QT_DEP_ISE_OUT              AS EMB_ISENTA_OUTRAS             
      ,QT_DEP_EMB_BAG_DOM          AS EMB_BAGAGEM_DOM               
      ,QT_DEP_EMB_BAG_INT          AS EMB_BAGAGEM_INT               
      ,QT_DEP_EMB_CAR_DOM          AS EMB_CARGA_DOM                 
      ,QT_DEP_EMB_CAR_INT          AS EMB_CARGA_INT                 
      ,QT_DEP_EMB_COR_DOM          AS EMB_CORREIO_DOM               
      ,QT_DEP_EMB_COR_INT          AS EMB_CORREIO_INT               
      ,QT_DEP_TFB_DOM_ANT          AS EMB_TARIFA_PAG_BILHETE_DOM_ANT
      ,QT_DEP_TFB_INT_ANT          AS EMB_TARIFA_PAG_BILHETE_INT_ANT
      ,QT_DEP_TFC_DOM_ANT          AS EMB_TARIFA_PAG_CHECKIN_DOM_ANT
      ,QT_DEP_TFC_INT_ANT          AS EMB_TARIFA_PAG_CHECKIN_INT_ANT
      ,CD_CHG_AEN_ANT              AS COD_CHG_VOO_ANT               
      ,CD_PAR_VIN                  AS EMB_VIN                       
      ,NR_BOX                      AS NR_BOX                        
      ,TP_BOX                      AS TP_BOX                        
      ,SIGLA_AEROPORTO_DES         AS SIGLA_AEROPORTO_DES           
      ,FL_AEN_TAX                  AS FL_AEN_TAX                    
      ,FL_EQP_HLC                  AS FL_EQP_HLC                    
      ,CD_STA                      AS CD_STA                        
      ,NOME_CIA                    AS NME_CIA_AEREA                 
      ,NM_EQP                      AS NME_EQUIPAMENTO               
      ,PIS_PO                      AS DSC_PISTA_POU                 
      ,PIS_DE                      AS DSC_PISTA_DEC                 
      ,5                           AS FLG_MIGRADO                   
      ,GETDATE()                   AS DTA_MIGRACAO                  
FROM BIOGER.dbo.INTEGRACAO_SISO_BIOGER_EMB


INSERT INTO BIOGER.dbo.BIOGER_RPE_EMB
SELECT [SIGLA_AEROPORTO]
      ,[NUMERO_VOO]
      ,[DATA_HORA_NORMAL_DECOLAGEM]
      ,[DATA_HORA_EFETIVA_DECOLAGEM]
      ,[CD_COM]
      ,[SIGLA_IATA_CIA_AEREA]
      ,[MATRICULA_AERONAVE]
      ,[GRUPO_VOO]
      ,[NATUREZA_VOO]
      ,[CLASSE_VOO]
      ,[CATEGORIA_VOO]
      ,[CATEGORIA_VOO_VINCULADO]
      ,[SIGLA_EQUIPAMENTO]
      ,[EMB_TARIFA_PAGA_BILHETE_DOM]
      ,[EMB_TARIFA_PAGA_BILHETE_INT]
      ,[EMB_TARIFA_PAGA_CHECKIN_DOM]
      ,[EMB_TARIFA_PAGA_CHECKIN_INT]
      ,[EMB_ISENTA_COLO]
      ,[EMB_ISENTA_TRANSITO]
      ,[EMB_ISENTA_CONEXAO_DOM]
      ,[EMB_ISENTA_CONEXAO_INT]
      ,[EMB_ISENTA_OUTRAS]
      ,[EMB_BAGAGEM_DOM]
      ,[EMB_BAGAGEM_INT]
      ,[EMB_CARGA_DOM]
      ,[EMB_CARGA_INT]
      ,[EMB_CORREIO_DOM]
      ,[EMB_CORREIO_INT]
      ,[EMB_TARIFA_PAG_BILHETE_DOM_ANT]
      ,[EMB_TARIFA_PAG_BILHETE_INT_ANT]
      ,[EMB_TARIFA_PAG_CHECKIN_DOM_ANT]
      ,[EMB_TARIFA_PAG_CHECKIN_INT_ANT]
      ,[COD_CHG_VOO_ANT]
      ,[EMB_VIN]
      ,[NR_BOX]
      ,[TP_BOX]
      ,[SIGLA_AEROPORTO_DES]
      ,[FL_AEN_TAX]
      ,[FL_EQP_HLC]
      ,[CD_STA]
      ,[NME_CIA_AEREA]
      ,[NME_EQUIPAMENTO]
      ,[DSC_PISTA_POU]
      ,[DSC_PISTA_DEC]
      ,4
      ,[DTA_MIGRACAO]
FROM [BIOGER].[dbo].[BKP_BIOGER_RPE_EMB]
WHERE		SIGLA_AEROPORTO IN ('SBCJ', 'SBFL', 'SBMT', 'SBSJ')


-**********************************
TRUNCATE TABLE BIOGER_RPE_MOV

INSERT INTO BIOGER.dbo.BIOGER_RPE_MOV
SELECT sigla_aeroporto   AS SIGLA_AEROPORTO
      ,CD_STA            AS CD_STA         
      ,CD_MOV            AS CD_MOV         
      ,TIPO_MOV          AS TIPO_MOV       
      ,HR_MOV            AS DATA_HORA_MOV  
      ,NR_BOX            AS NR_BOX         
      ,TIPO_BOX          AS TP_BOX         
      ,NR_TPS            AS NR_TPS         
      ,5                 AS FLG_MIGRADO    
      ,GETDATE()         AS DTA_MIGRACAO   
FROM BIOGER.dbo.INTEGRACAO_SISO_BIOGER_MOV


INSERT INTO BIOGER.dbo.BIOGER_RPE_MOV
SELECT [SIGLA_AEROPORTO]
      ,[CD_STA]
      ,[CD_MOV]
      ,[TIPO_MOV]
      ,[DATA_HORA_MOV]
      ,[NR_BOX]
      ,[TP_BOX]
      ,[NR_TPS]
      ,4
      ,[DTA_MIGRACAO]
FROM [BIOGER].[dbo].[BKP_BIOGER_RPE_MOV]
WHERE		SIGLA_AEROPORTO IN ('SBCJ', 'SBFL', 'SBMT', 'SBSJ')



TRUNCATE TABLE INTEGRACAO_SISO_BIOGER_DES

TRUNCATE TABLE INTEGRACAO_SISO_BIOGER_EMB

TRUNCATE TABLE INTEGRACAO_SISO_BIOGER_MOV