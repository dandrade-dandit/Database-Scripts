USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_upd_upla]    Script Date: 12/16/2010 17:46:18 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_upd_upla    Script Date: 19/09/2008 15:21:17 ******/

if exists(select * from sysobjects where name = 'usp_upd_upla')
   drop procedure usp_upd_upla
go


Create PROCEDURE [dbo].[usp_upd_upla] 
	  ( @p_cd_aerop               char(4), 
		@p_cd_terminal            char(10), 
		@p_dt_mov                 datetime, 
        @p_cd_cia_aerea_key       char(3),
        @p_voo_rea_key            char(4),
		@p_nro_selo_electronico   char(14),  
		@p_tp_natureza            char(1), 
		@p_selo_status            char(1), 
		@p_cd_motivo              char(2), 
		@p_tp_fat                 char(1), 
		@p_cd_cia_aerea           char(3), 
		@p_tp_unid                char(1), 
		@p_dt_confirma            datetime, 
		@p_cd_aerop_utilizacao    char(4), 
		@p_cd_terminal_utilizacao char(10), 
		@p_tp_coletor             char(16), 
		@p_item_fat               char(26), 
		@p_billing_line_id        int, 
		@p_billing_int_date       datetime, 
		@p_billing_int_type       char(1), 
		@p_billing_user_1         char(10), 
		@p_voo_rea					char(4), 					
		@p_dt_voo_rea				datetime,
		@p_hh_voo_rea				char(6),
		@p_hh_mov					char(6), 
		@p_date_created           datetime, 
		@p_user_id_created        char(30), 
		@p_date_changed           datetime, 
		@p_user_id_changed        char(30), 
		@p_inactive_ind           char(1), 
		@p_active_date            datetime, 
		@p_old_chgstamp           smallint ) 
AS 
DECLARE @ret 			int 
	,@v_item_fat		char(26)
EXEC @ret = sp_dbs_authenticate 

IF @ret != 0 RETURN 
 
DECLARE @w_new_chgstamp smallint 
EXEC sp_dbs_calc_chgstamp @p_old_chgstamp, @w_new_chgstamp OUTPUT 

-- Inicio da verificacao do status de ativacao
if @p_inactive_ind = '0' 
   begin
      if @p_active_date = ''
         select @p_active_date = getdate()
   end
else 
   select @p_active_date = ''
-- fim da verificacao do status de ativacao

/* 001 Alteração para utilizar item de selos a vista
	- Responsable	: José Muñoz
	- Data			: 04/10/2007
*/
if @p_tp_fat = 'A' and @p_tp_natureza in ('D','I')
begin
	SELECT TOP 1 @v_item_fat = ISNULL(item_id,'')
	FROM GEACutcx..cor_item_pax_u 	(NOLOCK INDEX = P_cor_item_pax_u)
	WHERE cd_aerop      		= @p_cd_aerop 	    AND cd_terminal     	= @p_cd_terminal 
	    AND tp_natureza     	= @p_tp_natureza 
	    AND dt_vigencia			<= @p_dt_mov
		and inactive_ind		= '0'
		AND RIGHT(RTRIM(item_id),1) = 'V'
	ORDER BY   dt_vigencia DESC
end
else
begin
	SELECT TOP 1 @v_item_fat = ISNULL(item_id,'')
	FROM GEACutcx..cor_item_pax_u 	(NOLOCK INDEX = P_cor_item_pax_u)
	WHERE cd_aerop      		= @p_cd_aerop 
	    AND cd_terminal     	= @p_cd_terminal 
	    AND tp_natureza     	= @p_tp_natureza 
	    AND dt_vigencia			<= @p_dt_mov
		and inactive_ind		= '0'
		AND RIGHT(RTRIM(item_id),1) <> 'V'
	ORDER BY   dt_vigencia DESC
end

/* Original 
SELECT TOP 1 @v_item_fat = ISNULL(item_id,'')
FROM GEACutcx..cor_item_pax_u 	(NOLOCK INDEX = P_cor_item_pax_u)
WHERE cd_aerop      		= @p_cd_aerop 
    AND cd_terminal     	= @p_cd_terminal 
    AND tp_natureza     	= @p_tp_natureza 
    AND dt_vigencia			<= @p_dt_mov
    AND inactive_ind		= '0'
ORDER BY   dt_vigencia DESC
*/
/* 001 FIM Alteração para utilizar item de selos a vista
	- Responsable	: José Muñoz
	- Data			: 04/10/2007
*/

if @p_tp_coletor = 'MA'
	set @p_tp_coletor = '03'
 
UPDATE pax_selo_electronico_u 
	SET tp_natureza			= @p_tp_natureza, 
	selo_status				= @p_selo_status, 
	cd_motivo              	= @p_cd_motivo, 
	tp_fat                 	= @p_tp_fat, 
	cd_cia_aerea           	= @p_cd_cia_aerea, 
	tp_unid                	= @p_tp_unid, 
	dt_confirma            	= @p_dt_confirma, 
	cd_aerop_utilizacao    	= @p_cd_aerop_utilizacao, 
	cd_terminal_utilizacao 	= @p_cd_terminal_utilizacao, 
	tp_coletor             	= @p_tp_coletor, 
	item_fat               	= @v_item_fat, 
	billing_line_id        	= @p_billing_line_id, 
	billing_int_date       	= @p_billing_int_date, 
	billing_int_type       	= @p_billing_int_type, 
	billing_user_1         	= @p_billing_user_1, 
	voo_rea					= @p_voo_rea,
	dt_voo_rea				= @p_dt_voo_rea,
	hh_voo_rea				= @p_hh_voo_rea,
	hh_mov					= @p_hh_mov,
	date_changed 			= getdate(),   		--@p_date_changed, 
	user_id_changed  		= suser_sname(),  	--@p_user_id_changed, 
	inactive_ind           	= @p_inactive_ind, 
	active_date            	= @p_active_date, 
	chgstamp               	= @w_new_chgstamp 
WHERE cd_aerop              		= @p_cd_aerop 
	AND cd_terminal            		= @p_cd_terminal 
	AND CONVERT(VARCHAR,dt_mov,112)	= @p_dt_mov 
	AND nro_selo_electronico   		= @p_nro_selo_electronico 
	AND chgstamp               		= @p_old_chgstamp 
 
  IF @@rowcount = 0 
  BEGIN 
      IF EXISTS ( SELECT * 
                    FROM pax_selo_electronico_u (nolock)
                   WHERE cd_aerop               	= @p_cd_aerop 
                     AND cd_terminal            	= @p_cd_terminal 
                     AND CONVERT(VARCHAR,dt_mov,112)= @p_dt_mov 
                     AND nro_selo_electronico   	= @p_nro_selo_electronico ) 
          RAISERROR 20001 'Row updated by another user.'
      ELSE 
          RAISERROR 20002 'Row does not exist.'
      RETURN 
  END 
 
  SELECT @w_new_chgstamp
