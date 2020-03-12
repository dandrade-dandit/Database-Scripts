--OUTROS
SELECT  *
FROM    UNIDADES_ORGANIZACIONAIS
WHERE   UOR_DATA_CRIACAO > TO_DATE('16/11/2009','DD/MM/YYYY')

SELECT  'UPDATE UNIDADES_ORGANIZACIONAIS SET UOR_DATA_EXTINCAO = TO_DATE(''' || TO_CHAR(UOR_DATA_EXTINCAO, 'DD/MM/YYYY') || ''',''DD/MM/YYYY'') WHERE UOR_CODIGO = ' || UOR_CODIGO || ';'
FROM    UNIDADES_ORGANIZACIONAIS
WHERE   UOR_DATA_EXTINCAO > TO_DATE('16/11/2009','DD/MM/YYYY')

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

--CARGA DOS ARQUIVOS


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

SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 158
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')

SELECT  *
FROM    UNIDADES_ORGANIZACIONAIS 
WHERE   UOR_DEP_CODIGO = 158



--DEPENDENCIAS
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

UPDATE  DEPENDENCIAS
SET     DEP_NOME = 'SUPERINTENDÊNCIA REGIONAL DO RIO DE JANEIRO'
,       DEP_SIGLA = 'SRRJ.'
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

--UNIDADES_ORGANIZACIONAIS
INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 156
/

INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT  *
FROM    IFRDBA2.TMP_UOR
WHERE   UOR_DEP_CODIGO = 158
AND     UOR_DATA_CRIACAO >= TO_DATE('14/01/2010','DD/MM/YYYY')
/

--HISTORICO DEPENDENCIAS
DELETE FROM HISTORICO_DEPENDENCIAS
/

EXECUTAR CARGA PELO ARQUIVO HDE.SQL

--PRODSEDE2
INSERT INTO TAB_ENTIDADE_SMART VALUES('156','02156', TO_DATE('14/01/2010', 'DD/MM/YYYY')
/

