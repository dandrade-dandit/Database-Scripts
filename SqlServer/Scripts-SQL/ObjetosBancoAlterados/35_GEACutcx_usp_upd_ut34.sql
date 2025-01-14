USE [GEACutcx]
GO
/****** Object:  StoredProcedure [dbo].[usp_upd_ut34]    Script Date: 12/03/2010 11:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists(select * from sysobjects where name = 'usp_upd_ut34')
   drop Procedure usp_upd_ut34
go

Create PROCEDURE [dbo].[usp_upd_ut34] 
    ( @p_cd_aerop           char(4), 
      @p_no_aerop           varchar(40), 
      @p_recv_entity_id     char(5),
      @p_cd_regional		char(2),
      @p_cd_aerop_num		char(3),
      @p_sigla_aerop_iata   char(3),
      @p_date_created       datetime, 
      @p_user_id_created    char(30), 
      @p_date_changed       datetime, 
      @p_user_id_changed    char(30), 
      @p_inactive_ind       char(1), 
      @p_active_date        datetime, 
      @p_old_chgstamp       smallint ) 
AS 
    DECLARE @ret int  
    EXEC @ret = sp_dbs_authenticate 
 
    IF @ret != 0 RETURN 
 
    DECLARE @w_new_chgstamp smallint 
    EXEC sp_dbs_calc_chgstamp @p_old_chgstamp, @w_new_chgstamp OUTPUT 

    -- Inicio da verificacao do status de ativacao
    declare @wdt_ativo datetime

    if @p_inactive_ind = '0' 
    begin
        if @p_active_date = ""
            select @wdt_ativo = getdate()
        else
            select @wdt_ativo = @p_active_date
    end
    else 
        select @wdt_ativo = ""

    -- fim da verificacao do status de ativacao

    UPDATE cor_aeroporto_u 
       SET no_aerop			= @p_no_aerop, 
           recv_entity_id	= @p_recv_entity_id,
           cd_regional		= @p_cd_regional,
           cd_aerop_num		= @p_cd_aerop_num,
           sigla_aerop_iata = @p_sigla_aerop_iata,
           date_created		= @p_date_created, 
           user_id_created	= @p_user_id_created, 
           date_changed		= getdate(), 		--@p_date_changed, 
           user_id_changed	= suser_sname(),	--@p_user_id_changed, 
           inactive_ind		= @p_inactive_ind, 
           active_date		= @wdt_ativo,		--@p_active_date,         
           chgstamp			= @w_new_chgstamp 
     WHERE cd_aerop			= @p_cd_aerop 
       AND chgstamp			= @p_old_chgstamp 
 
    IF @@rowcount = 0 
    BEGIN 
        IF EXISTS ( SELECT * 
                      FROM cor_aeroporto_u with (NOLOCK INDEX = P_cor_aeroporto_u)
                     WHERE cd_aerop        = @p_cd_aerop ) 
            RAISERROR 20001 'Row updated by another user.'
        ELSE 
            RAISERROR 20002 'Row does not exist.'
        RETURN 
    END 
 
    SELECT @w_new_chgstamp
