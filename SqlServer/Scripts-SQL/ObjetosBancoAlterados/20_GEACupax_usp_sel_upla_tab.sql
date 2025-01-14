USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_sel_upla_tab]    Script Date: 12/15/2010 18:21:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_sel_upla_tab    Script Date: 19/09/2008 15:21:02 ******/

/*
exec usp_sel_upla_tab 'SBBR', '1', '20081101', 'ONE', '6124'
*/

if exists(select * from sysobjects where name = 'usp_sel_upla_tab')
   drop procedure usp_sel_upla_tab
go


Create PROCEDURE [dbo].[usp_sel_upla_tab] 
    ( @p_cd_aerop             char(4), 
      @p_cd_terminal          char(10), 
      @p_dt_mov               datetime,
      @p_cd_cia_aerea         char(3), 
      @p_voo_rea              char(4) ) 
AS 
    If @p_cd_cia_aerea = '###'  Set @p_cd_cia_aerea = ''
    If @p_voo_rea      = '####' Set @p_voo_rea      = ''

    SELECT A.nro_selo_electronico 
          ,A.tp_natureza 
          ,A.selo_status 
          ,A.cd_motivo 
          ,A.tp_fat 
          ,A.cd_cia_aerea 
          ,A.tp_unid 
          ,A.dt_confirma 
          ,A.cd_aerop_utilizacao 
          ,A.cd_terminal_utilizacao 
          ,A.tp_coletor 
          ,A.item_fat 
          ,A.billing_line_id 
          ,A.billing_int_date 
          ,A.billing_int_type 
          ,A.billing_user_1 
          ,A.voo_rea
          ,A.dt_voo_rea
          ,A.hh_voo_rea
          ,A.hh_mov	
          ,A.date_created 
          ,A.user_id_created 
          ,A.date_changed 
          ,A.user_id_changed 
          ,A.inactive_ind 
          ,A.active_date 
          ,A.chgstamp
          ,ds_natureza          = LTRIM(RTRIM(B.descp)) 
          ,ds_selo_status       = LTRIM(RTRIM(C.descp)) 
          ,ds_motivocnc         = LTRIM(RTRIM(ISNULL(D.ds_motivocnc,'')))
          ,ds_tp_fat            = LTRIM(RTRIM(E.descp))
          ,ds_cia_aerea         = LTRIM(RTRIM(F.no_cia_aerea))
          ,ds_unid              = LTRIM(RTRIM(ISNULL(G.descp,'')))
          ,ds_aerop_utilizacao  = CASE WHEN A.cd_aerop_utilizacao IS NULL THEN '' ELSE A.cd_aerop_utilizacao + ' - ' + LTRIM(RTRIM(H.no_aerop)) END 
          ,ds_tp_coletor        = LTRIM(RTRIM(I.descp))
      FROM pax_selo_electronico_u              A (nolock)
     INNER JOIN GEACCOMMON..dropdowndw_u       B (NOLOCK INDEX = PK_dropdowndw_u)
        ON B.tbl_code                        = 'NTRI'
       AND B.code                            = A.tp_natureza
     INNER JOIN GEACCOMMON..dropdowndw_u       C (NOLOCK INDEX = PK_dropdowndw_u)
        ON C.tbl_code                        = 'STSL'
       AND C.code                            = A.selo_status
      LEFT JOIN GEACutcx..cor_motivocnc_selo_u D (NOLOCK INDEX = P_cor_motivocnc_selo_u)
        ON D.cd_motivo                       = A.cd_motivo
     INNER JOIN GEACCOMMON..dropdowndw_u       E (NOLOCK INDEX = PK_dropdowndw_u)
        ON E.tbl_code                        = 'TPFT'
       AND E.code                            = A.tp_fat
     INNER JOIN GEACutcx..cor_cia_aerea_u      F (NOLOCK INDEX = P_cor_cia_aerea_u)
        ON F.cd_cia_aerea                    = A.cd_cia_aerea
      LEFT JOIN GEACCOMMON..dropdowndw_u       G (NOLOCK INDEX = PK_dropdowndw_u)
        ON G.tbl_code                        = 'TPUN'
       AND G.code                            = A.tp_unid
      LEFT JOIN GEACutcx..cor_aeroporto_u      H (NOLOCK INDEX = P_cor_aeroporto_u)
        ON H.cd_aerop                        = A.cd_aerop_utilizacao
     INNER JOIN GEACCOMMON..dropdowndw_u       I (NOLOCK INDEX = PK_dropdowndw_u)
        ON I.tbl_code                        = 'TPCL'
       AND I.code                            = A.tp_coletor
     WHERE A.cd_aerop						 = @p_cd_aerop 
	   AND A.cd_terminal					 = @p_cd_terminal 
	   AND CONVERT(VARCHAR,A.dt_mov,112)	 = @p_dt_mov
       And A.cd_cia_aerea                 Like Rtrim(@p_cd_cia_aerea) + '%'
       And A.voo_rea                      Like Rtrim(@p_voo_rea)      + '%'

