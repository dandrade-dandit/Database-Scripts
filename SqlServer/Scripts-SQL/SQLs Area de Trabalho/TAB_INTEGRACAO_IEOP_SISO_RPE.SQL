USE [integracao]
GO

/****** Object:  Table [dbo].[INTEGRACAO_SISO_BIOGER_DES_NEW]    Script Date: 09/05/2014 10:28:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[INTEGRACAO_IEOP_SISO_RPE_DES](
	[SIGLA_AEROPORTO] [varchar](10) NULL,
	[NR_CHG_VOO] [varchar](10) NULL,
	[DH_CHG_NRM] [datetime] NULL,
	[DH_CHG_EFE] [datetime] NULL,
	[CD_COM] [int] NULL,
	[SG_COM_IAT_003] [varchar](10) NULL,
	[NR_AEN] [varchar](10) NULL,
	[TP_CHG_GRU] [smallint] NULL,
	[TP_CHG_NAT] [smallint] NULL,
	[TP_CHG] [smallint] NULL,
	[TP_CHG_CTG] [smallint] NULL,
	[TP_CHG_CTG_VIN] [smallint] NULL,
	[SG_EQP] [varchar](10) NULL,
	[QT_DEC_DES_DOM] [int] NULL,
	[QT_DEC_DES_INT] [int] NULL,
	[QT_DEC_DES_BAG_DOM] [int] NULL,
	[QT_DEC_DES_BAG_INT] [int] NULL,
	[QT_DEC_DES_CAR_DOM] [int] NULL,
	[QT_DEC_DES_CAR_INT] [int] NULL,
	[QT_DEC_DES_COR_DOM] [int] NULL,
	[QT_DEC_DES_COR_INT] [int] NULL,
	[QT_DEC_TRA_BAG_DOM] [int] NULL,
	[QT_DEC_TRA_BAG_INT] [int] NULL,
	[QT_DEC_TRA_CAR_DOM] [int] NULL,
	[QT_DEC_TRA_CAR_INT] [int] NULL,
	[QT_DEC_TRA_COR_DOM] [int] NULL,
	[QT_DEC_TRA_COR_INT] [int] NULL,
	[QT_DEC_TRA_DOM_CX] [int] NULL,
	[QT_DEC_TRA_INT_CX] [int] NULL,
	[CD_CHG] [varchar](10) NULL,
	[CD_CHG_VIN] [varchar](10) NULL,
	[NR_BOX] [varchar](10) NULL,
	[TP_BOX] [varchar](10) NULL,
	[SIGLA_AEROPORTO_PRO] [varchar](4) NULL,
	[FL_AEN_TAX] [tinyint] NULL,
	[FL_EQP_HLC] [tinyint] NULL,
	[CD_STA] [int] NULL,
	[NOME_CIA] [char](30) NULL,
	[NM_EQP] [char](20) NULL,
	[PIS_PO] [char](10) NULL,
	[PIS_DE] [char](10) NULL,
	[HR_MOV_PRI] [smalldatetime] NULL,
	[HR_MOV_ULT] [smalldatetime] NULL,
	[DTH_ATUALIZACAO] [datetime] NULL,
	[FL_STATUS] [int] NULL,
	[FLAG_ISE] [int] NULL,
	[FLAG_AVISTA] [int] NULL,
	[HR_MOV_PRI_ENT] [smalldatetime] NULL,
	[TP_STA] [tinyint] NULL,
	[CD_STA_ANT] [int] NULL,
	[CD_STA_POS] [int] NULL,
	[NM_PON] [varchar](40) NULL,
	[NR_EST] [varchar](30) NULL,
	[DTH_MIGRACAO] [datetime] NULL,
	[FLG_MIGRADO] [tinyint] NULL,
  [DTH_CARGA_SISO] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[INTEGRACAO_IEOP_SISO_RPE_EMB](
	[SIGLA_AEROPORTO] [varchar](10) NULL,
	[NR_PAR_VOO] [varchar](10) NULL,
	[DH_PAR_NRM] [datetime] NULL,
	[DH_PAR_EFE] [datetime] NULL,
	[CD_COM] [int] NULL,
	[SG_COM_IAT_003] [varchar](10) NULL,
	[NR_AEN] [varchar](10) NULL,
	[TP_PAR_GRU] [smallint] NULL,
	[TP_PAR_NAT] [smallint] NULL,
	[TP_PAR] [smallint] NULL,
	[TP_PAR_CTG] [smallint] NULL,
	[TP_PAR_CTG_VIN] [smallint] NULL,
	[SG_EQP] [varchar](10) NULL,
	[QT_DEP_TFB_DOM] [int] NULL,
	[QT_DEP_TFB_INT] [int] NULL,
	[QT_DEP_TFC_DOM] [int] NULL,
	[QT_DEP_TFC_INT] [int] NULL,
	[QT_DEP_ISE_COL] [int] NULL,
	[QT_DEP_ISE_TRA] [int] NULL,
	[QT_DEP_ISE_CON_DOM] [int] NULL,
	[QT_DEP_ISE_CON_INT] [int] NULL,
	[QT_DEP_ISE_OUT] [int] NULL,
	[QT_DEP_EMB_BAG_DOM] [int] NULL,
	[QT_DEP_EMB_BAG_INT] [int] NULL,
	[QT_DEP_EMB_CAR_DOM] [int] NULL,
	[QT_DEP_EMB_CAR_INT] [int] NULL,
	[QT_DEP_EMB_COR_DOM] [int] NULL,
	[QT_DEP_EMB_COR_INT] [int] NULL,
	[QT_DEP_TFB_DOM_ANT] [int] NULL,
	[QT_DEP_TFB_INT_ANT] [int] NULL,
	[QT_DEP_TFC_DOM_ANT] [int] NULL,
	[QT_DEP_TFC_INT_ANT] [int] NULL,
	[CD_CHG_AEN_ANT] [varchar](10) NULL,
	[CD_PAR_VIN] [varchar](10) NULL,
	[NR_BOX] [varchar](10) NULL,
	[TP_BOX] [varchar](10) NULL,
	[SIGLA_AEROPORTO_DES] [varchar](4) NULL,
	[FL_AEN_TAX] [tinyint] NULL,
	[FL_EQP_HLC] [tinyint] NULL,
	[CD_STA] [int] NULL,
	[NOME_CIA] [char](30) NULL,
	[NM_EQP] [char](20) NULL,
	[PIS_PO] [char](10) NULL,
	[PIS_DE] [char](10) NULL,
	[HR_MOV_PRI] [smalldatetime] NULL,
	[HR_MOV_ULT] [smalldatetime] NULL,
	[DTH_ATUALIZACAO] [datetime] NULL,
	[FL_STATUS] [int] NULL,
	[HR_MOV_ULT_SAI] [smalldatetime] NULL,
	[TP_STA] [tinyint] NULL,
	[CD_STA_ANT] [int] NULL,
	[CD_STA_POS] [int] NULL,
	[NM_PON] [varchar](40) NULL,
	[NR_POR] [char](4) NULL,
	[CD_PAR] [varchar](10) NULL,
	[DTH_MIGRACAO] [datetime] NULL,
	[FLG_MIGRADO] [tinyint] NULL,
  [DTH_CARGA_SISO] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON INTEGRACAO_IEOP_SISO_RPE_DES TO SISO_CARGA
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON INTEGRACAO_IEOP_SISO_RPE_EMB TO SISO_CARGA
GO