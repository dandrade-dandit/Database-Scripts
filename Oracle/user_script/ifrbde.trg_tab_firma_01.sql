/* Formatted on 2005/05/12 10:42 (Formatter Plus v4.5.2) */
-- Start of DDL Script for Trigger IFRBDE.TRG_TAB_FIRMA_01
-- Generated 2-dez-2004 20:25:08 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_tab_firma_01
   BEFORE INSERT OR UPDATE
   ON ifrbde.tab_firma
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro              VARCHAR2 (200);
   v_sucesso           NUMBER (1);
   v_cnpj_cpf          VARCHAR2 (18);
   v_vendor_id         VARCHAR2 (10);
   v_vendor_loc_code   VARCHAR2 (3);

   CURSOR cur_financeira (p_vendor_id VARCHAR2, p_vendor_loc_code VARCHAR2)
   IS
      SELECT b.vendor_id, b.vendor_loc_code, b.organization_operating_name,
             a.addr_line_1, a.street_or_post_office_box_1,
             a.street_or_post_office_box_2, a.city_name, a.postal_code,
             a.phone_format_code, a.country_sub_entity_code, b.country_code,
             b.custom_field_12, b.vendor_status_code, b.custom_field_10
        
/*                          INTO v_nome, v_endereco,
                               v_complemento,
                               v_bairro, v_cidade,
                               v_cep, v_uf,
                               v_pais, v_fone,
                               v_mail, v_status
*/
        FROM ifrbde.viw_vendor_loc b, ifrbde.viw_vendor_loc_addr a
       WHERE a.vendor_id = b.vendor_id
         AND a.vendor_loc_code = b.vendor_loc_code
         AND a.vendor_id = p_vendor_id
         AND a.vendor_loc_code = p_vendor_loc_code;
--   
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
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
         ifrbde.prc_verifica_cpnj (:NEW.fir_cnpj);
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
         BEGIN
            
--
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
               v_vendor_id := SUBSTR (v_cnpj_cpf, 1, 10);
               v_vendor_loc_code := SUBSTR (v_cnpj_cpf, 11, 3);
            END IF;

            
--
            IF :NEW.tip_cnpj_cpf IN ('CPF', 'OUT')
            THEN
               v_vendor_id := SUBSTR (v_cnpj_cpf, 1, 10);
               v_vendor_loc_code := ' ';
            END IF;

            
--
--
            FOR x IN cur_financeira (v_vendor_id, v_vendor_loc_code)
            LOOP
               IF DECODE (
                     x.custom_field_10,
                     'JUR', 'CGC',
                     'OTH', 'OUT',
                     'FIS', 'CPF'
                  ) = :NEW.tip_cnpj_cpf
               THEN
                  IF x.vendor_status_code = 'A'
                  THEN
                     
--
                     :NEW.fir_razao := x.organization_operating_name;
                     :NEW.dsc_endereco := x.addr_line_1;
                     :NEW.dsc_complemento := x.street_or_post_office_box_1;
                     :NEW.dsc_bairro := x.street_or_post_office_box_2;
                     :NEW.dsc_cidade := x.city_name;
                     :NEW.num_cep := x.postal_code;
                     :NEW.fir_fone := x.phone_format_code;
                     :NEW.sg_uf := x.country_sub_entity_code;
                     :NEW.sg_pais := x.country_code;
                     :NEW.fir_email := x.custom_field_12;
                     :NEW.cod_status :=
                                    DECODE (x.vendor_status_code, 'A', '1', '4');
--                                    
--                   executar procedure de carga e checagem de contas correntes prc_carga_conta_corrente(fir_cod,v_vendor_id, v_vendor_loc_code)                
--
                  END IF;

                  v_erro :=
                        'Tipo e Número Empresa (CGC,CPF,OUTROS) não são compativeis com informação na financeira !!!';
                  v_sucesso := 1;
               END IF;
            END LOOP;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                     'Não foi localizado no SSContratos firma referente a este CPF/CNPJ!!!';
               v_sucesso := 1;
         END;
      END IF;
   
--      
   END IF;

   IF DELETING
   THEN
      IF :OLD.cod_status <> '5'
      THEN
         v_erro :=
                  'Empresa/CPF/Outros não esta em situação de ser excluida !';
         v_sucesso := 1;
      END IF;
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_FIRMA_01

