USE [GEACupax]
GO
/****** Object:  Trigger [dbo].[utrg_upd_pax_selos_coletados_u]    Script Date: 12/13/2010 08:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists(select * from sysobjects where name = 'utrg_upd_pax_selos_coletados_u')
   drop Trigger utrg_upd_pax_selos_coletados_u
go


Create Trigger [dbo].[utrg_upd_pax_selos_coletados_u] On [dbo].[pax_selos_coletados_u]
For Update
As
Begin

    Set NOCOUNT On

    Update GEACupax..pax_selos_coletados_bd_u
       Set linha                = i.linha,
           cd_aerop_num         = i.cd_aerop_num,
           tp_selo              = i.tp_selo,
           tp_baixa             = i.tp_baixa,
           serie_coletor        = i.serie_coletor,
           cpf_agente           = i.cpf_agente,
           status_linha         = i.status_linha
      From inserted               i (nolock)
     Inner join
           GEACupax..pax_selos_coletados_bd_u b (nolock)
        On i.arquivo            = b.arquivo
       And i.nro_linha          = b.nro_linha

End
