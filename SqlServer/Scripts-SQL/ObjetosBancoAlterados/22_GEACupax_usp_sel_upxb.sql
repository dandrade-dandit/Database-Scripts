USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_upxb]    Script Date: 12/28/2010 09:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists(select * from sysobjects where name = 'usp_sel_upxb')
   drop procedure usp_sel_upxb
go

 
Create PROCEDURE [dbo].[usp_sel_upxb] 
               ( @p_cd_aerop                       char(4), 
                 @p_cd_terminal                    char(10), 
                 @p_dt_mov                         datetime, 
                 @p_nro_selo_electronico           char(14) ) 
AS 
  SELECT cd_aerop, 
         cd_terminal, 
         dt_mov, 
         nro_selo_electronico, 
         format_code, 
         num_legs_encode, 
         passenger_name, 
         eletronic_ticket_ind, 
         oper_carrier_pnr_code, 
         source_code, 
         target_code, 
         oper_carrier_designator, 
         flight_number, 
         flight_date, 
         compartiment_code, 
         seat_number, 
         checkin_seq_number, 
         passenger_status, 
         field_size_follow_var, 
         beginning_version_number, 
         version_number, 
         field_size_follow_struc_unique, 
         passenger_desc, 
         checkin_source, 
         boarding_pass_source, 
         boarding_pass_date, 
         document_type, 
         airline_desig_boarding_pass, 
         field_size_follow_struc_repeat, 
         airline_numeric_code, 
         document_form_serial_num, 
         selectee_indicator, 
         international_doc_verification, 
         marketing_carrier_designator, 
         frequent_flyer_airline_desig, 
         frequent_flyer_num, 
         id_ad_indicator, 
         free_baggage_allowance, 
         generic_individual_airline_use, 
         date_created, 
         user_id_created, 
         date_changed, 
         user_id_changed, 
         inactive_ind, 
         active_date, 
         chgstamp 
    FROM pax_selos_bd_u 
   WHERE cd_aerop                       = @p_cd_aerop 
     AND cd_terminal                    = @p_cd_terminal 
     AND dt_mov                         = @p_dt_mov 
     AND nro_selo_electronico           = @p_nro_selo_electronico 
 
go 

Grant Execute on [dbo].[usp_sel_upxb] to Public
go