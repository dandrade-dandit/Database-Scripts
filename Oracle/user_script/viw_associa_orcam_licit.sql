/* Formatted on 2005/05/25 08:53 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW viw_associa_orcam_licit (
   seq_orcamento,
   dsc_titulo_orcamento,
   val_total_revisao,
   seq_licitacao_revisao,
   dsc_situacao_associacao,
   cod_pgose_licitacao,
   seq_licitacao,
   seq_pre_compromisso
)
AS
   SELECT cad_orcamento.seq_orcamento, cad_orcamento.dsc_titulo_orcamento,
          NVL (cad_revisao_orcamento.val_total_revisao, 0),
          NVL (cad_revisao_orcamento.seq_licitacao_revisao, 0),
          DECODE (
             cad_revisao_orcamento.seq_licitacao_revisao,
             0, 'Não Associado',
                'Associado    '
          )||' - Nome ='||cad_orcamento.dsc_titulo_orcamento||', Valor = '||NVL (cad_revisao_orcamento.val_total_revisao, 0),
          cad_licitacao.cod_pgose_licitacao, cad_pre_compromisso.seq_licitacao,
          cad_pre_compromisso.seq_pre_compromisso
     FROM ifrbde.cad_licitacao,
          ifrbde.cad_orcamento,
          ifrbde.cad_revisao_orcamento,
          ifrbde.cad_pre_compromisso
    WHERE cad_orcamento.cod_pgose_orcamento =
                                             cad_licitacao.cod_pgose_licitacao
      AND cad_orcamento.seq_orcamento = cad_revisao_orcamento.seq_orcamento
      AND cad_revisao_orcamento.cod_situacao_revisao = 'F'
      AND cad_licitacao.cod_pgose_licitacao IS NOT NULL
      AND cad_licitacao.seq_licitacao = cad_pre_compromisso.seq_licitacao
   UNION
   SELECT 0, ' ', 0, 0, ' ------------ Orçamento Inexistente ----------------',
          cad_licitacao.cod_pgose_licitacao, cad_pre_compromisso.seq_licitacao,
          cad_pre_compromisso.seq_pre_compromisso
     FROM ifrbde.cad_licitacao, ifrbde.cad_pre_compromisso
    WHERE cad_licitacao.seq_licitacao = cad_pre_compromisso.seq_licitacao
/
-- Grants for View
GRANT SELECT ON viw_associa_orcam_licit TO bde_geral
/

