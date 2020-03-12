/* Formatted on 2005/08/17 10:10 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_cad_resumo_pagamento_01
   BEFORE INSERT OR UPDATE OF dat_moeda_rp,
                              dsc_glosa_rp,
                              val_glosa_rp,
                              val_multa_rp,
                              dat_pagamento,
                              num_fatura_rp,
                              cod_tipo_pag_rp,
                              val_retencao_rp,
                              val_pagamento_rp,
                              dat_vencimento_pag,
                              dsc_solicitacao_rp,
                              val_imposto_iss_rp,
                              num_seq_entidade_rp,
                              val_imposto_icms_rp,
                              val_imposto_inss_rp,
                              val_imposto_irrf_rp,
                              val_liquido_nota_rp,
                              num_seq_entidade_pag,
                              tip_cotacao_moeda_rp,
                              val_cotacao_moeda_rp,
                              val_imposto_pasep_rp OR DELETE
   ON ifrbde.cad_resumo_pagamento
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                        VARCHAR2 (400);
   v_sucesso                     NUMBER (1);
   v_ccp_valor                   NUMBER (12, 2);
   v_val_saldo_crono             NUMBER (12, 2);
   v_flg_moeda_controle          ifrbde.cad_resumo_valores.flg_moeda_controle%TYPE;
   v_tip_situacao_contrato       ifrbde.tab_contrato.tip_situacao_contrato%TYPE;
   v_num_versao_contrato         ifrbde.cad_resumo_valores.num_versao_contrato_res%TYPE;
   v_num_contrato                ifrbde.tab_contrato.cnt_cod%TYPE;
   v_carencia                    ifrbde.tab_contrato.cnt_cre_cod%TYPE;
   v_num_fatura_rp               VARCHAR2 (14);
   v_dat_liberacao               DATE;
   v_num_pgose                   VARCHAR2 (4);
   v_tip_situacao_pag            NUMBER (2);
   v_num_seq_resumo_crono        NUMBER (15);
   v_dat_vencimento_crono        DATE;
   v_val_pagamento_crono         NUMBER (18, 2);
   v_tip_pagamento_crono         VARCHAR2 (2);
   v_tipo_crono                  VARCHAR2 (2);
   v_tipo_crono_saida            VARCHAR2 (30);
   v_num_seq_resumo_crono_r      NUMBER (15);
   v_liberacao_sp                VARCHAR2 (1);
   v_num_seq_resumo_crono_novo   NUMBER (15);
   v_data_inicio                 DATE;
   v_data_termino                DATE;
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
--
   IF INSERTING
   THEN
      
--
      :NEW.val_imposto_irrf_rp := NVL (:NEW.val_imposto_irrf_rp, 0);
      :NEW.val_imposto_iss_rp := NVL (:NEW.val_imposto_iss_rp, 0);
      :NEW.val_imposto_pasep_rp := NVL (:NEW.val_imposto_pasep_rp, 0);
      :NEW.val_imposto_icms_rp := NVL (:NEW.val_imposto_icms_rp, 0);
      :NEW.val_imposto_inss_rp := NVL (:NEW.val_imposto_inss_rp, 0);
      
--
      :NEW.val_pagamento_rp := NVL (:NEW.val_pagamento_rp, 0);
      :NEW.val_glosa_rp := NVL (:NEW.val_glosa_rp, 0);
      :NEW.val_retencao_rp := NVL (:NEW.val_retencao_rp, 0);
      :NEW.val_multa_rp := NVL (:NEW.val_multa_rp, 0);
      :NEW.val_impostos_rp := NVL (:NEW.val_impostos_rp, 0);
      
--
      :NEW.num_seq_entidade_rp := NVL (:NEW.num_seq_entidade_rp, 0);
      :NEW.num_fatura_rp := TRIM (:NEW.num_fatura_rp);
      :NEW.dsc_solicitacao_rp := TRIM (:NEW.dsc_solicitacao_rp);
      :NEW.dsc_glosa_rp := TRIM (:NEW.dsc_glosa_rp);
      
--
      :NEW.dat_pagamento_st := :NEW.dat_pagamento;

      
--
-- verifica qual tipo de moeda a do resumo
--
      BEGIN
         SELECT a.flg_moeda_controle, b.tip_situacao_contrato,
                b.num_versao_contrato, b.cnt_cre_cod, b.cnt_cod,
                b.cnt_data_inicio, (  b.dat_termino_contrato
                                    + 90
                                   )
           INTO v_flg_moeda_controle, v_tip_situacao_contrato,
                v_num_versao_contrato, v_carencia, v_num_contrato,
                v_data_inicio, v_data_termino
           FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
          WHERE a.num_seq_resumo = :NEW.num_seq_pag_contrato_rp
            AND a.num_seq_contrato_res = b.num_seq_contrato;

         
--
         v_liberacao_sp := 'F';
         
--       
         ifrbde.prc_liberacao_realizacao_sp (
            :NEW.num_seq_resumo_pag,
            :NEW.cod_tipo_pag_rp,
            v_carencia,
            v_num_contrato,
            :NEW.dat_vencimento_pag,
            :NEW.num_fatura_rp,
            v_liberacao_sp
         );
      
--
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                  'Não foi possível localizar o resumo do contrato'
               || SQLERRM;
            v_sucesso := 1;
      END;

      
--
--   coloca a versão do resumo no pagamento e no cronograma
--
      :NEW.num_versao_contrato_pag := TRIM (v_num_versao_contrato);

      
--
--

      IF  :NEW.dat_vencimento_pag < v_data_inicio AND v_sucesso = 0
      THEN
         v_erro :=    'Data do Vencimento '
                   || TO_CHAR (:NEW.dat_pagamento, 'dd/mm/yyyy')
                   || ' não pode ser menor que a Data do Inicio do Contrato '
                   || TO_CHAR (v_data_inicio, 'dd/mm/yyyy');
         v_sucesso := 1;
      END IF;

      
--
      IF      :NEW.dat_vencimento_pag > v_data_termino
          AND v_sucesso = 0
          AND v_liberacao_sp = 'F'
      THEN
         v_erro :=    'Data do Vencimento '
                   || TO_CHAR (:NEW.dat_pagamento, 'dd/mm/yyyy')
                   || ' não pode ser maior que a Data de Termino do Contrato '
                   || TO_CHAR (v_data_termino, 'dd/mm/yyyy');
         v_sucesso := 1;
      END IF;

      
--
      IF  TO_CHAR (:NEW.dat_vencimento_pag, 'd') IN ('1', '7') 
	  AND v_sucesso = 0
      THEN
         v_erro :=    'Data do Vencimento '
                   || TO_CHAR (:NEW.dat_vencimento_pag, 'dd/mm/yyyy')
                   || ' não pode ser usada, pois é '
                   || TO_CHAR (:NEW.dat_vencimento_pag, 'day');
         v_sucesso := 1;
      END IF;

      
--
      IF  v_tip_situacao_contrato = 5 AND v_sucesso = 0
      THEN
         v_erro :=
               ' Pagamento Bloqueado , pois o Contrato encontra-se Incompleto - Verifique as criticas do contrato e atualize as informações solicitadas';
         v_sucesso := 1;
      END IF;

      
--
      IF  v_tip_situacao_contrato IN (2, 4) AND v_sucesso = 0
      THEN
         v_erro :=
               ' Pagamento Bloqueado , pois o Contrato não foi enviado a Financeira - Atualize o contrato e para fazer o envio';
         v_sucesso := 1;
      END IF;

      
--
      IF  v_tip_situacao_contrato IN (1, 3) AND v_sucesso = 0
      THEN
         v_erro :=
               ' Pagamento Bloqueado , pois o Contrato encontra-se Encerrado ou Rescindido !!!!!!!!!!';
         v_sucesso := 1;
      END IF;

      
--
      IF  v_tip_situacao_contrato = 9 AND v_sucesso = 0
      THEN
         IF v_liberacao_sp = 'F'
         THEN
            v_erro :=
                     ' Pagamento Bloqueado , pois o Contrato aguarda ajuste do cronograma de realização e não há Liberação de SP '
                  || ' com  vencimento '
                  || TO_CHAR (:NEW.dat_vencimento_pag, 'dd/mm/yyyy')
                  || ' , igual a valor de realização = '
                  || TO_CHAR ((  :NEW.val_pagamento_rp
                               - :NEW.val_glosa_rp
                              ))
                  || ' da carência / Contrato / '
                  || TO_CHAR (v_carencia)
                  || ' / '
                  || v_num_contrato
                  || ' da fatura '
                  || TRIM (:NEW.num_fatura_rp)
                  || ' e liberação de SP = '
                  || v_liberacao_sp;
            
--
            v_sucesso := 1;
         END IF;
      END IF;

      
--
/*
      IF  v_tip_situacao_contrato IN (6) AND v_sucesso = 0
      THEN
         v_erro :=
               ' Pagamento Bloqueado , pois o Contrato não foi ativado no SmartStream - Aguarde a confirmação de retorno de envio';
         v_sucesso := 1;
      END IF;
*/

--
      :NEW.val_impostos_rp :=   NVL (:NEW.val_imposto_irrf_rp, 0)
                              + NVL (:NEW.val_imposto_iss_rp, 0)
                              + NVL (:NEW.val_imposto_pasep_rp, 0)
                              + NVL (:NEW.val_imposto_icms_rp, 0)
                              + NVL (:NEW.val_imposto_inss_rp, 0);
      
--
      :NEW.val_liquido_nota_rp := (  :NEW.val_pagamento_rp
                                   - (  :NEW.val_glosa_rp
                                      + :NEW.val_retencao_rp
                                      + :NEW.val_multa_rp
                                      + :NEW.val_impostos_rp
                                     )
                                  );

      
--
      IF  :NEW.val_liquido_nota_rp < 0 AND v_sucesso = 0
      THEN
         v_erro :=
                  ' O valor Liquido não pode ser menor que zero - Resultado do Calculo '
               || TO_CHAR (
                     (  :NEW.val_pagamento_rp
                      - (  :NEW.val_glosa_rp
                         + :NEW.val_retencao_rp
                         + :NEW.val_multa_rp
                         + :NEW.val_impostos_rp
                        )
                     )
                  );
         v_sucesso := 1;
      END IF;

      
--
      IF      (   :NEW.val_pagamento_rp <= 0
               OR :NEW.val_glosa_rp < 0
               OR :NEW.val_retencao_rp < 0
               OR :NEW.val_multa_rp < 0
               OR :NEW.val_impostos_rp < 0
              )
          AND v_sucesso = 0
      THEN
         v_erro :=
               ' Existe(m) valor(es) invalido(s), Não podem ser negativos e o Liquido da Fatura ou Valor P0 não podem ser iguais a zero !!!!! ';
         v_sucesso := 1;
      END IF;

      IF  v_sucesso = 0 AND v_flg_moeda_controle = 2
      THEN
         IF    :NEW.dat_moeda_rp IS NULL
            OR NVL (:NEW.val_cotacao_moeda_rp, 0) = 0
            OR :NEW.tip_cotacao_moeda_rp IS NULL
         THEN
            v_erro :=
                  'Quando o resumo de valores é utiliza a moeda secundaria, é obrigatório o preenchimento da Data,Valor, e Tipo de Cotação da Moeda ';
            v_sucesso := 1;
         END IF;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         IF :NEW.cod_tipo_pag_rp IN ('P', 'R', 'D')
         THEN
            IF    (    NVL (:NEW.num_seq_entidade_rp, 0) <> 0
                   AND NVL (:NEW.val_retencao_rp, 0) = 0
                  )
               OR (    NVL (:NEW.num_seq_entidade_rp, 0) = 0
                   AND NVL (:NEW.val_retencao_rp, 0) > 0
                  )
            THEN
               v_erro :=
                     'O valor e a entidade de retenção , devem ser informados quando houver retenção !!!!!';
               v_sucesso := 1;
            END IF;
         ELSE
            :NEW.num_seq_entidade_rp := 0;
            :NEW.val_retencao_rp := 0;
         END IF;
      END IF;

      
--      
      IF      v_sucesso = 0
          AND LENGTH (:NEW.dsc_glosa_rp) = 0
          AND :NEW.val_glosa_rp <> 0
      THEN
         v_erro :=
               'A descrição da Glosa é obrigatório quando for informada o valor !!!!!';
         v_sucesso := 1;
      END IF;

      IF      v_sucesso = 0
          AND LENGTH (:NEW.dsc_glosa_rp) > 0
          AND :NEW.val_glosa_rp = 0
      THEN
         v_erro :=
               'A Valor da Glosa é obrigatório quando for informada a descrição !!!!!';
         v_sucesso := 1;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         IF :NEW.dat_pagamento > :NEW.dat_vencimento_pag
         THEN
            v_erro :=
                  'A Data de Vencimento da SP não pode ser menor que a Data da Fatura !!!!!';
            v_sucesso := 1;
         END IF;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         
--
         ifrbde.prc_ano_realizacao_sp (
            'I',
            :NEW.num_seq_resumo_pag,
            :NEW.cod_tipo_pag_rp,
            v_carencia,
            v_num_contrato,
            :NEW.dat_vencimento_pag,
            :NEW.num_fatura_rp,
            :NEW.tip_situacao_pag,
            v_num_pgose,
            :NEW.tip_situacao_pag
         );

         
--
         IF :NEW.cod_tipo_pag_rp IN ('P', 'R', 'D')
         THEN
            ifrbde.prc_gerar_solic_pagamento (
               v_num_pgose,
               :NEW.num_seq_resumo_pag,
               :NEW.num_seq_pag_contrato_rp,
               :NEW.dat_pagamento,
               :NEW.num_fatura_rp,
               :NEW.num_versao_contrato_pag,
               v_flg_moeda_controle,
               :NEW.cod_tipo_pag_rp,
               :NEW.dat_moeda_rp,
               :NEW.val_cotacao_moeda_rp,
               :NEW.tip_situacao_pag,
               :NEW.val_pagamento_rp,
               :NEW.val_retencao_rp,
               :NEW.val_glosa_rp,
               :NEW.val_multa_rp,
               :NEW.val_liquido_nota_rp,
               :NEW.val_imposto_irrf_rp,
               :NEW.val_imposto_iss_rp,
               :NEW.val_imposto_pasep_rp,
               :NEW.val_imposto_icms_rp,
               :NEW.val_imposto_inss_rp,
               :NEW.val_impostos_rp
            );
            
--
            v_liberacao_sp := 'F';
            
--       
            ifrbde.prc_liberacao_realizacao_sp (
               :NEW.num_seq_resumo_pag,
               :NEW.cod_tipo_pag_rp,
               v_carencia,
               v_num_contrato,
               :NEW.dat_vencimento_pag,
               :NEW.num_fatura_rp,
               v_liberacao_sp
            );

            
--
--
--
            IF :NEW.cod_tipo_pag_rp = 'P'
            THEN
               v_tipo_crono_saida := 'DESEMBOLSO';
               v_tipo_crono := 'DE';
            END IF;

            IF :NEW.cod_tipo_pag_rp = 'R'
            THEN
               v_tipo_crono_saida := 'REAJUSTE';
               v_tipo_crono := 'RJ';
            END IF;

            IF :NEW.cod_tipo_pag_rp = 'D'
            THEN
               v_tipo_crono_saida := 'DESEMBARAÇO ADUANEIRO';
               v_tipo_crono := 'DA';
            END IF;

            
--
            v_erro :=    ' com  vencimento '
                      || TO_CHAR (:NEW.dat_vencimento_pag, 'dd/mm/yyyy')
                      || ' , igual a valor de realização = '
                      || TO_CHAR (
                            (  :NEW.val_pagamento_rp
                             - :NEW.val_glosa_rp
                            )
                         )
                      || ' , e tipo '
                      || TRIM (v_tipo_crono_saida)
                      || ' da carência / Contrato / '
                      || TO_CHAR (v_carencia)
                      || ' / '
                      || v_num_contrato
                      || ' da fatura '
                      || :NEW.num_fatura_rp
                      || 'e liberação = '
                      || v_liberacao_sp;

            
--
-- acessar cronograma realizado
--
            BEGIN
               
--
               SELECT num_seq_resumo_crono
                 INTO v_num_seq_resumo_crono
                 FROM cad_resumo_cronograma
                WHERE dat_vencimento_rc = :NEW.dat_vencimento_pag
                  AND val_resumo_crno =
                                (  :NEW.val_pagamento_rp
                                 - :NEW.val_glosa_rp
                                )
                  AND tip_resumo_crono = v_tipo_crono
                  AND num_seq_resumo_pag IS NULL
                  AND num_seq_contrato_rc = :NEW.num_seq_pag_contrato_rp
                  AND ROWNUM = 1;

               
--
--        
--
               UPDATE cad_resumo_cronograma
                  SET num_seq_resumo_pag = :NEW.num_seq_resumo_pag,
                      ano_realizacao = v_num_pgose
                WHERE num_seq_resumo_crono = v_num_seq_resumo_crono;
            
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  IF :NEW.dat_vencimento_pag > TRUNC (SYSDATE)
                  THEN
                     raise_application_error (
                        -20100,
                           'Não foi localizado o cronograma realização '
                        || v_erro
                     );
                  ELSE
                     IF v_liberacao_sp = 'T'
                     THEN
                        
--
                        BEGIN
                           SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
                             INTO v_num_seq_resumo_crono_novo
                             FROM DUAL;

                           
--
                           INSERT INTO cad_resumo_cronograma
                                       (num_seq_resumo_crono,
                                        num_seq_contrato_rc,
                                        dat_vencimento_rc,
                                        val_resumo_crno,
                                        tip_resumo_crono,
                                        dat_moeda_rc,
                                        val_cotacao_rc,
                                        tip_cotacao_rc,
                                        num_seq_resumo_pag, ano_realizacao)
                                VALUES (v_num_seq_resumo_crono_novo,
                                        :NEW.num_seq_pag_contrato_rp,
                                        :NEW.dat_vencimento_pag,
                                        NVL (
                                           (  :NEW.val_pagamento_rp
                                            - :NEW.val_glosa_rp
                                           ),
                                           0
                                        ),
                                        DECODE (
                                           :NEW.cod_tipo_pag_rp,
                                           'P', 'DE',
                                           'R', 'RJ',
                                           'D', 'DA'
                                        ),
                                        :NEW.dat_moeda_rp,
                                        NVL (:NEW.val_cotacao_moeda_rp, 1),
                                        NVL (:NEW.tip_cotacao_moeda_rp, 'V'),
                                        :NEW.num_seq_resumo_pag, v_num_pgose);
                        EXCEPTION
                           WHEN OTHERS
                           THEN
                              raise_application_error (
                                 -20100,
                                    'Erro ao incluir cronograma de realização antigo '
                                 || v_erro
                                 || SQLERRM
                              );
                        END;
                     END IF;
                  END IF;
               WHEN OTHERS
               THEN
                  raise_application_error (-20100,    v_erro
                                                   || SQLERRM);
            END;
         
--
         END IF;

         
--
         IF :NEW.cod_tipo_pag_rp = 'L'
         THEN
            ifrbde.prc_gerar_liberacao_retencao (
               v_num_pgose,
               :NEW.num_seq_resumo_pag,
               :NEW.num_seq_pag_contrato_rp,
               :NEW.dat_pagamento,
               :NEW.num_fatura_rp,
               :NEW.num_versao_contrato_pag,
               v_flg_moeda_controle,
               :NEW.cod_tipo_pag_rp,
               :NEW.dat_moeda_rp,
               :NEW.val_cotacao_moeda_rp,
               :NEW.tip_situacao_pag,
               :NEW.val_pagamento_rp,
               :NEW.val_retencao_rp,
               :NEW.val_glosa_rp,
               :NEW.val_multa_rp,
               :NEW.val_liquido_nota_rp,
               :NEW.val_imposto_irrf_rp,
               :NEW.val_imposto_iss_rp,
               :NEW.val_imposto_pasep_rp,
               :NEW.val_imposto_icms_rp,
               :NEW.val_imposto_inss_rp,
               :NEW.val_impostos_rp
            );
         END IF;
      END IF;
   
--
   END IF;

   
--
   IF UPDATING
   THEN
      
--
-- verificações iniciais para atualização do registro
--
      :NEW.num_seq_entidade_rp := NVL (:NEW.num_seq_entidade_rp, 0);

      IF :NEW.num_seq_entidade_rp IS NULL
      THEN
         :NEW.num_seq_entidade_rp := 0;
      END IF;

      :NEW.dat_pagamento_st := :NEW.dat_pagamento;
      
--
      v_erro :=
            'O lançamento não pode ser modificado - Exclua o registro e redigite novamente ';
      v_sucesso := 1;

      
--
      IF  :OLD.tip_situacao_pag = 1 AND :NEW.tip_situacao_pag = 1
      THEN
         v_erro := '';
         v_sucesso := 0;
      ELSE
         IF :OLD.tip_situacao_pag IN (2, 3, 4, 5)
         THEN
            v_erro :=
                  'O lançamento já foi enviado a financeira não pode ser modificado';
            v_sucesso := 1;
         END IF;

         IF :OLD.tip_situacao_pag IN (6)
         THEN
            v_erro :=
                  'O lançamento já foi pago na financeira não pode ser modificado';
            v_sucesso := 1;
         END IF;

         IF :OLD.tip_situacao_pag IN (9)
         THEN
            v_erro :=
               'O lançamento já foi para o Historico não pode ser modificado';
            v_sucesso := 1;
         END IF;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         :NEW.num_seq_entidade_rp := NVL (:NEW.num_seq_entidade_rp, 0);

         IF :NEW.num_seq_entidade_rp IS NULL
         THEN
            :NEW.num_seq_entidade_rp := 0;
         END IF;

         :NEW.dat_pagamento_st := :NEW.dat_pagamento;

         
--
-- verifica qual tipo de moeda a do resumo
--
         BEGIN
            SELECT a.flg_moeda_controle, b.tip_situacao_contrato,
                   b.num_versao_contrato
              INTO v_flg_moeda_controle, v_tip_situacao_contrato,
                   v_num_versao_contrato
              FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
             WHERE a.num_seq_resumo = :NEW.num_seq_pag_contrato_rp
               AND a.num_seq_contrato_res = b.num_seq_contrato;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Não foi possível localizar o resumo do contrato'
                         || SQLERRM;
               v_sucesso := 1;
         END;

         
--
         IF v_sucesso = 0
         THEN
            IF    v_tip_situacao_contrato IN (1, 3)
               OR :NEW.dat_vencimento_pag <=
                                          TO_DATE ('31/03/2003', 'DD/MM/YYYY')
            THEN
               :NEW.tip_situacao_pag := 9;
            
--            :NEW.tip_situacao_pag := 1;
            END IF;
         END IF;

         
--
--
         IF  :NEW.num_versao_contrato_pag IS NULL AND v_sucesso = 0
         THEN
            v_erro :=
                  ' Pagamento Bloqueado , pois não consta a referencia de que versão de Contrato a solicitação pertence - entre em contaco com o analista responsavel';
            v_sucesso := 1;
         END IF;

         
--
         IF  v_tip_situacao_contrato = 5 AND v_sucesso = 0
         THEN
            v_erro :=
                  ' Pagamento Bloqueado , pois o Contrato encontra-se Incompleto - Verifique as criticas do contrato e atualize as informações solicitadas';
            v_sucesso := 1;
         END IF;

         
--
         IF  v_tip_situacao_contrato IN (2, 4) AND v_sucesso = 0
         THEN
            v_erro :=
                  ' Pagamento Bloqueado , pois o Contrato não foi enviado a Financeira - Atualize o contrato e para fazer o envio';
            v_sucesso := 1;
         END IF;
      END IF;

      
--
      IF      (   :NEW.cod_tipo_pag_rp <> :OLD.cod_tipo_pag_rp
               OR TRIM (:NEW.num_fatura_rp) <> TRIM (:OLD.num_fatura_rp)
               OR :NEW.val_pagamento_rp <> :OLD.val_pagamento_rp
               OR :NEW.val_glosa_rp <> :OLD.val_glosa_rp
               OR :NEW.val_retencao_rp <> :OLD.val_retencao_rp
               OR :NEW.val_imposto_irrf_rp <> :OLD.val_imposto_irrf_rp
               OR :NEW.val_imposto_iss_rp <> :OLD.val_imposto_iss_rp
               OR :NEW.val_imposto_pasep_rp <> :OLD.val_imposto_pasep_rp
               OR :NEW.val_imposto_icms_rp <> :OLD.val_imposto_icms_rp
               OR :NEW.val_imposto_inss_rp <> :OLD.val_imposto_inss_rp
               OR :NEW.val_multa_rp <> :OLD.val_multa_rp
               OR :NEW.val_liquido_nota_rp <> :OLD.val_liquido_nota_rp
               OR :NEW.val_cotacao_moeda_rp <> :OLD.val_cotacao_moeda_rp
              )
          AND v_sucesso = 0
      THEN
         v_erro :=
               ' Foi modificada alguma informação relativa a valores e/ou Numero da Fatura e/ou tipo de solicitação - Caso haja necessidade desta modificação exclua a solicitação e recadastre-a';
         v_sucesso := 1;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         IF :NEW.dat_pagamento > :NEW.dat_vencimento_pag
         THEN
            v_erro :=
                  'A Data de Vencimento da SP não pode ser menor que a Data da Fatura !!!!!';
            v_sucesso := 1;
         END IF;
      END IF;

      
--
--
      v_liberacao_sp := 'F';
      
--       
      ifrbde.prc_liberacao_realizacao_sp (
         :NEW.num_seq_resumo_pag,
         :NEW.cod_tipo_pag_rp,
         v_carencia,
         v_num_contrato,
         :NEW.dat_vencimento_pag,
         :NEW.num_fatura_rp,
         v_liberacao_sp
      );

      
--
-- acessar cronograma realizado -- FOI ADICIONADO AND user <> 'I9563674'
--
      IF  v_sucesso = 0 AND v_liberacao_sp = 'F'
      THEN
         IF :NEW.cod_tipo_pag_rp <> 'L'
         THEN
            BEGIN
               SELECT num_seq_resumo_crono, dat_vencimento_rc,
                      val_resumo_crno,
                      DECODE (tip_resumo_crono, 'DE', 'P', 'RJ', 'R', 'DA', 'D')
                 INTO v_num_seq_resumo_crono_r, v_dat_vencimento_crono,
                      v_val_pagamento_crono,
                      v_tip_pagamento_crono
                 FROM cad_resumo_cronograma a
                WHERE num_seq_resumo_pag = :OLD.num_seq_resumo_pag;

               
--
               IF    (v_val_pagamento_crono <>
                                (  :NEW.val_pagamento_rp
                                 - :NEW.val_glosa_rp
                                )
                     )
                  OR (v_tip_pagamento_crono <> :NEW.cod_tipo_pag_rp)
                  OR (v_dat_vencimento_crono <> :NEW.dat_vencimento_pag)
               THEN
                  v_erro :=
                        'Os dados de pagamento (valor da fatura - valor Glosa), ou data de vencimento ou tipo pagamento da SP não podem ser modificados , exclua a SP e atualize o cronograma de realização';
                  v_sucesso := 1;
               END IF;
            
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  raise_application_error (
                     -20100,
                     'Não foi localizado o cronograma realização desta fatura'
                  );
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        'Erro ao selecionar a fatura no cronograma realização '
                     || SQLERRM
                  );
            END;
         END IF;
      END IF;
   END IF;

   
--
   IF DELETING
   THEN
      
--
-- verifica qual tipo de moeda a do resumo
--
      BEGIN
         SELECT a.flg_moeda_controle, b.tip_situacao_contrato,
                b.num_versao_contrato, b.cnt_cod, b.cnt_cre_cod
           INTO v_flg_moeda_controle, v_tip_situacao_contrato,
                v_num_versao_contrato, v_num_contrato, v_carencia
           FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
          WHERE a.num_seq_resumo = :OLD.num_seq_pag_contrato_rp
            AND a.num_seq_contrato_res = b.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                  'Não foi possível localizar o resumo do contrato'
               || SQLERRM;
            v_sucesso := 1;
      END;

      
--
--   verifica se pode excluir a SP da Versão do contrato
--
      IF :OLD.num_versao_contrato_pag <> v_num_versao_contrato
      THEN
         v_erro :=
               'Esta Solicitação não pertence a versão do Contrato, não pode ser excluida !!!!!!';
         v_sucesso := 1;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         ifrbde.prc_ano_realizacao_sp (
            'E',
            :OLD.num_seq_resumo_pag,
            :OLD.cod_tipo_pag_rp,
            v_carencia,
            v_num_contrato,
            :OLD.dat_vencimento_pag,
            :OLD.num_fatura_rp,
            :OLD.tip_situacao_pag,
            v_num_pgose,
            v_tip_situacao_pag
         );
      END IF;

      
--
      IF  :OLD.tip_situacao_pag NOT IN (1, 7, 8) AND v_sucesso = 0
      THEN
         v_erro :=
                  'Solicitação não esta em situação para ser excluida !!!!!!';
         v_sucesso := 1;
      ELSE
         
--
         BEGIN
            DELETE FROM ifrbde.cad_pagamento_contrato
                  WHERE num_seq_contrato_pag = :OLD.num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao excluir lançamento '
                         || SQLERRM;
               v_sucesso := 1;
         END;

         
--
--  deleta o registro de retenção do cronograma
--
         IF      :OLD.cod_tipo_pag_rp IN ('P', 'R', 'D')
             AND NVL (:OLD.val_retencao_rp, 0) > 0
         THEN
            BEGIN
               SELECT ccp_valor
                 INTO v_ccp_valor
                 FROM ifrbde.tab_cont_crono_pagamento
                WHERE num_seq_resumo_pag_retencao = :OLD.num_seq_resumo_pag
                  AND ROWNUM = 1;

               BEGIN
                  SELECT ccp_valor, val_saldo_crono
                    INTO v_ccp_valor, v_val_saldo_crono
                    FROM ifrbde.tab_cont_crono_pagamento
                   WHERE num_seq_resumo_pag_retencao =
                                                      :OLD.num_seq_resumo_pag
                     AND ccp_valor <> val_saldo_crono
                     AND ROWNUM = 1;

                  v_erro :=
                        'Esta Solicitação de Pagamento não pode ser excluida, pois o cronograma de retenção vinculado tem saldo diferente do valor retido - Exclua primeiro as liberações de retenção para pode exclui este lançamento';
                  v_sucesso := 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao verificar no cronograma de retenção vinculado a existencia de saldo '
                           || SQLERRM;
                     v_sucesso := 1;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  v_erro :=
                           'Erro não encontrei o cronograma de retenção vinculado a esta solicitação de pagamento '
                        || SQLERRM;
                  v_sucesso := 1;
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro a  verificar o cronograma de retenção vinculado a esta solicitação de pagamento '
                        || SQLERRM;
                  v_sucesso := 1;
            END;

            IF v_sucesso = 0
            THEN
               BEGIN
                  DELETE FROM ifrbde.tab_cont_crono_pagamento
                        WHERE num_seq_resumo_pag_retencao =
                                                      :OLD.num_seq_resumo_pag;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao excluir o cronograma de retenção, gerado por esta solicitação de pagamento '
                           || SQLERRM;
                     v_sucesso := 1;
               END;
            END IF;
         END IF;

         
--
--  deleta os registros na area de integração com SmartStream
--
         IF v_sucesso = 0
         THEN
            BEGIN
               ifrbde.prc_exclui_sst_contrato_sp (
                  v_num_contrato,
                  v_num_versao_contrato,
                  :OLD.num_fatura_rp
               );
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao executar a exclusão da SP da area de integração com SmartStream - '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      
--
      END IF;

      
--
      v_liberacao_sp := 'F';
      
--       
      ifrbde.prc_liberacao_realizacao_sp (
         :OLD.num_seq_resumo_pag,
         :OLD.cod_tipo_pag_rp,
         v_carencia,
         v_num_contrato,
         :OLD.dat_vencimento_pag,
         :OLD.num_fatura_rp,
         v_liberacao_sp
      );

      
--
-- acessar cronograma realizado 
--
      IF v_sucesso = 0
      THEN
         IF :OLD.cod_tipo_pag_rp <> 'L'
         THEN
            BEGIN
               
--
               SELECT num_seq_resumo_crono
                 INTO v_num_seq_resumo_crono
                 FROM cad_resumo_cronograma
                WHERE num_seq_resumo_pag = :OLD.num_seq_resumo_pag;

               
--
               UPDATE cad_resumo_cronograma
                  SET num_seq_resumo_pag = NULL
                WHERE num_seq_resumo_crono = v_num_seq_resumo_crono;
            
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  raise_application_error (
                     -20100,
                     'Não foi localizado o cronograma realização desta fatura - Exclusão'
                  );
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        'Erro ao selecionar a fatura no cronograma realização - Exclusão '
                     || SQLERRM
                  );
            END;
         
--
         END IF;
      
--
      END IF;
   
--
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_CAD_RESUMO_PAGAMENTO_01

