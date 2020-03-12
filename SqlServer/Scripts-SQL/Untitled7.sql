--create or replace view ifrgestao_ti.VIW_CHAMADOS as
select
        a.seq_chamado
     ,  nvl(a.num_chamado_pai, 0) as num_chamado_pai
     ,  ac.seq_atribuicao_chamado
     ,  a.num_matricula_solicitante
     ,  a.seq_atividade_chamado
     --,  a.seq_situacao_chamado
     ,  nvl(a.seq_localizacao_fisica,0) as seq_localizacao_fisica
     ,  a.seq_prioridade_chamado
     ,  nvl(a.seq_item_configuracao, 0) as seq_item_configuracao
     ,  nvl(a.seq_avaliacao_atendimento,0) as seq_avaliacao_atendimento
     ,  ac.seq_equipe_ti
     ,  ac.seq_situacao_chamado
     ,  nvl(ac.num_matricula,0) as num_matricula
     ,  nvl(ac.seq_equipe_atribuicao,0) as seq_equipe_atribuicao
     ,  to_char(a.dth_abertura, 'YYYY') as ano_abertura_cham
     ,  to_char(a.dth_abertura, 'MM') as mes_abertura_cham
     ,  to_char(a.dth_abertura, 'DD') as dia_abertura_cham
     ,  to_char(a.dth_abertura, 'HH') as hr_abertura_cham
     ,  to_char(a.dth_abertura, 'MI') as mim_abertura_cham
     ,  a.dth_abertura
     --,  a.dth_triagem_efetiva
     --,  a.dth_inicio_previsao
     --,  a.dth_inicio_efetivo dth_inicio_efetivo_cham
     --,  a.dth_encerramento_efetivo dth_encerramento_efetivo_cham
     --,  (trunc((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24) - trunc((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24))*60))) as ind1
     ,  ac.dth_atribuicao 
     ,  ac.dth_inicio_efetivo
     ,  ac.dth_encerramento_efetivo
     ,  NVL(to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))), 0) as ind2
     ,  NVL(TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))), 0) as ind3
     ,  CASE 
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) < 30 THEN 1
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 31 AND 60 THEN 2
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 61 AND 90 THEN 3
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 91 AND 120 THEN 4
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 121 AND 180 THEN 5
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 181 AND 240 THEN 6
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 241 AND 300 THEN 7
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 301 AND 360 THEN 8
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) > 361  THEN 9
           ELSE 0                                                                             
        END AS IND4
     ,  CASE 
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) < 30 THEN 1
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 31 AND 60 THEN 2
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 61 AND 90 THEN 3
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 91 AND 120 THEN 4
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 121 AND 180 THEN 5
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 181 AND 240 THEN 6
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 241 AND 300 THEN 7
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 301 AND 360 THEN 8
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) > 361  THEN 9
           ELSE 0                                                                             
        END AS IND5
  from  chamado a
     ,  atribuicao_chamado ac
 where  a.seq_chamado = ac.seq_chamado
   --and  a.seq_chamado = 60571
