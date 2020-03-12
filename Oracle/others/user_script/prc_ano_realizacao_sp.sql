/* Formatted on 2004/12/23 14:06 (Formatter Plus v4.5.2) */
-- Start of DDL Script for Procedure IFRBDE.PRC_ANO_REALIZACAO_SP
-- Generated 2-dez-2004 20:29:59 from SYSMAN@HOMOLOG2

CREATE OR REPLACE PROCEDURE ifrbde.prc_ano_realizacao_sp (
   p_operacao               IN       VARCHAR2,
   p_num_seq_resumo_pag     IN       NUMBER,
   p_cod_tipo_pag_rp        IN       VARCHAR2,
   p_cnt_cre_cod            IN       NUMBER,
   p_cnt_cod                IN       VARCHAR2,
   p_dat_vencimento         IN       DATE,
   p_num_fatura_rp          IN       VARCHAR2,
   p_tip_situacao_pag_in    IN       NUMBER,
   p_num_pgose              OUT      VARCHAR2,
   p_tip_situacao_pag_out   OUT      NUMBER
)
IS
   
--
   v_erro             VARCHAR2 (200);
   v_sucesso          NUMBER (1);
   
--
   v_ano_realizacao   VARCHAR2 (4);
   v_ano_corrente     VARCHAR2 (4);
   v_num_fatura_rp    VARCHAR2 (14);
   v_dat_liberacao    DATE;
--
BEGIN
   v_sucesso := 0;
   v_erro := '';
   
--
--  em atendimento ao despacho nº 9/EPPL4/2004
--
   v_ano_corrente := TO_CHAR (SYSDATE, 'yyyy');

   
--
--
--   
   IF p_operacao = 'I' ---- criterios para a operação de inclusão
   THEN
      
--
--   se o tipo do pagamento for diferente de [L]iberação de Retenção
--
      IF p_cod_tipo_pag_rp <> 'L'
      THEN
         
--
-- verifica se a data de vencimento da fatura é maior que a data de hoje
--
         IF TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy') <
               TO_DATE (TO_CHAR (p_dat_vencimento, 'dd/mm/yyyy'), 'dd/mm/yyyy')
         THEN
            
--
-- verifica se esta liberado na tabela de liberações de SP
--
            v_ano_realizacao := '0';

            BEGIN
               SELECT NVL (num_ano_realizacao, '0'), dat_liberacao
                 INTO v_ano_realizacao, v_dat_liberacao
                 FROM aux_liberacao_sp
                WHERE cnt_cre_cod_aux = p_cnt_cre_cod
                  AND cnt_cod_aux = p_cnt_cod
                  AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
                  AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
                  AND TO_DATE (
                         TO_CHAR (dat_liberacao, 'dd/mm/yyyy'),
                         'dd/mm/yyyy'
                      ) >= TO_DATE (
                              TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                              'dd/mm/yyyy'
                           );

               IF TRIM (v_ano_realizacao) = '0'
               THEN
                  v_erro :=
                     'O ano de realização do pgose não pode ser igual a zero';
                  v_sucesso := 1;
               ELSE
                  
--
--
--
                  p_num_pgose := v_ano_realizacao;

                  
--
--      atualiza na liberação a data que o dado foi incluido 
--
                  UPDATE aux_liberacao_sp
                     SET dat_inclusao = TO_DATE (
                                           TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                                           'dd/mm/yyyy'
                                        )
                   WHERE cnt_cre_cod_aux = p_cnt_cre_cod
                     AND cnt_cod_aux = p_cnt_cod
                     AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
                     AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
                     AND TO_DATE (
                            TO_CHAR (dat_liberacao, 'dd/mm/yyyy'),
                            'dd/mm/yyyy'
                         ) = TO_DATE (
                                TO_CHAR (v_dat_liberacao, 'dd/mm/yyyy'),
                                'dd/mm/yyyy'
                             );
               END IF;
            
--
--
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  v_sucesso := 0;
                  v_ano_realizacao := '0';
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao verificar de liberação de SP na Inclusão de SP'
                        || SQLERRM;
                  v_sucesso := 1;
            END;

            IF  v_sucesso = 0 AND v_ano_realizacao = '0'
            THEN
               
--
--   verifica se há bloqueio para o ano da data corrente
--
--              v_ano_corrente := to_char(sysdate,'yyyy');
--
               NULL;
            END IF;

            
--            
--
            IF  v_sucesso = 0 AND v_ano_realizacao = '0'
            THEN
               IF      TO_NUMBER (TO_CHAR (p_dat_vencimento, 'dd')) >= 1
                   AND TO_NUMBER (TO_CHAR (p_dat_vencimento, 'dd')) <= 15
                   AND TO_NUMBER (TO_CHAR (p_dat_vencimento, 'mm')) = 1
                   AND TO_NUMBER (TO_CHAR (p_dat_vencimento, 'yyyy')) > 2003
               THEN
                  p_num_pgose := TO_CHAR (
                                      TO_NUMBER (
                                         TO_CHAR (p_dat_vencimento, 'yyyy')
                                      )
                                    - 1
                                 );
               ELSE
                  
--
--   caso as demais criticas não fizeram efeito o ano de realização é igual ao corrente
--
                  p_num_pgose := v_ano_corrente;
               END IF;
            END IF;

            p_tip_situacao_pag_out := p_tip_situacao_pag_in;
         ELSE
            
--
-- verifica se a data de vencimento da fatura é menor ou igual a data de hoje
--
--
-- verifica se esta liberado na tabela de liberações de SP
--
            v_ano_realizacao := '0';

            BEGIN
               SELECT NVL (num_ano_realizacao, '0'), dat_liberacao
                 INTO v_ano_realizacao, v_dat_liberacao
                 FROM aux_liberacao_sp
                WHERE cnt_cre_cod_aux = p_cnt_cre_cod
                  AND cnt_cod_aux = p_cnt_cod
                  AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
                  AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
                  AND TO_DATE (
                         TO_CHAR (dat_liberacao, 'dd/mm/yyyy'),
                         'dd/mm/yyyy'
                      ) >= TO_DATE (
                              TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                              'dd/mm/yyyy'
                           );

               IF TRIM (v_ano_realizacao) = '0'
               THEN
                  v_erro :=
                     'O ano de realização do pgose não pode ser igual a zero';
                  v_sucesso := 1;
               ELSE
                  
--
--
--
                  p_num_pgose := v_ano_realizacao;
                  p_tip_situacao_pag_out := 9;

                  
--
--      atualiza na liberação a data que o dado foi incluido 
--
                  UPDATE aux_liberacao_sp
                     SET dat_inclusao = TO_DATE (
                                           TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                                           'dd/mm/yyyy'
                                        )
                   WHERE cnt_cre_cod_aux = p_cnt_cre_cod
                     AND cnt_cod_aux = p_cnt_cod
                     AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
                     AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
                     AND TO_DATE (
                            TO_CHAR (dat_liberacao, 'dd/mm/yyyy'),
                            'dd/mm/yyyy'
                         ) = TO_DATE (
                                TO_CHAR (v_dat_liberacao, 'dd/mm/yyyy'),
                                'dd/mm/yyyy'
                             );
               END IF;
            
--
--
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  v_erro :=
                        'Data de Vencimento Menor ou igual a data de Hoje, é obrigatório liberação pela area de gestores da SEDE';
                  v_sucesso := 1;
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao verificar de liberação de SP na Inclusão de SP'
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      ELSE
         
--      
--  se o tipo do pagamento for "L" liberacao de retencao
--
         p_num_pgose := TO_CHAR (SYSDATE, 'yyyy');
         p_tip_situacao_pag_out := p_tip_situacao_pag_in;
      
--
--            
      END IF;
   END IF;

   IF p_operacao = 'E' ---- criterios para a operação de exclusão
   THEN
      BEGIN
         SELECT num_ano_pgose
           INTO v_ano_realizacao
           FROM cad_pagamento_contrato
          WHERE num_seq_contrato_pag = p_num_seq_resumo_pag AND ROWNUM = 1;

         
--
--   verifica se o ano de realizacao da SP é menor que o ano atual
--
         IF v_ano_realizacao < v_ano_corrente
         THEN
            
--
-- verifica se esta liberado na tabela de liberações de SP
--
            v_ano_realizacao := '0';

            BEGIN
               SELECT NVL (num_ano_realizacao, '0'), dat_liberacao
                 INTO v_ano_realizacao, v_dat_liberacao
                 FROM aux_liberacao_sp
                WHERE cnt_cre_cod_aux = p_cnt_cre_cod
                  AND cnt_cod_aux = p_cnt_cod
                  AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
                  AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
                  AND TO_DATE (
                         TO_CHAR (dat_liberacao, 'dd/mm/yyyy'),
                         'dd/mm/yyyy'
                      ) >= TO_DATE (
                              TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                              'dd/mm/yyyy'
                           );
            
--
--
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  v_erro :=
                        'SP com ano de realização menor que o atual, é obrigatório liberação pela area de gestores da SEDE';
                  v_sucesso := 1;
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao verificar de liberação de SP na Exclusao de SP '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Erro ao verificar o ano de realização da SP '
                      || ' sequencial :'
                      || TO_CHAR (p_cnt_cre_cod)
                      || '  - contrato :'
                      || p_cnt_cod
                      || '  - numero da fatura :'
                      || p_num_fatura_rp
                      || '  - tipo de SP :'
                      || p_cod_tipo_pag_rp
                      || ' - '
                      || SQLERRM;
            v_sucesso := 1;
      END;
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_ano_realizacao_sp TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_ANO_REALIZACAO_SP

