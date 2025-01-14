USE [IEOP]
GO

/****** Object:  StoredProcedure [dbo].[PRC_CARGA_DES_AEROPORTOS]    Script Date: 27/08/2013 09:10:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[PRC_CARGA_DES_AEROPORTOS](@SIG_AEROPORTO varchar(4))
AS
declare @QUERY VARCHAR(2000);
BEGIN
set @QUERY='';
	--TRUNCATE TABLE IEOP.dbo.IEOP_DESEMBARQUE_TEMP
set	@QUERY = 'UPDATE ['+@SIG_AEROPORTO+' - INTEGRACAO].[integracao].[dbo].[INTEGRACAO_SISO_BIOGER_DES_NEW] 
	   SET FL_STATUS= 1
	 WHERE FL_STATUS IS NULL';
	 exec(@QUERY);
	 
set	@QUERY = 'INSERT INTO IEOP.dbo.IEOP_DESEMBARQUE_TEMP
	SELECT  
			 LTRIM(RTRIM(SIGLA_AEROPORTO)) SIGLA_AEROPORTO
			,LTRIM(RTRIM(NR_CHG_VOO)) NR_CHG_VOO
			,DH_CHG_NRM
			,DH_CHG_EFE
			,CD_COM
			,LTRIM(RTRIM(SG_COM_IAT_003)) SG_COM_IAT_003
			,LTRIM(RTRIM(NOME_CIA)) NOME_CIA
			,LTRIM(RTRIM(NR_AEN)) NR_AEN
			,TP_CHG_GRU
			,TP_CHG_NAT
			,TP_CHG
			,TP_CHG_CTG
			,TP_CHG_CTG_VIN
			,LTRIM(RTRIM(SG_EQP)) SG_EQP
			,LTRIM(RTRIM(NM_EQP)) NM_EQP
			,QT_DEC_DES_DOM, QT_DEC_DES_INT, QT_DEC_DES_BAG_DOM
			,QT_DEC_DES_BAG_INT, QT_DEC_DES_CAR_DOM, QT_DEC_DES_CAR_INT
			,QT_DEC_DES_COR_DOM, QT_DEC_DES_COR_INT, QT_DEC_TRA_BAG_DOM
			,QT_DEC_TRA_BAG_INT, QT_DEC_TRA_CAR_DOM, QT_DEC_TRA_CAR_INT
			,QT_DEC_TRA_COR_DOM, QT_DEC_TRA_COR_INT, QT_DEC_TRA_DOM_CX,QT_DEC_TRA_INT_CX
			,ISNULL(LTRIM(RTRIM(CD_CHG)),0) CD_CHG
			,LTRIM(RTRIM(CD_CHG_VIN)) CD_CHG_VIN
			,LTRIM(RTRIM(SIGLA_AEROPORTO_PRO)) SIGLA_AEROPORTO_PRO
			,LTRIM(RTRIM(NR_BOX)) NR_BOX
			,LTRIM(RTRIM(TP_BOX)) TP_BOX
			,LTRIM(RTRIM(NM_PON)) NM_PON
			,LTRIM(RTRIM(NR_EST)) NR_EST
			,LTRIM(RTRIM(PIS_PO)) PIS_PO
			,LTRIM(RTRIM(PIS_DE)) PIS_DE
			,CD_STA
			,CD_STA_ANT
			,CD_STA_POS
			,TP_STA
			,FL_STATUS
			,FLAG_ISE
			,FLAG_AVISTA
			,FL_AEN_TAX
			,FL_EQP_HLC
			,HR_MOV_PRI
			,HR_MOV_PRI_ENT
			,HR_MOV_ULT
			,DTH_ATUALIZACAO
			,0 QTD_ATUALIZACAO
			,1 FLG_MIGRADO
			,GETDATE() DTH_MIGRACAO			
		FROM ['+@SIG_AEROPORTO+' - INTEGRACAO].[integracao].[dbo].[INTEGRACAO_SISO_BIOGER_DES_NEW] WITH (NOLOCK)
	   WHERE FL_STATUS = 1';
exec(@QUERY);

set	@QUERY = 'UPDATE ['+@SIG_AEROPORTO+' - INTEGRACAO].[integracao].[dbo].[INTEGRACAO_SISO_BIOGER_DES_NEW] 
	   SET FL_STATUS = 2
	 WHERE FL_STATUS = 1';
exec(@QUERY);
END;
GO


