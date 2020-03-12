/* Formatted on 2005/09/08 11:26 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_entidade_firma (
   cod_firma,
   nom_firma,
   num_cnpj,
   nom_completo
)
AS
   SELECT a.fir_cod, a.fir_nome, a.fir_cnpj,
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
           || ' Situação :'
           || DECODE (
                 a.cod_status,
                 '1', ' Origem na financeira ',
                 '2', ' Origem na Licitação  ',
                 '3', ' Origem no Orçamento  ',
                 '4', ' Pendente na origem   ',
                 '5', ' Cancelada            '
              )
          )
     FROM ifrbde.tab_firma a,
          ifrbde.cad_participantes_contrato b,
          ifrbde.aux_usuario_contrato c
    WHERE b.num_seq_contrato_part = c.num_seq_contrato_aux
      AND b.num_fir_cod = a.fir_cod
      AND c.nom_username = USER
      AND c.tip_parte_contrato = 'R'
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_entidade_firma TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_ENTIDADE_FIRMA

