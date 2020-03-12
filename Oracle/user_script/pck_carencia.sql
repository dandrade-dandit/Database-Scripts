
-- Start of DDL Script for Package Body IFRBDE.PCK_CARENCIA
-- Generated 2-dez-2004 20:35:30 from SYSMAN@HOMOLOG2

CREATE OR REPLACE PACKAGE BODY ifrbde.pck_carencia
IS
   
--------------------------------------------------------------------
-- Pesquisa Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_APROVADO',
            'PESQUISA')
      THEN
         SELECT num_seq_carencia_rec,
                rap_cre_cod,
                rap_pgose,
                rap_rti_cod,
                rap_valor,
                rap_cre_pgi,
                rap_valor_pago,
                val_saldo_recurso
           INTO vo_num_seq_carencia_rec (1),
                vo_rap_cre_cod (1),
                vo_rap_pgose (1),
                vo_rap_rti_cod (1),
                vo_rap_valor (1),
                vo_rap_cre_pgi (1),
                vo_rap_valor_pago (1),
                vo_val_saldo_recurso (1)
           FROM ifrbde.tab_rec_aprovado
          WHERE num_seq_carencia_rec = vi_num_seq_carencia_rec
            AND rap_cre_cod = vi_rap_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Aprovação
   -- retorna o OK ou não
   PROCEDURE stp_exclui_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_rec_aprovado
              WHERE num_seq_carencia_rec = vi_num_seq_carencia_rec
                AND rap_cre_cod = vi_rap_cre_cod
         FOR UPDATE;

      v_tab_rec_aprovado            ifrbde.tab_rec_aprovado%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_APROVADO',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_aprovado;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'num_seq_carencia_rec = '
                      || TO_CHAR (v_tab_rec_aprovado.num_seq_carencia_rec);
            v_dado := v_dado || ',' || 'rap_cre_cod = '
                      || TO_CHAR (v_tab_rec_aprovado.rap_cre_cod);
            v_dado := v_dado || ',' || 'rap_pgose = '
                      || RTRIM (
                            LTRIM (UPPER (v_tab_rec_aprovado.rap_pgose) ) );
            v_dado := v_dado || ',' || 'rap_rti_cod = '
                      || RTRIM (
                            LTRIM (UPPER (v_tab_rec_aprovado.rap_rti_cod) ) );
            v_dado := v_dado || ',' || 'rap_valor = '
                      || TO_CHAR (v_tab_rec_aprovado.rap_valor);
            v_dado := v_dado || ',' || 'rap_cre_pgi = '
                      || RTRIM (
                            LTRIM (UPPER (v_tab_rec_aprovado.rap_cre_pgi) ) );
            v_dado := v_dado || ',' || 'rap_valor_pago = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_tab_rec_aprovado.rap_valor_pago) ) );
            v_dado :=
                  v_dado || ',' || 'val_saldo_recurso = '
                  || RTRIM (
                        LTRIM (UPPER (v_tab_rec_aprovado.val_saldo_recurso) ) );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_REC_APROVADO',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.tab_rec_aprovado
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
-- Inclui Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod             IN       t_rap_cre_cod,
      vi_rap_pgose               IN       t_rap_pgose,
      vi_rap_rti_cod             IN       t_rap_rti_cod,
      vi_rap_valor               IN       t_rap_valor,
      vi_rap_cre_pgi             IN       t_rap_cre_pgi,
      vi_rap_valor_pago          IN       t_rap_valor_pago,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso)
   AS
      v_num_seq_carencia_rec        tab_rec_aprovado.num_seq_carencia_rec%TYPE;
      v_rap_cre_cod                 tab_rec_aprovado.rap_cre_cod%TYPE;
      v_rap_pgose                   tab_rec_aprovado.rap_pgose%TYPE;
      v_rap_rti_cod                 tab_rec_aprovado.rap_rti_cod%TYPE;
      v_rap_valor                   tab_rec_aprovado.rap_valor%TYPE;
      v_rap_cre_pgi                 tab_rec_aprovado.rap_cre_pgi%TYPE;
      v_rap_valor_pago              tab_rec_aprovado.rap_valor_pago%TYPE;
      v_val_saldo_recurso           tab_rec_aprovado.val_saldo_recurso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_APROVADO',
            'INCLUI')
      THEN
         SELECT ifrbde.seq_num_seq_carencia.NEXTVAL
           INTO v_num_seq_carencia_rec
           FROM DUAL;

         v_rap_pgose := RTRIM (LTRIM (vi_rap_pgose) );
         v_rap_rti_cod := RTRIM (LTRIM (vi_rap_rti_cod) );
         v_rap_cre_pgi := RTRIM (LTRIM (vi_rap_cre_pgi) );
         v_rap_valor_pago := RTRIM (LTRIM (vi_rap_valor_pago) );
         v_val_saldo_recurso := RTRIM (LTRIM (vi_val_saldo_recurso) );
         v_rap_cre_cod := vi_rap_cre_cod;
         v_rap_valor := vi_rap_valor;

         INSERT INTO ifrbde.tab_rec_aprovado
                     (num_seq_carencia_rec,
                      rap_cre_cod,
                      rap_pgose,
                      rap_rti_cod,
                      rap_valor,
                      rap_cre_pgi,
                      rap_valor_pago,
                      val_saldo_recurso)
              VALUES (v_num_seq_carencia_rec,
                      v_rap_cre_cod,
                      v_rap_pgose,
                      v_rap_rti_cod,
                      v_rap_valor,
                      v_rap_cre_pgi,
                      v_rap_valor_pago,
                      v_val_saldo_recurso);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_rec_aprovado (
               p_usuario,
               vo_num_seq_carencia_rec,
               vo_rap_cre_cod,
               vo_rap_pgose,
               vo_rap_rti_cod,
               vo_rap_valor,
               vo_rap_cre_pgi,
               vo_rap_valor_pago,
               vo_val_saldo_recurso,
               v_num_seq_carencia_rec,
               v_rap_cre_cod);
            v_dado :=
                  'num_seq_carencia_rec = ' || TO_CHAR (
                                                  v_num_seq_carencia_rec);
            v_dado := v_dado || ',' || 'rap_cre_cod = ' || TO_CHAR (
                                                              v_rap_cre_cod);
            v_dado :=
                   v_dado || ',' || 'rap_pgose = ' || RTRIM (
                                                         LTRIM (v_rap_pgose) );
            v_dado :=
               v_dado || ',' || 'rap_rti_cod = ' || RTRIM (
                                                       LTRIM (v_rap_rti_cod) );
            v_dado := v_dado || ',' || 'rap_valor = ' || TO_CHAR (
                                                            v_rap_valor);
            v_dado :=
               v_dado || ',' || 'rap_cre_pgi = ' || RTRIM (
                                                       LTRIM (v_rap_cre_pgi) );
            v_dado := v_dado || ',' || 'rap_valor_pago = '
                      || RTRIM (LTRIM (v_rap_valor_pago) );
            v_dado := v_dado || ',' || 'val_saldo_recurso = '
                      || RTRIM (LTRIM (v_val_saldo_recurso) );
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'TAB_REC_APROVADO',
               'I',
               v_dado);
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
-- Altera Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod,
      vi_rap_pgose               IN       t_rap_pgose,
      vi_rap_rti_cod             IN       t_rap_rti_cod,
      vi_rap_valor               IN       t_rap_valor,
      vi_rap_cre_pgi             IN       t_rap_cre_pgi,
      vi_rap_valor_pago          IN       t_rap_valor_pago,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_rec_aprovado
              WHERE num_seq_carencia_rec = vi_num_seq_carencia_rec
                AND rap_cre_cod = vi_rap_cre_cod
         FOR UPDATE;

      v_tab_rec_aprovado            ifrbde.tab_rec_aprovado%ROWTYPE;
      v_num_seq_carencia_rec        ifrbde.tab_rec_aprovado.num_seq_carencia_rec%TYPE;
      v_rap_cre_cod                 ifrbde.tab_rec_aprovado.rap_cre_cod%TYPE;
      v_rap_pgose                   ifrbde.tab_rec_aprovado.rap_pgose%TYPE;
      v_rap_rti_cod                 ifrbde.tab_rec_aprovado.rap_rti_cod%TYPE;
      v_rap_valor                   ifrbde.tab_rec_aprovado.rap_valor%TYPE;
      v_rap_cre_pgi                 ifrbde.tab_rec_aprovado.rap_cre_pgi%TYPE;
      v_rap_valor_pago              ifrbde.tab_rec_aprovado.rap_valor_pago%TYPE;
      v_val_saldo_recurso           ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_APROVADO',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_aprovado;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_rap_pgose := RTRIM (LTRIM (vi_rap_pgose) );
            v_rap_rti_cod := RTRIM (LTRIM (vi_rap_rti_cod) );
            v_rap_cre_pgi := RTRIM (LTRIM (vi_rap_cre_pgi) );
            v_rap_valor_pago := RTRIM (LTRIM (vi_rap_valor_pago) );
            v_val_saldo_recurso := RTRIM (LTRIM (vi_val_saldo_recurso) );
            v_num_seq_carencia_rec := vi_num_seq_carencia_rec;
            v_rap_cre_cod := vi_rap_cre_cod;
            v_rap_valor := vi_rap_valor;

            UPDATE ifrbde.tab_rec_aprovado
               SET rap_pgose = v_rap_pgose,
                   rap_rti_cod = v_rap_rti_cod,
                   rap_valor = v_rap_valor,
                   rap_cre_pgi = v_rap_cre_pgi,
                   rap_valor_pago = v_rap_valor_pago,
                   val_saldo_recurso = v_val_saldo_recurso
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_rec_aprovado (
                  p_usuario,
                  vo_num_seq_carencia_rec,
                  vo_rap_cre_cod,
                  vo_rap_pgose,
                  vo_rap_rti_cod,
                  vo_rap_valor,
                  vo_rap_cre_pgi,
                  vo_rap_valor_pago,
                  vo_val_saldo_recurso,
                  vi_num_seq_carencia_rec,
                  vi_rap_cre_cod);
               v_dado :=
                  'num_seq_carencia_rec = ' || TO_CHAR (
                                                  v_num_seq_carencia_rec);
               v_dado :=
                      v_dado || ',' || 'rap_cre_cod = ' || TO_CHAR (
                                                              v_rap_cre_cod);
               v_dado :=
                   v_dado || ',' || 'rap_pgose = ' || RTRIM (
                                                         LTRIM (v_rap_pgose) );
               v_dado := v_dado || ',' || 'rap_rti_cod = '
                         || RTRIM (LTRIM (v_rap_rti_cod) );
               v_dado := v_dado || ',' || 'rap_valor = ' || TO_CHAR (
                                                               v_rap_valor);
               v_dado := v_dado || ',' || 'rap_cre_pgi = '
                         || RTRIM (LTRIM (v_rap_cre_pgi) );
               v_dado := v_dado || ',' || 'rap_valor_pago = '
                         || RTRIM (LTRIM (v_rap_valor_pago) );
               v_dado := v_dado || ',' || 'val_saldo_recurso = '
                         || RTRIM (LTRIM (v_val_saldo_recurso) );
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_REC_APROVADO',
                  'A',
                  v_dado);
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
-- Pesquisa Pré Compromisso
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_PRECOMPROVADO',
            'PESQUISA')
      THEN
         SELECT rpr_cre_cod,
                rpr_pgose,
                rpr_rti_cod,
                rpr_num,
                rpr_data,
                rpr_valor
           INTO vo_rpr_cre_cod (1),
                vo_rpr_pgose (1),
                vo_rpr_rti_cod (1),
                vo_rpr_num (1),
                vo_rpr_data (1),
                vo_rpr_valor (1)
           FROM ifrbde.tab_rec_precomprovado
          WHERE rpr_cre_cod = vi_rpr_cre_cod
            AND rpr_pgose = vi_rpr_pgose
            AND rpr_rti_cod = vi_rpr_rti_cod
            AND rpr_num = vi_rpr_num;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Pré Compromisso
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_rec_precomprovado
              WHERE rpr_cre_cod = vi_rpr_cre_cod
                AND rpr_pgose = vi_rpr_pgose
                AND rpr_rti_cod = vi_rpr_rti_cod
                AND rpr_num = vi_rpr_num
         FOR UPDATE;

      v_tab_rec_precomprovado       ifrbde.tab_rec_precomprovado%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_PRECOMPROVADO',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_precomprovado;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'rpr_cre_cod = '
                      || TO_CHAR (v_tab_rec_precomprovado.rpr_cre_cod);
            v_dado := v_dado || ',' || 'rpr_pgose = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_tab_rec_precomprovado.rpr_pgose) ) );
            v_dado :=
                  v_dado || ',' || 'rpr_rti_cod = '
                  || RTRIM (
                        LTRIM (UPPER (v_tab_rec_precomprovado.rpr_rti_cod) ) );
            v_dado := v_dado || ',' || 'rpr_num = '
                      || RTRIM (
                            LTRIM (UPPER (v_tab_rec_precomprovado.rpr_num) ) );
            v_dado := v_dado || ',' || 'rpr_data = '
                      || TO_DATE (
                            v_tab_rec_precomprovado.rpr_data,
                            'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'rpr_valor = '
                      || TO_CHAR (v_tab_rec_precomprovado.rpr_valor);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_REC_PRECOMPROVADO',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.tab_rec_precomprovado
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
-- Inclui Pré Compromisso
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num,
      vi_rpr_data                IN       t_rpr_data,
      vi_rpr_valor               IN       t_rpr_valor)
   AS
      v_rpr_cre_cod                 tab_rec_precomprovado.rpr_cre_cod%TYPE;
      v_rpr_pgose                   tab_rec_precomprovado.rpr_pgose%TYPE;
      v_rpr_rti_cod                 tab_rec_precomprovado.rpr_rti_cod%TYPE;
      v_rpr_num                     tab_rec_precomprovado.rpr_num%TYPE;
      v_rpr_data                    tab_rec_precomprovado.rpr_data%TYPE;
      v_rpr_valor                   tab_rec_precomprovado.rpr_valor%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_PRECOMPROVADO',
            'INCLUI')
      THEN
         v_rpr_pgose := RTRIM (LTRIM (vi_rpr_pgose) );
         v_rpr_rti_cod := RTRIM (LTRIM (vi_rpr_rti_cod) );
         v_rpr_num := RTRIM (LTRIM (vi_rpr_num) );
         v_rpr_data := TO_DATE (vi_rpr_data, 'DD/MM/YYYY');
         v_rpr_cre_cod := vi_rpr_cre_cod;
         v_rpr_valor := vi_rpr_valor;

         INSERT INTO ifrbde.tab_rec_precomprovado
                     (rpr_cre_cod,
                      rpr_pgose,
                      rpr_rti_cod,
                      rpr_num,
                      rpr_data,
                      rpr_valor)
              VALUES (v_rpr_cre_cod,
                      v_rpr_pgose,
                      v_rpr_rti_cod,
                      v_rpr_num,
                      v_rpr_data,
                      v_rpr_valor);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_rec_precomprovado (
               p_usuario,
               vo_rpr_cre_cod,
               vo_rpr_pgose,
               vo_rpr_rti_cod,
               vo_rpr_num,
               vo_rpr_data,
               vo_rpr_valor,
               v_rpr_cre_cod,
               v_rpr_pgose,
               v_rpr_rti_cod,
               v_rpr_num);
            v_dado := 'rpr_cre_cod = ' || TO_CHAR (v_rpr_cre_cod);
            v_dado :=
                   v_dado || ',' || 'rpr_pgose = ' || RTRIM (
                                                         LTRIM (v_rpr_pgose) );
            v_dado :=
               v_dado || ',' || 'rpr_rti_cod = ' || RTRIM (
                                                       LTRIM (v_rpr_rti_cod) );
            v_dado := v_dado || ',' || 'rpr_num = ' || RTRIM (
                                                          LTRIM (v_rpr_num) );
            v_dado :=
               v_dado || ',' || 'rpr_data = ' || TO_CHAR (
                                                    v_rpr_data,
                                                    'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'rpr_valor = ' || TO_CHAR (
                                                            v_rpr_valor);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'TAB_REC_PRECOMPROVADO',
               'I',
               v_dado);
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
-- Altera Pré Compromisso
-- retorna o recordset correspondente
   PROCEDURE stp_altera_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num,
      vi_rpr_data                IN       t_rpr_data,
      vi_rpr_valor               IN       t_rpr_valor)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.tab_rec_precomprovado
              WHERE rpr_cre_cod = vi_rpr_cre_cod
                AND rpr_pgose = vi_rpr_pgose
                AND rpr_rti_cod = vi_rpr_rti_cod
                AND rpr_num = vi_rpr_num
         FOR UPDATE;

      v_tab_rec_precomprovado       ifrbde.tab_rec_precomprovado%ROWTYPE;
      v_rpr_cre_cod                 ifrbde.tab_rec_precomprovado.rpr_cre_cod%TYPE;
      v_rpr_pgose                   ifrbde.tab_rec_precomprovado.rpr_pgose%TYPE;
      v_rpr_rti_cod                 ifrbde.tab_rec_precomprovado.rpr_rti_cod%TYPE;
      v_rpr_num                     ifrbde.tab_rec_precomprovado.rpr_num%TYPE;
      v_rpr_data                    ifrbde.tab_rec_precomprovado.rpr_data%TYPE;
      v_rpr_valor                   ifrbde.tab_rec_precomprovado.rpr_valor%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REC_PRECOMPROVADO',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_precomprovado;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_rpr_pgose := RTRIM (LTRIM (vi_rpr_pgose) );
            v_rpr_rti_cod := RTRIM (LTRIM (vi_rpr_rti_cod) );
            v_rpr_num := RTRIM (LTRIM (vi_rpr_num) );
            v_rpr_data := TO_DATE (vi_rpr_data, 'DD/MM/YYYY');
            v_rpr_cre_cod := vi_rpr_cre_cod;
            v_rpr_valor := vi_rpr_valor;

            UPDATE ifrbde.tab_rec_precomprovado
               SET rpr_data = v_rpr_data,
                   rpr_valor = v_rpr_valor
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_rec_precomprovado (
                  p_usuario,
                  vo_rpr_cre_cod,
                  vo_rpr_pgose,
                  vo_rpr_rti_cod,
                  vo_rpr_num,
                  vo_rpr_data,
                  vo_rpr_valor,
                  vi_rpr_cre_cod,
                  vi_rpr_pgose,
                  vi_rpr_rti_cod,
                  vi_rpr_num);
               v_dado := 'rpr_cre_cod = ' || TO_CHAR (v_rpr_cre_cod);
               v_dado :=
                   v_dado || ',' || 'rpr_pgose = ' || RTRIM (
                                                         LTRIM (v_rpr_pgose) );
               v_dado := v_dado || ',' || 'rpr_rti_cod = '
                         || RTRIM (LTRIM (v_rpr_rti_cod) );
               v_dado :=
                       v_dado || ',' || 'rpr_num = ' || RTRIM (
                                                           LTRIM (v_rpr_num) );
               v_dado := v_dado || ',' || 'rpr_data = '
                         || TO_CHAR (v_rpr_data, 'DD/MM/YYYY');
               v_dado := v_dado || ',' || 'rpr_valor = ' || TO_CHAR (
                                                               v_rpr_valor);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_REC_PRECOMPROVADO',
                  'A',
                  v_dado);
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
   -- Pesquisa Cadastro de Carências
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_cod                 IN       t_cre_cod)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CARENCIA',
            'PESQUISA')
      THEN
         SELECT cre_cod,
                cre_dep_cod,
                num_prioridade_superint,
                num_prioridade_carencia,
                cre_projeto,
                num_seq_pessoal_carencia,
                cre_desc,
                cre_justificativa,
                cre_aen_subcod,
                cre_ntf_cod,
                cod_detalhe_cliente,
                cre_prazo,
                cre_inicio,
                cre_termino,
                cre_data,
                cre_vlobras,
                num_situacao_carencia,
                dsc_critica_carencia,
                cre_tipo
           INTO vo_cre_cod (1),
                vo_cre_dep_cod (1),
                vo_num_prioridade_superint (1),
                vo_num_prioridade_carencia (1),
                vo_cre_projeto (1),
                vo_num_seq_pessoal_carencia (1),
                vo_cre_desc (1),
                vo_cre_justificativa (1),
                vo_cre_aen_subcod (1),
                vo_cre_ntf_cod (1),
                vo_cod_detalhe_cliente (1),
                vo_cre_prazo (1),
                vo_cre_inicio (1),
                vo_cre_termino (1),
                vo_cre_data (1),
                vo_cre_vlobras (1),
                vo_num_situacao_carencia (1),
                vo_dsc_critica_carencia (1),
                vo_cre_tipo (1)
           FROM ifrbde.viw_carencia
          WHERE cre_cod = vi_cre_cod;

         SELECT ifrbde.pck_geral.stf_cur2str (NVL (SUM (rap_valor), 0) )
           INTO vo_cre_valor_aprov (1)
           FROM ifrbde.tab_rec_aprovado
          WHERE rap_cre_cod = vi_cre_cod;

         SELECT ifrbde.pck_geral.stf_cur2str (NVL (SUM (rap_valor_pago), 0) )
           INTO vo_cre_valor_pago (1)
           FROM ifrbde.tab_rec_aprovado
          WHERE rap_cre_cod = vi_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Carências
   -- retorna o OK ou não
   PROCEDURE stp_exclui_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_cre_cod                 IN       t_cre_cod)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_carencia
              WHERE cre_cod = vi_cre_cod
         FOR UPDATE;

      v_viw_carencia                ifrbde.viw_carencia%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CARENCIA',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_carencia;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'cre_cod = ' || TO_CHAR (v_viw_carencia.cre_cod);
            v_dado := v_dado || ',' || 'cre_dep_cod = '
                      || TO_CHAR (v_viw_carencia.cre_dep_cod);
            v_dado := v_dado || ',' || 'num_prioridade_superint = '
                      || TO_CHAR (v_viw_carencia.num_prioridade_superint);
            v_dado := v_dado || ',' || 'num_prioridade_carencia = '
                      || TO_CHAR (v_viw_carencia.num_prioridade_carencia);
            v_dado := v_dado || ',' || 'cre_projeto = '
                      || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_projeto) ) );
            v_dado := v_dado || ',' || 'num_seq_pessoal_carencia = '
                      || TO_CHAR (v_viw_carencia.num_seq_pessoal_carencia);
            v_dado := v_dado || ',' || 'cre_desc = '
                      || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_desc) ) );
            v_dado := v_dado || ',' || 'cre_justificativa = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_carencia.cre_justificativa) ) );
            v_dado := v_dado || ',' || 'cre_aen_subcod = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_carencia.cre_aen_subcod) ) );
            v_dado := v_dado || ',' || 'cre_ntf_cod = '
                      || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_ntf_cod) ) );
            v_dado := v_dado || ',' || 'cod_detalhe_cliente = '
                      || TO_CHAR (v_viw_carencia.cod_detalhe_cliente);
            v_dado := v_dado || ',' || 'cre_prazo = '
                      || TO_CHAR (v_viw_carencia.cre_prazo);
            v_dado := v_dado || ',' || 'cre_inicio = '
                      || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_inicio) ) );
            v_dado := v_dado || ',' || 'cre_termino = '
                      || RTRIM (LTRIM (UPPER (v_viw_carencia.cre_termino) ) );
            v_dado := v_dado || ',' || 'cre_data = '
                      || TO_DATE (v_viw_carencia.cre_data, 'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'cre_vlobras = '
                      || TO_CHAR (v_viw_carencia.cre_vlobras);
            v_dado := v_dado || ',' || 'num_situacao_carencia = '
                      || TO_CHAR (v_viw_carencia.num_situacao_carencia);
            v_dado :=
                  v_dado || ',' || 'dsc_critica_carencia = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_carencia.dsc_critica_carencia) ) );
            v_dado :=
               v_dado || ',' || 'cre_tipo = ' || TO_CHAR (
                                                    v_viw_carencia.cre_tipo);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_CARENCIA',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.viw_carencia
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
                     'Mais de um registro solicitado para exclusão. Operação não realizada!!!');
               END IF;
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para exclusão!!!');
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para exclusão!!!');
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
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_dep_cod             IN       t_cre_dep_cod,
      vi_num_prioridade_superint IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia IN       t_num_prioridade_carencia,
      vi_cre_projeto             IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia IN      t_num_seq_pessoal_carencia,
      vi_cre_desc                IN       t_cre_desc,
      vi_cre_justificativa       IN       t_cre_justificativa,
      vi_cre_aen_subcod          IN       t_cre_aen_subcod,
      vi_cre_ntf_cod             IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente     IN       t_cod_detalhe_cliente,
      vi_cre_prazo               IN       t_cre_prazo,
      vi_cre_inicio              IN       t_cre_inicio,
      vi_cre_termino             IN       t_cre_termino,
      vi_cre_data                IN       t_cre_data,
      vi_cre_vlobras             IN       t_cre_vlobras,
      vi_num_situacao_carencia   IN       t_num_situacao_carencia,
      vi_cre_tipo                IN       t_cre_tipo)
   AS
      v_cre_cod                     viw_carencia.cre_cod%TYPE;
      v_cre_dep_cod                 viw_carencia.cre_dep_cod%TYPE;
      v_num_prioridade_superint     viw_carencia.num_prioridade_superint%TYPE;
      v_num_prioridade_carencia     viw_carencia.num_prioridade_carencia%TYPE;
      v_cre_projeto                 viw_carencia.cre_projeto%TYPE;
      v_num_seq_pessoal_carencia    viw_carencia.num_seq_pessoal_carencia%TYPE;
      v_cre_desc                    viw_carencia.cre_desc%TYPE;
      v_cre_justificativa           viw_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod              viw_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                 viw_carencia.cre_ntf_cod%TYPE;
      v_cod_detalhe_cliente         viw_carencia.cod_detalhe_cliente%TYPE;
      v_cre_prazo                   viw_carencia.cre_prazo%TYPE;
      v_cre_inicio                  viw_carencia.cre_inicio%TYPE;
      v_cre_termino                 viw_carencia.cre_termino%TYPE;
      v_cre_data                    viw_carencia.cre_data%TYPE;
      v_cre_vlobras                 viw_carencia.cre_vlobras%TYPE;
      v_num_situacao_carencia       viw_carencia.num_situacao_carencia%TYPE;
      v_cre_tipo                    viw_carencia.cre_tipo%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CARENCIA',
            'INCLUI')
      THEN
         SELECT ifrbde.seq_cre_cod.NEXTVAL
           INTO v_cre_cod
           FROM DUAL;

         v_cre_projeto := RTRIM (LTRIM (vi_cre_projeto) );
         v_cre_desc := RTRIM (LTRIM (vi_cre_desc) );
         v_cre_justificativa := RTRIM (LTRIM (vi_cre_justificativa) );
         v_cre_aen_subcod := RTRIM (LTRIM (vi_cre_aen_subcod) );
         v_cre_ntf_cod := RTRIM (LTRIM (vi_cre_ntf_cod) );
         v_cre_inicio := RTRIM (LTRIM (vi_cre_inicio) );
         v_cre_termino := RTRIM (LTRIM (vi_cre_termino) );
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
                     (cre_cod,
                      cre_dep_cod,
                      num_prioridade_superint,
                      num_prioridade_carencia,
                      cre_projeto,
                      num_seq_pessoal_carencia,
                      cre_desc,
                      cre_justificativa,
                      cre_aen_subcod,
                      cre_ntf_cod,
                      cod_detalhe_cliente,
                      cre_prazo,
                      cre_inicio,
                      cre_termino,
                      cre_data,
                      cre_vlobras,
                      num_situacao_carencia,
                      cre_tipo)
              VALUES (v_cre_cod,
                      v_cre_dep_cod,
                      v_num_prioridade_superint,
                      v_num_prioridade_carencia,
                      v_cre_projeto,
                      v_num_seq_pessoal_carencia,
                      v_cre_desc,
                      v_cre_justificativa,
                      v_cre_aen_subcod,
                      v_cre_ntf_cod,
                      v_cod_detalhe_cliente,
                      v_cre_prazo,
                      v_cre_inicio,
                      v_cre_termino,
                      v_cre_data,
                      v_cre_vlobras,
                      v_num_situacao_carencia,
                      v_cre_tipo);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_carencia (
               p_usuario,
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
               v_cre_cod);
            v_dado := 'cre_cod = ' || TO_CHAR (v_cre_cod);
            v_dado := v_dado || ',' || 'cre_dep_cod = ' || TO_CHAR (
                                                              v_cre_dep_cod);
            v_dado := v_dado || ',' || 'num_prioridade_superint = '
                      || TO_CHAR (v_num_prioridade_superint);
            v_dado := v_dado || ',' || 'num_prioridade_carencia = '
                      || TO_CHAR (v_num_prioridade_carencia);
            v_dado :=
               v_dado || ',' || 'cre_projeto = ' || RTRIM (
                                                       LTRIM (v_cre_projeto) );
            v_dado := v_dado || ',' || 'num_seq_pessoal_carencia = '
                      || TO_CHAR (v_num_seq_pessoal_carencia);
            v_dado :=
                     v_dado || ',' || 'cre_desc = ' || RTRIM (
                                                          LTRIM (v_cre_desc) );
            v_dado := v_dado || ',' || 'cre_justificativa = '
                      || RTRIM (LTRIM (v_cre_justificativa) );
            v_dado := v_dado || ',' || 'cre_aen_subcod = '
                      || RTRIM (LTRIM (v_cre_aen_subcod) );
            v_dado :=
               v_dado || ',' || 'cre_ntf_cod = ' || RTRIM (
                                                       LTRIM (v_cre_ntf_cod) );
            v_dado := v_dado || ',' || 'cod_detalhe_cliente = '
                      || TO_CHAR (v_cod_detalhe_cliente);
            v_dado := v_dado || ',' || 'cre_prazo = ' || TO_CHAR (
                                                            v_cre_prazo);
            v_dado :=
                 v_dado || ',' || 'cre_inicio = ' || RTRIM (
                                                        LTRIM (v_cre_inicio) );
            v_dado :=
               v_dado || ',' || 'cre_termino = ' || RTRIM (
                                                       LTRIM (v_cre_termino) );
            v_dado :=
               v_dado || ',' || 'cre_data = ' || TO_CHAR (
                                                    v_cre_data,
                                                    'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'cre_vlobras = ' || TO_CHAR (
                                                              v_cre_vlobras);
            v_dado := v_dado || ',' || 'num_situacao_carencia = '
                      || TO_CHAR (v_num_situacao_carencia);
            v_dado := v_dado || ',' || 'cre_tipo = ' || TO_CHAR (v_cre_tipo);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_CARENCIA',
               'I',
               v_dado);
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error (
               -20100,
               'Mais de um registro solicitado para inclusão. Operação não realizada!!!');
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para inclusão!!!');
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
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_cod                 IN       t_cre_cod,
      vi_cre_dep_cod             IN       t_cre_dep_cod,
      vi_num_prioridade_superint IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia IN       t_num_prioridade_carencia,
      vi_cre_projeto             IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia IN      t_num_seq_pessoal_carencia,
      vi_cre_desc                IN       t_cre_desc,
      vi_cre_justificativa       IN       t_cre_justificativa,
      vi_cre_aen_subcod          IN       t_cre_aen_subcod,
      vi_cre_ntf_cod             IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente     IN       t_cod_detalhe_cliente,
      vi_cre_prazo               IN       t_cre_prazo,
      vi_cre_inicio              IN       t_cre_inicio,
      vi_cre_termino             IN       t_cre_termino,
      vi_cre_data                IN       t_cre_data,
      vi_cre_vlobras             IN       t_cre_vlobras,
      vi_num_situacao_carencia   IN       t_num_situacao_carencia,
      vi_cre_tipo                IN       t_cre_tipo)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_carencia
              WHERE cre_cod = vi_cre_cod
         FOR UPDATE;

      v_viw_carencia                ifrbde.viw_carencia%ROWTYPE;
      v_cre_cod                     ifrbde.viw_carencia.cre_cod%TYPE;
      v_cre_dep_cod                 ifrbde.viw_carencia.cre_dep_cod%TYPE;
      v_num_prioridade_superint     ifrbde.viw_carencia.num_prioridade_superint%TYPE;
      v_num_prioridade_carencia     ifrbde.viw_carencia.num_prioridade_carencia%TYPE;
      v_cre_projeto                 ifrbde.viw_carencia.cre_projeto%TYPE;
      v_num_seq_pessoal_carencia    ifrbde.viw_carencia.num_seq_pessoal_carencia%TYPE;
      v_cre_desc                    ifrbde.viw_carencia.cre_desc%TYPE;
      v_cre_justificativa           ifrbde.viw_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod              ifrbde.viw_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                 ifrbde.viw_carencia.cre_ntf_cod%TYPE;
      v_cod_detalhe_cliente         ifrbde.viw_carencia.cod_detalhe_cliente%TYPE;
      v_cre_prazo                   ifrbde.viw_carencia.cre_prazo%TYPE;
      v_cre_inicio                  ifrbde.viw_carencia.cre_inicio%TYPE;
      v_cre_termino                 ifrbde.viw_carencia.cre_termino%TYPE;
      v_cre_data                    ifrbde.viw_carencia.cre_data%TYPE;
      v_cre_vlobras                 ifrbde.viw_carencia.cre_vlobras%TYPE;
      v_num_situacao_carencia       ifrbde.viw_carencia.num_situacao_carencia%TYPE;
      v_cre_tipo                    ifrbde.viw_carencia.cre_tipo%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_CARENCIA',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_carencia;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cre_projeto := RTRIM (LTRIM (vi_cre_projeto) );
            v_cre_desc := RTRIM (LTRIM (vi_cre_desc) );
            v_cre_justificativa := RTRIM (LTRIM (vi_cre_justificativa) );
            v_cre_aen_subcod := RTRIM (LTRIM (vi_cre_aen_subcod) );
            v_cre_ntf_cod := RTRIM (LTRIM (vi_cre_ntf_cod) );
            v_cre_inicio := RTRIM (LTRIM (vi_cre_inicio) );
            v_cre_termino := RTRIM (LTRIM (vi_cre_termino) );
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
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_carencia (
                  p_usuario,
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
                  vi_cre_cod);
               v_dado := 'cre_cod = ' || TO_CHAR (v_cre_cod);
               v_dado :=
                      v_dado || ',' || 'cre_dep_cod = ' || TO_CHAR (
                                                              v_cre_dep_cod);
               v_dado := v_dado || ',' || 'num_prioridade_superint = '
                         || TO_CHAR (v_num_prioridade_superint);
               v_dado := v_dado || ',' || 'num_prioridade_carencia = '
                         || TO_CHAR (v_num_prioridade_carencia);
               v_dado := v_dado || ',' || 'cre_projeto = '
                         || RTRIM (LTRIM (v_cre_projeto) );
               v_dado := v_dado || ',' || 'num_seq_pessoal_carencia = '
                         || TO_CHAR (v_num_seq_pessoal_carencia);
               v_dado :=
                     v_dado || ',' || 'cre_desc = ' || RTRIM (
                                                          LTRIM (v_cre_desc) );
               v_dado := v_dado || ',' || 'cre_justificativa = '
                         || RTRIM (LTRIM (v_cre_justificativa) );
               v_dado := v_dado || ',' || 'cre_aen_subcod = '
                         || RTRIM (LTRIM (v_cre_aen_subcod) );
               v_dado := v_dado || ',' || 'cre_ntf_cod = '
                         || RTRIM (LTRIM (v_cre_ntf_cod) );
               v_dado := v_dado || ',' || 'cod_detalhe_cliente = '
                         || TO_CHAR (v_cod_detalhe_cliente);
               v_dado := v_dado || ',' || 'cre_prazo = ' || TO_CHAR (
                                                               v_cre_prazo);
               v_dado := v_dado || ',' || 'cre_inicio = '
                         || RTRIM (LTRIM (v_cre_inicio) );
               v_dado := v_dado || ',' || 'cre_termino = '
                         || RTRIM (LTRIM (v_cre_termino) );
               v_dado := v_dado || ',' || 'cre_data = '
                         || TO_CHAR (v_cre_data, 'DD/MM/YYYY');
               v_dado :=
                      v_dado || ',' || 'cre_vlobras = ' || TO_CHAR (
                                                              v_cre_vlobras);
               v_dado := v_dado || ',' || 'num_situacao_carencia = '
                         || TO_CHAR (v_num_situacao_carencia);
               v_dado := v_dado || ',' || 'cre_tipo = ' || TO_CHAR (
                                                              v_cre_tipo);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_CARENCIA',
                  'A',
                  v_dado);
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error (
                  -20100,
                  'Mais de um registro solicitado para alteração. Operação não realizada!!!');
            END IF;
         ELSE
            raise_application_error (
               -20100,
               'Registro não foi encontrado para alteração!!!');
         END IF;
      ELSE
         raise_application_error (
            -20100,
            'Não foi concedida permissão para alteração!!!');
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Valores Comprometidos
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_saldo_carencia_co (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SALDO_CARENCIA_CONTRATO',
            'PESQUISA')
      THEN
         SELECT num_cre_cod,
                val_total_recurso,
                val_total_contratado,
                val_total_aditivado,
                val_saldo_recurso
           INTO vo_num_cre_cod (1),
                vo_val_total_recurso (1),
                vo_val_total_contratado (1),
                vo_val_total_aditivado (1),
                vo_val_saldo_recurso (1)
           FROM ifrbde.viw_saldo_carencia_contrato
          WHERE num_cre_cod = vi_num_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Valores Comprometidos
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_cre_cod             IN       t_num_cre_cod)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_saldo_carencia_contrato
              WHERE num_cre_cod = vi_num_cre_cod
         FOR UPDATE;

      v_viw_saldo_carencia_contrato ifrbde.viw_saldo_carencia_contrato%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SALDO_CARENCIA_CONTRATO',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_saldo_carencia_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'num_cre_cod = '
                      || TO_CHAR (v_viw_saldo_carencia_contrato.num_cre_cod);
            v_dado :=
                  v_dado || ',' || 'val_total_recurso = '
                  || TO_CHAR (
                        v_viw_saldo_carencia_contrato.val_total_recurso);
            v_dado :=
                  v_dado || ',' || 'val_total_contratado = '
                  || TO_CHAR (
                        v_viw_saldo_carencia_contrato.val_total_contratado);
            v_dado :=
                  v_dado || ',' || 'val_total_aditivado = '
                  || TO_CHAR (
                        v_viw_saldo_carencia_contrato.val_total_aditivado);
            v_dado :=
                  v_dado || ',' || 'val_saldo_recurso = '
                  || TO_CHAR (
                        v_viw_saldo_carencia_contrato.val_saldo_recurso);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_SALDO_CARENCIA_CONTRATO',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.viw_saldo_carencia_contrato
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
-- Inclui Valores Comprometidos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod,
      vi_val_total_recurso       IN       t_val_total_recurso,
      vi_val_total_contratado    IN       t_val_total_contratado,
      vi_val_total_aditivado     IN       t_val_total_aditivado,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso)
   AS
      v_num_cre_cod                 viw_saldo_carencia_contrato.num_cre_cod%TYPE;
      v_val_total_recurso           viw_saldo_carencia_contrato.val_total_recurso%TYPE;
      v_val_total_contratado        viw_saldo_carencia_contrato.val_total_contratado%TYPE;
      v_val_total_aditivado         viw_saldo_carencia_contrato.val_total_aditivado%TYPE;
      v_val_saldo_recurso           viw_saldo_carencia_contrato.val_saldo_recurso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SALDO_CARENCIA_CONTRATO',
            'INCLUI')
      THEN
         v_num_cre_cod := vi_num_cre_cod;
         v_val_total_recurso := vi_val_total_recurso;
         v_val_total_contratado := vi_val_total_contratado;
         v_val_total_aditivado := vi_val_total_aditivado;
         v_val_saldo_recurso := vi_val_saldo_recurso;

         INSERT INTO ifrbde.viw_saldo_carencia_contrato
                     (num_cre_cod,
                      val_total_recurso,
                      val_total_contratado,
                      val_total_aditivado,
                      val_saldo_recurso)
              VALUES (v_num_cre_cod,
                      v_val_total_recurso,
                      v_val_total_contratado,
                      v_val_total_aditivado,
                      v_val_saldo_recurso);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_saldo_carencia_co (
               p_usuario,
               vo_num_cre_cod,
               vo_val_total_recurso,
               vo_val_total_contratado,
               vo_val_total_aditivado,
               vo_val_saldo_recurso,
               v_num_cre_cod);
            v_dado := 'num_cre_cod = ' || TO_CHAR (v_num_cre_cod);
            v_dado := v_dado || ',' || 'val_total_recurso = '
                      || TO_CHAR (v_val_total_recurso);
            v_dado := v_dado || ',' || 'val_total_contratado = '
                      || TO_CHAR (v_val_total_contratado);
            v_dado := v_dado || ',' || 'val_total_aditivado = '
                      || TO_CHAR (v_val_total_aditivado);
            v_dado := v_dado || ',' || 'val_saldo_recurso = '
                      || TO_CHAR (v_val_saldo_recurso);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_SALDO_CARENCIA_CONTRATO',
               'I',
               v_dado);
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
-- Altera Valores Comprometidos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod,
      vi_val_total_recurso       IN       t_val_total_recurso,
      vi_val_total_contratado    IN       t_val_total_contratado,
      vi_val_total_aditivado     IN       t_val_total_aditivado,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_saldo_carencia_contrato
              WHERE num_cre_cod = vi_num_cre_cod
         FOR UPDATE;

      v_viw_saldo_carencia_contrato ifrbde.viw_saldo_carencia_contrato%ROWTYPE;
      v_num_cre_cod                 ifrbde.viw_saldo_carencia_contrato.num_cre_cod%TYPE;
      v_val_total_recurso           ifrbde.viw_saldo_carencia_contrato.val_total_recurso%TYPE;
      v_val_total_contratado        ifrbde.viw_saldo_carencia_contrato.val_total_contratado%TYPE;
      v_val_total_aditivado         ifrbde.viw_saldo_carencia_contrato.val_total_aditivado%TYPE;
      v_val_saldo_recurso           ifrbde.viw_saldo_carencia_contrato.val_saldo_recurso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SALDO_CARENCIA_CONTRATO',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_saldo_carencia_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_num_cre_cod := vi_num_cre_cod;
            v_val_total_recurso := vi_val_total_recurso;
            v_val_total_contratado := vi_val_total_contratado;
            v_val_total_aditivado := vi_val_total_aditivado;
            v_val_saldo_recurso := vi_val_saldo_recurso;

            UPDATE ifrbde.viw_saldo_carencia_contrato
               SET val_total_recurso = v_val_total_recurso,
                   val_total_contratado = v_val_total_contratado,
                   val_total_aditivado = v_val_total_aditivado,
                   val_saldo_recurso = v_val_saldo_recurso
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_saldo_carencia_co (
                  p_usuario,
                  vo_num_cre_cod,
                  vo_val_total_recurso,
                  vo_val_total_contratado,
                  vo_val_total_aditivado,
                  vo_val_saldo_recurso,
                  vi_num_cre_cod);
               v_dado := 'num_cre_cod = ' || TO_CHAR (v_num_cre_cod);
               v_dado := v_dado || ',' || 'val_total_recurso = '
                         || TO_CHAR (v_val_total_recurso);
               v_dado := v_dado || ',' || 'val_total_contratado = '
                         || TO_CHAR (v_val_total_contratado);
               v_dado := v_dado || ',' || 'val_total_aditivado = '
                         || TO_CHAR (v_val_total_aditivado);
               v_dado := v_dado || ',' || 'val_saldo_recurso = '
                         || TO_CHAR (v_val_saldo_recurso);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_SALDO_CARENCIA_CONTRATO',
                  'A',
                  v_dado);
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
-- Pesquisa Solicitação de Recursos
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_recursos_solicita (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RECURSOS_SOLICITADOS',
            'PESQUISA')
      THEN
         SELECT num_seq_carencia,
                num_ano,
                val_proposta
           INTO vo_num_seq_carencia (1),
                vo_num_ano (1),
                vo_val_proposta (1)
           FROM ifrbde.cad_recursos_solicitados
          WHERE num_seq_carencia = vi_num_seq_carencia
            AND num_ano = vi_num_ano;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Solicitação de Recursos
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_recursos_solicitados
              WHERE num_seq_carencia = vi_num_seq_carencia
                AND num_ano = vi_num_ano
         FOR UPDATE;

      v_cad_recursos_solicitados    ifrbde.cad_recursos_solicitados%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RECURSOS_SOLICITADOS',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_recursos_solicitados;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'num_seq_carencia = '
                      || TO_CHAR (
                            v_cad_recursos_solicitados.num_seq_carencia);
            v_dado := v_dado || ',' || 'num_ano = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_cad_recursos_solicitados.num_ano) ) );
            v_dado := v_dado || ',' || 'val_proposta = '
                      || TO_CHAR (v_cad_recursos_solicitados.val_proposta);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RECURSOS_SOLICITADOS',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.cad_recursos_solicitados
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
-- Inclui Solicitação de Recursos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano,
      vi_val_proposta            IN       t_val_proposta)
   AS
      v_num_seq_carencia            cad_recursos_solicitados.num_seq_carencia%TYPE;
      v_num_ano                     cad_recursos_solicitados.num_ano%TYPE;
      v_val_proposta                cad_recursos_solicitados.val_proposta%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RECURSOS_SOLICITADOS',
            'INCLUI')
      THEN
         v_num_ano := RTRIM (LTRIM (vi_num_ano) );
         v_num_seq_carencia := vi_num_seq_carencia;
         v_val_proposta := vi_val_proposta;

         INSERT INTO ifrbde.cad_recursos_solicitados
                     (num_seq_carencia,
                      num_ano,
                      val_proposta)
              VALUES (v_num_seq_carencia,
                      v_num_ano,
                      v_val_proposta);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_recursos_solicita (
               p_usuario,
               vo_num_seq_carencia,
               vo_num_ano,
               vo_val_proposta,
               v_num_seq_carencia,
               v_num_ano);
            v_dado := 'num_seq_carencia = ' || TO_CHAR (v_num_seq_carencia);
            v_dado := v_dado || ',' || 'num_ano = ' || RTRIM (
                                                          LTRIM (v_num_ano) );
            v_dado :=
                    v_dado || ',' || 'val_proposta = ' || TO_CHAR (
                                                             v_val_proposta);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RECURSOS_SOLICITADOS',
               'I',
               v_dado);
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
-- Altera Solicitação de Recursos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano,
      vi_val_proposta            IN       t_val_proposta)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.cad_recursos_solicitados
              WHERE num_seq_carencia = vi_num_seq_carencia
                AND num_ano = vi_num_ano
         FOR UPDATE;

      v_cad_recursos_solicitados    ifrbde.cad_recursos_solicitados%ROWTYPE;
      v_num_seq_carencia            ifrbde.cad_recursos_solicitados.num_seq_carencia%TYPE;
      v_num_ano                     ifrbde.cad_recursos_solicitados.num_ano%TYPE;
      v_val_proposta                ifrbde.cad_recursos_solicitados.val_proposta%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RECURSOS_SOLICITADOS',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_recursos_solicitados;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_num_ano := RTRIM (LTRIM (vi_num_ano) );
            v_num_seq_carencia := vi_num_seq_carencia;
            v_val_proposta := vi_val_proposta;

            UPDATE ifrbde.cad_recursos_solicitados
               SET val_proposta = v_val_proposta
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_recursos_solicita (
                  p_usuario,
                  vo_num_seq_carencia,
                  vo_num_ano,
                  vo_val_proposta,
                  vi_num_seq_carencia,
                  vi_num_ano);
               v_dado := 'num_seq_carencia = ' || TO_CHAR (
                                                     v_num_seq_carencia);
               v_dado :=
                       v_dado || ',' || 'num_ano = ' || RTRIM (
                                                           LTRIM (v_num_ano) );
               v_dado :=
                    v_dado || ',' || 'val_proposta = ' || TO_CHAR (
                                                             v_val_proposta);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RECURSOS_SOLICITADOS',
                  'A',
                  v_dado);
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
-- Pesquisa PRÉ COMPROMISSO
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia)
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_PRE_COMPROMISSO',
            'PESQUISA')
      THEN
         SELECT seq_pre_compromisso,
                seq_carencia,
                num_forma_pagamento,
                num_reg_execucao,
                flg_consorcio,
                val_pre_comp,
                dat_pre_comp,
                flg_risco,
                tax_garantia,
                flg_execucao,
                tax_execucao,
                dsc_local_entrega,
                num_prz_exec,
                num_execucao_meses,
                num_prz_exec_contrato,
                num_exec_contrato_mes,
                cod_mod_licitacao,
                num_inciso,
                dsc_fundamento_legal,
                num_licitacao,
                num_ano_licitacao,
                num_processo,
                num_sit_pre_comp
           INTO vo_seq_pre_compromisso (1),
                vo_seq_carencia (1),
                vo_num_forma_pagamento (1),
                vo_num_reg_execucao (1),
                vo_flg_consorcio (1),
                vo_val_pre_comp (1),
                vo_dat_pre_comp (1),
                vo_flg_risco (1),
                vo_tax_garantia (1),
                vo_flg_execucao (1),
                vo_tax_execucao (1),
                vo_dsc_local_entrega (1),
                vo_num_prz_exec (1),
                vo_num_execucao_meses (1),
                vo_num_prz_exec_contrato (1),
                vo_num_exec_contrato_mes (1),
                vo_cod_mod_licitacao (1),
                vo_num_inciso (1),
                vo_dsc_fundamento_legal (1),
                vo_num_licitacao (1),
                vo_num_ano_licitacao (1),
                vo_num_processo (1),
                vo_num_sit_pre_comp (1)
           FROM ifrbde.viw_pre_compromisso
          WHERE seq_pre_compromisso = vi_seq_pre_compromisso
            AND seq_carencia = vi_seq_carencia;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui PRÉ COMPROMISSO
   -- retorna o OK ou não
   PROCEDURE stp_exclui_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_pre_compromisso
              WHERE seq_pre_compromisso = vi_seq_pre_compromisso
                AND seq_carencia = vi_seq_carencia
         FOR UPDATE;

      v_viw_pre_compromisso         ifrbde.viw_pre_compromisso%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_PRE_COMPROMISSO',
            'EXCLUI')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_pre_compromisso;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado := 'seq_pre_compromisso = '
                      || TO_CHAR (v_viw_pre_compromisso.seq_pre_compromisso);
            v_dado := v_dado || ',' || 'seq_carencia = '
                      || TO_CHAR (v_viw_pre_compromisso.seq_carencia);
            v_dado := v_dado || ',' || 'num_forma_pagamento = '
                      || TO_CHAR (v_viw_pre_compromisso.num_forma_pagamento);
            v_dado := v_dado || ',' || 'num_reg_execucao = '
                      || TO_CHAR (v_viw_pre_compromisso.num_reg_execucao);
            v_dado :=
                  v_dado || ',' || 'flg_consorcio = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_pre_compromisso.flg_consorcio) ) );
            v_dado := v_dado || ',' || 'val_pre_comp = '
                      || TO_CHAR (v_viw_pre_compromisso.val_pre_comp);
            v_dado := v_dado || ',' || 'dat_pre_comp = '
                      || TO_DATE (
                            v_viw_pre_compromisso.dat_pre_comp,
                            'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'flg_risco = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_pre_compromisso.flg_risco) ) );
            v_dado := v_dado || ',' || 'tax_garantia = '
                      || TO_CHAR (v_viw_pre_compromisso.tax_garantia);
            v_dado := v_dado || ',' || 'flg_execucao = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_viw_pre_compromisso.flg_execucao) ) );
            v_dado := v_dado || ',' || 'tax_execucao = '
                      || TO_CHAR (v_viw_pre_compromisso.tax_execucao);
            v_dado :=
                  v_dado || ',' || 'dsc_local_entrega = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_pre_compromisso.dsc_local_entrega) ) );
            v_dado := v_dado || ',' || 'num_prz_exec = '
                      || TO_CHAR (v_viw_pre_compromisso.num_prz_exec);
            v_dado := v_dado || ',' || 'num_execucao_meses = '
                      || TO_CHAR (v_viw_pre_compromisso.num_execucao_meses);
            v_dado := v_dado || ',' || 'num_prz_exec_contrato = '
                      || TO_CHAR (
                            v_viw_pre_compromisso.num_prz_exec_contrato);
            v_dado := v_dado || ',' || 'num_exec_contrato_mes = '
                      || TO_CHAR (
                            v_viw_pre_compromisso.num_exec_contrato_mes);
            v_dado :=
                  v_dado || ',' || 'cod_mod_licitacao = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_pre_compromisso.cod_mod_licitacao) ) );
            v_dado := v_dado || ',' || 'num_inciso = '
                      || TO_CHAR (v_viw_pre_compromisso.num_inciso);
            v_dado :=
                  v_dado || ',' || 'dsc_fundamento_legal = '
                  || RTRIM (
                        LTRIM (
                           UPPER (v_viw_pre_compromisso.dsc_fundamento_legal) ) );
            v_dado := v_dado || ',' || 'num_licitacao = '
                      || TO_CHAR (v_viw_pre_compromisso.num_licitacao);
            v_dado := v_dado || ',' || 'num_ano_licitacao = '
                      || TO_CHAR (v_viw_pre_compromisso.num_ano_licitacao);
            v_dado := v_dado || ',' || 'num_processo = '
                      || RTRIM (
                            LTRIM (
                               UPPER (v_viw_pre_compromisso.num_processo) ) );
            v_dado := v_dado || ',' || 'num_sit_pre_comp = '
                      || TO_CHAR (v_viw_pre_compromisso.num_sit_pre_comp);

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_PRE_COMPROMISSO',
                  'E',
                  v_dado);

               DELETE FROM ifrbde.viw_pre_compromisso
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
-- Inclui PRÉ COMPROMISSO
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_carencia            IN       t_seq_carencia,
      vi_num_forma_pagamento     IN       t_num_forma_pagamento,
      vi_num_reg_execucao        IN       t_num_reg_execucao,
      vi_flg_consorcio           IN       t_flg_consorcio,
      vi_dat_pre_comp            IN       t_dat_pre_comp,
      vi_flg_risco               IN       t_flg_risco,
      vi_flg_execucao            IN       t_flg_execucao,
      vi_tax_execucao            IN       t_tax_execucao,
      vi_dsc_local_entrega       IN       t_dsc_local_entrega,
      vi_num_prz_exec            IN       t_num_prz_exec,
      vi_num_prz_exec_contrato   IN       t_num_prz_exec_contrato,
      vi_cod_mod_licitacao       IN       t_cod_mod_licitacao,
      vi_num_inciso              IN       t_num_inciso,
      vi_dsc_fundamento_legal    IN       t_dsc_fundamento_legal,
      vi_num_licitacao           IN       t_num_licitacao,
      vi_num_ano_licitacao       IN       t_num_ano_licitacao,
      vi_num_processo            IN       t_num_processo,
      vi_num_sit_pre_comp        IN       t_num_sit_pre_comp)
   AS
      v_seq_pre_compromisso         viw_pre_compromisso.seq_pre_compromisso%TYPE;
      v_seq_carencia                viw_pre_compromisso.seq_carencia%TYPE;
      v_num_forma_pagamento         viw_pre_compromisso.num_forma_pagamento%TYPE;
      v_num_reg_execucao            viw_pre_compromisso.num_reg_execucao%TYPE;
      v_flg_consorcio               viw_pre_compromisso.flg_consorcio%TYPE;
      v_dat_pre_comp                viw_pre_compromisso.dat_pre_comp%TYPE;
      v_flg_risco                   viw_pre_compromisso.flg_risco%TYPE;
      v_flg_execucao                viw_pre_compromisso.flg_execucao%TYPE;
      v_tax_execucao                viw_pre_compromisso.tax_execucao%TYPE;
      v_dsc_local_entrega           viw_pre_compromisso.dsc_local_entrega%TYPE;
      v_num_prz_exec                viw_pre_compromisso.num_prz_exec%TYPE;
      v_num_prz_exec_contrato       viw_pre_compromisso.num_prz_exec_contrato%TYPE;
      v_cod_mod_licitacao           viw_pre_compromisso.cod_mod_licitacao%TYPE;
      v_num_inciso                  viw_pre_compromisso.num_inciso%TYPE;
      v_dsc_fundamento_legal        viw_pre_compromisso.dsc_fundamento_legal%TYPE;
      v_num_licitacao               viw_pre_compromisso.num_licitacao%TYPE;
      v_num_ano_licitacao           viw_pre_compromisso.num_ano_licitacao%TYPE;
      v_num_processo                viw_pre_compromisso.num_processo%TYPE;
      v_num_sit_pre_comp            viw_pre_compromisso.num_sit_pre_comp%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_PRE_COMPROMISSO',
            'INCLUI')
      THEN
         SELECT seq_cad_pre_compromisso.NEXTVAL
           INTO v_seq_pre_compromisso
           FROM DUAL;

         v_flg_consorcio := RTRIM (LTRIM (vi_flg_consorcio) );
         v_flg_risco := RTRIM (LTRIM (vi_flg_risco) );
         v_flg_execucao := RTRIM (LTRIM (vi_flg_execucao) );
         v_dsc_local_entrega := RTRIM (LTRIM (vi_dsc_local_entrega) );
         v_cod_mod_licitacao := RTRIM (LTRIM (vi_cod_mod_licitacao) );
         v_dsc_fundamento_legal := RTRIM (LTRIM (vi_dsc_fundamento_legal) );
         v_num_processo := RTRIM (LTRIM (vi_num_processo) );
         v_dat_pre_comp := TO_DATE (vi_dat_pre_comp, 'DD/MM/YYYY');
         v_seq_carencia := vi_seq_carencia;
         v_num_forma_pagamento := vi_num_forma_pagamento;
         v_num_reg_execucao := vi_num_reg_execucao;
         v_tax_execucao := vi_tax_execucao;
         v_num_prz_exec := vi_num_prz_exec;
         v_num_prz_exec_contrato := vi_num_prz_exec_contrato;
         v_num_inciso := vi_num_inciso;
         v_num_licitacao := vi_num_licitacao;
         v_num_ano_licitacao := vi_num_ano_licitacao;
         v_num_sit_pre_comp := vi_num_sit_pre_comp;

         INSERT INTO ifrbde.viw_pre_compromisso
                     (seq_pre_compromisso,
                      seq_carencia,
                      num_forma_pagamento,
                      num_reg_execucao,
                      flg_consorcio,
                      dat_pre_comp,
                      flg_risco,
                      flg_execucao,
                      tax_execucao,
                      dsc_local_entrega,
                      num_prz_exec,
                      num_prz_exec_contrato,
                      cod_mod_licitacao,
                      num_inciso,
                      dsc_fundamento_legal,
                      num_licitacao,
                      num_ano_licitacao,
                      num_processo,
                      num_sit_pre_comp)
              VALUES (v_seq_pre_compromisso,
                      v_seq_carencia,
                      v_num_forma_pagamento,
                      v_num_reg_execucao,
                      v_flg_consorcio,
                      v_dat_pre_comp,
                      v_flg_risco,
                      v_flg_execucao,
                      v_tax_execucao,
                      v_dsc_local_entrega,
                      v_num_prz_exec,
                      v_num_prz_exec_contrato,
                      v_cod_mod_licitacao,
                      v_num_inciso,
                      v_dsc_fundamento_legal,
                      v_num_licitacao,
                      v_num_ano_licitacao,
                      v_num_processo,
                      v_num_sit_pre_comp);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_pre_compromisso (
               p_usuario,
               vo_seq_pre_compromisso,
               vo_seq_carencia,
               vo_num_forma_pagamento,
               vo_num_reg_execucao,
               vo_flg_consorcio,
               vo_val_pre_comp,
               vo_dat_pre_comp,
               vo_flg_risco,
               vo_tax_garantia,
               vo_flg_execucao,
               vo_tax_execucao,
               vo_dsc_local_entrega,
               vo_num_prz_exec,
               vo_num_execucao_meses,
               vo_num_prz_exec_contrato,
               vo_num_exec_contrato_mes,
               vo_cod_mod_licitacao,
               vo_num_inciso,
               vo_dsc_fundamento_legal,
               vo_num_licitacao,
               vo_num_ano_licitacao,
               vo_num_processo,
               vo_num_sit_pre_comp,
               v_seq_pre_compromisso,
               v_seq_carencia);
            v_dado :=
                    'seq_pre_compromisso = ' || TO_CHAR (
                                                   v_seq_pre_compromisso);
            v_dado :=
                    v_dado || ',' || 'seq_carencia = ' || TO_CHAR (
                                                             v_seq_carencia);
            v_dado := v_dado || ',' || 'num_forma_pagamento = '
                      || TO_CHAR (v_num_forma_pagamento);
            v_dado := v_dado || ',' || 'num_reg_execucao = '
                      || TO_CHAR (v_num_reg_execucao);
            v_dado := v_dado || ',' || 'flg_consorcio = '
                      || RTRIM (LTRIM (v_flg_consorcio) );
            v_dado := v_dado || ',' || 'dat_pre_comp = '
                      || TO_CHAR (v_dat_pre_comp, 'DD/MM/YYYY');
            v_dado :=
                   v_dado || ',' || 'flg_risco = ' || RTRIM (
                                                         LTRIM (v_flg_risco) );
            v_dado := v_dado || ',' || 'flg_execucao = '
                      || RTRIM (LTRIM (v_flg_execucao) );
            v_dado :=
                    v_dado || ',' || 'tax_execucao = ' || TO_CHAR (
                                                             v_tax_execucao);
            v_dado := v_dado || ',' || 'dsc_local_entrega = '
                      || RTRIM (LTRIM (v_dsc_local_entrega) );
            v_dado :=
                    v_dado || ',' || 'num_prz_exec = ' || TO_CHAR (
                                                             v_num_prz_exec);
            v_dado := v_dado || ',' || 'num_prz_exec_contrato = '
                      || TO_CHAR (v_num_prz_exec_contrato);
            v_dado := v_dado || ',' || 'cod_mod_licitacao = '
                      || RTRIM (LTRIM (v_cod_mod_licitacao) );
            v_dado := v_dado || ',' || 'num_inciso = ' || TO_CHAR (
                                                             v_num_inciso);
            v_dado := v_dado || ',' || 'dsc_fundamento_legal = '
                      || RTRIM (LTRIM (v_dsc_fundamento_legal) );
            v_dado :=
                  v_dado || ',' || 'num_licitacao = ' || TO_CHAR (
                                                            v_num_licitacao);
            v_dado := v_dado || ',' || 'num_ano_licitacao = '
                      || TO_CHAR (v_num_ano_licitacao);
            v_dado := v_dado || ',' || 'num_processo = '
                      || RTRIM (LTRIM (v_num_processo) );
            v_dado := v_dado || ',' || 'num_sit_pre_comp = '
                      || TO_CHAR (v_num_sit_pre_comp);
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_PRE_COMPROMISSO',
               'I',
               v_dado);
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
-- Altera PRÉ COMPROMISSO
-- retorna o recordset correspondente
   PROCEDURE stp_altera_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia,
      vi_num_forma_pagamento     IN       t_num_forma_pagamento,
      vi_num_reg_execucao        IN       t_num_reg_execucao,
      vi_flg_consorcio           IN       t_flg_consorcio,
      vi_dat_pre_comp            IN       t_dat_pre_comp,
      vi_flg_risco               IN       t_flg_risco,
      vi_flg_execucao            IN       t_flg_execucao,
      vi_tax_execucao            IN       t_tax_execucao,
      vi_dsc_local_entrega       IN       t_dsc_local_entrega,
      vi_num_prz_exec            IN       t_num_prz_exec,
      vi_num_prz_exec_contrato   IN       t_num_prz_exec_contrato,
      vi_cod_mod_licitacao       IN       t_cod_mod_licitacao,
      vi_num_inciso              IN       t_num_inciso,
      vi_dsc_fundamento_legal    IN       t_dsc_fundamento_legal,
      vi_num_licitacao           IN       t_num_licitacao,
      vi_num_ano_licitacao       IN       t_num_ano_licitacao,
      vi_num_processo            IN       t_num_processo,
      vi_num_sit_pre_comp        IN       t_num_sit_pre_comp)
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_pre_compromisso
              WHERE seq_pre_compromisso = vi_seq_pre_compromisso
                AND seq_carencia = vi_seq_carencia
         FOR UPDATE;

      v_viw_pre_compromisso         ifrbde.viw_pre_compromisso%ROWTYPE;
      v_seq_pre_compromisso         ifrbde.viw_pre_compromisso.seq_pre_compromisso%TYPE;
      v_seq_carencia                ifrbde.viw_pre_compromisso.seq_carencia%TYPE;
      v_num_forma_pagamento         ifrbde.viw_pre_compromisso.num_forma_pagamento%TYPE;
      v_num_reg_execucao            ifrbde.viw_pre_compromisso.num_reg_execucao%TYPE;
      v_flg_consorcio               ifrbde.viw_pre_compromisso.flg_consorcio%TYPE;
      v_dat_pre_comp                ifrbde.viw_pre_compromisso.dat_pre_comp%TYPE;
      v_flg_risco                   ifrbde.viw_pre_compromisso.flg_risco%TYPE;
      v_flg_execucao                ifrbde.viw_pre_compromisso.flg_execucao%TYPE;
      v_tax_execucao                ifrbde.viw_pre_compromisso.tax_execucao%TYPE;
      v_dsc_local_entrega           ifrbde.viw_pre_compromisso.dsc_local_entrega%TYPE;
      v_num_prz_exec                ifrbde.viw_pre_compromisso.num_prz_exec%TYPE;
      v_num_prz_exec_contrato       ifrbde.viw_pre_compromisso.num_prz_exec_contrato%TYPE;
      v_cod_mod_licitacao           ifrbde.viw_pre_compromisso.cod_mod_licitacao%TYPE;
      v_num_inciso                  ifrbde.viw_pre_compromisso.num_inciso%TYPE;
      v_dsc_fundamento_legal        ifrbde.viw_pre_compromisso.dsc_fundamento_legal%TYPE;
      v_num_licitacao               ifrbde.viw_pre_compromisso.num_licitacao%TYPE;
      v_num_ano_licitacao           ifrbde.viw_pre_compromisso.num_ano_licitacao%TYPE;
      v_num_processo                ifrbde.viw_pre_compromisso.num_processo%TYPE;
      v_num_sit_pre_comp            ifrbde.viw_pre_compromisso.num_sit_pre_comp%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_PRE_COMPROMISSO',
            'ALTERA')
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_pre_compromisso;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_flg_consorcio := RTRIM (LTRIM (vi_flg_consorcio) );
            v_flg_risco := RTRIM (LTRIM (vi_flg_risco) );
            v_flg_execucao := RTRIM (LTRIM (vi_flg_execucao) );
            v_dsc_local_entrega := RTRIM (LTRIM (vi_dsc_local_entrega) );
            v_cod_mod_licitacao := RTRIM (LTRIM (vi_cod_mod_licitacao) );
            v_dsc_fundamento_legal :=
                                     RTRIM (LTRIM (vi_dsc_fundamento_legal) );
            v_num_processo := RTRIM (LTRIM (vi_num_processo) );
            v_dat_pre_comp := TO_DATE (vi_dat_pre_comp, 'DD/MM/YYYY');
            v_seq_pre_compromisso := vi_seq_pre_compromisso;
            v_seq_carencia := vi_seq_carencia;
            v_num_forma_pagamento := vi_num_forma_pagamento;
            v_num_reg_execucao := vi_num_reg_execucao;
            v_tax_execucao := vi_tax_execucao;
            v_num_prz_exec := vi_num_prz_exec;
            v_num_prz_exec_contrato := vi_num_prz_exec_contrato;
            v_num_inciso := vi_num_inciso;
            v_num_licitacao := vi_num_licitacao;
            v_num_ano_licitacao := vi_num_ano_licitacao;
            v_num_sit_pre_comp := vi_num_sit_pre_comp;

            UPDATE ifrbde.viw_pre_compromisso
               SET num_forma_pagamento = v_num_forma_pagamento,
                   num_reg_execucao = v_num_reg_execucao,
                   flg_consorcio = v_flg_consorcio,
                   dat_pre_comp = v_dat_pre_comp,
                   flg_risco = v_flg_risco,
                   flg_execucao = v_flg_execucao,
                   tax_execucao = v_tax_execucao,
                   dsc_local_entrega = v_dsc_local_entrega,
                   num_prz_exec = v_num_prz_exec,
                   num_prz_exec_contrato = v_num_prz_exec_contrato,
                   cod_mod_licitacao = v_cod_mod_licitacao,
                   num_inciso = v_num_inciso,
                   dsc_fundamento_legal = v_dsc_fundamento_legal,
                   num_licitacao = v_num_licitacao,
                   num_ano_licitacao = v_num_ano_licitacao,
                   num_processo = v_num_processo,
                   num_sit_pre_comp = v_num_sit_pre_comp
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_pre_compromisso (
                  p_usuario,
                  vo_seq_pre_compromisso,
                  vo_seq_carencia,
                  vo_num_forma_pagamento,
                  vo_num_reg_execucao,
                  vo_flg_consorcio,
                  vo_val_pre_comp,
                  vo_dat_pre_comp,
                  vo_flg_risco,
                  vo_tax_garantia,
                  vo_flg_execucao,
                  vo_tax_execucao,
                  vo_dsc_local_entrega,
                  vo_num_prz_exec,
                  vo_num_execucao_meses,
                  vo_num_prz_exec_contrato,
                  vo_num_exec_contrato_mes,
                  vo_cod_mod_licitacao,
                  vo_num_inciso,
                  vo_dsc_fundamento_legal,
                  vo_num_licitacao,
                  vo_num_ano_licitacao,
                  vo_num_processo,
                  vo_num_sit_pre_comp,
                  vi_seq_pre_compromisso,
                  vi_seq_carencia);
               v_dado :=
                    'seq_pre_compromisso = ' || TO_CHAR (
                                                   v_seq_pre_compromisso);
               v_dado :=
                    v_dado || ',' || 'seq_carencia = ' || TO_CHAR (
                                                             v_seq_carencia);
               v_dado := v_dado || ',' || 'num_forma_pagamento = '
                         || TO_CHAR (v_num_forma_pagamento);
               v_dado := v_dado || ',' || 'num_reg_execucao = '
                         || TO_CHAR (v_num_reg_execucao);
               v_dado := v_dado || ',' || 'flg_consorcio = '
                         || RTRIM (LTRIM (v_flg_consorcio) );
               v_dado := v_dado || ',' || 'dat_pre_comp = '
                         || TO_CHAR (v_dat_pre_comp, 'DD/MM/YYYY');
               v_dado :=
                   v_dado || ',' || 'flg_risco = ' || RTRIM (
                                                         LTRIM (v_flg_risco) );
               v_dado := v_dado || ',' || 'flg_execucao = '
                         || RTRIM (LTRIM (v_flg_execucao) );
               v_dado :=
                    v_dado || ',' || 'tax_execucao = ' || TO_CHAR (
                                                             v_tax_execucao);
               v_dado := v_dado || ',' || 'dsc_local_entrega = '
                         || RTRIM (LTRIM (v_dsc_local_entrega) );
               v_dado :=
                    v_dado || ',' || 'num_prz_exec = ' || TO_CHAR (
                                                             v_num_prz_exec);
               v_dado := v_dado || ',' || 'num_prz_exec_contrato = '
                         || TO_CHAR (v_num_prz_exec_contrato);
               v_dado := v_dado || ',' || 'cod_mod_licitacao = '
                         || RTRIM (LTRIM (v_cod_mod_licitacao) );
               v_dado :=
                        v_dado || ',' || 'num_inciso = ' || TO_CHAR (
                                                               v_num_inciso);
               v_dado := v_dado || ',' || 'dsc_fundamento_legal = '
                         || RTRIM (LTRIM (v_dsc_fundamento_legal) );
               v_dado :=
                  v_dado || ',' || 'num_licitacao = ' || TO_CHAR (
                                                            v_num_licitacao);
               v_dado := v_dado || ',' || 'num_ano_licitacao = '
                         || TO_CHAR (v_num_ano_licitacao);
               v_dado := v_dado || ',' || 'num_processo = '
                         || RTRIM (LTRIM (v_num_processo) );
               v_dado := v_dado || ',' || 'num_sit_pre_comp = '
                         || TO_CHAR (v_num_sit_pre_comp);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_PRE_COMPROMISSO',
                  'A',
                  v_dado);
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
END;
/

-- Grants for Package Body
--GRANT EXECUTE ON ifrbde.pck_carencia TO bde_geral
--/
-- End of DDL Script for Package Body IFRBDE.PCK_CARENCIA

