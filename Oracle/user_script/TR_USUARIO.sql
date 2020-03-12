/* Formatted on 2005/04/26 11:42 (Formatter Plus v4.8.0) */
CREATE OR REPLACE TRIGGER tr_usuario
   BEFORE INSERT OR UPDATE
   ON maxusergroups
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_depe                        usuario.user01%TYPE := '';
   v_nome                        usuario.user02%TYPE := '';
   v_grupo                       usuario.description%TYPE := '';
BEGIN
   IF INSERTING
   THEN
      BEGIN
         IF (SUBSTR (:NEW.usrname,
                     1,
                     1
                    ) = 'I')
         THEN
            BEGIN
               SELECT NAME,
                      la14
                 INTO v_nome,
                      v_depe
                 FROM labor
                WHERE laborcode = :NEW.usrname;

               IF (SUBSTR (:NEW.grpname,
                           1,
                           4
                          ) = v_depe)
               THEN
                  IF SUBSTR (:NEW.grpname,
                             4,
                             2
                            ) = '01'
                  THEN
                     v_grupo := SUBSTR (:NEW.grpname,
                                        1,
                                        4
                                       ) || '-CONSULTA';
                  END IF;

                  IF SUBSTR (:NEW.grpname,
                             4,
                             2
                            ) = '02'
                  THEN
                     v_grupo := SUBSTR (:NEW.grpname,
                                        1,
                                        4
                                       ) || '-REQUISITANTE';
                  END IF;

                  IF SUBSTR (:NEW.grpname,
                             4,
                             2
                            ) = '03'
                  THEN
                     v_grupo :=
                              SUBSTR (:NEW.grpname,
                                      1,
                                      4
                                     ) || '-ACOMPANHAMENTO';
                  END IF;

                  IF SUBSTR (:NEW.grpname,
                             4,
                             2
                            ) = '04'
                  THEN
                     v_grupo := SUBSTR (:NEW.grpname,
                                        1,
                                        4
                                       ) || '-COORDENADOR';
                  END IF;

                  INSERT INTO usuario
                              (usernum,
                               description,
                               user01,
                               user02
                              )
                  VALUES      (:NEW.usrname,
                               v_grupo,
                               v_depe,
                               v_name
                              );
               END IF;

               IF (SUBSTR (:NEW.grpname,
                           1,
                           4
                          ) <> v_depe)
               THEN
                  raise_application_error
                     (-20671,
                      'DEPENDÊNCIA CADASTRADA NA TABELA LABOR É INCOMPATÍVEL COM GRUPO SUGERIDO.');
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  raise_application_error
                     (-20670,
                      'USUÁRIO NÃO CADASTRADO NA APLICAÇÃO MÃO DE OBRA. FAVOR PROVIDENCIAR O CADASTRAMENTO.');
            END;
         END IF;
      END;
   END IF;
END;

