-- Start of DDL Script for View IFRBDE.VIW_REL_REMANEJAMENTO
-- Generated 24-mar-2005 11:14:51 from IFRBDE@PRODSEDE2

CREATE OR REPLACE VIEW viw_rel_remanejamento (
   cre_projeto_orig,
   rmj_seq_orig,
   rmj_dep_orig,
   dpp_desc_orig,
   dpp_sigla_orig,
   dep_desc_orig,
   dep_sigla_orig,
   rti_sigla_orig,
   rmj_obj_orig,
   rmj_rti_cod_orig,
   rap_valor_orig,
   dat_remanejamento,
   rmj_usuario,
   rmj_valor,
   rmj_ano,
   rmj_cod,
   cre_projeto_dest,
   rmj_seq_dest,
   rmj_dep_dest,
   dpp_desc_dest,
   dpp_sigla_dest,
   dep_desc_dest,
   dep_sigla_dest,
   rti_sigla_dest,
   rmj_obj_dest,
   rmj_rti_cod_dest,
   rap_valor_dest,
   justificativa )
AS
SELECT
       DECODE(tab_carencia.cre_projeto,'R','REGIONAL','S','SEDE'),
       viw_remanejamento.rmj_seq_orig,
       viw_remanejamento.rmj_dep_orig,
       tab_dependencia_pai.dpp_desc,
       tab_dependencia_pai.dpp_sigla,
       tab_dependencia.dep_desc,
       tab_dependencia.dep_sigla,
       tab_tipo_recurso_item.rti_sigla,
       viw_remanejamento.rmj_obj_orig,
       viw_remanejamento.rmj_rti_cod_orig,
       tab_rec_aprovado.rap_valor,
	   viw_remanejamento.dat_remanejamento,
       viw_remanejamento.rmj_usuario,
       viw_remanejamento.rmj_valor,
       viw_remanejamento.rmj_ano,
       viw_remanejamento.rmj_cod,
       DECODE(tab_carencia_destino.cre_projeto,'R','REGIONAL','S','SEDE'),
       viw_remanejamento.rmj_seq_dest,
       viw_remanejamento.rmj_dep_dest,
       regional_destino.dpp_desc,
       regional_destino.dpp_sigla,
       dep_destino.dep_desc,
       dep_destino.dep_sigla,
       recurso_destino.rti_sigla,
       viw_remanejamento.rmj_obj_dest,
       viw_remanejamento.rmj_rti_cod_dest,
       aprovacao_destino.rap_valor,
	   viw_remanejamento.dsc_justificativa
  FROM ifrbde.viw_remanejamento,
       ifrbde.tab_carencia,
       ifrbde.tab_carencia tab_carencia_destino,
       ifrbde.tab_dependencia,
       ifrbde.tab_dependencia_pai,
       ifrbde.tab_dependencia dep_destino,
       ifrbde.tab_dependencia_pai regional_destino,
       ifrbde.tab_tipo_recurso_item,
       ifrbde.tab_tipo_recurso_item recurso_destino,
       ifrbde.tab_rec_aprovado,
       ifrbde.tab_rec_aprovado aprovacao_destino
 WHERE      ((viw_remanejamento.rmj_seq_orig = tab_carencia.cre_cod)
        AND (viw_remanejamento.rmj_seq_dest = tab_carencia_destino.cre_cod)
        AND (viw_remanejamento.rmj_dep_orig = tab_dependencia.dep_cod)
        AND (tab_dependencia.dep_dpp_cod = tab_dependencia_pai.dpp_cod)
        AND (tab_dependencia_pai.dpp_cod = dep_destino.dep_dpp_cod)
        AND (viw_remanejamento.rmj_dep_dest = dep_destino.dep_cod)
        AND (dep_destino.dep_dpp_cod = regional_destino.dpp_cod)
        AND (viw_remanejamento.rmj_rti_cod_orig =tab_tipo_recurso_item.rti_cod)
        AND (viw_remanejamento.rmj_rti_cod_dest = recurso_destino.rti_cod))
        AND ((viw_remanejamento.rmj_seq_orig = tab_rec_aprovado.rap_cre_cod)
        AND (viw_remanejamento.rmj_rti_cod_orig = tab_rec_aprovado.rap_rti_cod)
        AND (viw_remanejamento.rmj_ano = tab_rec_aprovado.rap_pgose)
        AND (viw_remanejamento.rmj_ano = aprovacao_destino.rap_pgose)
        AND (viw_remanejamento.rmj_seq_dest = aprovacao_destino.rap_cre_cod)
        AND (viw_remanejamento.rmj_rti_cod_dest = aprovacao_destino.rap_rti_cod))
/

-- Grants for View
GRANT SELECT ON viw_rel_remanejamento TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REL_REMANEJAMENTO

