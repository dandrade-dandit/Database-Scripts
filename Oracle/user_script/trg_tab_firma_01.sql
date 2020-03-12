/* Formatted on 2005/09/08 15:07 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_firma_01
   BEFORE INSERT OR UPDATE
   ON ifrbde.tab_firma
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                     VARCHAR2 (600);
   v_sucesso                  NUMBER (1);
   v_existe                   NUMBER (1);
   v_cnpj_cpf                 VARCHAR2 (18);
   v_vendor_id                VARCHAR2 (10);
   v_vendor_loc_code          VARCHAR2 (3);
   v_vendor_tipo              VARCHAR2 (3);
   v_num_seq_conta_bancaria   NUMBER (15);

   CURSOR cur_financeira (
      p_vendor_id         VARCHAR2,
      p_vendor_loc_code   VARCHAR2,
      p_vendor_tipo       VARCHAR2
   )
   IS
      SELECT b.vendor_id, b.vendor_loc_code, b.organization_operating_name,
             a.addr_line_1, a.street_or_post_office_box_1,
             a.street_or_post_office_box_2, a.city_name, a.postal_code,
             a.phone_format_code, a.country_sub_entity_code, b.country_code,
             b.custom_field_12, b.vendor_status_code, b.custom_field_10
        FROM ifrbde.viw_vendor_loc b, ifrbde.viw_vendor_loc_addr a
       WHERE b.vendor_id = a.vendor_id(+)
         AND b.vendor_loc_code = a.vendor_loc_code(+)
         AND TRIM (b.vendor_id) = p_vendor_id
         AND NVL (TRIM (b.vendor_loc_code), ' ') = p_vendor_loc_code
         AND TRIM (b.custom_field_10) = p_vendor_tipo;

   CURSOR cur_conta_bancaria (
      p_vendor_id1         VARCHAR2,
      p_vendor_loc_code1   VARCHAR2
   )
   IS
      SELECT   a.vendor_id, a.vendor_loc_code, a.type_of_pmt, a.seq_nbr,
               a.default_flag, a.bank_acct_nbr, a.bank_name, a.bank_nbr,
               a.branch_name, a.addr_line, a.street_or_post_office_box_1,
               a.street_or_post_office_box_2, a.city_name,
               a.country_sub_entity_code, a.postal_code, a.name_on_acct,
               a.bank_acct_type_code, a.pmt_channel_code, a.chgstamp
          FROM ifrbde.viw_vendor_loc_bank_acct_u a
         WHERE TRIM (a.vendor_id) = p_vendor_id1
           AND TRIM (a.vendor_loc_code) = p_vendor_loc_code1
      ORDER BY a.seq_nbr;

   CURSOR cur_conta_corrente (p_fir_cod NUMBER, p_seq_nbr VARCHAR2)
   IS
      SELECT     a.num_seq_conta_bancaria, a.fir_cod,
                 a.num_seq_financeira_bancaria, a.num_banco, a.nom_banco,
                 a.num_agencia, a.num_conta, a.tip_situacao_conta
            FROM ifrbde.tab_conta_bancaria a
           WHERE a.fir_cod = p_fir_cod
             AND a.num_seq_financeira_bancaria = p_seq_nbr
      FOR UPDATE;
--   
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF INSERTING
   THEN
      :NEW.cod_status := NVL (:NEW.cod_status, '4');
   END IF;

   IF    INSERTING
      OR UPDATING
   THEN
      IF :NEW.cod_status <> '5'
      THEN
         IF :NEW.tip_cnpj_cpf NOT IN ('CGC', 'CPF', 'OUT')
         THEN
            v_erro :=
                  'Tipo de Empresa não cadastrada, favor selecionar CNPJ,CPF, OU OUTROS!!!';
            v_sucesso := 1;
         END IF;

         
--
--   EXECUTA A ROTINA DE CHECAGEM PARA CADA TIPO DE EMPRESA
--
         IF  :NEW.tip_cnpj_cpf = 'CGC' AND v_sucesso = 0
         THEN
            ifrbde.prc_verifica_cnpj (:NEW.fir_cnpj);
         END IF;

         
--
         IF  :NEW.tip_cnpj_cpf = 'CPF' AND v_sucesso = 0
         THEN
            ifrbde.prc_verifica_cpf (:NEW.fir_cnpj);
         END IF;

         
--
         IF  :NEW.tip_cnpj_cpf = 'OUT' AND v_sucesso = 0
         THEN
            ifrbde.prc_verifica_outros (:NEW.fir_cnpj);
         END IF;

         
--
--
--
         IF v_sucesso = 0
         THEN
            
--
            IF :NEW.cod_status NOT IN ('2', '3')
            THEN
               :NEW.fir_razao := '';
               :NEW.dsc_endereco := '';
               :NEW.dsc_complemento := '';
               :NEW.dsc_bairro := '';
               :NEW.dsc_cidade := '';
               :NEW.num_cep := '';
               :NEW.fir_fone := '';
               :NEW.sg_uf := '';
               :NEW.sg_pais := '';
               :NEW.fir_email := '';
               :NEW.cod_status := '4';
            END IF;

            
--
--   EXECUTA A ROTINA DE CARGA PARA CADA TIPO DE EMPRESA
--
            v_cnpj_cpf := '';

            
--   
            FOR contador IN 1 .. LENGTH (TRIM (:NEW.fir_cnpj))
            LOOP
               IF      SUBSTR (:NEW.fir_cnpj, contador, 1) >= '0'
                   AND SUBSTR (:NEW.fir_cnpj, contador, 1) <= '9'
               THEN
                  v_cnpj_cpf :=
                             v_cnpj_cpf
                          || SUBSTR (:NEW.fir_cnpj, contador, 1);
               END IF;
            END LOOP;

            
--
            IF :NEW.tip_cnpj_cpf = 'CGC'
            THEN
               v_vendor_id := SUBSTR (v_cnpj_cpf, 1, 9);
               v_vendor_loc_code := SUBSTR (v_cnpj_cpf, 10, 3);
               v_vendor_tipo := 'JUR';
            END IF;

            
--
            IF :NEW.tip_cnpj_cpf IN ('CPF')
            THEN
               v_vendor_id := SUBSTR (v_cnpj_cpf, 1, 9);
               v_vendor_loc_code := ' ';
               v_vendor_tipo := 'FIS';
            END IF;

            
--
            IF :NEW.tip_cnpj_cpf IN ('OUT')
            THEN
               v_vendor_id := SUBSTR (v_cnpj_cpf, 1, 10);
               v_vendor_loc_code := ' ';
               v_vendor_tipo := 'OTH';
            END IF;

            
--
            FOR x IN cur_financeira (
                        v_vendor_id,
                        v_vendor_loc_code,
                        v_vendor_tipo
                     )
            LOOP
               IF x.vendor_status_code = 'A'
               THEN
                  
--
                  :NEW.fir_razao :=
                                SUBSTR (x.organization_operating_name, 1, 50);
                  :NEW.dsc_endereco := SUBSTR (x.addr_line_1, 1, 35);
                  :NEW.dsc_complemento :=
                                SUBSTR (x.street_or_post_office_box_1, 1, 35);
                  :NEW.dsc_bairro :=
                                SUBSTR (x.street_or_post_office_box_2, 1, 35);
                  :NEW.dsc_cidade := SUBSTR (x.city_name, 1, 35);
                  :NEW.num_cep := SUBSTR (x.postal_code, 1, 9);
                  :NEW.fir_fone := SUBSTR (x.phone_format_code, 1, 20);
                  :NEW.sg_uf := SUBSTR (x.country_sub_entity_code, 1, 2);
                  :NEW.sg_pais := SUBSTR (x.country_code, 1, 2);
                  :NEW.fir_email := SUBSTR (x.custom_field_12, 1, 50);
                  :NEW.cod_status := '1';

                  
--                                    
--                   executar procedure de carga e checagem de contas correntes                 
--
                  BEGIN
                     FOR css IN cur_conta_bancaria (
                                   v_vendor_id,
                                   v_vendor_loc_code
                                )
                     LOOP
                        v_existe := 0;

                        FOR csi IN cur_conta_corrente (
                                      :NEW.fir_cod,
                                      css.seq_nbr
                                   )
                        LOOP
/*                           IF    TRIM (csi.num_banco) <> TRIM (css.bank_nbr)
                              OR TRIM (csi.num_agencia) <>
                                                       TRIM (css.branch_name)
                              OR TRIM (csi.num_conta) <>
                                                     TRIM (css.bank_acct_nbr)
                           THEN
                              v_erro :=
                                       'A mesma Sequencia Bancaria '
                                    || TRIM (css.seq_nbr)
                                    || ' Banco : '
                                    || TRIM (css.bank_nbr)
                                    || ' Agencia : '
                                    || TRIM (css.branch_name)
                                    || ' Conta : '
                                    || TRIM (css.bank_acct_nbr)
                                    || ' não pertence a mesma conta corrente'
                                    || ' Banco : '
                                    || TRIM (csi.num_banco)
                                    || ' Agencia : '
                                    || TRIM (csi.num_agencia)
                                    || ' Conta : '
                                    || TRIM (csi.num_conta)
                                    || ' desta empresa , cnpj : '
                                    || :NEW.fir_cnpj;
                              v_sucesso := 1;
                           ELSE
*/                              UPDATE ifrbde.tab_conta_bancaria
                                 SET num_banco =
                                           TRIM (SUBSTR (css.bank_nbr, 1, 3)),
                                     nom_banco =
                                         TRIM (SUBSTR (css.bank_name, 1, 70)),
                                     num_agencia =
                                        TRIM (
                                           SUBSTR (css.branch_name, 1, 17)
                                        ),
                                     num_conta =
                                        TRIM (
                                           SUBSTR (css.bank_acct_nbr, 1, 17)
                                        ),
                                     tip_situacao_conta = css.default_flag
                               WHERE  CURRENT OF cur_conta_corrente;
--                           END IF;

                           v_existe := 1;
                        END LOOP;

                        IF v_existe = 0
                        THEN
                           SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
                             INTO v_num_seq_conta_bancaria
                             FROM DUAL;

                           INSERT INTO ifrbde.tab_conta_bancaria
                                       (num_seq_conta_bancaria,
                                        fir_cod,
                                        num_seq_financeira_bancaria,
                                        num_banco,
                                        nom_banco,
                                        num_agencia,
                                        num_conta,
                                        tip_situacao_conta)
                                VALUES (v_num_seq_conta_bancaria,
                                        :NEW.fir_cod,
                                        TRIM (SUBSTR (css.seq_nbr, 1, 3)),
                                        TRIM (SUBSTR (css.bank_nbr, 1, 3)),
                                        TRIM (SUBSTR (css.bank_name, 1, 70)),
                                        TRIM (
                                           SUBSTR (css.branch_name, 1, 17)
                                        ),
                                        TRIM (
                                           SUBSTR (css.bank_acct_nbr, 1, 17)
                                        ),
                                        TRIM (
                                           SUBSTR (css.default_flag, 1, 1)
                                        ));
                        END IF;
                     END LOOP;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_erro :=
                                 'Erro ao localizar as contas correntes da empresa '
                              || SQLERRM;
                        v_sucesso := 1;
                  END;
               ELSE
                  :NEW.cod_status := '5';
               END IF;
            END LOOP;
         END IF;
      END IF;
   
--      
   END IF;

   
--
   IF DELETING
   THEN
      IF :OLD.cod_status NOT IN ('4', '5')
      THEN
         v_erro :=
                  'Empresa/CPF/Outros não esta em situação de ser excluida !';
         v_sucesso := 1;
      ELSE
         BEGIN
            DELETE FROM ifrbde.tab_conta_bancaria
                  WHERE fir_cod = :OLD.fir_cod;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao Excluir as contas correntes da empresa '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

