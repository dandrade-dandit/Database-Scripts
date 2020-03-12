USE [master]
GO

/****** Object:  Table [dbo].[TempTableToKeep]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TempTableToKeep](
	[TempTable] [varchar](100) NOT NULL,
	[DateToDelete] [datetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[bkp_chaves_abertas_encerramento_2009]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[bkp_chaves_abertas_encerramento_2009](
	[ldr_entity_id] [char](5) NOT NULL,
	[dependencia] [char](3) NOT NULL,
	[conta] [char](9) NOT NULL,
	[programa] [char](2) NOT NULL,
	[projeto] [char](4) NOT NULL,
	[custo] [char](6) NOT NULL,
	[udak_surr_key] [int] NOT NULL,
	[acct_type_code] [char](1) NOT NULL,
	[acct_descp_1] [char](35) NOT NULL,
	[acct_descp_2] [char](35) NOT NULL,
	[acct_status_code] [char](1) NOT NULL,
	[summ_ind] [char](1) NOT NULL,
	[open_date] [datetime] NOT NULL,
	[close_date] [datetime] NOT NULL,
	[date_created] [datetime] NOT NULL,
	[date_last_maintained] [datetime] NOT NULL,
	[revaln_opt] [char](1) NOT NULL,
	[revaln_key_id] [char](5) NOT NULL,
	[revaln_rate_type] [char](1) NOT NULL,
	[revaln_date_opt] [char](2) NOT NULL,
	[revaln_rate_date] [datetime] NOT NULL,
	[restate_opt] [char](1) NOT NULL,
	[restate_key_id] [char](5) NOT NULL,
	[restate_rate_type] [char](1) NOT NULL,
	[restate_date_opt] [char](2) NOT NULL,
	[restate_rate_date] [datetime] NOT NULL,
	[life_to_date_ind] [char](1) NOT NULL,
	[chgstamp] [smallint] NOT NULL,
	[restate_calc_opt] [char](1) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[bkp_chaves_abertas_orcamento_2010]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[bkp_chaves_abertas_orcamento_2010](
	[ldr_entity_id] [char](5) NOT NULL,
	[dependencia] [char](3) NOT NULL,
	[conta] [char](9) NOT NULL,
	[programa] [char](2) NOT NULL,
	[projeto] [char](4) NOT NULL,
	[custo] [char](6) NOT NULL,
	[open_date] [datetime] NOT NULL,
	[close_date] [datetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[gtb_log_memocred_baixa_uleo]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[gtb_log_memocred_baixa_uleo](
	[nu_boleto_ss] [int] NULL,
	[recv_doc_id] [char](22) NULL,
	[prim_amt] [money] NULL,
	[dt_baixa] [datetime] NULL,
	[fl_estorno] [char](1) NULL,
	[eff_date_estorno] [datetime] NULL,
	[fl_estorno_contab] [char](1) NULL,
	[recv_doc_eff_date] [datetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[migracao]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[migracao](
	[base] [varchar](20) NULL,
	[path] [varchar](300) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[migracao1]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[migracao1](
	[base] [varchar](20) NULL,
	[path] [varchar](200) NULL,
	[fileid] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[mov_concil_banc_20090317]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[mov_concil_banc_20090317](
	[ldr_entity_id] [char](5) NOT NULL,
	[jrnl_id] [char](20) NOT NULL,
	[eff_date] [datetime] NOT NULL,
	[jrnl_seq_nbr] [int] NOT NULL,
	[suspense_seq_nbr] [smallint] NOT NULL,
	[jrnl_line_nbr] [int] NOT NULL,
	[accrl_rvsl_ind] [char](1) NOT NULL,
	[recon_key] [varchar](255) NOT NULL,
	[recon_criteria] [char](20) NOT NULL,
	[recon_switch] [char](1) NOT NULL,
	[recon_status] [char](1) NOT NULL,
	[recon_date] [datetime] NOT NULL,
	[recon_curr] [char](3) NOT NULL,
	[recon_amt] [money] NOT NULL,
	[line_ldr_entity_id] [char](5) NOT NULL,
	[dependencia] [char](3) NOT NULL,
	[conta] [char](9) NOT NULL,
	[programa] [char](2) NOT NULL,
	[projeto] [char](4) NOT NULL,
	[custo] [char](6) NOT NULL,
	[acct_type_code] [char](2) NOT NULL,
	[acctg_distn_type_code] [char](3) NOT NULL,
	[jrnl_user_fld_amt] [money] NOT NULL,
	[date_created] [datetime] NOT NULL,
	[jrnl_user_alpha_fld_1] [char](10) NOT NULL,
	[jrnl_user_alpha_fld_2] [char](15) NOT NULL,
	[posting_pd] [tinyint] NOT NULL,
	[jrnl_origin_code] [char](2) NOT NULL,
	[source_doc_ref] [char](14) NOT NULL,
	[descp] [char](80) NOT NULL,
	[prim_dr_cr_code] [char](1) NOT NULL,
	[prim_amt] [money] NOT NULL,
	[prim_curr_code] [char](3) NOT NULL,
	[trans_amt] [money] NOT NULL,
	[trans_curr_code] [char](3) NOT NULL,
	[date_posted] [datetime] NOT NULL,
	[adb_value_date] [datetime] NOT NULL,
	[chgstamp] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[par_61051_02_1995_0031_5]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[par_61051_02_1995_0031_5](
	[recv_entity_id] [char](5) NOT NULL,
	[tp_contrato] [char](2) NOT NULL,
	[ano_contrato] [char](4) NOT NULL,
	[seq_contrato] [char](4) NOT NULL,
	[versao] [int] NOT NULL,
	[item_id] [varchar](26) NOT NULL,
	[parcela] [char](6) NOT NULL,
	[dt_vcmt_fixo] [datetime] NOT NULL,
	[vl_fixo] [money] NOT NULL,
	[dt_vcmt_gm] [datetime] NOT NULL,
	[vl_gm] [money] NOT NULL,
	[dt_vcmt_pfat] [datetime] NOT NULL,
	[vl_pfat] [float] NOT NULL,
	[vl_fixo_l] [money] NOT NULL,
	[vl_gm_l] [money] NOT NULL,
	[vl_pfat_l] [float] NOT NULL,
	[vl_fat] [money] NOT NULL,
	[vl_fixo_bl] [money] NOT NULL,
	[billing_line_id_fixo] [int] NOT NULL,
	[billing_int_date_fixo] [datetime] NOT NULL,
	[billing_int_type_fixo] [char](1) NOT NULL,
	[billing_int_user_1_fixo] [char](10) NOT NULL,
	[vl_gm_bl] [money] NOT NULL,
	[billing_line_id_gm] [int] NOT NULL,
	[billing_int_date_gm] [datetime] NOT NULL,
	[billing_int_type_gm] [char](1) NOT NULL,
	[billing_int_user_1_gm] [char](10) NOT NULL,
	[vl_fat_bl] [money] NOT NULL,
	[billing_line_id_fat] [int] NOT NULL,
	[billing_int_date_fat] [datetime] NOT NULL,
	[billing_int_type_fat] [char](1) NOT NULL,
	[billing_int_user_1_fat] [char](10) NOT NULL,
	[tp_parcela] [char](1) NOT NULL,
	[userfield01] [money] NOT NULL,
	[userfield02] [datetime] NOT NULL,
	[userfield03] [char](10) NOT NULL,
	[mes_competencia] [char](2) NOT NULL,
	[ano_competencia] [char](4) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[user_id_created] [char](30) NOT NULL,
	[date_changed] [datetime] NOT NULL,
	[user_id_changed] [char](30) NOT NULL,
	[inactive_ind] [char](1) NOT NULL,
	[active_date] [datetime] NOT NULL,
	[chgstamp] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[pbcatcol]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pbcatcol](
	[pbc_tnam] [char](129) NOT NULL,
	[pbc_tid] [int] NULL,
	[pbc_ownr] [char](129) NOT NULL,
	[pbc_cnam] [char](129) NOT NULL,
	[pbc_cid] [smallint] NULL,
	[pbc_labl] [varchar](254) NULL,
	[pbc_lpos] [smallint] NULL,
	[pbc_hdr] [varchar](254) NULL,
	[pbc_hpos] [smallint] NULL,
	[pbc_jtfy] [smallint] NULL,
	[pbc_mask] [varchar](31) NULL,
	[pbc_case] [smallint] NULL,
	[pbc_hght] [smallint] NULL,
	[pbc_wdth] [smallint] NULL,
	[pbc_ptrn] [varchar](31) NULL,
	[pbc_bmap] [char](1) NULL,
	[pbc_init] [varchar](254) NULL,
	[pbc_cmnt] [varchar](254) NULL,
	[pbc_edit] [varchar](31) NULL,
	[pbc_tag] [varchar](254) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[pbcatedt]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pbcatedt](
	[pbe_name] [varchar](30) NOT NULL,
	[pbe_edit] [varchar](254) NULL,
	[pbe_type] [smallint] NULL,
	[pbe_cntr] [int] NULL,
	[pbe_seqn] [smallint] NOT NULL,
	[pbe_flag] [int] NULL,
	[pbe_work] [char](32) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[pbcatfmt]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pbcatfmt](
	[pbf_name] [varchar](30) NOT NULL,
	[pbf_frmt] [varchar](254) NULL,
	[pbf_type] [smallint] NULL,
	[pbf_cntr] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[pbcattbl]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pbcattbl](
	[pbt_tnam] [char](129) NOT NULL,
	[pbt_tid] [int] NULL,
	[pbt_ownr] [char](129) NOT NULL,
	[pbd_fhgt] [smallint] NULL,
	[pbd_fwgt] [smallint] NULL,
	[pbd_fitl] [char](1) NULL,
	[pbd_funl] [char](1) NULL,
	[pbd_fchr] [smallint] NULL,
	[pbd_fptc] [smallint] NULL,
	[pbd_ffce] [char](18) NULL,
	[pbh_fhgt] [smallint] NULL,
	[pbh_fwgt] [smallint] NULL,
	[pbh_fitl] [char](1) NULL,
	[pbh_funl] [char](1) NULL,
	[pbh_fchr] [smallint] NULL,
	[pbh_fptc] [smallint] NULL,
	[pbh_ffce] [char](18) NULL,
	[pbl_fhgt] [smallint] NULL,
	[pbl_fwgt] [smallint] NULL,
	[pbl_fitl] [char](1) NULL,
	[pbl_funl] [char](1) NULL,
	[pbl_fchr] [smallint] NULL,
	[pbl_fptc] [smallint] NULL,
	[pbl_ffce] [char](18) NULL,
	[pbt_cmnt] [varchar](254) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[pbcatvld]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pbcatvld](
	[pbv_name] [varchar](30) NOT NULL,
	[pbv_vald] [varchar](254) NULL,
	[pbv_type] [smallint] NULL,
	[pbv_cntr] [int] NULL,
	[pbv_msg] [varchar](254) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[prodver]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[prodver](
	[index] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Internal_value] [int] NULL,
	[Charcater_Value] [nvarchar](50) NULL
) ON [PRIMARY]

GO

USE [master]
GO

/****** Object:  Table [dbo].[temp_extr]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temp_extr](
	[linha] [char](250) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[temp_sec]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[temp_sec](
	[user_or_grp_id] [char](30) NOT NULL,
	[activity_id] [char](10) NOT NULL,
	[user_or_grp_id_type] [char](1) NOT NULL,
	[data_ctrl_type] [char](1) NOT NULL,
	[data_ctrl_row_type_code] [char](1) NOT NULL,
	[recv_entity_from_01] [char](5) NOT NULL,
	[recv_entity_to_01] [char](5) NOT NULL,
	[recv_entity_from_02] [char](5) NOT NULL,
	[recv_entity_to_02] [char](5) NOT NULL,
	[recv_entity_from_03] [char](5) NOT NULL,
	[recv_entity_to_03] [char](5) NOT NULL,
	[recv_entity_from_04] [char](5) NOT NULL,
	[recv_entity_to_04] [char](5) NOT NULL,
	[recv_entity_from_05] [char](5) NOT NULL,
	[recv_entity_to_05] [char](5) NOT NULL,
	[recv_entity_from_06] [char](5) NOT NULL,
	[recv_entity_to_06] [char](5) NOT NULL,
	[recv_entity_from_07] [char](5) NOT NULL,
	[recv_entity_to_07] [char](5) NOT NULL,
	[recv_entity_from_08] [char](5) NOT NULL,
	[recv_entity_to_08] [char](5) NOT NULL,
	[recv_entity_from_09] [char](5) NOT NULL,
	[recv_entity_to_09] [char](5) NOT NULL,
	[recv_entity_from_10] [char](5) NOT NULL,
	[recv_entity_to_10] [char](5) NOT NULL,
	[chgstamp] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [master]
GO

/****** Object:  Table [dbo].[unrecon_journals_20090317a]    Script Date: 02/07/2011 12:49:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[unrecon_journals_20090317a](
	[ldr_entity_id] [char](5) NOT NULL,
	[jrnl_id] [char](20) NOT NULL,
	[eff_date] [datetime] NOT NULL,
	[jrnl_seq_nbr] [int] NOT NULL,
	[suspense_seq_nbr] [smallint] NOT NULL,
	[jrnl_line_nbr] [int] NOT NULL,
	[accrl_rvsl_ind] [char](1) NOT NULL,
	[recon_key] [varchar](255) NOT NULL,
	[recon_criteria] [char](20) NOT NULL,
	[recon_switch] [char](1) NOT NULL,
	[recon_status] [char](1) NOT NULL,
	[recon_date] [datetime] NOT NULL,
	[recon_curr] [char](3) NOT NULL,
	[recon_amt] [money] NOT NULL,
	[line_ldr_entity_id] [char](5) NOT NULL,
	[dependencia] [char](3) NOT NULL,
	[conta] [char](9) NOT NULL,
	[programa] [char](2) NOT NULL,
	[projeto] [char](4) NOT NULL,
	[custo] [char](6) NOT NULL,
	[acct_type_code] [char](2) NOT NULL,
	[acctg_distn_type_code] [char](3) NOT NULL,
	[jrnl_user_fld_amt] [money] NOT NULL,
	[date_created] [datetime] NOT NULL,
	[jrnl_user_alpha_fld_1] [char](10) NOT NULL,
	[jrnl_user_alpha_fld_2] [char](15) NOT NULL,
	[posting_pd] [tinyint] NOT NULL,
	[jrnl_origin_code] [char](2) NOT NULL,
	[source_doc_ref] [char](14) NOT NULL,
	[descp] [char](80) NOT NULL,
	[prim_dr_cr_code] [char](1) NOT NULL,
	[prim_amt] [money] NOT NULL,
	[prim_curr_code] [char](3) NOT NULL,
	[trans_amt] [money] NOT NULL,
	[trans_curr_code] [char](3) NOT NULL,
	[date_posted] [datetime] NOT NULL,
	[adb_value_date] [datetime] NOT NULL,
	[chgstamp] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

