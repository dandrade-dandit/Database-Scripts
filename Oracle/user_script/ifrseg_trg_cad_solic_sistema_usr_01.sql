/* Formatted on 10/06/2005 17:12 (Formatter Plus v4.8.0) */
-- Start of DDL Script for Trigger IFRSEG.TRG_CAD_SOLIC_SISTEMA_USR_01
-- Generated 2-dez-2004 19:33:21 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrseg.trg_cad_solic_sistema_usr_01
   BEFORE INSERT OR UPDATE OR DELETE
   ON ifrseg.cad_solic_sistema_usuario
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CURSOR usuario IS
      SELECT     flg_situacao_solic,
                 dat_aprovacao,
                 cod_usuario_solic
            FROM cad_solicitacao_usuario
           WHERE num_seq_solicitacao = :NEW.num_seq_solic_sist_usr
      FOR UPDATE;

   v_cod_grupo_m                 ifrseg.cad_acesso.cod_grupo_acesso%TYPE;
   v_cod_grupo_o                 ifrseg.cad_acesso.num_cod_grupo_obj%TYPE;
BEGIN
   IF    INSERTING
      OR UPDATING THEN
      IF (:NEW.dat_situacao_sist_usr IS NULL) THEN
         :NEW.dat_situacao_sist_usr := TRUNC (SYSDATE);
      END IF;
   END IF;

   FOR c IN usuario
   LOOP
      IF    INSERTING
         OR UPDATING THEN
         IF     :NEW.flg_situacao_solic_sist_usr IN ('I', 'P', 'A')
            AND (   (:OLD.flg_situacao_solic_sist_usr IS NULL)
                 OR (:OLD.flg_situacao_solic_sist_usr NOT IN ('A', 'C'))
                ) THEN
            IF INSERTING THEN
               v_cod_grupo_m := 0;
               v_cod_grupo_o := 0;

               IF :NEW.cod_grupo_solic_sist_usr IS NULL THEN
                  SELECT b.cod_grupo
                    INTO v_cod_grupo_m
                    FROM ifrseg.cad_sistema a,
                         ifrseg.cad_grupo b
                   WHERE a.cod_sistema = b.cod_sistema_grupo
                     AND b.dsc_grupo = a.dsc_sgl_sistema || '_M';

                  :NEW.cod_grupo_solic_sist_usr := v_cod_grupo_m;

                  SELECT b.cod_grupo
                    INTO v_cod_grupo_o
                    FROM ifrseg.cad_sistema a,
                         ifrseg.cad_grupo b
                   WHERE a.cod_sistema = b.cod_sistema_grupo
                     AND b.dsc_grupo = a.dsc_sgl_sistema || '_O';

                  :NEW.cod_grupo_obj_solic := v_cod_grupo_o;
               END IF;

               UPDATE cad_solicitacao_usuario
                  SET flg_situacao_solic = 'P',
                      dat_aprovacao = SYSDATE
                WHERE num_seq_solicitacao = :NEW.num_seq_solic_sist_usr;
            END IF;

            IF UPDATING THEN
               IF     :NEW.flg_situacao_solic_sist_usr = 'A'
                  AND :OLD.flg_situacao_solic_sist_usr = 'P' THEN
                  INSERT      /*+ NOPARALLEL(CAD_ACESSO, ) */INTO cad_acesso
                              (cod_grupo_acesso,
                               cod_usuario_acesso,
                               cod_sistema_acesso,
                               flg_consulta_acesso,
                               flg_inclusao_acesso,
                               flg_alteracao_acesso,
                               flg_exclusao_acesso,
                               num_cod_grupo_obj
                              )
                       VALUES (:NEW.cod_grupo_solic_sist_usr,
                               c.cod_usuario_solic,
                               :NEW.cod_sistema_solic_sist_usr,
                               :NEW.flg_consulta_solic_sist_usr,
                               :NEW.flg_inclusao_solic_sist_usr,
                               :NEW.flg_alteracao_solic_sist_usr,
                               :NEW.flg_exclusao_solic_sist_usr,
                               :NEW.cod_grupo_obj_solic
                              );

                  INSERT      /*+ NOPARALLEL(CAD_USUARIO_SISTEMA, ) */INTO cad_usuario_sistema
                              (cod_usuario_usr_sistema,
                               cod_grupo_usr_sistema,
                               cod_sistema_usr_sistema
                              )
                       VALUES (c.cod_usuario_solic,
                               :NEW.cod_grupo_solic_sist_usr,
                               :NEW.cod_sistema_solic_sist_usr
                              );

                  :NEW.flg_situacao_solic_sist_usr := 'C';
                  :NEW.dat_situacao_sist_usr := TRUNC (SYSDATE);
               END IF;
            END IF;
         ELSE
            IF :OLD.flg_situacao_solic_sist_usr NOT IN ('I', 'P', 'N') THEN
               raise_application_error
                                    (-20100,
                                     'Situação da Solicitação - '
                                     || c.flg_situacao_solic
                                     || ' não permite alteração ou exclusão !!!'
                                    );
            END IF;
         END IF;
      ELSE
         IF (   (:OLD.flg_situacao_solic_sist_usr IS NULL)
             OR (:OLD.flg_situacao_solic_sist_usr NOT IN ('A', 'C'))
            ) THEN
            IF DELETING THEN
               UPDATE cad_solicitacao_usuario
                  SET flg_situacao_solic = 'I',
                      dat_aprovacao = SYSDATE
                WHERE num_seq_solicitacao = :OLD.num_seq_solic_sist_usr;
            END IF;
         ELSE
            IF :OLD.flg_situacao_solic_sist_usr NOT IN ('I', 'P', 'N') THEN
               raise_application_error
                                    (-20100,
                                     'Situação da Solicitação - '
                                     || c.flg_situacao_solic
                                     || ' não permite alteração ou exclusão !!!'
                                    );
            END IF;
         END IF;
      END IF;
   END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      IF UPDATING THEN
         :NEW.flg_situacao_solic_sist_usr := 'N';
      END IF;

      raise_application_error
         (-20100,
          SQLERRM
          || ' Solicitação de cadastro de usuário não concluida. Favor Verificar.'
         );
END;
/
-- End of DDL Script for Trigger IFRSEG.TRG_CAD_SOLIC_SISTEMA_USR_01

