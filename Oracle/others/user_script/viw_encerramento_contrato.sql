/* Formatted on 2007/01/05 14:34 (Formatter Plus v4.8.0) */
CREATE OR REPLACE VIEW viw_encerramento_contrato (cnt_cre_cod,
                                                  cnt_cod,
                                                  cnt_justificativa_cre,
                                                  cnt_ice_cod,
                                                  cnt_data_proposta,
                                                  cnt_data,
                                                  cnt_data_inicio,
                                                  cnt_prazo_exec,
                                                  cnt_prazo_adit,
                                                  cnt_valor,
                                                  cnt_valor_compromisso,
                                                  cnt_valor_termo,
                                                  cnt_valor_reaj,
                                                  cnt_valor_pago,
                                                  cnt_valor_reaj_pago,
                                                  cnt_cei,
                                                  cnt_crea,
                                                  num_seq_gestor,
                                                  num_seq_assinatura_1,
                                                  num_seq_assinatura_2,
                                                  num_ato_administrativo,
                                                  num_seq_contrato,
                                                  dat_termino_contrato,
                                                  num_prazo_exec_meses,
                                                  tip_situacao_contrato,
                                                  cod_dep_contrato,
                                                  tip_contrato,
                                                  num_contrato_original,
                                                  flg_numero_padrao,
                                                  num_versao_contrato,
                                                  num_termo_aditivo,
                                                  dat_termo_aditivo,
                                                  dsc_critica_contrato,
                                                  dat_publicacao,
                                                  num_dou_publicacao,
                                                  num_pagina_publicacao,
                                                  num_secao_publicacao,
                                                  cod_modalidade_licitacao,
                                                  num_inciso,
                                                  dsc_fundamento_legal,
                                                  num_licitacao,
                                                  num_ano_licitacao,
                                                  num_processo
                                                 )
AS
   SELECT cnt_cre_cod, cnt_cod, cnt_justificativa_cre, cnt_ice_cod,
          cnt_data_proposta, cnt_data, cnt_data_inicio, cnt_prazo_exec,
          cnt_prazo_adit, cnt_valor, cnt_valor_compromisso, cnt_valor_termo,
          cnt_valor_reaj, cnt_valor_pago, cnt_valor_reaj_pago, cnt_cei,
          cnt_crea, num_seq_gestor, num_seq_assinatura_1,
          num_seq_assinatura_2, num_ato_administrativo, num_seq_contrato,
          dat_termino_contrato, num_prazo_exec_meses, tip_situacao_contrato,
          cod_dep_contrato, tip_contrato, num_contrato_original,
          flg_numero_padrao, num_versao_contrato, num_termo_aditivo,
          dat_termo_aditivo, dsc_critica_contrato, dat_publicacao,
          num_dou_publicacao, num_pagina_publicacao, num_secao_publicacao,
          cod_modalidade_licitacao, num_inciso, dsc_fundamento_legal,
          num_licitacao, num_ano_licitacao, num_processo
     FROM ifrbde.tab_contrato a
    WHERE dat_termino_contrato <= SYSDATE
      AND cnt_cre_cod IN (SELECT cre_cod
                            FROM ifrbde.viw_carencia)
/
-- Grants for View
GRANT SELECT ON viw_encerramento_contrato TO bde_geral
/
GRANT UPDATE ON viw_encerramento_contrato TO bde_geral
/

