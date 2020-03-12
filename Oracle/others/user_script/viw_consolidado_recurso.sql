/* Formatted on 2005/03/01 17:08 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_consolidado_recurso (
   cod_grupo,
   cod_recurso,
   sigla_recurso,
   desc_recurso,
   pgose,
   valor_total_aprovado,
   valor_total_realizado,
   percentual_realizado
)
AS
   SELECT   '1',viw_rel_atividade.recursocod, viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc, viw_rel_atividade.pgose,
            SUM (viw_rel_atividade.valor), SUM (viw_rel_atividade.valorpago),
              SUM (viw_rel_atividade.valorpago)
            * 100
            / SUM (viw_rel_atividade.valor)
       FROM ifrbde.viw_rel_atividade
      WHERE viw_rel_atividade.valor > 0
      and SUBSTR(viw_rel_atividade.recursocod,1,2) IN ('01','02')
   GROUP BY '1',viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose
UNION
   SELECT   '2',viw_rel_atividade.recursocod, viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc, viw_rel_atividade.pgose,
            SUM (viw_rel_atividade.valor), SUM (viw_rel_atividade.valorpago),
              SUM (viw_rel_atividade.valorpago)
            * 100
            / SUM (viw_rel_atividade.valor)
       FROM ifrbde.viw_rel_atividade
      WHERE viw_rel_atividade.valor > 0
      and SUBSTR(viw_rel_atividade.recursocod,1,2) NOT IN ('01','02')
   GROUP BY '1',viw_rel_atividade.recursocod,
            viw_rel_atividade.recurso,
            viw_rel_atividade.recursodesc,
            viw_rel_atividade.pgose
            
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_consolidado_recurso TO bde_geral
/

