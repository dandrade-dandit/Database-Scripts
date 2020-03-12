/* Formatted on 2005/10/10 16:53 (Formatter Plus v4.8.0) */
-- Start of DDL Script for View IFRBDE.VIW_CARENCIA
-- Generated 10-out-2005 16:52:36 from IFRBDE@homolog

CREATE OR REPLACE VIEW viw_carencia (cre_cod,
                                     cre_dep_cod,
                                     cre_tipo,
                                     cre_aen_subcod,
                                     cre_ntf_cod,
                                     cre_inicio,
                                     cre_termino,
                                     cre_data,
                                     cre_vlobras,
                                     cre_projeto,
                                     cre_pgi,
                                     cre_total_pago,
                                     cre_usuario,
                                     cre_prazo,
                                     num_seq_pessoal_carencia,
                                     cre_desc,
                                     cre_justificativa,
                                     cod_cliente,
                                     cod_detalhe_cliente,
                                     num_prioridade_carencia,
                                     dsc_critica_carencia,
                                     num_situacao_carencia,
                                     num_prioridade_superint
                                    )
AS
   (((SELECT cre_cod, cre_dep_cod, cre_tipo, cre_aen_subcod, cre_ntf_cod,
             cre_inicio, cre_termino, cre_data, cre_vlobras, cre_projeto,
             cre_pgi, cre_total_pago, cre_usuario, cre_prazo,
             num_seq_pessoal_carencia, cre_desc, cre_justificativa,
             cod_cliente, cod_detalhe_cliente, num_prioridade_carencia,
             dsc_critica_carencia, num_situacao_carencia,
             num_prioridade_superint
        FROM ifrbde.tab_carencia
       WHERE cre_dep_cod IN (SELECT dep_cd_dependencia
                               FROM viw_usuario_dependencia_bde)
         AND cre_projeto IN (SELECT cod_projeto
                               FROM viw_usuario_projeto))))
/
-- Grants for View
GRANT DELETE ON viw_carencia TO bde_geral
/
GRANT INSERT ON viw_carencia TO bde_geral
/
GRANT SELECT ON viw_carencia TO bde_geral
/
GRANT UPDATE ON viw_carencia TO bde_geral
/
-- End of DDL Script for View IFRBDE.VIW_CARENCIA

