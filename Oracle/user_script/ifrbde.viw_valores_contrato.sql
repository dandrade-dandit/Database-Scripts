-- Start of DDL Script for View IFRBDE.VIW_VALORES_CONTRATO
-- Generated 6-jan-2005 14:51:40 from IFRBDE@PRODSEDE2

CREATE OR REPLACE VIEW viw_valores_contrato (
   num_seq_resumo_rv,
   num_seq_contrato_res_rv,
   val_inicial_resumo_rv,
   val_saldo_resumo_rv,
   val_resumo_rv,
   val_termo_rv,
   val_pagamento_rv,
   val_reajuste_rv,
   val_pago_rv,
   val_pago_reajuste_rv,
   flg_moeda_controle_rv,
   num_seq_indice_rv,
   tip_moeda_rv,
   dat_moeda_rv,
   val_saldo_resumo_sec_rv,
   val_resumo_sec_rv,
   val_termo_sec_rv,
   val_pagamento_sec_rv,
   val_reajuste_sec_rv,
   val_pago_sec_rv,
   val_pago_reajuste_sec_rv,
   cod_recurso_res_rv,
   val_cotacao_moeda_rv,
   tip_cotacao_moeda_rv,
   cnt_cre_cod_res,
   cnt_cod_res,
   num_versao_contrato_res_rv,
   val_crono_realizado_pag, 
   val_crono_realizado_reaj )
AS
SELECT a.num_seq_resumo,
          a.num_seq_contrato_res,
          a.val_inicial_resumo,
          a.val_saldo_resumo,
          a.val_resumo,
          a.val_termo,
          a.val_pagamento,
          a.val_reajuste,
          a.val_pago,
          a.val_pago_reajuste,
          a.flg_moeda_controle,
          a.num_seq_indice,
          a.tip_moeda,
          a.dat_moeda,
          a.val_saldo_resumo_sec,
          a.val_resumo_sec,
          a.val_termo_sec,
          a.val_pagamento_sec,
          a.val_reajuste_sec,
          a.val_pago_sec,
          a.val_pago_reajuste_sec,
          a.cod_recurso_res,
          a.val_cotacao_moeda,
          a.tip_cotacao_moeda,
          b.cnt_cre_cod,
          b.cnt_cod,
          a.num_versao_contrato_res,
          a.val_crono_realizado_pag, 
          a.val_crono_realizado_reaj
     FROM ifrbde.cad_resumo_valores a,
          ifrbde.tab_contrato b
    WHERE a.num_seq_contrato_res = b.num_seq_contrato
      AND b.cnt_cre_cod IN (SELECT cre_cod
                              FROM ifrbde.viw_carencia)
/

-- Grants for View
GRANT DELETE ON viw_valores_contrato TO bde_geral
/
GRANT INSERT ON viw_valores_contrato TO bde_geral
/
GRANT SELECT ON viw_valores_contrato TO bde_geral
/
GRANT UPDATE ON viw_valores_contrato TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_VALORES_CONTRATO

