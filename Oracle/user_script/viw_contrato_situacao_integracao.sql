/* Formatted on 2005/03/01 13:37 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_contrato_integracao
(
 date_changed, 
 date_created,
 num_seq_contrato, 
 tip_situacao_contrato,
 cnt_cod, 
 num_versao_contrato,
 contract_id, 
 contract_versao,
 contract_status_code,
 contract_prev_status_code
)
AS
SELECT conf_identificacao_u.date_changed, conf_identificacao_u.date_created,tab_contrato.num_seq_contrato, tab_contrato.tip_situacao_contrato,
       tab_contrato.cnt_cod, tab_contrato.num_versao_contrato,
       conf_identificacao_u.contract_id, conf_identificacao_u.contract_versao,
       conf_identificacao_u.contract_status_code,
       conf_identificacao_u.contract_prev_status_code
  FROM ifrbde.tab_contrato, integracao.conf_identificacao_u
 WHERE (    (tab_contrato.cnt_cod = conf_identificacao_u.contract_id)
        AND (tab_contrato.num_versao_contrato =
                                          conf_identificacao_u.contract_versao
            )
       )
/
-- Grants for View
GRANT SELECT ON ifrbde.viw_contrato_integracao TO bde_geral
/

