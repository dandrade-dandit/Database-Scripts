/* Formatted on 2007/01/05 10:29 (Formatter Plus v4.8.0) */
CREATE OR REPLACE VIEW viw_envio_contrato (cnt_cre_cod,
                                           cnt_cod,
                                           num_seq_contrato,
                                           tip_situacao_contrato,
                                           cod_dep_contrato,
                                           num_versao_contrato,
                                           tip_comando
                                          )
AS
   (SELECT cnt_cre_cod, cnt_cod, num_seq_contrato, tip_situacao_contrato,
           cod_dep_contrato, num_versao_contrato, 'I'
      FROM ifrbde.tab_contrato
     WHERE tip_situacao_contrato IN (2, 4)
       AND cnt_cre_cod IN (SELECT cre_cod
                             FROM ifrbde.viw_carencia))
/
-- Grants for View
GRANT SELECT ON viw_envio_contrato TO bde_geral
/

