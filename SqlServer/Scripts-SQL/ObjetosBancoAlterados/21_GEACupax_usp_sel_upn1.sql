USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_upn1]    Script Date: 12/24/2010 08:13:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_sel_upn1    Script Date: 19/09/2008 15:21:02 ******/


/*
exec usp_sel_upn1 'SBBR', '20081001', '20081015'
EXECUTE SQLSSIII.GEACupax.dbo.usp_sel_upn1 'SBBE', '20080516', '20080531'
*/

if exists(select * from sysobjects where name = 'usp_sel_upn1')
   drop procedure usp_sel_upn1
go


Create PROCEDURE [dbo].[usp_sel_upn1] 
    ( @p_cd_aerop               char(4), 
      @p_dt_mov_ini             datetime, 
      @p_dt_mov_fim             datetime ) 
AS 
    DECLARE @w_com_flg          char(1),
            @w_fl_quin_fat      char(1),
            @w_nro_selo         char(14)

    If Exists ( Select * 
                  From pax_val_quinz_hdr_u_comnt_u 
                 Where cd_aerop         = @p_cd_aerop 
                   And dt_mov_ini       = @p_dt_mov_ini 
                   And dt_mov_fim       = @p_dt_mov_fim) 
        Select @w_com_flg = 'Y' 
    Else 
        Select @w_com_flg = 'N' 

    -- verifica se a quinzena jah foi faturada
    Set     @w_fl_quin_fat      = '0'

    Select top 1 
           @w_nro_selo          = nro_selo
      From GEACupax..pax_selo_u (nolock)
     Where cd_aerop             = @p_cd_aerop
       And dt_mov         between @p_dt_mov_ini And @p_dt_mov_fim
       And billing_line_id      > 0 

    If @@rowcount > 0 Set @w_fl_quin_fat = '1'

    Select top 1
           @w_nro_selo          = nro_selo_electronico
      From GEACupax..pax_selo_electronico_u (nolock)
     Where cd_aerop             = @p_cd_aerop
       And dt_mov         between @p_dt_mov_ini And @p_dt_mov_fim
       And billing_line_id      > 0 

    If @@rowcount > 0 Set @w_fl_quin_fat = '1'

    Select Top 1
           a.cd_aerop, 
           a.dt_mov_ini, 
           a.dt_mov_fim, 
           a.com_quin_atu, 
           a.com_quin_ant, 
           a.com_quin_ano_ant, 
           a.tot_voo_no_per, 
           a.tot_voo_conf, 
           a.qua_sel_dis, 
           a.qua_sel_pen, 
           a.consideracoes, 
           a.fl_val, 
           a.user_res_val,	--ltrim(rtrim(a.user_res_val)) + ' - ' + isnull(rtrim(ltrim(u1.first_name)) + ' ' + rtrim(ltrim(u1.last_name)), ''), 
           a.dt_val, 
           a.fl_aut, 
           a.user_aut_fat, --ltrim(rtrim(a.user_aut_fat)) + ' - ' + isnull(rtrim(ltrim(u2.first_name)) + ' ' + rtrim(ltrim(u2.last_name)), ''), 
           a.dt_aut, 
           a.qua_sel_dis_geral,
           a.qua_sel_pen_geral,
           a.chgstamp, 
           @w_com_flg,
           rtrim(b.no_aerop),
           isnull(c.dt_time, '19000101'),
           isnull(rtrim(ltrim(c.user_id)), '') + ' - ' + isnull(rtrim(ltrim(u3.first_name))  + ' ' +  rtrim(ltrim(u3.last_name)), ''),
           ltrim(rtrim(a.user_res_val)) + ' - ' + isnull(rtrim(ltrim(u1.first_name)) + ' ' + rtrim(ltrim(u1.last_name)), '') user_val,
           ltrim(rtrim(a.user_aut_fat)) + ' - ' + isnull(rtrim(ltrim(u2.first_name)) + ' ' + rtrim(ltrim(u2.last_name)), '') user_aut,
           fl_quin_fat      = @w_fl_quin_fat
      From pax_val_quinz_hdr_u a
     Inner join GEACutcx..cor_aeroporto_u b
        On b.cd_aerop       = a.cd_aerop
      Left join pax_val_quinz_hdr__history_u c
        On c.cd_aerop       = a.cd_aerop
       And c.dt_mov_ini     = a.dt_mov_ini
       And c.dt_mov_fim     = a.dt_mov_fim
       And c.chg_type      in ('M', 'A')
       And c.chg_trans      = 'upa9931'
       And c.col_id        in ('980979', '980980', '980981', '980982', '0')
       And c.dt_time        = (Select max(d.dt_time) 
                                 From pax_val_quinz_hdr__history_u d (nolock)
                                Where d.cd_aerop		= c.cd_aerop
                                  And d.dt_mov_ini		= c.dt_mov_ini
                                  And d.dt_mov_fim		= c.dt_mov_fim
                                  And d.chg_type		= c.chg_type
                                  And d.chg_trans		= 'upa9931'
                                  And d.col_id			= c.col_id)
      Left join DBSwact..user_master_1 u1 (nolock)
        On u1.user_id       = a.user_res_val
      Left join DBSwact..user_master_1 u2 (nolock)
        On u2.user_id       = a.user_aut_fat
      Left join DBSwact..user_master_1 u3 (nolock)
        On c.user_id        = substring(u3.user_id,1,10)
     Where a.cd_aerop       = @p_cd_aerop 
       And a.dt_mov_ini     = @p_dt_mov_ini 
       And a.dt_mov_fim     = @p_dt_mov_fim 
     Order by
           c.dt_time desc
