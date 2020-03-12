/*
Script criado para realizar alteracoes na base do BDO.
- 
- 
- 
- 


Teste na base:
SBGL - 15/01/2013 - ok


*/


DECLARE @STRSQL VARCHAR(1000);
DECLARE @STARTTIME DATETIME;
DECLARE @ENDTIME DATETIME;
DECLARE @STRERROR VARCHAR(1000);
DECLARE @ID	INT;

/* Criar a tabela temporaria TMPCMDIDX'; */
/*Criar tabela temporaria para registar os comandos e resultado de execucoes */
IF EXISTS(SELECT NAME FROM SYS.TABLES WHERE NAME='TMPCMDIDX')
	DROP TABLE TMPCMDIDX


	CREATE TABLE TMPCMDIDX(
	ID INT IDENTITY(1,1) NOT NULL,
	COMMAND VARCHAR(3000),
	TIME_EXEC DATETIME,
	MSGERRO VARCHAR(1000) NULL
	); 


--EXCLUIR RELACIONAMENTOS EXISTENTES, SERAO RECRIADOS POSTERIORMENTE

/* APAGAR TODOS RELACIONAMENTOS, POIS SERAM RECRIADOS */
INSERT INTO TMPCMDIDX (COMMAND)
	SELECT 'ALTER TABLE '+TABLE_NAME+' DROP CONSTRAINT '+CONSTRAINT_NAME+'; ' 
	  FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
	 WHERE CONSTRAINT_NAME LIKE '%_FK' OR CONSTRAINT_NAME LIKE 'FK_%';

--EXCLUIR AS CONSTRAINTS UNIQUE
INSERT INTO TMPCMDIDX (COMMAND)
	SELECT 'ALTER TABLE '+TC.table_name+' DROP CONSTRAINT '+TC.Constraint_Name+'; ' 
	from information_schema.table_constraints TC
	where TC.constraint_type = 'Unique'
	order by TC.Constraint_Name

		
/*
EXCLUIR OS INDICES 
*/
/* APAGAR TODOS RELACIONAMENTOS, POIS SERAM RECRIADOS */
INSERT INTO TMPCMDIDX (COMMAND)
	select 'drop index '+name+' on '+OBJECT_NAME(object_id)
	from sys.indexes
	where  Is_primary_key <> 1 
	and is_unique_constraint <> 1
	and OBJECT_NAME(object_id) like 'T_%'
	and type <> 0;

/*
Rebuild em todos index	
*/

INSERT INTO TMPCMDIDX (COMMAND)
	SELECT 'ALTER INDEX ALL ON ' + table_name + ' REBUILD WITH (PAD_INDEX = OFF,STATISTICS_NORECOMPUTE = OFF,ALLOW_ROW_LOCKS = ON,ALLOW_PAGE_LOCKS = ON,ONLINE = OFF,SORT_IN_TEMPDB = OFF)'
	FROM INFORMATION_SCHEMA.TABLES	


/* CRIA OS INDICES */
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_ONI_001] ON [dbo].[T_ONI] ([IDENT_ONI] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_INO_001] ON [dbo].[T_INO] ([CD_REC] ASC,[DH_INICIO] ASC,[MOTIVO] ASC)INCLUDE ( [TP_REC],[DH_FINAL_PREVISTO],[DH_FINAL]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_INO_002] ON [dbo].[T_INO] ([DH_INICIO] ASC,[DH_FINAL] ASC,[TP_REC] ASC,[CD_REC] ASC,[MOTIVO] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_INO_003] ON [dbo].[T_INO] ([DH_INICIO] ASC,[DH_FINAL] ASC,[DH_FINAL_PREVISTO] ASC,[TP_REC] ASC,[CD_REC] ASC,[MOTIVO] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_DGA_OBJ_001] ON [dbo].[T_DGA_OBJ] ([CD_DGA_OBJ] ASC) INCLUDE ( [DH_CHPA_EFE],[DH_DGA_WIDTH],[NR_AEN]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_001] ON [dbo].[T_MOV] ([CD_MOV] ASC) INCLUDE ( [HR_MOV]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_002] ON [dbo].[T_MOV] ([CD_STA] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_003] ON [dbo].[T_MOV] ([CD_STA] ASC,[CD_MOV] ASC,[TIPO_MOV] ASC) INCLUDE ( [CD_BOX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_004] ON [dbo].[T_MOV] ([CD_STA] ASC,[CD_MOV] ASC,[HR_MOV] ASC,[CD_BOX] ASC) INCLUDE ( [TIPO_MOV]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_005] ON [dbo].[T_MOV] ([HR_MOV] ASC) INCLUDE ( [CD_STA],[CD_MOV],[TIPO_MOV],[CD_BOX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MOV_006] ON [dbo].[T_MOV] ([CD_BOX] ASC,[HR_MOV] ASC) INCLUDE ( [CD_STA],[CD_MOV],[TIPO_MOV]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_001] ON [dbo].[T_CHG] ([TP_CHG_STA] ASC,[CD_COM] ASC,	[TP_CHG_GRU] ASC,[DH_CHG_NRM] ASC,[NR_CHG_VOO] ASC,[CD_CHG] ASC)INCLUDE ( [TP_CHG],[TP_CHG_NAT],[TP_CHG_CTG],[CD_AEN_CHG],[CD_BOX],[DH_CHG_EFE],[CD_SIT],[CD_TPS],[CD_SET_CHG],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_002] ON [dbo].[T_CHG] ([TP_CHG_STA] ASC,[TP_CHG] ASC,[TP_CHG_GRU] ASC,[DH_CHG_EFE] ASC,[FL_CHG_EXC] ASC,[CD_SET_CHG] ASC,[CD_TPS] ASC,[CD_CHG] ASC,[CD_BOX] ASC,[CD_COM] ASC,[CD_SIT] ASC,[CD_AEN_CHG] ASC,[TP_CHG_NAT] ASC,[TP_CHG_CTG] ASC,[NR_CHG_VOO] ASC,[DH_CHG_NRM] ASC) INCLUDE ( [FL_CHG_CAN],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_003] ON [dbo].[T_CHG] ([DH_CHG_EFE] ASC,[CD_CHG] ASC,	[DH_CHG_NRM] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_004] ON [dbo].[T_CHG] ([DT_CHG] ASC,[CD_COM] ASC,[CD_CHG] ASC,[NR_CHG_VOO] ASC,[FL_CHG_CAN] ASC,[CD_AEN_CHG] ASC) INCLUDE ( [QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_005] ON [dbo].[T_CHG] ([CD_SIT] ASC,[TP_CHG_GRU] ASC,[CD_COM] ASC) INCLUDE ( [TP_CHG],[TP_CHG_NAT],[TP_CHG_CTG],[CD_AEN_CHG],[CD_BOX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_006] ON [dbo].[T_CHG] ([FL_CHG_CAN] ASC,[DT_CHG] ASC,	[NR_CHG_VOO] ASC,[CD_COM] ASC,[CD_CHG] ASC,[CD_AEN_CHG] ASC) INCLUDE ( [QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_007] ON [dbo].[T_CHG] ([CD_CHG] ASC,[TP_CHG_STA] ASC,[TP_CHG_GRU] ASC,[CD_AER] ASC,[DH_CHG_EFE] ASC,[DH_CHG_NRM] ASC,[CD_SET_CHG] ASC,[CD_SIT] ASC,[CD_COM] ASC,[CD_EQP_CHG] ASC,[CD_TPS] ASC,[CD_AEN_CHG] ASC,[CD_BOX] ASC,[TP_CHG] ASC,[TP_CHG_NAT] ASC,[TP_CHG_CTG] ASC) INCLUDE ( [NR_CHG_VOO],[CD_CHG_VIN],[FL_CHG_ANU],[FL_CHG_TEL],[DH_CHG_SIT],[FL_CHG_PAR_ORI],[QT_PAX],[QT_PAX_ESP]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_008] ON [dbo].[T_CHG] ([CD_AER] ASC,[TP_CHG_GRU] ASC,[TP_CHG_STA] ASC) INCLUDE ( [CD_CHG],[NR_CHG_VOO],[TP_CHG],[TP_CHG_NAT],[TP_CHG_CTG],[CD_COM],[CD_CHG_VIN],[FL_CHG_ANU],[FL_CHG_TEL],[CD_EQP_CHG],[CD_AEN_CHG],[CD_BOX],[DH_CHG_NRM],[DH_CHG_EFE],[CD_SIT],[DH_CHG_SIT],[FL_CHG_PAR_ORI],[CD_TPS],[CD_SET_CHG],[QT_PAX],[QT_PAX_ESP]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] ');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_009] ON [dbo].[T_CHG] ([FL_CHG_CAN] ASC) INCLUDE ( [CD_CHG],[DT_CHG],[NR_CHG_VOO],[CD_COM],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_010] ON [dbo].[T_CHG] ([CD_AER] ASC,[TP_CHG_GRU] ASC,[TP_CHG_STA] ASC,[DH_CHG_EFE] ASC) INCLUDE ( [CD_CHG],[DH_CHG_NRM]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_011] ON [dbo].[T_CHG] ([DT_CHG] ASC,[NR_CHG_VOO] ASC,	[CD_COM] ASC) INCLUDE ( [CD_CHG],[CD_BOX],[DH_CHG_EFE],[CD_SIT]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_001] ON [dbo].[T_PAR] ([DH_PAR_EFE] ASC,[CD_PAR] ASC,[CD_AER] ASC,[FL_PAR_CAN] ASC,[TP_PAR_CTG] ASC,[TP_PAR_NAT] ASC,[CD_BOX] ASC, [CD_SIT] ASC,[CD_COM] ASC,[DH_PAR_NRM] ASC,[CD_CHG_AEN_ANT] ASC) INCLUDE ( [NR_PAR_VOO],[TP_PAR_GRU],[TP_PAR],[TP_PAR_STA],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_002] ON [dbo].[T_PAR] ([TP_PAR_GRU] ASC,[CD_PAR] ASC,[DH_PAR_EFE] ASC,[FL_PAR_EXC] ASC,[CD_COM] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_003] ON [dbo].[T_PAR] ([CD_CHG_AEN_ANT] ASC) INCLUDE ( [NR_PAR_VOO]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_004] ON [dbo].[T_PAR] ([CD_CHG_AEN_ANT] ASC,	[CD_POR] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_005] ON [dbo].[T_PAR] ([FL_PAR_CAN] ASC) INCLUDE ( [CD_PAR],[DT_PAR],[NR_PAR_VOO],[CD_COM],[CD_CHG_AEN_ANT],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_006] ON [dbo].[T_PAR] ([DT_PAR] ASC,[NR_PAR_VOO] ASC,[CD_COM] ASC,[FL_PAR_CAN] ASC) INCLUDE ( [CD_PAR],[CD_CHG_AEN_ANT],[QT_PAX]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PRP_001] ON [dbo].[T_PRP] ([DT_PRP_FIM] ASC)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MCH_001] ON [dbo].[T_MCH] ([TP_MCH] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MCH_002] ON [dbo].[T_MCH] ([CD_CHG] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_HCH_001] ON [dbo].[T_HCH] ([CD_CHK] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MNG_001] ON [dbo].[T_MNG] ([CD_GRU] ASC,[CD_MNU] ASC) INCLUDE ( [NR_MNG_NIV]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_AEN_001] ON [dbo].[T_AEN] ([CD_AEN] ASC) INCLUDE ( [NR_AEN],[CD_EQP]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_AEN_002] ON [dbo].[T_AEN] ([CD_AEN] ASC,[CD_EQP] ASC) INCLUDE ( [NR_AEN]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_AEN_003] ON [dbo].[T_AEN] ([CD_AEN] ASC) INCLUDE ( [NR_AEN]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_USG_001] ON [dbo].[T_USG] ([CD_GRU] ASC,[CD_USR] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_COM_001] ON [dbo].[T_COM] ([CD_COM] ASC) INCLUDE ( [SG_COM_IAT_003]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MPA_001] ON [dbo].[T_MPA] ([CD_PAR] ASC,	[CD_MPA] ASC) INCLUDE ( [TT_MPA_RES],[FL_MPA_LIDA]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_MPA_002] ON [dbo].[T_MPA] ([TP_MPA] ASC) INCLUDE ( [CD_PAR],[CD_USR]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_001] ON [dbo].[T_STA] ([NR_CHG_VOO] ASC,[CD_STA] ASC,	[TP_STA] ASC) INCLUDE ( [CD_COM],[HR_VOO_HT_CHG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_002] ON [dbo].[T_STA] ([TP_STA] ASC,[CD_STA] ASC,[MA_STA_ABE] ASC,[NR_STA] ASC,[DH_STA_ABE] ASC,[CD_AEN] ASC,[CD_COM] ASC,[CD_COM_PAR] ASC) INCLUDE ( [DH_STA_FEC],[NR_CHG_VOO],[DH_VOO_HT_CHG],[NR_PAR_VOO],[DH_VOO_HT_PAR],[TP_GRU],[TP_CHG],[TP_CHG_NAT],[TP_CHG_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_003] ON [dbo].[T_STA] ([TP_STA] ASC,[CD_STA] ASC,[CD_AEN] ASC,[CD_COM] ASC) INCLUDE ( [TP_GRU],[TP_CHG],[TP_CHG_NAT],[TP_CHG_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_004] ON [dbo].[T_STA] ([TP_STA] ASC,[MA_STA_ABE] ASC,	[NR_STA] ASC) INCLUDE ( [CD_STA]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_005] ON [dbo].[T_STA] ([CD_AER] ASC,[TP_GRU] ASC,[TP_STA] ASC,[TP_PAR_NAT] ASC) INCLUDE ( [CD_STA],[CD_AEN],[TP_PAR],[TP_PAR_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_006] ON [dbo].[T_STA] ([CD_AER] ASC,[TP_GRU] ASC,[TP_STA] ASC,[TP_CHG_NAT] ASC) INCLUDE ( [CD_STA],[CD_AEN],[CD_COM],[NR_CHG_VOO],[DH_VOO_HT_CHG],[TP_CHG],[TP_CHG_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_007] ON [dbo].[T_STA] ([CD_AER] ASC,[TP_GRU] ASC,[TP_STA] ASC,[TP_PAR_NAT] ASC) INCLUDE ( [CD_STA],[CD_AEN],[CD_COM_PAR],[NR_PAR_VOO],[DH_VOO_HT_PAR],[TP_PAR],[TP_PAR_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_008] ON [dbo].[T_STA] ([CD_AER] ASC,[TP_GRU] ASC,[TP_STA] ASC,[TP_CHG_NAT] ASC) INCLUDE ( [CD_STA],[CD_AEN],[CD_COM],[DH_VOO_HT_CHG],[TP_CHG],[TP_CHG_CTG]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
        INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_ERR_001] ON [dbo].[T_ERR] ([DH_ERR] ASC,[CD_TIPO_ERR] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
        INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_LOG_001] ON [dbo].[T_LOG] ([DH_LOG] ASC,[CD_TIPO_LOG] ASC,[NR_STA] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
        INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_CHG_012] ON [dbo].[T_CHG] ([CD_CHG_VIN] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_PAR_007] ON [dbo].[T_PAR] ([CD_PAR_VIN] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]');
--	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IDX_DEC_CHG] ON [dbo].[T_DEC] ([CD_CHG] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]')
--	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IDX_DEP_PAR] ON [dbo].[T_DEP] ([CD_PAR] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]')
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_009] ON [dbo].[T_STA] ([TP_STA] ASC, [DH_STA_ABE] ASC, [FLAG_TXT] ASC, [FLAG_AVISTA] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]')
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_010] ON [dbo].[T_STA] ([CD_CHG] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]')
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_STA_011] ON [dbo].[T_STA] ([CD_PAR] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]')
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('CREATE NONCLUSTERED INDEX [IX_RST_001] ON [dbo].[T_RST] ([CD_VOO] ASC,	[TP_VOO] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]')


/* CRIA AS CHAVES �NICAS */
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_AEN ADD CONSTRAINT UK_AEN_AEN UNIQUE NONCLUSTERED ([NR_AEN] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_AER ADD CONSTRAINT UK_AER_ICA UNIQUE NONCLUSTERED ([SG_AER_ICA] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_AER_FEC ADD CONSTRAINT UK_AER_FEC_DT_INI UNIQUE NONCLUSTERED ([DT_AER_INI] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_ASE ADD CONSTRAINT UK_ASE_AAN_SET UNIQUE NONCLUSTERED ([CD_AAN] ASC,[CD_SET] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_ATA ADD CONSTRAINT UK_ATA_AANTPA UNIQUE NONCLUSTERED ([CD_AAN] ASC,[CD_TPA] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_BCP ADD CONSTRAINT UK_BCP_BOX UNIQUE NONCLUSTERED ([CD_BOX] ASC,[TP_BCP] ASC,[VL_BCP] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_BOX ADD CONSTRAINT UK_BOX_AER UNIQUE NONCLUSTERED ([NR_BOX] ASC,[CD_AER] ASC,[CD_TPS] ASC,[CD_PON] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CHG ADD CONSTRAINT UK_CHG_EFE UNIQUE NONCLUSTERED ([TP_CHG_STA] ASC,[DH_CHG_EFE] ASC,[CD_CHG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CHG ADD CONSTRAINT UK_CHG_GRU UNIQUE NONCLUSTERED ([TP_CHG_STA] ASC,[TP_CHG_GRU] ASC,[CD_CHG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CHG ADD CONSTRAINT UK_CHG_STA UNIQUE NONCLUSTERED ([TP_CHG_STA] ASC,[CD_CHG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CHG ADD CONSTRAINT UK_CHG_STA_DAT UNIQUE NONCLUSTERED ([TP_CHG_STA] ASC,[DT_CHG] ASC,[CD_CHG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CHK ADD CONSTRAINT UK_CHK_AER UNIQUE NONCLUSTERED ([NR_CHK] ASC,[CD_AER] ASC,[CD_TPS] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_CLS ADD CONSTRAINT UK_CLS_SGCLS UNIQUE NONCLUSTERED ([SG_CLS] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_EMB ADD CONSTRAINT UK_EMB_NMAER UNIQUE NONCLUSTERED ([NM_EMB] ASC,[CD_AER] ASC,[CD_TPS] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_EQP ADD CONSTRAINT UK_EQP_SGL UNIQUE NONCLUSTERED ([SG_EQP] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_EST ADD CONSTRAINT UK_EST_AER UNIQUE NONCLUSTERED ([NR_EST] ASC,[CD_SAL] ASC,[CD_AER] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_CST ADD CONSTRAINT UK_FIDS_CST_NM UNIQUE NONCLUSTERED ([NM_CST] ASC,[TP_CST_DIS] ASC,[TP_CST_INT] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_DGU ADD CONSTRAINT UK_FIDS_DGU_DGTUSRCOM UNIQUE NONCLUSTERED ([CD_DGT] ASC,[CD_USR] ASC,[CD_COM] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_DST ADD CONSTRAINT UK_FIDS_DST_IP UNIQUE NONCLUSTERED ([NM_DST_IP] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_ISF ADD CONSTRAINT UK_FIDS_ISF_ISTFLD UNIQUE NONCLUSTERED ([TP_ISF] ASC,[CD_FLD] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_IST ADD CONSTRAINT UK_FIDS_IST_NM UNIQUE NONCLUSTERED ([NM_IST] ASC) ON [PRIMARY]'); 
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_PAL ADD CONSTRAINT UK_FIDS_PAL_PALNM UNIQUE NONCLUSTERED ([NM_PAL] ASC,[CD_ROL] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_PRO ADD CONSTRAINT UK_FIDS_PRO_NMPRO UNIQUE NONCLUSTERED ([NM_PRO] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_FIDS_ROL ADD CONSTRAINT UK_FIDS_ROL_NM UNIQUE NONCLUSTERED ([NM_ROL] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HCH ADD CONSTRAINT UK_HCH_DHPARCHG UNIQUE CLUSTERED ([DH_HCH_PAR_ALO] ASC,[CD_PAR] ASC,[CD_CHK] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HCK ADD CONSTRAINT UK_HCK_CHK UNIQUE NONCLUSTERED ([CD_HOT] ASC,[CD_HVE] ASC,[CD_HFR] ASC,[CD_CHK] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HES ADD CONSTRAINT UK_HES_DHCHGEST UNIQUE CLUSTERED ([DH_HES_CHG_ALO] ASC,[CD_CHG] ASC,[CD_EST] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HIF ADD CONSTRAINT UK_HIF_01 UNIQUE NONCLUSTERED ([CD_INF] ASC,[DT_HIF] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HPO ADD CONSTRAINT UK_HPO_DHPAR UNIQUE CLUSTERED ([DH_HPO_PAR_ALO] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HRC ADD CONSTRAINT UK_HRC_HRCAER UNIQUE NONCLUSTERED ([CD_AER] ASC,[HR_HRC_INI] ASC,[HR_HRC_FIM] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HSC ADD CONSTRAINT UK_HSC_DHCHG UNIQUE CLUSTERED ([DH_HSC] ASC,[CD_CHG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HSP ADD CONSTRAINT UK_HSP_HSPPAR UNIQUE CLUSTERED ([DH_HSP] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_HTE ADD CONSTRAINT UK_HTE_01 UNIQUE NONCLUSTERED ([CD_TFE] ASC,[DT_HTE] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_MNG ADD CONSTRAINT UK_MNG_MNU_GRU UNIQUE NONCLUSTERED ([CD_MNU] ASC,[CD_GRU] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_MOD ADD CONSTRAINT UK_MOD_NOM UNIQUE NONCLUSTERED ([NM_MOD] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_MSG ADD CONSTRAINT UK_MSG_IDI_TPA UNIQUE NONCLUSTERED ([CD_IDI] ASC,[CD_TPA] ASC,[CD_SIT] ASC,[TP_TEL] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PAR ADD CONSTRAINT UK_PAR_EFE UNIQUE NONCLUSTERED ([TP_PAR_STA] ASC,[DH_PAR_EFE] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PAR ADD CONSTRAINT UK_PAR_GRU UNIQUE NONCLUSTERED ([TP_PAR_STA] ASC,[TP_PAR_GRU] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PAR ADD CONSTRAINT UK_PAR_POR UNIQUE NONCLUSTERED ([TP_PAR_STA] ASC,[CD_POR] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PAR ADD CONSTRAINT UK_PAR_STA UNIQUE NONCLUSTERED ([TP_PAR_STA] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PAR ADD CONSTRAINT UK_PAR_STA_DAT UNIQUE NONCLUSTERED ([TP_PAR_STA] ASC,[DT_PAR] ASC,[CD_PAR] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PES ADD CONSTRAINT UK_PES_NM UNIQUE NONCLUSTERED ([NM_PES] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PIS ADD CONSTRAINT UK_PIS_NOM UNIQUE NONCLUSTERED ([NM_PIS] ASC,[CD_AER] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PON ADD CONSTRAINT UK_PON_NOM UNIQUE NONCLUSTERED ([CD_AER] ASC,[NM_PON] ASC,[CD_PON] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_POR ADD CONSTRAINT UK_POR_AER UNIQUE NONCLUSTERED ([NR_POR] ASC,[CD_AER] ASC,[CD_EMB] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PRA ADD CONSTRAINT UK_PRA_IDITPATPASIT UNIQUE NONCLUSTERED ([CD_IDI] ASC,[CD_TPA] ASC,[TP_PRA_TPA] ASC,[CD_SIT] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PRALOG ADD CONSTRAINT UK_PRALOG_001 UNIQUE CLUSTERED ([CD_PRA] ASC,[CD_CHG] ASC,[CD_PAR] ASC,[DH_LOG] ASC, [CD_TPA] ASC,[CD_IDI] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_PSI ADD CONSTRAINT UK_PSI_AER UNIQUE NONCLUSTERED ([CD_AER] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_REX ADD CONSTRAINT UK_REX_PRG UNIQUE NONCLUSTERED ([CD_PRG] ASC,[DT_REX] ASC,[CD_HRC] ASC,[CD_TEL] ASC,[NR_REX_PAG_TEL] ASC,[CD_DST] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_SAL ADD CONSTRAINT UK_SAL_AER UNIQUE NONCLUSTERED ([NM_SAL] ASC,[CD_AER] ASC,[CD_TPS] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_SCA ADD CONSTRAINT UK_SCA_SIT UNIQUE NONCLUSTERED ([CD_SIT] ASC,[CD_SIT_ANT] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_SIRP_ATT ADD CONSTRAINT UK_SIRP_ATT_NRO UNIQUE NONCLUSTERED ([CD_ATT] ASC,[NR_ATT] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_SSU ADD CONSTRAINT UK_SSU_SIT UNIQUE NONCLUSTERED ([CD_SIT] ASC,[CD_SIT_SUC] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_STA ADD CONSTRAINT UK_STA_001 UNIQUE NONCLUSTERED ([MA_STA_ABE] ASC,[NR_STA] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_TEL ADD CONSTRAINT UK_TEL_IST UNIQUE NONCLUSTERED ([TP_IST] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_TEL ADD CONSTRAINT UK_TEL_NM UNIQUE NONCLUSTERED ([NM_TEL] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_TEL ADD CONSTRAINT UK_TEL_SGTEL UNIQUE NONCLUSTERED ([SG_TEL] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_TFE ADD CONSTRAINT UK_TFE_AER_CTG UNIQUE NONCLUSTERED ([TP_TFE] ASC,[TP_TFE_AER_CTG] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_TSI ADD CONSTRAINT UK_TSI_TELSIT UNIQUE NONCLUSTERED ([CD_TEL] ASC,[CD_SIT] ASC) ON [PRIMARY]');
	INSERT INTO TMPCMDIDX (COMMAND) VALUES ('ALTER TABLE T_USG ADD CONSTRAINT UK_USG_USR_GRU UNIQUE NONCLUSTERED ([CD_USR] ASC,[CD_GRU] ASC) ON [PRIMARY]');


DECLARE CURSQL CURSOR FOR
SELECT ID,COMMAND
FROM TMPCMDIDX
ORDER BY ID

OPEN CURSQL;

FETCH NEXT FROM CURSQL INTO @ID,@STRSQL;
WHILE @@FETCH_STATUS=0
BEGIN 
	SET @STRERROR=NULL;
	SET @STARTTIME=GETDATE();
	BEGIN TRY
		EXECUTE (@STRSQL);
    END TRY
    BEGIN CATCH
		 SET @STRERROR = ERROR_NUMBER()
    END CATCH;
    SET @ENDTIME=GETDATE();
		UPDATE TMPCMDIDX 
			SET TIME_EXEC=@ENDTIME-@STARTTIME, MSGERRO=@STRERROR
			WHERE TMPCMDIDX.ID=@ID

    FETCH NEXT FROM CURSQL INTO @ID,@STRSQL;

    --WAITFOR DELAY '00:00:30';
END;

CLOSE CURSQL;
DEALLOCATE CURSQL;