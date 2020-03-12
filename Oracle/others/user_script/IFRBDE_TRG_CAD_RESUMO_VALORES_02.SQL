CREATE OR REPLACE TRIGGER TRG_CAD_RESUMO_VALORES_02
 AFTER 
 INSERT OR DELETE OR UPDATE
 ON CAD_RESUMO_VALORES
 REFERENCING OLD AS OLD NEW AS NEW
DECLARE
   v_erro              VARCHAR2 (200);
   v_sucesso           NUMBER (1);
   v_num_seq_contrato  IFRBDE.tab_contrato.num_seq_contrato%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';
--
--
--    
   if IFRBDE.pck_variaveis.v_pck_num_seq_contrato <> 0 then
      BEGIN
         v_num_seq_contrato := nvl(IFRBDE.pck_variaveis.v_pck_num_seq_contrato,0); 
         UPDATE IFRBDE.tab_contrato
            SET cnt_valor_compromisso = -100
          WHERE num_seq_contrato = v_num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Trigger After do Resumo - Erro ao Atualizar os Valores no contrato '
                      || SQLERRM;
            v_sucesso := 1;
      END;
      IFRBDE.pck_variaveis.v_pck_num_seq_contrato := 0;
   END IF;
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
