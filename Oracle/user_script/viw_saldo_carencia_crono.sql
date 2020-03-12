-- Start of DDL Script for View IFRBDE.VIW_SALDO_CARENCIA_CRONO
-- Generated 2-dez-2004 20:19:16 from SYSMAN@HOMOLOG2

CREATE OR REPLACE VIEW ifrbde.viw_saldo_carencia_crono (
   num_seq_carencia,
   ano_pgose,
   val_total_recurso,
   val_total_cronogramado,
   val_saldo_cronogramado )
AS
SELECT viw_total_recurso_carencia_ano.cre_cod,
         viw_total_recurso_carencia_ano.cre_pgose,
         NVL (viw_total_recurso_carencia_ano.val_total_recurso, 0),
         NVL (viw_total_cronograma_real.val_total_cronogramado, 0),
         (  NVL (viw_total_recurso_carencia_ano.val_total_recurso, 0)
          - NVL (viw_total_cronograma_real.val_total_cronogramado, 0)
         )
    FROM  viw_total_recurso_carencia_ano , viw_total_cronograma_real
   WHERE viw_total_recurso_carencia_ano.cre_cod =
                                    viw_total_cronograma_real.num_carencia(+)

          AND viw_total_recurso_carencia_ano.cre_pgose =
                                       viw_total_cronograma_real.ano_pgose(+)
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_saldo_carencia_crono TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_SALDO_CARENCIA_CRONO

