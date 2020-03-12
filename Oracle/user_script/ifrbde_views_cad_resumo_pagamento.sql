CREATE OR REPLACE VIEW ifrbde_views.cad_resumo_pagamento (
   num_seq_resumo_pag,
   num_seq_pag_contrato_rp,
   cod_tipo_pag_rp,
   dsc_solicitacao_rp,
   dat_pagamento,
   num_fatura_rp,
   val_pagamento_rp,
   val_glosa_rp,
   dsc_glosa_rp,
   val_retencao_rp,
   num_seq_entidade_rp,
   val_imposto_irrf_rp,
   val_imposto_iss_rp,
   val_imposto_pasep_rp,
   val_imposto_icms_rp,
   val_imposto_inss_rp,
   val_multa_rp,
   val_liquido_nota_rp,
   dat_pagamento_st,
   dat_moeda_rp,
   val_cotacao_moeda_rp,
   tip_cotacao_moeda_rp,
   num_seq_entidade_pag,
   val_impostos_rp,
   tip_situacao_pag,
   dat_vencimento_pag,
   num_versao_contrato_pag,
   dsc_retencao_rp )
AS
SELECT num_seq_resumo_pag, num_seq_pag_contrato_rp, cod_tipo_pag_rp,
       dsc_solicitacao_rp, dat_pagamento, num_fatura_rp,
       val_pagamento_rp, val_glosa_rp, dsc_glosa_rp, val_retencao_rp,
       num_seq_entidade_rp, val_imposto_irrf_rp, val_imposto_iss_rp,
       val_imposto_pasep_rp, val_imposto_icms_rp, val_imposto_inss_rp,
       val_multa_rp, val_liquido_nota_rp, dat_pagamento_st,
       dat_moeda_rp, val_cotacao_moeda_rp, tip_cotacao_moeda_rp,
       num_seq_entidade_pag, val_impostos_rp, tip_situacao_pag ,
       dat_vencimento_pag, num_versao_contrato_pag,DSC_RETENCAO_RP
       FROM IFRBDE.cad_resumo_pagamento
/

-- Grants for View
GRANT DELETE ON ifrbde_views.cad_resumo_pagamento TO bde_views
/
GRANT INSERT ON ifrbde_views.cad_resumo_pagamento TO bde_views
/
GRANT SELECT ON ifrbde_views.cad_resumo_pagamento TO bde_views
/
GRANT UPDATE ON ifrbde_views.cad_resumo_pagamento TO bde_views
/
GRANT DELETE ON ifrbde_views.cad_resumo_pagamento TO bde_geral
/
GRANT INSERT ON ifrbde_views.cad_resumo_pagamento TO bde_geral
/
GRANT SELECT ON ifrbde_views.cad_resumo_pagamento TO bde_geral
/
GRANT UPDATE ON ifrbde_views.cad_resumo_pagamento TO bde_geral
/

-- End of DDL Script for View IFRBDE_VIEWS.CAD_RESUMO_PAGAMENTO


