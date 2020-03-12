/* Formatted on 2006/03/14 09:53 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_viw_carencia
IS
--------------------------------------------------------------------
 -- Pesquisa Cadastro de Carências
 -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_carencia (
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_cod                    IN       t_cre_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CARENCIA',
                                             'PESQUISA'
                                            )
      THEN
         SELECT cre_cod, cre_dep_cod,
                num_prioridade_superint,
                num_prioridade_carencia, cre_projeto,
                num_seq_pessoal_carencia, cre_desc,
                cre_justificativa, cre_aen_subcod,
                cre_ntf_cod, cod_detalhe_cliente,
                cre_prazo, cre_inicio, cre_termino,
                cre_data, cre_vlobras, cre_valor_aprov,
                cre_valor_pago, num_situacao_carencia,
                dsc_critica_carencia, cre_tipo
           INTO vo_cre_cod (1), vo_cre_dep_cod (1),
                vo_num_prioridade_superint (1),
                vo_num_prioridade_carencia (1), vo_cre_projeto (1),
                vo_num_seq_pessoal_carencia (1), vo_cre_desc (1),
                vo_cre_justificativa (1), vo_cre_aen_subcod (1),
                vo_cre_ntf_cod (1), vo_cod_detalhe_cliente (1),
                vo_cre_prazo (1), vo_cre_inicio (1), vo_cre_termino (1),
                vo_cre_data (1), vo_cre_vlobras (1), vo_cre_valor_aprov (1),
                vo_cre_valor_pago (1), vo_num_situacao_carencia (1),
                vo_dsc_critica_carencia (1), vo_cre_tipo (1)
           FROM ifrbde.viw_carencia
          WHERE cre_cod = vi_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Carências
   -- retorna o OK ou não
   PROCEDURE stp_exclui_carencia (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_cre_cod   IN       t_cre_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_carencia
              WHERE cre_cod = vi_cre_cod
         FOR UPDATE;

      v_viw_carencia   ifrbde.viw_carencia%ROWTYPE;
      v_dado           VARCHAR2 (4000)               := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CARENCIA',
                                             'EXCLUI'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_carencia;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'cre_cod = ' || TO_CHAR (v_viw_carencia.cre_cod);
            v_dado :=
                  v_dado
               || ','
               || 'cre_dep_cod = '
               || TO_CHAR (v_viw_carencia.cre_dep_cod);
            v_dado :=
                  v_dado
               || ','
               || 'num_prioridade_superint = '
               || TO_CHAR (v_viw_carencia.num_prioridade_superint);
            v_dado :=
                  v_dado
               || ','
               || 'num_prioridade_carencia = '
               || TO_CHAR (v_viw_carencia.num_prioridade_carencia);
            v_dado :=
                  v_dado
               || ','
               || 'cre_projeto = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_projeto)));
            v_dado :=
                  v_dado
               || ','
               || 'num_seq_pessoal_carencia = '
               || TO_CHAR (v_viw_carencia.num_seq_pessoal_carencia);
            v_dado :=
                  v_dado
               || ','
               || 'cre_desc = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_desc)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_justificativa = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_justificativa)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_aen_subcod = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_aen_subcod)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_ntf_cod = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_ntf_cod)));
            v_dado :=
                  v_dado
               || ','
               || 'cod_detalhe_cliente = '
               || TO_CHAR (v_viw_carencia.cod_detalhe_cliente);
            v_dado :=
                  v_dado
               || ','
               || 'cre_prazo = '
               || TO_CHAR (v_viw_carencia.cre_prazo);
            v_dado :=
                  v_dado
               || ','
               || 'cre_inicio = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_inicio)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_termino = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_termino)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_data = '
               || TO_DATE (v_viw_carencia.cre_data, 'DD/MM/YYYY');
            v_dado :=
                  v_dado
               || ','
               || 'cre_vlobras = '
               || TO_CHAR (v_viw_carencia.cre_vlobras);
            v_dado :=
                  v_dado
               || ','
               || 'num_situacao_carencia = '
               || TO_CHAR (v_viw_carencia.num_situacao_carencia);
            v_dado :=
                  v_dado
               || ','
               || 'dsc_critica_carencia = '
               || RTRIM (LTRIM (UPPER (v_viw_carencia.dsc_critica_carencia)));
            v_dado :=
                  v_dado
               || ','
               || 'cre_tipo = '
               || TO_CHAR (v_viw_carencia.cre_tipo);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CARENCIA',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_carencia
                     WHERE CURRENT OF c_cursor;

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
-- Inclui Cadastro de Carências
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_carencia (
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_num_prioridade_superint    IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia    IN       t_num_prioridade_carencia,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente        IN       t_cod_detalhe_cliente,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_vlobras                IN       t_cre_vlobras,
      vi_num_situacao_carencia      IN       t_num_situacao_carencia,
      vi_cre_tipo                   IN       t_cre_tipo
   )
   AS
      v_cre_cod                    viw_carencia.cre_cod%TYPE;
      v_cre_dep_cod                viw_carencia.cre_dep_cod%TYPE;
      v_num_prioridade_superint    viw_carencia.num_prioridade_superint%TYPE;
      v_num_prioridade_carencia    viw_carencia.num_prioridade_carencia%TYPE;
      v_cre_projeto                viw_carencia.cre_projeto%TYPE;
      v_num_seq_pessoal_carencia   viw_carencia.num_seq_pessoal_carencia%TYPE;
      v_cre_desc                   viw_carencia.cre_desc%TYPE;
      v_cre_justificativa          viw_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod             viw_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                viw_carencia.cre_ntf_cod%TYPE;
      v_cod_detalhe_cliente        viw_carencia.cod_detalhe_cliente%TYPE;
      v_cre_prazo                  viw_carencia.cre_prazo%TYPE;
      v_cre_inicio                 viw_carencia.cre_inicio%TYPE;
      v_cre_termino                viw_carencia.cre_termino%TYPE;
      v_cre_data                   viw_carencia.cre_data%TYPE;
      v_cre_vlobras                viw_carencia.cre_vlobras%TYPE;
      v_num_situacao_carencia      viw_carencia.num_situacao_carencia%TYPE;
      v_cre_tipo                   viw_carencia.cre_tipo%TYPE;
      v_dado                       VARCHAR2 (4000)                    := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CARENCIA',
                                             'INCLUI'
                                            )
      THEN
         SELECT seq_cre_cod.NEXTVAL
           INTO v_cre_cod
           FROM DUAL;

         v_cre_projeto := RTRIM (LTRIM (vi_cre_projeto));
         v_cre_desc := RTRIM (LTRIM (vi_cre_desc));
         v_cre_justificativa := RTRIM (LTRIM (vi_cre_justificativa));
         v_cre_aen_subcod := RTRIM (LTRIM (vi_cre_aen_subcod));
         v_cre_ntf_cod := RTRIM (LTRIM (vi_cre_ntf_cod));
         v_cre_inicio := RTRIM (LTRIM (vi_cre_inicio));
         v_cre_termino := RTRIM (LTRIM (vi_cre_termino));
         v_cre_data := TO_DATE (vi_cre_data, 'DD/MM/YYYY');
         v_cre_dep_cod := vi_cre_dep_cod;
         v_num_prioridade_superint := vi_num_prioridade_superint;
         v_num_prioridade_carencia := vi_num_prioridade_carencia;
         v_num_seq_pessoal_carencia := vi_num_seq_pessoal_carencia;
         v_cod_detalhe_cliente := vi_cod_detalhe_cliente;
         v_cre_prazo := vi_cre_prazo;
         v_cre_vlobras := vi_cre_vlobras;
         v_num_situacao_carencia := vi_num_situacao_carencia;
         v_cre_tipo := vi_cre_tipo;

         INSERT INTO ifrbde.viw_carencia
                     (cre_cod, cre_dep_cod, num_prioridade_superint,
                      num_prioridade_carencia, cre_projeto,
                      num_seq_pessoal_carencia, cre_desc,
                      cre_justificativa, cre_aen_subcod, cre_ntf_cod,
                      cod_detalhe_cliente, cre_prazo, cre_inicio,
                      cre_termino, cre_data, cre_vlobras,
                      num_situacao_carencia, cre_tipo
                     )
              VALUES (v_cre_cod, v_cre_dep_cod, v_num_prioridade_superint,
                      v_num_prioridade_carencia, v_cre_projeto,
                      v_num_seq_pessoal_carencia, v_cre_desc,
                      v_cre_justificativa, v_cre_aen_subcod, v_cre_ntf_cod,
                      v_cod_detalhe_cliente, v_cre_prazo, v_cre_inicio,
                      v_cre_termino, v_cre_data, v_cre_vlobras,
                      v_num_situacao_carencia, v_cre_tipo
                     );

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_carencia (p_usuario,
                                   vo_cre_cod,
                                   vo_cre_dep_cod,
                                   vo_num_prioridade_superint,
                                   vo_num_prioridade_carencia,
                                   vo_cre_projeto,
                                   vo_num_seq_pessoal_carencia,
                                   vo_cre_desc,
                                   vo_cre_justificativa,
                                   vo_cre_aen_subcod,
                                   vo_cre_ntf_cod,
                                   vo_cod_detalhe_cliente,
                                   vo_cre_prazo,
                                   vo_cre_inicio,
                                   vo_cre_termino,
                                   vo_cre_data,
                                   vo_cre_vlobras,
                                   vo_cre_valor_aprov,
                                   vo_cre_valor_pago,
                                   vo_num_situacao_carencia,
                                   vo_dsc_critica_carencia,
                                   vo_cre_tipo,
                                   v_cre_cod
                                  );
            v_dado := 'cre_cod = ' || TO_CHAR (v_cre_cod);
            v_dado :=
                  v_dado || ',' || 'cre_dep_cod = ' || TO_CHAR (v_cre_dep_cod);
            v_dado :=
                  v_dado
               || ','
               || 'num_prioridade_superint = '
               || TO_CHAR (v_num_prioridade_superint);
            v_dado :=
                  v_dado
               || ','
               || 'num_prioridade_carencia = '
               || TO_CHAR (v_num_prioridade_carencia);
            v_dado :=
               v_dado || ',' || 'cre_projeto = '
               || RTRIM (LTRIM (v_cre_projeto));
            v_dado :=
                  v_dado
               || ','
               || 'num_seq_pessoal_carencia = '
               || TO_CHAR (v_num_seq_pessoal_carencia);
            v_dado :=
                  v_dado || ',' || 'cre_desc = ' || RTRIM (LTRIM (v_cre_desc));
            v_dado :=
                  v_dado
               || ','
               || 'cre_justificativa = '
               || RTRIM (LTRIM (v_cre_justificativa));
            v_dado :=
                  v_dado
               || ','
               || 'cre_aen_subcod = '
               || RTRIM (LTRIM (v_cre_aen_subcod));
            v_dado :=
               v_dado || ',' || 'cre_ntf_cod = '
               || RTRIM (LTRIM (v_cre_ntf_cod));
            v_dado :=
                  v_dado
               || ','
               || 'cod_detalhe_cliente = '
               || TO_CHAR (v_cod_detalhe_cliente);
            v_dado := v_dado || ',' || 'cre_prazo = ' || TO_CHAR (v_cre_prazo);
            v_dado :=
               v_dado || ',' || 'cre_inicio = '
               || RTRIM (LTRIM (v_cre_inicio));
            v_dado :=
               v_dado || ',' || 'cre_termino = '
               || RTRIM (LTRIM (v_cre_termino));
            v_dado :=
                  v_dado
               || ','
               || 'cre_data = '
               || TO_CHAR (v_cre_data, 'DD/MM/YYYY');
            v_dado :=
                  v_dado || ',' || 'cre_vlobras = ' || TO_CHAR (v_cre_vlobras);
            v_dado :=
                  v_dado
               || ','
               || 'num_situacao_carencia = '
               || TO_CHAR (v_num_situacao_carencia);
            v_dado := v_dado || ',' || 'cre_tipo = ' || TO_CHAR (v_cre_tipo);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CARENCIA',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error
               (-20100,
                'Mais de um registro solicitado para inclusão. Operação não realizada!!!'
               );
         END IF;
      ELSE
         raise_application_error
                              (-20100,
                               'Não foi concedida permissão para inclusão!!!'
                              );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Cadastro de Carências
-- retorna o recordset correspondente
   PROCEDURE stp_altera_carencia (
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_cod                    IN       t_cre_cod,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_num_prioridade_superint    IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia    IN       t_num_prioridade_carencia,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente        IN       t_cod_detalhe_cliente,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_vlobras                IN       t_cre_vlobras,
      vi_num_situacao_carencia      IN       t_num_situacao_carencia,
      vi_cre_tipo                   IN       t_cre_tipo
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_carencia
              WHERE cre_cod = vi_cre_cod
         FOR UPDATE;

      v_viw_carencia               ifrbde.viw_carencia%ROWTYPE;
      v_cre_cod                    ifrbde.viw_carencia.cre_cod%TYPE;
      v_cre_dep_cod                ifrbde.viw_carencia.cre_dep_cod%TYPE;
      v_num_prioridade_superint    ifrbde.viw_carencia.num_prioridade_superint%TYPE;
      v_num_prioridade_carencia    ifrbde.viw_carencia.num_prioridade_carencia%TYPE;
      v_cre_projeto                ifrbde.viw_carencia.cre_projeto%TYPE;
      v_num_seq_pessoal_carencia   ifrbde.viw_carencia.num_seq_pessoal_carencia%TYPE;
      v_cre_desc                   ifrbde.viw_carencia.cre_desc%TYPE;
      v_cre_justificativa          ifrbde.viw_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod             ifrbde.viw_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                ifrbde.viw_carencia.cre_ntf_cod%TYPE;
      v_cod_detalhe_cliente        ifrbde.viw_carencia.cod_detalhe_cliente%TYPE;
      v_cre_prazo                  ifrbde.viw_carencia.cre_prazo%TYPE;
      v_cre_inicio                 ifrbde.viw_carencia.cre_inicio%TYPE;
      v_cre_termino                ifrbde.viw_carencia.cre_termino%TYPE;
      v_cre_data                   ifrbde.viw_carencia.cre_data%TYPE;
      v_cre_vlobras                ifrbde.viw_carencia.cre_vlobras%TYPE;
      v_num_situacao_carencia      ifrbde.viw_carencia.num_situacao_carencia%TYPE;
      v_cre_tipo                   ifrbde.viw_carencia.cre_tipo%TYPE;
      v_dado                       VARCHAR2 (4000)                    := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CARENCIA',
                                             'ALTERA'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_carencia;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cre_projeto := RTRIM (LTRIM (vi_cre_projeto));
            v_cre_desc := RTRIM (LTRIM (vi_cre_desc));
            v_cre_justificativa := RTRIM (LTRIM (vi_cre_justificativa));
            v_cre_aen_subcod := RTRIM (LTRIM (vi_cre_aen_subcod));
            v_cre_ntf_cod := RTRIM (LTRIM (vi_cre_ntf_cod));
            v_cre_inicio := RTRIM (LTRIM (vi_cre_inicio));
            v_cre_termino := RTRIM (LTRIM (vi_cre_termino));
            v_cre_data := TO_DATE (vi_cre_data, 'DD/MM/YYYY');
            v_cre_cod := vi_cre_cod;
            v_cre_dep_cod := vi_cre_dep_cod;
            v_num_prioridade_superint := vi_num_prioridade_superint;
            v_num_prioridade_carencia := vi_num_prioridade_carencia;
            v_num_seq_pessoal_carencia := vi_num_seq_pessoal_carencia;
            v_cod_detalhe_cliente := vi_cod_detalhe_cliente;
            v_cre_prazo := vi_cre_prazo;
            v_cre_vlobras := vi_cre_vlobras;
            v_num_situacao_carencia := vi_num_situacao_carencia;
            v_cre_tipo := vi_cre_tipo;

            UPDATE ifrbde.viw_carencia
               SET cre_dep_cod = v_cre_dep_cod,
                   num_prioridade_superint = v_num_prioridade_superint,
                   num_prioridade_carencia = v_num_prioridade_carencia,
                   cre_projeto = v_cre_projeto,
                   num_seq_pessoal_carencia = v_num_seq_pessoal_carencia,
                   cre_desc = v_cre_desc,
                   cre_justificativa = v_cre_justificativa,
                   cre_aen_subcod = v_cre_aen_subcod,
                   cre_ntf_cod = v_cre_ntf_cod,
                   cod_detalhe_cliente = v_cod_detalhe_cliente,
                   cre_prazo = v_cre_prazo,
                   cre_inicio = v_cre_inicio,
                   cre_termino = v_cre_termino,
                   cre_data = v_cre_data,
                   cre_vlobras = v_cre_vlobras,
                   num_situacao_carencia = v_num_situacao_carencia,
                   cre_tipo = v_cre_tipo
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_carencia (p_usuario,
                                      vo_cre_cod,
                                      vo_cre_dep_cod,
                                      vo_num_prioridade_superint,
                                      vo_num_prioridade_carencia,
                                      vo_cre_projeto,
                                      vo_num_seq_pessoal_carencia,
                                      vo_cre_desc,
                                      vo_cre_justificativa,
                                      vo_cre_aen_subcod,
                                      vo_cre_ntf_cod,
                                      vo_cod_detalhe_cliente,
                                      vo_cre_prazo,
                                      vo_cre_inicio,
                                      vo_cre_termino,
                                      vo_cre_data,
                                      vo_cre_vlobras,
                                      vo_cre_valor_aprov,
                                      vo_cre_valor_pago,
                                      vo_num_situacao_carencia,
                                      vo_dsc_critica_carencia,
                                      vo_cre_tipo,
                                      vi_cre_cod
                                     );
               v_dado := 'cre_cod = ' || TO_CHAR (v_cre_cod);
               v_dado :=
                  v_dado || ',' || 'cre_dep_cod = ' || TO_CHAR (v_cre_dep_cod);
               v_dado :=
                     v_dado
                  || ','
                  || 'num_prioridade_superint = '
                  || TO_CHAR (v_num_prioridade_superint);
               v_dado :=
                     v_dado
                  || ','
                  || 'num_prioridade_carencia = '
                  || TO_CHAR (v_num_prioridade_carencia);
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_projeto = '
                  || RTRIM (LTRIM (v_cre_projeto));
               v_dado :=
                     v_dado
                  || ','
                  || 'num_seq_pessoal_carencia = '
                  || TO_CHAR (v_num_seq_pessoal_carencia);
               v_dado :=
                  v_dado || ',' || 'cre_desc = ' || RTRIM (LTRIM (v_cre_desc));
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_justificativa = '
                  || RTRIM (LTRIM (v_cre_justificativa));
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_aen_subcod = '
                  || RTRIM (LTRIM (v_cre_aen_subcod));
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_ntf_cod = '
                  || RTRIM (LTRIM (v_cre_ntf_cod));
               v_dado :=
                     v_dado
                  || ','
                  || 'cod_detalhe_cliente = '
                  || TO_CHAR (v_cod_detalhe_cliente);
               v_dado :=
                      v_dado || ',' || 'cre_prazo = ' || TO_CHAR (v_cre_prazo);
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_inicio = '
                  || RTRIM (LTRIM (v_cre_inicio));
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_termino = '
                  || RTRIM (LTRIM (v_cre_termino));
               v_dado :=
                     v_dado
                  || ','
                  || 'cre_data = '
                  || TO_CHAR (v_cre_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado || ',' || 'cre_vlobras = ' || TO_CHAR (v_cre_vlobras);
               v_dado :=
                     v_dado
                  || ','
                  || 'num_situacao_carencia = '
                  || TO_CHAR (v_num_situacao_carencia);
               v_dado :=
                        v_dado || ',' || 'cre_tipo = ' || TO_CHAR (v_cre_tipo);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CARENCIA',
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

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_viw_carencia TO bde_geral
/
