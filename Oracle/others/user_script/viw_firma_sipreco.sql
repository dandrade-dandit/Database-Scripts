/* Formatted on 2005/08/24 18:40 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW viw_firma_sipreco (
   fir_cod,
   fir_nome,
   fir_razao,
   fir_contato,
   fir_fone,
   fir_fax,
   fir_email,
   fir_obs,
   fir_cnpj,
   dsc_endereco,
   dsc_complemento,
   dsc_bairro,
   dsc_cidade,
   num_cep,
   cod_status,
   tip_cnpj_cpf,
   sg_uf,
   sg_pais
)
AS
   SELECT a.fir_cod, a.fir_nome, a.fir_razao, a.fir_contato, a.fir_fone,
          a.fir_fax, a.fir_email, a.fir_obs, a.fir_cnpj, a.dsc_endereco,
          a.dsc_complemento, a.dsc_bairro, a.dsc_cidade, a.num_cep,
          a.cod_status, a.tip_cnpj_cpf, a.sg_uf, a.sg_pais
     FROM ifrbde.tab_firma a
   UNION
   SELECT (  ROWNUM
           + 50000000
          ), b.organization_operating_name,
          b.organization_operating_name, ' ', ' ', ' ', b.custom_field_12, ' ',
          TRIM (b.vendor_id), a.addr_line_1, a.street_or_post_office_box_1,
          a.street_or_post_office_box_2, a.city_name, a.postal_code, '0', 'OUT',
          a.country_sub_entity_code, b.country_code
     FROM ifrbde.viw_vendor_loc b, ifrbde.viw_vendor_loc_addr a
    WHERE b.vendor_id = a.vendor_id(+)
      AND b.vendor_loc_code = a.vendor_loc_code(+)
      AND TRIM (b.custom_field_10) = 'OTH'
      AND b.vendor_status_code = 'A'
      AND (TRIM (b.vendor_id), NVL (TRIM (b.vendor_loc_code), ' ')) NOT IN
                (SELECT TRIM (SUBSTR (c.fir_cnpj, 1, 10)), ' '
                   FROM ifrbde.tab_firma c
                  WHERE c.tip_cnpj_cpf = 'OUT');

/

-- Create synonym VIW_FIRMA
CREATE PUBLIC SYNONYM viw_firma_sipreco
  FOR viw_firma_sipreco
/

-- Grants for View
GRANT SELECT ON viw_firma_sipreco TO bde_geral
/

