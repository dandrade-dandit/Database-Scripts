-- Start of DDL Script for Trigger IFRBDE.TRG_AUX_LIBERACAO_SP_01
-- Generated 2-dez-2004 20:23:31 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_aux_liberacao_sp_01
BEFORE INSERT  OR UPDATE 
ON ifrbde.aux_liberacao_sp
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   CURSOR reg (
      p_cnt_cre_cod     NUMBER,
      p_cnt_cod         VARCHAR2,
      p_num_fatura_rp   VARCHAR2
   )
   IS
      SELECT d.cnt_cre_cod, d.cnt_cod, b.num_fatura_rp, b.num_seq_resumo_pag,
             d.num_versao_contrato, b.num_versao_contrato_pag
        FROM ifrbde.cad_resumo_valores c,
             ifrbde.tab_contrato d,
             ifrbde.cad_resumo_pagamento b
       WHERE (c.num_seq_contrato_res = d.num_seq_contrato)
         AND (b.num_seq_pag_contrato_rp = c.num_seq_resumo)
         AND (d.cnt_cre_cod = p_cnt_cre_cod)
         AND (d.cnt_cod = p_cnt_cod)
         AND (SUBSTR(TRIM(b.num_fatura_rp),1,14) = SUBSTR(TRIM(p_num_fatura_rp),1,14));

   v_erro      VARCHAR2 (200);
   v_sucesso   NUMBER (1);
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
   THEN
      FOR regx IN reg (
                     :NEW.cnt_cre_cod_aux,
                     :NEW.cnt_cod_aux,
                     :NEW.num_fatura_sp
                  )
      LOOP
         IF regx.num_versao_contrato = regx.num_versao_contrato_pag
         THEN
            BEGIN
               UPDATE ifrbde.cad_resumo_pagamento
                  SET tip_situacao_pag = 1
                WHERE num_seq_resumo_pag = regx.num_seq_resumo_pag;
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (-20100, SQLERRM);
            END;
         ELSE
            raise_application_error (
               -20100,
               ' Fatura com versão diferente do Contrato !!!!. Não pode ser liberado.'
            );
         END IF;
      END LOOP;

      IF TO_NUMBER (:NEW.num_ano_realizacao) >
                                          TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
      THEN
         v_erro := 'O ano de realização não pode ser maior que o atual';
         v_sucesso := 1;
      END IF;
   END IF;

   
--
   IF UPDATING
   THEN
      IF :OLD.cod_tipo_pag_rp <> :NEW.cod_tipo_pag_rp
      THEN
         v_erro := 'O Tipo do Pagamento não pode ser modificado';
         v_sucesso := 1;
      END IF;
   END IF;

   
--

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
--      

END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_AUX_LIBERACAO_SP_01

