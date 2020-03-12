USE [GEACupax]
GO

/****** Object:  Trigger [dbo].[TR1_P_pax_selos_coletados_u]    Script Date: 01/05/2012 09:17:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[TR1_P_pax_selos_coletados_u] ON [dbo].[pax_selos_coletados_u]
FOR INSERT AS BEGIN
SET NOCOUNT ON

DECLARE @cd_aerop_num varchar(10)

    select @cd_aerop_num = cd_aerop_num
      from inserted

	IF (@cd_aerop_num = '002' or @cd_aerop_num = '058') BEGIN
		INSERT INTO [GEACupax].[dbo].[pp_pax_selos_coletados_u]
		SELECT [arquivo]
			  ,[nro_linha]
			  ,[linha]
			  ,[cd_aerop_num]
			  ,[tp_selo]
			  ,[nro_selo]
			  ,[tp_baixa]
			  ,[serie_coletor]
			  ,[cpf_agente]
			  ,[status_linha]
			  ,[user_id_created]
			  ,[date_created]
		FROM inserted
	END
	
END

GO


--***********************
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [dependencia]
      ,[desc_dependencia]
      ,[centro]
      ,[desc_centro]
      ,[categoria]
      ,[desc_categoria]
      ,[sigla]
  FROM [INFRAERO].[dbo].[INFRA_centros_dependencias]
 --WHERE dependencia = '002'
 
 --**********************
 
 SELECT *--sum([TOTAL])
  FROM [SQLSSII].[GEACupax].[dbo].[viw_pax_coletados]
 where [DATA] = '20120105'
   and [MES_DIA_VOO] = '0105'
   AND sig_aeroporto = 'SBCF'
   and VOO COLLATE Latin1_General_CI_AI not in (SELECT DISTINCT [Processo] FROM [CGA].[dbo].[ColetasCGA] WITH (NOLOCK) WHERE DtaCriacao > '20120105' AND SequenciaProcesso = 81)

 --**********************