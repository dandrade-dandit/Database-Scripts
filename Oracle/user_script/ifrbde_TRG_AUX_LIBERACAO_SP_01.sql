CREATE OR REPLACE TRIGGER ifrbde.TRG_AUX_LIBERACAO_SP_01
 BEFORE 
 INSERT
 ON AUX_LIBERACAO_SP
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
   CURSOR reg (
      p_cnt_cre_cod     NUMBER,
      p_cnt_cod         VARCHAR2,
      p_num_fatura_rp   VARCHAR2
   ) IS
      SELECT d.cnt_cre_cod,
             d.cnt_cod,
             b.num_fatura_rp,
             b.num_seq_resumo_pag,
             d.num_versao_contrato,
             b.num_versao_contrato_pag
        FROM ifrbde.cad_resumo_valores c,
             ifrbde.tab_contrato d,
             ifrbde.cad_resumo_pagamento b
       WHERE (c.num_seq_contrato_res = d.num_seq_contrato)
         AND (b.num_seq_pag_contrato_rp = c.num_seq_resumo)
         AND (d.cnt_cre_cod = p_cnt_cre_cod)
         AND (d.cnt_cod = p_cnt_cod)
         AND (b.num_fatura_rp = p_num_fatura_rp);
BEGIN
   FOR regx IN reg (:NEW.cnt_cre_cod_aux, :NEW.cnt_cod_aux, :NEW.num_fatura_sp)
   LOOP
      IF regx.num_versao_contrato = regx.num_versao_contrato_pag THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 1
             WHERE num_seq_resumo_pag = regx.num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS THEN
               raise_application_error (-20100, SQLERRM);
         END;
      ELSE
         raise_application_error (
            -20100,
            ' Fatura com versão diferente do Contrato !!!!. Não pode ser liberado.'
         );
      END IF;
   END LOOP;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_AUX_LIBERACAO_SP_01


