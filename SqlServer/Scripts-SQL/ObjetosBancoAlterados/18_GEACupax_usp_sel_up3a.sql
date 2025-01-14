USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_up3a]    Script Date: 12/15/2010 10:37:21 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_sel_up3a    Script Date: 19/09/2008 15:20:54 ******/


if exists(select * from sysobjects where name = 'usp_sel_up3a')
   drop procedure usp_sel_up3a
go


Create PROCEDURE [dbo].[usp_sel_up3a] 
    ( @p_serial      char(9) ) 
AS
    DECLARE        @w_com_flg     char(1) 

    IF EXISTS ( SELECT * 
                  FROM pax_coletor_u_comnt_u 
                 WHERE serial      = @p_serial ) 
        SELECT @w_com_flg = "Y" 
    ELSE 
        SELECT @w_com_flg = "N" 

    SELECT a.serial, 
           a.dependencia, 
           a.sigla, 
           a.date_created, 
           a.user_id_created, 
           a.date_changed, 
           a.user_id_changed, 
           a.inactive_ind, 
           a.active_date,
           a.chgstamp, 
           @w_com_flg,
           isnull(b.dependencia_descp, ''),
           isnull(c.no_aerop, '')
      FROM pax_coletor_u a (nolock index = P_pax_coletor_u)
      left join GEACrpt..infra_dependencias b(nolock)
        on b.dependencia	= a.dependencia
      left join GEACutcx..cor_aeroporto_u c(nolock index = P_cor_aeroporto_u)
        on c.cd_aerop		= a.sigla
     WHERE a.serial         = @p_serial
