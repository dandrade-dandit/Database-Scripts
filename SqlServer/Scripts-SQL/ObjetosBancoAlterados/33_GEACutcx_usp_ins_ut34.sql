USE [GEACutcx]
GO
/****** Object:  StoredProcedure [dbo].[usp_ins_ut34]    Script Date: 12/03/2010 11:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists(select * from sysobjects where name = 'usp_ins_ut34')
   drop Procedure usp_ins_ut34
go

Create PROCEDURE [dbo].[usp_ins_ut34] 
    ( @p_cd_aerop           char(4), 
      @p_no_aerop        	varchar(40), 
      @p_recv_entity_id	    varchar(05),  
      @p_cd_regional		char(2),
      @p_cd_aerop_num		char(3),
      @p_sigla_aerop_iata   char(3),
      @p_date_created    	datetime, 
      @p_user_id_created 	char(30), 
      @p_date_changed    	datetime, 
      @p_user_id_changed 	char(30), 
      @p_inactive_ind    	char(1), 
      @p_active_date     	datetime ) 
AS 
    DECLARE @ret int 
    EXEC @ret = sp_dbs_authenticate 
 
    IF @ret != 0 RETURN 

    IF @p_active_date = ''
	    SET @p_active_date = GETDATE()

    INSERT INTO cor_aeroporto_u 
         ( cd_aerop, 
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
           chgstamp ) 
    VALUES 
         ( @p_cd_aerop, 
           @p_no_aerop, 
           @p_recv_entity_id,
           @p_cd_regional,
           @p_cd_aerop_num,
           @p_sigla_aerop_iata,
           getdate(),			--@p_date_created, 
           suser_sname(),		--@p_user_id_created, 
           @p_date_changed, 
           @p_user_id_changed, 
           '0',				--@p_inactive_ind, 
           @p_active_date, 
           0 )
