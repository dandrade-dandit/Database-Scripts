-- Start of DDL Script for View IFRBDE.VIW_TOTAL_CRONOGRAMA_REAL
-- Generated 2-dez-2004 20:20:25 from SYSMAN@HOMOLOG2

CREATE OR REPLACE VIEW ifrbde.viw_total_cronograma_real (
   num_carencia,
   ano_pgose,
   val_total_cronogramado )
AS
SELECT   a.cnt_cre_cod, e.num_ano_pgose, SUM (e.val_pagamento)
    FROM ifrbde.tab_contrato a,
         ifrbde.cad_resumo_valores b,
         ifrbde.cad_resumo_cronograma c,
         ifrbde.cad_resumo_pagamento d,
         ifrbde.cad_pagamento_contrato e
   WHERE (    (a.num_seq_contrato = b.num_seq_contrato_res)
          AND (b.num_seq_resumo = c.num_seq_contrato_rc)
         )
     AND c.num_seq_resumo_pag = d.num_seq_resumo_pag
     AND d.num_seq_resumo_pag = e.num_seq_contrato_pag
GROUP BY a.cnt_cre_cod, e.num_ano_pgose, c.val_resumo_crno
UNION
SELECT   a.cnt_cre_cod, TO_CHAR (c.dat_vencimento_rc, 'yyyy'),
         SUM (c.val_resumo_crno)
    FROM tab_contrato a, cad_resumo_valores b, cad_resumo_cronograma c
   WHERE (    (a.num_seq_contrato = b.num_seq_contrato_res)
          AND (b.num_seq_resumo = c.num_seq_contrato_rc)
         )
     AND c.num_seq_resumo_pag IS NULL
GROUP BY a.cnt_cre_cod, TO_CHAR (c.dat_vencimento_rc, 'yyyy')
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_total_cronograma_real TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_TOTAL_CRONOGRAMA_REAL

