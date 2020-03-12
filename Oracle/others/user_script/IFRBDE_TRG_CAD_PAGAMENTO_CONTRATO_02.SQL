CREATE OR REPLACE TRIGGER TRG_CAD_PAGAMENTO_CONTRATO_02
 AFTER 
 INSERT OR DELETE OR UPDATE OF VAL_ACUMULADO, VAL_FATURADO
 ON CAD_PAGAMENTO_CONTRATO
 REFERENCING OLD AS OLD NEW AS NEW
DECLARE
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_pgose                     IFRBDE.tab_rec_aprovado.rap_pgose%TYPE;
   v_num_seq_carencia          IFRBDE.tab_rec_aprovado.rap_cre_cod%TYPE;
   v_cod_recurso               IFRBDE.tab_rec_aprovado.rap_rti_cod%TYPE;
   v_num_ano_pgose             IFRBDE.tab_rec_aprovado.rap_pgose%TYPE;
   v_num_seq_resumo_contrato   IFRBDE.cad_resumo_valores.num_seq_contrato_res%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
--
--
--    
   IF NVL (IFRBDE.pck_variaveis.v_pck_num_seq_carencia, 0) <> 0
   THEN
      v_num_seq_carencia :=
                        NVL (IFRBDE.pck_variaveis.v_pck_num_seq_carencia, 0);
      v_cod_recurso := NVL (IFRBDE.pck_variaveis.v_pck_cod_recurso, ' ');
      v_num_ano_pgose :=
                       NVL (IFRBDE.pck_variaveis.v_pck_num_ano_pgose, '0000');

      
--
      BEGIN
         SELECT rap_pgose
           INTO v_pgose
           FROM IFRBDE.tab_rec_aprovado
          WHERE rap_cre_cod = v_num_seq_carencia
            AND rap_rti_cod = v_cod_recurso
            AND rap_pgose = v_num_ano_pgose;

         
--
         BEGIN
            UPDATE IFRBDE.tab_rec_aprovado
               SET rap_valor_pago = -100
             WHERE rap_cre_cod = v_num_seq_carencia
               AND rap_rti_cod = v_cod_recurso
               AND rap_pgose = v_num_ano_pgose;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não conseguiu atualizar os totais do recurso aprovado '
                     || SQLERRM;
               v_sucesso := 1;
         END;

         
--         
         BEGIN
            UPDATE IFRBDE.tab_carencia
               SET cre_total_pago = -100
             WHERE cre_cod = v_num_seq_carencia;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não conseguiu atualizar o Total Faturado da Carência '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não conseguiu localizar o Recurso Aprovado na carência, recurso e ano para pagamento do Reajuste. Verifique os recursos aprovados na Carência '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      IFRBDE.pck_variaveis.v_pck_num_seq_carencia := 0;
      IFRBDE.pck_variaveis.v_pck_cod_recurso := ' ';
      IFRBDE.pck_variaveis.v_pck_num_ano_pgose := '0000';
   END IF;

   
--   
   IF NVL (IFRBDE.pck_variaveis.v_pck_num_seq_resumo_contrato, 0) <> 0
   THEN
      v_num_seq_resumo_contrato :=
                 NVL (IFRBDE.pck_variaveis.v_pck_num_seq_resumo_contrato, 0);

      
--
      BEGIN
         UPDATE IFRBDE.cad_resumo_valores
            SET val_pagamento = -100
          WHERE num_seq_resumo = v_num_seq_resumo_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não conseguiu atualizar os totais do Resumo de Valores '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      IFRBDE.pck_variaveis.v_pck_num_seq_resumo_contrato := 0;
   END IF;

   
--

--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
