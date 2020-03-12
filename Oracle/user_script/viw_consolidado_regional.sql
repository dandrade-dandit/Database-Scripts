/* Formatted on 2005/03/08 10:48 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_consolidado_regional (
   sigla_regional,
   pgose,
   valor_total_aprovado,
   valor_total_realizado,
   percentual_realizado
)
AS
   SELECT   'SEDE', viw_rel_atividade.pgose,
            SUM (viw_rel_atividade.valor), SUM (viw_rel_atividade.valorpago),
              (SUM (viw_rel_atividade.valorpago) * 100)
            / (SUM (viw_rel_atividade.valor))
       FROM ifrbde.viw_rel_atividade 
       where viw_rel_atividade.projeto = 'S'
   GROUP BY 'SEDE', viw_rel_atividade.pgose
union
   SELECT   viw_rel_atividade.cnsigla, viw_rel_atividade.pgose,
            SUM (viw_rel_atividade.valor), SUM (viw_rel_atividade.valorpago),
              (SUM (viw_rel_atividade.valorpago) * 100)
            / (SUM (viw_rel_atividade.valor))
       FROM ifrbde.viw_rel_atividade
       where viw_rel_atividade.projeto = 'R'
   GROUP BY viw_rel_atividade.cnsigla, viw_rel_atividade.pgose
UNION
   SELECT   'TOT.', viw_rel_atividade.pgose, SUM (viw_rel_atividade.valor),
            SUM (viw_rel_atividade.valorpago),
              (SUM (viw_rel_atividade.valorpago) * 100)
            / (SUM (viw_rel_atividade.valor))
       FROM ifrbde.viw_rel_atividade
   GROUP BY 'TOT.', viw_rel_atividade.pgose
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_consolidado_regional TO bde_geral
/

