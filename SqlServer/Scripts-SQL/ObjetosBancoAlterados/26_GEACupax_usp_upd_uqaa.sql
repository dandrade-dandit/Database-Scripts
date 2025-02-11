USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_upd_uqaa]    Script Date: 12/21/2010 08:51:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_upd_uqaa    Script Date: 19/09/2008 15:21:21 ******/

if exists(select * from sysobjects where name = 'usp_upd_uqaa')
   drop procedure usp_upd_uqaa
go

Create Procedure [dbo].[usp_upd_uqaa] 
    ( @p_cd_aerop         char(4), 
      @p_data_mov         datetime, 
      @p_cd_cia_aerea     char(3), 
      @p_nro_voo          char(5), 
      @p_fl_fiscalizado   char(1), 
      @p_user_ficalizador char(30), 
      @p_fl_validado      char(1), 
      @p_user_validador   char(30), 
      @p_tipo_selecao     char(1),
      @p_old_chgstamp     smallint ) 
As 
    Declare @ret int 
    Exec    @ret = sp_dbs_authenticate 
 
    If @ret != 0 RETURN 
 
    Declare @w_new_chgstamp smallint 
    Exec    sp_dbs_calc_chgstamp @p_old_chgstamp, @w_new_chgstamp OUTPUT 
 
    Update pax_fiscal_head_u 
       Set fl_fiscalizado   = @p_fl_fiscalizado, 
           user_ficalizador = @p_user_ficalizador, 
           fl_validado      = @p_fl_validado, 
           user_validador   = @p_user_validador, 
           tipo_selecao     = @p_tipo_selecao,
           chgstamp         = @w_new_chgstamp 
     Where cd_aerop	        = @p_cd_aerop 
       And data_mov         = @p_data_mov 
       And cd_cia_aerea     = @p_cd_cia_aerea 
       And nro_voo          = @p_nro_voo 
       And chgstamp         = @p_old_chgstamp 
 
    If @@rowcount = 0 
    Begin 
        If Exists ( Select * 
                      From pax_fiscal_head_u (nolock)
                     Where cd_aerop         = @p_cd_aerop 
                       And data_mov         = @p_data_mov 
                       And cd_cia_aerea     = @p_cd_cia_aerea 
                       And nro_voo          = @p_nro_voo ) 
            Raiserror 20001 'Row updated by another user.' 
        Else 
            Raiserror 20002 'Row does not exist.' 
        
        Return 
    End 
 
    Exec   usp_ins_uqaa_com_adc @p_cd_aerop, @p_data_mov, @p_cd_cia_aerea, @p_nro_voo
    Select @w_new_chgstamp
