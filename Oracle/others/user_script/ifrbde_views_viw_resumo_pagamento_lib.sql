CREATE OR REPLACE VIEW ifrbde_views.viw_resumo_pagamento_lib (
   num_seq_resumo_pag,
   cnt_cre_cod_r,
   cnt_cod_r,
   num_fatura_rp,
   val_pagamento_rp,
   dat_pagamento,
   cod_tipo_pag_r )
AS
SELECT a.num_seq_resumo_pag, c.cnt_cre_cod, c.cnt_cod, a.num_fatura_rp,
       a.val_pagamento_rp, a.dat_pagamento, a.cod_tipo_pag_rp
  FROM ifrbde.cad_resumo_pagamento a,
       ifrbde.cad_resumo_valores b,
       ifrbde.tab_contrato c
 WHERE a.num_seq_pag_contrato_rp = b.num_seq_resumo
   AND b.num_seq_contrato_res = c.num_seq_contrato
/

-- Grants for View
GRANT DELETE ON ifrbde_views.viw_resumo_pagamento_lib TO bde_views
/
GRANT INSERT ON ifrbde_views.viw_resumo_pagamento_lib TO bde_views
/
GRANT SELECT ON ifrbde_views.viw_resumo_pagamento_lib TO bde_views
/
GRANT UPDATE ON ifrbde_views.viw_resumo_pagamento_lib TO bde_views
/
GRANT DELETE ON ifrbde_views.viw_resumo_pagamento_lib TO bde_geral
/
GRANT INSERT ON ifrbde_views.viw_resumo_pagamento_lib TO bde_geral
/
GRANT SELECT ON ifrbde_views.viw_resumo_pagamento_lib TO bde_geral
/
GRANT UPDATE ON ifrbde_views.viw_resumo_pagamento_lib TO bde_geral
/

-- End of DDL Script for View IFRBDE_VIEWS.VIW_RESUMO_PAGAMENTO_LIB


