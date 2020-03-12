/* Formatted on 18/02/2005 17:06 (Formatter Plus v4.8.0) */
CREATE OR REPLACE VIEW ifrseg.viw_log (num_seq_log,
                                       data_log,
                                       sistema,
                                       viw_tabela,
                                       username,
                                       nome,
                                       unidade,
                                       tipo,
                                       descricao
                                      ) AS
   SELECT   /*+ NOPARALLEL(TAB_LOG, TAB_ACESSO, CAD_USUARIO, CAD_SISTEMA, CAD_TABELA ) */
            tab_log.num_seq_log,
            TO_CHAR (tab_log.dat_log, 'DD/MM/YYYY HH24:MI:SS'),
            cad_sistema.nom_sistema,
            cad_tabela.nom_tabela_tabela,
            cad_usuario.nom_username,
            cad_usuario.nom_usuario,
            cad_usuario.sgl_unidade,
            tab_log.flg_tipo_log,
            tab_log.dsc_dado_log
       FROM ifrseg.tab_log,
            ifrseg.tab_acesso,
            ifrseg.cad_usuario,
            ifrseg.cad_sistema,
            ifrseg.cad_tabela
      WHERE (    (tab_acesso.num_sessionid = tab_log.num_sessionid_log)
             AND (cad_sistema.cod_sistema = tab_acesso.cod_sistema_acesso)
             AND (tab_acesso.nom_username_acesso = cad_usuario.nom_username)
             AND (cad_tabela.num_seq_tabela = tab_log.num_seq_tabela_log)
            )
   ORDER BY tab_log.dat_log DESC
/
GRANT SELECT ON ifrseg.viw_log TO seg_geral

