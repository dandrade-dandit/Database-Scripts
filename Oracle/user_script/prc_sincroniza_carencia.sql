/* Formatted on 2004/12/16 17:19 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PROCEDURE ifrbde.prc_sincroniza_carencia (
   p_num_seq_parametro   IN   NUMBER,
   p_tipo_operacao       IN   VARCHAR2
)
IS
   
--
-- objetivo: executar atualizações para recalculo de valores do rec_aprovado e carência
--
--
-- Historico de modificações
--  Pessoa                Data        Comentarios
-- ---------            ------       -------------------------------------------
-- Carlos lassance      10/12/2004   criação da procedure
-- Carlos lassance      14/12/2004   modificação para executar de forma diferente quando for excluida as SP´s
--                                   criação do campo p_tipo_operacao
--
-- variaveis
--
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_pgose                     ifrbde.tab_rec_aprovado.rap_pgose%TYPE;
   v_num_seq_carencia          ifrbde.tab_rec_aprovado.rap_cre_cod%TYPE;
   v_cod_recurso               ifrbde.tab_rec_aprovado.rap_rti_cod%TYPE;
   v_num_ano_pgose             ifrbde.tab_rec_aprovado.rap_pgose%TYPE;
   v_num_seq_resumo_contrato   ifrbde.cad_resumo_valores.num_seq_contrato_res%TYPE;

   
--
-- cursor quando a operacao for [I]nclusão ou [A]lteração  (p_tipo_operacao)
--

   CURSOR pagx (p_num_seq_resumo_pag NUMBER)
   IS
      SELECT c.num_ano_pgose, c.cod_recurso, b.cnt_cre_cod,
             c.num_seq_resumo_contrato
        FROM ifrbde.cad_resumo_valores a,
             ifrbde.tab_contrato b,
             ifrbde.cad_pagamento_contrato c,
             ifrbde.cad_resumo_pagamento d
       WHERE d.num_seq_resumo_pag = p_num_seq_resumo_pag
         AND d.num_seq_resumo_pag = c.num_seq_contrato_pag
         AND d.num_seq_pag_contrato_rp = a.num_seq_resumo
         AND a.num_seq_contrato_res = b.num_seq_contrato;

   
--
--
-- cursor quando a operacao for [E]xclusão (p_tipo_operacao)
--

   CURSOR pagy (p_num_seq_resumo NUMBER)
   IS
      SELECT b.cnt_cre_cod , a.num_seq_resumo
        FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
       WHERE a.num_seq_resumo = p_num_seq_resumo
         AND a.num_seq_contrato_res = b.num_seq_contrato;
--
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
--
--
--
   IF p_tipo_operacao IN ('I', 'A')
   THEN
      FOR xx IN pagx (p_num_seq_parametro)
      LOOP
         
--
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = xx.cnt_cre_cod
               AND rap_rti_cod = xx.cod_recurso
               AND rap_pgose = xx.num_ano_pgose;

            
--
            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor_pago = -100
                WHERE rap_cre_cod = xx.cnt_cre_cod
                  AND rap_pgose = xx.num_ano_pgose;
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
               UPDATE ifrbde.tab_carencia
                  SET cre_total_pago = -100
                WHERE cre_cod = xx.cnt_cre_cod;
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

         
--
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_pagamento = -100
             WHERE num_seq_resumo = xx.num_seq_resumo_contrato;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não conseguiu atualizar os totais do Resumo de Valores '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END LOOP;
   END IF;

   
--
--   
--
   IF p_tipo_operacao IN ('E')
   THEN
      FOR xx IN pagy (p_num_seq_parametro)
      LOOP
         
--
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = xx.cnt_cre_cod AND ROWNUM = 1;

            
--
            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor_pago = -100
                WHERE rap_cre_cod = xx.cnt_cre_cod;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Não conseguiu atualizar os totais do recurso aprovado na operação de exclusão da SP '
                        || SQLERRM;
                  v_sucesso := 1;
            END;

            
--
            BEGIN
               UPDATE ifrbde.tab_carencia
                  SET cre_total_pago = -100
                WHERE cre_cod = xx.cnt_cre_cod;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Não conseguiu atualizar o Total Faturado da Carência na operação de exclusão da SP '
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

         
--
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_pagamento = -100
             WHERE num_seq_resumo = xx.num_seq_resumo;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não conseguiu atualizar os totais do Resumo de Valores '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END LOOP;
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END prc_sincroniza_carencia;
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_sincroniza_carencia TO bde_geral
/

-- End of DDL Script for Procedure ifrbde.prc_sincroniza_carencia

