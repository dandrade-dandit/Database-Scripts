SET ECHO OFF
SET DEFINE '&'
SET PAUSE OFF
SET PAGESIZE 0
SET VERIFY OFF
SET LINESIZE 100
SET FEEDBACK OFF
SPOOL Carga.LOG
CLEAR SCREEN
PROMPT
PROMPT SGS - Software de Gestao de Seguros (Criacao Base dados)
PROMPT
PROMPT *-----------------------------------------------------*
PROMPT 
PROMPT
PROMPT ' Base de dados esta sendo carregada ' 
PROMPT
SET TERMOUT OFF
PROMPT *-----------------------------------------------------*
PROMPT
@user_script\pr_inclui_funcao_seg.sql
PROMPT
@user_script\Sgs0.sql
PROMPT
commit;
PROMPT
PROMPT *-----------------------------------------------------*
PROMPT
PROMPT '         Atualizacao Concluida       '
PROMPT
SET TERMOUT ON
SPOOL OFF
PROMPT 
PROMPT Favor verificar arquivo Carga.LOG
SET PAGESIZE 24
SET FEEDBACK ON
SET VERIFY ON
SET ECHO ON
