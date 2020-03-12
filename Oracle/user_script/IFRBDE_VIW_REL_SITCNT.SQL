CREATE OR REPLACE VIEW IFRBDE.VIW_REL_SITCNT
 (
 PROGRAMA, CN, CNCOD, DEPENDENCIA, DEPCOD, SEQUENCIAL, CONTRATO, OBJETO, 
DSC_SITUACAO, SITUACAO, FISCAL, GESTOR
 )
 AS 
SELECT   cre.cre_projeto, cn.dpp_desc, cn.dpp_cod, dep.dep_sigla, dep.dep_cod,
         cre.cre_cod, cnt.cnt_cod, cnt.cnt_justificativa_cre,
         DECODE (
            cnt.tip_situacao_contrato,
            1, 'Não Revisado - Encerrado',
            2, 'Não Revisado - Ativo',
            3, 'Revisado - Encerrado',
            4, 'Revisado - Ativo',
            5, 'Revisado - Incompleto',
            6, 'Enviado a Financeira',
            7, 'Ativo na Financeira'
         ),
         cnt.tip_situacao_contrato,
         fsc.nome, rep.nom_responsavel
    FROM ifrbde.tab_contrato cnt,
         ifrbde.tab_dependencia dep,
         ifrbde.tab_dependencia_pai cn,
         ifrbde.tab_carencia cre,
         ifrbde.viw_fiscal fsc,
         ifrbde.cad_responsaveis rep
   WHERE dep.dep_dpp_cod = cn.dpp_cod
     AND cre.cre_dep_cod = dep.dep_cod
     AND cnt.num_seq_gestor = rep.num_seq_pessoal
     AND cnt.num_seq_contrato = fsc.contrato(+)
     AND cnt.cnt_cre_cod = cre.cre_cod
ORDER BY 1, 2, 3, 4
/
