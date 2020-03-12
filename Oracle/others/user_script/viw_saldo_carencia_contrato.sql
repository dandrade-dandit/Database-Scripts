/* Formatted on 2005/06/10 08:34 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW viw_saldo_carencia_contrato (
   num_cre_cod,
   val_total_recurso,
   val_total_contratado,
   val_total_aditivado,
   val_saldo_recurso
)
AS
   SELECT   a.cre_cod, a.val_total_recurso, SUM (b.val_total_contratado),
            SUM (b.val_total_aditivado),
            (  a.val_total_recurso
             - (  SUM (b.val_total_contratado)
                + SUM (b.val_total_aditivado)
               )
            )
       FROM ifrbde.viw_total_recurso_carencia a, ifrbde.viw_total_contrato b
      WHERE a.cre_cod = b.cre_cod
   GROUP BY a.cre_cod, a.val_total_recurso
/

-- Create synonym VIW_SALDO_CARENCIA_CONTRATO
CREATE PUBLIC SYNONYM viw_saldo_carencia_contrato
  FOR viw_saldo_carencia_contrato
/

-- Grants for View
GRANT SELECT ON viw_saldo_carencia_contrato TO bde_geral
/

