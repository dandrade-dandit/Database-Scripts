DROP PROCEDURE ifrbde.prc_gerar_liberacao_retencao
/

CREATE OR REPLACE 
PROCEDURE ifrbde.prc_gerar_liberacao_retencao (
   p_num_pgose                 IN   VARCHAR2,
   p_num_seq_resumo_pag        IN   NUMBER,
   p_num_seq_pag_contrato_rp   IN   NUMBER,
   p_dat_pagamento             IN   DATE,
   p_num_fatura_rp             IN   VARCHAR2,
   p_num_versao_contrato       IN   VARCHAR2,
   p_flg_moeda_controle        IN   VARCHAR2,
   p_cod_tipo_pag_rp           IN   VARCHAR2,
   p_dat_moeda_rp              IN   DATE,
   p_val_cotacao_moeda_rp      IN   NUMBER,
   p_tip_situacao_pag          IN   NUMBER,
   p_val_pagamento_rp          IN   NUMBER,
   p_val_retencao_rp           IN   NUMBER,
   p_val_glosa_rp              IN   NUMBER,
   p_val_multa_rp              IN   NUMBER,
   p_val_liquido_nota_rp       IN   NUMBER,
   p_val_imposto_irrf_rp       IN   NUMBER,
   p_val_imposto_iss_rp        IN   NUMBER,
   p_val_imposto_pasep_rp      IN   NUMBER,
   p_val_imposto_icms_rp       IN   NUMBER,
   p_val_imposto_inss_rp       IN   NUMBER,
   p_val_impostos_rp           IN   NUMBER
)
IS
   
--
--
   v_val_retirada           NUMBER (18, 2);
   v_val_resta              NUMBER (18, 2);
   v_val_retirada_sec       NUMBER (18, 2);
   v_val_resta_sec          NUMBER (18, 2);
   
--
   v_erro                   VARCHAR2 (200);
   v_sucesso                NUMBER (1);
   
--
   v_qtd_recursos           NUMBER (2);
   v_total_recursos         NUMBER (18, 2);
   v_total_recursos_sec     NUMBER (18, 2);
   v_total_geral            NUMBER (18, 2);
   v_total_geral_sec        NUMBER (18, 2);
   
--
   v_valor_base_pag         NUMBER (12, 2);
   v_percentual_pag         NUMBER (10, 9);
   v_percentual_ret         NUMBER (10, 9);
   
--
   v_num_seq_pag_contrato   NUMBER (15);
   v_num_seq_ret_contrato   NUMBER (15);
   v_seq                    VARCHAR2 (2);
   v_num_fatura             VARCHAR2 (18);
   v_tipo                   VARCHAR2 (2);
   
--
   v_val_pagamento_r        NUMBER (18, 2);
   v_val_glosa_r            NUMBER (18, 2);
   v_val_retencao_r         NUMBER (18, 2);
   v_val_impostos_r         NUMBER (18, 2);
   v_val_multas_r           NUMBER (18, 2);
   v_val_irrf_r             NUMBER (18, 2);
   v_val_iss_r              NUMBER (18, 2);
   v_val_pasep_r            NUMBER (18, 2);
   v_val_icms_r             NUMBER (18, 2);
   v_val_inss_r             NUMBER (18, 2);
   
--
   v_val_pagamento          NUMBER (18, 2);
   v_val_glosa              NUMBER (18, 2);
   v_val_retencao           NUMBER (18, 2);
   v_val_impostos           NUMBER (18, 2);
   v_val_multas             NUMBER (18, 2);
   v_val_irrf               NUMBER (18, 2);
   v_val_iss                NUMBER (18, 2);
   v_val_pasep              NUMBER (18, 2);
   v_val_icms               NUMBER (18, 2);
   v_val_inss               NUMBER (18, 2);
   v_val_liquido            NUMBER (18, 2);

   
--

--
-- cursor para as quantidades e o valores totais dos saldos disponiveis
--

   CURSOR regc (
      p_num_seq_pag_contrato_c   NUMBER,
      p_pgose_c                  VARCHAR2,
      p_num_versao_c             VARCHAR2,
      p_num_fatura_c             VARCHAR2
   )
   IS
      SELECT   a.ccp_rti_cod,
               SUM (NVL (a.val_saldo_crono, 0)) AS saldo_carencia,
               SUM (NVL (a.val_saldo_crono_sec, 0)) AS saldo_carencia_sec
          FROM ifrbde.tab_cont_crono_pagamento a,
               ifrbde.cad_resumo_pagamento b
         WHERE a.num_seq_contrato_cron = p_num_seq_pag_contrato_c
           AND (   a.val_saldo_crono > 0
                OR a.val_saldo_crono_sec > 0
               )
           AND a.tip_cronograma = 'LR'
           AND a.num_versao_contrato_cron = p_num_versao_c
           AND a.num_seq_resumo_pag_retencao = b.num_seq_resumo_pag
           AND TRIM (b.num_fatura_rp) = TRIM (p_num_fatura_c)
      GROUP BY a.ccp_rti_cod;

   
--
-- cursor para os recursos por tipo e versao do cronograma
--
--
   CURSOR regcr (
      p_num_seq_resumo_cr   NUMBER,
      p_tip_cronograma_cr   VARCHAR2,
      p_cod_recurso_cr      VARCHAR2,
      p_pgose_cr            VARCHAR2,
      p_num_versao_cr       VARCHAR2,
      p_num_fatura_cr       VARCHAR2
   )
   IS
      SELECT     a.*
            FROM ifrbde.tab_cont_crono_pagamento a,
                 ifrbde.cad_resumo_pagamento b
           WHERE a.num_seq_contrato_cron = p_num_seq_resumo_cr
             AND a.ccp_rti_cod = p_cod_recurso_cr
             AND (   a.val_saldo_crono > 0
                  OR a.val_saldo_crono_sec > 0
                 )
             AND a.tip_cronograma = 'LR'
             AND a.num_versao_contrato_cron = p_num_versao_cr
             AND a.num_seq_resumo_pag_retencao = b.num_seq_resumo_pag
             AND TRIM (b.num_fatura_rp) = TRIM (p_num_fatura_cr)
      FOR UPDATE
        ORDER BY a.ccp_data_venc, a.tip_cronograma;
--
--
BEGIN
   v_sucesso := 0;
   v_erro := '';
   
--
   v_qtd_recursos := 0;
   v_total_recursos := 0;
   v_total_recursos_sec := 0;
   v_total_geral := 0;
   v_total_geral_sec := 0;
   
--
   v_percentual_pag := 1;
   v_percentual_ret := 1;

   
--
--  seta o tipo de cronograma de acordo com o tipo de pagamento
--
   IF p_cod_tipo_pag_rp = 'L'
   THEN
      v_tipo := 'LR';
   END IF;

   
--
   FOR regx IN regc (
                  p_num_seq_pag_contrato_rp,
                  p_num_pgose,
                  p_num_versao_contrato,
                  p_num_fatura_rp
               )
   LOOP
      v_qtd_recursos :=   v_qtd_recursos
                        + 1;
      v_total_geral :=   v_total_geral
                       + NVL (regx.saldo_carencia, 0);
      v_total_geral_sec :=
                          v_total_geral_sec
                        + NVL (regx.saldo_carencia_sec, 0);
   END LOOP;

   
--

   IF  v_qtd_recursos = 0 AND v_sucesso = 0
   THEN
      v_erro :=
            ' Não há Recurso Disponivel para pagamento no cronograma de liberação de retenção, para esta versão do contrato!!!!';
      v_sucesso := 1;
   END IF;

   
--
   IF      v_total_geral < (  p_val_pagamento_rp
                            - p_val_glosa_rp
                           )
       AND v_sucesso = 0
   THEN
      v_erro :=
               ' Não há Saldo Disponivel para pagamento no cronograma de liberação de retenção, para esta versão do contrato!!!!'
            || ' - Valor do Saldo : '
            || TO_CHAR (v_total_geral)
            || ' Resumo '
            || TO_CHAR (p_num_seq_pag_contrato_rp)
            || ' Versão '
            || p_num_versao_contrato
            || ' Fatura '
            || p_num_fatura_rp;
      v_sucesso := 1;
   END IF;

   
--
--

   IF p_flg_moeda_controle = '2'
   THEN
      IF      v_total_geral_sec <
                    ROUND (
                       (  (  p_val_pagamento_rp
                           - p_val_glosa_rp
                          )
                        / p_val_cotacao_moeda_rp
                       ),
                       2
                    )
          AND v_sucesso = 0
      THEN
         v_erro :=
                  ' Não há Saldo Disponivel para pagamento no cronograma de liberação de retenção na moeda secundaria, para esta versão do contrato!!!!'
               || ' - Valor do Saldo : '
               || TO_CHAR (v_total_geral_sec);
         v_sucesso := 1;
      END IF;
   END IF;

   
--

--
--  criar os registros no cad_pagamento_contrato
--
   IF v_sucesso = 0
   THEN
      v_seq := '1';

      IF v_qtd_recursos > 1
      THEN
         
--
         v_val_pagamento_r := p_val_pagamento_rp;
         v_val_glosa_r := p_val_glosa_rp;
         v_val_retencao_r := p_val_retencao_rp;
         v_val_impostos_r := p_val_impostos_rp;
         v_val_multas_r := p_val_multa_rp;
         v_val_irrf_r := p_val_imposto_irrf_rp;
         v_val_iss_r := p_val_imposto_iss_rp;
         v_val_pasep_r := p_val_imposto_pasep_rp;
         v_val_icms_r := p_val_imposto_icms_rp;
         v_val_inss_r := p_val_imposto_inss_rp;
         
--
         v_percentual_pag :=   (  NVL (p_val_pagamento_rp, 0)
                                - NVL (p_val_glosa_rp, 0)
                               )
                             / v_total_geral;
      
--

      ELSE
         
--

         v_valor_base_pag :=   p_val_pagamento_rp
                             - p_val_glosa_rp;
         
--
         v_val_pagamento := p_val_pagamento_rp;
         v_val_glosa := p_val_glosa_rp;
         v_val_retencao := p_val_retencao_rp;
         v_val_impostos := p_val_impostos_rp;
         v_val_multas := p_val_multa_rp;
         v_val_irrf := p_val_imposto_irrf_rp;
         v_val_iss := p_val_imposto_iss_rp;
         v_val_pasep := p_val_imposto_pasep_rp;
         v_val_icms := p_val_imposto_icms_rp;
         v_val_inss := p_val_imposto_inss_rp;
         v_val_liquido :=   v_val_pagamento
                          - v_val_glosa
                          - v_val_retencao
                          - v_val_impostos
                          - v_val_multas;
      
--
      END IF;

      
--
      FOR regx IN regc (
                     p_num_seq_pag_contrato_rp,
                     p_num_pgose,
                     p_num_versao_contrato,
                     p_num_fatura_rp
                  )
      LOOP
         IF v_qtd_recursos > 1
         THEN
            
--
            v_valor_base_pag :=
                            ROUND (regx.saldo_carencia * v_percentual_pag, 2);
            
--
--  calculo dos valores para gravação da SP
--
            v_val_pagamento := ROUND (
                                    (  NVL (p_val_pagamento_rp, 0)
                                     * v_valor_base_pag
                                    )
                                  / (  NVL (p_val_pagamento_rp, 0)
                                     - NVL (p_val_glosa_rp, 0)
                                    ),
                                  2
                               );
            v_val_glosa :=   v_val_pagamento
                           - v_valor_base_pag;
            v_val_retencao := ROUND (
                                   (  NVL (p_val_retencao_rp, 0)
                                    * v_valor_base_pag
                                   )
                                 / (  NVL (p_val_pagamento_rp, 0)
                                    - NVL (p_val_glosa_rp, 0)
                                   ),
                                 2
                              );
            v_val_impostos := ROUND (
                                   (  NVL (p_val_impostos_rp, 0)
                                    * v_valor_base_pag
                                   )
                                 / (  NVL (p_val_pagamento_rp, 0)
                                    - NVL (p_val_glosa_rp, 0)
                                   ),
                                 2
                              );
            v_val_multas := ROUND (
                                 (NVL (p_val_multa_rp, 0) * v_valor_base_pag)
                               / (  NVL (p_val_pagamento_rp, 0)
                                  - NVL (p_val_glosa_rp, 0)
                                 ),
                               2
                            );
            v_val_irrf := ROUND (
                               (  NVL (p_val_imposto_irrf_rp, 0)
                                * v_valor_base_pag
                               )
                             / (  NVL (p_val_pagamento_rp, 0)
                                - NVL (p_val_glosa_rp, 0)
                               ),
                             2
                          );
            v_val_iss := ROUND (
                              (  NVL (p_val_imposto_iss_rp, 0)
                               * v_valor_base_pag
                              )
                            / (  NVL (p_val_pagamento_rp, 0)
                               - NVL (p_val_glosa_rp, 0)
                              ),
                            2
                         );
            v_val_pasep := ROUND (
                                (  NVL (p_val_imposto_pasep_rp, 0)
                                 * v_valor_base_pag
                                )
                              / (  NVL (p_val_pagamento_rp, 0)
                                 - NVL (p_val_glosa_rp, 0)
                                ),
                              2
                           );
            v_val_icms := ROUND (
                               (  NVL (p_val_imposto_icms_rp, 0)
                                * v_valor_base_pag
                               )
                             / (  NVL (p_val_pagamento_rp, 0)
                                - NVL (p_val_glosa_rp, 0)
                               ),
                             2
                          );
            v_val_inss := ROUND (
                               (  NVL (p_val_imposto_inss_rp, 0)
                                * v_valor_base_pag
                               )
                             / (  NVL (p_val_pagamento_rp, 0)
                                - NVL (p_val_glosa_rp, 0)
                               ),
                             2
                          );
            v_val_liquido :=   v_valor_base_pag
                             - v_val_retencao
                             - v_val_impostos
                             - v_val_multas;
            
--
--
-- retira o calculado do valor restante
--
--
            v_val_pagamento_r :=   v_val_pagamento_r
                                 - v_val_pagamento;
            v_val_glosa_r :=   v_val_glosa_r
                             - v_val_glosa;
            v_val_retencao_r :=   v_val_retencao_r
                                - v_val_retencao;
            v_val_impostos_r :=   v_val_impostos_r
                                - v_val_impostos;
            v_val_multas_r :=   v_val_multas_r
                              - v_val_multas;
            v_val_irrf_r :=   v_val_irrf_r
                            - v_val_irrf;
            v_val_iss_r :=   v_val_iss_r
                           - v_val_iss;
            v_val_pasep_r :=   v_val_pasep_r
                             - v_val_pasep;
            v_val_icms_r :=   v_val_icms_r
                            - v_val_icms;
            v_val_inss_r :=   v_val_inss_r
                            - v_val_inss;

            
--
--
--  verifica-se se é o ultimo recurso para ajustes
--
            IF TO_NUMBER (v_seq) = v_qtd_recursos
            THEN
               IF v_val_pagamento_r <> 0
               THEN
                  v_val_pagamento :=   v_val_pagamento
                                     + v_val_pagamento_r;
               END IF;

               
--
               IF v_val_glosa_r <> 0
               THEN
                  v_val_glosa :=   v_val_glosa
                                 + v_val_glosa_r;
               END IF;

               
--
               IF v_val_retencao_r <> 0
               THEN
                  v_val_retencao :=   v_val_retencao
                                    + v_val_retencao_r;
               END IF;

               
--
               IF v_val_impostos_r <> 0
               THEN
                  v_val_impostos :=   v_val_impostos
                                    + v_val_impostos_r;
               END IF;

               
--
               IF v_val_multas_r <> 0
               THEN
                  v_val_multas :=   v_val_multas
                                  + v_val_multas_r;
               END IF;

               
--
               IF v_val_irrf_r <> 0
               THEN
                  v_val_irrf :=   v_val_irrf
                                + v_val_irrf_r;
               END IF;

               
--
               IF v_val_iss_r <> 0
               THEN
                  v_val_iss :=   v_val_iss
                               + v_val_iss_r;
               END IF;

               
--
               IF v_val_pasep_r <> 0
               THEN
                  v_val_pasep :=   v_val_pasep
                                 + v_val_pasep_r;
               END IF;

               
--
               IF v_val_icms_r <> 0
               THEN
                  v_val_icms :=   v_val_icms
                                + v_val_icms_r;
               END IF;

               
--
               IF v_val_inss_r <> 0
               THEN
                  v_val_inss :=   v_val_inss
                                + v_val_inss_r;
               END IF;

               
--
               v_val_liquido :=   v_val_pagamento
                                - v_val_glosa
                                - v_val_retencao
                                - v_val_impostos
                                - v_val_multas;
            
--

/*  raise_application_error (-20100,
     ' v_valor_base_pag '||to_char(v_valor_base_pag)
   ||' saldo da carencia '||to_char(regx.saldo_carencia)
   ||' percentual ' ||to_char(v_percentual_pag)
   ||' p_num_seq_resumo_pag      '||TO_CHAR(p_num_seq_resumo_pag)
   ||' p_num_seq_pag_contrato_rp '||TO_CHAR(p_num_seq_pag_contrato_rp)
   ||' p_dat_pagamento '||TO_CHAR(p_dat_pagamento,'DD/MM/YYYY')
   ||' p_num_fatura_rp '||v_num_fatura
   ||' p_num_versao_contrato '||p_num_versao_contrato
   ||' p_flg_moeda_controle '||p_flg_moeda_controle
   ||' p_cod_tipo_pag_rp '||p_cod_tipo_pag_rp
   ||' p_dat_moeda_rp'||to_char(p_dat_moeda_rp,'dd/mm/yyyy')
   ||' p_val_cotacao_moeda_rp '||to_char(p_val_cotacao_moeda_rp)
   ||' p_tip_situacao_pag '||to_char(p_tip_situacao_pag)
   ||' p_val_pagamento_rp '||to_char(v_val_pagamento)
   ||' p_val_glosa_rp '||to_char(v_val_glosa)
   ||' p_val_retencao_rp '||to_char(v_val_retencao)
   ||' p_val_multa_rp '||to_char(v_val_multas)
   ||' p_val_liquido_nota_rp '||to_char(v_val_liquido)
   ||' p_val_imposto_irrf_rp '||to_char(v_val_irrf)
   ||' p_val_imposto_iss_rp  '||to_char(v_val_iss)
   ||' p_val_imposto_pasep_rp '||to_char(v_val_pasep)
   ||' p_val_imposto_icms_rp '||to_char(v_val_icms)
   ||' p_val_imposto_inss_rp '||to_char(v_val_inss)
   ||' p_val_impostos_rp '||to_char(v_val_impostos)
   );
*/

--

            END IF;
         
--
         END IF;

         
--
--
         BEGIN
            SELECT ifrbde_views.seq_num_seq_contrato.NEXTVAL
              INTO v_num_seq_pag_contrato
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'Não consegui selecionar na sequence '
                  || SQLERRM
               );
         END;

         
--
         IF p_cod_tipo_pag_rp = 'L'
         THEN
            v_num_fatura :=    p_num_fatura_rp
                            || '-LR'
                            || v_seq;
         ELSE
            v_num_fatura :=    p_num_fatura_rp
                            || '-SP'
                            || v_seq;
         END IF;

         
/*
  raise_application_error (-20100,
     ' v_valor_base_pag '||to_char(v_valor_base_pag)
   ||' saldo da carencia '||to_char(regx.saldo_carencia)
   ||' percentual ' ||to_char(v_percentual_pag)
   ||' p_num_seq_resumo_pag      '||TO_CHAR(p_num_seq_resumo_pag)
   ||' p_num_seq_pag_contrato_rp '||TO_CHAR(p_num_seq_pag_contrato_rp)
   ||' p_dat_pagamento '||TO_CHAR(p_dat_pagamento,'DD/MM/YYYY')
   ||' p_num_fatura_rp '||v_num_fatura
   ||' p_num_versao_contrato '||p_num_versao_contrato
   ||' p_flg_moeda_controle '||p_flg_moeda_controle
   ||' p_cod_tipo_pag_rp '||p_cod_tipo_pag_rp
   ||' p_dat_moeda_rp'||to_char(p_dat_moeda_rp,'dd/mm/yyyy')
   ||' p_val_cotacao_moeda_rp '||to_char(p_val_cotacao_moeda_rp)
   ||' p_tip_situacao_pag '||to_char(p_tip_situacao_pag)
   ||' p_val_pagamento_rp '||to_char(v_val_pagamento)
   ||' p_val_glosa_rp '||to_char(v_val_glosa)
   ||' p_val_retencao_rp '||to_char(v_val_retencao)
   ||' p_val_multa_rp '||to_char(v_val_multas)
   ||' p_val_liquido_nota_rp '||to_char(v_val_liquido)
   ||' p_val_imposto_irrf_rp '||to_char(v_val_irrf)
   ||' p_val_imposto_iss_rp  '||to_char(v_val_iss)
   ||' p_val_imposto_pasep_rp '||to_char(v_val_pasep)
   ||' p_val_imposto_icms_rp '||to_char(v_val_icms)
   ||' p_val_imposto_inss_rp '||to_char(v_val_inss)
   ||' p_val_impostos_rp '||to_char(v_val_impostos)
   );
*/
--
         INSERT INTO ifrbde.cad_pagamento_contrato
                     (num_seq_pag_contrato, num_ano_pgose, cod_recurso,
                      cod_tipo_pag, val_pagamento, num_fatura_pagamento,
                      val_glosa, val_retencao, val_impostos,
                      val_multa, val_liquido_nota, num_seq_contrato_pag,
                      val_cotacao_moeda, tip_situacao_pagamento,
                      dat_situacao_pagamento, val_imposto_irrf,
                      val_imposto_iss, val_imposto_pasep, val_imposto_icms,
                      val_imposto_inss, num_seq_resumo_contrato)
              VALUES (v_num_seq_pag_contrato, p_num_pgose, regx.ccp_rti_cod,
                      p_cod_tipo_pag_rp, v_val_pagamento, v_num_fatura,
                      v_val_glosa, v_val_retencao, v_val_impostos,
                      v_val_multas, v_val_liquido, p_num_seq_resumo_pag,
                      p_val_cotacao_moeda_rp, p_tip_situacao_pag,
                      SYSDATE, v_val_irrf,
                      v_val_iss, v_val_pasep, v_val_icms,
                      v_val_inss, p_num_seq_pag_contrato_rp);

         
--
--   calcula os valores em Real e em dolares para retirada do cronograma
--
         v_val_resta := 0;
         v_val_retirada := 0;
         v_val_resta_sec := 0;
         v_val_retirada_sec := 0;

         IF p_flg_moeda_controle = '2'
         THEN
            v_val_resta_sec :=
                 ROUND (v_valor_base_pag / NVL (p_val_cotacao_moeda_rp, 1), 2);
            v_val_resta := 0;
         ELSE
            v_val_resta := v_valor_base_pag;
            v_val_resta_sec := 0;
         END IF;

         
--
         FOR regs IN regcr (
                        p_num_seq_pag_contrato_rp,
                        v_tipo,
                        regx.ccp_rti_cod,
                        p_num_pgose,
                        p_num_versao_contrato,
                        p_num_fatura_rp
                     )
         LOOP
            IF    v_val_resta > 0
               OR v_val_resta_sec > 0
            THEN
               
--
               IF p_flg_moeda_controle = '1'
               THEN
                  IF regs.val_saldo_crono >= v_val_resta
                  THEN
                     v_val_retirada := v_val_resta;
                     v_val_resta := 0;
                  ELSE
                     v_val_retirada := regs.val_saldo_crono;
                     v_val_resta :=   v_val_resta
                                    - v_val_retirada;
                  END IF;
               ELSE
                  IF regs.val_saldo_crono_sec >= v_val_resta_sec
                  THEN
                     v_val_retirada_sec := v_val_resta_sec;
                     v_val_resta_sec := 0;
                  ELSE
                     v_val_retirada_sec := regs.val_saldo_crono_sec;
                     v_val_resta_sec :=
                                         v_val_resta_sec
                                       - v_val_retirada_sec;
                  END IF;

                  v_val_retirada := ROUND (
                                       (  v_val_retirada_sec
                                        * NVL (p_val_cotacao_moeda_rp, 0)
                                       ),
                                       2
                                    );
               END IF;

               BEGIN
                  INSERT INTO ifrbde.hst_pagamento_cronograma
                              (num_seq_cronograma_hst,
                               num_seq_pag_contrato_hst, dat_execucao_hst,
                               cod_recurso_hst, val_retirado_hst,
                               val_retirado_sec_hst, tip_historico_pagamento)
                       VALUES (regs.num_seq_cronograma,
                               v_num_seq_pag_contrato, SYSDATE,
                               TRIM (regx.ccp_rti_cod), v_val_retirada,
                               v_val_retirada_sec, 'P');
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao incluir a parcela no historico de pagamento x cronograma'
                           || 'resumo '
                           || TO_CHAR (p_num_seq_pag_contrato_rp)
                           || ' tipo '
                           || v_tipo
                           || ' recurso '
                           || regx.ccp_rti_cod
                           || ' erro '
                           || SQLERRM;
                     v_sucesso := 1;
               END;
            
--
            END IF;
         END LOOP;

         IF  v_val_resta > 0 AND v_sucesso = 0
         THEN
            v_erro :=
                     'Não há saldo disponivel no cronograma na moeda principal para gerar a solicitação de Pagamento - faltou ='
                  || TO_CHAR (v_val_resta);
            v_sucesso := 1;
         END IF;

         
--
         IF  v_val_resta_sec > 0 AND v_sucesso = 0
         THEN
            v_erro :=
                     'Não há saldo disponivel no cronograma na moeda secundaria para gerar a solicitação de Pagamento - faltou ='
                  || TO_CHAR (v_val_resta_sec);
            v_sucesso := 1;
         END IF;

         
--
--  DESCARREGA A GERAÇÃO DA GLOSA
--
         IF  v_val_glosa > 0 AND v_sucesso = 0
         THEN
            
--
--   calcula os valores em Real e em dolares para retirada 
--   do cronograma, relativo a parte da Glosa
--
            v_val_resta := 0;
            v_val_retirada := 0;
            v_val_resta_sec := 0;
            v_val_retirada_sec := 0;

            IF p_flg_moeda_controle = '2'
            THEN
               v_val_resta_sec :=
                      ROUND (v_val_glosa / NVL (p_val_cotacao_moeda_rp, 1), 2);
               v_val_resta := 0;
            ELSE
               v_val_resta := v_val_glosa;
               v_val_resta_sec := 0;
            END IF;

            
--
            FOR regs IN regcr (
                           p_num_seq_pag_contrato_rp,
                           v_tipo,
                           regx.ccp_rti_cod,
                           p_num_pgose,
                           p_num_versao_contrato,
                           p_num_fatura_rp
                        )
            LOOP
               IF    v_val_resta > 0
                  OR v_val_resta_sec > 0
               THEN
                  IF p_flg_moeda_controle = '1'
                  THEN
                     IF regs.val_saldo_crono >= v_val_resta
                     THEN
                        v_val_retirada := v_val_resta;
                        v_val_resta := 0;
                     ELSE
                        v_val_retirada := regs.val_saldo_crono;
                        v_val_resta :=   v_val_resta
                                       - v_val_retirada;
                     END IF;
                  ELSE
                     IF regs.val_saldo_crono_sec >= v_val_resta_sec
                     THEN
                        v_val_retirada_sec := v_val_resta_sec;
                        v_val_resta_sec := 0;
                     ELSE
                        v_val_retirada_sec := regs.val_saldo_crono_sec;
                        v_val_resta_sec :=
                                         v_val_resta_sec
                                       - v_val_retirada_sec;
                     END IF;

                     v_val_retirada := ROUND (
                                          (  v_val_retirada_sec
                                           * NVL (p_val_cotacao_moeda_rp, 0)
                                          ),
                                          2
                                       );
                  END IF;

                  IF v_sucesso = 0
                  THEN
                     BEGIN
                        INSERT INTO ifrbde.hst_pagamento_cronograma
                                    (num_seq_cronograma_hst,
                                     num_seq_pag_contrato_hst,
                                     dat_execucao_hst, cod_recurso_hst,
                                     val_retirado_hst, val_retirado_sec_hst,
                                     tip_historico_pagamento)
                             VALUES (regs.num_seq_cronograma,
                                     v_num_seq_pag_contrato,
                                     SYSDATE, TRIM (regx.ccp_rti_cod),
                                     v_val_retirada, v_val_retirada_sec,
                                     'G');
                     
--
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           v_erro :=
                                    'Erro ao incluir a parcela no historico de pagamento x cronograma para a Glosa'
                                 || 'resumo '
                                 || TO_CHAR (p_num_seq_pag_contrato_rp)
                                 || 'tipo '
                                 || v_tipo
                                 || 'recurso '
                                 || regx.ccp_rti_cod
                                 || ' erro '
                                 || SQLERRM;
                           v_sucesso := 1;
                     END;
                  END IF;
               
--
               END IF;
            END LOOP;

            
--
            IF  v_val_resta > 0 AND v_sucesso = 0
            THEN
               v_erro :=
                        'Não há saldo disponivel no cronograma na moeda principal para gerar a solicitação de Pagamento - faltou ='
                     || TO_CHAR (v_val_resta);
               v_sucesso := 1;
            END IF;

            
--
            IF  v_val_resta_sec > 0 AND v_sucesso = 0
            THEN
               v_erro :=
                        'Não há saldo disponivel no cronograma na moeda secundaria para gerar a solicitação de Pagamento - faltou ='
                     || TO_CHAR (v_val_resta_sec);
               v_sucesso := 1;
            END IF;
         END IF;

         
--
--
         IF v_sucesso <> 0
         THEN
            raise_application_error (-20100, v_erro);
         END IF;

         
--

         v_seq := TO_CHAR (  TO_NUMBER (v_seq)
                           + 1, '0');
      END LOOP;
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_gerar_liberacao_retencao TO bde_views
/
GRANT EXECUTE ON ifrbde.prc_gerar_liberacao_retencao TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_GERAR_LIBERACAO_RETENCAO


