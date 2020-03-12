
SELECT  'UPDATE DEPENDENCIAS SET dep_sigla = '''|| dep_sigla || ''', dep_numero_cgc = '''|| dep_numero_cgc || ''', dep_in_categoria_aeroporto = ' || NVL(dep_in_categoria_aeroporto, 'NULL') || ', dep_numero_telefone_2 = ' || NVL(TO_CHAR(dep_numero_telefone_2), 'NULL') || ', dep_grupos_dependencias= ' || NVL(TO_CHAR(dep_grupos_dependencias), 'NULL') || ', cd_dependencia_chave = ''' || cd_dependencia_chave || ''', DEP_DEP_CODIGO = ' || DEP_DEP_CODIGO || ', DEP_NOME = ''' || DEP_NOME || ''', DEP_DATA_CRIACAO = TO_DATE('''|| TO_CHAR(DEP_DATA_CRIACAO, 'DD/MM/YYYY') || ''', ''DD/MM/YYYY''), DEP_DS_DOCUMENTO_CRIACAO = ''' || DEP_DS_DOCUMENTO_CRIACAO || ''', DEP_DENOMINACAO_COMPLETA = ''' || DEP_DENOMINACAO_COMPLETA || ''', DEP_DENOMINACAO_ABREVIADA = ''' || DEP_DENOMINACAO_ABREVIADA || ''' WHERE DEP_CODIGO= '|| DEP_CODIGO || ' AND DEP_DATA_EXTINCAO IS NULL ;'
FROM    IFRDBA2.TMP_DEP
WHERE   DEP_CODIGO IN (10,22,28)
  AND   DEP_DATA_EXTINCAO IS NULL
  AND   DEP_DATA_CRIACAO >= TO_DATE('10/01/2010','DD/MM/YYYY')
/

UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 362/PR/2010, IP 027/PRPG/2010' WHERE UOR_DEP_CODIGO = 10 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');        
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 362/PR/2010, IP 027/PRPG/2010' WHERE UOR_DEP_CODIGO = 22 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');        
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 362/PR/2010, IP 027/PRPG/2010' WHERE UOR_DEP_CODIGO = 28 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');        


UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 16 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 20 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 50 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 54 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 80 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 86 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 965/PR/2010 E IP 061/PRPG/2010' WHERE UOR_DEP_CODIGO = 93 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 





select  *
from    ifrdba2.tmp_uor
where   uor_data_extincao is null
and     uor_data_criacao >= to_date('14/01/2010','DD/MM/YYYY')
and     uor_dep_codigo in (10,22,28)
/

DELETE FROM HISTORICO_DEPENDENCIAS
WHERE   HDE_DEP_CODIGO IN (10,22,28)
/

INSERT INTO HISTORICO_DEPENDENCIAS
SELECT * FROM IFRDBA2.TMP_HIST_DEP
WHERE   HDE_DEP_CODIGO IN (10,22,28)
/


select * 
from quadros_funcoes_dependencias
where qfd_hfd_dep_codigo IN (10,22,28)

select * from quadro_funcoes
where qfu_hfl_uor_codigo  in (
select  uor_codigo
from    UNIDADES_ORGANIZACIONAIS
where   uor_data_extincao is null
and     uor_data_criacao >= to_date('14/01/2010','DD/MM/YYYY')
and     uor_dep_codigo IN (10,22,28)
);

select * 
from ifrsrh.historicos_funcoes_lotacoes 
where hfl_hfd_dep_codigo IN (10,22,28)


select * 
from historico_cargos_lotacao