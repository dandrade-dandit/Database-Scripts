

CREATE OR REPLACE VIEW viw_firma_contrato (
   contrato, firma, sequencial)
AS
   SELECT cnt.cnt_cod, fir.fir_nome, cnt.cnt_cre_cod
     FROM ifrbde.tab_contrato cnt,
          ifrbde.tab_firma fir,
          ifrbde.cad_participantes_contrato cpc
    WHERE cpc.num_seq_contrato_part = cnt.num_seq_contrato
      AND cpc.num_fir_cod = fir.fir_cod
/

-- Grants for View
GRANT DELETE ON viw_firma TO bde_geral
/
GRANT INSERT ON viw_firma TO bde_geral
/
GRANT SELECT ON viw_firma TO bde_geral
/
GRANT UPDATE ON viw_firma TO bde_geral
/



