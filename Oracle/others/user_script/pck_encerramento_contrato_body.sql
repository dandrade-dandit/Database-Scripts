/* Formatted on 2007/01/05 14:54 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_encerramento_contrato
IS
--------------------------------------------------------------------
--------------------------------------------------------------------
-- Pesquisa Encerramento de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_encerramento_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo       OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre   OUT      tyt_cnt_justificativa_cre,
      vo_cnt_ice_cod             OUT      tyt_cnt_ice_cod,
      vo_cnt_data                OUT      tyt_cnt_data,
      vo_cnt_data_proposta       OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio         OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec          OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses    OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit          OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato    OUT      tyt_dat_termino_contrato,
      vo_cnt_valor_compromisso   OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo         OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago          OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj          OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago     OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor               OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ENCERRAMENTO_CONTRATO',
                                             'PESQUISA'
                                            )
      THEN
         SELECT num_seq_contrato, cnt_cre_cod, cnt_cod,
                num_versao_contrato, num_termo_aditivo,
                cod_dep_contrato, cnt_justificativa_cre,
                cnt_ice_cod, cnt_data,
                cnt_data_proposta, cnt_data_inicio,
                cnt_prazo_exec, num_prazo_exec_meses,
                cnt_prazo_adit, dat_termino_contrato,
                cnt_valor_compromisso, cnt_valor_termo,
                cnt_valor_pago, cnt_valor_reaj,
                cnt_valor_reaj_pago, cnt_valor,
                tip_situacao_contrato, tip_contrato,
                dsc_critica_contrato
           INTO vo_num_seq_contrato (1), vo_cnt_cre_cod (1), vo_cnt_cod (1),
                vo_num_versao_contrato (1), vo_num_termo_aditivo (1),
                vo_cod_dep_contrato (1), vo_cnt_justificativa_cre (1),
                vo_cnt_ice_cod (1), vo_cnt_data (1),
                vo_cnt_data_proposta (1), vo_cnt_data_inicio (1),
                vo_cnt_prazo_exec (1), vo_num_prazo_exec_meses (1),
                vo_cnt_prazo_adit (1), vo_dat_termino_contrato (1),
                vo_cnt_valor_compromisso (1), vo_cnt_valor_termo (1),
                vo_cnt_valor_pago (1), vo_cnt_valor_reaj (1),
                vo_cnt_valor_reaj_pago (1), vo_cnt_valor (1),
                vo_tip_situacao_contrato (1), vo_tip_contrato (1),
                vo_dsc_critica_contrato (1)
           FROM ifrbde.viw_encerramento_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato
            AND cnt_cre_cod = vi_cnt_cre_cod;

         IF vo_tip_situacao_contrato (1) <> 3
         THEN
            vo_dsc_critica_contrato (1) := NULL;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Encerramento de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_encerramento_contra (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo       OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre   OUT      tyt_cnt_justificativa_cre,
      vo_cnt_ice_cod             OUT      tyt_cnt_ice_cod,
      vo_cnt_data                OUT      tyt_cnt_data,
      vo_cnt_data_proposta       OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio         OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec          OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses    OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit          OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato    OUT      tyt_dat_termino_contrato,
      vo_cnt_valor_compromisso   OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo         OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago          OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj          OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago     OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor               OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_dsc_critica_contrato    IN       t_dsc_critica_contrato
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_encerramento_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_encerramento_contrato   ifrbde.viw_encerramento_contrato%ROWTYPE;
      v_num_seq_contrato            ifrbde.viw_encerramento_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                 ifrbde.viw_encerramento_contrato.cnt_cre_cod%TYPE;
      v_dsc_critica_contrato        ifrbde.viw_encerramento_contrato.dsc_critica_contrato%TYPE;
      v_dado                        VARCHAR2 (4000)                    := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ENCERRAMENTO_CONTRATO',
                                             'ALTERA'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_encerramento_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dsc_critica_contrato := RTRIM (LTRIM (vi_dsc_critica_contrato));
            v_num_seq_contrato := vi_num_seq_contrato;
            v_cnt_cre_cod := vi_cnt_cre_cod;

            v_dsc_critica_contrato:=
                         'Contrato Encerrado em '
                      || TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi')
                      || ' pelo usuário '
                      || USER
                      || ' com a justificativa : '
                      || TRIM (SUBSTR(v_dsc_critica_contrato,1,2000));

            UPDATE ifrbde.viw_encerramento_contrato
               SET dsc_critica_contrato = v_dsc_critica_contrato,
                   tip_situacao_contrato = 3
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_encerramento_cont (p_usuario,
                                               vo_num_seq_contrato,
                                               vo_cnt_cre_cod,
                                               vo_cnt_cod,
                                               vo_num_versao_contrato,
                                               vo_num_termo_aditivo,
                                               vo_cod_dep_contrato,
                                               vo_cnt_justificativa_cre,
                                               vo_cnt_ice_cod,
                                               vo_cnt_data,
                                               vo_cnt_data_proposta,
                                               vo_cnt_data_inicio,
                                               vo_cnt_prazo_exec,
                                               vo_num_prazo_exec_meses,
                                               vo_cnt_prazo_adit,
                                               vo_dat_termino_contrato,
                                               vo_cnt_valor_compromisso,
                                               vo_cnt_valor_termo,
                                               vo_cnt_valor_pago,
                                               vo_cnt_valor_reaj,
                                               vo_cnt_valor_reaj_pago,
                                               vo_cnt_valor,
                                               vo_tip_situacao_contrato,
                                               vo_tip_contrato,
                                               vo_dsc_critica_contrato,
                                               vi_num_seq_contrato,
                                               vi_cnt_cre_cod
                                              );
               v_dado := 'num_seq_contrato = ' || TO_CHAR (v_num_seq_contrato);
               v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
               v_dado :=
                     v_dado
                  || ','
                  || 'dsc_critica_contrato = '
                  || RTRIM (LTRIM (v_dsc_critica_contrato));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_ENCERRAMENTO_CONTRATO',
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
END;
/

