-- Start of DDL Script for View IFRBDE.VIW_CONTROLE_CONTRATO
-- Generated 21-fev-2005 15:01:01 from IFRBDE@PRODSEDE2

-- Drop the old instance of VIW_CONTROLE_CONTRATO
DROP VIEW ifrbde.viw_controle_contrato
/

CREATE OR REPLACE VIEW ifrbde.viw_controle_contrato (
   sequencial,
   projeto,
   cncod,
   cndesc,
   cnsigla,
   depcod,
   depdesc,
   depsigla,
   pgose,
   situacao_carencia,
   prioridade,
   contrato,
   objeto,
   empresa,
   dt_proposta,
   dt_inicio,
   prazo_exec,
   prazo_adit,
   valor_compromisso,
   total_ta,
   dt_termino,
   valor_pago,
   valor_reaj,
   valor_termo,
   situacao_contrato,
   cnt_valor,
   valor_total_p0,
   valor_total_sec_p0,
   moeda,
   flag_moeda )
AS
SELECT DISTINCT cre.cre_cod, cre.cre_projeto, cn.dpp_cod, cn.dpp_desc,
                cn.dpp_sigla, dep.dep_cod, dep.dep_desc, dep.dep_sigla,
                TO_NUMBER (rap.rap_pgose), cre.num_situacao_carencia,
                cre.num_prioridade_carencia, cnt.cnt_cod,
                UPPER (cnt.cnt_justificativa_cre), vfr.empresa,
                cnt.cnt_data_proposta, cnt.cnt_data_inicio, cnt.cnt_prazo_exec,
                cnt.cnt_prazo_adit, cnt.cnt_valor_compromisso, vtac.total,
                cnt.dat_termino_contrato, cnt.cnt_valor_pago,
                cnt.cnt_valor_reaj, cnt.cnt_valor_termo,
                cnt.tip_situacao_contrato, cnt.cnt_valor,
                (  cnt.cnt_valor_compromisso
                 + cnt.cnt_valor_termo
                ),
                (  crv.val_resumo
                 + crv.val_termo
                 + crv.val_reajuste
                ),
                crv.tip_moeda, crv.flg_moeda_controle
           FROM ifrbde.tab_dependencia_pai cn,
                ifrbde.tab_dependencia dep,
                ifrbde.tab_carencia cre,
                ifrbde.tab_rec_aprovado rap,
                ifrbde.viw_firma_rel vfr,
                ifrbde.viw_total_aditivo_contrato vtac,
                ifrbde.tab_contrato cnt,
                ifrbde.cad_resumo_valores crv
          WHERE cn.dpp_cod = dep.dep_dpp_cod
            AND cre.cre_dep_cod = dep.dep_cod
            AND rap.rap_cre_cod = cre.cre_cod
            AND vtac.sequencial(+) = cnt.num_seq_contrato
            AND vfr.codigo_part = cnt.num_seq_contrato
            AND cre.cre_cod = cnt.cnt_cre_cod
            AND cnt.num_seq_contrato = crv.num_seq_contrato_res
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_controle_contrato TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_CONTROLE_CONTRATO

