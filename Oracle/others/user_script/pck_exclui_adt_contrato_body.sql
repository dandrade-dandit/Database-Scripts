/* Formatted on 2007/01/03 11:06 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_exclui_adt_contrato
IS
--------------------------------------------------------------------
--- VIW_EXCLUI_TERMO_ADITIVO
--- ************* ATENÇÃO *************
-- PROCEDURE MODIFICADA NA ALTERAÇÃO
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
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
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
      p_usuario                       IN       VARCHAR2,
      vo_ok                           OUT      tyt_ok,
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
                AND num_versao_contrato_res_ex = vi_num_versao_contrato_res_ex
         FOR UPDATE;

      v_viw_exclui_termo_aditivo   ifrbde.viw_exclui_termo_aditivo%ROWTYPE;
      v_dado                       VARCHAR2 (4000)                     := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_EXCLUI_TERMO_ADITIVO',
                                             'EXCLUI'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_exclui_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=
                  'cnt_cre_cod_res_ex = '
               || TO_CHAR (v_viw_exclui_termo_aditivo.cnt_cre_cod_res_ex);
            v_dado :=
                  v_dado
               || ','
               || 'cnt_cod_res_ex = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_exclui_termo_aditivo.cnt_cod_res_ex)
                             )
                      );
            v_dado :=
                  v_dado
               || ','
               || 'num_versao_contrato_res_ex = '
               || RTRIM
                     (LTRIM
                         (UPPER
                             (v_viw_exclui_termo_aditivo.num_versao_contrato_res_ex
                             )
                         )
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
--
               ifrbde.prc_exclui_termo_adt
                       (v_viw_exclui_termo_aditivo.cnt_cod_res_ex,
                        v_viw_exclui_termo_aditivo.num_versao_contrato_res_ex
                       );
--
            -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_EXCLUI_TERMO_ADITIVO',
                                             'E',
                                             v_dado
                                            );

--
--         DELETE FROM IFRBDE.viw_exclui_termo_aditivo
--         WHERE  CURRENT OF c_cursor ;
--
               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
                  raise_application_error
                     (-20100,
                      'Mais de um registro solicitado para exclusão. Operação não realizada!!!'
                     );
               END IF;
            END IF;
         ELSE
            raise_application_error
                              (-20100,
                               'Registro não foi encontrado para exclusão!!!'
                              );
         END IF;
      ELSE
         raise_application_error
                              (-20100,
                               'Não foi concedida permissão para exclusão!!!'
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
      v_dado                         VARCHAR2 (4000)                   := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_EXCLUI_TERMO_ADITIVO',
                                             'ALTERA'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_exclui_termo_aditivo;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cnt_cod_res_ex := RTRIM (LTRIM (vi_cnt_cod_res_ex));
            v_num_versao_contrato_res_ex :=
                                RTRIM (LTRIM (vi_num_versao_contrato_res_ex));
            v_cnt_cre_cod_res_ex := vi_cnt_cre_cod_res_ex;
--
            ifrbde.prc_exclui_termo_adt
                       (v_viw_exclui_termo_aditivo.cnt_cod_res_ex,
                        v_viw_exclui_termo_aditivo.num_versao_contrato_res_ex
                       );

--
/*
            UPDATE ifrbde.viw_exclui_termo_aditivo
               SET num_versao_contrato_res_ex = v_num_versao_contrato_res_ex
             WHERE CURRENT OF c_cursor;
*/
            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_exclui_termo_adit (p_usuario,
                                               vo_cnt_cre_cod_res_ex,
                                               vo_cnt_cod_res_ex,
                                               vo_num_versao_contrato_res_ex,
                                               vi_cnt_cre_cod_res_ex,
                                               vi_cnt_cod_res_ex
                                              );
               v_dado :=
                     'cnt_cre_cod_res_ex = ' || TO_CHAR (v_cnt_cre_cod_res_ex);
               v_dado :=
                     v_dado
                  || ','
                  || 'cnt_cod_res_ex = '
                  || RTRIM (LTRIM (v_cnt_cod_res_ex));
               v_dado :=
                     v_dado
                  || ','
                  || 'num_versao_contrato_res_ex = '
                  || RTRIM (LTRIM (v_num_versao_contrato_res_ex));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_EXCLUI_TERMO_ADITIVO',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error
                  (-20100,
                   'Mais de um registro solicitado para alteração. Operação não realizada!!!'
                  );
            END IF;
         ELSE
            raise_application_error
                             (-20100,
                              'Registro não foi encontrado para alteração!!!'
                             );
         END IF;
      ELSE
         raise_application_error
                             (-20100,
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

