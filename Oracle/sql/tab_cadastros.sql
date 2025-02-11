
SELECT  TO_CHAR(A.SEQ_PROPOSTA_ADESAO) AS SEQ_PROPOSTA_ADESAO
     ,  TO_CHAR(A.NUM_MAT_EMPREGADO) AS NUM_MAT_EMPREGADO
     ,  E.NOME_ABREVIADO
     ,  E.DEPENDENCIA
     ,  E.LOTACAO
     ,  E.CARGO_FUNCAO
     ,  A.NUM_FASE_PROG
     ,  A.COD_SIT_PROPOSTA
     ,  TO_CHAR(A.DTH_SIMULACAO, 'DD/MM/RRRR HH24:MI') DATA_HORA_SIMULACAO
     ,  'PDITA II' AS PROGRAMA
  FROM  IFRPDVI.CAD_PROPOSTA_ADESAO A
     ,  IFRAGENDA.TAB_AGE_EMPREGADOS E
 WHERE  A.NUM_MAT_EMPREGADO = E.MATRICULA
   AND  A.COD_PROG_DESLIG = 2
   AND  A.COD_SIT_PROPOSTA = 3
UNION
SELECT  TO_CHAR(A.SEQ_PROPOSTA_ADESAO) AS SEQ_PROPOSTA_ADESAO
     ,  TO_CHAR(A.NUM_MAT_EXECUTOR) AS NUM_MAT_EXECUTOR
     ,  E.NOME_ABREVIADO
     ,  E.DEPENDENCIA
     ,  E.LOTACAO
     ,  E.CARGO_FUNCAO
     ,  NULL AS NUM_FASE_PROG
     ,  NULL AS COD_SIT_PROPOSTA
     ,  TO_CHAR(A.DTH_SIMULACAO, 'DD/MM/RRRR HH24:MI') DATA_HORA_SIMULACAO
     ,  'DIN II' AS PROGRAMA
  FROM  IFRPEAE.CAD_HISTORICO_PROPOSTA A
     ,  IFRAGENDA.TAB_AGE_EMPREGADOS E     
 WHERE  SEQ_PROPOSTA_ADESAO IN (SELECT SEQ_PROPOSTA_ADESAO
                                     FROM IFRPEAE.CAD_PROPOSTA_ADESAO
                                    WHERE SEQ_FASE_PROGRAMA = 41
                                      AND COD_SITUACAO_PROPOSTA = 4)   
   AND  A.NUM_MAT_EXECUTOR = E.MATRICULA
ORDER BY DEPENDENCIA
/


select  EMP_NOME, EMP_STATUS
from 	CADASTROS
where 	EMP_STATUS <> 2
and	EMP_NUMERO_MATRICULA = 1190738

select  EMP_NUMERO_MATRICULA, EMP_NOME
from 	CADASTROS
where 	EMP_NOME LIKE 'ESDRAS%'

select  EMP_NOME, EMP_STATUS
from 	CADASTROS
where 	EMP_NUMERO_MATRICULA =1190738 ;

select  EMP_NUMERO_MATRICULA, EMP_NOME, EMP_STATUS
from 	CADASTROS
where 	EMP_NOME LIKE 'DENIS A%'
/

SELECT  *
  FROM  IFRPONTOSOFT.FUNCIONARIOS_PIS_PONTOS
 WHERE  NRO_PIS = 12713519278 --COD_FUNCIONARIO = 10333
 
SELECT  *
  FROM  IFRPONTOSOFT.MARCACOES_PONTOS
 WHERE  COD_FUNCIONARIO = 10333
   AND  DATA_MARCACAO >= TO_DATE('01/11/2015', 'DD/MM/RRRR')


SELECT  *
  FROM  IFRPONTOSOFT.MARCACOES_JUSTIFICADAS_PONTOS
 WHERE  COD_FUNCIONARIO = 10333
   AND  DATA_MARCACAO >= TO_DATE('01/11/2015', 'DD/MM/RRRR')

SELECT R.RUB_DENOMINACAO, A.MOV_VALOR
FROM MOVIMENTACAO A,
RUBRICAS R
WHERE A.MOV_ANO_REFERENCIA = 2017
AND A.MOV_MES_REFERENCIA = 5
AND A.MOV_VERSAO_PAGAMENTO = 1
AND A.MOV_EMP_NUMERO_MATRICULA = 1190738
AND A.MOV_RUB_CODIGO = R.RUB_CODIGO
/

select * 
  from empregados_pagamentos
 where egt_emp_numero_matricula = 1190738
   and egt_crp_ano_pagamento = 2017
/

select *
  from programacoes_ferias
 where pfe_emp_numero_matricula = 1190738
/

SELECT *
FROM IFRPAMI.SAM_BENEFICIARIO_CARTAOIDENTIF 
WHERE NUMEROCARTAO LIKE '%1190738%'
  AND BENEFICIARIO = 3135;
  
  SELECT * FROM IFRPAMI.SAM_BENEFICIARIO WHERE HANDLE = 3135;

SELECT  A.MOV_EMP_NUMERO_MATRICULA
     ,  A.MOV_ANO_REFERENCIA
     ,  A.MOV_MES_REFERENCIA
     ,  A.MOV_RUB_CODIGO
     ,  R.RUB_DENOMINACAO
     ,  A.MOV_VALOR
FROM MOVIMENTACAO A,
RUBRICAS R
WHERE A.MOV_ANO_REFERENCIA BETWEEN 2002 AND 2017
AND A.MOV_MES_REFERENCIA BETWEEN 1 AND 13
AND A.MOV_VERSAO_PAGAMENTO = 1
AND A.MOV_EMP_NUMERO_MATRICULA = 1190738
AND A.MOV_RUB_CODIGO = R.RUB_CODIGO
AND A.MOV_RUB_CODIGO = 5050



/*
SELECT SEQ_PROPOSTA_ADESAO
     , NUM_MAT_EMPREGADO
     , NUM_FASE_PROG
     , COD_SIT_PROPOSTA
     , TO_CHAR(DTH_SIMULACAO, 'DD/MM/RRRR HH24:MI') DATA_HORA_SIMULACAO
  FROM IFRPDVI.CAD_PROPOSTA_ADESAO
 WHERE DTH_SIMULACAO > TO_DATE('28/02/2018', 'DD/MM/RRRR') 
   AND COD_PROG_DESLIG = 2
   AND COD_SIT_PROPOSTA = 3
 ORDER
    BY 2 DESC
 

SELECT *
  FROM IFRAGENDA.TAB_AGE_EMPREGADOS
 WHERE MATRICULA IN (
     SELECT NUM_MAT_EMPREGADO
      FROM IFRPDVI.CAD_PROPOSTA_ADESAO
     WHERE DTH_SIMULACAO > TO_DATE('28/02/2018', 'DD/MM/RRRR')
       AND COD_PROG_DESLIG = 2
       AND COD_SIT_PROPOSTA iN  ( 3, 4 , 5, 6,7 ,8)
 )
 ORDER BY 7
 
SELECT *
  FROM IFRPEAE.CAD_PROPOSTA_ADESAO
 WHERE SEQ_FASE_PROGRAMA = 41
 
SELECT NUM_MAT_EXECUTOR, SEQ_PROPOSTA_ADESAO, TO_CHAR(DTH_SIMULACAO, 'DD/MM/RRRR HH24:MI') DATA_HORA_SIMULACAO
  FROM IFRPEAE.CAD_HISTORICO_PROPOSTA
 WHERE SEQ_PROPOSTA_ADESAO IN (SELECT SEQ_PROPOSTA_ADESAO
                                 FROM IFRPEAE.CAD_PROPOSTA_ADESAO
                                WHERE SEQ_FASE_PROGRAMA = 41)
                                AND COD_SITUACAO_PROPOSTA = 4
                                AND DTH_SIMULACAO > TO_DATE('28/02/2018', 'DD/MM/RRRR')
      
 
 SELECT * 
 FROM CAD_PROPOSTA_VALORES 
 WHERE SEQ_HISTORICO_PROPOSTA IN (
     SELECT SEQ_HISTORICO_PROPOSTA
      FROM IFRPEAE.CAD_HISTORICO_PROPOSTA
     WHERE SEQ_PROPOSTA_ADESAO IN (SELECT SEQ_PROPOSTA_ADESAO
                                     FROM IFRPEAE.CAD_PROPOSTA_ADESAO
                                    WHERE SEQ_FASE_PROGRAMA = 41
                                      AND COD_SITUACAO_PROPOSTA = 4)    
    )
    


*/

--GRANT RH_PERFIL_99 TO I1190738;
--REVOKE RH_PERFIL_99 FROM I1190738;
--ALTER USER I1190738 IDENTIFIED BY INFRAERO ACCOUNT UNLOCK;

--select * from  dba_role_privs where grantee = 'I1190738'










--************************************************
SELECT  *
  FROM  empregados_pagamentos
 WHERE  egt_crp_ano_pagamento = 2013
   AND  egt_crp_mes_pagamento = 6
   AND  egt_emp_numero_matricula = 184932
   
SELECT  egt_emp_numero_matricula, emp_nome, egt_remuneracao_liquido
  FROM  empregados_pagamentos, cadastros
 WHERE  egt_crp_ano_pagamento = 2013
   AND  egt_crp_mes_pagamento = 6
   AND  egt_remuneracao_liquido > 30000
   AND  emp_numero_matricula = egt_emp_numero_matricula

select emp_status from cadastros where emp_numero_matricula = 1844907

select * from ocorrencias_empregados where oem_emp_numero_matricula = 1844907

--********************************************

select * from dba_tables where owner = 'IFRRHPORTAL'

select * from dba_objects where object_name = 'CAD_USR_PORTAL_RH'


select * from CAD_USR_PORTAL_RH where usr_email like 'denis_andrade%'

--update CAD_USR_PORTAL_RH set usr_senha = 'ca182be3265790cb659a0f410d507eae' where usr_email like 'denis_andrade@%'

'ca182be3265790cb659a0f410d507eae'


select * from CAD_USR_PORTAL_RH where usr_email like 'denis_andrade%'

'32e25981a47bdb23177128a6e9b682bc'

commit
rollback







/*

--insert
@_dsa
--delete
revoke rh_perfil_99 from i1190738;

alter trigger IFRDBA2.TRG_USUSIT_IUD disable;

select count(1) from ifrdba2.seg_usuario_sistema where SU_ID_USUARIO = 'I1190738';

delete from ifrdba2.seg_usuario_sistema where SU_ID_USUARIO = 'I1190738' and SS_CD_SISTEMA != 13;

select count(1) from ifrdba2.seg_usuario_sistema where SU_ID_USUARIO = 'I1190738';

select count(1) from ifrdba2.seg_log_usuario_sistema where SU_ID_USUARIO = 'I1190738';

delete from ifrdba2.seg_log_usuario_sistema where SU_ID_USUARIO = 'I1190738' and SS_CD_SISTEMA != 13;

select count(1) from ifrdba2.seg_log_usuario_sistema where SU_ID_USUARIO = 'I1190738';

select count(1) from  ifrsrh.controle_usuario_dependencia where sgu_id_usuario =  'I1190738';

delete from  ifrsrh.controle_usuario_dependencia where sgu_id_usuario =  'I1190738' and dep_cd_dependencia != 1 and ssi_cd_sistema != 13;

delete from  ifrsrh.controle_usuario_dependencia where sgu_id_usuario =  'I1190738' and dep_cd_dependencia = 1 and ssi_cd_sistema != 13;

select count(1) from  ifrsrh.controle_usuario_dependencia where sgu_id_usuario =  'I1190738';

select count(1) from ifrsrh.LOG_CONTROLE_USU_DEP where sgu_id_usuario = 'I1190738';

delete from ifrsrh.LOG_CONTROLE_USU_DEP where sgu_id_usuario = 'I1190738';

select count(1) from ifrsrh.LOG_CONTROLE_USU_DEP where sgu_id_usuario = 'I1190738';

alter trigger IFRDBA2.TRG_USUSIT_IUD enable;

revoke SEG_GERAL from I1190738;

commit;
*/

--OUVIDORIA
select * 
from ifrprouvi_owner.tab_usuario_ouvidoria
--update ifrprouvi_owner.tab_usuario_ouvidoria set dsc_senha = 'tigp' 
where cpf_usuario = '28712463191'


SELECT *
FROM IFRNUMWEB.CAD_NUM_DOCS 
--WHERE DTH_GERACAO > TO_DATE('01/12/2014' , 'DD/MM/RRRR')
WHERE TO_CHAR(DTH_GERACAO, 'DD/MM/RRRR') = TO_CHAR(SYSDATE, 'DD/MM/RRRR')
--  AND UPPER(DSC_ASSUNTO) LIKE '%CARGOS%'
  AND SIG_ORIGEM='SEDE'
  AND COD_TIPO_DOCUMENTO = 'MM';
  



SELECT  DEP_CODIGO
     ,  DEP_SIGLA
     ,  DEP_NOME
     ,  CASE DEP_TIPO
          WHEN 1  THEN 'CENTRO CORPORATIVO'
          WHEN 14 THEN 'CENTRO DE SUPORTE'
          WHEN 3  THEN 'CENTRO DE NEG�CIOS'
          WHEN 6  THEN 'GNA'
          WHEN 13 THEN 'EPTA'
        END DEP_TIPO
     ,  (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = NVL(D.DEP_DEP_CODIGO, 1)) DEP_DEP_CODIGO
  FROM  DEPENDENCIAS D
 WHERE  DEP_DATA_EXTINCAO IS NULL
   AND  DEP_TIPO NOT IN (2 , 8, 9)
 START WITH DEP_CODIGO = 1
 CONNECT BY PRIOR DEP_CODIGO = DEP_DEP_CODIGO;