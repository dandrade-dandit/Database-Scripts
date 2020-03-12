/* Formatted on 2005/11/10 17:21 (Formatter Plus v4.8.0) */
CREATE OR REPLACE TRIGGER ifrbde.trg_cad_resumo_valores_02
   AFTER INSERT OR UPDATE OF val_pago,
                             dat_moeda,
                             tip_moeda,
                             val_termo,
                             val_resumo,
                             val_pago_sec,
                             val_reajuste,
                             val_pagamento,
                             val_termo_sec,
                             val_resumo_sec,
                             val_reajuste_sec,
                             val_saldo_resumo,
                             tip_cotacao_moeda,
                             val_cotacao_moeda,
                             val_pagamento_sec,
                             val_pago_reajuste,
                             flg_moeda_controle,
                             val_inicial_resumo,
                             val_saldo_resumo_sec,
                             val_pago_reajuste_sec,
                             val_crono_realizado_reaj,
                             val_crono_realizado_pag,
                             val_crono_realizado_pag_sec,
                             qtd_crono_realizado_invalidos,
                             dat_base_crono_invalido OR DELETE
   ON ifrbde.cad_resumo_valores
   REFERENCING NEW AS NEW OLD AS OLD
DECLARE
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_num_seq_contrato          ifrbde.tab_contrato.num_seq_contrato%TYPE;
   v_tip_situacao_contrato     ifrbde.tab_contrato.tip_situacao_contrato%TYPE;
   v_saldo_ano                 ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
   v_total_aprovado_carencia   NUMBER (18, 2);
   v_total_comprometido        NUMBER (18, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';

--
--
--
   IF NVL (ifrbde.pck_variaveis.v_pck_num_seq_contrato, 0) <> 0
   THEN
      BEGIN
         v_num_seq_contrato :=
                         NVL (ifrbde.pck_variaveis.v_pck_num_seq_contrato, 0);

         UPDATE ifrbde.tab_contrato
            SET cnt_valor_compromisso = -100
          WHERE num_seq_contrato = v_num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                  'Trigger After do Resumo - Erro ao Atualizar os Valores no contrato '
               || SQLERRM;
            v_sucesso := 1;
      END;

--
--  verificação do saldo de comprometimento da carencia em relação aos contratos
--
      IF v_sucesso = 0
      THEN
--
         v_saldo_ano := 0;

--
         BEGIN
            SELECT a.val_saldo_recurso, a.val_total_recurso,
                   (a.val_total_contratado + a.val_total_aditivado
                   )
              INTO v_saldo_ano, v_total_aprovado_carencia,
                   v_total_comprometido
              FROM ifrbde.viw_saldo_carencia_contrato a,
                   ifrbde.tab_contrato b
             WHERE a.num_cre_cod = b.cnt_cre_cod
               AND b.num_seq_contrato = v_num_seq_contrato;

--
            IF v_saldo_ano < 0
            THEN
               v_erro := 'O Valor do Saldo de Comprometimento da Carência vai ficar negativo ';
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_erro :=
                   'Não existe recurso aprovado para inclusão deste contrato';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=
                     'Erro ao verificar o saldo de recurso aprovado na carência '
                  || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

--
      ifrbde.pck_variaveis.v_pck_num_seq_contrato := 0;
--
   END IF;

--
/*   IF NVL (ifrbde.pck_variaveis.v_pck_num_seq_contrato_sit, 0) <> 0
   THEN
      BEGIN
         v_num_seq_contrato :=
                     NVL (ifrbde.pck_variaveis.v_pck_num_seq_contrato_sit, 0);

         SELECT tip_situacao_contrato
           INTO v_tip_situacao_contrato
           FROM ifrbde.tab_contrato
          WHERE num_seq_contrato = v_num_seq_contrato;

         IF v_tip_situacao_contrato IN (6, 7, 9)
         THEN
            UPDATE ifrbde.tab_contrato
               SET tip_situacao_contrato =
                           DECODE (v_tip_situacao_contrato, 6, 9, 7, 9, 9, 6)
             WHERE num_seq_contrato = v_num_seq_contrato;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Trigger After do Resumo - Erro ao Atualizar a situação do contrato '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      ifrbde.pck_variaveis.v_pck_num_seq_contrato_sit := 0;
   END IF;
*/
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
-- End of DDL Script for Trigger IFRBDE.TRG_CAD_RESUMO_VALORES_02

