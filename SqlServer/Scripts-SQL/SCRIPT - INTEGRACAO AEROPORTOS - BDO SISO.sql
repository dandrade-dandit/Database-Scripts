--******************************************************************************************************************
--CRIAÇÃO DE TABELAS DE SPOLLING PARA CAPTURAR INFORMAÇÕES DO SISO.
--SERÃO CRIADAS 5 TABELAS NO DATABASE BDO E 1 NO DATABASE INTEGRACAO.
--******************************************************************************************************************
--

--DATABASE BDO
USE [BDO]
GO

/****** Object:  Table [dbo].[P_T_CHG]    Script Date: 08/23/2011 14:11:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[P_T_CHG](
	[CD_CHG] [int] NOT NULL,
	[DT_CHG] [smalldatetime] NOT NULL,
	[CD_AER] [int] NOT NULL,
	[NR_CHG_VOO] [char](10) NOT NULL,
	[NR_CHG_HOT] [char](9) NULL,
	[TP_CHG_GRU] [tinyint] NOT NULL,
	[TP_CHG] [tinyint] NOT NULL,
	[TP_CHG_NAT] [tinyint] NOT NULL,
	[TP_CHG_CTG] [tinyint] NOT NULL,
	[CD_COM] [int] NOT NULL,
	[CD_CHG_VIN] [int] NULL,
	[FL_CHG_ANU] [bit] NOT NULL,
	[FL_CHG_TEL] [bit] NOT NULL,
	[CD_EQP_CHG] [int] NULL,
	[CD_AEN_CHG] [int] NULL,
	[CD_BOX] [int] NULL,
	[QT_CHG_PER_MIN] [int] NOT NULL,
	[DH_CHG_NRM] [smalldatetime] NULL,
	[DH_CHG_EFE] [smalldatetime] NULL,
	[DH_CHG_EST] [smalldatetime] NULL,
	[CD_SIT] [int] NULL,
	[NM_CHG_COM_SIT] [varchar](30) NULL,
	[DH_CHG_SIT] [smalldatetime] NULL,
	[FL_CHG_CAN] [bit] NOT NULL,
	[TP_CHG_STA] [tinyint] NULL,
	[CD_IFT] [int] NULL,
	[CD_USR] [int] NULL,
	[FL_CHG_PAR_ORI] [bit] NOT NULL,
	[TIMESTAMP] [timestamp] NOT NULL,
	[CD_TPS] [int] NULL,
	[FL_CHG_EXC] [bit] NULL,
	[CD_SET_CHG] [int] NULL,
	[QT_PAX] [int] NULL,
	[FL_ALO_SAPIOS] [bit] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[P_T_ESV001](
	[CD_CHG] [int] NULL,
	[CD_EST] [int] NULL,
	[FL_ALO_SAPIOS] [bit] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[P_T_MOV](
	[CD_STA] [int] NULL,
	[CD_MOV] [int] NULL,
	[TIPO_MOV] [char](2) NULL,
	[DH_MOV] [smalldatetime] NULL,
	[HR_MOV] [smalldatetime] NULL,
	[CD_BOX] [int] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[P_T_PAR](
	[CD_PAR] [int] NULL,
	[DT_PAR] [smalldatetime] NULL,
	[CD_AER] [int] NULL,
	[NR_PAR_VOO] [char](10) NULL,
	[NR_PAR_HOT] [char](9) NULL,
	[TP_PAR_GRU] [tinyint] NULL,
	[TP_PAR] [tinyint] NULL,
	[TP_PAR_NAT] [tinyint] NULL,
	[TP_PAR_CTG] [tinyint] NULL,
	[CD_COM] [int] NULL,
	[CD_CHG_ANT] [int] NULL,
	[CD_CHG_AEN_ANT] [int] NULL,
	[CD_PAR_VIN] [int] NULL,
	[FL_PAR_ANU] [bit] NULL,
	[FL_PAR_TEL] [bit] NULL,
	[DH_PAR_NRM] [smalldatetime] NULL,
	[DH_PAR_EFE] [smalldatetime] NULL,
	[DH_PAR_EST] [smalldatetime] NULL,
	[CD_SIT] [int] NULL,
	[NM_PAR_COM_SIT] [varchar](30) NULL,
	[DH_PAR_SIT] [smalldatetime] NULL,
	[CD_POR] [int] NULL,
	[FL_PAR_CAN] [bit] NULL,
	[TP_PAR_STA] [tinyint] NULL,
	[CD_IFT] [int] NULL,
	[CD_USR] [int] NULL,
	[FL_PAR_SP] [bit] NULL,
	[CD_TPS] [int] NULL,
	[FL_PAR_EXC] [bit] NULL,
	[DT_PAR_CHG] [smalldatetime] NULL,
	[CD_SET_PAR] [int] NULL,
	[QT_PAX] [int] NULL,
	[CD_BOX] [int] NULL,
	[FL_ALO_SAPIOS] [bit] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[P_T_CHG] ADD  DEFAULT ('N') FOR [IDB_STATUS]
GO

ALTER TABLE [dbo].[P_T_ESV001] ADD  CONSTRAINT [DF_P_T_ESV001_IDB_STATUS]  DEFAULT ('N') FOR [IDB_STATUS]
GO

ALTER TABLE [dbo].[P_T_MOV] ADD  CONSTRAINT [DF_P_T_MOV_IDB_STATUS]  DEFAULT ('N') FOR [IDB_STATUS]
GO

ALTER TABLE [dbo].[P_T_PAR] ADD  CONSTRAINT [DF_P_T_PAR_IDB_STATUS]  DEFAULT ('N') FOR [IDB_STATUS]
GO

CREATE TABLE [dbo].[P_T_STA](
	[CD_STA] [int] NOT NULL,
	[MA_STA_ABE] [smalldatetime] NOT NULL,
	[NR_STA] [int] NOT NULL,
	[DH_STA_FEC] [smalldatetime] NULL,
	[CD_STA_ANT] [int] NULL,
	[CD_STA_POS] [int] NULL,
	[TP_STA] [tinyint] NULL,
	[CD_AER] [int] NULL,
	[CD_AEN] [int] NULL,
	[CD_COM] [int] NULL,
	[NR_CHG_VOO] [char](10) NULL,
	[DH_VOO_HT_CHG] [smalldatetime] NULL,
	[HR_VOO_HT_CHG] [datetime] NULL,
	[CD_COM_PAR] [int] NULL,
	[NR_PAR_VOO] [char](10) NULL,
	[DH_VOO_HT_PAR] [smalldatetime] NULL,
	[HR_VOO_HT_PAR] [smalldatetime] NULL,
	[QT_STA_PSI_PATIO] [char](10) NULL,
	[QT_STA_PSI_EST] [char](10) NULL,
	[QT_STA_PSI_ISE] [char](10) NULL,
	[DH_STA_ABE] [smalldatetime] NULL,
	[OBS_CHG] [char](300) NULL,
	[OBS_PAR] [char](300) NULL,
	[TP_GRU] [tinyint] NULL,
	[TP_CHG] [tinyint] NULL,
	[TP_CHG_NAT] [tinyint] NULL,
	[TP_CHG_CTG] [tinyint] NULL,
	[TP_PAR] [tinyint] NULL,
	[TP_PAR_NAT] [tinyint] NULL,
	[TP_PAR_CTG] [tinyint] NULL,
	[CD_ICAO_PRO] [char](4) NULL,
	[CD_ICAO_DES] [char](4) NULL,
	[CD_PIS_PO] [int] NULL,
	[CD_PIS_DE] [int] NULL,
	[VOO_CHG_VIN] [char](8) NULL,
	[VOO_PAR_VIN] [char](8) NULL,
	[NR_PAX] [int] NULL,
	[FLAG_TXT] [tinyint] NULL,
	[NR_IMP] [tinyint] NULL,
	[CD_USR] [int] NULL,
	[VOO_CHG_VIN2] [char](8) NULL,
	[VOO_CHG_VIN3] [char](8) NULL,
	[VOO_PAR_VIN2] [char](8) NULL,
	[VOO_PAR_VIN3] [char](8) NULL,
	[FLAG_MEN] [tinyint] NULL,
	[TIMESTAMP] [timestamp] NOT NULL,
	[FLAG_ISE] [tinyint] NULL,
	[FLAG_AVISTA] [tinyint] NULL,
	[NRO_ISE] [char](10) NULL,
	[NRO_DAT] [char](10) NULL,
	[FLAG_ISE_OUTRAS] [tinyint] NULL,
	[QT_PER_COB_DIF_MIN] [int] NULL,
	[QT_PER_COB_DIF_MIN_ANT] [int] NULL,
	[CD_USR_VERIF] [int] NULL,
	[DT_VERIF] [datetime] NULL,
	[FL_COPIA_BIOGER] [tinyint] NULL,
	[Fl_tratamento_CHG] [tinyint] NULL,
	[Fl_tratamento_PAR] [tinyint] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[P_T_HES](
	[DH_HES_CHG_ALO] [datetime] NULL,
	[CD_CHG] [int] NOT NULL,
	[CD_EST] [int] NULL,
	[DH_HES] [smalldatetime] NULL,
	[CD_USR] [int] NULL,
	[NM_HES_USR] [varchar](30) NULL,
	[DH_HES_CHG_DES] [datetime] NULL,
	[CD_AER] [int] NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO



--DATABASE INTEGRACAO
USE [integracao]
GO

/****** Object:  Table [dbo].[P_INTEGRACAO_STMS_SIV]    Script Date: 06/03/2012 18:16:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[P_INTEGRACAO_STMS_SIV](
	[row_id] [int] NOT NULL,
	[row_time] [datetime] NOT NULL,
	[cd_mensagem] [varchar](2) NOT NULL,
	[cd_tipo] [char](1) NOT NULL,
	[identificacao_voo] [varchar](10) NOT NULL,
	[ho_data] [smalldatetime] NOT NULL,
	[hr_estimada] [datetime] NULL,
	[hr_real] [datetime] NULL,
	[sigla_icao_localidade] [varchar](4) NULL,
	[cd_equipamento_aeronave] [varchar](7) NULL,
	[nr_pessoas_bordo] [smallint] NULL,
	[cabeceira_pista_usada] [varchar](5) NULL,
	[fl_tratamento] [tinyint] NULL,
	[TV] [char](1) NULL,
	[ADB_SUBJECT] [varchar](255) NULL,
	[ADB_SEQUENCE] [int] IDENTITY(1,1) NOT NULL,
	[ADB_SET_SEQUENCE] [int] NULL,
	[ADB_TIMESTAMP] [datetime] NULL,
	[ADB_OPCODE] [int] NOT NULL,
	[ADB_UPDATE_ALL] [int] NULL,
	[ADB_REF_OBJECT] [varchar](64) NULL,
	[ADB_L_DELIVERY_STATUS] [char](1) NULL,
	[ADB_L_CMSEQUENCE] [decimal](28, 0) NULL,
	[ADB_TRACKINGID] [varchar](40) NULL,
	[IDB_STATUS] [char](1) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[P_INTEGRACAO_STMS_SIV] ADD  DEFAULT ('N') FOR [IDB_STATUS]
GO

--******************************************************************************************************************
--CRIAÇÃO DE TRIGGERS PARA CARREGAR AS TABELAS DE SPOLLING PARA CAPTURAR INFORMAÇÕES DO SISO.
--******************************************************************************************************************
--

--DATABASE BDO
USE [BDO]
GO

/****** Object:  Trigger [dbo].[TR1_P_T_CHG]    Script Date: 08/23/2011 14:09:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[TR1_P_T_CHG] ON [dbo].[T_CHG]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_CHG(
	 CD_CHG
	,DT_CHG
	,CD_AER
	,NR_CHG_VOO
	,NR_CHG_HOT
	,TP_CHG_GRU
	,TP_CHG
	,TP_CHG_NAT
	,TP_CHG_CTG
	,CD_COM
	,CD_CHG_VIN
	,FL_CHG_ANU
	,FL_CHG_TEL
	,CD_EQP_CHG
	,CD_AEN_CHG
	,CD_BOX
	,QT_CHG_PER_MIN
	,DH_CHG_NRM
	,DH_CHG_EFE
	,DH_CHG_EST
	,CD_SIT
	,NM_CHG_COM_SIT
	,DH_CHG_SIT
	,FL_CHG_CAN
	,TP_CHG_STA
	,CD_IFT
	,CD_USR
	,FL_CHG_PAR_ORI
	,CD_TPS
	,FL_CHG_EXC
	,CD_SET_CHG
	,QT_PAX
	,FL_ALO_SAPIOS
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
	SELECT CD_CHG,DT_CHG,CD_AER,NR_CHG_VOO,NR_CHG_HOT,TP_CHG_GRU,TP_CHG,TP_CHG_NAT,TP_CHG_CTG,CD_COM,CD_CHG_VIN,FL_CHG_ANU,FL_CHG_TEL,CD_EQP_CHG,CD_AEN_CHG,CD_BOX,QT_CHG_PER_MIN,DH_CHG_NRM,DH_CHG_EFE,DH_CHG_EST,CD_SIT,NM_CHG_COM_SIT,DH_CHG_SIT,FL_CHG_CAN,TP_CHG_STA,CD_IFT,CD_USR,FL_CHG_PAR_ORI,CD_TPS,FL_CHG_EXC,CD_SET_CHG,QT_PAX,FL_ALO_SAPIOS, NULL, getdate(), 1, NULL, 'C'
	FROM inserted
END

GO

CREATE TRIGGER [dbo].[TR2_P_T_CHG] ON [dbo].[T_CHG]
FOR UPDATE AS BEGIN
SET NOCOUNT ON
BEGIN
DECLARE @CD_SIT_OLD INT
      , @CD_SIT_NEW INT
      , @DH_CHG_SIT_OLD DATETIME
      , @DH_CHG_SIT_NEW DATETIME


SELECT	@CD_SIT_OLD = deleted.CD_SIT
      , @DH_CHG_SIT_OLD = deleted.DH_CHG_SIT
   FROM deleted
      
SELECT	@CD_SIT_NEW = inserted.CD_SIT
      , @DH_CHG_SIT_NEW = inserted.DH_CHG_SIT
  FROM inserted

IF ((@CD_SIT_OLD <> @CD_SIT_NEW) OR (@DH_CHG_SIT_OLD <> @DH_CHG_SIT_NEW)) BEGIN
	INSERT INTO dbo.P_T_CHG(
		 CD_CHG
		,DT_CHG
		,CD_AER
		,NR_CHG_VOO
		,NR_CHG_HOT
		,TP_CHG_GRU
		,TP_CHG
		,TP_CHG_NAT
		,TP_CHG_CTG
		,CD_COM
		,CD_CHG_VIN
		,FL_CHG_ANU
		,FL_CHG_TEL
		,CD_EQP_CHG
		,CD_AEN_CHG
		,CD_BOX
		,QT_CHG_PER_MIN
		,DH_CHG_NRM
		,DH_CHG_EFE
		,DH_CHG_EST
		,CD_SIT
		,NM_CHG_COM_SIT
		,DH_CHG_SIT
		,FL_CHG_CAN
		,TP_CHG_STA
		,CD_IFT
		,CD_USR
		,FL_CHG_PAR_ORI
		,CD_TPS
		,FL_CHG_EXC
		,CD_SET_CHG
		,QT_PAX
		,FL_ALO_SAPIOS
		,ADB_SUBJECT
		,ADB_TIMESTAMP
		,ADB_OPCODE
		,ADB_REF_OBJECT
		,ADB_L_DELIVERY_STATUS)
		SELECT CD_CHG,DT_CHG,CD_AER,NR_CHG_VOO,NR_CHG_HOT,TP_CHG_GRU,TP_CHG,TP_CHG_NAT,TP_CHG_CTG,CD_COM,CD_CHG_VIN,FL_CHG_ANU,FL_CHG_TEL,CD_EQP_CHG,CD_AEN_CHG,CD_BOX,QT_CHG_PER_MIN,DH_CHG_NRM,DH_CHG_EFE,DH_CHG_EST,CD_SIT,NM_CHG_COM_SIT,DH_CHG_SIT,FL_CHG_CAN,TP_CHG_STA,CD_IFT,CD_USR,FL_CHG_PAR_ORI,CD_TPS,FL_CHG_EXC,CD_SET_CHG,QT_PAX,FL_ALO_SAPIOS, NULL, getdate(), 2, NULL, 'C'
		FROM inserted
END
END
END


GO

CREATE TRIGGER [dbo].[TR1_P_T_ESV001] ON [dbo].[T_ESV001]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_ESV001(
      CD_CHG,
      CD_EST,
      FL_ALO_SAPIOS,
      ADB_SUBJECT,
      ADB_TIMESTAMP,
      ADB_OPCODE,
      ADB_REF_OBJECT,
      ADB_L_DELIVERY_STATUS)
      SELECT CD_CHG, CD_EST, FL_ALO_SAPIOS, NULL, getdate(), 1, NULL, 'N'
      FROM deleted
END

GO

CREATE TRIGGER [dbo].[TR2_P_T_ESV001] ON [dbo].[T_ESV001]
FOR UPDATE AS BEGIN
SET NOCOUNT ON

DECLARE @CD_EST_OLD INT
      , @CD_EST_NEW INT


SELECT      @CD_EST_OLD = deleted.CD_EST
   FROM deleted
      
SELECT      @CD_EST_NEW = inserted.CD_EST
  FROM inserted

IF (@CD_EST_NEW <> @CD_EST_OLD) BEGIN
      INSERT INTO dbo.P_T_ESV001(
            CD_CHG,
            CD_EST,
            FL_ALO_SAPIOS,
            ADB_SUBJECT,
            ADB_TIMESTAMP,
            ADB_OPCODE,
            ADB_REF_OBJECT,
            ADB_L_DELIVERY_STATUS)
            SELECT CD_CHG, CD_EST, FL_ALO_SAPIOS, NULL, getdate(), 2, NULL, 'N'
            FROM deleted
END

END

GO

CREATE TRIGGER [dbo].[TR3_P_T_ESV001] ON [dbo].[T_ESV001]
FOR DELETE AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_ESV001(
	CD_CHG,
	CD_EST,
	FL_ALO_SAPIOS,
	ADB_SUBJECT,
	ADB_TIMESTAMP,
	ADB_OPCODE,
	ADB_REF_OBJECT,
	ADB_L_DELIVERY_STATUS)
	SELECT CD_CHG, CD_EST, FL_ALO_SAPIOS, NULL, getdate(), 3, NULL, 'N'
	FROM deleted
END


GO


CREATE TRIGGER [dbo].[TR1_P_T_MOV] ON [dbo].[T_MOV]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_MOV(
	CD_STA,
	CD_MOV,
	TIPO_MOV,
	DH_MOV,
	HR_MOV,
	CD_BOX,
	ADB_SUBJECT,
	ADB_TIMESTAMP,
	ADB_OPCODE,
	ADB_REF_OBJECT,
	ADB_L_DELIVERY_STATUS)
	SELECT CD_STA, CD_MOV, TIPO_MOV, DH_MOV, HR_MOV, CD_BOX, NULL, getdate(), 1, NULL, 'N'
	FROM inserted
END


GO


CREATE TRIGGER [dbo].[TR1_P_T_PAR] ON [dbo].[T_PAR]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_PAR(
	CD_PAR,
	DT_PAR,
	CD_AER,
	NR_PAR_VOO,
	NR_PAR_HOT,
	TP_PAR_GRU,
	TP_PAR,
	TP_PAR_NAT,
	TP_PAR_CTG,
	CD_COM,
	CD_CHG_ANT,
	CD_CHG_AEN_ANT,
	CD_PAR_VIN,
	FL_PAR_ANU,
	FL_PAR_TEL,
	DH_PAR_NRM,
	DH_PAR_EFE,
	DH_PAR_EST,
	CD_SIT,
	NM_PAR_COM_SIT,
	DH_PAR_SIT,
	CD_POR,
	FL_PAR_CAN,
	TP_PAR_STA,
	CD_IFT,
	CD_USR,
	FL_PAR_SP,
	CD_TPS,
	FL_PAR_EXC,
	DT_PAR_CHG,
	CD_SET_PAR,
	QT_PAX,
	CD_BOX,
	FL_ALO_SAPIOS,
	ADB_SUBJECT,
	ADB_TIMESTAMP,
	ADB_OPCODE,
	ADB_REF_OBJECT,
	ADB_L_DELIVERY_STATUS)
	SELECT CD_PAR, DT_PAR, CD_AER, NR_PAR_VOO, NR_PAR_HOT, TP_PAR_GRU, TP_PAR, TP_PAR_NAT, TP_PAR_CTG, CD_COM, CD_CHG_ANT, CD_CHG_AEN_ANT, CD_PAR_VIN, FL_PAR_ANU, FL_PAR_TEL, DH_PAR_NRM, DH_PAR_EFE, DH_PAR_EST, CD_SIT, NM_PAR_COM_SIT, DH_PAR_SIT, CD_POR, FL_PAR_CAN, TP_PAR_STA, CD_IFT, CD_USR, FL_PAR_SP, CD_TPS, FL_PAR_EXC, DT_PAR_CHG, CD_SET_PAR, QT_PAX, CD_BOX, FL_ALO_SAPIOS, NULL, getdate(), 1, NULL, 'N'
	FROM inserted
END


GO

CREATE TRIGGER [dbo].[TR2_P_T_PAR] ON [dbo].[T_PAR]
FOR UPDATE AS BEGIN
SET NOCOUNT ON
BEGIN

DECLARE @CD_SIT_OLD INT
      , @CD_SIT_NEW INT
      , @DH_PAR_SIT_OLD DATETIME
      , @DH_PAR_SIT_NEW DATETIME


SELECT	@CD_SIT_OLD = deleted.CD_SIT
      , @DH_PAR_SIT_OLD = deleted.DH_PAR_SIT
   FROM deleted
      
SELECT	@CD_SIT_NEW = inserted.CD_SIT
      , @DH_PAR_SIT_NEW = inserted.DH_PAR_SIT
  FROM inserted

IF ((@CD_SIT_OLD <> @CD_SIT_NEW) OR (@DH_PAR_SIT_OLD <> @DH_PAR_SIT_NEW)) BEGIN
		INSERT INTO dbo.P_T_PAR(
			CD_PAR,
			DT_PAR,
			CD_AER,
			NR_PAR_VOO,
			NR_PAR_HOT,
			TP_PAR_GRU,
			TP_PAR,
			TP_PAR_NAT,
			TP_PAR_CTG,
			CD_COM,
			CD_CHG_ANT,
			CD_CHG_AEN_ANT,
			CD_PAR_VIN,
			FL_PAR_ANU,
			FL_PAR_TEL,
			DH_PAR_NRM,
			DH_PAR_EFE,
			DH_PAR_EST,
			CD_SIT,
			NM_PAR_COM_SIT,
			DH_PAR_SIT,
			CD_POR,
			FL_PAR_CAN,
			TP_PAR_STA,
			CD_IFT,
			CD_USR,
			FL_PAR_SP,
			CD_TPS,
			FL_PAR_EXC,
			DT_PAR_CHG,
			CD_SET_PAR,
			QT_PAX,
			CD_BOX,
			FL_ALO_SAPIOS,
			ADB_SUBJECT,
			ADB_TIMESTAMP,
			ADB_OPCODE,
			ADB_REF_OBJECT,
			ADB_L_DELIVERY_STATUS)
			SELECT CD_PAR, DT_PAR, CD_AER, NR_PAR_VOO, NR_PAR_HOT, TP_PAR_GRU, TP_PAR, TP_PAR_NAT, TP_PAR_CTG, CD_COM, CD_CHG_ANT, CD_CHG_AEN_ANT, CD_PAR_VIN, FL_PAR_ANU, FL_PAR_TEL, DH_PAR_NRM, DH_PAR_EFE, DH_PAR_EST, CD_SIT, NM_PAR_COM_SIT, DH_PAR_SIT, CD_POR, FL_PAR_CAN, TP_PAR_STA, CD_IFT, CD_USR, FL_PAR_SP, CD_TPS, FL_PAR_EXC, DT_PAR_CHG, CD_SET_PAR, QT_PAX, CD_BOX, FL_ALO_SAPIOS, NULL, getdate(), 2, NULL, 'N'
			FROM inserted
			WHERE EXISTS
				(SELECT * 
				FROM deleted
				WHERE inserted.CD_PAR = deleted.CD_PAR)
END
END
END

GO

CREATE TRIGGER [dbo].[TR3_P_T_PAR] ON [dbo].[T_PAR]
FOR DELETE AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_PAR(
	CD_PAR,
	DT_PAR,
	CD_AER,
	NR_PAR_VOO,
	NR_PAR_HOT,
	TP_PAR_GRU,
	TP_PAR,
	TP_PAR_NAT,
	TP_PAR_CTG,
	CD_COM,
	CD_CHG_ANT,
	CD_CHG_AEN_ANT,
	CD_PAR_VIN,
	FL_PAR_ANU,
	FL_PAR_TEL,
	DH_PAR_NRM,
	DH_PAR_EFE,
	DH_PAR_EST,
	CD_SIT,
	NM_PAR_COM_SIT,
	DH_PAR_SIT,
	CD_POR,
	FL_PAR_CAN,
	TP_PAR_STA,
	CD_IFT,
	CD_USR,
	FL_PAR_SP,
	CD_TPS,
	FL_PAR_EXC,
	DT_PAR_CHG,
	CD_SET_PAR,
	QT_PAX,
	CD_BOX,
	FL_ALO_SAPIOS,
	ADB_SUBJECT,
	ADB_TIMESTAMP,
	ADB_OPCODE,
	ADB_REF_OBJECT,
	ADB_L_DELIVERY_STATUS)
	SELECT CD_PAR, DT_PAR, CD_AER, NR_PAR_VOO, NR_PAR_HOT, TP_PAR_GRU, TP_PAR, TP_PAR_NAT, TP_PAR_CTG, CD_COM, CD_CHG_ANT, CD_CHG_AEN_ANT, CD_PAR_VIN, FL_PAR_ANU, FL_PAR_TEL, DH_PAR_NRM, DH_PAR_EFE, DH_PAR_EST, CD_SIT, NM_PAR_COM_SIT, DH_PAR_SIT, CD_POR, FL_PAR_CAN, TP_PAR_STA, CD_IFT, CD_USR, FL_PAR_SP, CD_TPS, FL_PAR_EXC, DT_PAR_CHG, CD_SET_PAR, QT_PAX, CD_BOX, FL_ALO_SAPIOS, NULL, getdate(), 3, NULL, 'N'
	FROM deleted
END


GO


CREATE TRIGGER [dbo].[TR1_P_T_STA] ON [dbo].[T_STA]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_STA(
	 CD_STA
	,MA_STA_ABE
	,NR_STA
	,DH_STA_FEC
	,CD_STA_ANT
	,CD_STA_POS
	,TP_STA
	,CD_AER
	,CD_AEN
	,CD_COM
	,NR_CHG_VOO
	,DH_VOO_HT_CHG
	,HR_VOO_HT_CHG
	,CD_COM_PAR
	,NR_PAR_VOO
	,DH_VOO_HT_PAR
	,HR_VOO_HT_PAR
	,QT_STA_PSI_PATIO
	,QT_STA_PSI_EST
	,QT_STA_PSI_ISE
	,DH_STA_ABE
	,OBS_CHG
	,OBS_PAR
	,TP_GRU
	,TP_CHG
	,TP_CHG_NAT
	,TP_CHG_CTG
	,TP_PAR
	,TP_PAR_NAT
	,TP_PAR_CTG
	,CD_ICAO_PRO
	,CD_ICAO_DES
	,CD_PIS_PO
	,CD_PIS_DE
	,VOO_CHG_VIN
	,VOO_PAR_VIN
	,NR_PAX
	,FLAG_TXT
	,NR_IMP
	,CD_USR
	,VOO_CHG_VIN2
	,VOO_CHG_VIN3
	,VOO_PAR_VIN2
	,VOO_PAR_VIN3
	,FLAG_ISE
	,FLAG_AVISTA
	,NRO_ISE
	,NRO_DAT
	,FLAG_ISE_OUTRAS
	,QT_PER_COB_DIF_MIN
	,QT_PER_COB_DIF_MIN_ANT
	,CD_USR_VERIF
	,DT_VERIF
	,FL_COPIA_BIOGER
	,Fl_tratamento_CHG
	,Fl_tratamento_PAR
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
SELECT CD_STA,MA_STA_ABE,NR_STA,DH_STA_FEC,CD_STA_ANT,CD_STA_POS,TP_STA,CD_AER,CD_AEN,CD_COM,NR_CHG_VOO,DH_VOO_HT_CHG,HR_VOO_HT_CHG,CD_COM_PAR,NR_PAR_VOO,DH_VOO_HT_PAR,HR_VOO_HT_PAR,QT_STA_PSI_PATIO,QT_STA_PSI_EST,QT_STA_PSI_ISE,DH_STA_ABE,OBS_CHG,OBS_PAR,TP_GRU,TP_CHG,TP_CHG_NAT,TP_CHG_CTG,TP_PAR,TP_PAR_NAT,TP_PAR_CTG,CD_ICAO_PRO,CD_ICAO_DES,CD_PIS_PO,CD_PIS_DE,VOO_CHG_VIN,VOO_PAR_VIN,NR_PAX,FLAG_TXT,NR_IMP,CD_USR,VOO_CHG_VIN2,VOO_CHG_VIN3,VOO_PAR_VIN2,VOO_PAR_VIN3,FLAG_ISE,FLAG_AVISTA,NRO_ISE,NRO_DAT,FLAG_ISE_OUTRAS,QT_PER_COB_DIF_MIN,QT_PER_COB_DIF_MIN_ANT,CD_USR_VERIF,DT_VERIF,FL_COPIA_BIOGER,Fl_tratamento_CHG,Fl_tratamento_PAR, NULL, getdate(), 1, NULL, 'N'
	FROM inserted
END
GO


CREATE TRIGGER [dbo].[TR2_P_T_STA] ON [dbo].[T_STA]
FOR UPDATE AS BEGIN
SET NOCOUNT ON
BEGIN

DECLARE @NR_PAR_VOO_OLD char(10)
      , @NR_PAR_VOO_NEW char(10)


SELECT	@NR_PAR_VOO_OLD = ISNULL(deleted.NR_PAR_VOO, '0')
   FROM deleted
      
SELECT	@NR_PAR_VOO_NEW = ISNULL(inserted.NR_PAR_VOO, '0')
  FROM inserted

IF (@NR_PAR_VOO_OLD <> @NR_PAR_VOO_NEW) BEGIN

	INSERT INTO dbo.P_T_STA(
		 CD_STA
		,MA_STA_ABE
		,NR_STA
		,DH_STA_FEC
		,CD_STA_ANT
		,CD_STA_POS
		,TP_STA
		,CD_AER
		,CD_AEN
		,CD_COM
		,NR_CHG_VOO
		,DH_VOO_HT_CHG
		,HR_VOO_HT_CHG
		,CD_COM_PAR
		,NR_PAR_VOO
		,DH_VOO_HT_PAR
		,HR_VOO_HT_PAR
		,QT_STA_PSI_PATIO
		,QT_STA_PSI_EST
		,QT_STA_PSI_ISE
		,DH_STA_ABE
		,OBS_CHG
		,OBS_PAR
		,TP_GRU
		,TP_CHG
		,TP_CHG_NAT
		,TP_CHG_CTG
		,TP_PAR
		,TP_PAR_NAT
		,TP_PAR_CTG
		,CD_ICAO_PRO
		,CD_ICAO_DES
		,CD_PIS_PO
		,CD_PIS_DE
		,VOO_CHG_VIN
		,VOO_PAR_VIN
		,NR_PAX
		,FLAG_TXT
		,NR_IMP
		,CD_USR
		,VOO_CHG_VIN2
		,VOO_CHG_VIN3
		,VOO_PAR_VIN2
		,VOO_PAR_VIN3
		,FLAG_ISE
		,FLAG_AVISTA
		,NRO_ISE
		,NRO_DAT
		,FLAG_ISE_OUTRAS
		,QT_PER_COB_DIF_MIN
		,QT_PER_COB_DIF_MIN_ANT
		,CD_USR_VERIF
		,DT_VERIF
		,FL_COPIA_BIOGER
		,Fl_tratamento_CHG
		,Fl_tratamento_PAR
		,ADB_SUBJECT
		,ADB_TIMESTAMP
		,ADB_OPCODE
		,ADB_REF_OBJECT
		,ADB_L_DELIVERY_STATUS)
	SELECT CD_STA,MA_STA_ABE,NR_STA,DH_STA_FEC,CD_STA_ANT,CD_STA_POS,TP_STA,CD_AER,CD_AEN,CD_COM,NR_CHG_VOO,DH_VOO_HT_CHG,HR_VOO_HT_CHG,CD_COM_PAR,NR_PAR_VOO,DH_VOO_HT_PAR,HR_VOO_HT_PAR,QT_STA_PSI_PATIO,QT_STA_PSI_EST,QT_STA_PSI_ISE,DH_STA_ABE,OBS_CHG,OBS_PAR,TP_GRU,TP_CHG,TP_CHG_NAT,TP_CHG_CTG,TP_PAR,TP_PAR_NAT,TP_PAR_CTG,CD_ICAO_PRO,CD_ICAO_DES,CD_PIS_PO,CD_PIS_DE,VOO_CHG_VIN,VOO_PAR_VIN,NR_PAX,FLAG_TXT,NR_IMP,CD_USR,VOO_CHG_VIN2,VOO_CHG_VIN3,VOO_PAR_VIN2,VOO_PAR_VIN3,FLAG_ISE,FLAG_AVISTA,NRO_ISE,NRO_DAT,FLAG_ISE_OUTRAS,QT_PER_COB_DIF_MIN,QT_PER_COB_DIF_MIN_ANT,CD_USR_VERIF,DT_VERIF,FL_COPIA_BIOGER,Fl_tratamento_CHG,Fl_tratamento_PAR, NULL, getdate(), 2, NULL, 'N'
		FROM inserted
		WHERE EXISTS
				(SELECT * 
				FROM deleted
				WHERE inserted.CD_STA = deleted.CD_STA)
END
END
END
GO


CREATE TRIGGER [dbo].[TR1_P_T_HES] ON [dbo].[T_HES]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_T_HES(
	 DH_HES_CHG_ALO
    ,CD_CHG
    ,CD_EST
    ,DH_HES
    ,CD_USR
    ,NM_HES_USR
    ,DH_HES_CHG_DES
    ,CD_AER
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
	SELECT DH_HES_CHG_ALO,CD_CHG,CD_EST,DH_HES,CD_USR,NM_HES_USR,DH_HES_CHG_DES,CD_AER, NULL, getdate(), 1, NULL, 'N'
	FROM inserted
END

GO

CREATE TRIGGER [dbo].[TR2_P_T_HES] ON [dbo].[T_HES]
FOR UPDATE AS BEGIN
SET NOCOUNT ON
BEGIN
DECLARE @CD_EST_OLD INT
      , @CD_EST_NEW INT
      , @DH_HES_OLD DATETIME
      , @DH_HES_NEW DATETIME


SELECT	@CD_EST_OLD = deleted.CD_EST
      , @DH_HES_OLD = deleted.DH_HES
   FROM deleted
      
SELECT	@CD_EST_NEW = inserted.CD_EST
      , @DH_HES_NEW = inserted.DH_HES
  FROM inserted

IF ((@CD_EST_OLD <> @CD_EST_NEW) OR (@DH_HES_OLD <> @DH_HES_NEW)) BEGIN
	INSERT INTO dbo.P_T_HES(
	 DH_HES_CHG_ALO
    ,CD_CHG
    ,CD_EST
    ,DH_HES
    ,CD_USR
    ,NM_HES_USR
    ,DH_HES_CHG_DES
    ,CD_AER
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
	SELECT DH_HES_CHG_ALO,CD_CHG,CD_EST,DH_HES,CD_USR,NM_HES_USR,DH_HES_CHG_DES,CD_AER, NULL, getdate(), 2, NULL, 'N'
	FROM inserted
END
END
END

GO

--DATABASE INTEGRACAO
USE [integracao]
GO

/****** Object:  Trigger [dbo].[TR1_P_INTEGRACAO_STMS_SIV]    Script Date: 06/03/2012 18:18:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TR1_P_INTEGRACAO_STMS_SIV] ON [dbo].[INTEGRACAO_STMS_SIV]
FOR INSERT AS BEGIN
SET NOCOUNT ON
INSERT INTO dbo.P_INTEGRACAO_STMS_SIV(
	 [row_id]
	,[row_time]
	,[cd_mensagem]
	,[cd_tipo]
	,[identificacao_voo]
	,[ho_data]
	,[hr_estimada]
	,[hr_real]
	,[sigla_icao_localidade]
	,[cd_equipamento_aeronave]
	,[nr_pessoas_bordo]
	,[cabeceira_pista_usada]
	,[fl_tratamento]
	,[TV]
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
	SELECT [row_id],[row_time],[cd_mensagem],[cd_tipo],[identificacao_voo],[ho_data],[hr_estimada],[hr_real],[sigla_icao_localidade],[cd_equipamento_aeronave],[nr_pessoas_bordo],[cabeceira_pista_usada],[fl_tratamento],[TV],NULL, getdate(), 1, NULL, 'N'
	FROM inserted
END





GO


CREATE TRIGGER [dbo].[TR2_P_INTEGRACAO_STMS_SIV] ON [dbo].[INTEGRACAO_STMS_SIV]
FOR UPDATE AS BEGIN
SET NOCOUNT ON
BEGIN
DECLARE @HR_ESTIMADA_OLD DATETIME
      , @HR_ESTIMADA_NEW DATETIME
      , @HR_REAL_OLD DATETIME
      , @HR_REAL_NEW DATETIME
      , @SIGLA_ICAO_LOCALIDADE_OLD VARCHAR(4)
      , @SIGLA_ICAO_LOCALIDADE_NEW VARCHAR(4)
      , @CABECEIRA_PISTA_USADA_OLD VARCHAR(5)
      , @CABECEIRA_PISTA_USADA_NEW VARCHAR(5)
      , @CD_EQUIPAMENTO_AERONAVE_OLD VARCHAR(7)
      , @CD_EQUIPAMENTO_AERONAVE_NEW VARCHAR(7)
      ,	@NR_PESSOAS_BORDO_OLD SMALLINT
      , @NR_PESSOAS_BORDO_NEW SMALLINT


SELECT	@HR_ESTIMADA_OLD = ISNULL(deleted.HR_ESTIMADA, '19000101')
      , @HR_REAL_OLD = ISNULL(deleted.HR_REAL, '19000101')
      ,	@SIGLA_ICAO_LOCALIDADE_OLD = ISNULL(RTRIM(LTRIM(deleted.SIGLA_ICAO_LOCALIDADE)),'')
      ,	@CABECEIRA_PISTA_USADA_OLD = ISNULL(RTRIM(LTRIM(deleted.CABECEIRA_PISTA_USADA)),'')
      ,	@CD_EQUIPAMENTO_AERONAVE_OLD = ISNULL(RTRIM(LTRIM(deleted.CD_EQUIPAMENTO_AERONAVE)),'')
      , @NR_PESSOAS_BORDO_OLD = ISNULL(deleted.NR_PESSOAS_BORDO, 0)
   FROM deleted
     
SELECT	@HR_ESTIMADA_NEW = ISNULL(inserted.HR_ESTIMADA, '19000101')
      , @HR_REAL_NEW = ISNULL(inserted.HR_REAL, '19000101')
      ,	@SIGLA_ICAO_LOCALIDADE_NEW = ISNULL(RTRIM(LTRIM(inserted.SIGLA_ICAO_LOCALIDADE)),'')
      ,	@CABECEIRA_PISTA_USADA_NEW = ISNULL(RTRIM(LTRIM(inserted.CABECEIRA_PISTA_USADA)),'')
      ,	@CD_EQUIPAMENTO_AERONAVE_NEW = ISNULL(RTRIM(LTRIM(inserted.CD_EQUIPAMENTO_AERONAVE)),'')
      , @NR_PESSOAS_BORDO_NEW = ISNULL(inserted.NR_PESSOAS_BORDO, 0)
  FROM inserted

IF ( (@HR_ESTIMADA_OLD <> @HR_ESTIMADA_NEW) OR (@HR_REAL_OLD <> @HR_REAL_NEW) OR 
     (@SIGLA_ICAO_LOCALIDADE_OLD <> @SIGLA_ICAO_LOCALIDADE_NEW) OR (@CABECEIRA_PISTA_USADA_OLD <> @CABECEIRA_PISTA_USADA_NEW) OR 
     (@CD_EQUIPAMENTO_AERONAVE_OLD <> @CD_EQUIPAMENTO_AERONAVE_NEW) OR (@NR_PESSOAS_BORDO_OLD <> @NR_PESSOAS_BORDO_NEW)
) BEGIN
	INSERT INTO dbo.P_INTEGRACAO_STMS_SIV(
	 [row_id]
	,[row_time]
	,[cd_mensagem]
	,[cd_tipo]
	,[identificacao_voo]
	,[ho_data]
	,[hr_estimada]
	,[hr_real]
	,[sigla_icao_localidade]
	,[cd_equipamento_aeronave]
	,[nr_pessoas_bordo]
	,[cabeceira_pista_usada]
	,[fl_tratamento]
	,[TV]
	,ADB_SUBJECT
	,ADB_TIMESTAMP
	,ADB_OPCODE
	,ADB_REF_OBJECT
	,ADB_L_DELIVERY_STATUS)
	SELECT [row_id],[row_time],[cd_mensagem],[cd_tipo],[identificacao_voo],[ho_data],[hr_estimada],[hr_real],[sigla_icao_localidade],[cd_equipamento_aeronave],[nr_pessoas_bordo],[cabeceira_pista_usada],[fl_tratamento],[TV],NULL, getdate(), 2, NULL, 'N'
	FROM inserted
END
END
END

GO


--******************************************************************************************************************
--GRANTS PARA O USUÁRIO SISO_CARGA. ESSE USUÁRIO SERÁ USANDO PARA A MIGRAÇÃO DAS INFORMAÇÕES.
--******************************************************************************************************************
--

--DATABASE BDO
use bdo

grant select, update, delete, insert on P_T_CHG to siso_carga
grant select, update, delete, insert on P_T_ESV001 to siso_carga
grant select, update, delete, insert on P_T_MOV to siso_carga
grant select, update, delete, insert on P_T_PAR to siso_carga
grant select, update, delete, insert on P_T_STA to siso_carga
GRANT SELECT, UPDATE, DELETE, INSERT ON [P_T_HES] TO siso_carga;
GRANT SELECT ON T_SAL TO SISO_CARGA
grant select on T_AEN to siso_carga
grant select on T_AER to siso_carga
grant select on T_BOX to siso_carga
grant select on T_CHG to siso_carga
grant select on T_COM to siso_carga
grant select on T_DEC to siso_carga
grant select on T_DEP to siso_carga
grant select on T_EQP to siso_carga
grant select on T_HET to siso_carga
grant select on T_HFR to siso_carga
grant select on T_HOT001 to siso_carga
grant select on T_HPA001_old to siso_carga
grant select on T_HVE to siso_carga
grant select on T_MOV to siso_carga
grant select on T_PAR to siso_carga
grant select on T_PIS to siso_carga
grant select on T_POR to siso_carga
grant select on T_SIT to siso_carga
GRANT SELECT ON T_EST TO SISO_CARGA;
grant select on VIW_RPE_DESEMBARQUE to siso_carga
grant select on VIW_RPE_EMBARQUE to siso_carga

GO

--DATABASE INTEGRACAO
USE integracao

grant select, insert, delete, update on P_INTEGRACAO_STMS_SIV to siso_carga


--******************************************************************************************************************
--OBSERVAÇÕES
--******************************************************************************************************************
--

--A) O PROCESSO DE MIGRAÇÃO SERÁ CONTROLADO POR JOB DO SERVIDOR S-SEBN111 DA SEDE;
--B) TODO DIA A ZERO HORA, TODAS AS INFORMAÇÕES JÁ MIGRADAS DO AEROPORTO SERÃO DELETADAS PELO PROCESSO DA SEDE

--******************************************************************************************************************