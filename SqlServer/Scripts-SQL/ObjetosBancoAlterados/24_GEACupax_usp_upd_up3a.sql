USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_upd_up3a]    Script Date: 12/15/2010 10:41:55 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_upd_up3a    Script Date: 19/09/2008 15:21:13 ******/

if exists(select * from sysobjects where name = 'usp_upd_up3a')
   drop procedure usp_upd_up3a
go

Create PROCEDURE [dbo].[usp_upd_up3a] 
               ( @p_serial                  char(9), 
                 @p_dependencia             char(3), 
                 @p_sigla                   char(4), 
                 @p_date_created        	datetime, 
				 @p_user_id_created     	char(30), 
				 @p_date_changed        	datetime, 
				 @p_user_id_changed     	char(30), 
				 @p_inactive_ind        	char(1), 
                 @p_active_date         	datetime,
                 @p_old_chgstamp            smallint ) 
AS 
  DECLARE @ret int 
  EXEC @ret = sp_dbs_authenticate 
 
  IF @ret != 0 RETURN 
 
  DECLARE @w_new_chgstamp smallint 
  EXEC sp_dbs_calc_chgstamp @p_old_chgstamp, @w_new_chgstamp OUTPUT 
 
  UPDATE pax_coletor_u 
     SET dependencia      = @p_dependencia, 
         sigla            = @p_sigla, 
         date_created     = @p_date_created, 
         user_id_created  = @p_user_id_created, 
         date_changed     = getdate(), 
         user_id_changed  = suser_sname(), 
         inactive_ind     = @p_inactive_ind, 
         active_date      = @p_active_date,
         chgstamp         = @w_new_chgstamp 
   WHERE serial           = @p_serial 
     AND chgstamp         = @p_old_chgstamp 
 
  IF @@rowcount = 0 
  BEGIN 
      IF EXISTS ( SELECT * 
                    FROM pax_coletor_u 
                   WHERE serial       = @p_serial ) 
          RAISERROR 20001 "Row updated by another user." 
      ELSE 
          RAISERROR 20002 "Row does not exist." 
      RETURN 
  END 
 
  SELECT @w_new_chgstamp
