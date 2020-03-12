-- Start of DDL Script for Trigger IFRBDE.TRG_TAB_CONTRATO_06_B
-- Generated 2-dez-2004 20:25:06 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_tab_contrato_06_b
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON ifrbde.tab_contrato
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   v_erro                        VARCHAR2 (200);
   v_sucesso                     NUMBER (1);
   v_existe                      NUMBER (1);
   v_situacao                    ifrbde.tab_carencia.num_situacao_carencia%TYPE;
   tot_val_cronogramado_de       NUMBER (12, 2);
   tot_val_cronogramado_rj       NUMBER (12, 2);
   tot_val_cronogramado_de_sec   NUMBER (12, 2);
   tot_qtd_ocorrencias_crono     NUMBER (5);


--
   CURSOR regr (p_num_seq_contrato NUMBER)
   IS
      SELECT *
        FROM ifrbde.cad_resumo_valores
       WHERE num_seq_contrato_res = p_num_seq_contrato;
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_existe := 0;


--

   IF    INSERTING
      OR UPDATING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:NEW.cnt_cre_cod, 0);


--
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT num_situacao_carencia
              INTO v_situacao
              FROM ifrbde.tab_carencia
             WHERE cre_cod = :NEW.cnt_cre_cod;


--
            IF v_situacao NOT IN (3, 4)
            THEN
               IF      UPDATING
                   AND UPPER (TRIM (:NEW.dsc_critica_contrato)) = 'REATIVAR'
               THEN
                  :NEW.dsc_critica_contrato :=
                           TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS ')
                        || ' Contrato reativado pelo usuário '
                        || USER
                        || ' nesta data e hora ';
               ELSE
                  v_erro :=
                        'Carência não esta em situação para cadastrar ou alterar o contrato';
                  v_sucesso := 1;
               END IF;
            END IF;

--
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                      'Erro ao verificar a situação da Carência - '
                   || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;


--
--
-- Verifica e atualiza a situacao e a area de descrição das criticas relativo ao cronograma de realização do contrato
--

      IF  v_sucesso = 0 AND :NEW.tip_situacao_contrato IN (6, 7, 9)
      THEN
         :NEW.dsc_critica_contrato := '';

         FOR regs IN regr (:NEW.num_seq_contrato)
         LOOP

--
-- calcula os totais para o cronograma realizado de desembolso, Desembolso aduaneiro
--
            IF regs.flg_moeda_controle = 1
            THEN
               IF NVL (regs.val_pagamento, 0) <>
                                        NVL (regs.val_crono_realizado_pag, 0)
               THEN
                  :NEW.dsc_critica_contrato :=
                           :NEW.dsc_critica_contrato
                        || ' - Valor Total do Cronograma Realizado para desembolso '
                        || TO_CHAR (NVL (regs.val_crono_realizado_pag, 0))
                        || ' não pode ser diferente do Valor Total do Cronograma Financeiro '
                        || TO_CHAR (NVL (regs.val_pagamento, 0));
                  v_existe := 1;
               END IF;


--
-- calcula os totais para o cronograma de reajuste
--


               IF NVL (regs.val_reajuste, 0) <
                                        NVL (regs.val_crono_realizado_reaj, 0)
               THEN
                  :NEW.dsc_critica_contrato :=
                           :NEW.dsc_critica_contrato
                        || ' - Valor Total do Cronograma Realizado para reajuste '
                        || TO_CHAR (NVL (regs.val_crono_realizado_reaj, 0))
                        || ' não pode ser menor do que Valor Total do Cronograma Financeiro para reajuste '
                        || TO_CHAR (NVL (regs.val_reajuste, 0));
                  v_existe := 1;
               END IF;
            END IF;


--
--  calcula o resumo para moeda secundaria
--
--
-- calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--

            IF regs.flg_moeda_controle = 2
            THEN
               IF NVL (regs.val_pagamento_sec, 0) <>
                                    NVL (regs.val_crono_realizado_pag_sec, 0)
               THEN
                  :NEW.dsc_critica_contrato :=
                           :NEW.dsc_critica_contrato
                        || ' - Valor Total do Cronograma Realizado para desembolso '
                        || TO_CHAR (
                              NVL (regs.val_crono_realizado_pag_sec, 0)
                           )
                        || ' não pode ser diferente do Valor Total do Cronograma Financeiro '
                        || TO_CHAR (NVL (regs.val_pagamento_sec, 0))
                        || ' para moeda secundaria ';
                  v_existe := 1;
               END IF;
            END IF;
--
/*            IF NVL (regs.qtd_crono_realizado_invalidos, 0) > 0
            THEN
               BEGIN
                  -- trunc(nvl(regs.dat_base_crono_invalido,systdate),'dd/mm/yyyy')

                  tot_qtd_ocorrencias_crono := 0;

                  SELECT COUNT (*)
                    INTO tot_qtd_ocorrencias_crono
                    FROM ifrbde.cad_resumo_cronograma
                   WHERE num_seq_contrato_rc = regs.num_seq_resumo
                     AND TO_DATE (
                            TO_CHAR (dat_vencimento_rc, 'dd/mm/yyyy'),
                            'dd/mm/yyyy'
                         ) < TO_DATE (
                                TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                                'dd/mm/yyyy'
                             )
                     AND num_seq_resumo_pag = NULL;

                  IF tot_qtd_ocorrencias_crono > 0
                  THEN
                     :NEW.dsc_critica_contrato :=
                              :NEW.dsc_critica_contrato
                           || ' - Existe(m) '
                           || TO_CHAR (tot_qtd_ocorrencias_crono)
                           || ' Ocorrência(s) de cronograma(s) de realização com data de vencimento menor que '
                           || TO_CHAR (SYSDATE, 'dd/mm/yyyy');
                     v_existe := 2;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                           'Não foi possível atualizar os Totais do Cronograma de Desembolso ou Desembaraço Aduaneiro para moeda secundaria';
                     v_sucesso := 1;
               END;
            END IF;
*/
         END LOOP;

         IF v_existe > 0
         THEN
            IF v_existe = 1
            THEN
               ifrbde.prc_gerar_cronograma_realizado (:NEW.num_seq_contrato);
            END IF;

            :NEW.dsc_critica_contrato :=    TO_CHAR (
                                               SYSDATE,
                                               'dd/mm/yyyy hh:mi:ss'
                                            )
                                         || :NEW.dsc_critica_contrato;
            :NEW.tip_situacao_contrato := 9;
         ELSE
            :NEW.tip_situacao_contrato := 6;
            :NEW.dsc_critica_contrato :=
                     TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                  || ' - Dados de Cronograma Ajustados com sucesso ';
         END IF;
      END IF;

--
--
-- fim do update e insert
--
   END IF;

   IF DELETING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:NEW.cnt_cre_cod, 0);
   END IF;


--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_CONTRATO_06_B

