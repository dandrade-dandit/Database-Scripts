use GEACupax
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
CREATE TABLE dbo.Tmp_pax_coletor_u
	(
	serial char(9) NOT NULL,
	dependencia char(3) NOT NULL,
	sigla char(4) NOT NULL,
	date_created datetime NOT NULL,
	user_id_created char(30) NOT NULL,
	date_changed datetime NOT NULL,
	user_id_changed char(30) NOT NULL,
	inactive_ind char(1) NOT NULL,
	active_date datetime NOT NULL,
	chgstamp smallint NOT NULL
	)  ON [PRIMARY]
GO
GRANT SELECT ON dbo.Tmp_pax_coletor_u TO public  AS dbo
GO
IF EXISTS(SELECT * FROM dbo.pax_coletor_u)
	 EXEC('INSERT INTO dbo.Tmp_pax_coletor_u (
                  serial, 
                  dependencia, 
                  sigla, 
                  date_created,
                  user_id_created,
                  date_changed,
                  user_id_changed,
                  inactive_ind,
                  active_date,
                  chgstamp)
		   SELECT serial, 
                  dependencia, 
                  sigla,
                  getdate(),
                  ''AR_SISTEMA'',
                  ''19000101'',
                  '' '',
                  ''0'',
                  getdate(),
                  chgstamp 
             FROM dbo.pax_coletor_u WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.pax_coletor_u
GO
EXECUTE sp_rename N'dbo.Tmp_pax_coletor_u', N'pax_coletor_u', 'OBJECT' 
GO
ALTER TABLE dbo.pax_coletor_u ADD CONSTRAINT
	P_pax_coletor_u PRIMARY KEY CLUSTERED 
	(
	serial
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 80, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
