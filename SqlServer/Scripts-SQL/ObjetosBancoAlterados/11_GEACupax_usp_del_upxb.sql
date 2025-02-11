USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_del_upxb]    Script Date: 12/28/2010 09:23:02 ******/


if exists(select * from sysobjects where name = 'usp_del_upxb')
   drop procedure usp_del_upxb
go


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

 
Create PROCEDURE [dbo].[usp_del_upxb] 
               ( @p_cd_aerop                       char(4), 
                 @p_cd_terminal                    char(10), 
                 @p_dt_mov                         datetime, 
                 @p_nro_selo_electronico           char(14), 
                 @p_old_chgstamp                   smallint ) 
AS 
  DECLARE @ret int 
     EXEC @ret = sp_dbs_authenticate 
 
  IF @ret != 0 RETURN 
 
  DELETE pax_selos_bd_u 
   WHERE cd_aerop                       = @p_cd_aerop 
     AND cd_terminal                    = @p_cd_terminal 
     AND dt_mov                         = @p_dt_mov 
     AND nro_selo_electronico           = @p_nro_selo_electronico 
     AND chgstamp                       = @p_old_chgstamp 
 
  IF @@rowcount = 0 
  BEGIN 
      IF EXISTS ( SELECT * 
                    FROM pax_selos_bd_u 
                   WHERE cd_aerop                       = @p_cd_aerop 
                     AND cd_terminal                    = @p_cd_terminal 
                     AND dt_mov                         = @p_dt_mov 
                     AND nro_selo_electronico           = @p_nro_selo_electronico ) 
          RAISERROR 20001 "Row updated by another user." 
      ELSE 
          RAISERROR 20002 "Row does not exist." 
      RETURN 
  END 
 
 
go

Grant Execute on usp_del_upxb to Public
go