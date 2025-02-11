USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_ins_upla]    Script Date: 12/16/2010 17:44:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_ins_upla    Script Date: 19/09/2008 15:20:43 ******/


if exists(select * from sysobjects where name = 'usp_ins_upla')
   drop procedure usp_ins_upla
go


Create PROCEDURE [dbo].[usp_ins_upla] 
			( @p_cd_aerop				char(4), 
			@p_cd_terminal				char(10), 
			@p_dt_mov					datetime, 
			@p_nro_selo_electronico		char(14), 
			@p_tp_natureza				char(1), 
			@p_selo_status				char(1), 
			@p_cd_motivo				char(2), 
			@p_tp_fat					char(1), 
			@p_cd_cia_aerea				char(3), 
			@p_tp_unid					char(1), 
			@p_dt_confirma				datetime, 
			@p_cd_aerop_utilizacao		char(4), 
			@p_cd_terminal_utilizacao	char(10), 
			@p_tp_coletor				char(16), 
			@p_item_fat					char(26), 
			@p_billing_line_id			int, 
			@p_billing_int_date			datetime, 
			@p_billing_int_type			char(1), 
			@p_billing_user_1			char(10), 
			@p_voo_rea					char(4), 					
			@p_dt_voo_rea				datetime,
			@p_hh_voo_rea				char(6), 
			@p_hh_mov					char(6), 
			@p_date_created				datetime, 
			@p_user_id_created			char(30), 
			@p_date_changed				datetime, 
			@p_user_id_changed			char(30), 
			@p_inactive_ind				char(1), 
			@p_active_date				datetime ) 
AS 
DECLARE @ret 		int 
	,@v_item_fat	char(26)

EXEC @ret = sp_dbs_authenticate 
 
IF @ret != 0 RETURN 

IF @p_active_date 	= ''
  	SET @p_active_date 	= GETDATE()

IF  @p_user_id_created IS NULL OR LTRIM(RTRIM(@p_user_id_created)) = ''                     
  	SELECT @p_user_id_created =  suser_sname()  

IF @p_tp_coletor = 'MA'
	SET @p_tp_coletor = '03'

--  BUSCAR EL ITEM    

/* 001 Alteração para utilizar item de selos a vista
	- Responsable	: José Muñoz
	- Data			: 04/10/2007
*/
if @p_tp_fat = 'A' and @p_tp_natureza in ('D','I')
begin
	SELECT TOP 1 @v_item_fat = ISNULL(item_id,'')
	FROM GEACutcx..cor_item_pax_u 	(NOLOCK INDEX = P_cor_item_pax_u)
	WHERE cd_aerop      		= @p_cd_aerop 
	    AND cd_terminal     	= @p_cd_terminal 
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


INSERT INTO pax_selo_electronico_u 
	( cd_aerop, 
	cd_terminal, 
	dt_mov, 
	nro_selo_electronico, 
	tp_natureza, 
	selo_status, 
	cd_motivo, 
	tp_fat, 
	cd_cia_aerea, 
	tp_unid, 
	dt_confirma, 
	cd_aerop_utilizacao, 
	cd_terminal_utilizacao, 
	tp_coletor, 
	item_fat, 
	billing_line_id, 
	billing_int_date, 
	billing_int_type, 
	billing_user_1, 
	voo_rea,
	dt_voo_rea,
	hh_voo_rea,
	hh_mov,
	user_id_created, 
	date_created, 
	date_changed, 
	user_id_changed, 
	inactive_ind, 
	active_date, 
	chgstamp ) 
VALUES ( @p_cd_aerop, 
	@p_cd_terminal, 
	@p_dt_mov, 
	@p_nro_selo_electronico, 
	@p_tp_natureza, 
	@p_selo_status, 
	@p_cd_motivo, 
	@p_tp_fat, 
	@p_cd_cia_aerea, 
	@p_tp_unid, 
	@p_dt_confirma, 
	@p_cd_aerop_utilizacao, 
	@p_cd_terminal_utilizacao, 
	@p_tp_coletor, 
	@v_item_fat, 
	@p_billing_line_id, 
	@p_billing_int_date, 
	@p_billing_int_type, 
	@p_billing_user_1, 
	@p_voo_rea,
	@p_dt_voo_rea,
	@p_hh_voo_rea,
	@p_hh_mov,
	@p_user_id_created, 
	getdate(),		
	@p_date_changed, 
	@p_user_id_changed, 
	'0',
	@p_active_date, 
	0 )
