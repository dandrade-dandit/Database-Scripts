USE [GEACutcx]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_ut34]    Script Date: 12/03/2010 11:00:34 ******/
-- exec GEACutcx..usp_sel_ut34 'SBBR'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists(select * from sysobjects where name = 'usp_sel_ut34')
   drop Procedure usp_sel_ut34
go

Create PROCEDURE [dbo].[usp_sel_ut34]  
    ( @p_cd_aerop              char(4) ) 
AS 
    DECLARE @w_com_flg         char(1) 
 
    IF EXISTS ( SELECT * 
                  FROM cor_aeroporto_u_comnt_u (nolock) 
                 WHERE cd_aerop        = @p_cd_aerop ) 
        SELECT @w_com_flg =  'Y'
    ELSE 
        SELECT @w_com_flg =  'N' 
  
    SELECT cd_aerop, 
           no_aerop, 
           recv_entity_id,
           cd_regional,
           cd_aerop_num,
           sigla_aerop_iata,
           date_created, 
           user_id_created, 
           date_changed, 
           user_id_changed, 
           inactive_ind, 
           active_date, 
           chgstamp, 
           @w_com_flg 
      FROM cor_aeroporto_u with (NOLOCK INDEX = P_cor_aeroporto_u)
     WHERE cd_aerop        = @p_cd_aerop
