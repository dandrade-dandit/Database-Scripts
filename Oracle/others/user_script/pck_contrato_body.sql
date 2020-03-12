/* Formatted on 2005/08/24 11:47 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_contrato
IS
   
--------------------------------------------------------------------
-- Pesquisa Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_fiscais_contrato (
      p_usuario                 IN       VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato_fis, num_seq_pessoal_fis
           INTO vo_num_seq_contrato_fis (1), vo_num_seq_pessoal_fis (1)
           FROM ifrbde.cad_fiscais_contrato
          WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
            AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Fiscais do Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_fiscais_contrato (
      p_usuario                 IN       VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_fiscais_contrato
              WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
                AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis
         FOR UPDATE;

      v_cad_fiscais_contrato   ifrbde.cad_fiscais_contrato%ROWTYPE;
      v_dado                   VARCHAR2 (4000)                       := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_fiscais_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'num_seq_contrato_fis = '
                      || TO_CHAR (
                            v_cad_fiscais_contrato.num_seq_contrato_fis
                         );
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_pessoal_fis = '
                      || TO_CHAR (v_cad_fiscais_contrato.num_seq_pessoal_fis);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_FISCAIS_CONTRATO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.cad_fiscais_contrato
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_fiscais_contrato (
      p_usuario                 IN       VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   )
   AS
      v_num_seq_contrato_fis   cad_fiscais_contrato.num_seq_contrato_fis%TYPE;
      v_num_seq_pessoal_fis    cad_fiscais_contrato.num_seq_pessoal_fis%TYPE;
      v_dado                   VARCHAR2 (4000)                              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'INCLUI'
         )
      THEN
         v_num_seq_contrato_fis := vi_num_seq_contrato_fis;
         v_num_seq_pessoal_fis := vi_num_seq_pessoal_fis;

         INSERT INTO ifrbde.cad_fiscais_contrato
                     (num_seq_contrato_fis, num_seq_pessoal_fis)
              VALUES (v_num_seq_contrato_fis, v_num_seq_pessoal_fis);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_fiscais_contrato (
               p_usuario,
               vo_num_seq_contrato_fis,
               vo_num_seq_pessoal_fis,
               v_num_seq_contrato_fis,
               v_num_seq_pessoal_fis
            );
            v_dado :=
                  'num_seq_contrato_fis = '
               || TO_CHAR (v_num_seq_contrato_fis);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_pessoal_fis = '
                      || TO_CHAR (v_num_seq_pessoal_fis);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_FISCAIS_CONTRATO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_fiscais_contrato (
      p_usuario                 IN       VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_fiscais_contrato
              WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
                AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis
         FOR UPDATE;

      v_cad_fiscais_contrato   ifrbde.cad_fiscais_contrato%ROWTYPE;
      v_num_seq_contrato_fis   ifrbde.cad_fiscais_contrato.num_seq_contrato_fis%TYPE;
      v_num_seq_pessoal_fis    ifrbde.cad_fiscais_contrato.num_seq_pessoal_fis%TYPE;
      v_dado                   VARCHAR2 (4000)                              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_fiscais_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_num_seq_contrato_fis := vi_num_seq_contrato_fis;
            v_num_seq_pessoal_fis := vi_num_seq_pessoal_fis;

            
--            UPDATE IFRBDE.cad_fiscais_contrato
--            SET
--            WHERE CURRENT of c_cursor;
            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_fiscais_contrato (
                  p_usuario,
                  vo_num_seq_contrato_fis,
                  vo_num_seq_pessoal_fis,
                  vi_num_seq_contrato_fis,
                  vi_num_seq_pessoal_fis
               );
               v_dado :=    'num_seq_contrato_fis = '
                         || TO_CHAR (v_num_seq_contrato_fis);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_pessoal_fis = '
                         || TO_CHAR (v_num_seq_pessoal_fis);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_FISCAIS_CONTRATO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_participantes_con (
      p_usuario                   IN       VARCHAR2,
      vo_num_seq_contrato_part    OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod              OUT      tyt_num_fir_cod,
      vo_tip_fir_contrato         OUT      tyt_tip_fir_contrato,
      vo_num_seq_conta_bancaria   OUT      tyt_num_seq_conta_bancaria,
      vi_num_seq_contrato_part    IN       t_num_seq_contrato_part,
      vi_num_fir_cod              IN       t_num_fir_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato_part, num_fir_cod,
                tip_fir_contrato, num_seq_conta_bancaria
           INTO vo_num_seq_contrato_part (1), vo_num_fir_cod (1),
                vo_tip_fir_contrato (1), vo_num_seq_conta_bancaria (1)
           FROM ifrbde.cad_participantes_contrato
          WHERE num_seq_contrato_part = vi_num_seq_contrato_part
            AND num_fir_cod = vi_num_fir_cod;
      END IF;

      ifrbde.prc_gravar_usuario_firma (
         vi_num_seq_contrato_part,
         vi_num_fir_cod
      );
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Firmas do Contrato
   -- retorna o OK ou não
   PROCEDURE stp_exclui_participantes_contr (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_participantes_contrato
              WHERE num_seq_contrato_part = vi_num_seq_contrato_part
                AND num_fir_cod = vi_num_fir_cod
         FOR UPDATE;

      v_cad_participantes_contrato   ifrbde.cad_participantes_contrato%ROWTYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_participantes_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'num_seq_contrato_part = '
                  || TO_CHAR (
                        v_cad_participantes_contrato.num_seq_contrato_part
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_fir_cod = '
                      || TO_CHAR (v_cad_participantes_contrato.num_fir_cod);
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_fir_contrato = '
                  || TO_CHAR (v_cad_participantes_contrato.tip_fir_contrato);
            v_dado :=
                     v_dado
                  || ','
                  || 'num_seq_conta_bancaria = '
                  || TO_CHAR (
                        v_cad_participantes_contrato.num_seq_conta_bancaria
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_PARTICIPANTES_CONTRATO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.cad_participantes_contrato
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
                  raise_application_error (
                     -20100,
                     'Mais de um registro solicitado para exclusão. Operação não realizada!!!'
                  );
               END IF;
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para exclusão!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para exclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_participantes_contr (
      p_usuario                   IN       VARCHAR2,
      vo_num_seq_contrato_part    OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod              OUT      tyt_num_fir_cod,
      vo_tip_fir_contrato         OUT      tyt_tip_fir_contrato,
      vo_num_seq_conta_bancaria   OUT      tyt_num_seq_conta_bancaria,
      vi_num_seq_contrato_part    IN       t_num_seq_contrato_part,
      vi_num_fir_cod              IN       t_num_fir_cod,
      vi_tip_fir_contrato         IN       t_tip_fir_contrato,
      vi_num_seq_conta_bancaria   IN       t_num_seq_conta_bancaria
   )
   AS
      v_num_seq_contrato_part    cad_participantes_contrato.num_seq_contrato_part%TYPE;
      v_num_fir_cod              cad_participantes_contrato.num_fir_cod%TYPE;
      v_tip_fir_contrato         cad_participantes_contrato.tip_fir_contrato%TYPE;
      v_num_seq_conta_bancaria   cad_participantes_contrato.num_seq_conta_bancaria%TYPE;
      v_dado                     VARCHAR2 (4000)                            := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'INCLUI'
         )
      THEN
         v_num_seq_contrato_part := vi_num_seq_contrato_part;
         v_num_fir_cod := vi_num_fir_cod;
         v_tip_fir_contrato := vi_tip_fir_contrato;
         v_num_seq_conta_bancaria := vi_num_seq_conta_bancaria;

         INSERT INTO ifrbde.cad_participantes_contrato
                     (num_seq_contrato_part, num_fir_cod,
                      tip_fir_contrato, num_seq_conta_bancaria)
              VALUES (v_num_seq_contrato_part, v_num_fir_cod,
                      v_tip_fir_contrato, v_num_seq_conta_bancaria);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_participantes_con (
               p_usuario,
               vo_num_seq_contrato_part,
               vo_num_fir_cod,
               vo_tip_fir_contrato,
               vo_num_seq_conta_bancaria,
               v_num_seq_contrato_part,
               v_num_fir_cod
            );
            v_dado :=    'num_seq_contrato_part = '
                      || TO_CHAR (v_num_seq_contrato_part);
            v_dado :=
                      v_dado
                   || ','
                   || 'num_fir_cod = '
                   || TO_CHAR (v_num_fir_cod);
            v_dado :=    v_dado
                      || ','
                      || 'tip_fir_contrato = '
                      || TO_CHAR (v_tip_fir_contrato);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_conta_bancaria = '
                      || TO_CHAR (v_num_seq_conta_bancaria);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_PARTICIPANTES_CONTRATO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error (
               -20100,
               'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para inclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_participantes_contr (
      p_usuario                   IN       VARCHAR2,
      vo_num_seq_contrato_part    OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod              OUT      tyt_num_fir_cod,
      vo_tip_fir_contrato         OUT      tyt_tip_fir_contrato,
      vo_num_seq_conta_bancaria   OUT      tyt_num_seq_conta_bancaria,
      vi_num_seq_contrato_part    IN       t_num_seq_contrato_part,
      vi_num_fir_cod              IN       t_num_fir_cod,
      vi_tip_fir_contrato         IN       t_tip_fir_contrato,
      vi_num_seq_conta_bancaria   IN       t_num_seq_conta_bancaria
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_participantes_contrato
              WHERE num_seq_contrato_part = vi_num_seq_contrato_part
                AND num_fir_cod = vi_num_fir_cod
         FOR UPDATE;

      v_cad_participantes_contrato   ifrbde.cad_participantes_contrato%ROWTYPE;
      v_num_seq_contrato_part        ifrbde.cad_participantes_contrato.num_seq_contrato_part%TYPE;
      v_num_fir_cod                  ifrbde.cad_participantes_contrato.num_fir_cod%TYPE;
      v_tip_fir_contrato             ifrbde.cad_participantes_contrato.tip_fir_contrato%TYPE;
      v_num_seq_conta_bancaria       ifrbde.cad_participantes_contrato.num_seq_conta_bancaria%TYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_participantes_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_num_seq_contrato_part := vi_num_seq_contrato_part;
            v_num_fir_cod := vi_num_fir_cod;
            v_tip_fir_contrato := vi_tip_fir_contrato;
            v_num_seq_conta_bancaria := vi_num_seq_conta_bancaria;

            UPDATE ifrbde.cad_participantes_contrato
               SET tip_fir_contrato = v_tip_fir_contrato,
                   num_seq_conta_bancaria = v_num_seq_conta_bancaria
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_participantes_con (
                  p_usuario,
                  vo_num_seq_contrato_part,
                  vo_num_fir_cod,
                  vo_tip_fir_contrato,
                  vo_num_seq_conta_bancaria,
                  vi_num_seq_contrato_part,
                  vi_num_fir_cod
               );
               v_dado :=    'num_seq_contrato_part = '
                         || TO_CHAR (v_num_seq_contrato_part);
               v_dado :=
                      v_dado
                   || ','
                   || 'num_fir_cod = '
                   || TO_CHAR (v_num_fir_cod);
               v_dado :=    v_dado
                         || ','
                         || 'tip_fir_contrato = '
                         || TO_CHAR (v_tip_fir_contrato);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_conta_bancaria = '
                         || TO_CHAR (v_num_seq_conta_bancaria);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_PARTICIPANTES_CONTRATO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error (
                  -20100,
                  'Mais de um registro solicitado para alteração. Operação não realizada!!!'
               );
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para alteração!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para alteração!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_pagamento (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_pag_contrato_rp, num_seq_resumo_pag,
                num_seq_entidade_pag, cod_tipo_pag_rp,
                dat_pagamento, dat_vencimento_pag,
                num_fatura_rp, dat_moeda_rp,
                val_cotacao_moeda_rp, tip_cotacao_moeda_rp,
                val_pagamento_rp, val_glosa_rp,
                dsc_glosa_rp, val_retencao_rp,
                num_seq_entidade_rp, val_multa_rp,
                dsc_retencao_rp, val_imposto_irrf_rp,
                val_imposto_iss_rp, val_imposto_pasep_rp,
                val_imposto_icms_rp, val_imposto_inss_rp,
                val_impostos_rp, val_liquido_nota_rp,
                dsc_solicitacao_rp, tip_situacao_pag
           INTO vo_num_seq_pag_contrato_rp (1), vo_num_seq_resumo_pag (1),
                vo_num_seq_entidade_pag (1), vo_cod_tipo_pag_rp (1),
                vo_dat_pagamento (1), vo_dat_vencimento_pag (1),
                vo_num_fatura_rp (1), vo_dat_moeda_rp (1),
                vo_val_cotacao_moeda_rp (1), vo_tip_cotacao_moeda_rp (1),
                vo_val_pagamento_rp (1), vo_val_glosa_rp (1),
                vo_dsc_glosa_rp (1), vo_val_retencao_rp (1),
                vo_num_seq_entidade_rp (1), vo_val_multa_rp (1),
                vo_dsc_retencao_rp (1), vo_val_imposto_irrf_rp (1),
                vo_val_imposto_iss_rp (1), vo_val_imposto_pasep_rp (1),
                vo_val_imposto_icms_rp (1), vo_val_imposto_inss_rp (1),
                vo_val_impostos_rp (1), vo_val_liquido_nota_rp (1),
                vo_dsc_solicitacao_rp (1), vo_tip_situacao_pag (1)
           FROM ifrbde.cad_resumo_pagamento
          WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
            AND num_seq_resumo_pag = vi_num_seq_resumo_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Solicitação de Pagamento - SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_resumo_pagamento (
      p_usuario                    IN       VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_resumo_pagamento
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_cad_resumo_pagamento   ifrbde.cad_resumo_pagamento%ROWTYPE;
      v_dado                   VARCHAR2 (4000)                       := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_pagamento;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'num_seq_pag_contrato_rp = '
                  || TO_CHAR (v_cad_resumo_pagamento.num_seq_pag_contrato_rp);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_pag = '
                      || TO_CHAR (v_cad_resumo_pagamento.num_seq_resumo_pag);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_entidade_pag = '
                      || TO_CHAR (
                            v_cad_resumo_pagamento.num_seq_entidade_pag
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'cod_tipo_pag_rp = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_pagamento.cod_tipo_pag_rp)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'dat_pagamento = '
                      || TO_DATE (
                            v_cad_resumo_pagamento.dat_pagamento,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dat_vencimento_pag = '
                      || TO_DATE (
                            v_cad_resumo_pagamento.dat_vencimento_pag,
                            'DD/MM/YYYY'
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_fatura_rp = '
                  || RTRIM (
                        LTRIM (UPPER (v_cad_resumo_pagamento.num_fatura_rp))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_rp = '
                      || TO_DATE (
                            v_cad_resumo_pagamento.dat_moeda_rp,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda_rp = '
                      || TO_CHAR (
                            v_cad_resumo_pagamento.val_cotacao_moeda_rp
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_cotacao_moeda_rp = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_resumo_pagamento.tip_cotacao_moeda_rp
                           )
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_pagamento_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_glosa_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_glosa_rp);
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_glosa_rp = '
                  || RTRIM (
                        LTRIM (UPPER (v_cad_resumo_pagamento.dsc_glosa_rp))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_retencao_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_retencao_rp);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_entidade_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.num_seq_entidade_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_multa_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_multa_rp);
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_retencao_rp = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_pagamento.dsc_retencao_rp)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_irrf_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_imposto_irrf_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_iss_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_imposto_iss_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_pasep_rp = '
                      || TO_CHAR (
                            v_cad_resumo_pagamento.val_imposto_pasep_rp
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_icms_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_imposto_icms_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_inss_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_imposto_inss_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_impostos_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_impostos_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_liquido_nota_rp = '
                      || TO_CHAR (v_cad_resumo_pagamento.val_liquido_nota_rp);
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_solicitacao_rp = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_pagamento.dsc_solicitacao_rp)
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_situacao_pag = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_pagamento.tip_situacao_pag)
                        )
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_PAGAMENTO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.cad_resumo_pagamento
                     WHERE  CURRENT OF c_cursor;

               
--
--               ifrbde.prc_sincroniza_carencia
--                              (v_cad_resumo_pagamento.num_seq_pag_contrato_rp,
--                               'E'
--                              );
--

               --
-- atualiza os dados para o relatorio de cronograma de medicao - parte das SP´s
--
               ifrbde.prc_rel_cronograma_medicao (
                  vi_num_seq_pag_contrato_rp,
                  'CP'
               );

               
--
               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_pagamento (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp
   )
   AS
      v_num_seq_pag_contrato_rp   cad_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag        cad_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_num_seq_entidade_pag      cad_resumo_pagamento.num_seq_entidade_pag%TYPE;
      v_cod_tipo_pag_rp           cad_resumo_pagamento.cod_tipo_pag_rp%TYPE;
      v_dat_pagamento             cad_resumo_pagamento.dat_pagamento%TYPE;
      v_dat_vencimento_pag        cad_resumo_pagamento.dat_vencimento_pag%TYPE;
      v_num_fatura_rp             cad_resumo_pagamento.num_fatura_rp%TYPE;
      v_dat_moeda_rp              cad_resumo_pagamento.dat_moeda_rp%TYPE;
      v_val_cotacao_moeda_rp      cad_resumo_pagamento.val_cotacao_moeda_rp%TYPE;
      v_tip_cotacao_moeda_rp      cad_resumo_pagamento.tip_cotacao_moeda_rp%TYPE;
      v_val_pagamento_rp          cad_resumo_pagamento.val_pagamento_rp%TYPE;
      v_val_glosa_rp              cad_resumo_pagamento.val_glosa_rp%TYPE;
      v_dsc_glosa_rp              cad_resumo_pagamento.dsc_glosa_rp%TYPE;
      v_val_retencao_rp           cad_resumo_pagamento.val_retencao_rp%TYPE;
      v_num_seq_entidade_rp       cad_resumo_pagamento.num_seq_entidade_rp%TYPE;
      v_val_multa_rp              cad_resumo_pagamento.val_multa_rp%TYPE;
      v_dsc_retencao_rp           cad_resumo_pagamento.dsc_retencao_rp%TYPE;
      v_val_imposto_irrf_rp       cad_resumo_pagamento.val_imposto_irrf_rp%TYPE;
      v_val_imposto_iss_rp        cad_resumo_pagamento.val_imposto_iss_rp%TYPE;
      v_val_imposto_pasep_rp      cad_resumo_pagamento.val_imposto_pasep_rp%TYPE;
      v_val_imposto_icms_rp       cad_resumo_pagamento.val_imposto_icms_rp%TYPE;
      v_val_imposto_inss_rp       cad_resumo_pagamento.val_imposto_inss_rp%TYPE;
      v_val_liquido_nota_rp       cad_resumo_pagamento.val_liquido_nota_rp%TYPE;
      v_dsc_solicitacao_rp        cad_resumo_pagamento.dsc_solicitacao_rp%TYPE;
      v_dado                      VARCHAR2 (4000)                           := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_pag
           FROM DUAL;

         v_cod_tipo_pag_rp := RTRIM (LTRIM (vi_cod_tipo_pag_rp));
         v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
         v_tip_cotacao_moeda_rp := RTRIM (LTRIM (vi_tip_cotacao_moeda_rp));
         v_dsc_glosa_rp := RTRIM (LTRIM (vi_dsc_glosa_rp));
         v_dsc_retencao_rp := RTRIM (LTRIM (vi_dsc_retencao_rp));
         v_dsc_solicitacao_rp := RTRIM (LTRIM (vi_dsc_solicitacao_rp));
         v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
         v_dat_vencimento_pag := TO_DATE (vi_dat_vencimento_pag, 'DD/MM/YYYY');
         v_dat_moeda_rp := TO_DATE (vi_dat_moeda_rp, 'DD/MM/YYYY');
         v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
         v_num_seq_entidade_pag := vi_num_seq_entidade_pag;
         v_val_cotacao_moeda_rp := vi_val_cotacao_moeda_rp;
         v_val_pagamento_rp := vi_val_pagamento_rp;
         v_val_glosa_rp := vi_val_glosa_rp;
         v_val_retencao_rp := vi_val_retencao_rp;
         v_num_seq_entidade_rp := vi_num_seq_entidade_rp;
         v_val_multa_rp := vi_val_multa_rp;
         v_val_imposto_irrf_rp := vi_val_imposto_irrf_rp;
         v_val_imposto_iss_rp := vi_val_imposto_iss_rp;
         v_val_imposto_pasep_rp := vi_val_imposto_pasep_rp;
         v_val_imposto_icms_rp := vi_val_imposto_icms_rp;
         v_val_imposto_inss_rp := vi_val_imposto_inss_rp;
         v_val_liquido_nota_rp := vi_val_liquido_nota_rp;

         INSERT INTO ifrbde.cad_resumo_pagamento
                     (num_seq_pag_contrato_rp, num_seq_resumo_pag,
                      num_seq_entidade_pag, cod_tipo_pag_rp,
                      dat_pagamento, dat_vencimento_pag, num_fatura_rp,
                      dat_moeda_rp, val_cotacao_moeda_rp,
                      tip_cotacao_moeda_rp, val_pagamento_rp,
                      val_glosa_rp, dsc_glosa_rp, val_retencao_rp,
                      num_seq_entidade_rp, val_multa_rp,
                      dsc_retencao_rp, val_imposto_irrf_rp,
                      val_imposto_iss_rp, val_imposto_pasep_rp,
                      val_imposto_icms_rp, val_imposto_inss_rp,
                      val_liquido_nota_rp, dsc_solicitacao_rp)
              VALUES (v_num_seq_pag_contrato_rp, v_num_seq_resumo_pag,
                      v_num_seq_entidade_pag, v_cod_tipo_pag_rp,
                      v_dat_pagamento, v_dat_vencimento_pag, v_num_fatura_rp,
                      v_dat_moeda_rp, v_val_cotacao_moeda_rp,
                      v_tip_cotacao_moeda_rp, v_val_pagamento_rp,
                      v_val_glosa_rp, v_dsc_glosa_rp, v_val_retencao_rp,
                      v_num_seq_entidade_rp, v_val_multa_rp,
                      v_dsc_retencao_rp, v_val_imposto_irrf_rp,
                      v_val_imposto_iss_rp, v_val_imposto_pasep_rp,
                      v_val_imposto_icms_rp, v_val_imposto_inss_rp,
                      v_val_liquido_nota_rp, v_dsc_solicitacao_rp);

         
--
--         ifrbde.prc_sincroniza_carencia (v_num_seq_resumo_pag, 'I');
--
--
         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_resumo_pagamento (
               p_usuario,
               vo_num_seq_pag_contrato_rp,
               vo_num_seq_resumo_pag,
               vo_num_seq_entidade_pag,
               vo_cod_tipo_pag_rp,
               vo_dat_pagamento,
               vo_dat_vencimento_pag,
               vo_num_fatura_rp,
               vo_dat_moeda_rp,
               vo_val_cotacao_moeda_rp,
               vo_tip_cotacao_moeda_rp,
               vo_val_pagamento_rp,
               vo_val_glosa_rp,
               vo_dsc_glosa_rp,
               vo_val_retencao_rp,
               vo_num_seq_entidade_rp,
               vo_val_multa_rp,
               vo_dsc_retencao_rp,
               vo_val_imposto_irrf_rp,
               vo_val_imposto_iss_rp,
               vo_val_imposto_pasep_rp,
               vo_val_imposto_icms_rp,
               vo_val_imposto_inss_rp,
               vo_val_impostos_rp,
               vo_val_liquido_nota_rp,
               vo_dsc_solicitacao_rp,
               vo_tip_situacao_pag,
               v_num_seq_pag_contrato_rp,
               v_num_seq_resumo_pag
            );
            v_dado :=    'num_seq_pag_contrato_rp = '
                      || TO_CHAR (v_num_seq_pag_contrato_rp);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_pag = '
                      || TO_CHAR (v_num_seq_resumo_pag);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_entidade_pag = '
                      || TO_CHAR (v_num_seq_entidade_pag);
            v_dado :=    v_dado
                      || ','
                      || 'cod_tipo_pag_rp = '
                      || RTRIM (LTRIM (v_cod_tipo_pag_rp));
            v_dado :=    v_dado
                      || ','
                      || 'dat_pagamento = '
                      || TO_CHAR (v_dat_pagamento, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'dat_vencimento_pag = '
                      || TO_CHAR (v_dat_vencimento_pag, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'num_fatura_rp = '
                      || RTRIM (LTRIM (v_num_fatura_rp));
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_rp = '
                      || TO_CHAR (v_dat_moeda_rp, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda_rp = '
                      || TO_CHAR (v_val_cotacao_moeda_rp);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cotacao_moeda_rp = '
                      || RTRIM (LTRIM (v_tip_cotacao_moeda_rp));
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_rp = '
                      || TO_CHAR (v_val_pagamento_rp);
            v_dado :=
                    v_dado
                 || ','
                 || 'val_glosa_rp = '
                 || TO_CHAR (v_val_glosa_rp);
            v_dado :=    v_dado
                      || ','
                      || 'dsc_glosa_rp = '
                      || RTRIM (LTRIM (v_dsc_glosa_rp));
            v_dado :=    v_dado
                      || ','
                      || 'val_retencao_rp = '
                      || TO_CHAR (v_val_retencao_rp);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_entidade_rp = '
                      || TO_CHAR (v_num_seq_entidade_rp);
            v_dado :=
                    v_dado
                 || ','
                 || 'val_multa_rp = '
                 || TO_CHAR (v_val_multa_rp);
            v_dado :=    v_dado
                      || ','
                      || 'dsc_retencao_rp = '
                      || RTRIM (LTRIM (v_dsc_retencao_rp));
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_irrf_rp = '
                      || TO_CHAR (v_val_imposto_irrf_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_iss_rp = '
                      || TO_CHAR (v_val_imposto_iss_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_pasep_rp = '
                      || TO_CHAR (v_val_imposto_pasep_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_icms_rp = '
                      || TO_CHAR (v_val_imposto_icms_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_imposto_inss_rp = '
                      || TO_CHAR (v_val_imposto_inss_rp);
            v_dado :=    v_dado
                      || ','
                      || 'val_liquido_nota_rp = '
                      || TO_CHAR (v_val_liquido_nota_rp);
            v_dado :=    v_dado
                      || ','
                      || 'dsc_solicitacao_rp = '
                      || RTRIM (LTRIM (v_dsc_solicitacao_rp));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_PAGAMENTO',
               'I',
               v_dado
            );
            
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte das SP´s
--
            ifrbde.prc_rel_cronograma_medicao (
               v_num_seq_pag_contrato_rp,
               'CP'
            );
            
--
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_pagamento (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_resumo_pagamento
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_cad_resumo_pagamento      ifrbde.cad_resumo_pagamento%ROWTYPE;
      v_num_seq_pag_contrato_rp   ifrbde.cad_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag        ifrbde.cad_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_num_seq_entidade_pag      ifrbde.cad_resumo_pagamento.num_seq_entidade_pag%TYPE;
      v_cod_tipo_pag_rp           ifrbde.cad_resumo_pagamento.cod_tipo_pag_rp%TYPE;
      v_dat_pagamento             ifrbde.cad_resumo_pagamento.dat_pagamento%TYPE;
      v_dat_vencimento_pag        ifrbde.cad_resumo_pagamento.dat_vencimento_pag%TYPE;
      v_num_fatura_rp             ifrbde.cad_resumo_pagamento.num_fatura_rp%TYPE;
      v_dat_moeda_rp              ifrbde.cad_resumo_pagamento.dat_moeda_rp%TYPE;
      v_val_cotacao_moeda_rp      ifrbde.cad_resumo_pagamento.val_cotacao_moeda_rp%TYPE;
      v_tip_cotacao_moeda_rp      ifrbde.cad_resumo_pagamento.tip_cotacao_moeda_rp%TYPE;
      v_val_pagamento_rp          ifrbde.cad_resumo_pagamento.val_pagamento_rp%TYPE;
      v_val_glosa_rp              ifrbde.cad_resumo_pagamento.val_glosa_rp%TYPE;
      v_dsc_glosa_rp              ifrbde.cad_resumo_pagamento.dsc_glosa_rp%TYPE;
      v_val_retencao_rp           ifrbde.cad_resumo_pagamento.val_retencao_rp%TYPE;
      v_num_seq_entidade_rp       ifrbde.cad_resumo_pagamento.num_seq_entidade_rp%TYPE;
      v_val_multa_rp              ifrbde.cad_resumo_pagamento.val_multa_rp%TYPE;
      v_dsc_retencao_rp           ifrbde.cad_resumo_pagamento.dsc_retencao_rp%TYPE;
      v_val_imposto_irrf_rp       ifrbde.cad_resumo_pagamento.val_imposto_irrf_rp%TYPE;
      v_val_imposto_iss_rp        ifrbde.cad_resumo_pagamento.val_imposto_iss_rp%TYPE;
      v_val_imposto_pasep_rp      ifrbde.cad_resumo_pagamento.val_imposto_pasep_rp%TYPE;
      v_val_imposto_icms_rp       ifrbde.cad_resumo_pagamento.val_imposto_icms_rp%TYPE;
      v_val_imposto_inss_rp       ifrbde.cad_resumo_pagamento.val_imposto_inss_rp%TYPE;
      v_val_liquido_nota_rp       ifrbde.cad_resumo_pagamento.val_liquido_nota_rp%TYPE;
      v_dsc_solicitacao_rp        ifrbde.cad_resumo_pagamento.dsc_solicitacao_rp%TYPE;
      v_dado                      VARCHAR2 (4000)                           := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_pagamento;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cod_tipo_pag_rp := RTRIM (LTRIM (vi_cod_tipo_pag_rp));
            v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
            v_tip_cotacao_moeda_rp := RTRIM (LTRIM (vi_tip_cotacao_moeda_rp));
            v_dsc_glosa_rp := RTRIM (LTRIM (vi_dsc_glosa_rp));
            v_dsc_retencao_rp := RTRIM (LTRIM (vi_dsc_retencao_rp));
            v_dsc_solicitacao_rp := RTRIM (LTRIM (vi_dsc_solicitacao_rp));
            v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
            v_dat_vencimento_pag :=
                                 TO_DATE (vi_dat_vencimento_pag, 'DD/MM/YYYY');
            v_dat_moeda_rp := TO_DATE (vi_dat_moeda_rp, 'DD/MM/YYYY');
            v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
            v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
            v_num_seq_entidade_pag := vi_num_seq_entidade_pag;
            v_val_cotacao_moeda_rp := vi_val_cotacao_moeda_rp;
            v_val_pagamento_rp := vi_val_pagamento_rp;
            v_val_glosa_rp := vi_val_glosa_rp;
            v_val_retencao_rp := vi_val_retencao_rp;
            v_num_seq_entidade_rp := vi_num_seq_entidade_rp;
            v_val_multa_rp := vi_val_multa_rp;
            v_val_imposto_irrf_rp := vi_val_imposto_irrf_rp;
            v_val_imposto_iss_rp := vi_val_imposto_iss_rp;
            v_val_imposto_pasep_rp := vi_val_imposto_pasep_rp;
            v_val_imposto_icms_rp := vi_val_imposto_icms_rp;
            v_val_imposto_inss_rp := vi_val_imposto_inss_rp;
            v_val_liquido_nota_rp := vi_val_liquido_nota_rp;

            UPDATE ifrbde.cad_resumo_pagamento
               SET num_seq_entidade_pag = v_num_seq_entidade_pag,
                   cod_tipo_pag_rp = v_cod_tipo_pag_rp,
                   dat_pagamento = v_dat_pagamento,
                   dat_vencimento_pag = v_dat_vencimento_pag,
                   num_fatura_rp = v_num_fatura_rp,
                   dat_moeda_rp = v_dat_moeda_rp,
                   val_cotacao_moeda_rp = v_val_cotacao_moeda_rp,
                   tip_cotacao_moeda_rp = v_tip_cotacao_moeda_rp,
                   val_pagamento_rp = v_val_pagamento_rp,
                   val_glosa_rp = v_val_glosa_rp,
                   dsc_glosa_rp = v_dsc_glosa_rp,
                   val_retencao_rp = v_val_retencao_rp,
                   num_seq_entidade_rp = v_num_seq_entidade_rp,
                   val_multa_rp = v_val_multa_rp,
                   dsc_retencao_rp = v_dsc_retencao_rp,
                   val_imposto_irrf_rp = v_val_imposto_irrf_rp,
                   val_imposto_iss_rp = v_val_imposto_iss_rp,
                   val_imposto_pasep_rp = v_val_imposto_pasep_rp,
                   val_imposto_icms_rp = v_val_imposto_icms_rp,
                   val_imposto_inss_rp = v_val_imposto_inss_rp,
                   val_liquido_nota_rp = v_val_liquido_nota_rp,
                   dsc_solicitacao_rp = v_dsc_solicitacao_rp
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               
--
--               ifrbde.prc_sincroniza_carencia (vi_num_seq_resumo_pag, 'A');
--
--
               IF v_cad_resumo_pagamento.tip_situacao_pag = 1
               THEN
                  ifrbde.prc_conf_sol_pag_header_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_valor_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_acr_ret_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_outros_u (vi_num_seq_resumo_pag);
               END IF;

               stp_pesquisa_resumo_pagamento (
                  p_usuario,
                  vo_num_seq_pag_contrato_rp,
                  vo_num_seq_resumo_pag,
                  vo_num_seq_entidade_pag,
                  vo_cod_tipo_pag_rp,
                  vo_dat_pagamento,
                  vo_dat_vencimento_pag,
                  vo_num_fatura_rp,
                  vo_dat_moeda_rp,
                  vo_val_cotacao_moeda_rp,
                  vo_tip_cotacao_moeda_rp,
                  vo_val_pagamento_rp,
                  vo_val_glosa_rp,
                  vo_dsc_glosa_rp,
                  vo_val_retencao_rp,
                  vo_num_seq_entidade_rp,
                  vo_val_multa_rp,
                  vo_dsc_retencao_rp,
                  vo_val_imposto_irrf_rp,
                  vo_val_imposto_iss_rp,
                  vo_val_imposto_pasep_rp,
                  vo_val_imposto_icms_rp,
                  vo_val_imposto_inss_rp,
                  vo_val_impostos_rp,
                  vo_val_liquido_nota_rp,
                  vo_dsc_solicitacao_rp,
                  vo_tip_situacao_pag,
                  vi_num_seq_pag_contrato_rp,
                  vi_num_seq_resumo_pag
               );
               v_dado :=    'num_seq_pag_contrato_rp = '
                         || TO_CHAR (v_num_seq_pag_contrato_rp);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_resumo_pag = '
                         || TO_CHAR (v_num_seq_resumo_pag);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_entidade_pag = '
                         || TO_CHAR (v_num_seq_entidade_pag);
               v_dado :=    v_dado
                         || ','
                         || 'cod_tipo_pag_rp = '
                         || RTRIM (LTRIM (v_cod_tipo_pag_rp));
               v_dado :=    v_dado
                         || ','
                         || 'dat_pagamento = '
                         || TO_CHAR (v_dat_pagamento, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'dat_vencimento_pag = '
                         || TO_CHAR (v_dat_vencimento_pag, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'num_fatura_rp = '
                         || RTRIM (LTRIM (v_num_fatura_rp));
               v_dado :=    v_dado
                         || ','
                         || 'dat_moeda_rp = '
                         || TO_CHAR (v_dat_moeda_rp, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'val_cotacao_moeda_rp = '
                         || TO_CHAR (v_val_cotacao_moeda_rp);
               v_dado :=    v_dado
                         || ','
                         || 'tip_cotacao_moeda_rp = '
                         || RTRIM (LTRIM (v_tip_cotacao_moeda_rp));
               v_dado :=    v_dado
                         || ','
                         || 'val_pagamento_rp = '
                         || TO_CHAR (v_val_pagamento_rp);
               v_dado :=
                     v_dado
                  || ','
                  || 'val_glosa_rp = '
                  || TO_CHAR (v_val_glosa_rp);
               v_dado :=    v_dado
                         || ','
                         || 'dsc_glosa_rp = '
                         || RTRIM (LTRIM (v_dsc_glosa_rp));
               v_dado :=    v_dado
                         || ','
                         || 'val_retencao_rp = '
                         || TO_CHAR (v_val_retencao_rp);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_entidade_rp = '
                         || TO_CHAR (v_num_seq_entidade_rp);
               v_dado :=
                     v_dado
                  || ','
                  || 'val_multa_rp = '
                  || TO_CHAR (v_val_multa_rp);
               v_dado :=    v_dado
                         || ','
                         || 'dsc_retencao_rp = '
                         || RTRIM (LTRIM (v_dsc_retencao_rp));
               v_dado :=    v_dado
                         || ','
                         || 'val_imposto_irrf_rp = '
                         || TO_CHAR (v_val_imposto_irrf_rp);
               v_dado :=    v_dado
                         || ','
                         || 'val_imposto_iss_rp = '
                         || TO_CHAR (v_val_imposto_iss_rp);
               v_dado :=    v_dado
                         || ','
                         || 'val_imposto_pasep_rp = '
                         || TO_CHAR (v_val_imposto_pasep_rp);
               v_dado :=    v_dado
                         || ','
                         || 'val_imposto_icms_rp = '
                         || TO_CHAR (v_val_imposto_icms_rp);
               v_dado :=    v_dado
                         || ','
                         || 'val_imposto_inss_rp = '
                         || TO_CHAR (v_val_imposto_inss_rp);
               v_dado :=    v_dado
                         || ','
                         || 'val_liquido_nota_rp = '
                         || TO_CHAR (v_val_liquido_nota_rp);
               v_dado :=    v_dado
                         || ','
                         || 'dsc_solicitacao_rp = '
                         || RTRIM (LTRIM (v_dsc_solicitacao_rp));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_PAGAMENTO',
                  'A',
                  v_dado
               );
               
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte das SP´s
--
               ifrbde.prc_rel_cronograma_medicao (
                  vi_num_seq_pag_contrato_rp,
                  'CP'
               );
               
--
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_valores (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_cod_recurso_res         OUT      tyt_cod_recurso_res,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato_res, num_seq_resumo,
                val_resumo, cod_recurso_res, val_termo,
                val_pagamento, val_reajuste, val_pago,
                val_pago_reajuste, val_saldo_resumo,
                flg_moeda_controle, tip_moeda,
                dat_moeda, val_cotacao_moeda,
                tip_cotacao_moeda, val_resumo_sec,
                val_termo_sec, val_pagamento_sec,
                val_reajuste_sec, val_pago_sec,
                val_pago_reajuste_sec, val_saldo_resumo_sec
           INTO vo_num_seq_contrato_res (1), vo_num_seq_resumo (1),
                vo_val_resumo (1), vo_cod_recurso_res (1), vo_val_termo (1),
                vo_val_pagamento (1), vo_val_reajuste (1), vo_val_pago (1),
                vo_val_pago_reajuste (1), vo_val_saldo_resumo (1),
                vo_flg_moeda_controle (1), vo_tip_moeda (1),
                vo_dat_moeda (1), vo_val_cotacao_moeda (1),
                vo_tip_cotacao_moeda (1), vo_val_resumo_sec (1),
                vo_val_termo_sec (1), vo_val_pagamento_sec (1),
                vo_val_reajuste_sec (1), vo_val_pago_sec (1),
                vo_val_pago_reajuste_sec (1), vo_val_saldo_resumo_sec (1)
           FROM ifrbde.cad_resumo_valores
          WHERE num_seq_contrato_res = vi_num_seq_contrato_res
            AND num_seq_resumo = vi_num_seq_resumo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Resumo de Valores
   -- retorna o OK ou não
   PROCEDURE stp_exclui_resumo_valores (
      p_usuario                 IN       VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_res   IN       t_num_seq_contrato_res,
      vi_num_seq_resumo         IN       t_num_seq_resumo
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_resumo_valores
              WHERE num_seq_contrato_res = vi_num_seq_contrato_res
                AND num_seq_resumo = vi_num_seq_resumo
         FOR UPDATE;

      v_cad_resumo_valores   ifrbde.cad_resumo_valores%ROWTYPE;
      v_dado                 VARCHAR2 (4000)                     := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_valores;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'num_seq_contrato_res = '
                      || TO_CHAR (v_cad_resumo_valores.num_seq_contrato_res);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo = '
                      || TO_CHAR (v_cad_resumo_valores.num_seq_resumo);
            v_dado :=    v_dado
                      || ','
                      || 'val_resumo = '
                      || TO_CHAR (v_cad_resumo_valores.val_resumo);
            v_dado :=
                     v_dado
                  || ','
                  || 'cod_recurso_res = '
                  || RTRIM (
                        LTRIM (UPPER (v_cad_resumo_valores.cod_recurso_res))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_termo = '
                      || TO_CHAR (v_cad_resumo_valores.val_termo);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento = '
                      || TO_CHAR (v_cad_resumo_valores.val_pagamento);
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste = '
                      || TO_CHAR (v_cad_resumo_valores.val_reajuste);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago = '
                      || TO_CHAR (v_cad_resumo_valores.val_pago);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_reajuste = '
                      || TO_CHAR (v_cad_resumo_valores.val_pago_reajuste);
            v_dado :=    v_dado
                      || ','
                      || 'val_saldo_resumo = '
                      || TO_CHAR (v_cad_resumo_valores.val_saldo_resumo);
            v_dado :=
                     v_dado
                  || ','
                  || 'flg_moeda_controle = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_valores.flg_moeda_controle)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'tip_moeda = '
                      || RTRIM (
                            LTRIM (UPPER (v_cad_resumo_valores.tip_moeda))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda = '
                      || TO_DATE (
                            v_cad_resumo_valores.dat_moeda,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda = '
                      || TO_CHAR (v_cad_resumo_valores.val_cotacao_moeda);
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_cotacao_moeda = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_cad_resumo_valores.tip_cotacao_moeda)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_resumo_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_resumo_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_termo_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_termo_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_pagamento_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_reajuste_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_pago_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_reajuste_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_pago_reajuste_sec);
            v_dado :=    v_dado
                      || ','
                      || 'val_saldo_resumo_sec = '
                      || TO_CHAR (v_cad_resumo_valores.val_saldo_resumo_sec);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_VALORES',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.cad_resumo_valores
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_valores (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_cod_recurso_res         OUT      tyt_cod_recurso_res,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_val_resumo              IN       t_val_resumo,
      vi_cod_recurso_res         IN       t_cod_recurso_res,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   )
   AS
      v_num_seq_contrato_res   cad_resumo_valores.num_seq_contrato_res%TYPE;
      v_num_seq_resumo         cad_resumo_valores.num_seq_resumo%TYPE;
      v_val_resumo             cad_resumo_valores.val_resumo%TYPE;
      v_cod_recurso_res        cad_resumo_valores.cod_recurso_res%TYPE;
      v_flg_moeda_controle     cad_resumo_valores.flg_moeda_controle%TYPE;
      v_tip_moeda              cad_resumo_valores.tip_moeda%TYPE;
      v_dat_moeda              cad_resumo_valores.dat_moeda%TYPE;
      v_val_cotacao_moeda      cad_resumo_valores.val_cotacao_moeda%TYPE;
      v_tip_cotacao_moeda      cad_resumo_valores.tip_cotacao_moeda%TYPE;
      v_dado                   VARCHAR2 (4000)                              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo
           FROM DUAL;

         v_cod_recurso_res := RTRIM (LTRIM (vi_cod_recurso_res));
         v_flg_moeda_controle := RTRIM (LTRIM (vi_flg_moeda_controle));
         v_tip_moeda := RTRIM (LTRIM (vi_tip_moeda));
         v_tip_cotacao_moeda := RTRIM (LTRIM (vi_tip_cotacao_moeda));
         v_dat_moeda := TO_DATE (vi_dat_moeda, 'DD/MM/YYYY');
         v_num_seq_contrato_res := vi_num_seq_contrato_res;
         v_val_resumo := vi_val_resumo;
         v_val_cotacao_moeda := vi_val_cotacao_moeda;

         INSERT INTO ifrbde.cad_resumo_valores
                     (num_seq_contrato_res, num_seq_resumo, val_resumo,
                      cod_recurso_res, flg_moeda_controle, tip_moeda,
                      dat_moeda, val_cotacao_moeda, tip_cotacao_moeda)
              VALUES (v_num_seq_contrato_res, v_num_seq_resumo, v_val_resumo,
                      v_cod_recurso_res, v_flg_moeda_controle, v_tip_moeda,
                      v_dat_moeda, v_val_cotacao_moeda, v_tip_cotacao_moeda);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_resumo_valores (
               p_usuario,
               vo_num_seq_contrato_res,
               vo_num_seq_resumo,
               vo_val_resumo,
               vo_cod_recurso_res,
               vo_val_termo,
               vo_val_pagamento,
               vo_val_reajuste,
               vo_val_pago,
               vo_val_pago_reajuste,
               vo_val_saldo_resumo,
               vo_flg_moeda_controle,
               vo_tip_moeda,
               vo_dat_moeda,
               vo_val_cotacao_moeda,
               vo_tip_cotacao_moeda,
               vo_val_resumo_sec,
               vo_val_termo_sec,
               vo_val_pagamento_sec,
               vo_val_reajuste_sec,
               vo_val_pago_sec,
               vo_val_pago_reajuste_sec,
               vo_val_saldo_resumo_sec,
               v_num_seq_contrato_res,
               v_num_seq_resumo
            );
            v_dado :=
                  'num_seq_contrato_res = '
               || TO_CHAR (v_num_seq_contrato_res);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo = '
                      || TO_CHAR (v_num_seq_resumo);
            v_dado :=
                        v_dado
                     || ','
                     || 'val_resumo = '
                     || TO_CHAR (v_val_resumo);
            v_dado :=    v_dado
                      || ','
                      || 'cod_recurso_res = '
                      || RTRIM (LTRIM (v_cod_recurso_res));
            v_dado :=    v_dado
                      || ','
                      || 'flg_moeda_controle = '
                      || RTRIM (LTRIM (v_flg_moeda_controle));
            v_dado :=
                    v_dado
                 || ','
                 || 'tip_moeda = '
                 || RTRIM (LTRIM (v_tip_moeda));
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda = '
                      || TO_CHAR (v_dat_moeda, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda = '
                      || TO_CHAR (v_val_cotacao_moeda);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cotacao_moeda = '
                      || RTRIM (LTRIM (v_tip_cotacao_moeda));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_VALORES',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_valores (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_cod_recurso_res         OUT      tyt_cod_recurso_res,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo,
      vi_val_resumo              IN       t_val_resumo,
      vi_cod_recurso_res         IN       t_cod_recurso_res,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_resumo_valores
              WHERE num_seq_contrato_res = vi_num_seq_contrato_res
                AND num_seq_resumo = vi_num_seq_resumo
         FOR UPDATE;

      v_cad_resumo_valores     ifrbde.cad_resumo_valores%ROWTYPE;
      v_num_seq_contrato_res   ifrbde.cad_resumo_valores.num_seq_contrato_res%TYPE;
      v_num_seq_resumo         ifrbde.cad_resumo_valores.num_seq_resumo%TYPE;
      v_val_resumo             ifrbde.cad_resumo_valores.val_resumo%TYPE;
      v_cod_recurso_res        ifrbde.cad_resumo_valores.cod_recurso_res%TYPE;
      v_flg_moeda_controle     ifrbde.cad_resumo_valores.flg_moeda_controle%TYPE;
      v_tip_moeda              ifrbde.cad_resumo_valores.tip_moeda%TYPE;
      v_dat_moeda              ifrbde.cad_resumo_valores.dat_moeda%TYPE;
      v_val_cotacao_moeda      ifrbde.cad_resumo_valores.val_cotacao_moeda%TYPE;
      v_tip_cotacao_moeda      ifrbde.cad_resumo_valores.tip_cotacao_moeda%TYPE;
      v_dado                   VARCHAR2 (4000)                              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_valores;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cod_recurso_res := RTRIM (LTRIM (vi_cod_recurso_res));
            v_flg_moeda_controle := RTRIM (LTRIM (vi_flg_moeda_controle));
            v_tip_moeda := RTRIM (LTRIM (vi_tip_moeda));
            v_tip_cotacao_moeda := RTRIM (LTRIM (vi_tip_cotacao_moeda));
            v_dat_moeda := TO_DATE (vi_dat_moeda, 'DD/MM/YYYY');
            v_num_seq_contrato_res := vi_num_seq_contrato_res;
            v_num_seq_resumo := vi_num_seq_resumo;
            v_val_resumo := vi_val_resumo;
            v_val_cotacao_moeda := vi_val_cotacao_moeda;

            UPDATE ifrbde.cad_resumo_valores
               SET val_resumo = v_val_resumo,
                   cod_recurso_res = v_cod_recurso_res,
                   flg_moeda_controle = v_flg_moeda_controle,
                   tip_moeda = v_tip_moeda,
                   dat_moeda = v_dat_moeda,
                   val_cotacao_moeda = v_val_cotacao_moeda,
                   tip_cotacao_moeda = v_tip_cotacao_moeda
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_resumo_valores (
                  p_usuario,
                  vo_num_seq_contrato_res,
                  vo_num_seq_resumo,
                  vo_val_resumo,
                  vo_cod_recurso_res,
                  vo_val_termo,
                  vo_val_pagamento,
                  vo_val_reajuste,
                  vo_val_pago,
                  vo_val_pago_reajuste,
                  vo_val_saldo_resumo,
                  vo_flg_moeda_controle,
                  vo_tip_moeda,
                  vo_dat_moeda,
                  vo_val_cotacao_moeda,
                  vo_tip_cotacao_moeda,
                  vo_val_resumo_sec,
                  vo_val_termo_sec,
                  vo_val_pagamento_sec,
                  vo_val_reajuste_sec,
                  vo_val_pago_sec,
                  vo_val_pago_reajuste_sec,
                  vo_val_saldo_resumo_sec,
                  vi_num_seq_contrato_res,
                  vi_num_seq_resumo
               );
               v_dado :=    'num_seq_contrato_res = '
                         || TO_CHAR (v_num_seq_contrato_res);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_resumo = '
                         || TO_CHAR (v_num_seq_resumo);
               v_dado :=
                        v_dado
                     || ','
                     || 'val_resumo = '
                     || TO_CHAR (v_val_resumo);
               v_dado :=    v_dado
                         || ','
                         || 'cod_recurso_res = '
                         || RTRIM (LTRIM (v_cod_recurso_res));
               v_dado :=    v_dado
                         || ','
                         || 'flg_moeda_controle = '
                         || RTRIM (LTRIM (v_flg_moeda_controle));
               v_dado :=    v_dado
                         || ','
                         || 'tip_moeda = '
                         || RTRIM (LTRIM (v_tip_moeda));
               v_dado :=    v_dado
                         || ','
                         || 'dat_moeda = '
                         || TO_CHAR (v_dat_moeda, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'val_cotacao_moeda = '
                         || TO_CHAR (v_val_cotacao_moeda);
               v_dado :=    v_dado
                         || ','
                         || 'tip_cotacao_moeda = '
                         || RTRIM (LTRIM (v_tip_cotacao_moeda));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_VALORES',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_termo_aditivo_con (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_termo_aditivo,
                num_seq_contrato_origem, dat_termo_aditivo,
                num_termo_aditivo, dsc_objeto_termo,
                dat_publicacao, num_dou_publicacao,
                num_secao_publicacao, num_pagina_publicacao,
                tip_termo_aditivo, num_prazo,
                flg_aum_dim
           INTO vo_num_seq_termo_aditivo (1),
                vo_num_seq_contrato_origem (1), vo_dat_termo_aditivo (1),
                vo_num_termo_aditivo (1), vo_dsc_objeto_termo (1),
                vo_dat_publicacao (1), vo_num_dou_publicacao (1),
                vo_num_secao_publicacao (1), vo_num_pagina_publicacao (1),
                vo_tip_termo_aditivo (1), vo_num_prazo (1),
                vo_flg_aum_dim (1)
           FROM ifrbde.cad_termo_aditivo_contrato
          WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
            AND num_seq_contrato_origem = vi_num_seq_contrato_origem;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Registrar Termo Aditivo
   -- retorna o OK ou não
   PROCEDURE stp_exclui_termo_aditivo_contr (
      p_usuario                    IN       VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_termo_aditivo_contrato
              WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
                AND num_seq_contrato_origem = vi_num_seq_contrato_origem
         FOR UPDATE;

      v_cad_termo_aditivo_contrato   ifrbde.cad_termo_aditivo_contrato%ROWTYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_termo_aditivo_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'num_seq_termo_aditivo = '
                  || TO_CHAR (
                        v_cad_termo_aditivo_contrato.num_seq_termo_aditivo
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_seq_contrato_origem = '
                  || TO_CHAR (
                        v_cad_termo_aditivo_contrato.num_seq_contrato_origem
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'dat_termo_aditivo = '
                  || TO_DATE (
                        v_cad_termo_aditivo_contrato.dat_termo_aditivo,
                        'DD/MM/YYYY'
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_termo_aditivo = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.num_termo_aditivo
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_objeto_termo = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.dsc_objeto_termo
                           )
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'dat_publicacao = '
                      || TO_DATE (
                            v_cad_termo_aditivo_contrato.dat_publicacao,
                            'DD/MM/YYYY'
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_dou_publicacao = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.num_dou_publicacao
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_secao_publicacao = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.num_secao_publicacao
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_pagina_publicacao = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.num_pagina_publicacao
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_termo_aditivo = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_cad_termo_aditivo_contrato.tip_termo_aditivo
                           )
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_prazo = '
                      || TO_CHAR (v_cad_termo_aditivo_contrato.num_prazo);
            v_dado :=    v_dado
                      || ','
                      || 'flg_aum_dim = '
                      || TO_CHAR (v_cad_termo_aditivo_contrato.flg_aum_dim);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_TERMO_ADITIVO_CONTRATO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.cad_termo_aditivo_contrato
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_termo_aditivo_contr (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   )
   AS
      v_num_seq_termo_aditivo     cad_termo_aditivo_contrato.num_seq_termo_aditivo%TYPE;
      v_num_seq_contrato_origem   cad_termo_aditivo_contrato.num_seq_contrato_origem%TYPE;
      v_dat_termo_aditivo         cad_termo_aditivo_contrato.dat_termo_aditivo%TYPE;
      v_num_termo_aditivo         cad_termo_aditivo_contrato.num_termo_aditivo%TYPE;
      v_dsc_objeto_termo          cad_termo_aditivo_contrato.dsc_objeto_termo%TYPE;
      v_dat_publicacao            cad_termo_aditivo_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao        cad_termo_aditivo_contrato.num_dou_publicacao%TYPE;
      v_num_secao_publicacao      cad_termo_aditivo_contrato.num_secao_publicacao%TYPE;
      v_num_pagina_publicacao     cad_termo_aditivo_contrato.num_pagina_publicacao%TYPE;
      v_tip_termo_aditivo         cad_termo_aditivo_contrato.tip_termo_aditivo%TYPE;
      v_num_prazo                 cad_termo_aditivo_contrato.num_prazo%TYPE;
      v_flg_aum_dim               cad_termo_aditivo_contrato.flg_aum_dim%TYPE;
      v_dado                      VARCHAR2 (4000)                           := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_termo_aditivo
           FROM DUAL;

         v_num_termo_aditivo := RTRIM (LTRIM (vi_num_termo_aditivo));
         v_dsc_objeto_termo := RTRIM (LTRIM (vi_dsc_objeto_termo));
         v_num_dou_publicacao := RTRIM (LTRIM (vi_num_dou_publicacao));
         v_num_secao_publicacao := RTRIM (LTRIM (vi_num_secao_publicacao));
         v_num_pagina_publicacao := RTRIM (LTRIM (vi_num_pagina_publicacao));
         v_tip_termo_aditivo := RTRIM (LTRIM (vi_tip_termo_aditivo));
         v_dat_termo_aditivo := TO_DATE (vi_dat_termo_aditivo, 'DD/MM/YYYY');
         v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
         v_num_seq_contrato_origem := vi_num_seq_contrato_origem;
         v_num_prazo := vi_num_prazo;
         v_flg_aum_dim := vi_flg_aum_dim;

         INSERT INTO ifrbde.cad_termo_aditivo_contrato
                     (num_seq_termo_aditivo, num_seq_contrato_origem,
                      dat_termo_aditivo, num_termo_aditivo,
                      dsc_objeto_termo, dat_publicacao,
                      num_dou_publicacao, num_secao_publicacao,
                      num_pagina_publicacao, tip_termo_aditivo,
                      num_prazo, flg_aum_dim)
              VALUES (v_num_seq_termo_aditivo, v_num_seq_contrato_origem,
                      v_dat_termo_aditivo, v_num_termo_aditivo,
                      v_dsc_objeto_termo, v_dat_publicacao,
                      v_num_dou_publicacao, v_num_secao_publicacao,
                      v_num_pagina_publicacao, v_tip_termo_aditivo,
                      v_num_prazo, v_flg_aum_dim);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_termo_aditivo_con (
               p_usuario,
               vo_num_seq_termo_aditivo,
               vo_num_seq_contrato_origem,
               vo_dat_termo_aditivo,
               vo_num_termo_aditivo,
               vo_dsc_objeto_termo,
               vo_dat_publicacao,
               vo_num_dou_publicacao,
               vo_num_secao_publicacao,
               vo_num_pagina_publicacao,
               vo_tip_termo_aditivo,
               vo_num_prazo,
               vo_flg_aum_dim,
               v_num_seq_termo_aditivo,
               v_num_seq_contrato_origem
            );
            v_dado :=    'num_seq_termo_aditivo = '
                      || TO_CHAR (v_num_seq_termo_aditivo);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_contrato_origem = '
                      || TO_CHAR (v_num_seq_contrato_origem);
            v_dado :=    v_dado
                      || ','
                      || 'dat_termo_aditivo = '
                      || TO_CHAR (v_dat_termo_aditivo, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'num_termo_aditivo = '
                      || RTRIM (LTRIM (v_num_termo_aditivo));
            v_dado :=    v_dado
                      || ','
                      || 'dsc_objeto_termo = '
                      || RTRIM (LTRIM (v_dsc_objeto_termo));
            v_dado :=    v_dado
                      || ','
                      || 'dat_publicacao = '
                      || TO_CHAR (v_dat_publicacao, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'num_dou_publicacao = '
                      || RTRIM (LTRIM (v_num_dou_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'num_secao_publicacao = '
                      || RTRIM (LTRIM (v_num_secao_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'num_pagina_publicacao = '
                      || RTRIM (LTRIM (v_num_pagina_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'tip_termo_aditivo = '
                      || RTRIM (LTRIM (v_tip_termo_aditivo));
            v_dado :=    v_dado
                      || ','
                      || 'num_prazo = '
                      || TO_CHAR (v_num_prazo);
            v_dado :=
                      v_dado
                   || ','
                   || 'flg_aum_dim = '
                   || TO_CHAR (v_flg_aum_dim);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_TERMO_ADITIVO_CONTRATO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_altera_termo_aditivo_contr (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_termo_aditivo_contrato
              WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
                AND num_seq_contrato_origem = vi_num_seq_contrato_origem
         FOR UPDATE;

      v_cad_termo_aditivo_contrato   ifrbde.cad_termo_aditivo_contrato%ROWTYPE;
      v_num_seq_termo_aditivo        ifrbde.cad_termo_aditivo_contrato.num_seq_termo_aditivo%TYPE;
      v_num_seq_contrato_origem      ifrbde.cad_termo_aditivo_contrato.num_seq_contrato_origem%TYPE;
      v_dat_termo_aditivo            ifrbde.cad_termo_aditivo_contrato.dat_termo_aditivo%TYPE;
      v_num_termo_aditivo            ifrbde.cad_termo_aditivo_contrato.num_termo_aditivo%TYPE;
      v_dsc_objeto_termo             ifrbde.cad_termo_aditivo_contrato.dsc_objeto_termo%TYPE;
      v_dat_publicacao               ifrbde.cad_termo_aditivo_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao           ifrbde.cad_termo_aditivo_contrato.num_dou_publicacao%TYPE;
      v_num_secao_publicacao         ifrbde.cad_termo_aditivo_contrato.num_secao_publicacao%TYPE;
      v_num_pagina_publicacao        ifrbde.cad_termo_aditivo_contrato.num_pagina_publicacao%TYPE;
      v_tip_termo_aditivo            ifrbde.cad_termo_aditivo_contrato.tip_termo_aditivo%TYPE;
      v_num_prazo                    ifrbde.cad_termo_aditivo_contrato.num_prazo%TYPE;
      v_flg_aum_dim                  ifrbde.cad_termo_aditivo_contrato.flg_aum_dim%TYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_termo_aditivo_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_num_termo_aditivo := RTRIM (LTRIM (vi_num_termo_aditivo));
            v_dsc_objeto_termo := RTRIM (LTRIM (vi_dsc_objeto_termo));
            v_num_dou_publicacao := RTRIM (LTRIM (vi_num_dou_publicacao));
            v_num_secao_publicacao := RTRIM (LTRIM (vi_num_secao_publicacao));
            v_num_pagina_publicacao :=
                                     RTRIM (LTRIM (vi_num_pagina_publicacao));
            v_tip_termo_aditivo := RTRIM (LTRIM (vi_tip_termo_aditivo));
            v_dat_termo_aditivo :=
                                  TO_DATE (vi_dat_termo_aditivo, 'DD/MM/YYYY');
            v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
            v_num_seq_termo_aditivo := vi_num_seq_termo_aditivo;
            v_num_seq_contrato_origem := vi_num_seq_contrato_origem;
            v_num_prazo := vi_num_prazo;
            v_flg_aum_dim := vi_flg_aum_dim;

            UPDATE ifrbde.cad_termo_aditivo_contrato
               SET dat_termo_aditivo = v_dat_termo_aditivo,
                   num_termo_aditivo = v_num_termo_aditivo,
                   dsc_objeto_termo = v_dsc_objeto_termo,
                   dat_publicacao = v_dat_publicacao,
                   num_dou_publicacao = v_num_dou_publicacao,
                   num_secao_publicacao = v_num_secao_publicacao,
                   num_pagina_publicacao = v_num_pagina_publicacao,
                   tip_termo_aditivo = v_tip_termo_aditivo,
                   num_prazo = v_num_prazo,
                   flg_aum_dim = v_flg_aum_dim
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_termo_aditivo_con (
                  p_usuario,
                  vo_num_seq_termo_aditivo,
                  vo_num_seq_contrato_origem,
                  vo_dat_termo_aditivo,
                  vo_num_termo_aditivo,
                  vo_dsc_objeto_termo,
                  vo_dat_publicacao,
                  vo_num_dou_publicacao,
                  vo_num_secao_publicacao,
                  vo_num_pagina_publicacao,
                  vo_tip_termo_aditivo,
                  vo_num_prazo,
                  vo_flg_aum_dim,
                  vi_num_seq_termo_aditivo,
                  vi_num_seq_contrato_origem
               );
               v_dado :=    'num_seq_termo_aditivo = '
                         || TO_CHAR (v_num_seq_termo_aditivo);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_contrato_origem = '
                         || TO_CHAR (v_num_seq_contrato_origem);
               v_dado :=    v_dado
                         || ','
                         || 'dat_termo_aditivo = '
                         || TO_CHAR (v_dat_termo_aditivo, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'num_termo_aditivo = '
                         || RTRIM (LTRIM (v_num_termo_aditivo));
               v_dado :=    v_dado
                         || ','
                         || 'dsc_objeto_termo = '
                         || RTRIM (LTRIM (v_dsc_objeto_termo));
               v_dado :=    v_dado
                         || ','
                         || 'dat_publicacao = '
                         || TO_CHAR (v_dat_publicacao, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'num_dou_publicacao = '
                         || RTRIM (LTRIM (v_num_dou_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'num_secao_publicacao = '
                         || RTRIM (LTRIM (v_num_secao_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'num_pagina_publicacao = '
                         || RTRIM (LTRIM (v_num_pagina_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'tip_termo_aditivo = '
                         || RTRIM (LTRIM (v_tip_termo_aditivo));
               v_dado :=
                          v_dado
                       || ','
                       || 'num_prazo = '
                       || TO_CHAR (v_num_prazo);
               v_dado :=
                      v_dado
                   || ','
                   || 'flg_aum_dim = '
                   || TO_CHAR (v_flg_aum_dim);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_TERMO_ADITIVO_CONTRATO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Histórico de T.A. de Valor
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_termo_aditiv (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_contrato_termo    OUT      tyt_num_seq_contrato_termo,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_contrato_termo    IN       t_num_seq_contrato_termo,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato_termo, num_seq_termo,
                num_seq_resumo_ta, cta_periodo,
                cta_num, num_versao_contrato_vta,
                cta_objeto, cta_valor, cta_deb_cred,
                dat_moeda_ta, val_moeda_ta,
                tip_cotacao_moeda
           INTO vo_num_seq_contrato_termo (1), vo_num_seq_termo (1),
                vo_num_seq_resumo_ta (1), vo_cta_periodo (1),
                vo_cta_num (1), vo_num_versao_contrato_vta (1),
                vo_cta_objeto (1), vo_cta_valor (1), vo_cta_deb_cred (1),
                vo_dat_moeda_ta (1), vo_val_moeda_ta (1),
                vo_tip_cotacao_moeda (1)
           FROM ifrbde.tab_cont_termo_aditivo
          WHERE num_seq_contrato_termo = vi_num_seq_contrato_termo
            AND num_seq_termo = vi_num_seq_termo
            AND num_seq_resumo_ta = vi_num_seq_resumo_ta;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Histórico de T.A. de Valor
   -- retorna o OK ou não
   PROCEDURE stp_exclui_cont_termo_aditivo (
      p_usuario                   IN       VARCHAR2,
      vo_ok                       OUT      tyt_ok,
      vi_num_seq_contrato_termo   IN       t_num_seq_contrato_termo,
      vi_num_seq_termo            IN       t_num_seq_termo,
      vi_num_seq_resumo_ta        IN       t_num_seq_resumo_ta
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_cont_termo_aditivo
              WHERE num_seq_contrato_termo = vi_num_seq_contrato_termo
                AND num_seq_termo = vi_num_seq_termo
                AND num_seq_resumo_ta = vi_num_seq_resumo_ta
         FOR UPDATE;

      v_tab_cont_termo_aditivo   ifrbde.tab_cont_termo_aditivo%ROWTYPE;
      v_dado                     VARCHAR2 (4000)                         := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'num_seq_contrato_termo = '
                  || TO_CHAR (
                        v_tab_cont_termo_aditivo.num_seq_contrato_termo
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_termo = '
                      || TO_CHAR (v_tab_cont_termo_aditivo.num_seq_termo);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_ta = '
                      || TO_CHAR (v_tab_cont_termo_aditivo.num_seq_resumo_ta);
            v_dado :=    v_dado
                      || ','
                      || 'cta_periodo = '
                      || TO_DATE (
                            v_tab_cont_termo_aditivo.cta_periodo,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'cta_num = '
                      || RTRIM (
                            LTRIM (UPPER (v_tab_cont_termo_aditivo.cta_num))
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_versao_contrato_vta = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_tab_cont_termo_aditivo.num_versao_contrato_vta
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'cta_objeto = '
                  || RTRIM (
                        LTRIM (UPPER (v_tab_cont_termo_aditivo.cta_objeto))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'cta_valor = '
                      || TO_CHAR (v_tab_cont_termo_aditivo.cta_valor);
            v_dado :=    v_dado
                      || ','
                      || 'cta_deb_cred = '
                      || TO_CHAR (v_tab_cont_termo_aditivo.cta_deb_cred);
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_ta = '
                      || TO_DATE (
                            v_tab_cont_termo_aditivo.dat_moeda_ta,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_moeda_ta = '
                      || TO_CHAR (v_tab_cont_termo_aditivo.val_moeda_ta);
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_cotacao_moeda = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_tab_cont_termo_aditivo.tip_cotacao_moeda)
                        )
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONT_TERMO_ADITIVO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.tab_cont_termo_aditivo
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Histórico de T.A. de Valor
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_termo_aditivo (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_contrato_termo    OUT      tyt_num_seq_contrato_termo,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_contrato_termo    IN       t_num_seq_contrato_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   )
   AS
      v_num_seq_contrato_termo   tab_cont_termo_aditivo.num_seq_contrato_termo%TYPE;
      v_num_seq_termo            tab_cont_termo_aditivo.num_seq_termo%TYPE;
      v_num_seq_resumo_ta        tab_cont_termo_aditivo.num_seq_resumo_ta%TYPE;
      v_cta_periodo              tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                  tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto               tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred             tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_dat_moeda_ta             tab_cont_termo_aditivo.dat_moeda_ta%TYPE;
      v_val_moeda_ta             tab_cont_termo_aditivo.val_moeda_ta%TYPE;
      v_tip_cotacao_moeda        tab_cont_termo_aditivo.tip_cotacao_moeda%TYPE;
      v_dado                     VARCHAR2 (4000)                            := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_termo
           FROM DUAL;

         v_cta_num := RTRIM (LTRIM (vi_cta_num));
         v_cta_objeto := RTRIM (LTRIM (vi_cta_objeto));
         v_tip_cotacao_moeda := RTRIM (LTRIM (vi_tip_cotacao_moeda));
         v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
         v_dat_moeda_ta := TO_DATE (vi_dat_moeda_ta, 'DD/MM/YYYY');
         v_num_seq_contrato_termo := vi_num_seq_contrato_termo;
         v_num_seq_resumo_ta := vi_num_seq_resumo_ta;
         v_cta_valor := vi_cta_valor;
         v_cta_deb_cred := vi_cta_deb_cred;
         v_val_moeda_ta := vi_val_moeda_ta;

         INSERT INTO ifrbde.tab_cont_termo_aditivo
                     (num_seq_contrato_termo, num_seq_termo,
                      num_seq_resumo_ta, cta_periodo, cta_num,
                      cta_objeto, cta_valor, cta_deb_cred,
                      dat_moeda_ta, val_moeda_ta, tip_cotacao_moeda)
              VALUES (v_num_seq_contrato_termo, v_num_seq_termo,
                      v_num_seq_resumo_ta, v_cta_periodo, v_cta_num,
                      v_cta_objeto, v_cta_valor, v_cta_deb_cred,
                      v_dat_moeda_ta, v_val_moeda_ta, v_tip_cotacao_moeda);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_cont_termo_aditiv (
               p_usuario,
               vo_num_seq_contrato_termo,
               vo_num_seq_termo,
               vo_num_seq_resumo_ta,
               vo_cta_periodo,
               vo_cta_num,
               vo_num_versao_contrato_vta,
               vo_cta_objeto,
               vo_cta_valor,
               vo_cta_deb_cred,
               vo_dat_moeda_ta,
               vo_val_moeda_ta,
               vo_tip_cotacao_moeda,
               v_num_seq_contrato_termo,
               v_num_seq_termo,
               v_num_seq_resumo_ta
            );
            v_dado :=    'num_seq_contrato_termo = '
                      || TO_CHAR (v_num_seq_contrato_termo);
            v_dado :=
                  v_dado
               || ','
               || 'num_seq_termo = '
               || TO_CHAR (v_num_seq_termo);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_ta = '
                      || TO_CHAR (v_num_seq_resumo_ta);
            v_dado :=    v_dado
                      || ','
                      || 'cta_periodo = '
                      || TO_CHAR (v_cta_periodo, 'DD/MM/YYYY');
            v_dado :=
                        v_dado
                     || ','
                     || 'cta_num = '
                     || RTRIM (LTRIM (v_cta_num));
            v_dado :=
                  v_dado
               || ','
               || 'cta_objeto = '
               || RTRIM (LTRIM (v_cta_objeto));
            v_dado :=    v_dado
                      || ','
                      || 'cta_valor = '
                      || TO_CHAR (v_cta_valor);
            v_dado :=
                    v_dado
                 || ','
                 || 'cta_deb_cred = '
                 || TO_CHAR (v_cta_deb_cred);
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_ta = '
                      || TO_CHAR (v_dat_moeda_ta, 'DD/MM/YYYY');
            v_dado :=
                    v_dado
                 || ','
                 || 'val_moeda_ta = '
                 || TO_CHAR (v_val_moeda_ta);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cotacao_moeda = '
                      || RTRIM (LTRIM (v_tip_cotacao_moeda));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_TERMO_ADITIVO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Histórico de T.A. de Valor
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_termo_aditivo (
      p_usuario                    IN       VARCHAR2,
      vo_num_seq_contrato_termo    OUT      tyt_num_seq_contrato_termo,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_contrato_termo    IN       t_num_seq_contrato_termo,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_cont_termo_aditivo
              WHERE num_seq_contrato_termo = vi_num_seq_contrato_termo
                AND num_seq_termo = vi_num_seq_termo
                AND num_seq_resumo_ta = vi_num_seq_resumo_ta
         FOR UPDATE;

      v_tab_cont_termo_aditivo   ifrbde.tab_cont_termo_aditivo%ROWTYPE;
      v_num_seq_contrato_termo   ifrbde.tab_cont_termo_aditivo.num_seq_contrato_termo%TYPE;
      v_num_seq_termo            ifrbde.tab_cont_termo_aditivo.num_seq_termo%TYPE;
      v_num_seq_resumo_ta        ifrbde.tab_cont_termo_aditivo.num_seq_resumo_ta%TYPE;
      v_cta_periodo              ifrbde.tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                  ifrbde.tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto               ifrbde.tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                ifrbde.tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred             ifrbde.tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_dat_moeda_ta             ifrbde.tab_cont_termo_aditivo.dat_moeda_ta%TYPE;
      v_val_moeda_ta             ifrbde.tab_cont_termo_aditivo.val_moeda_ta%TYPE;
      v_tip_cotacao_moeda        ifrbde.tab_cont_termo_aditivo.tip_cotacao_moeda%TYPE;
      v_dado                     VARCHAR2 (4000)                            := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cta_num := RTRIM (LTRIM (vi_cta_num));
            v_cta_objeto := RTRIM (LTRIM (vi_cta_objeto));
            v_tip_cotacao_moeda := RTRIM (LTRIM (vi_tip_cotacao_moeda));
            v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
            v_dat_moeda_ta := TO_DATE (vi_dat_moeda_ta, 'DD/MM/YYYY');
            v_num_seq_contrato_termo := vi_num_seq_contrato_termo;
            v_num_seq_termo := vi_num_seq_termo;
            v_num_seq_resumo_ta := vi_num_seq_resumo_ta;
            v_cta_valor := vi_cta_valor;
            v_cta_deb_cred := vi_cta_deb_cred;
            v_val_moeda_ta := vi_val_moeda_ta;

            UPDATE ifrbde.tab_cont_termo_aditivo
               SET cta_periodo = v_cta_periodo,
                   cta_num = v_cta_num,
                   cta_objeto = v_cta_objeto,
                   cta_valor = v_cta_valor,
                   cta_deb_cred = v_cta_deb_cred,
                   dat_moeda_ta = v_dat_moeda_ta,
                   val_moeda_ta = v_val_moeda_ta,
                   tip_cotacao_moeda = v_tip_cotacao_moeda
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_cont_termo_aditiv (
                  p_usuario,
                  vo_num_seq_contrato_termo,
                  vo_num_seq_termo,
                  vo_num_seq_resumo_ta,
                  vo_cta_periodo,
                  vo_cta_num,
                  vo_num_versao_contrato_vta,
                  vo_cta_objeto,
                  vo_cta_valor,
                  vo_cta_deb_cred,
                  vo_dat_moeda_ta,
                  vo_val_moeda_ta,
                  vo_tip_cotacao_moeda,
                  vi_num_seq_contrato_termo,
                  vi_num_seq_termo,
                  vi_num_seq_resumo_ta
               );
               v_dado :=    'num_seq_contrato_termo = '
                         || TO_CHAR (v_num_seq_contrato_termo);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_termo = '
                         || TO_CHAR (v_num_seq_termo);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_resumo_ta = '
                         || TO_CHAR (v_num_seq_resumo_ta);
               v_dado :=    v_dado
                         || ','
                         || 'cta_periodo = '
                         || TO_CHAR (v_cta_periodo, 'DD/MM/YYYY');
               v_dado :=
                        v_dado
                     || ','
                     || 'cta_num = '
                     || RTRIM (LTRIM (v_cta_num));
               v_dado :=    v_dado
                         || ','
                         || 'cta_objeto = '
                         || RTRIM (LTRIM (v_cta_objeto));
               v_dado :=
                          v_dado
                       || ','
                       || 'cta_valor = '
                       || TO_CHAR (v_cta_valor);
               v_dado :=    v_dado
                         || ','
                         || 'cta_deb_cred = '
                         || TO_CHAR (v_cta_deb_cred);
               v_dado :=    v_dado
                         || ','
                         || 'dat_moeda_ta = '
                         || TO_CHAR (v_dat_moeda_ta, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'val_moeda_ta = '
                         || TO_CHAR (v_val_moeda_ta);
               v_dado :=    v_dado
                         || ','
                         || 'tip_cotacao_moeda = '
                         || RTRIM (LTRIM (v_tip_cotacao_moeda));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONT_TERMO_ADITIVO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Valores de Indices e Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice_fil (
      p_usuario             IN       VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_indice, ici_ice_cod,
                ici_periodo, ici_valor_diario
           INTO vo_num_seq_indice (1), vo_ici_ice_cod (1),
                vo_ici_periodo (1), vo_ici_valor_diario (1)
           FROM ifrbde.tab_indice_fil
          WHERE num_seq_indice = vi_num_seq_indice;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Valores de Indices e Moedas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_indice_fil (
      p_usuario           IN       VARCHAR2,
      vo_ok               OUT      tyt_ok,
      vi_num_seq_indice   IN       t_num_seq_indice
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_indice_fil
              WHERE num_seq_indice = vi_num_seq_indice
         FOR UPDATE;

      v_tab_indice_fil   ifrbde.tab_indice_fil%ROWTYPE;
      v_dado             VARCHAR2 (4000)                 := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_indice_fil;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'num_seq_indice = '
                      || TO_CHAR (v_tab_indice_fil.num_seq_indice);
            v_dado :=    v_dado
                      || ','
                      || 'ici_ice_cod = '
                      || RTRIM (LTRIM (UPPER (v_tab_indice_fil.ici_ice_cod)));
            v_dado :=    v_dado
                      || ','
                      || 'ici_periodo = '
                      || TO_DATE (v_tab_indice_fil.ici_periodo, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'ici_valor_diario = '
                      || TO_CHAR (v_tab_indice_fil.ici_valor_diario);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_INDICE_FIL',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.tab_indice_fil
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Valores de Indices e Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice_fil (
      p_usuario             IN       VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   )
   AS
      v_num_seq_indice     tab_indice_fil.num_seq_indice%TYPE;
      v_ici_ice_cod        tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo        tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario   tab_indice_fil.ici_valor_diario%TYPE;
      v_dado               VARCHAR2 (4000)                        := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_indice.NEXTVAL
           INTO v_num_seq_indice
           FROM DUAL;

         v_ici_ice_cod := RTRIM (LTRIM (vi_ici_ice_cod));
         v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
         v_ici_valor_diario := vi_ici_valor_diario;

         INSERT INTO ifrbde.tab_indice_fil
                     (num_seq_indice, ici_ice_cod, ici_periodo,
                      ici_valor_diario)
              VALUES (v_num_seq_indice, v_ici_ice_cod, v_ici_periodo,
                      v_ici_valor_diario);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_indice_fil (
               p_usuario,
               vo_num_seq_indice,
               vo_ici_ice_cod,
               vo_ici_periodo,
               vo_ici_valor_diario,
               v_num_seq_indice
            );
            v_dado :=    'num_seq_indice = '
                      || TO_CHAR (v_num_seq_indice);
            v_dado :=    v_dado
                      || ','
                      || 'ici_ice_cod = '
                      || RTRIM (LTRIM (v_ici_ice_cod));
            v_dado :=    v_dado
                      || ','
                      || 'ici_periodo = '
                      || TO_CHAR (v_ici_periodo, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'ici_valor_diario = '
                      || TO_CHAR (v_ici_valor_diario);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'TAB_INDICE_FIL',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Valores de Indices e Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_indice_fil (
      p_usuario             IN       VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_indice_fil
              WHERE num_seq_indice = vi_num_seq_indice
         FOR UPDATE;

      v_tab_indice_fil     ifrbde.tab_indice_fil%ROWTYPE;
      v_num_seq_indice     ifrbde.tab_indice_fil.num_seq_indice%TYPE;
      v_ici_ice_cod        ifrbde.tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo        ifrbde.tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario   ifrbde.tab_indice_fil.ici_valor_diario%TYPE;
      v_dado               VARCHAR2 (4000)                               := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_indice_fil;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_ici_ice_cod := RTRIM (LTRIM (vi_ici_ice_cod));
            v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
            v_num_seq_indice := vi_num_seq_indice;
            v_ici_valor_diario := vi_ici_valor_diario;

            UPDATE ifrbde.tab_indice_fil
               SET ici_ice_cod = v_ici_ice_cod,
                   ici_periodo = v_ici_periodo,
                   ici_valor_diario = v_ici_valor_diario
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_indice_fil (
                  p_usuario,
                  vo_num_seq_indice,
                  vo_ici_ice_cod,
                  vo_ici_periodo,
                  vo_ici_valor_diario,
                  vi_num_seq_indice
               );
               v_dado :=    'num_seq_indice = '
                         || TO_CHAR (v_num_seq_indice);
               v_dado :=    v_dado
                         || ','
                         || 'ici_ice_cod = '
                         || RTRIM (LTRIM (v_ici_ice_cod));
               v_dado :=    v_dado
                         || ','
                         || 'ici_periodo = '
                         || TO_CHAR (v_ici_periodo, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'ici_valor_diario = '
                         || TO_CHAR (v_ici_valor_diario);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_INDICE_FIL',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_contrato (
      p_usuario                     IN       VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_cod_subtipo_contrato       OUT      tyt_cod_subtipo_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_tip_regularidade_fiscal    OUT      tyt_tip_regularidade_fiscal,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_seq_licitante_ganhadora    OUT      tyt_seq_licitante_ganhadora,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato, cnt_cre_cod, cnt_cod,
                num_versao_contrato, cod_subtipo_contrato,
                num_termo_aditivo, cod_dep_contrato,
                cnt_justificativa_cre, num_seq_gestor,
                num_seq_assinatura_1, num_seq_assinatura_2,
                num_ato_administrativo, cnt_cei,
                cnt_crea, cnt_data, cnt_data_proposta,
                cnt_data_inicio, cnt_prazo_exec,
                num_prazo_exec_meses, cnt_prazo_adit,
                dat_termino_contrato, dat_publicacao,
                num_dou_publicacao, num_pagina_publicacao,
                num_secao_publicacao,
                cod_modalidade_licitacao, num_inciso,
                dsc_fundamento_legal, num_licitacao,
                num_ano_licitacao, num_processo,
                tip_regularidade_fiscal,
                cnt_valor_compromisso, cnt_valor_termo,
                cnt_valor_pago, cnt_valor_reaj,
                cnt_valor_reaj_pago, cnt_valor,
                seq_licitante_ganhadora,
                tip_situacao_contrato, tip_contrato,
                dsc_critica_contrato
           INTO vo_num_seq_contrato (1), vo_cnt_cre_cod (1), vo_cnt_cod (1),
                vo_num_versao_contrato (1), vo_cod_subtipo_contrato (1),
                vo_num_termo_aditivo (1), vo_cod_dep_contrato (1),
                vo_cnt_justificativa_cre (1), vo_num_seq_gestor (1),
                vo_num_seq_assinatura_1 (1), vo_num_seq_assinatura_2 (1),
                vo_num_ato_administrativo (1), vo_cnt_cei (1),
                vo_cnt_crea (1), vo_cnt_data (1), vo_cnt_data_proposta (1),
                vo_cnt_data_inicio (1), vo_cnt_prazo_exec (1),
                vo_num_prazo_exec_meses (1), vo_cnt_prazo_adit (1),
                vo_dat_termino_contrato (1), vo_dat_publicacao (1),
                vo_num_dou_publicacao (1), vo_num_pagina_publicacao (1),
                vo_num_secao_publicacao (1),
                vo_cod_modalidade_licitacao (1), vo_num_inciso (1),
                vo_dsc_fundamento_legal (1), vo_num_licitacao (1),
                vo_num_ano_licitacao (1), vo_num_processo (1),
                vo_tip_regularidade_fiscal (1),
                vo_cnt_valor_compromisso (1), vo_cnt_valor_termo (1),
                vo_cnt_valor_pago (1), vo_cnt_valor_reaj (1),
                vo_cnt_valor_reaj_pago (1), vo_cnt_valor (1),
                vo_seq_licitante_ganhadora (1),
                vo_tip_situacao_contrato (1), vo_tip_contrato (1),
                vo_dsc_critica_contrato (1)
           FROM ifrbde.viw_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato
            AND cnt_cre_cod = vi_cnt_cre_cod;

         ifrbde.prc_gravar_usuario_contrato (vi_num_seq_contrato, 'C');
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Contratos
   -- retorna o OK ou não
   PROCEDURE stp_exclui_contrato (
      p_usuario             IN       VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_contrato   IN       t_num_seq_contrato,
      vi_cnt_cre_cod        IN       t_cnt_cre_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_contrato   ifrbde.viw_contrato%ROWTYPE;
      v_dado           VARCHAR2 (4000)               := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CONTRATO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'num_seq_contrato = '
                      || TO_CHAR (v_viw_contrato.num_seq_contrato);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cre_cod = '
                      || TO_CHAR (v_viw_contrato.cnt_cre_cod);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cod = '
                      || RTRIM (LTRIM (UPPER (v_viw_contrato.cnt_cod)));
            v_dado :=    v_dado
                      || ','
                      || 'num_versao_contrato = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_viw_contrato.num_versao_contrato)
                            )
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'cod_subtipo_contrato = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.cod_subtipo_contrato))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_termo_aditivo = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_contrato.num_termo_aditivo))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'cod_dep_contrato = '
                      || TO_CHAR (v_viw_contrato.cod_dep_contrato);
            v_dado :=
                     v_dado
                  || ','
                  || 'cnt_justificativa_cre = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.cnt_justificativa_cre))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_gestor = '
                      || TO_CHAR (v_viw_contrato.num_seq_gestor);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_assinatura_1 = '
                      || TO_CHAR (v_viw_contrato.num_seq_assinatura_1);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_assinatura_2 = '
                      || TO_CHAR (v_viw_contrato.num_seq_assinatura_2);
            v_dado :=
                     v_dado
                  || ','
                  || 'num_ato_administrativo = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.num_ato_administrativo))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cei = '
                      || RTRIM (LTRIM (UPPER (v_viw_contrato.cnt_cei)));
            v_dado :=    v_dado
                      || ','
                      || 'cnt_crea = '
                      || RTRIM (LTRIM (UPPER (v_viw_contrato.cnt_crea)));
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data = '
                      || TO_DATE (v_viw_contrato.cnt_data, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data_proposta = '
                      || TO_DATE (
                            v_viw_contrato.cnt_data_proposta,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data_inicio = '
                      || TO_DATE (
                            v_viw_contrato.cnt_data_inicio,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'cnt_prazo_exec = '
                      || TO_CHAR (v_viw_contrato.cnt_prazo_exec);
            v_dado :=    v_dado
                      || ','
                      || 'num_prazo_exec_meses = '
                      || TO_CHAR (v_viw_contrato.num_prazo_exec_meses);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_prazo_adit = '
                      || TO_CHAR (v_viw_contrato.cnt_prazo_adit);
            v_dado :=    v_dado
                      || ','
                      || 'dat_termino_contrato = '
                      || TO_DATE (
                            v_viw_contrato.dat_termino_contrato,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dat_publicacao = '
                      || TO_DATE (v_viw_contrato.dat_publicacao, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'num_dou_publicacao = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_contrato.num_dou_publicacao))
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_pagina_publicacao = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.num_pagina_publicacao))
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_secao_publicacao = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.num_secao_publicacao))
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'cod_modalidade_licitacao = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_contrato.cod_modalidade_licitacao)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_inciso = '
                      || TO_CHAR (v_viw_contrato.num_inciso);
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_fundamento_legal = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.dsc_fundamento_legal))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'num_licitacao = '
                      || TO_CHAR (v_viw_contrato.num_licitacao);
            v_dado :=    v_dado
                      || ','
                      || 'num_ano_licitacao = '
                      || TO_CHAR (v_viw_contrato.num_ano_licitacao);
            v_dado :=    v_dado
                      || ','
                      || 'num_processo = '
                      || RTRIM (LTRIM (UPPER (v_viw_contrato.num_processo)));
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_regularidade_fiscal = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_contrato.tip_regularidade_fiscal)
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor_compromisso = '
                      || TO_CHAR (v_viw_contrato.cnt_valor_compromisso);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor_termo = '
                      || TO_CHAR (v_viw_contrato.cnt_valor_termo);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor_pago = '
                      || TO_CHAR (v_viw_contrato.cnt_valor_pago);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor_reaj = '
                      || TO_CHAR (v_viw_contrato.cnt_valor_reaj);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor_reaj_pago = '
                      || TO_CHAR (v_viw_contrato.cnt_valor_reaj_pago);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_valor = '
                      || TO_CHAR (v_viw_contrato.cnt_valor);
            v_dado :=    v_dado
                      || ','
                      || 'seq_licitante_ganhadora = '
                      || TO_CHAR (v_viw_contrato.seq_licitante_ganhadora);
            v_dado :=    v_dado
                      || ','
                      || 'tip_situacao_contrato = '
                      || TO_CHAR (v_viw_contrato.tip_situacao_contrato);
            v_dado :=    v_dado
                      || ','
                      || 'tip_contrato = '
                      || TO_CHAR (v_viw_contrato.tip_contrato);
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_critica_contrato = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_contrato.dsc_critica_contrato))
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_CONTRATO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.viw_contrato
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
                  raise_application_error (
                     -20100,
                     'Mais de um registro solicitado para exclusão. Operação não realizada!!!'
                  );
               END IF;
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para exclusão!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para exclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_contrato (
      p_usuario                     IN       VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_cod_subtipo_contrato       OUT      tyt_cod_subtipo_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_tip_regularidade_fiscal    OUT      tyt_tip_regularidade_fiscal,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_seq_licitante_ganhadora    OUT      tyt_seq_licitante_ganhadora,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_subtipo_contrato       IN       t_cod_subtipo_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_cnt_prazo_adit             IN       t_cnt_prazo_adit,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_regularidade_fiscal    IN       t_tip_regularidade_fiscal,
      vi_seq_licitante_ganhadora    IN       t_seq_licitante_ganhadora,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   )
   AS
      v_num_seq_contrato           viw_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                viw_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                    viw_contrato.cnt_cod%TYPE;
      v_num_versao_contrato        viw_contrato.num_versao_contrato%TYPE;
      v_cod_subtipo_contrato       viw_contrato.cod_subtipo_contrato%TYPE;
      v_cod_dep_contrato           viw_contrato.cod_dep_contrato%TYPE;
      v_cnt_justificativa_cre      viw_contrato.cnt_justificativa_cre%TYPE;
      v_num_seq_gestor             viw_contrato.num_seq_gestor%TYPE;
      v_num_seq_assinatura_1       viw_contrato.num_seq_assinatura_1%TYPE;
      v_num_seq_assinatura_2       viw_contrato.num_seq_assinatura_2%TYPE;
      v_num_ato_administrativo     viw_contrato.num_ato_administrativo%TYPE;
      v_cnt_cei                    viw_contrato.cnt_cei%TYPE;
      v_cnt_crea                   viw_contrato.cnt_crea%TYPE;
      v_cnt_data                   viw_contrato.cnt_data%TYPE;
      v_cnt_data_proposta          viw_contrato.cnt_data_proposta%TYPE;
      v_cnt_data_inicio            viw_contrato.cnt_data_inicio%TYPE;
      v_cnt_prazo_exec             viw_contrato.cnt_prazo_exec%TYPE;
      v_num_prazo_exec_meses       viw_contrato.num_prazo_exec_meses%TYPE;
      v_cnt_prazo_adit             viw_contrato.cnt_prazo_adit%TYPE;
      v_dat_publicacao             viw_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao         viw_contrato.num_dou_publicacao%TYPE;
      v_num_pagina_publicacao      viw_contrato.num_pagina_publicacao%TYPE;
      v_num_secao_publicacao       viw_contrato.num_secao_publicacao%TYPE;
      v_cod_modalidade_licitacao   viw_contrato.cod_modalidade_licitacao%TYPE;
      v_num_inciso                 viw_contrato.num_inciso%TYPE;
      v_dsc_fundamento_legal       viw_contrato.dsc_fundamento_legal%TYPE;
      v_num_licitacao              viw_contrato.num_licitacao%TYPE;
      v_num_ano_licitacao          viw_contrato.num_ano_licitacao%TYPE;
      v_num_processo               viw_contrato.num_processo%TYPE;
      v_tip_regularidade_fiscal    viw_contrato.tip_regularidade_fiscal%TYPE;
      v_seq_licitante_ganhadora    viw_contrato.seq_licitante_ganhadora%TYPE;
      v_tip_situacao_contrato      viw_contrato.tip_situacao_contrato%TYPE;
      v_dado                       VARCHAR2 (4000)                          := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CONTRATO',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_contrato
           FROM DUAL;

         v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
         v_num_versao_contrato := RTRIM (LTRIM (vi_num_versao_contrato));
         v_cod_subtipo_contrato := RTRIM (LTRIM (vi_cod_subtipo_contrato));
         v_cnt_justificativa_cre := RTRIM (LTRIM (vi_cnt_justificativa_cre));
         v_num_ato_administrativo :=
                                    RTRIM (LTRIM (vi_num_ato_administrativo));
         v_cnt_cei := RTRIM (LTRIM (vi_cnt_cei));
         v_cnt_crea := RTRIM (LTRIM (vi_cnt_crea));
         v_num_dou_publicacao := RTRIM (LTRIM (vi_num_dou_publicacao));
         v_num_pagina_publicacao := RTRIM (LTRIM (vi_num_pagina_publicacao));
         v_num_secao_publicacao := RTRIM (LTRIM (vi_num_secao_publicacao));
         v_cod_modalidade_licitacao :=
                                  RTRIM (LTRIM (vi_cod_modalidade_licitacao));
         v_dsc_fundamento_legal := RTRIM (LTRIM (vi_dsc_fundamento_legal));
         v_num_processo := RTRIM (LTRIM (vi_num_processo));
         v_tip_regularidade_fiscal :=
                                   RTRIM (LTRIM (vi_tip_regularidade_fiscal));
         v_cnt_data := TO_DATE (vi_cnt_data, 'DD/MM/YYYY');
         v_cnt_data_proposta := TO_DATE (vi_cnt_data_proposta, 'DD/MM/YYYY');
         v_cnt_data_inicio := TO_DATE (vi_cnt_data_inicio, 'DD/MM/YYYY');
         v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_cod_dep_contrato := vi_cod_dep_contrato;
         v_num_seq_gestor := vi_num_seq_gestor;
         v_num_seq_assinatura_1 := vi_num_seq_assinatura_1;
         v_num_seq_assinatura_2 := vi_num_seq_assinatura_2;
         v_cnt_prazo_exec := vi_cnt_prazo_exec;
         v_num_prazo_exec_meses := vi_num_prazo_exec_meses;
         v_cnt_prazo_adit := vi_cnt_prazo_adit;
         v_num_inciso := vi_num_inciso;
         v_num_licitacao := vi_num_licitacao;
         v_num_ano_licitacao := vi_num_ano_licitacao;
         v_seq_licitante_ganhadora := vi_seq_licitante_ganhadora;
         v_tip_situacao_contrato := vi_tip_situacao_contrato;

         INSERT INTO ifrbde.viw_contrato
                     (num_seq_contrato, cnt_cre_cod, cnt_cod,
                      num_versao_contrato, cod_subtipo_contrato,
                      cod_dep_contrato, cnt_justificativa_cre,
                      num_seq_gestor, num_seq_assinatura_1,
                      num_seq_assinatura_2, num_ato_administrativo,
                      cnt_cei, cnt_crea, cnt_data, cnt_data_proposta,
                      cnt_data_inicio, cnt_prazo_exec,
                      num_prazo_exec_meses, cnt_prazo_adit,
                      dat_publicacao, num_dou_publicacao,
                      num_pagina_publicacao, num_secao_publicacao,
                      cod_modalidade_licitacao, num_inciso,
                      dsc_fundamento_legal, num_licitacao,
                      num_ano_licitacao, num_processo,
                      tip_regularidade_fiscal, seq_licitante_ganhadora,
                      tip_situacao_contrato)
              VALUES (v_num_seq_contrato, v_cnt_cre_cod, v_cnt_cod,
                      v_num_versao_contrato, v_cod_subtipo_contrato,
                      v_cod_dep_contrato, v_cnt_justificativa_cre,
                      v_num_seq_gestor, v_num_seq_assinatura_1,
                      v_num_seq_assinatura_2, v_num_ato_administrativo,
                      v_cnt_cei, v_cnt_crea, v_cnt_data, v_cnt_data_proposta,
                      v_cnt_data_inicio, v_cnt_prazo_exec,
                      v_num_prazo_exec_meses, v_cnt_prazo_adit,
                      v_dat_publicacao, v_num_dou_publicacao,
                      v_num_pagina_publicacao, v_num_secao_publicacao,
                      v_cod_modalidade_licitacao, v_num_inciso,
                      v_dsc_fundamento_legal, v_num_licitacao,
                      v_num_ano_licitacao, v_num_processo,
                      v_tip_regularidade_fiscal, v_seq_licitante_ganhadora,
                      v_tip_situacao_contrato);

         IF SQL%ROWCOUNT = 1
         THEN
            BEGIN
               ifrbde.prc_critica_contrato (v_num_seq_contrato);
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao executar a rotina de critica '
                     || SQLERRM
                  );
            END;

            stp_pesquisa_contrato (
               p_usuario,
               vo_num_seq_contrato,
               vo_cnt_cre_cod,
               vo_cnt_cod,
               vo_num_versao_contrato,
               vo_cod_subtipo_contrato,
               vo_num_termo_aditivo,
               vo_cod_dep_contrato,
               vo_cnt_justificativa_cre,
               vo_num_seq_gestor,
               vo_num_seq_assinatura_1,
               vo_num_seq_assinatura_2,
               vo_num_ato_administrativo,
               vo_cnt_cei,
               vo_cnt_crea,
               vo_cnt_data,
               vo_cnt_data_proposta,
               vo_cnt_data_inicio,
               vo_cnt_prazo_exec,
               vo_num_prazo_exec_meses,
               vo_cnt_prazo_adit,
               vo_dat_termino_contrato,
               vo_dat_publicacao,
               vo_num_dou_publicacao,
               vo_num_pagina_publicacao,
               vo_num_secao_publicacao,
               vo_cod_modalidade_licitacao,
               vo_num_inciso,
               vo_dsc_fundamento_legal,
               vo_num_licitacao,
               vo_num_ano_licitacao,
               vo_num_processo,
               vo_tip_regularidade_fiscal,
               vo_cnt_valor_compromisso,
               vo_cnt_valor_termo,
               vo_cnt_valor_pago,
               vo_cnt_valor_reaj,
               vo_cnt_valor_reaj_pago,
               vo_cnt_valor,
               vo_seq_licitante_ganhadora,
               vo_tip_situacao_contrato,
               vo_tip_contrato,
               vo_dsc_critica_contrato,
               v_num_seq_contrato,
               v_cnt_cre_cod
            );
            v_dado :=    'num_seq_contrato = '
                      || TO_CHAR (v_num_seq_contrato);
            v_dado :=
                       v_dado
                    || ','
                    || 'cnt_cre_cod = '
                    || TO_CHAR (v_cnt_cre_cod);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cod = '
                      || RTRIM (LTRIM (v_cnt_cod));
            v_dado :=    v_dado
                      || ','
                      || 'num_versao_contrato = '
                      || RTRIM (LTRIM (v_num_versao_contrato));
            v_dado :=    v_dado
                      || ','
                      || 'cod_subtipo_contrato = '
                      || RTRIM (LTRIM (v_cod_subtipo_contrato));
            v_dado :=    v_dado
                      || ','
                      || 'cod_dep_contrato = '
                      || TO_CHAR (v_cod_dep_contrato);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_justificativa_cre = '
                      || RTRIM (LTRIM (v_cnt_justificativa_cre));
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_gestor = '
                      || TO_CHAR (v_num_seq_gestor);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_assinatura_1 = '
                      || TO_CHAR (v_num_seq_assinatura_1);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_assinatura_2 = '
                      || TO_CHAR (v_num_seq_assinatura_2);
            v_dado :=    v_dado
                      || ','
                      || 'num_ato_administrativo = '
                      || RTRIM (LTRIM (v_num_ato_administrativo));
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cei = '
                      || RTRIM (LTRIM (v_cnt_cei));
            v_dado :=
                       v_dado
                    || ','
                    || 'cnt_crea = '
                    || RTRIM (LTRIM (v_cnt_crea));
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data = '
                      || TO_CHAR (v_cnt_data, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data_proposta = '
                      || TO_CHAR (v_cnt_data_proposta, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'cnt_data_inicio = '
                      || TO_CHAR (v_cnt_data_inicio, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'cnt_prazo_exec = '
                      || TO_CHAR (v_cnt_prazo_exec);
            v_dado :=    v_dado
                      || ','
                      || 'num_prazo_exec_meses = '
                      || TO_CHAR (v_num_prazo_exec_meses);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_prazo_adit = '
                      || TO_CHAR (v_cnt_prazo_adit);
            v_dado :=    v_dado
                      || ','
                      || 'dat_publicacao = '
                      || TO_CHAR (v_dat_publicacao, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'num_dou_publicacao = '
                      || RTRIM (LTRIM (v_num_dou_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'num_pagina_publicacao = '
                      || RTRIM (LTRIM (v_num_pagina_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'num_secao_publicacao = '
                      || RTRIM (LTRIM (v_num_secao_publicacao));
            v_dado :=    v_dado
                      || ','
                      || 'cod_modalidade_licitacao = '
                      || RTRIM (LTRIM (v_cod_modalidade_licitacao));
            v_dado :=    v_dado
                      || ','
                      || 'num_inciso = '
                      || TO_CHAR (v_num_inciso);
            v_dado :=    v_dado
                      || ','
                      || 'dsc_fundamento_legal = '
                      || RTRIM (LTRIM (v_dsc_fundamento_legal));
            v_dado :=
                   v_dado
                || ','
                || 'num_licitacao = '
                || TO_CHAR (v_num_licitacao);
            v_dado :=    v_dado
                      || ','
                      || 'num_ano_licitacao = '
                      || TO_CHAR (v_num_ano_licitacao);
            v_dado :=    v_dado
                      || ','
                      || 'num_processo = '
                      || RTRIM (LTRIM (v_num_processo));
            v_dado :=    v_dado
                      || ','
                      || 'tip_regularidade_fiscal = '
                      || RTRIM (LTRIM (v_tip_regularidade_fiscal));
            v_dado :=    v_dado
                      || ','
                      || 'seq_licitante_ganhadora = '
                      || TO_CHAR (v_seq_licitante_ganhadora);
            v_dado :=    v_dado
                      || ','
                      || 'tip_situacao_contrato = '
                      || TO_CHAR (v_tip_situacao_contrato);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_CONTRATO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error (
               -20100,
               'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para inclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         raise_application_error (
            -20100,
               'Número do contrato já existe'
            || vi_cnt_cre_cod
            || ' - '
            || SQLERRM
         );
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_contrato (
      p_usuario                     IN       VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_cod_subtipo_contrato       OUT      tyt_cod_subtipo_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_tip_regularidade_fiscal    OUT      tyt_tip_regularidade_fiscal,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_seq_licitante_ganhadora    OUT      tyt_seq_licitante_ganhadora,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_subtipo_contrato       IN       t_cod_subtipo_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_cnt_prazo_adit             IN       t_cnt_prazo_adit,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_regularidade_fiscal    IN       t_tip_regularidade_fiscal,
      vi_seq_licitante_ganhadora    IN       t_seq_licitante_ganhadora,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_contrato               ifrbde.viw_contrato%ROWTYPE;
      v_num_seq_contrato           ifrbde.viw_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                ifrbde.viw_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                    ifrbde.viw_contrato.cnt_cod%TYPE;
      v_num_versao_contrato        ifrbde.viw_contrato.num_versao_contrato%TYPE;
      v_cod_subtipo_contrato       ifrbde.viw_contrato.cod_subtipo_contrato%TYPE;
      v_cod_dep_contrato           ifrbde.viw_contrato.cod_dep_contrato%TYPE;
      v_cnt_justificativa_cre      ifrbde.viw_contrato.cnt_justificativa_cre%TYPE;
      v_num_seq_gestor             ifrbde.viw_contrato.num_seq_gestor%TYPE;
      v_num_seq_assinatura_1       ifrbde.viw_contrato.num_seq_assinatura_1%TYPE;
      v_num_seq_assinatura_2       ifrbde.viw_contrato.num_seq_assinatura_2%TYPE;
      v_num_ato_administrativo     ifrbde.viw_contrato.num_ato_administrativo%TYPE;
      v_cnt_cei                    ifrbde.viw_contrato.cnt_cei%TYPE;
      v_cnt_crea                   ifrbde.viw_contrato.cnt_crea%TYPE;
      v_cnt_data                   ifrbde.viw_contrato.cnt_data%TYPE;
      v_cnt_data_proposta          ifrbde.viw_contrato.cnt_data_proposta%TYPE;
      v_cnt_data_inicio            ifrbde.viw_contrato.cnt_data_inicio%TYPE;
      v_cnt_prazo_exec             ifrbde.viw_contrato.cnt_prazo_exec%TYPE;
      v_num_prazo_exec_meses       ifrbde.viw_contrato.num_prazo_exec_meses%TYPE;
      v_cnt_prazo_adit             ifrbde.viw_contrato.cnt_prazo_adit%TYPE;
      v_dat_publicacao             ifrbde.viw_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao         ifrbde.viw_contrato.num_dou_publicacao%TYPE;
      v_num_pagina_publicacao      ifrbde.viw_contrato.num_pagina_publicacao%TYPE;
      v_num_secao_publicacao       ifrbde.viw_contrato.num_secao_publicacao%TYPE;
      v_cod_modalidade_licitacao   ifrbde.viw_contrato.cod_modalidade_licitacao%TYPE;
      v_num_inciso                 ifrbde.viw_contrato.num_inciso%TYPE;
      v_dsc_fundamento_legal       ifrbde.viw_contrato.dsc_fundamento_legal%TYPE;
      v_num_licitacao              ifrbde.viw_contrato.num_licitacao%TYPE;
      v_num_ano_licitacao          ifrbde.viw_contrato.num_ano_licitacao%TYPE;
      v_num_processo               ifrbde.viw_contrato.num_processo%TYPE;
      v_tip_regularidade_fiscal    ifrbde.viw_contrato.tip_regularidade_fiscal%TYPE;
      v_seq_licitante_ganhadora    ifrbde.viw_contrato.seq_licitante_ganhadora%TYPE;
      v_tip_situacao_contrato      ifrbde.viw_contrato.tip_situacao_contrato%TYPE;
      v_dado                       VARCHAR2 (4000)                          := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
            v_num_versao_contrato := RTRIM (LTRIM (vi_num_versao_contrato));
            v_cod_subtipo_contrato := RTRIM (LTRIM (vi_cod_subtipo_contrato));
            v_cnt_justificativa_cre :=
                                     RTRIM (LTRIM (vi_cnt_justificativa_cre));
            v_num_ato_administrativo :=
                                    RTRIM (LTRIM (vi_num_ato_administrativo));
            v_cnt_cei := RTRIM (LTRIM (vi_cnt_cei));
            v_cnt_crea := RTRIM (LTRIM (vi_cnt_crea));
            v_num_dou_publicacao := RTRIM (LTRIM (vi_num_dou_publicacao));
            v_num_pagina_publicacao :=
                                     RTRIM (LTRIM (vi_num_pagina_publicacao));
            v_num_secao_publicacao := RTRIM (LTRIM (vi_num_secao_publicacao));
            v_cod_modalidade_licitacao :=
                                  RTRIM (LTRIM (vi_cod_modalidade_licitacao));
            v_dsc_fundamento_legal := RTRIM (LTRIM (vi_dsc_fundamento_legal));
            v_num_processo := RTRIM (LTRIM (vi_num_processo));
            v_tip_regularidade_fiscal :=
                                   RTRIM (LTRIM (vi_tip_regularidade_fiscal));
            v_cnt_data := TO_DATE (vi_cnt_data, 'DD/MM/YYYY');
            v_cnt_data_proposta :=
                                  TO_DATE (vi_cnt_data_proposta, 'DD/MM/YYYY');
            v_cnt_data_inicio := TO_DATE (vi_cnt_data_inicio, 'DD/MM/YYYY');
            v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
            v_num_seq_contrato := vi_num_seq_contrato;
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_cod_dep_contrato := vi_cod_dep_contrato;
            v_num_seq_gestor := vi_num_seq_gestor;
            v_num_seq_assinatura_1 := vi_num_seq_assinatura_1;
            v_num_seq_assinatura_2 := vi_num_seq_assinatura_2;
            v_cnt_prazo_exec := vi_cnt_prazo_exec;
            v_num_prazo_exec_meses := vi_num_prazo_exec_meses;
            v_cnt_prazo_adit := vi_cnt_prazo_adit;
            v_num_inciso := vi_num_inciso;
            v_num_licitacao := vi_num_licitacao;
            v_num_ano_licitacao := vi_num_ano_licitacao;
            v_seq_licitante_ganhadora := vi_seq_licitante_ganhadora;
            v_tip_situacao_contrato := vi_tip_situacao_contrato;

            UPDATE ifrbde.viw_contrato
               SET cnt_cod = v_cnt_cod,
                   num_versao_contrato = v_num_versao_contrato,
                   cod_subtipo_contrato = v_cod_subtipo_contrato,
                   cod_dep_contrato = v_cod_dep_contrato,
                   cnt_justificativa_cre = v_cnt_justificativa_cre,
                   num_seq_gestor = v_num_seq_gestor,
                   num_seq_assinatura_1 = v_num_seq_assinatura_1,
                   num_seq_assinatura_2 = v_num_seq_assinatura_2,
                   num_ato_administrativo = v_num_ato_administrativo,
                   cnt_cei = v_cnt_cei,
                   cnt_crea = v_cnt_crea,
                   cnt_data = v_cnt_data,
                   cnt_data_proposta = v_cnt_data_proposta,
                   cnt_data_inicio = v_cnt_data_inicio,
                   cnt_prazo_exec = v_cnt_prazo_exec,
                   num_prazo_exec_meses = v_num_prazo_exec_meses,
                   cnt_prazo_adit = v_cnt_prazo_adit,
                   dat_publicacao = v_dat_publicacao,
                   num_dou_publicacao = v_num_dou_publicacao,
                   num_pagina_publicacao = v_num_pagina_publicacao,
                   num_secao_publicacao = v_num_secao_publicacao,
                   cod_modalidade_licitacao = v_cod_modalidade_licitacao,
                   num_inciso = v_num_inciso,
                   dsc_fundamento_legal = v_dsc_fundamento_legal,
                   num_licitacao = v_num_licitacao,
                   num_ano_licitacao = v_num_ano_licitacao,
                   num_processo = v_num_processo,
                   tip_regularidade_fiscal = v_tip_regularidade_fiscal,
                   seq_licitante_ganhadora = v_seq_licitante_ganhadora,
                   tip_situacao_contrato = v_tip_situacao_contrato
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               BEGIN
                  ifrbde.prc_critica_contrato (vi_num_seq_contrato);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (
                        -20100,
                           ' Erro ao executar a rotina de critica '
                        || SQLERRM
                     );
               END;

               stp_pesquisa_contrato (
                  p_usuario,
                  vo_num_seq_contrato,
                  vo_cnt_cre_cod,
                  vo_cnt_cod,
                  vo_num_versao_contrato,
                  vo_cod_subtipo_contrato,
                  vo_num_termo_aditivo,
                  vo_cod_dep_contrato,
                  vo_cnt_justificativa_cre,
                  vo_num_seq_gestor,
                  vo_num_seq_assinatura_1,
                  vo_num_seq_assinatura_2,
                  vo_num_ato_administrativo,
                  vo_cnt_cei,
                  vo_cnt_crea,
                  vo_cnt_data,
                  vo_cnt_data_proposta,
                  vo_cnt_data_inicio,
                  vo_cnt_prazo_exec,
                  vo_num_prazo_exec_meses,
                  vo_cnt_prazo_adit,
                  vo_dat_termino_contrato,
                  vo_dat_publicacao,
                  vo_num_dou_publicacao,
                  vo_num_pagina_publicacao,
                  vo_num_secao_publicacao,
                  vo_cod_modalidade_licitacao,
                  vo_num_inciso,
                  vo_dsc_fundamento_legal,
                  vo_num_licitacao,
                  vo_num_ano_licitacao,
                  vo_num_processo,
                  vo_tip_regularidade_fiscal,
                  vo_cnt_valor_compromisso,
                  vo_cnt_valor_termo,
                  vo_cnt_valor_pago,
                  vo_cnt_valor_reaj,
                  vo_cnt_valor_reaj_pago,
                  vo_cnt_valor,
                  vo_seq_licitante_ganhadora,
                  vo_tip_situacao_contrato,
                  vo_tip_contrato,
                  vo_dsc_critica_contrato,
                  vi_num_seq_contrato,
                  vi_cnt_cre_cod
               );
               v_dado :=
                           'num_seq_contrato = '
                        || TO_CHAR (v_num_seq_contrato);
               v_dado :=
                       v_dado
                    || ','
                    || 'cnt_cre_cod = '
                    || TO_CHAR (v_cnt_cre_cod);
               v_dado :=
                         v_dado
                      || ','
                      || 'cnt_cod = '
                      || RTRIM (LTRIM (v_cnt_cod));
               v_dado :=    v_dado
                         || ','
                         || 'num_versao_contrato = '
                         || RTRIM (LTRIM (v_num_versao_contrato));
               v_dado :=    v_dado
                         || ','
                         || 'cod_subtipo_contrato = '
                         || RTRIM (LTRIM (v_cod_subtipo_contrato));
               v_dado :=    v_dado
                         || ','
                         || 'cod_dep_contrato = '
                         || TO_CHAR (v_cod_dep_contrato);
               v_dado :=    v_dado
                         || ','
                         || 'cnt_justificativa_cre = '
                         || RTRIM (LTRIM (v_cnt_justificativa_cre));
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_gestor = '
                         || TO_CHAR (v_num_seq_gestor);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_assinatura_1 = '
                         || TO_CHAR (v_num_seq_assinatura_1);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_assinatura_2 = '
                         || TO_CHAR (v_num_seq_assinatura_2);
               v_dado :=    v_dado
                         || ','
                         || 'num_ato_administrativo = '
                         || RTRIM (LTRIM (v_num_ato_administrativo));
               v_dado :=
                         v_dado
                      || ','
                      || 'cnt_cei = '
                      || RTRIM (LTRIM (v_cnt_cei));
               v_dado :=
                       v_dado
                    || ','
                    || 'cnt_crea = '
                    || RTRIM (LTRIM (v_cnt_crea));
               v_dado :=    v_dado
                         || ','
                         || 'cnt_data = '
                         || TO_CHAR (v_cnt_data, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'cnt_data_proposta = '
                         || TO_CHAR (v_cnt_data_proposta, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'cnt_data_inicio = '
                         || TO_CHAR (v_cnt_data_inicio, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'cnt_prazo_exec = '
                         || TO_CHAR (v_cnt_prazo_exec);
               v_dado :=    v_dado
                         || ','
                         || 'num_prazo_exec_meses = '
                         || TO_CHAR (v_num_prazo_exec_meses);
               v_dado :=    v_dado
                         || ','
                         || 'cnt_prazo_adit = '
                         || TO_CHAR (v_cnt_prazo_adit);
               v_dado :=    v_dado
                         || ','
                         || 'dat_publicacao = '
                         || TO_CHAR (v_dat_publicacao, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'num_dou_publicacao = '
                         || RTRIM (LTRIM (v_num_dou_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'num_pagina_publicacao = '
                         || RTRIM (LTRIM (v_num_pagina_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'num_secao_publicacao = '
                         || RTRIM (LTRIM (v_num_secao_publicacao));
               v_dado :=    v_dado
                         || ','
                         || 'cod_modalidade_licitacao = '
                         || RTRIM (LTRIM (v_cod_modalidade_licitacao));
               v_dado :=
                         v_dado
                      || ','
                      || 'num_inciso = '
                      || TO_CHAR (v_num_inciso);
               v_dado :=    v_dado
                         || ','
                         || 'dsc_fundamento_legal = '
                         || RTRIM (LTRIM (v_dsc_fundamento_legal));
               v_dado :=    v_dado
                         || ','
                         || 'num_licitacao = '
                         || TO_CHAR (v_num_licitacao);
               v_dado :=    v_dado
                         || ','
                         || 'num_ano_licitacao = '
                         || TO_CHAR (v_num_ano_licitacao);
               v_dado :=    v_dado
                         || ','
                         || 'num_processo = '
                         || RTRIM (LTRIM (v_num_processo));
               v_dado :=    v_dado
                         || ','
                         || 'tip_regularidade_fiscal = '
                         || RTRIM (LTRIM (v_tip_regularidade_fiscal));
               v_dado :=    v_dado
                         || ','
                         || 'seq_licitante_ganhadora = '
                         || TO_CHAR (v_seq_licitante_ganhadora);
               v_dado :=    v_dado
                         || ','
                         || 'tip_situacao_contrato = '
                         || TO_CHAR (v_tip_situacao_contrato);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_CONTRATO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error (
                  -20100,
                  'Mais de um registro solicitado para alteração. Operação não realizada!!!'
               );
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para alteração!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para alteração!!!'
         );
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         raise_application_error (
            -20100,
               'Número do contrato já existe'
            || vi_cnt_cre_cod
            || ' - '
            || SQLERRM
         );
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_valores_contrato (
      p_usuario                       IN       VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato_res_rv, num_seq_resumo_rv,
                cnt_cre_cod_res, cnt_cod_res,
                num_versao_contrato_res_rv, val_resumo_rv,
                val_termo_rv, val_pagamento_rv,
                val_reajuste_rv, val_pago_rv,
                val_pago_reajuste_rv, val_saldo_resumo_rv,
                flg_moeda_controle_rv, tip_moeda_rv,
                dat_moeda_rv, val_cotacao_moeda_rv,
                tip_cotacao_moeda_rv, val_resumo_sec_rv,
                val_termo_sec_rv, val_pagamento_sec_rv,
                val_reajuste_sec_rv, val_pago_sec_rv,
                val_pago_reajuste_sec_rv,
                val_saldo_resumo_sec_rv
           INTO vo_num_seq_contrato_res_rv (1), vo_num_seq_resumo_rv (1),
                vo_cnt_cre_cod_res (1), vo_cnt_cod_res (1),
                vo_num_versao_contrato_res_rv (1), vo_val_resumo_rv (1),
                vo_val_termo_rv (1), vo_val_pagamento_rv (1),
                vo_val_reajuste_rv (1), vo_val_pago_rv (1),
                vo_val_pago_reajuste_rv (1), vo_val_saldo_resumo_rv (1),
                vo_flg_moeda_controle_rv (1), vo_tip_moeda_rv (1),
                vo_dat_moeda_rv (1), vo_val_cotacao_moeda_rv (1),
                vo_tip_cotacao_moeda_rv (1), vo_val_resumo_sec_rv (1),
                vo_val_termo_sec_rv (1), vo_val_pagamento_sec_rv (1),
                vo_val_reajuste_sec_rv (1), vo_val_pago_sec_rv (1),
                vo_val_pago_reajuste_sec_rv (1),
                vo_val_saldo_resumo_sec_rv (1)
           FROM ifrbde.viw_valores_contrato
          WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
            AND num_seq_resumo_rv = vi_num_seq_resumo_rv;

         
--
         ifrbde.prc_gravar_usuario_contrato (vi_num_seq_contrato_res_rv, 'R');
      
/*
         DELETE FROM ifrbde.aux_usuario_contrato
               WHERE nom_username = USER;

         INSERT INTO ifrbde.aux_usuario_contrato
                     (nom_username,
                      num_seq_contrato_aux
                     )
              VALUES (USER,
                      vi_num_seq_contrato_res_rv
                     );
*/
--
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Valores do Contrato
   -- retorna o OK ou não
   PROCEDURE stp_exclui_valores_contrato (
      p_usuario                    IN       VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_contrato_res_rv   IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv         IN       t_num_seq_resumo_rv
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_valores_contrato
              WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
                AND num_seq_resumo_rv = vi_num_seq_resumo_rv
         FOR UPDATE;

      v_viw_valores_contrato   ifrbde.viw_valores_contrato%ROWTYPE;
      v_dado                   VARCHAR2 (4000)                       := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_valores_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'num_seq_contrato_res_rv = '
                  || TO_CHAR (v_viw_valores_contrato.num_seq_contrato_res_rv);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_rv = '
                      || TO_CHAR (v_viw_valores_contrato.num_seq_resumo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cre_cod_res = '
                      || TO_CHAR (v_viw_valores_contrato.cnt_cre_cod_res);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cod_res = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_viw_valores_contrato.cnt_cod_res)
                            )
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_versao_contrato_res_rv = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_viw_valores_contrato.num_versao_contrato_res_rv
                           )
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_resumo_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_resumo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_termo_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_termo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_pagamento_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_reajuste_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_pago_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_reajuste_rv = '
                      || TO_CHAR (
                            v_viw_valores_contrato.val_pago_reajuste_rv
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_saldo_resumo_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_saldo_resumo_rv);
            v_dado :=
                     v_dado
                  || ','
                  || 'flg_moeda_controle_rv = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_viw_valores_contrato.flg_moeda_controle_rv
                           )
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_moeda_rv = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_valores_contrato.tip_moeda_rv))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_rv = '
                      || TO_DATE (
                            v_viw_valores_contrato.dat_moeda_rv,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda_rv = '
                      || TO_CHAR (
                            v_viw_valores_contrato.val_cotacao_moeda_rv
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'tip_cotacao_moeda_rv = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_viw_valores_contrato.tip_cotacao_moeda_rv
                           )
                        )
                     );
            v_dado :=    v_dado
                      || ','
                      || 'val_resumo_sec_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_resumo_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_termo_sec_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_termo_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_sec_rv = '
                      || TO_CHAR (
                            v_viw_valores_contrato.val_pagamento_sec_rv
                         );
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste_sec_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_reajuste_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_sec_rv = '
                      || TO_CHAR (v_viw_valores_contrato.val_pago_sec_rv);
            v_dado :=
                     v_dado
                  || ','
                  || 'val_pago_reajuste_sec_rv = '
                  || TO_CHAR (
                        v_viw_valores_contrato.val_pago_reajuste_sec_rv
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'val_saldo_resumo_sec_rv = '
                  || TO_CHAR (v_viw_valores_contrato.val_saldo_resumo_sec_rv);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_VALORES_CONTRATO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.viw_valores_contrato
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_valores_contrato (
      p_usuario                       IN       VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   )
   AS
      v_num_seq_contrato_res_rv    viw_valores_contrato.num_seq_contrato_res_rv%TYPE;
      v_num_seq_resumo_rv          viw_valores_contrato.num_seq_resumo_rv%TYPE;
      v_cnt_cre_cod_res            viw_valores_contrato.cnt_cre_cod_res%TYPE;
      v_cnt_cod_res                viw_valores_contrato.cnt_cod_res%TYPE;
      v_val_resumo_rv              viw_valores_contrato.val_resumo_rv%TYPE;
      v_val_termo_rv               viw_valores_contrato.val_termo_rv%TYPE;
      v_val_pagamento_rv           viw_valores_contrato.val_pagamento_rv%TYPE;
      v_val_reajuste_rv            viw_valores_contrato.val_reajuste_rv%TYPE;
      v_val_pago_rv                viw_valores_contrato.val_pago_rv%TYPE;
      v_val_pago_reajuste_rv       viw_valores_contrato.val_pago_reajuste_rv%TYPE;
      v_val_saldo_resumo_rv        viw_valores_contrato.val_saldo_resumo_rv%TYPE;
      v_flg_moeda_controle_rv      viw_valores_contrato.flg_moeda_controle_rv%TYPE;
      v_tip_moeda_rv               viw_valores_contrato.tip_moeda_rv%TYPE;
      v_dat_moeda_rv               viw_valores_contrato.dat_moeda_rv%TYPE;
      v_val_cotacao_moeda_rv       viw_valores_contrato.val_cotacao_moeda_rv%TYPE;
      v_tip_cotacao_moeda_rv       viw_valores_contrato.tip_cotacao_moeda_rv%TYPE;
      v_val_resumo_sec_rv          viw_valores_contrato.val_resumo_sec_rv%TYPE;
      v_val_termo_sec_rv           viw_valores_contrato.val_termo_sec_rv%TYPE;
      v_val_pagamento_sec_rv       viw_valores_contrato.val_pagamento_sec_rv%TYPE;
      v_val_reajuste_sec_rv        viw_valores_contrato.val_reajuste_sec_rv%TYPE;
      v_val_pago_sec_rv            viw_valores_contrato.val_pago_sec_rv%TYPE;
      v_val_pago_reajuste_sec_rv   viw_valores_contrato.val_pago_reajuste_sec_rv%TYPE;
      v_val_saldo_resumo_sec_rv    viw_valores_contrato.val_saldo_resumo_sec_rv%TYPE;
      v_dado                       VARCHAR2 (4000)                          := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'INCLUI'
         )
      THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_rv
           FROM DUAL;

         v_cnt_cod_res := RTRIM (LTRIM (vi_cnt_cod_res));
         v_flg_moeda_controle_rv := RTRIM (LTRIM (vi_flg_moeda_controle_rv));
         v_tip_moeda_rv := RTRIM (LTRIM (vi_tip_moeda_rv));
         v_tip_cotacao_moeda_rv := RTRIM (LTRIM (vi_tip_cotacao_moeda_rv));
         v_dat_moeda_rv := TO_DATE (vi_dat_moeda_rv, 'DD/MM/YYYY');
         v_num_seq_contrato_res_rv := vi_num_seq_contrato_res_rv;
         v_cnt_cre_cod_res := vi_cnt_cre_cod_res;
         v_val_resumo_rv := vi_val_resumo_rv;
         v_val_termo_rv := vi_val_termo_rv;
         v_val_pagamento_rv := vi_val_pagamento_rv;
         v_val_reajuste_rv := vi_val_reajuste_rv;
         v_val_pago_rv := vi_val_pago_rv;
         v_val_pago_reajuste_rv := vi_val_pago_reajuste_rv;
         v_val_saldo_resumo_rv := vi_val_saldo_resumo_rv;
         v_val_cotacao_moeda_rv := vi_val_cotacao_moeda_rv;
         v_val_resumo_sec_rv := vi_val_resumo_sec_rv;
         v_val_termo_sec_rv := vi_val_termo_sec_rv;
         v_val_pagamento_sec_rv := vi_val_pagamento_sec_rv;
         v_val_reajuste_sec_rv := vi_val_reajuste_sec_rv;
         v_val_pago_sec_rv := vi_val_pago_sec_rv;
         v_val_pago_reajuste_sec_rv := vi_val_pago_reajuste_sec_rv;
         v_val_saldo_resumo_sec_rv := vi_val_saldo_resumo_sec_rv;

         INSERT INTO ifrbde.viw_valores_contrato
                     (num_seq_contrato_res_rv, num_seq_resumo_rv,
                      cnt_cre_cod_res, cnt_cod_res, val_resumo_rv,
                      val_termo_rv, val_pagamento_rv, val_reajuste_rv,
                      val_pago_rv, val_pago_reajuste_rv,
                      val_saldo_resumo_rv, flg_moeda_controle_rv,
                      tip_moeda_rv, dat_moeda_rv, val_cotacao_moeda_rv,
                      tip_cotacao_moeda_rv, val_resumo_sec_rv,
                      val_termo_sec_rv, val_pagamento_sec_rv,
                      val_reajuste_sec_rv, val_pago_sec_rv,
                      val_pago_reajuste_sec_rv, val_saldo_resumo_sec_rv)
              VALUES (v_num_seq_contrato_res_rv, v_num_seq_resumo_rv,
                      v_cnt_cre_cod_res, v_cnt_cod_res, v_val_resumo_rv,
                      v_val_termo_rv, v_val_pagamento_rv, v_val_reajuste_rv,
                      v_val_pago_rv, v_val_pago_reajuste_rv,
                      v_val_saldo_resumo_rv, v_flg_moeda_controle_rv,
                      v_tip_moeda_rv, v_dat_moeda_rv, v_val_cotacao_moeda_rv,
                      v_tip_cotacao_moeda_rv, v_val_resumo_sec_rv,
                      v_val_termo_sec_rv, v_val_pagamento_sec_rv,
                      v_val_reajuste_sec_rv, v_val_pago_sec_rv,
                      v_val_pago_reajuste_sec_rv, v_val_saldo_resumo_sec_rv);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_valores_contrato (
               p_usuario,
               vo_num_seq_contrato_res_rv,
               vo_num_seq_resumo_rv,
               vo_cnt_cre_cod_res,
               vo_cnt_cod_res,
               vo_num_versao_contrato_res_rv,
               vo_val_resumo_rv,
               vo_val_termo_rv,
               vo_val_pagamento_rv,
               vo_val_reajuste_rv,
               vo_val_pago_rv,
               vo_val_pago_reajuste_rv,
               vo_val_saldo_resumo_rv,
               vo_flg_moeda_controle_rv,
               vo_tip_moeda_rv,
               vo_dat_moeda_rv,
               vo_val_cotacao_moeda_rv,
               vo_tip_cotacao_moeda_rv,
               vo_val_resumo_sec_rv,
               vo_val_termo_sec_rv,
               vo_val_pagamento_sec_rv,
               vo_val_reajuste_sec_rv,
               vo_val_pago_sec_rv,
               vo_val_pago_reajuste_sec_rv,
               vo_val_saldo_resumo_sec_rv,
               v_num_seq_contrato_res_rv,
               v_num_seq_resumo_rv
            );
            v_dado :=    'num_seq_contrato_res_rv = '
                      || TO_CHAR (v_num_seq_contrato_res_rv);
            v_dado :=    v_dado
                      || ','
                      || 'num_seq_resumo_rv = '
                      || TO_CHAR (v_num_seq_resumo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cre_cod_res = '
                      || TO_CHAR (v_cnt_cre_cod_res);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cod_res = '
                      || RTRIM (LTRIM (v_cnt_cod_res));
            v_dado :=
                  v_dado
               || ','
               || 'val_resumo_rv = '
               || TO_CHAR (v_val_resumo_rv);
            v_dado :=
                    v_dado
                 || ','
                 || 'val_termo_rv = '
                 || TO_CHAR (v_val_termo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_rv = '
                      || TO_CHAR (v_val_pagamento_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste_rv = '
                      || TO_CHAR (v_val_reajuste_rv);
            v_dado :=
                      v_dado
                   || ','
                   || 'val_pago_rv = '
                   || TO_CHAR (v_val_pago_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_reajuste_rv = '
                      || TO_CHAR (v_val_pago_reajuste_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_saldo_resumo_rv = '
                      || TO_CHAR (v_val_saldo_resumo_rv);
            v_dado :=    v_dado
                      || ','
                      || 'flg_moeda_controle_rv = '
                      || RTRIM (LTRIM (v_flg_moeda_controle_rv));
            v_dado :=    v_dado
                      || ','
                      || 'tip_moeda_rv = '
                      || RTRIM (LTRIM (v_tip_moeda_rv));
            v_dado :=    v_dado
                      || ','
                      || 'dat_moeda_rv = '
                      || TO_CHAR (v_dat_moeda_rv, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'val_cotacao_moeda_rv = '
                      || TO_CHAR (v_val_cotacao_moeda_rv);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cotacao_moeda_rv = '
                      || RTRIM (LTRIM (v_tip_cotacao_moeda_rv));
            v_dado :=    v_dado
                      || ','
                      || 'val_resumo_sec_rv = '
                      || TO_CHAR (v_val_resumo_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_termo_sec_rv = '
                      || TO_CHAR (v_val_termo_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pagamento_sec_rv = '
                      || TO_CHAR (v_val_pagamento_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_reajuste_sec_rv = '
                      || TO_CHAR (v_val_reajuste_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_sec_rv = '
                      || TO_CHAR (v_val_pago_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_pago_reajuste_sec_rv = '
                      || TO_CHAR (v_val_pago_reajuste_sec_rv);
            v_dado :=    v_dado
                      || ','
                      || 'val_saldo_resumo_sec_rv = '
                      || TO_CHAR (v_val_saldo_resumo_sec_rv);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_VALORES_CONTRATO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_valores_contrato (
      p_usuario                       IN       VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_valores_contrato
              WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
                AND num_seq_resumo_rv = vi_num_seq_resumo_rv
         FOR UPDATE;

      v_viw_valores_contrato       ifrbde.viw_valores_contrato%ROWTYPE;
      v_num_seq_contrato_res_rv    ifrbde.viw_valores_contrato.num_seq_contrato_res_rv%TYPE;
      v_num_seq_resumo_rv          ifrbde.viw_valores_contrato.num_seq_resumo_rv%TYPE;
      v_cnt_cre_cod_res            ifrbde.viw_valores_contrato.cnt_cre_cod_res%TYPE;
      v_cnt_cod_res                ifrbde.viw_valores_contrato.cnt_cod_res%TYPE;
      v_val_resumo_rv              ifrbde.viw_valores_contrato.val_resumo_rv%TYPE;
      v_val_termo_rv               ifrbde.viw_valores_contrato.val_termo_rv%TYPE;
      v_val_pagamento_rv           ifrbde.viw_valores_contrato.val_pagamento_rv%TYPE;
      v_val_reajuste_rv            ifrbde.viw_valores_contrato.val_reajuste_rv%TYPE;
      v_val_pago_rv                ifrbde.viw_valores_contrato.val_pago_rv%TYPE;
      v_val_pago_reajuste_rv       ifrbde.viw_valores_contrato.val_pago_reajuste_rv%TYPE;
      v_val_saldo_resumo_rv        ifrbde.viw_valores_contrato.val_saldo_resumo_rv%TYPE;
      v_flg_moeda_controle_rv      ifrbde.viw_valores_contrato.flg_moeda_controle_rv%TYPE;
      v_tip_moeda_rv               ifrbde.viw_valores_contrato.tip_moeda_rv%TYPE;
      v_dat_moeda_rv               ifrbde.viw_valores_contrato.dat_moeda_rv%TYPE;
      v_val_cotacao_moeda_rv       ifrbde.viw_valores_contrato.val_cotacao_moeda_rv%TYPE;
      v_tip_cotacao_moeda_rv       ifrbde.viw_valores_contrato.tip_cotacao_moeda_rv%TYPE;
      v_val_resumo_sec_rv          ifrbde.viw_valores_contrato.val_resumo_sec_rv%TYPE;
      v_val_termo_sec_rv           ifrbde.viw_valores_contrato.val_termo_sec_rv%TYPE;
      v_val_pagamento_sec_rv       ifrbde.viw_valores_contrato.val_pagamento_sec_rv%TYPE;
      v_val_reajuste_sec_rv        ifrbde.viw_valores_contrato.val_reajuste_sec_rv%TYPE;
      v_val_pago_sec_rv            ifrbde.viw_valores_contrato.val_pago_sec_rv%TYPE;
      v_val_pago_reajuste_sec_rv   ifrbde.viw_valores_contrato.val_pago_reajuste_sec_rv%TYPE;
      v_val_saldo_resumo_sec_rv    ifrbde.viw_valores_contrato.val_saldo_resumo_sec_rv%TYPE;
      v_dado                       VARCHAR2 (4000)                          := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_valores_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cnt_cod_res := RTRIM (LTRIM (vi_cnt_cod_res));
            v_flg_moeda_controle_rv :=
                                     RTRIM (LTRIM (vi_flg_moeda_controle_rv));
            v_tip_moeda_rv := RTRIM (LTRIM (vi_tip_moeda_rv));
            v_tip_cotacao_moeda_rv := RTRIM (LTRIM (vi_tip_cotacao_moeda_rv));
            v_dat_moeda_rv := TO_DATE (vi_dat_moeda_rv, 'DD/MM/YYYY');
            v_num_seq_contrato_res_rv := vi_num_seq_contrato_res_rv;
            v_num_seq_resumo_rv := vi_num_seq_resumo_rv;
            v_cnt_cre_cod_res := vi_cnt_cre_cod_res;
            v_val_resumo_rv := vi_val_resumo_rv;
            v_val_termo_rv := vi_val_termo_rv;
            v_val_pagamento_rv := vi_val_pagamento_rv;
            v_val_reajuste_rv := vi_val_reajuste_rv;
            v_val_pago_rv := vi_val_pago_rv;
            v_val_pago_reajuste_rv := vi_val_pago_reajuste_rv;
            v_val_saldo_resumo_rv := vi_val_saldo_resumo_rv;
            v_val_cotacao_moeda_rv := vi_val_cotacao_moeda_rv;
            v_val_resumo_sec_rv := vi_val_resumo_sec_rv;
            v_val_termo_sec_rv := vi_val_termo_sec_rv;
            v_val_pagamento_sec_rv := vi_val_pagamento_sec_rv;
            v_val_reajuste_sec_rv := vi_val_reajuste_sec_rv;
            v_val_pago_sec_rv := vi_val_pago_sec_rv;
            v_val_pago_reajuste_sec_rv := vi_val_pago_reajuste_sec_rv;
            v_val_saldo_resumo_sec_rv := vi_val_saldo_resumo_sec_rv;

            UPDATE ifrbde.viw_valores_contrato
               SET cnt_cre_cod_res = v_cnt_cre_cod_res,
                   cnt_cod_res = v_cnt_cod_res,
                   val_resumo_rv = v_val_resumo_rv,
                   val_termo_rv = v_val_termo_rv,
                   val_pagamento_rv = v_val_pagamento_rv,
                   val_reajuste_rv = v_val_reajuste_rv,
                   val_pago_rv = v_val_pago_rv,
                   val_pago_reajuste_rv = v_val_pago_reajuste_rv,
                   val_saldo_resumo_rv = v_val_saldo_resumo_rv,
                   flg_moeda_controle_rv = v_flg_moeda_controle_rv,
                   tip_moeda_rv = v_tip_moeda_rv,
                   dat_moeda_rv = v_dat_moeda_rv,
                   val_cotacao_moeda_rv = v_val_cotacao_moeda_rv,
                   tip_cotacao_moeda_rv = v_tip_cotacao_moeda_rv,
                   val_resumo_sec_rv = v_val_resumo_sec_rv,
                   val_termo_sec_rv = v_val_termo_sec_rv,
                   val_pagamento_sec_rv = v_val_pagamento_sec_rv,
                   val_reajuste_sec_rv = v_val_reajuste_sec_rv,
                   val_pago_sec_rv = v_val_pago_sec_rv,
                   val_pago_reajuste_sec_rv = v_val_pago_reajuste_sec_rv,
                   val_saldo_resumo_sec_rv = v_val_saldo_resumo_sec_rv
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_valores_contrato (
                  p_usuario,
                  vo_num_seq_contrato_res_rv,
                  vo_num_seq_resumo_rv,
                  vo_cnt_cre_cod_res,
                  vo_cnt_cod_res,
                  vo_num_versao_contrato_res_rv,
                  vo_val_resumo_rv,
                  vo_val_termo_rv,
                  vo_val_pagamento_rv,
                  vo_val_reajuste_rv,
                  vo_val_pago_rv,
                  vo_val_pago_reajuste_rv,
                  vo_val_saldo_resumo_rv,
                  vo_flg_moeda_controle_rv,
                  vo_tip_moeda_rv,
                  vo_dat_moeda_rv,
                  vo_val_cotacao_moeda_rv,
                  vo_tip_cotacao_moeda_rv,
                  vo_val_resumo_sec_rv,
                  vo_val_termo_sec_rv,
                  vo_val_pagamento_sec_rv,
                  vo_val_reajuste_sec_rv,
                  vo_val_pago_sec_rv,
                  vo_val_pago_reajuste_sec_rv,
                  vo_val_saldo_resumo_sec_rv,
                  vi_num_seq_contrato_res_rv,
                  vi_num_seq_resumo_rv
               );
               v_dado :=    'num_seq_contrato_res_rv = '
                         || TO_CHAR (v_num_seq_contrato_res_rv);
               v_dado :=    v_dado
                         || ','
                         || 'num_seq_resumo_rv = '
                         || TO_CHAR (v_num_seq_resumo_rv);
               v_dado :=    v_dado
                         || ','
                         || 'cnt_cre_cod_res = '
                         || TO_CHAR (v_cnt_cre_cod_res);
               v_dado :=    v_dado
                         || ','
                         || 'cnt_cod_res = '
                         || RTRIM (LTRIM (v_cnt_cod_res));
               v_dado :=    v_dado
                         || ','
                         || 'val_resumo_rv = '
                         || TO_CHAR (v_val_resumo_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_termo_rv = '
                         || TO_CHAR (v_val_termo_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_pagamento_rv = '
                         || TO_CHAR (v_val_pagamento_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_reajuste_rv = '
                         || TO_CHAR (v_val_reajuste_rv);
               v_dado :=
                      v_dado
                   || ','
                   || 'val_pago_rv = '
                   || TO_CHAR (v_val_pago_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_pago_reajuste_rv = '
                         || TO_CHAR (v_val_pago_reajuste_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_saldo_resumo_rv = '
                         || TO_CHAR (v_val_saldo_resumo_rv);
               v_dado :=    v_dado
                         || ','
                         || 'flg_moeda_controle_rv = '
                         || RTRIM (LTRIM (v_flg_moeda_controle_rv));
               v_dado :=    v_dado
                         || ','
                         || 'tip_moeda_rv = '
                         || RTRIM (LTRIM (v_tip_moeda_rv));
               v_dado :=    v_dado
                         || ','
                         || 'dat_moeda_rv = '
                         || TO_CHAR (v_dat_moeda_rv, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'val_cotacao_moeda_rv = '
                         || TO_CHAR (v_val_cotacao_moeda_rv);
               v_dado :=    v_dado
                         || ','
                         || 'tip_cotacao_moeda_rv = '
                         || RTRIM (LTRIM (v_tip_cotacao_moeda_rv));
               v_dado :=    v_dado
                         || ','
                         || 'val_resumo_sec_rv = '
                         || TO_CHAR (v_val_resumo_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_termo_sec_rv = '
                         || TO_CHAR (v_val_termo_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_pagamento_sec_rv = '
                         || TO_CHAR (v_val_pagamento_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_reajuste_sec_rv = '
                         || TO_CHAR (v_val_reajuste_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_pago_sec_rv = '
                         || TO_CHAR (v_val_pago_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_pago_reajuste_sec_rv = '
                         || TO_CHAR (v_val_pago_reajuste_sec_rv);
               v_dado :=    v_dado
                         || ','
                         || 'val_saldo_resumo_sec_rv = '
                         || TO_CHAR (v_val_saldo_resumo_sec_rv);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_VALORES_CONTRATO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Cadastro de Índices/Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice (
      p_usuario       IN       VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_INDICE',
            'PESQUISA'
         )
      THEN
         SELECT ice_cod, tip_indice
           INTO vo_ice_cod (1), vo_tip_indice (1)
           FROM ifrbde.viw_indice
          WHERE ice_cod = vi_ice_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Índices/Moedas
   -- retorna o OK ou não
   PROCEDURE stp_exclui_indice (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_ice_cod   IN       t_ice_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_indice
              WHERE ice_cod = vi_ice_cod
         FOR UPDATE;

      v_viw_indice   ifrbde.viw_indice%ROWTYPE;
      v_dado         VARCHAR2 (4000)             := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_INDICE', 'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_indice;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                   'ice_cod = '
                || RTRIM (LTRIM (UPPER (v_viw_indice.ice_cod)));
            v_dado :=    v_dado
                      || ','
                      || 'tip_indice = '
                      || RTRIM (LTRIM (UPPER (v_viw_indice.tip_indice)));

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_INDICE',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.viw_indice
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Índices/Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice (
      p_usuario       IN       VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   )
   AS
      v_ice_cod      viw_indice.ice_cod%TYPE;
      v_tip_indice   viw_indice.tip_indice%TYPE;
      v_dado         VARCHAR2 (4000)              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_INDICE', 'INCLUI')
      THEN
         v_ice_cod := RTRIM (LTRIM (vi_ice_cod));
         v_tip_indice := RTRIM (LTRIM (vi_tip_indice));

         INSERT INTO ifrbde.viw_indice
                     (ice_cod, tip_indice)
              VALUES (v_ice_cod, v_tip_indice);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_indice (
               p_usuario,
               vo_ice_cod,
               vo_tip_indice,
               v_ice_cod
            );
            v_dado :=    'ice_cod = '
                      || RTRIM (LTRIM (v_ice_cod));
            v_dado :=
                  v_dado
               || ','
               || 'tip_indice = '
               || RTRIM (LTRIM (v_tip_indice));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario, 'VIW_INDICE', 'I', v_dado);
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Índices/Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_indice (
      p_usuario       IN       VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_indice
              WHERE ice_cod = vi_ice_cod
         FOR UPDATE;

      v_viw_indice   ifrbde.viw_indice%ROWTYPE;
      v_ice_cod      ifrbde.viw_indice.ice_cod%TYPE;
      v_tip_indice   ifrbde.viw_indice.tip_indice%TYPE;
      v_dado         VARCHAR2 (4000)                     := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_INDICE', 'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_indice;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_ice_cod := RTRIM (LTRIM (vi_ice_cod));
            v_tip_indice := RTRIM (LTRIM (vi_tip_indice));

            UPDATE ifrbde.viw_indice
               SET tip_indice = v_tip_indice
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_indice (
                  p_usuario,
                  vo_ice_cod,
                  vo_tip_indice,
                  vi_ice_cod
               );
               v_dado :=    'ice_cod = '
                         || RTRIM (LTRIM (v_ice_cod));
               v_dado :=    v_dado
                         || ','
                         || 'tip_indice = '
                         || RTRIM (LTRIM (v_tip_indice));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_INDICE',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
--- VIW_EXCLUI_TERMO_ADITIVO
--- ************* ATENÇÃO *************
-- PROCEDURE ALTERADA NA ALTERAÇÃO
--
-- Pesquisa Retorna Versão de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_exclui_termo_adit (
      p_usuario                       IN       VARCHAR2,
      vo_cnt_cre_cod_res_ex           OUT      tyt_cnt_cre_cod_res_ex,
      vo_cnt_cod_res_ex               OUT      tyt_cnt_cod_res_ex,
      vo_num_versao_contrato_res_ex   OUT      tyt_num_versao_contrato_res_ex,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_EXCLUI_TERMO_ADITIVO',
            'PESQUISA'
         )
      THEN
         SELECT cnt_cre_cod_res_ex, cnt_cod_res_ex,
                num_versao_contrato_res_ex
           INTO vo_cnt_cre_cod_res_ex (1), vo_cnt_cod_res_ex (1),
                vo_num_versao_contrato_res_ex (1)
           FROM ifrbde.viw_exclui_termo_aditivo
          WHERE cnt_cre_cod_res_ex = vi_cnt_cre_cod_res_ex
            AND cnt_cod_res_ex = vi_cnt_cod_res_ex;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Retorna Versão de Contrato
   -- retorna o OK ou não
   PROCEDURE stp_exclui_exclui_termo_aditiv (
      p_usuario               IN       VARCHAR2,
      vo_ok                   OUT      tyt_ok,
      vi_cnt_cre_cod_res_ex   IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex       IN       t_cnt_cod_res_ex
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_exclui_termo_aditivo
              WHERE cnt_cre_cod_res_ex = vi_cnt_cre_cod_res_ex
                AND cnt_cod_res_ex = vi_cnt_cod_res_ex
         FOR UPDATE;

      v_viw_exclui_termo_aditivo   ifrbde.viw_exclui_termo_aditivo%ROWTYPE;
      v_dado                       VARCHAR2 (4000)                          := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_EXCLUI_TERMO_ADITIVO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_exclui_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                     'cnt_cre_cod_res_ex = '
                  || TO_CHAR (v_viw_exclui_termo_aditivo.cnt_cre_cod_res_ex);
            v_dado :=
                     v_dado
                  || ','
                  || 'cnt_cod_res_ex = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_exclui_termo_aditivo.cnt_cod_res_ex)
                        )
                     );
            v_dado :=
                     v_dado
                  || ','
                  || 'num_versao_contrato_res_ex = '
                  || RTRIM (
                        LTRIM (
                           UPPER (
                              v_viw_exclui_termo_aditivo.num_versao_contrato_res_ex
                           )
                        )
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_EXCLUI_TERMO_ADITIVO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.viw_exclui_termo_aditivo
                     WHERE  CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
                  raise_application_error (
                     -20100,
                     'Mais de um registro solicitado para exclusão. Operação não realizada!!!'
                  );
               END IF;
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para exclusão!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para exclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Retorna Versão de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_exclui_termo_aditiv (
      p_usuario                       IN       VARCHAR2,
      vo_cnt_cre_cod_res_ex           OUT      tyt_cnt_cre_cod_res_ex,
      vo_cnt_cod_res_ex               OUT      tyt_cnt_cod_res_ex,
      vo_num_versao_contrato_res_ex   OUT      tyt_num_versao_contrato_res_ex,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex,
      vi_num_versao_contrato_res_ex   IN       t_num_versao_contrato_res_ex
   )
   AS
      v_cnt_cre_cod_res_ex           viw_exclui_termo_aditivo.cnt_cre_cod_res_ex%TYPE;
      v_cnt_cod_res_ex               viw_exclui_termo_aditivo.cnt_cod_res_ex%TYPE;
      v_num_versao_contrato_res_ex   viw_exclui_termo_aditivo.num_versao_contrato_res_ex%TYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_EXCLUI_TERMO_ADITIVO',
            'INCLUI'
         )
      THEN
         v_cnt_cod_res_ex := RTRIM (LTRIM (vi_cnt_cod_res_ex));
         v_num_versao_contrato_res_ex :=
                                RTRIM (LTRIM (vi_num_versao_contrato_res_ex));
         v_cnt_cre_cod_res_ex := vi_cnt_cre_cod_res_ex;

         INSERT INTO ifrbde.viw_exclui_termo_aditivo
                     (cnt_cre_cod_res_ex, cnt_cod_res_ex,
                      num_versao_contrato_res_ex)
              VALUES (v_cnt_cre_cod_res_ex, v_cnt_cod_res_ex,
                      v_num_versao_contrato_res_ex);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_exclui_termo_adit (
               p_usuario,
               vo_cnt_cre_cod_res_ex,
               vo_cnt_cod_res_ex,
               vo_num_versao_contrato_res_ex,
               v_cnt_cre_cod_res_ex,
               v_cnt_cod_res_ex
            );
            v_dado :=
                      'cnt_cre_cod_res_ex = '
                   || TO_CHAR (v_cnt_cre_cod_res_ex);
            v_dado :=    v_dado
                      || ','
                      || 'cnt_cod_res_ex = '
                      || RTRIM (LTRIM (v_cnt_cod_res_ex));
            v_dado :=    v_dado
                      || ','
                      || 'num_versao_contrato_res_ex = '
                      || RTRIM (LTRIM (v_num_versao_contrato_res_ex));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_EXCLUI_TERMO_ADITIVO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error (
               -20100,
               'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para inclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Retorna Versão de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_exclui_termo_aditiv (
      p_usuario                       IN       VARCHAR2,
      vo_cnt_cre_cod_res_ex           OUT      tyt_cnt_cre_cod_res_ex,
      vo_cnt_cod_res_ex               OUT      tyt_cnt_cod_res_ex,
      vo_num_versao_contrato_res_ex   OUT      tyt_num_versao_contrato_res_ex,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex,
      vi_num_versao_contrato_res_ex   IN       t_num_versao_contrato_res_ex
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_exclui_termo_aditivo
              WHERE cnt_cre_cod_res_ex = vi_cnt_cre_cod_res_ex
                AND cnt_cod_res_ex = vi_cnt_cod_res_ex
         FOR UPDATE;

      v_viw_exclui_termo_aditivo     ifrbde.viw_exclui_termo_aditivo%ROWTYPE;
      v_cnt_cre_cod_res_ex           ifrbde.viw_exclui_termo_aditivo.cnt_cre_cod_res_ex%TYPE;
      v_cnt_cod_res_ex               ifrbde.viw_exclui_termo_aditivo.cnt_cod_res_ex%TYPE;
      v_num_versao_contrato_res_ex   ifrbde.viw_exclui_termo_aditivo.num_versao_contrato_res_ex%TYPE;
      v_dado                         VARCHAR2 (4000)                        := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_EXCLUI_TERMO_ADITIVO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_exclui_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cnt_cod_res_ex := RTRIM (LTRIM (vi_cnt_cod_res_ex));
            v_num_versao_contrato_res_ex :=
                                RTRIM (LTRIM (vi_num_versao_contrato_res_ex));
            v_cnt_cre_cod_res_ex := vi_cnt_cre_cod_res_ex;
            ifrbde.prc_exclui_termo_adt (
               v_viw_exclui_termo_aditivo.cnt_cod_res_ex,
               v_viw_exclui_termo_aditivo.num_versao_contrato_res_ex
            );

            
/*
            UPDATE ifrbde.viw_exclui_termo_aditivo
               SET num_versao_contrato_res_ex = v_num_versao_contrato_res_ex
             WHERE CURRENT OF c_cursor;
*/
            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_exclui_termo_adit (
                  p_usuario,
                  vo_cnt_cre_cod_res_ex,
                  vo_cnt_cod_res_ex,
                  vo_num_versao_contrato_res_ex,
                  vi_cnt_cre_cod_res_ex,
                  vi_cnt_cod_res_ex
               );
               v_dado :=
                      'cnt_cre_cod_res_ex = '
                   || TO_CHAR (v_cnt_cre_cod_res_ex);
               v_dado :=    v_dado
                         || ','
                         || 'cnt_cod_res_ex = '
                         || RTRIM (LTRIM (v_cnt_cod_res_ex));
               v_dado :=    v_dado
                         || ','
                         || 'num_versao_contrato_res_ex = '
                         || RTRIM (LTRIM (v_num_versao_contrato_res_ex));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_EXCLUI_TERMO_ADITIVO',
                  'A',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error (
                  -20100,
                  'Mais de um registro solicitado para alteração. Operação não realizada!!!'
               );
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para alteração!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para alteração!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Cadastro de Firmas
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_firma_sipreco (
      p_usuario            IN       VARCHAR2,
      vo_fir_cod           OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf      OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj          OUT      tyt_fir_cnpj,
      vo_fir_nome          OUT      tyt_fir_nome,
      vo_fir_razao         OUT      tyt_fir_razao,
      vo_fir_contato       OUT      tyt_fir_contato,
      vo_dsc_endereco      OUT      tyt_dsc_endereco,
      vo_dsc_complemento   OUT      tyt_dsc_complemento,
      vo_dsc_bairro        OUT      tyt_dsc_bairro,
      vo_dsc_cidade        OUT      tyt_dsc_cidade,
      vo_num_cep           OUT      tyt_num_cep,
      vo_fir_fone          OUT      tyt_fir_fone,
      vo_fir_fax           OUT      tyt_fir_fax,
      vo_sg_uf             OUT      tyt_sg_uf,
      vo_sg_pais           OUT      tyt_sg_pais,
      vo_fir_email         OUT      tyt_fir_email,
      vo_fir_obs           OUT      tyt_fir_obs,
      vo_cod_status        OUT      tyt_cod_status,
      vi_fir_cod           IN       t_fir_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_FIRMA_SIPRECO',
            'PESQUISA'
         )
      THEN
         SELECT fir_cod, tip_cnpj_cpf, fir_cnpj,
                fir_nome, fir_razao, fir_contato,
                dsc_endereco, dsc_complemento,
                dsc_bairro, dsc_cidade, num_cep,
                fir_fone, fir_fax, sg_uf,
                sg_pais, fir_email, fir_obs,
                cod_status
           INTO vo_fir_cod (1), vo_tip_cnpj_cpf (1), vo_fir_cnpj (1),
                vo_fir_nome (1), vo_fir_razao (1), vo_fir_contato (1),
                vo_dsc_endereco (1), vo_dsc_complemento (1),
                vo_dsc_bairro (1), vo_dsc_cidade (1), vo_num_cep (1),
                vo_fir_fone (1), vo_fir_fax (1), vo_sg_uf (1),
                vo_sg_pais (1), vo_fir_email (1), vo_fir_obs (1),
                vo_cod_status (1)
           FROM ifrbde.viw_firma_sipreco
          WHERE fir_cod = vi_fir_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Firmas
   -- retorna o OK ou não
   PROCEDURE stp_exclui_firma_sipreco (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_fir_cod   IN       t_fir_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT *
           FROM ifrbde.viw_firma_sipreco
          WHERE fir_cod = vi_fir_cod;

      v_viw_firma_sipreco   ifrbde.tab_firma%ROWTYPE;
      v_dado                VARCHAR2 (4000)            := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_FIRMA_SIPRECO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_firma_sipreco;

         IF NOT c_cursor%NOTFOUND
         THEN
            IF v_viw_firma_sipreco.cod_status = '0'
            THEN
               raise_application_error (
                  -20100,
                  'Exclusão de Firma não autorizada, pois não esta incorporada no cadastro do sistema.  Operação não realizada!!!'
               );
            END IF;

            v_dado :=    'fir_cod = '
                      || TO_CHAR (v_viw_firma_sipreco.fir_cod);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cnpj_cpf = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.tip_cnpj_cpf))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'fir_cnpj = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_cnpj)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_nome = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_nome)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_razao = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_razao)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_contato = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.fir_contato))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dsc_endereco = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.dsc_endereco))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dsc_complemento = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_viw_firma_sipreco.dsc_complemento)
                            )
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dsc_bairro = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.dsc_bairro))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'dsc_cidade = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.dsc_cidade))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'num_cep = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.num_cep)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_fone = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_fone)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_fax = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_fax)));
            v_dado :=    v_dado
                      || ','
                      || 'sg_uf = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.sg_uf)));
            v_dado :=    v_dado
                      || ','
                      || 'sg_pais = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.sg_pais)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_email = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_email)));
            v_dado :=    v_dado
                      || ','
                      || 'fir_obs = '
                      || RTRIM (LTRIM (UPPER (v_viw_firma_sipreco.fir_obs)));
            v_dado :=    v_dado
                      || ','
                      || 'cod_status = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_firma_sipreco.cod_status))
                         );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_FIRMA_SIPRECO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.tab_firma
                     WHERE fir_cod = vi_fir_cod;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
                  raise_application_error (
                     -20100,
                     'Mais de um registro solicitado para exclusão. Operação não realizada!!!'
                  );
               END IF;
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para exclusão!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para exclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Firmas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_firma_sipreco (
      p_usuario            IN       VARCHAR2,
      vo_fir_cod           OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf      OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj          OUT      tyt_fir_cnpj,
      vo_fir_nome          OUT      tyt_fir_nome,
      vo_fir_razao         OUT      tyt_fir_razao,
      vo_fir_contato       OUT      tyt_fir_contato,
      vo_dsc_endereco      OUT      tyt_dsc_endereco,
      vo_dsc_complemento   OUT      tyt_dsc_complemento,
      vo_dsc_bairro        OUT      tyt_dsc_bairro,
      vo_dsc_cidade        OUT      tyt_dsc_cidade,
      vo_num_cep           OUT      tyt_num_cep,
      vo_fir_fone          OUT      tyt_fir_fone,
      vo_fir_fax           OUT      tyt_fir_fax,
      vo_sg_uf             OUT      tyt_sg_uf,
      vo_sg_pais           OUT      tyt_sg_pais,
      vo_fir_email         OUT      tyt_fir_email,
      vo_fir_obs           OUT      tyt_fir_obs,
      vo_cod_status        OUT      tyt_cod_status,
      vi_tip_cnpj_cpf      IN       t_tip_cnpj_cpf,
      vi_fir_cnpj          IN       t_fir_cnpj,
      vi_fir_nome          IN       t_fir_nome,
      vi_fir_obs           IN       t_fir_obs,
      vi_cod_status        IN       t_cod_status
   )
   AS
      v_fir_cod        viw_firma_sipreco.fir_cod%TYPE;
      v_tip_cnpj_cpf   viw_firma_sipreco.tip_cnpj_cpf%TYPE;
      v_fir_cnpj       viw_firma_sipreco.fir_cnpj%TYPE;
      v_fir_nome       viw_firma_sipreco.fir_nome%TYPE;
      v_fir_obs        viw_firma_sipreco.fir_obs%TYPE;
      v_cod_status     viw_firma_sipreco.cod_status%TYPE;
      v_dado           VARCHAR2 (4000)                       := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_FIRMA_SIPRECO',
            'INCLUI'
         )
      THEN
         v_fir_cod := 0;
         ifrbde.prc_prox_numero_firma (v_fir_cod);
         v_tip_cnpj_cpf := RTRIM (LTRIM (vi_tip_cnpj_cpf));
         v_fir_cnpj := RTRIM (LTRIM (vi_fir_cnpj));
         v_fir_nome := RTRIM (LTRIM (vi_fir_nome));
         v_fir_obs := RTRIM (LTRIM (vi_fir_obs));
         v_cod_status := RTRIM (LTRIM (vi_cod_status));

         INSERT INTO ifrbde.tab_firma
                     (fir_cod, tip_cnpj_cpf, fir_cnpj, fir_nome,
                      fir_obs, cod_status)
              VALUES (v_fir_cod, v_tip_cnpj_cpf, v_fir_cnpj, v_fir_nome,
                      v_fir_obs, v_cod_status);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_firma_sipreco (
               p_usuario,
               vo_fir_cod,
               vo_tip_cnpj_cpf,
               vo_fir_cnpj,
               vo_fir_nome,
               vo_fir_razao,
               vo_fir_contato,
               vo_dsc_endereco,
               vo_dsc_complemento,
               vo_dsc_bairro,
               vo_dsc_cidade,
               vo_num_cep,
               vo_fir_fone,
               vo_fir_fax,
               vo_sg_uf,
               vo_sg_pais,
               vo_fir_email,
               vo_fir_obs,
               vo_cod_status,
               v_fir_cod
            );
            v_dado :=    'fir_cod = '
                      || TO_CHAR (v_fir_cod);
            v_dado :=    v_dado
                      || ','
                      || 'tip_cnpj_cpf = '
                      || RTRIM (LTRIM (v_tip_cnpj_cpf));
            v_dado :=
                      v_dado
                   || ','
                   || 'fir_cnpj = '
                   || RTRIM (LTRIM (v_fir_cnpj));
            v_dado :=
                      v_dado
                   || ','
                   || 'fir_nome = '
                   || RTRIM (LTRIM (v_fir_nome));
            v_dado :=
                        v_dado
                     || ','
                     || 'fir_obs = '
                     || RTRIM (LTRIM (v_fir_obs));
            v_dado :=
                  v_dado
               || ','
               || 'cod_status = '
               || RTRIM (LTRIM (v_cod_status));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_FIRMA_SIPRECO',
               'I',
               v_dado
            );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error (
               -20100,
               'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
            );
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para inclusão!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Firmas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_firma_sipreco (
      p_usuario            IN       VARCHAR2,
      vo_fir_cod           OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf      OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj          OUT      tyt_fir_cnpj,
      vo_fir_nome          OUT      tyt_fir_nome,
      vo_fir_razao         OUT      tyt_fir_razao,
      vo_fir_contato       OUT      tyt_fir_contato,
      vo_dsc_endereco      OUT      tyt_dsc_endereco,
      vo_dsc_complemento   OUT      tyt_dsc_complemento,
      vo_dsc_bairro        OUT      tyt_dsc_bairro,
      vo_dsc_cidade        OUT      tyt_dsc_cidade,
      vo_num_cep           OUT      tyt_num_cep,
      vo_fir_fone          OUT      tyt_fir_fone,
      vo_fir_fax           OUT      tyt_fir_fax,
      vo_sg_uf             OUT      tyt_sg_uf,
      vo_sg_pais           OUT      tyt_sg_pais,
      vo_fir_email         OUT      tyt_fir_email,
      vo_fir_obs           OUT      tyt_fir_obs,
      vo_cod_status        OUT      tyt_cod_status,
      vi_fir_cod           IN       t_fir_cod,
      vi_tip_cnpj_cpf      IN       t_tip_cnpj_cpf,
      vi_fir_cnpj          IN       t_fir_cnpj,
      vi_fir_nome          IN       t_fir_nome,
      vi_fir_obs           IN       t_fir_obs,
      vi_cod_status        IN       t_cod_status
   )
   AS
      CURSOR c_cursor
      IS
         SELECT *
           FROM ifrbde.viw_firma_sipreco
          WHERE fir_cod = vi_fir_cod;

      v_viw_firma_sipreco   ifrbde.tab_firma%ROWTYPE;
      v_fir_cod             ifrbde.viw_firma_sipreco.fir_cod%TYPE;
      v_tip_cnpj_cpf        ifrbde.viw_firma_sipreco.tip_cnpj_cpf%TYPE;
      v_fir_cnpj            ifrbde.viw_firma_sipreco.fir_cnpj%TYPE;
      v_fir_nome            ifrbde.viw_firma_sipreco.fir_nome%TYPE;
      v_fir_obs             ifrbde.viw_firma_sipreco.fir_obs%TYPE;
      v_cod_status          ifrbde.viw_firma_sipreco.cod_status%TYPE;
      v_dado                VARCHAR2 (4000)                              := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_FIRMA_SIPRECO',
            'ALTERA'
         )
      THEN
         IF RTRIM (LTRIM (vi_cod_status)) = '0'
         THEN
            
-- inclui se for do cadastro da financeira ou licitação

            v_fir_cod := 0;
            ifrbde.prc_prox_numero_firma (v_fir_cod);
            v_tip_cnpj_cpf := RTRIM (LTRIM (vi_tip_cnpj_cpf));
            v_fir_cnpj := RTRIM (LTRIM (vi_fir_cnpj));
            v_fir_nome := RTRIM (LTRIM (vi_fir_nome));
            v_fir_obs := RTRIM (LTRIM (vi_fir_obs));
            v_cod_status := RTRIM (LTRIM (vi_cod_status));

            INSERT INTO ifrbde.tab_firma
                        (fir_cod, tip_cnpj_cpf, fir_cnpj, fir_nome,
                         fir_obs, cod_status)
                 VALUES (v_fir_cod, v_tip_cnpj_cpf, v_fir_cnpj, v_fir_nome,
                         v_fir_obs, v_cod_status);

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_firma_sipreco (
                  p_usuario,
                  vo_fir_cod,
                  vo_tip_cnpj_cpf,
                  vo_fir_cnpj,
                  vo_fir_nome,
                  vo_fir_razao,
                  vo_fir_contato,
                  vo_dsc_endereco,
                  vo_dsc_complemento,
                  vo_dsc_bairro,
                  vo_dsc_cidade,
                  vo_num_cep,
                  vo_fir_fone,
                  vo_fir_fax,
                  vo_sg_uf,
                  vo_sg_pais,
                  vo_fir_email,
                  vo_fir_obs,
                  vo_cod_status,
                  v_fir_cod
               );
               v_dado :=    'fir_cod = '
                         || TO_CHAR (v_fir_cod);
               v_dado :=    v_dado
                         || ','
                         || 'tip_cnpj_cpf = '
                         || RTRIM (LTRIM (v_tip_cnpj_cpf));
               v_dado :=
                      v_dado
                   || ','
                   || 'fir_cnpj = '
                   || RTRIM (LTRIM (v_fir_cnpj));
               v_dado :=
                      v_dado
                   || ','
                   || 'fir_nome = '
                   || RTRIM (LTRIM (v_fir_nome));
               v_dado :=
                        v_dado
                     || ','
                     || 'fir_obs = '
                     || RTRIM (LTRIM (v_fir_obs));
               v_dado :=    v_dado
                         || ','
                         || 'cod_status = '
                         || RTRIM (LTRIM (v_cod_status));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_FIRMA_SIPRECO',
                  'I',
                  v_dado
               );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error (
                  -20100,
                  'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
               );
            END IF;
         
-- fim da inclusão automatica            
         ELSE
            
-- executa a alteração se já for do cadastro do sipreco
            OPEN c_cursor;
            FETCH c_cursor INTO v_viw_firma_sipreco;

            IF NOT c_cursor%NOTFOUND
            THEN
               v_tip_cnpj_cpf := RTRIM (LTRIM (vi_tip_cnpj_cpf));
               v_fir_cnpj := RTRIM (LTRIM (vi_fir_cnpj));
               v_fir_nome := RTRIM (LTRIM (vi_fir_nome));
               v_fir_obs := RTRIM (LTRIM (vi_fir_obs));
               v_cod_status := RTRIM (LTRIM (vi_cod_status));
               v_fir_cod := vi_fir_cod;

               UPDATE ifrbde.tab_firma
                  SET tip_cnpj_cpf = v_tip_cnpj_cpf,
                      fir_cnpj = v_fir_cnpj,
                      fir_nome = v_fir_nome,
                      fir_obs = v_fir_obs,
                      cod_status = v_cod_status
                WHERE fir_cod = v_fir_cod;

               IF SQL%ROWCOUNT = 1
               THEN
                  stp_pesquisa_firma_sipreco (
                     p_usuario,
                     vo_fir_cod,
                     vo_tip_cnpj_cpf,
                     vo_fir_cnpj,
                     vo_fir_nome,
                     vo_fir_razao,
                     vo_fir_contato,
                     vo_dsc_endereco,
                     vo_dsc_complemento,
                     vo_dsc_bairro,
                     vo_dsc_cidade,
                     vo_num_cep,
                     vo_fir_fone,
                     vo_fir_fax,
                     vo_sg_uf,
                     vo_sg_pais,
                     vo_fir_email,
                     vo_fir_obs,
                     vo_cod_status,
                     vi_fir_cod
                  );
                  v_dado :=    'fir_cod = '
                            || TO_CHAR (v_fir_cod);
                  v_dado :=    v_dado
                            || ','
                            || 'tip_cnpj_cpf = '
                            || RTRIM (LTRIM (v_tip_cnpj_cpf));
                  v_dado :=    v_dado
                            || ','
                            || 'fir_cnpj = '
                            || RTRIM (LTRIM (v_fir_cnpj));
                  v_dado :=    v_dado
                            || ','
                            || 'fir_nome = '
                            || RTRIM (LTRIM (v_fir_nome));
                  v_dado :=
                        v_dado
                     || ','
                     || 'fir_obs = '
                     || RTRIM (LTRIM (v_fir_obs));
                  v_dado :=    v_dado
                            || ','
                            || 'cod_status = '
                            || RTRIM (LTRIM (v_cod_status));
                  -- LOG
                  ifrseg.pck_seguranca.stp_log (
                     p_usuario,
                     'VIW_FIRMA_SIPRECO',
                     'A',
                     v_dado
                  );
                  COMMIT;
               ELSE
                  ROLLBACK;
                  raise_application_error (
                     -20100,
                     'Mais de um registro solicitado para alteração. Operação não realizada!!!'
                  );
               END IF;
            ELSE
               raise_application_error (
                  -20100,
                  'Registro não foi encontrado para alteração!!!'
               );
            END IF;
         -- fim da alteração         
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para alteração!!!'
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrbde.pck_contrato TO bde_geral
/
-- End of DDL Script for Package Body IFRBDE.PCK_CONTRATO

