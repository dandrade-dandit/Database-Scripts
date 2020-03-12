Create Or Replace PROCEDURE PRC_EXCLUI_SST_CONTRATO (
   v_cnt_cod           IN   VARCHAR2,
   v_versao_contrato   IN   VARCHAR2
)
IS

--
-- OBJETIVO: excluir o contrato dos arquivos do SMARTSTREAM
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro      VARCHAR2 (200);
   v_sucesso   NUMBER (1);
BEGIN
   v_sucesso := 0;
   v_erro := '';

   DELETE FROM integracao.conf_item_projeto_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_item_cronograma_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_item_acct_distin_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_item_ident_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_item_reajuste_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_item_resumo_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

 --  DELETE FROM integracao.conf_item_usuario_u
 --        WHERE contract_id = v_cnt_cod AND contract_versao =
 --                                                           v_versao_contrato;

   DELETE FROM integracao.conf_objeto_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_participantes_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_publicacao_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_representantes_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_termo_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

 --  DELETE FROM integracao.conf_usuario_u
 --        WHERE contract_id = v_cnt_cod AND contract_versao =
 --                                                           v_versao_contrato;

   DELETE FROM integracao.conf_datas_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;

   DELETE FROM integracao.conf_identificacao_u
         WHERE contract_id = v_cnt_cod AND contract_versao =
                                                            v_versao_contrato;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'Erro ao excluir o contrato das tabelas do SmartStream - Entre em contato com analista responsavel '
         || SQLERRM
      );
END prc_exclui_sst_contrato; -- Procedure
