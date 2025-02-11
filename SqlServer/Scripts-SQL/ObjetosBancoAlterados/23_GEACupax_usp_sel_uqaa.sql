USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_uqaa]    Script Date: 12/21/2010 08:47:43 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_sel_uqaa    Script Date: 19/09/2008 15:21:11 ******/
/*
exec GEACupax..usp_sel_uqaa 'SBBR', '20080101', 'GLO', 'TODOS'
*/

if exists(select * from sysobjects where name = 'usp_sel_uqaa')
   drop procedure usp_sel_uqaa
go


Create PROCEDURE [dbo].[usp_sel_uqaa] 
    ( @p_cd_aerop         char(4), 
      @p_data_mov         datetime, 
      @p_cd_cia_aerea     char(3), 
      @p_nro_voo          char(5) ) 
AS 

    DECLARE        @w_com_flg          char(1) 

    IF EXISTS ( SELECT * 
                  FROM pax_fiscal_head_u_comnt_u 
                 WHERE cd_aerop         = @p_cd_aerop 
                   AND data_mov         = @p_data_mov 
                   AND cd_cia_aerea     = @p_cd_cia_aerea 
                   AND nro_voo          = @p_nro_voo ) 
        SELECT @w_com_flg = 'Y' 
    ELSE 
        SELECT @w_com_flg = 'N' 
 
    SELECT a.cd_aerop, 
           a.data_mov, 
           a.cd_cia_aerea, 
           a.nro_voo, 
           a.fl_fiscalizado, 
           a.user_ficalizador, 
           a.fl_validado, 
           a.user_validador, 
           a.tipo_selecao,
           a.chgstamp, 
           @w_com_flg,
           isnull(ltrim(rtrim(b.no_aerop)), '')     ds_aerop,
           isnull(ltrim(rtrim(c.no_cia_aerea)), '') ds_aerop,
           isnull(rtrim(d.user_id),'') 	            user_id_created,
           isnull(d.dt_time, '19000101')	        date_created,
           isnull(rtrim(f.user_id),'')              user_id_changed,
           isnull(f.dt_time, '19000101')	        date_changed
      FROM pax_fiscal_head_u a (nolock index = P_pax_fiscal_head_u)
      left join GEACutcx..cor_aeroporto_u b(nolock index = P_cor_aeroporto_u)
        on b.cd_aerop		= a.cd_aerop
      left join GEACutcx..cor_cia_aerea_u c(nolock index = P_cor_cia_aerea_u)
        on c.cd_cia_aerea	= a.cd_cia_aerea
      left join pax_fiscal_head_u_history_u d (nolock)
        on d.cd_aerop		= a.cd_aerop
       and d.data_mov		= a.data_mov
       and d.cd_cia_aerea	= a.cd_cia_aerea
       and d.nro_voo        = a.nro_voo
       and d.chg_type       = 'A'
       and d.dt_time        = (select max(e.dt_time)
                                 from pax_fiscal_head_u_history_u e (nolock)
                                where e.cd_aerop        = d.cd_aerop
                                  and e.data_mov        = d.data_mov
                                  and e.cd_cia_aerea    = d.cd_cia_aerea
                                  and e.nro_voo         = d.nro_voo
                                  and e.chg_type        = d.chg_type )
      left join pax_fiscal_head_u_history_u f (nolock)
        on f.cd_aerop		= a.cd_aerop
       and f.data_mov		= a.data_mov
       and f.cd_cia_aerea	= a.cd_cia_aerea
       and f.nro_voo		= a.nro_voo
       and f.chg_type		= 'M'
       and f.dt_time        = (select max(g.dt_time)
                                 from pax_fiscal_head_u_history_u g (nolock)
                                where g.cd_aerop        = f.cd_aerop
                                  and g.data_mov        = f.data_mov
                                  and g.cd_cia_aerea    = f.cd_cia_aerea
                                  and g.nro_voo         = f.nro_voo
                                  and g.chg_type        = f.chg_type )
     WHERE a.cd_aerop       = @p_cd_aerop 
       AND a.data_mov		= @p_data_mov 
       AND a.cd_cia_aerea	= @p_cd_cia_aerea 
       AND a.nro_voo		= @p_nro_voo 
 
    --select * from pax_fiscal_head_u_history_u
