Select distinct a.seq_chamado CHAMADO,
          to_char(a.dth_encerramento_efetivo,'rrrr') ANO, 
          to_char(a.dth_encerramento_efetivo,'mm') MES,          
          to_char(a.dth_abertura ,'dd/mm/yyyy hh24:mi:ss') ABERTURA, 
          to_char(a.dth_encerramento_efetivo, 'dd/mm/yyyy hh24:mi:ss') ENCERRAMENTO,
          tc.dsc_tipo_chamado TIPO,
          sc.dsc_subtipo_chamado SUBTIPO,
          ac.dsc_atividade_chamado ATIVIDADE,
          a.NUM_MATRICULA_SOLICITANTE MAT_SOLICITANTE,
          y.NUM_MATRICULA MAT_ATENDENTE,
          s.DSC_SITUACAO_CHAMADO SITUACAO,
          a.TXT_CHAMADO DSC_CHAMADO
  from IFRCRC.chamado a
    left join IFRCRC.atividade_chamado ac on a.seq_atividade_chamado = ac.seq_atividade_chamado
    left join IFRCRC.subtipo_chamado sc on ac.seq_subtipo_chamado = sc.seq_subtipo_chamado
    left join IFRCRC.tipo_chamado tc on sc.seq_tipo_chamado = tc.seq_tipo_chamado
    left join IFRCRC.SITUACAO_CHAMADO s on a.SEQ_SITUACAO_CHAMADO = s.SEQ_SITUACAO_CHAMADO
    left join IFRCRC.ATENDIMENTO_CHAMADO y on a.SEQ_CHAMADO = y.SEQ_CHAMADO
 where a.seq_chamado = 479417
    order by a.seq_chamado;



SELECT SEQ_ATRIBUICAO_CHAMADO,
  SEQ_CHAMADO,
  SEQ_EQUIPE_TI,
  SEQ_SITUACAO_CHAMADO,
  NUM_MATRICULA,
  TXT_ATIVIDADE,
  to_char(DTH_ATRIBUICAO, 'DD/MM/RRRR HH24:MI:SS') DTH_ATRIBUICAO,
  to_char(DTH_INICIO_EFETIVO, 'DD/MM/RRRR HH24:MI:SS') DTH_INICIO_EFETIVO,
  to_char(DTH_ENCERRAMENTO_EFETIVO, 'DD/MM/RRRR HH24:MI:SS') DTH_ENCERRAMENTO_EFETIVO,
  SEQ_EQUIPE_ATRIBUICAO,
  TXT_ENCERRAMENTO,
  NUM_HORAS_TRABALHADAS
FROM IFRCRC.ATRIBUICAO_CHAMADO 
where seq_chamado = 478821;


select  seq_chamado
     ,  num_matricula
     ,  to_char(dth_inicio, 'DD/MM/RRRR HH24:MI:SS') dth_inicio
     ,  to_char(dth_fim, 'DD/MM/RRRR HH24:MI:SS') dth_fim
from IFRCRC.time_sheet
 where seq_chamado = 478821;
 
 