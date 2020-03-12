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
           || a.fir_cnpj
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

