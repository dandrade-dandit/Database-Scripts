/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
USE GEACutcx
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.cor_aeroporto_u
	DROP CONSTRAINT DF_cor_aeroporto_u_recv_entity_id
GO
CREATE TABLE dbo.Tmp_cor_aeroporto_u
	(
	cd_aerop char(4) NOT NULL,
	no_aerop varchar(40) NOT NULL,
	recv_entity_id char(5) NOT NULL,
	cd_regional char(2) NOT NULL,
	cd_aerop_num char(3) NOT NULL,
	sigla_aerop_iata char(3) NOT NULL,
	date_created datetime NOT NULL,
	user_id_created char(30) NOT NULL,
	date_changed datetime NOT NULL,
	user_id_changed char(30) NOT NULL,
	inactive_ind char(1) NOT NULL,
	active_date datetime NOT NULL,
	chgstamp smallint NOT NULL
	)  ON [PRIMARY]
GO
GRANT SELECT ON dbo.Tmp_cor_aeroporto_u TO public  AS dbo
GO
GRANT SELECT ON dbo.Tmp_cor_aeroporto_u TO infraero  AS dbo
GO
ALTER TABLE dbo.Tmp_cor_aeroporto_u ADD CONSTRAINT
	DF_cor_aeroporto_u_recv_entity_id DEFAULT ((1001)) FOR recv_entity_id
GO
IF EXISTS(SELECT * FROM dbo.cor_aeroporto_u)
	 EXEC('INSERT INTO dbo.Tmp_cor_aeroporto_u (cd_aerop, no_aerop, recv_entity_id, cd_regional, cd_aerop_num, sigla_aerop_iata, date_created, user_id_created, date_changed, user_id_changed, inactive_ind, active_date, chgstamp)
		SELECT cd_aerop, no_aerop, recv_entity_id, cd_regional, cd_aerop_num, space(1), date_created, user_id_created, date_changed, user_id_changed, inactive_ind, active_date, chgstamp FROM dbo.cor_aeroporto_u WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.cor_aeroporto_u
GO
EXECUTE sp_rename N'dbo.Tmp_cor_aeroporto_u', N'cor_aeroporto_u', 'OBJECT' 
GO
ALTER TABLE dbo.cor_aeroporto_u ADD CONSTRAINT
	P_cor_aeroporto_u PRIMARY KEY CLUSTERED 
	(
	cd_aerop
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 80, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE TRIGGER [dbo].[utrg_del_ut34] 
       ON dbo.cor_aeroporto_u 
       FOR DELETE 
       AS 
 
 DELETE cor_aeroporto_u_comnt_u 
   FROM cor_aeroporto_u_comnt_u, deleted 
  WHERE cor_aeroporto_u_comnt_u.cd_aerop = deleted.cd_aerop
GO
COMMIT
