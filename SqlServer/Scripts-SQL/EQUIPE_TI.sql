SELECT a.seq_equipe_ti, a.nom_equipe_ti, a.num_matricula_lider,
       a.num_matricula_substituto, a.num_matricula_priorizador,
       a.cod_dependencia
  FROM ifrgestao_ti.equipe_ti a
  WHERE a.seq_equipe_ti IN (401, 284, 421)

-- PARA GERENCIAR SERVIÇO DE DBA
--SERVIÇO DE AD
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL    WHERE seq_equipe_ti = 401; 
--SERVIÇO DE DBA
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = 1190738 WHERE seq_equipe_ti = 284; 
--SERVIÇO DE DW
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL WHERE seq_equipe_ti = 421; 
COMMIT;

-- PARA GERENCIAR SERVIÇO DE AD
--SERVIÇO DE AD
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = 1190738    WHERE seq_equipe_ti = 401; 
--SERVIÇO DE DBA
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL WHERE seq_equipe_ti = 284; 
--SERVIÇO DE DW
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL WHERE seq_equipe_ti = 421; 
COMMIT;

-- PARA GERENCIAR SERVIÇO DE DW
--SERVIÇO DE AD
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL    WHERE seq_equipe_ti = 401; 
--SERVIÇO DE DBA
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = NULL WHERE seq_equipe_ti = 284; 
--SERVIÇO DE DW
UPDATE ifrgestao_ti.equipe_ti SET num_matricula_priorizador = 1190738 WHERE seq_equipe_ti = 421; 
COMMIT;


--PARA GERENCIAR TODOS
update ifrgestao_ti.equipe_ti set   num_matricula_priorizador = 1190738
  WHERE seq_equipe_ti IN (401, 284, 421)



UPDATE ifrgestao_ti.atribuicao_chamado SET
  "DTH_INICIO_EFETIVO" = TO_DATE('2009-09-23 08:06:41','YYYY-MM-DD HH24:MI:SS'),
  "DTH_ENCERRAMENTO_EFETIVO" = TO_DATE('2009-09-23 11:19:33','YYYY-MM-DD HH24:MI:SS')
  where seq_chamado = 19848
  and   seq_atribuicao_chamado = 30499
  
UPDATE ifrgestao_ti.chamado SET
  "DTH_ENCERRAMENTO_EFETIVO" = TO_DATE('2009-09-23 11:19:33','YYYY-MM-DD HH24:MI:SS')
  where seq_chamado = 19848
  
UPDATE ifrgestao_ti.time_sheet SET
  "DTH_INICIO" = TO_DATE('2009-09-23 08:06:41','YYYY-MM-DD HH24:MI:SS'),
  "DTH_FIM" = TO_DATE('2009-09-23 11:19:34','YYYY-MM-DD HH24:MI:SS')
  where seq_chamado = 19848
  and seq_time_sheet = 90460
  
  
SELECT a.seq_time_sheet, a.seq_chamado, a.num_matricula, a.dth_inicio,
       a.dth_fim
  FROM ifrgestao_ti.time_sheet a
  where seq_chamado = 19848
  and seq_time_sheet = 90460
  
SELECT a.seq_atribuicao_chamado, a.seq_chamado, a.seq_equipe_ti,
       a.seq_situacao_chamado, a.num_matricula, a.txt_atividade,
       a.dth_atribuicao, a.dth_inicio_efetivo,
       a.dth_encerramento_efetivo, a.seq_equipe_atribuicao,
       a.txt_encerramento
  FROM ifrgestao_ti.atribuicao_chamado a
  where seq_chamado = 19848
  and   seq_atribuicao_chamado = 30499
  

SELECT a.seq_chamado, a.num_matricula_solicitante,
       a.seq_atividade_chamado, a.seq_situacao_chamado,
       a.seq_localizacao_fisica, a.seq_prioridade_chamado,
       a.txt_chamado, a.dth_abertura, a.dth_triagem_efetiva,
       a.dth_inicio_previsao, a.dth_inicio_efetivo,
       a.dth_encerramento_efetivo, a.dth_agendamento,
       a.num_matricula_contato, a.seq_item_configuracao,
       a.num_prioridade_fila, a.flg_solicitacao_atendida,
       a.num_matricula_avaliador, a.txt_avaliacao,
       a.seq_avaliacao_atendimento
  FROM ifrgestao_ti.chamado a
  where seq_chamado = 19848
  
  
--HORAS DO MÊS
  

SELECT  T.NOME
,       TO_CHAR(T.DTH_INICIO, 'DD') AS DIA
,       TO_CHAR(T.DTH_INICIO, 'MM') AS MES
,       TO_CHAR(TRUNC(SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60)) || ' HORAS' AS HORA_CHAMADO
,       TO_CHAR(ROUND((SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60 - TRUNC(SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60))*60,0)) || ' MINUTOS' AS MINUTO_CHAMADO
FROM (
SELECT  a.seq_time_sheet, 
        a.num_matricula, 
        (SELECT NOME FROM VIW_AGE_EMPREGADOS WHERE SUBSTR(CPF,1,9) = a.num_matricula) AS NOME , 
        a.dth_inicio,
        a.dth_fim
  FROM  ifrgestao_ti.time_sheet a
  ,     ifrgestao_ti.recurso_ti b
  WHERE a.num_matricula = b.num_matricula_recurso
    AND b.seq_equipe_ti IN (401, 284, 421)
    AND a.dth_inicio > TO_DATE('01/12/2009','DD/MM/YYYY')
    AND a.dth_fim < TO_DATE('01/01/2010','DD/MM/YYYY')
) T
WHERE T.NOME LIKE 'RAFAEL%'
GROUP BY T.NOME
,        TO_CHAR(T.DTH_INICIO, 'DD')
,        TO_CHAR(T.DTH_INICIO, 'MM')
ORDER BY  TO_CHAR(T.DTH_INICIO, 'DD');


SELECT  T.EQUIPE
,       T.NOME
,       TO_CHAR(T.DTH_INICIO, 'MM') AS MES
,       TO_CHAR(TRUNC(SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60)) || ' HORAS' AS HORA_CHAMADO
,       TO_CHAR(ROUND((SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60 - TRUNC(SUM(ROUND(((T.DTH_FIM - T.DTH_INICIO)*24)*60,0))/60))*60,0)) || ' MINUTOS' AS MINUTO_CHAMADO
FROM (
SELECT  a.seq_time_sheet, 
        a.num_matricula, 
        (SELECT NOME FROM  VIW_AGE_EMPREGADOS WHERE SUBSTR(CPF,1,9) = a.num_matricula) AS NOME , 
        (SELECT NOM_EQUIPE_TI FROM EQUIPE_TI WHERE SEQ_EQUIPE_TI = B.SEQ_EQUIPE_TI) AS EQUIPE,
        a.dth_inicio,
        a.dth_fim
  FROM  ifrgestao_ti.time_sheet a
  ,     ifrgestao_ti.recurso_ti b
  WHERE a.num_matricula = b.num_matricula_recurso
    AND b.seq_equipe_ti IN (401, 284, 421)
    AND a.dth_inicio > TO_DATE('01/12/2009','DD/MM/YYYY')
    AND a.dth_fim < TO_DATE('01/01/2010','DD/MM/YYYY')
) T
GROUP BY T.EQUIPE
,        T.NOME
,        TO_CHAR(T.DTH_INICIO, 'MM')
ORDER BY T.EQUIPE
,        T.NOME


SELECT      V.MATRICULA
,           V.PRIVILEGIO AS PERFIL
,           V.NOME
,           V.DEPENDENCIA
,           V.LOTACAO
,           U.UOR_NOME AS NOME_LOTACAO
,           V.CARGO_FUNCAO
,           V.INFRA_TERC
FROM        (
SELECT      GRANTEE AS MATRICULA
     ,      GRANTED_ROLE AS PRIVILEGIO
     ,      (SELECT NOME FROM VIW_AGE_EMPREGADOS WHERE MAT_GERAL = GRANTEE)  AS NOME
     ,      (SELECT DEPENDENCIA FROM VIW_AGE_EMPREGADOS WHERE MAT_GERAL = GRANTEE)  AS DEPENDENCIA
     ,      (SELECT LOTACAO FROM VIW_AGE_EMPREGADOS WHERE MAT_GERAL = GRANTEE)  AS LOTACAO
     ,      (SELECT cargo_funcao FROM VIW_AGE_EMPREGADOS WHERE MAT_GERAL = GRANTEE)  AS CARGO_FUNCAO
     ,      (SELECT i_t  FROM VIW_AGE_EMPREGADOS WHERE MAT_GERAL = GRANTEE)  AS INFRA_TERC
 FROM       DBA_ROLE_PRIVS
WHERE       GRANTED_ROLE LIKE '%RH%'
AND         GRANTED_ROLE <> 'SRH_WEB'
AND         GRANTEE <> 'SYS'
AND         GRANTEE <> 'IFRDBA'
AND         GRANTEE <> 'DISCOVERER_ADMIN'
) V
     ,      UNIDADES_ORGANIZACIONAIS U
WHERE       U.UOR_DATA_EXTINCAO IS NULL
AND         U.UOR_SIGLA = V.LOTACAO 
ORDER BY    PRIVILEGIO, MATRICULA, DEPENDENCIA, LOTACAO

