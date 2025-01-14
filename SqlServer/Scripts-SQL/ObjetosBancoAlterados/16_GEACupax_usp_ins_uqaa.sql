USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_ins_uqaa]    Script Date: 12/20/2010 20:23:36 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_ins_uqaa    Script Date: 19/09/2008 15:20:52 ******/


if exists(select * from sysobjects where name = 'usp_ins_uqaa')
   drop procedure usp_ins_uqaa
go

 
Create Procedure [dbo].[usp_ins_uqaa] 
    ( @p_cd_aerop         char(4), 
      @p_data_mov         datetime, 
      @p_cd_cia_aerea     char(3), 
      @p_nro_voo          char(5), 
      @p_fl_fiscalizado   char(1), 
      @p_user_ficalizador char(30), 
      @p_fl_validado      char(1), 
      @p_user_validador   char(30),
      @p_tipo_selecao     char(1) ) 
AS 
    Declare @ret int 
    Exec    @ret = sp_dbs_authenticate 

    If @ret != 0 RETURN 
 
    Insert Into pax_fiscal_head_u 
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
    Values 
         ( @p_cd_aerop, 
           @p_data_mov, 
           @p_cd_cia_aerea, 
           @p_nro_voo, 
           @p_fl_fiscalizado, 
           @p_user_ficalizador, 
           @p_fl_validado, 
           @p_user_validador, 
           @p_tipo_selecao,
           0 )
