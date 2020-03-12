Use GEACupax

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
CREATE TABLE dbo.Tmp_pax_fiscal_head_u
	 ( cd_aerop                 char(4)  NOT NULL,
       data_mov                 datetime NOT NULL,
       cd_cia_aerea             char(3)  NOT NULL,
       nro_voo                  char(5)  NOT NULL,
       fl_fiscalizado           char(1)  NOT NULL,
       user_ficalizador         char(30) NOT NULL,
       fl_validado              char(1)  NOT NULL,
       user_validador           char(30) NOT NULL,
       tipo_selecao             char(1)  NOT NULL,
       chgstamp                 smallint NOT NULL )  ON [PRIMARY]
GO
GRANT SELECT ON dbo.Tmp_pax_fiscal_head_u TO public  AS dbo
GO
IF EXISTS(SELECT * FROM dbo.pax_fiscal_head_u)
    EXEC('INSERT INTO dbo.Tmp_pax_fiscal_head_u 
               ( cd_aerop, 
                 data_mov, 
                 cd_cia_aerea, 
                 nro_voo, 
                 fl_fiscalizado, 
                 user_ficalizador, 
                 fl_validado, 
                 user_validador, 
                 tipo_selecao,
                 chgstamp )
          SELECT cd_aerop, 
                 data_mov, 
                 cd_cia_aerea, 
                 nro_voo, 
                 fl_fiscalizado, 
                 user_ficalizador, 
                 fl_validado, 
                 user_validador, 
                 ''0'',
                 chgstamp 
            FROM dbo.pax_fiscal_head_u WITH (HOLDLOCK TABLOCKX)' )
GO
DROP TABLE dbo.pax_fiscal_head_u
GO
EXECUTE sp_rename N'dbo.Tmp_pax_fiscal_head_u', N'pax_fiscal_head_u', 'OBJECT' 
GO
ALTER TABLE dbo.pax_fiscal_head_u ADD CONSTRAINT
      P_pax_fiscal_head_u PRIMARY KEY CLUSTERED 
	( cd_aerop,
      data_mov,
      cd_cia_aerea,
      nro_voo
	) WITH( PAD_INDEX              = OFF, 
            FILLFACTOR             = 80, 
            STATISTICS_NORECOMPUTE = OFF, 
            IGNORE_DUP_KEY         = OFF, 
            ALLOW_ROW_LOCKS        = ON, 
            ALLOW_PAGE_LOCKS       = ON ) ON [PRIMARY]

GO
/****** Object:  Trigger dbo.utrg_del_uqaa    Script Date: 19/09/2008 15:21:46 ******/

CREATE TRIGGER [dbo].[utrg_del_uqaa] 
    ON dbo.pax_fiscal_head_u 
   FOR DELETE 
AS 
 
    DELETE pax_fiscal_head_u_comnt_u 
      FROM pax_fiscal_head_u_comnt_u, deleted 
     WHERE pax_fiscal_head_u_comnt_u.cd_aerop = deleted.cd_aerop 
       AND pax_fiscal_head_u_comnt_u.data_mov = deleted.data_mov 
       AND pax_fiscal_head_u_comnt_u.cd_cia_aerea = deleted.cd_cia_aerea 
       AND pax_fiscal_head_u_comnt_u.nro_voo = deleted.nro_voo 

    DELETE pax_fiscal_det_u 
      FROM pax_fiscal_det_u, deleted 
     WHERE pax_fiscal_det_u.cd_aerop = deleted.cd_aerop 
       AND pax_fiscal_det_u.data_mov = deleted.data_mov 
       AND pax_fiscal_det_u.cd_cia_aerea = deleted.cd_cia_aerea 
       AND pax_fiscal_det_u.nro_voo = deleted.nro_voo
GO
COMMIT

