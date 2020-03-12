SELECT nome_atendente,
       nom_equipe_ti,
       MIN (dth_inicio_timesheet) INICIO_REL,
       MAX (dth_fim_timesheet) FIM_REL,
       TRUNC(SUM(tempo_gasto)/60/60,0) HORA_TRABALHADAS,
       TRUNC((ROUND(SUM(tempo_gasto)/60/60,2) - TRUNC(SUM(tempo_gasto)/60/60,0))*60) MINUTOS_TRBALHADOS,
       (((ROUND(SUM(tempo_gasto)/60/60,2) - TRUNC(SUM(tempo_gasto)/60/60,0))*60) - TRUNC((ROUND(SUM(tempo_gasto)/60/60,2) - TRUNC(SUM(tempo_gasto)/60/60,0))*60))*60    SEGUNDOS_TRBALHADOS
  FROM (SELECT a.seq_chamado,
               c.nom_equipe_ti,
               d.dsc_situacao_chamado,
               a.num_matricula,
               f.nome nome_atendente,
               a.txt_atividade,
               a.dth_atribuicao,
               a.dth_inicio_efetivo,
               a.dth_encerramento_efetivo,
               b.dsc_equipe_atribuicao,
               a.txt_encerramento,
               e.dth_inicio dth_inicio_timesheet,
               e.dth_fim dth_fim_timesheet,
               e.seq_time_sheet,
               CASE
                  WHEN ROUND ( ( (e.dth_fim - e.dth_inicio) * 24 * 60 * 60), 0
                       ) < 0
                  THEN
                     ROUND ( ( (e.dth_fim - e.dth_inicio) * 24 * 60 * 60), 0)
                     * -1
                  WHEN ROUND ( ( (e.dth_fim - e.dth_inicio) * 24 * 60 * 60), 0
                       ) > 0
                  THEN
                     ROUND ( ( (e.dth_fim - e.dth_inicio) * 24 * 60 * 60), 0)
                  ELSE
                     0
               END
                  tempo_gasto
          FROM ifrgestao_ti.atribuicao_chamado a,
               ifrgestao_ti.equipe_atribuicao b,
               ifrgestao_ti.equipe_ti c,
               ifrgestao_ti.situacao_chamado d,
               ifrgestao_ti.time_sheet e,
               ifragenda.viw_age_empregados f
         WHERE     a.seq_equipe_atribuicao = b.seq_equipe_atribuicao
               AND a.seq_equipe_ti = c.seq_equipe_ti
               AND a.seq_situacao_chamado = d.seq_situacao_chamado
               AND a.seq_chamado = e.seq_chamado
               AND a.num_matricula = e.num_matricula
               AND (TO_NUMBER (SUBSTR (LPAD (f.cpf, 9, '0'), 1, 9)) =
                       TO_NUMBER (e.num_matricula)
                    OR f.matricula = e.num_matricula)
               AND a.seq_equipe_ti = 284
               AND e.dth_inicio >=
                     TO_DATE ('01/04/2009 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
               AND e.dth_inicio <
                     TO_DATE ('01/05/2009 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
        ORDER BY e.dth_inicio, e.seq_time_sheet)
GROUP BY nome_atendente, nom_equipe_ti
ORDER BY 5
/* Formatted on 9-abr-2009 12:49:26 (QP5 v5.120.811.25008) */
