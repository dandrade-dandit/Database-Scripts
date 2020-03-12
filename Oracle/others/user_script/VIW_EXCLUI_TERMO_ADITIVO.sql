CREATE OR REPLACE VIEW viw_exclui_termo_aditivo (
   cnt_cre_cod_res_ex,
   cnt_cod_res_ex,
   num_versao_contrato_res_ex )
AS
SELECT b.cnt_cre_cod,
          b.cnt_cod,
          a.num_versao_contrato_res
     FROM ifrbde.cad_resumo_valores a,
          ifrbde.tab_contrato b
    WHERE a.num_seq_contrato_res = b.num_seq_contrato
      AND b.cnt_cre_cod IN (SELECT cre_cod
                              FROM ifrbde.viw_carencia)
      AND TO_NUMBER (a.num_versao_contrato_res) > 0
/

-- Grants for View
GRANT SELECT ON viw_exclui_termo_aditivo TO bde_geral
/


