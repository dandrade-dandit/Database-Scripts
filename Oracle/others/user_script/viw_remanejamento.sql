-- Start of DDL Script for View IFRBDE.VIW_REMANEJAMENTO
-- Generated 29-mar-2005 13:50:29 from IFRBDE@HOMOLOG2

CREATE OR REPLACE VIEW viw_remanejamento (
   rmj_cod,
   rmj_ano,
   rmj_seq_orig,
   rmj_seq_dest,
   rmj_valor,
   rmj_rti_cod_orig,
   rmj_rti_cod_dest,
   rmj_usuario,
   rmj_dep_orig,
   rmj_dep_dest,
   rmj_obj_orig,
   rmj_obj_dest,
   dat_remanejamento,
   dsc_justificativa,
   val_aprovacao_origem,
   val_aprovacao_destino )
AS
SELECT a.rmj_cod, a.rmj_ano, a.rmj_seq_orig, a.rmj_seq_dest, a.rmj_valor,
       a.rmj_rti_cod_orig, a.rmj_rti_cod_dest, a.rmj_usuario, bd.dep_cod,
       cd.dep_cod, b.cre_desc, c.cre_desc, a.dat_remanejamento,a.dsc_justificativa,
       (a.val_aprovacao_origem),
       (a.val_aprovacao_destino)       
  FROM ifrbde.tab_remanejamento a,
       ifrbde.tab_carencia b,
       ifrbde.tab_carencia c,
       ifrbde.tab_dependencia bd,
       ifrbde.tab_dependencia cd
 WHERE a.rmj_seq_orig = b.cre_cod
   AND a.rmj_seq_dest = c.cre_cod
   AND b.cre_dep_cod = bd.dep_cod
   AND c.cre_dep_cod = cd.dep_cod
/

-- Create synonym VIW_REMANEJAMENTO
CREATE PUBLIC SYNONYM viw_remanejamento
  FOR viw_remanejamento
/

-- Grants for View
GRANT DELETE ON viw_remanejamento TO bde_geral
/
GRANT INSERT ON viw_remanejamento TO bde_geral
/
GRANT SELECT ON viw_remanejamento TO bde_geral
/
GRANT UPDATE ON viw_remanejamento TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REMANEJAMENTO

