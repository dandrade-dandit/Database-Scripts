set verify off
ACCEPT NOME CHAR PROMPT 'ENTRE COM O NOME DA PESSOA: '

SELECT emp_numero_matricula,emp_uor_codigo_lotacao
, SUBSTR(EMP_QFU_FUNCAO,1,DECODE(INSTR(EMP_QFU_FUNCAO,' '),0,100
,INSTR(EMP_QFU_FUNCAO,' '))) AS EMP_QFU_FUNCAO
,EMP_NOME_ABREVIADO || decode('"' || EMP_NOME_GUERRA ||'"','""','',' - "' || EMP_NOME_GUERRA ||'"') AS EMP_NOME
, EMP_UOR_SIGLA
,DECODE(LENGTH(EMP_EFC_UFF_VOIP_DDD_RAMAL),2,'('||EMP_EFC_UFF_VOIP_DDD_RAMAL||') ','')|| phone(emp_efc_uff_RAMAL) as emp_efc_uff_numero 
FROM VIW_CADASTROS 
WHERE (EMP_QFU_FUN_CODIGO IS NULL OR EMP_QFU_FUN_CODIGO NOT IN (690,692 ))  
AND EMP_NOME_ABREVIADO LIKE '%&NOME%'
order by emp_ordem
/