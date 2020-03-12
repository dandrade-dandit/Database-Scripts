/* Formatted on 2005/09/08 11:26 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW viw_firma_participante (
   fir_cod, fir_nome_completo)
AS
   SELECT a.fir_cod,
          (   TRIM (NVL (a.fir_razao, a.fir_nome))
           || ' - '
           || TRIM (NVL (a.dsc_cidade, '__________'))
           || '/'
           || NVL (a.sg_uf, '___')
           || ' - '
           || DECODE (
                 a.tip_cnpj_cpf,
                 'CGC', ' CNPJ...: ',
                 'CPF', ' CPF....: ',
                 'OUT', ' OUTROS.: '
              )
           || a.fir_cnpj
           || ' - Situação : '
           || DECODE (
                 a.cod_status,
                 '1', ' Origem na financeira ',
                 '2', ' Origem na Licitação  ',
                 '3', ' Origem no Orçamento  ',
                 '4', ' Pendente na origem   ',
                 '5', ' Cancelada            '
              )
          )
     FROM ifrbde.tab_firma a
/

-- Create synonym VIW_FIRMA
CREATE PUBLIC SYNONYM viw_firma_participante
  FOR viw_firma_sipreco
/

-- Grants for View
GRANT SELECT ON viw_firma_participante TO bde_geral
/

