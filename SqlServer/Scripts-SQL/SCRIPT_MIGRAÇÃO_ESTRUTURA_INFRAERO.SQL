--SELECTS
SELECT  DEP_CODIGO
     ,  DEP_DEP_CODIGO
     ,  DEP_TIPO
     ,  DEP_SIGLA
     ,  DEP_NOME 
     ,  DEP_DATA_EXTINCAO
  FROM  DEPENDENCIAS
 WHERE  (DEP_DATA_EXTINCAO IS NULL OR DEP_DATA_EXTINCAO >= TO_DATE('13/01/2010','DD/MM/YYYY') )
 START WITH DEP_CODIGO = 1
  CONNECT BY PRIOR DEP_CODIGO = DEP_DEP_CODIGO




SELECT  UOR_CODIGO
     ,  UOR_UOR_CODIGO
     ,  UOR_SIGLA
     ,  UOR_NOME
     ,  UOR_DEP_CODIGO
     ,  UOR_DATA_EXTINCAO 
  FROM  UNIDADES_ORGANIZACIONAIS
 WHERE  (UOR_DATA_EXTINCAO IS NULL OR UOR_DATA_EXTINCAO >= TO_DATE('10/01/2010','DD/MM/YYYY') )
   AND  UOR_DEP_CODIGO = 156
 START WITH UOR_UOR_CODIGO IS NULL
  CONNECT BY PRIOR UOR_CODIGO = UOR_UOR_CODIGO

--*************************************************************************************************
-- BACKUP DOS DADOS DE PRODUÇÃO DE DEPENDENCIA, UOR E HISTORICO_DEPENDENCIAS
--*************************************************************************************************

--CREATE TABLE
CREATE TABLE IFRDBA2.BKP_DEP
    (dep_codigo                     NUMBER(4,0) NOT NULL,
    dep_tipo                       NUMBER(2,0),
    dep_nome                       VARCHAR2(60),
    dep_sigla                      VARCHAR2(10),
    dep_endereco_logradouro        VARCHAR2(50),
    dep_endereco_bairro            VARCHAR2(30),
    dep_endereco_municipio         VARCHAR2(30),
    dep_ufe_sigla                  VARCHAR2(2),
    dep_endereco_cep               NUMBER(8,0),
    dep_numero_telefone_1          NUMBER(11,0),
    dep_numero_telefone_2          NUMBER(11,0),
    dep_numero_fax                 NUMBER(11,0),
    dep_numero_cgc                 VARCHAR2(14),
    dep_aba_ban_codigo             NUMBER(3,0),
    dep_aba_codigo                 VARCHAR2(7),
    dep_dep_codigo                 NUMBER(4,0),
    dep_codigo_ugd                 VARCHAR2(4),
    dep_rge_codigo                 VARCHAR2(2),
    cd_dependencia_chave           VARCHAR2(3),
    dep_in_categoria_aeroporto     VARCHAR2(3),
    dep_data_criacao               DATE,
    dep_ds_documento_criacao       VARCHAR2(50),
    dep_data_extincao              DATE,
    dep_ds_documento_extincao      VARCHAR2(50),
    dep_msg_cntchque               VARCHAR2(180),
    dep_dep_codigo_vincula_pgto    NUMBER(4,0),
    dep_mun_codigo                 NUMBER(5,0),
    dep_grupos_dependencias        NUMBER(2,0),
    in_opb_automatica              VARCHAR2(1),
    dep_sigla_anterior             VARCHAR2(10),
    dep_ind_recolh_sal_educacao    VARCHAR2(1),
    dep_ind_orcamento              VARCHAR2(1),
    dep_adm_material               NUMBER(4,0),
    dep_comar                      VARCHAR2(4),
    dep_denominacao_completa       VARCHAR2(150),
    dep_denominacao_abreviada      VARCHAR2(60),
    dep_id_cent_empresa            NUMBER(6,0),
    dep_ie                         VARCHAR2(20),
    dep_horaria_administrativo     VARCHAR2(40),
    dep_fuso_horario_brasilia      VARCHAR2(4),
    dep_dt_absorcao_infraero       DATE,
    dep_tel_achados_perdidos       NUMBER(8,0),
    dep_tel_balcao_informacao      NUMBER(8,0),
    dep_tel_comunicacao_social     NUMBER(8,0),
    dep_numero_telefone_ddd        NUMBER(2,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRDBA2.BKP_UOR
    (uor_codigo                     NUMBER(9,0) NOT NULL,
    uor_nome                       VARCHAR2(100),
    uor_sigla                      VARCHAR2(10),
    uor_codigo_lotacao_anterior    NUMBER(9,0),
    uor_dep_codigo                 NUMBER(4,0),
    uor_uor_codigo                 NUMBER(9,0),
    uor_sequencia_estrutura        VARCHAR2(10),
    uor_data_criacao               DATE,
    uor_ds_documento_criacao       VARCHAR2(50),
    uor_data_extincao              DATE,
    uor_ds_documento_extincao      VARCHAR2(50),
    uor_dep_codigo_vincula_pgto    NUMBER(4,0),
    uor_nome_abreviado             VARCHAR2(60),
    uor_tipo_unidad_org            NUMBER(2,0),
    uor_dep_adm_material           NUMBER(4,0),
    uor_endereco_logradouro        VARCHAR2(200),
    uor_endereco_bairro            VARCHAR2(30),
    uor_endereco_municipio         VARCHAR2(50),
    uor_ufe_sigla                  VARCHAR2(2),
    uor_cep                        VARCHAR2(10),
    uor_numero_fax                 VARCHAR2(8))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRDBA2.BKP_HIST_DEP
    (hde_dep_codigo                 NUMBER(4,0) NOT NULL,
    hde_data_criacao               DATE NOT NULL,
    hde_tipo                       NUMBER(2,0),
    hde_nome                       VARCHAR2(60),
    hde_sigla                      VARCHAR2(10),
    hde_aeo_codigo_icao            DATE,
    hde_endereco_logradouro        VARCHAR2(50),
    hde_endereco_bairro            VARCHAR2(30),
    hde_endereco_municipio         VARCHAR2(30),
    hde_ufe_sigla                  VARCHAR2(2),
    hde_endereco_cep               NUMBER(8,0),
    hde_numero_telefone_1          NUMBER(11,0),
    hde_numero_telefone_2          NUMBER(11,0),
    hde_numero_fax                 NUMBER(11,0),
    hde_numero_cgc                 NUMBER(14,0),
    hde_aba_ban_codigo             NUMBER(3,0),
    hde_aba_codigo                 NUMBER(7,0),
    hde_hde_dep_codigo             NUMBER(4,0),
    hde_in_categoria_aeroporto     VARCHAR2(3),
    hde_ds_documento_criacao       VARCHAR2(50),
    hde_data_extincao              DATE,
    hde_ds_documento_extincao      VARCHAR2(50),
    hde_msg_cntchque               VARCHAR2(180),
    hde_dep_codigo_vincula_pgto    NUMBER(4,0),
    hde_numero_ugd                 VARCHAR2(4),
    hde_mun_codigo                 NUMBER(5,0),
    hde_grupos_dependencias        NUMBER(2,0),
    hde_adm_material               NUMBER(4,0),
    hde_in_opb_automatica          VARCHAR2(1),
    hde_sigla_anterior             VARCHAR2(10),
    hde_ind_recolh_sal_educacao    VARCHAR2(1),
    hde_ind_orcamento              VARCHAR2(1),
    hde_comar                      VARCHAR2(4))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

TRUNCATE TABLE IFRDBA2.BKP_DEP;
TRUNCATE TABLE IFRDBA2.BKP_UOR;
TRUNCATE TABLE IFRDBA2.bkp_hist_dep;


--CARGA DAS TABELAS TEMPORÁRIAS DE BACKUP
INSERT INTO IFRDBA2.BKP_DEP
SELECT * FROM DEPENDENCIAS
/

INSERT INTO IFRDBA2.BKP_UOR
SELECT * FROM UNIDADES_ORGANIZACIONAIS
/

INSERT INTO IFRDBA2.BKP_HIST_DEP
SELECT * FROM HISTORICO_DEPENDENCIAS
/

COMMIT
/

--************************************************************************************************************
-- UPDATE DAS DEPENDENCIAS EXISTENTES, CRIAÇÃO DA NOVA DEPENDENCIA E ATUALIZAÇÃO DO HISTORICO_DEPENDENCIAS
--************************************************************************************************************

SELECT  'UPDATE DEPENDENCIAS SET DEP_NOME = ''' || DEP_NOME || ''', DEP_DATA_CRIACAO = TO_DATE('''|| DEP_DATA_CRIACAO || ''', ''DD/MM/YYYY''), DEP_DS_DOCUMENTO_CRIACAO = ''' || DEP_DS_DOCUMENTO_CRIACAO || ''', DEP_DENOMINACAO_COMPLETA = ''' || DEP_DENOMINACAO_COMPLETA || ''', DEP_DENOMINACAO_ABREVIADA = ''' || DEP_DENOMINACAO_ABREVIADA || ''' WHERE DEP_CODIGO= '|| DEP_CODIGO || ' AND DEP_DATA_EXTINCAO IS NULL ;'
FROM    IFRDBA2.TMP_DEP
WHERE   DEP_CODIGO NOT IN (1, 156, 157, 157, 158, 159, 161)
  AND   DEP_DATA_EXTINCAO IS NULL
  AND   DEP_DATA_CRIACAO >= TO_DATE('10/01/2010','DD/MM/YYYY')
/

SELECT   DISTINCT UOR_DEP_CODIGO, 'UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = ''' || uor_ds_documento_criacao || ''' WHERE UOR_DEP_CODIGO = ' || UOR_DEP_CODIGO || ' AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE(''14/01/2010'',''DD/MM/YYYY'');'
  FROM   UNIDADES_ORGANIZACIONAIS
 WHERE   UOR_DEP_CODIGO NOT IN (1, 161, 156, 157, 158, 159, 57, 61, 25, 58, 2)
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL
ORDER BY UOR_DEP_CODIGO

--DEPENDENCIA 156
UPDATE  DEPENDENCIAS
SET     DEP_NOME = 'SUPERINTENDÊNCIA REGIONAL DO CENTRO-OESTE'
,       DEP_SIGLA = 'SRCO'
,       DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY')
,       DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010'
,       DEP_DATA_EXTINCAO = NULL
,       DEP_DS_DOCUMENTO_EXTINCAO = NULL
,       DEP_DENOMINACAO_COMPLETA = 'SUPERINTENDÊNCIA REGIONAL DO CENTRO-OESTE'
,       DEP_DENOMINACAO_ABREVIADA = 'SUP. REGIONAL DO CENTRO-OESTE'
WHERE   DEP_CODIGO = 156
/

UPDATE  DEPENDENCIAS
SET     DEP_DEP_CODIGO = 156
WHERE   DEP_CODIGO IN (17,19,155,18,78,48,2,11,92,73,152)
/

--DEPENDENCIA 157
UPDATE DEPENDENCIAS
SET DEP_SIGLA = 'SRSP.'
WHERE DEP_SIGLA = 'SRSP'
/

UPDATE  DEPENDENCIAS
SET     DEP_NOME = 'SUPERINTENDÊNCIA REGIONAL DE SÃO PAULO'
,       DEP_SIGLA = 'SRSP'
,       DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY')
,       DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 22/PRPG/2010'
,       DEP_DATA_EXTINCAO = NULL
,       DEP_DS_DOCUMENTO_EXTINCAO = NULL
,       DEP_DENOMINACAO_COMPLETA = 'SUPERINTENDÊNCIA DE SÃO PAULO'
,       DEP_DENOMINACAO_ABREVIADA = 'SUP. REGIONAL DE SÃO PAULO'
WHERE   DEP_CODIGO = 157
/

UPDATE  DEPENDENCIAS
SET     DEP_DEP_CODIGO = 157
WHERE   DEP_CODIGO IN (52,7,24,34,57,149,117,97,51,53,8,9,72,74,71,12,26,33,35,36)
/


--DEPENDENCIA 158
UPDATE DEPENDENCIAS
SET DEP_SIGLA = 'SRRJ.'
WHERE DEP_SIGLA = 'SRRJ'
/

UPDATE  DEPENDENCIAS
SET     DEP_NOME = 'SUPERINTENDÊNCIA REGIONAL DO RIO DE JANEIRO'
,       DEP_SIGLA = 'SRRJ'
,       DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY')
,       DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010'
,       DEP_DATA_EXTINCAO = NULL
,       DEP_DS_DOCUMENTO_EXTINCAO = NULL
,       DEP_DENOMINACAO_COMPLETA = 'SUPERINTENDÊNCIA REGIONAL DO RIO DE JANEIRO'
,       DEP_DENOMINACAO_ABREVIADA = 'SUP. REG. DO RIO DE JANEIRO'
WHERE   DEP_CODIGO = 158
/

UPDATE  DEPENDENCIAS
SET     DEP_DEP_CODIGO = 158
WHERE   DEP_CODIGO IN (63,23,27,37,39,38,5,154,61,62,64,65)
/

--DEPENDENCIA 159
UPDATE  DEPENDENCIAS
SET     DEP_NOME = 'SUPERINTENDENCIA REGIONAL DO NOROESTE'
,       DEP_SIGLA = 'SRNR'
,       DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY')
,       DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010'
,       DEP_DATA_EXTINCAO = NULL
,       DEP_DS_DOCUMENTO_EXTINCAO = NULL
,       DEP_DENOMINACAO_COMPLETA = 'SUPERINTENDENCIA REGIONAL DO NOROESTE'
,       DEP_DENOMINACAO_ABREVIADA = 'SUPERINTENDENCIA REGIONAL DO NOROESTE'
WHERE   DEP_CODIGO = 159
/

--DEPENDENCIA 161
INSERT INTO DEPENDENCIAS (DEP_CODIGO,DEP_TIPO,DEP_NOME,DEP_SIGLA,DEP_ENDERECO_LOGRADOURO,DEP_ENDERECO_BAIRRO,DEP_ENDERECO_MUNICIPIO,DEP_UFE_SIGLA,DEP_ENDERECO_CEP,DEP_NUMERO_TELEFONE_1,DEP_NUMERO_TELEFONE_2,DEP_NUMERO_FAX,DEP_NUMERO_CGC,DEP_ABA_BAN_CODIGO,DEP_ABA_CODIGO,DEP_DEP_CODIGO,DEP_CODIGO_UGD,DEP_RGE_CODIGO,CD_DEPENDENCIA_CHAVE,DEP_IN_CATEGORIA_AEROPORTO,DEP_DATA_CRIACAO,DEP_DS_DOCUMENTO_CRIACAO,DEP_DATA_EXTINCAO,DEP_DS_DOCUMENTO_EXTINCAO,DEP_MSG_CNTCHQUE,DEP_DEP_CODIGO_VINCULA_PGTO,DEP_MUN_CODIGO,DEP_GRUPOS_DEPENDENCIAS,IN_OPB_AUTOMATICA,DEP_SIGLA_ANTERIOR,DEP_IND_RECOLH_SAL_EDUCACAO,DEP_IND_ORCAMENTO,DEP_ADM_MATERIAL,DEP_COMAR,DEP_DENOMINACAO_COMPLETA,DEP_DENOMINACAO_ABREVIADA,DEP_ID_CENT_EMPRESA,DEP_IE,DEP_HORARIA_ADMINISTRATIVO,DEP_FUSO_HORARIO_BRASILIA,DEP_DT_ABSORCAO_INFRAERO,DEP_TEL_ACHADOS_PERDIDOS,DEP_TEL_BALCAO_INFORMACAO,DEP_TEL_COMUNICACAO_SOCIAL,DEP_NUMERO_TELEFONE_DDD)
VALUES(161,2,'SUPERINTENDÊNCIA REGIONAL DO SUDESTE','SRSE','AEROPORTO INTERNACIONAL TANCREDO NEVES, S/Nº','AEROPORTO',NULL,'MG',33500900,3136892130,3136892344,3136892090,'00352294016114',NULL,NULL,1,NULL,NULL,NULL,NULL,TO_DATE('2010-01-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010',NULL,NULL,NULL,NULL,17876,0,NULL,'SRSE','N',NULL,NULL,NULL,'SUPERINTENDÊNCIA REGIONAL DO SUDESTE','SUPERINTENDÊNCIA REGIONAL DO SUDESTE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE  DEPENDENCIAS
SET     DEP_DEP_CODIGO = 161
WHERE   DEP_CODIGO IN (38,5,154,91,58,23,27,37,39)
/


--*************************************************************************************************
-- CÓPIA DOS DADOS DE HOMOLOGAÇÃO DE DEPENDENCIA, UOR E HISTORICO_DEPENDENCIAS VALIDADOS
--*************************************************************************************************

--CREATE TABLE
CREATE TABLE IFRDBA2.TMP_DEP
    (dep_codigo                     NUMBER(4,0) NOT NULL,
    dep_tipo                       NUMBER(2,0),
    dep_nome                       VARCHAR2(60),
    dep_sigla                      VARCHAR2(10),
    dep_endereco_logradouro        VARCHAR2(50),
    dep_endereco_bairro            VARCHAR2(30),
    dep_endereco_municipio         VARCHAR2(30),
    dep_ufe_sigla                  VARCHAR2(2),
    dep_endereco_cep               NUMBER(8,0),
    dep_numero_telefone_1          NUMBER(11,0),
    dep_numero_telefone_2          NUMBER(11,0),
    dep_numero_fax                 NUMBER(11,0),
    dep_numero_cgc                 VARCHAR2(14),
    dep_aba_ban_codigo             NUMBER(3,0),
    dep_aba_codigo                 VARCHAR2(7),
    dep_dep_codigo                 NUMBER(4,0),
    dep_codigo_ugd                 VARCHAR2(4),
    dep_rge_codigo                 VARCHAR2(2),
    cd_dependencia_chave           VARCHAR2(3),
    dep_in_categoria_aeroporto     VARCHAR2(3),
    dep_data_criacao               DATE,
    dep_ds_documento_criacao       VARCHAR2(50),
    dep_data_extincao              DATE,
    dep_ds_documento_extincao      VARCHAR2(50),
    dep_msg_cntchque               VARCHAR2(180),
    dep_dep_codigo_vincula_pgto    NUMBER(4,0),
    dep_mun_codigo                 NUMBER(5,0),
    dep_grupos_dependencias        NUMBER(2,0),
    in_opb_automatica              VARCHAR2(1),
    dep_sigla_anterior             VARCHAR2(10),
    dep_ind_recolh_sal_educacao    VARCHAR2(1),
    dep_ind_orcamento              VARCHAR2(1),
    dep_adm_material               NUMBER(4,0),
    dep_comar                      VARCHAR2(4),
    dep_denominacao_completa       VARCHAR2(150),
    dep_denominacao_abreviada      VARCHAR2(60),
    dep_id_cent_empresa            NUMBER(6,0),
    dep_ie                         VARCHAR2(20),
    dep_horaria_administrativo     VARCHAR2(40),
    dep_fuso_horario_brasilia      VARCHAR2(4),
    dep_dt_absorcao_infraero       DATE,
    dep_tel_achados_perdidos       NUMBER(8,0),
    dep_tel_balcao_informacao      NUMBER(8,0),
    dep_tel_comunicacao_social     NUMBER(8,0),
    dep_numero_telefone_ddd        NUMBER(2,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRDBA2.TMP_UOR
    (uor_codigo                     NUMBER(9,0) NOT NULL,
    uor_nome                       VARCHAR2(100),
    uor_sigla                      VARCHAR2(10),
    uor_codigo_lotacao_anterior    NUMBER(9,0),
    uor_dep_codigo                 NUMBER(4,0),
    uor_uor_codigo                 NUMBER(9,0),
    uor_sequencia_estrutura        VARCHAR2(10),
    uor_data_criacao               DATE,
    uor_ds_documento_criacao       VARCHAR2(50),
    uor_data_extincao              DATE,
    uor_ds_documento_extincao      VARCHAR2(50),
    uor_dep_codigo_vincula_pgto    NUMBER(4,0),
    uor_nome_abreviado             VARCHAR2(60),
    uor_tipo_unidad_org            NUMBER(2,0),
    uor_dep_adm_material           NUMBER(4,0),
    uor_endereco_logradouro        VARCHAR2(200),
    uor_endereco_bairro            VARCHAR2(30),
    uor_endereco_municipio         VARCHAR2(50),
    uor_ufe_sigla                  VARCHAR2(2),
    uor_cep                        VARCHAR2(10),
    uor_numero_fax                 VARCHAR2(8))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRDBA2.TMP_HIST_DEP
    (hde_dep_codigo                 NUMBER(4,0) NOT NULL,
    hde_data_criacao               DATE NOT NULL,
    hde_tipo                       NUMBER(2,0),
    hde_nome                       VARCHAR2(60),
    hde_sigla                      VARCHAR2(10),
    hde_aeo_codigo_icao            DATE,
    hde_endereco_logradouro        VARCHAR2(50),
    hde_endereco_bairro            VARCHAR2(30),
    hde_endereco_municipio         VARCHAR2(30),
    hde_ufe_sigla                  VARCHAR2(2),
    hde_endereco_cep               NUMBER(8,0),
    hde_numero_telefone_1          NUMBER(11,0),
    hde_numero_telefone_2          NUMBER(11,0),
    hde_numero_fax                 NUMBER(11,0),
    hde_numero_cgc                 NUMBER(14,0),
    hde_aba_ban_codigo             NUMBER(3,0),
    hde_aba_codigo                 NUMBER(7,0),
    hde_hde_dep_codigo             NUMBER(4,0),
    hde_in_categoria_aeroporto     VARCHAR2(3),
    hde_ds_documento_criacao       VARCHAR2(50),
    hde_data_extincao              DATE,
    hde_ds_documento_extincao      VARCHAR2(50),
    hde_msg_cntchque               VARCHAR2(180),
    hde_dep_codigo_vincula_pgto    NUMBER(4,0),
    hde_numero_ugd                 VARCHAR2(4),
    hde_mun_codigo                 NUMBER(5,0),
    hde_grupos_dependencias        NUMBER(2,0),
    hde_adm_material               NUMBER(4,0),
    hde_in_opb_automatica          VARCHAR2(1),
    hde_sigla_anterior             VARCHAR2(10),
    hde_ind_recolh_sal_educacao    VARCHAR2(1),
    hde_ind_orcamento              VARCHAR2(1),
    hde_comar                      VARCHAR2(4))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_geral
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


--CARGA DAS TABELAS TEMPORÁRIAS DE BACKUP
INSERT INTO IFRDBA2.TMP_DEP
SELECT * FROM DEPENDENCIAS
/

INSERT INTO IFRDBA2.TMP_UOR
SELECT * FROM UNIDADES_ORGANIZACIONAIS
/

INSERT INTO IFRDBA2.TMP_HIST_DEP
SELECT * FROM HISTORICO_DEPENDENCIAS
/

COMMIT
/

--MIGRAR TABELAS PARA O DESENV...PRODSEDE...USANDO DTS.

--*************************************************************************************************
-- MIGRAR UOR
--*************************************************************************************************
INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 156
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 157
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 158
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 159
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 161
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 02
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 57
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 61
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 25
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 58
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

--*************************************************************************************************
-- EXTINÇÃO DAS UOR EXISTENTES
--*************************************************************************************************
--1)
UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 22/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 157 
AND     UOR_DATA_CRIACAO < TO_DATE('10/01/2010','DD/MM/YYYY')
/

--2)
UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 158/PR/2010'
WHERE   UOR_DEP_CODIGO = 158 
AND     UOR_DATA_CRIACAO < TO_DATE('16/11/2009','DD/MM/YYYY')
/

--3)
UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 159 
AND     UOR_DATA_CRIACAO < TO_DATE('02/02/2010','DD/MM/YYYY')
/

--4)
UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 22/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 57
AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL
/

--5)
UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 61
AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL
/

--6)
UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 25
AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL
/

--7)
UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 58
AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL
/

--8)
UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010'
WHERE   UOR_DEP_CODIGO = 2
AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY')
AND  UOR_DATA_EXTINCAO IS NULL
/
--*************************************************************************************************
-- EXTINÇÃO DAS UOR EXISTENTES
--*************************************************************************************************
UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 22/PRPG/2010'
WHERE   UOR_CODIGO = 11034
/

UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 158/PR/2010'
WHERE   UOR_CODIGO = 11033
/

UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010'
WHERE   UOR_CODIGO = 11321
/

UPDATE 	UNIDADES_ORGANIZACIONAIS
SET	    UOR_DATA_EXTINCAO =  SYSDATE
,       uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010'
WHERE   UOR_CODIGO = 11024
/

--*************************************************************************************************
-- HISTORICO DEPENDENCIAS
--*************************************************************************************************
DELETE FROM HISTORICO_DEPENDENCIAS
/

INSERT INTO HISTORICO_DEPENDENCIAS
SELECT * FROM IFRDBA2.TMP_HIST_DEP
/

--*************************************************************************************************
-- INSERIR DEPENDENCIAS NO INTEGRACAO PARA O SMARTSTREAM - PRODSEDE2 - VER COM O ADAILI
--*************************************************************************************************
INSERT INTO TAB_ENTIDADE_SMART VALUES('156','02156', TO_DATE('14/01/2010', 'DD/MM/YYYY'))
/
INSERT INTO TAB_ENTIDADE_SMART VALUES('159','25159', TO_DATE('02/02/2010', 'DD/MM/YYYY'))
/
INSERT INTO TAB_ENTIDADE_SMART VALUES('161','58161', TO_DATE('14/01/2010', 'DD/MM/YYYY'))
/
--*************************************************************************************************
-- CHECKS DAS UORS
--*************************************************************************************************
INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO NOT IN (1, 161, 156, 157, 158, 159, 57, 61, 25, 58, 2)
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
AND     UOR_DATA_EXTINCAO IS NULL



UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010' WHERE UOR_DEP_CODIGO = 4 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');     
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 5 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');        
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 6 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY'); 
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 11 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 362/PR/2010 E IP Nº 27/PRPG/2010' WHERE UOR_DEP_CODIGO = 15 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');    
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 17 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 18 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 19 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010' WHERE UOR_DEP_CODIGO = 21 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');    
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 23 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 24 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010, IP 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 26 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 27 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 29 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 30 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010' WHERE UOR_DEP_CODIGO = 31 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');    
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 33 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 37 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 38 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 39 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 42 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 43 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 44 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 48 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 62 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 63 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 64 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 65 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 71 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 72 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 73 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 74 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 78 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 84 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 89 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 91 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 92 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');       
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 94 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 96 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 97 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');   
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 98 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM Nº 361/PR/2010 E IP Nº 023/PRPG/2010' WHERE UOR_DEP_CODIGO = 99 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010' WHERE UOR_DEP_CODIGO = 149 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');  
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010, IP 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 152 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');      
UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = SYSDATE,  uor_ds_documento_extincao = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010' WHERE UOR_DEP_CODIGO = 154 AND     UOR_DATA_EXTINCAO IS NULL AND     UOR_DATA_CRIACAO < TO_DATE('14/01/2010','DD/MM/YYYY');  


UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE ALTA FLORESTA', DEP_DATA_CRIACAO = TO_DATE('14/01/10', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE ALTA FLORESTA', DEP_DENOMINACAO_ABREVIADA = 'ALTA FLORESTA- GNA III' WHERE DEP_CODIGO= 73 AND DEP_DATA_EXTINCAO IS NULL ;                                                                        
UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE PRESIDENTE PRUDENTE', DEP_DATA_CRIACAO = TO_DATE('25/01/10', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE PRESIDENTE PRUDENTE - GNA II', DEP_DENOMINACAO_ABREVIADA = 'PRESIDENTE PRUDENTE - GNA II' WHERE DEP_CODIGO= 74 AND DEP_DATA_EXTINCAO IS NULL ;                                             
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE PALMAS/TO - BRIGADEIRO LYSIAS RODRIGUES - GRUPO', DEP_DATA_CRIACAO = TO_DATE('14/01/10', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE PALMAS/TO - BRIGADEIRO LYSIAS RODRIGUES - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROP. DE PALMAS-BRIG. LYSIAS RODRIGUES' WHERE DEP_CODIGO= 152 AND DEP_DATA_EXTINCAO IS NULL ;                      
UPDATE DEPENDENCIAS SET DEP_NOME = 'RUPAMENTO DE NAVEGAÇÃO AÉREA DE POÇOS DE CALDAS - GNA IV', DEP_DATA_CRIACAO = TO_DATE('14/01/10', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE POÇOS DE CALDAS - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'POÇOS DE CALDAS - GNA IV' WHERE DEP_CODIGO= 91 AND DEP_DATA_EXTINCAO IS NULL ;                                                 
UPDATE DEPENDENCIAS SET DEP_NOME = 'AMAPÁ - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AMAPÁ - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'AMAPÁ - GNA IV' WHERE DEP_CODIGO= 83 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                                 
UPDATE DEPENDENCIAS SET DEP_NOME = 'MONTE DOURADO - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'MONTE DOURADO - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'MONTE DOURADO - GNA IV' WHERE DEP_CODIGO= 87 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                         
UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE BAURU', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE BAURU - GNA II', DEP_DENOMINACAO_ABREVIADA = 'BAURU - GNA II' WHERE DEP_CODIGO= 71 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                       
UPDATE DEPENDENCIAS SET DEP_NOME = 'CONCEIÇÃO DO ARAGUAIA - GNA GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'CONCEIÇÃO DO ARAGUAIA - GNA GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'CONCEIÇÃO DO ARAGUAIA - GNA GRUPO IV' WHERE DEP_CODIGO= 76 AND DEP_DATA_EXTINCAO IS NULL ;                                                                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE GOIANIA - GRUPO II', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE GOIÂNIA - SANTA GENOVEVA -  GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE GOIÂNIA - GRUPO II' WHERE DEP_CODIGO= 11 AND DEP_DATA_EXTINCAO IS NULL ;                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'ITACOATIARA - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'ITACOATIARA - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'ITACOATIARA - GNA IV' WHERE DEP_CODIGO= 84 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'MANICORÉ - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'MANICORÉ - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'MANICORÉ - GNA IV' WHERE DEP_CODIGO= 89 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'PORTO NACIONAL - GNA IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'PORTO NACIONAL - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'PORTO NACIONAL - GNA IV' WHERE DEP_CODIGO= 92 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                     
UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE RIBEIRÃO PRETO', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE RIBEIRÃO PRETO - GNA II', DEP_DENOMINACAO_ABREVIADA = 'RIBEIRÃO PRETO - GNA II' WHERE DEP_CODIGO= 72 AND DEP_DATA_EXTINCAO IS NULL ;                                                            
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE CORUMBÁ - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE CORUMBÁ - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO INTERN. DE CORUMBÁ - GRUPO IV' WHERE DEP_CODIGO= 18 AND DEP_DATA_EXTINCAO IS NULL ;                                                         
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL MARECHAL CUNHA MACHADO/SÃO LUIS', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL  MARECHAL CUNHA MACHADO/SÃO LUÍS - GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN. MARECHAL CUNHA MACHADO' WHERE DEP_CODIGO= 21 AND DEP_DATA_EXTINCAO IS NULL ;                            
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE SÃO PAULO/CONGONHAS - GR ESPECIAL', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE SÃO PAULO/CONGONHAS', DEP_DENOMINACAO_ABREVIADA = 'AEROP. DE SÃO PAULO/CONGONHAS' WHERE DEP_CODIGO= 24 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE MACAPÁ - GRUPO II', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE MACAPÁ - ALBERTO ALCOLUMBRE - GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO INTERN.  DE MACAPÁ - GRUPO II' WHERE DEP_CODIGO= 31 AND DEP_DATA_EXTINCAO IS NULL ;                                       
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE UBERLÂNDIA - GRUPO II', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE UBERLÂNDIA - TEN. CEL. AV. CÉSAR BOMBONATO - GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE UBERLANDIA - GRUPO II' WHERE DEP_CODIGO= 38 AND DEP_DATA_EXTINCAO IS NULL ;                                                    
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL CRUZEIRO DO SUL - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL CRUZEIRO DO SUL - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN. CRUZEIRO DO SUL' WHERE DEP_CODIGO= 42 AND DEP_DATA_EXTINCAO IS NULL ;                                                            
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE BELO HORIZONTE/PAMPULHA - GRUPO II', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE BELO HORIZONTE/PAMPULHA-CARLOS DRUMMOND DE ANDRADE - GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROP. DE BELO HORIZONTE/PAMPULHA' WHERE DEP_CODIGO= 5 AND DEP_DATA_EXTINCAO IS NULL ;                                 
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE TABATINGA - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE TABATINGA - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERNACIONAL DE TABATINGA' WHERE DEP_CODIGO= 43 AND DEP_DATA_EXTINCAO IS NULL ;                                                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE ZONA DA MATA - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADMO 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE ZONA DA MATA - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE ZONA DA MATA - GRUPO IV' WHERE DEP_CODIGO= 154 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'ITAITUBA - GNA III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE ITAITUBA - GNA III', DEP_DENOMINACAO_ABREVIADA = 'ITAITUBA - GNA III' WHERE DEP_CODIGO= 75 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                       
UPDATE DEPENDENCIAS SET DEP_NOME = 'BARRA DO GARÇAS - GNA IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'BARRA DO GARÇAS - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'BARRA DO GARÇAS - GNA IV' WHERE DEP_CODIGO= 78 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'CAROLINA - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'CAROLINA - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'CAROLINA - GNA IV' WHERE DEP_CODIGO= 79 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                        
UPDATE DEPENDENCIAS SET DEP_NOME = 'JACAREACANGA - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'JACAREACANGA - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'JACAREACANGA - GNA IV' WHERE DEP_CODIGO= 81 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                            
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE SÃO PAULO GUARULHOS - GR. ESPECIA', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM. 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE SÃO PAULO / GUARULHOS - GOVERNADOR ANDRÉ FRANCO MONTORO', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERNACIONAL DE SÃO PAULO/GUARULHOS' WHERE DEP_CODIGO= 57 AND DEP_DATA_EXTINCAO IS NULL ;
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE CARAJÁS - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE CARAJÁS - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE CARAJÁS - GRUPO IV' WHERE DEP_CODIGO= 60 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                              
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DO RIO DE JANEIRO/ GALEÃO - ANTÔNIO', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DO RIO DE JANEIRO/ GALEÃO - ANTÔNIO CARLOS JOBIM', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERNACIONAL DO RIO DE JANEIRO /GALEÃO' WHERE DEP_CODIGO= 61 AND DEP_DATA_EXTINCAO IS NULL ;                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO SANTOS DUMONT - GRUPO I', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO SANTOS DUMONT - GRUPO I', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO SANTOS DUMONT - GRUPO I' WHERE DEP_CODIGO= 62 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                             
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE MACAÉ - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE MACAÉ - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE MACAÉ - GRUPO III' WHERE DEP_CODIGO= 64 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                      
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE JACAREPAGUÁ - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE JACAREPAGUÁ - ROBERTO MARINHO - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE JACAREPAGUÁ - GRUPO III' WHERE DEP_CODIGO= 65 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROP. DE SÃO JOSÉ DOS CAMPOS - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE SÃO JOSÉ DOS CAMPOS -  PROF. URBANO ERNESTO STUMPF - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROP. DE SÃO JOSÉ DOS CAMPOS' WHERE DEP_CODIGO= 149 AND DEP_DATA_EXTINCAO IS NULL ;                                          
UPDATE DEPENDENCIAS SET DEP_NOME = 'TARAUACA - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'TARAUACA - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'TARAUACA - GNA IV' WHERE DEP_CODIGO= 94 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'TUCURUÍ - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'TUCURUÍ - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'TUCURUÍ - GNA IV' WHERE DEP_CODIGO= 95 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'SÃO GABRIEL DA CACHOEIRA - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'SÃO GABRIEL DA CACHOEIRA - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'SÃO GABRIEL DA CACHOEIRA - GNA IV' WHERE DEP_CODIGO= 96 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE URUBUPUNGÁ', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IPNº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE URUBUPUNGÁ - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'URUBUPUNGÁ - GNA IV' WHERE DEP_CODIGO= 97 AND DEP_DATA_EXTINCAO IS NULL ;                                                                         
UPDATE DEPENDENCIAS SET DEP_NOME = 'VILHENA - GNA III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'VILHENA-GNA III', DEP_DENOMINACAO_ABREVIADA = 'VILHENA-GNA III' WHERE DEP_CODIGO= 98 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'IAUARETÉ - GNA IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'IAUARETÉ - GNA IV', DEP_DENOMINACAO_ABREVIADA = 'IAUARETÉ - GNA IV' WHERE DEP_CODIGO= 99 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE JULIO CESAR - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE JULIO CESAR - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE JULIO CESAR - GRUPO IV' WHERE DEP_CODIGO= 45 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE IMPERATRIZ - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE IMPERATRIZ - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE IMPERATRIZ - GRUPO III' WHERE DEP_CODIGO= 46 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE MARABÁ - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE MARABÁ - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE MARABÁ - GRUPO III' WHERE DEP_CODIGO= 47 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                              
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE PONTA PORÃ - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE PONTA PORÃ - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN. DE PONTA PORÃ' WHERE DEP_CODIGO= 48 AND DEP_DATA_EXTINCAO IS NULL ;                                                              
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE BRASÍLIA - GRUPO ESPECIAL', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE BRASÍLIA - PRESIDENTE JUSCELINO KUBITSCHEK', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERNACIONAL DE BRASÍLIA PRES. JUSCELINO KUBITSCHEK' WHERE DEP_CODIGO= 2 AND DEP_DATA_EXTINCAO IS NULL ;       
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE BOA VISTA - ATLAS BRASIL CANTANHE', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE BOA VISTA - ATLAS BRASIL CANTANHEDE - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN. DE BOA VISTA' WHERE DEP_CODIGO= 6 AND DEP_DATA_EXTINCAO IS NULL ;                              
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE UBERABA - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE UBERABA - MG - MÁRIO DE ALMEIDA FRANCO -GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE UBERABA - GRUPO IV' WHERE DEP_CODIGO= 37 AND DEP_DATA_EXTINCAO IS NULL ;                                                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE MONTES CLAROS - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE MONTES CLAROS - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE MONTES CLAROS - GRUPO IV' WHERE DEP_CODIGO= 39 AND DEP_DATA_EXTINCAO IS NULL ;                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE SANTARÉM - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE SANTARÉM - MAESTRO WILSON FONSECA', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE SANTARÉM - GRUPO III' WHERE DEP_CODIGO= 40 AND DEP_DATA_EXTINCAO IS NULL ;                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE ALTAMIRA - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010 E IP Nº 23/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE ALTAMIRA - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE ALTAMIRA - GRUPO IV' WHERE DEP_CODIGO= 41 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                           
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE TEFÉ - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE TEFÉ - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE TEFÉ - GRUPO IV' WHERE DEP_CODIGO= 44 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                          
UPDATE DEPENDENCIAS SET DEP_NOME = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE TRÊS LAGOAS', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'GRUPAMENTO DE NAVEGAÇÃO AÉREA DE TRÊS LAGOAS', DEP_DENOMINACAO_ABREVIADA = 'GNA DE TRÊS LAGOAS' WHERE DEP_CODIGO= 155 AND DEP_DATA_EXTINCAO IS NULL ;                                                                               
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL TANCREDO NEVES - GRUPO I', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL TANCREDO NEVES - CONFINS - GRUPO I', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERNACIONAL TANCREDO NEVES/CONFINS' WHERE DEP_CODIGO= 58 AND DEP_DATA_EXTINCAO IS NULL ;                                     
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO BARTOLOMEU LISANDRO - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO BARTOLOMEU LISANDRO - CAMPOS - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROP. BARTOLOMEU LISANDRO' WHERE DEP_CODIGO= 63 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                             
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL MARECHAL RONDON - GRUPO II', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL MARECHAL RONDON/CUIABÁ - GRUPO II', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN. MARECHAL RONDON' WHERE DEP_CODIGO= 19 AND DEP_DATA_EXTINCAO IS NULL ;                                                 
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE VITÓRIA - GRUPO I', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010 E IP Nº 007/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE VITÓRIA - EURICO DE AGUIAR SALLES', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE VITÓRIA - GRUPO I' WHERE DEP_CODIGO= 23 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL EDUARDO GOMES - GRUPO I', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL EDUARDO GOMES - MANAUS', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO INTERNACIONAL DE MANAUS' WHERE DEP_CODIGO= 25 AND DEP_DATA_EXTINCAO IS NULL ;                                                                
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE VIRACOPOS CAMPINAS - GR. ESPECIAL', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE VIRACOPOS/CAMPINAS', DEP_DENOMINACAO_ABREVIADA = 'AEROP.  INTERNACIONAL DE VIRACOPOS' WHERE DEP_CODIGO= 26 AND DEP_DATA_EXTINCAO IS NULL ;                                                             
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO DE CARLOS PRATES - GRUPO IV', DEP_DATA_CRIACAO = TO_DATE('14/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 158/PR/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO DE CARLOS PRATES - GRUPO IV', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO DE CARLOS PRATES - GRUPO IV' WHERE DEP_CODIGO= 27 AND DEP_DATA_EXTINCAO IS NULL ;                                                                                                 
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE RIO BRANCO', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE RIO BRANCO/AC  -  PLÁCIDO DE CASTRO - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN.  DE RIO BRANCO' WHERE DEP_CODIGO= 29 AND DEP_DATA_EXTINCAO IS NULL ;                                                  
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO INTERNACIONAL DE PORTO VELHO - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('02/02/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 361/PR/2010, IP 023/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO INTERNACIONAL DE PORTO VELHO - GOV. JORGE TEIXEIRA DE OLIVEIRA - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROP. INTERN.  DE PORTO VELHO' WHERE DEP_CODIGO= 30 AND DEP_DATA_EXTINCAO IS NULL ;                          
UPDATE DEPENDENCIAS SET DEP_NOME = 'AEROPORTO CAMPO DE MARTE - GRUPO III', DEP_DATA_CRIACAO = TO_DATE('25/01/2010', 'DD/MM/YYYY'), DEP_DS_DOCUMENTO_CRIACAO = 'ATO ADM 240/PR/2010 E IP Nº 022/PRPG/2010', DEP_DENOMINACAO_COMPLETA = 'AEROPORTO CAMPO DE MARTE - GRUPO III', DEP_DENOMINACAO_ABREVIADA = 'AEROPORTO CAMPO DE MARTE - GRUPO III' WHERE DEP_CODIGO= 33 AND DEP_DATA_EXTINCAO IS NULL ;                                                                              


--*****************************************************
SELECT  *
  FROM  UNIDADES_ORGANIZACIONAIS
--  UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = sysdate, uor_ds_documento_extincao = 'EXTINTA A PEDIDO DA DARH EM 10/03/2010.'
 WHERE  UOR_DATA_CRIACAO >= TO_DATE('19/11/2009', 'DD/MM/YYYY')
   AND  UOR_DEP_CODIGO IN (155, 156, 161, 157, 158, 159, 57, 61, 25, 58, 2, 4, 5, 6, 11, 15, 17, 18, 19, 21, 23, 24, 26, 27, 29, 30, 31, 33, 37, 38, 39, 42, 43, 44, 48, 62, 63, 64, 65, 71, 72, 73, 74, 78, 84, 89, 91, 92, 94, 96, 97, 98, 99, 149, 152, 154)
/


SELECT  *
  FROM  UNIDADES_ORGANIZACIONAIS
--  UPDATE UNIDADES_ORGANIZACIONAIS SET uor_data_extincao = NULL, uor_ds_documento_extincao = NULL
 WHERE  UOR_DATA_EXTINCAO >= TO_DATE('09/03/2010', 'DD/MM/YYYY')
   AND  UOR_DEP_CODIGO IN (155, 156, 161, 157, 158, 159, 57, 61, 25, 58, 2, 4, 5, 6, 11, 15, 17, 18, 19, 21, 23, 24, 26, 27, 29, 30, 31, 33, 37, 38, 39, 42, 43, 44, 48, 62, 63, 64, 65, 71, 72, 73, 74, 78, 84, 89, 91, 92, 94, 96, 97, 98, 99, 149, 152, 154)
/


SELECT  *
  FROM  UNIDADES_ORGANIZACIONAIS
 WHERE  UOR_DEP_CODIGO IN (157)
   AND  UOR_DATA_EXTINCAO IS NULL
/



---*********************************************************************************************************************************************
SELECT  'UPDATE DEPENDENCIAS SET DEP_NOME = ''' || DEP_NOME || ''', DEP_DATA_CRIACAO = TO_DATE('''|| TO_CHAR(DEP_DATA_CRIACAO,'DD/MM/YYYY') || ''', ''DD/MM/YYYY''), DEP_DS_DOCUMENTO_CRIACAO = ''' || DEP_DS_DOCUMENTO_CRIACAO || ''', DEP_DENOMINACAO_COMPLETA = ''' || DEP_DENOMINACAO_COMPLETA || ''', DEP_DENOMINACAO_ABREVIADA = ''' || DEP_DENOMINACAO_ABREVIADA || ''' WHERE DEP_CODIGO= '|| DEP_CODIGO || ' AND DEP_DATA_EXTINCAO IS NULL ;'
FROM    IFRDBA2.BKP_DEP
WHERE   DEP_CODIGO IN (155, 156, 161, 157, 158, 159, 57, 61, 25, 58, 2, 4, 5, 6, 11, 15, 17, 18, 19, 21, 23, 24, 26, 27, 29, 30, 31, 33, 37, 38, 39, 42, 43, 44, 48, 62, 63, 64, 65, 71, 72, 73, 74, 78, 84, 89, 91, 92, 94, 96, 97, 98, 99, 149, 152, 154)
  AND   DEP_DATA_EXTINCAO IS NULL
/

SELECT 'UPDATE DEPENDENCIAS SET DEP_DEP_CODIGO = ' || DEP_DEP_CODIGO || ' WHERE DEP_CODIGO = ' || DEP_CODIGO || ';'
  FROM IFRDBA2.BKP_DEP
 WHERE DEP_DATA_EXTINCAO IS NULL
   AND DEP_DEP_CODIGO != 1
   
   
DELETE FROM HISTORICO_DEPENDENCIAS
/

INSERT INTO HISTORICO_DEPENDENCIAS
SELECT * FROM IFRDBA2.BKP_HIST_DEP
/

   
--****************************************************************