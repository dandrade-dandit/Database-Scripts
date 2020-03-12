/* Formatted on 2005/03/01 17:07 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_consolidado_reg_recurso (
   regional,
   cod_recurso,
   sigla_recurso,
   desc_recurso,
   pgose,
   valor_total_aprovado,
   valor_total_realizado,
   percentual_realizado
)
AS
   SELECT   'SEDE', viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso, viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose, SUM (viw_rel_atividade.valor),
            SUM (viw_rel_atividade.valorpago),
            (  (SUM (viw_rel_atividade.valorpago) * 100)
             / SUM (viw_rel_atividade.valor)
            )
                  percentual_realizado
       FROM ifrbde.viw_rel_atividade
      WHERE ((viw_rel_atividade.valor > 0))
      AND viw_rel_atividade.projeto = 'S'
   GROUP BY 'SEDE',
            viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose
union
   SELECT   viw_rel_atividade.cnsigla, viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso, viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose, SUM (viw_rel_atividade.valor),
            SUM (viw_rel_atividade.valorpago),
            (  (SUM (viw_rel_atividade.valorpago) * 100)
             / SUM (viw_rel_atividade.valor)
            )
                  percentual_realizado
       FROM ifrbde.viw_rel_atividade
      WHERE ((viw_rel_atividade.valor > 0))
      AND viw_rel_atividade.projeto = 'R'
   GROUP BY viw_rel_atividade.cnsigla,
            viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose
UNION
   SELECT   'TOT.', viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso, viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose, SUM (viw_rel_atividade.valor),
            SUM (viw_rel_atividade.valorpago),
            (  (SUM (viw_rel_atividade.valorpago) * 100)
             / SUM (viw_rel_atividade.valor)
            )
                  percentual_realizado
       FROM ifrbde.viw_rel_atividade
      WHERE ((viw_rel_atividade.valor > 0))
   GROUP BY 'TOT.',
            viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose            
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_consolidado_reg_recurso TO bde_geral
/

