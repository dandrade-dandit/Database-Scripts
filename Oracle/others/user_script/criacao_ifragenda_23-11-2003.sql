--ifrsrh
grant SELECT on cadastros to agenda_usu;
grant SELECT on cargos to agenda_usu;
grant SELECT on cargos_confianca to agenda_usu;
grant SELECT on Dependencias to agenda_usu;
grant SELECT on ocupacoes_cargo to agenda_usu;
grant SELECT on orgaos_externos to agenda_usu;
grant SELECT on quadro_funcoes to agenda_usu;
grant SELECT on ocorrencias_empregados to agenda_usu;
grant SELECT on empregado_fone_comercial to agenda_usu;


grant SELECT on cadastros to ifragenda with grant option;
grant SELECT on cargos to ifragenda with grant option;
grant SELECT on cargos_confianca to ifragenda with grant option;
grant SELECT on Dependencias to ifragenda with grant option;
grant SELECT on ocupacoes_cargo to ifragenda with grant option;
grant SELECT on orgaos_externos to ifragenda with grant option;
grant SELECT on quadro_funcoes to ifragenda with grant option;
grant SELECT on ocorrencias_empregados to ifragenda with grant option;
grant SELECT on empregado_fone_comercial to ifragenda with grant option;


--ifrdba2
grant SELECT on Feriado to agenda_usu;
grant SELECT on municipios to agenda_usu;
grant SELECT on unidades_organizacionais to agenda_usu;
grant SELECT on dependencias to agenda_usu;

grant SELECT on Feriado to ifragenda with grant option;
grant SELECT on municipios to ifragenda with grant option;
grant SELECT on unidades_organizacionais to ifragenda with grant option;
grant SELECT on dependencias to ifragenda with grant option;


--criacao dos objetos
-- Start of DDL Script for Table IFRAGENDA.CONCESSIONARIAS
-- Generated 23-out-2003 9:14:31 from IFRAGENDA@HOMOLOG

CREATE TABLE ifragenda.concessionarias
    (con_codigo                     NUMBER(36,0) NOT NULL,
    con_ramo_comercial             CHAR(30),
    con_nome                       CHAR(60),
    con_ddd_telefone               CHAR(5),
    con_numero_ramal               CHAR(4),
    con_numero_fax                 CHAR(9),
    con_dep_codigo                 CHAR(20),
    con_endereco_logradouro        CHAR(60),
    con_endereco_bairro            CHAR(60),
    con_endereco_cidade            CHAR(35),
    con_endereco_eletronico        CHAR(70),
    con_nome_fantasia              CHAR(60),
    con_status                     CHAR(1),
    con_numero_telefone            CHAR(9),
    con_endereco_cep               CHAR(9),
    con_endereco_ufe_sigla         CHAR(2),
    con_identificador              VARCHAR2(36))
/

-- Grants for Table

GRANT DELETE ON ifragenda.concessionarias TO agenda_usu
/
GRANT INSERT ON ifragenda.concessionarias TO agenda_usu
/
GRANT SELECT ON ifragenda.concessionarias TO agenda_usu
/
GRANT UPDATE ON ifragenda.concessionarias TO agenda_usu
/

-- Constraints for IFRAGENDA.CONCESSIONARIAS

ALTER TABLE ifragenda.concessionarias
ADD CONSTRAINT con_codigo_pk PRIMARY KEY (con_codigo)
using index tablespace tsi_pessoal
/

CREATE OR REPLACE TRIGGER TRG_SEQ_CONCESSIONARIA
 BEFORE
 INSERT
 ON CONCESSIONARIAS
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
 SEQ_CON_CODIGO NUMBER;
BEGIN
 SELECT SEQ_CONCESSIONARIA.NEXTVAL
 INTO SEQ_CON_CODIGO FROM DUAL;
 :NEW.CON_CODIGO := SEQ_CON_CODIGO;
END;
/

-- Comments for IFRAGENDA.CONCESSIONARIAS

COMMENT ON COLUMN ifragenda.concessionarias.con_codigo IS 'Codigo Sequencial da Concessionaria'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_ddd_telefone IS 'Código DDD do Telefone da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_dep_codigo IS 'Código da Dependência aonde está a Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_bairro IS 'Bairro do Endereco da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_cep IS 'CEP do Endereço da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_cidade IS 'Cidade do Endereço da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_eletronico IS 'E-mail do Concessionário/Loja'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_logradouro IS 'Endereço da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_endereco_ufe_sigla IS 'UFE do Endereço da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_identificador IS 'Código Identificador da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_nome IS 'Nome da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_nome_fantasia IS 'Nome Fantasia da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_numero_fax IS 'Número do Fax da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_numero_ramal IS 'Número do Ramal da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_numero_telefone IS 'Número do Telefone da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_ramo_comercial IS 'Ramo Comercial da Concessionária'
/
COMMENT ON COLUMN ifragenda.concessionarias.con_status IS 'Status da Concessionária (N.Ativa, S.Não Ativa)'
/

-- Start of DDL Script for Package IFRAGENDA.PK_FERIAS
-- Generated 23-out-2003 9:27:55 from IFRAGENDA@HOMOLOG

CREATE OR REPLACE 
PACKAGE ifragenda.pk_ferias  AS

 FUNCTION superior_uor(p_uor_codigo NUMBER) RETURN NUMBER;

 FUNCTION chefe_imediato(p_emp_uor_codigo_lotacao NUMBER,
                         p_emp_numero_matricula NUMBER,
                         p_via_data_inicio DATE := TRUNC(SYSDATE),
                         p_via_data_termino DATE  := TRUNC(SYSDATE)) RETURN NUMBER;

 FUNCTION chefe_imediato_subst(p_emp_uor_codigo_lotacao NUMBER,
                               p_emp_numero_matricula NUMBER,
                               p_via_data_inicio DATE := TRUNC(SYSDATE),
                               p_via_data_termino DATE := TRUNC(SYSDATE),
                               p_subst NUMBER := 1) RETURN NUMBER ;

END PK_FERIAS;
/


CREATE OR REPLACE 
PACKAGE BODY ifragenda.pk_ferias  AS

 FUNCTION superior_uor(p_uor_codigo NUMBER) RETURN NUMBER IS
   CURSOR c1 IS
    SELECT a.uor_uor_codigo, a.uor_dep_codigo
     FROM unidades_organizacionais a
     WHERE a.uor_codigo = p_uor_codigo;
   r1 c1%ROWTYPE;
   v_superior_uor r1.uor_uor_codigo%TYPE := 0;
   CURSOR c2 IS
   	 SELECT a.uor_codigo
	     FROM unidades_organizacionais a, dependencias b
	     WHERE a.uor_dep_codigo = b.dep_dep_codigo
	       AND a.uor_uor_codigo IS NULL
	       AND a.uor_data_extincao IS NULL
	       AND b.dep_grupos_dependencias = 18
	       AND b.dep_data_extincao IS NULL
	       AND b.dep_codigo = r1.uor_dep_codigo;
   r2 c2%ROWTYPE;
 BEGIN
 	OPEN c1;
 	FETCH c1 INTO r1;
 	IF c1%FOUND THEN
 	 v_superior_uor := r1.uor_uor_codigo;
 	END IF;
 	CLOSE c1;
 	IF NVL(v_superior_uor,0)= 0 THEN
 		OPEN c2;
 		FETCH c2 INTO r2;
 		IF c2%FOUND THEN
 	 		v_superior_uor := r2.uor_codigo;
 		END IF;
 		CLOSE c2;
 	END IF;
 	RETURN v_superior_uor;
 END;

 FUNCTION chefe_imediato(p_emp_uor_codigo_lotacao NUMBER,
                         p_emp_numero_matricula NUMBER,
                         p_via_data_inicio DATE := TRUNC(SYSDATE),
                         p_via_data_termino DATE  := TRUNC(SYSDATE)) RETURN NUMBER IS
 BEGIN
 	 RETURN chefe_imediato_subst(p_emp_uor_codigo_lotacao,
                               p_emp_numero_matricula,
                               p_via_data_inicio,
                               p_via_data_termino,
                               1);
 END;

 FUNCTION chefe_imediato_subst(p_emp_uor_codigo_lotacao NUMBER,
                               p_emp_numero_matricula NUMBER,
                               p_via_data_inicio DATE := TRUNC(SYSDATE),
                               p_via_data_termino DATE := TRUNC(SYSDATE),
                               p_subst NUMBER := 1) RETURN NUMBER IS
	CURSOR c1 IS
   SELECT a.oem_emp_numero_matricula -- substituicao
    FROM ocorrencias_empregados a
    WHERE a.oem_ofu_codigo IN(89, 220, 221, 222)
      AND a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      AND p_via_data_inicio BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'))
      AND p_via_data_termino BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'))
      AND a.oem_emp_numero_matricula_subst IS NOT NULL
      AND p_subst = 1
      AND EXISTS(SELECT 'x'
                  FROM cadastros b, cargos_confianca c
									WHERE b.emp_status = 1
	  							AND b.emp_numero_matricula = a.oem_emp_numero_matricula_subst
	  							AND b.emp_qfu_fun_codigo  = c.fun_codigo
	 							 	AND c.fun_posicao_trabalho = 0);

	CURSOR c2 IS
   SELECT a.oem_emp_numero_matricula -- diretores
    FROM ocorrencias_empregados a
    WHERE a.oem_ofu_codigo IN(125, 238, 240)
      AND a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      AND p_via_data_inicio BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'))
      AND p_via_data_termino BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'));
	CURSOR c3 IS
   SELECT a.oem_emp_numero_matricula  -- nomeação tem que ter posição de trabalho = 0
    FROM ocorrencias_empregados a
    WHERE a.oem_ofu_codigo IN(85, 86, 88, 93, 217, 256) -- designacao
      AND a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      AND p_via_data_inicio BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'))
      AND p_via_data_termino BETWEEN a.oem_data_inicio AND NVL(a.oem_data_termino, TO_DATE('31129999', 'ddmmyyyy'))
      AND EXISTS(SELECT 'x'
                  FROM cadastros b, cargos_confianca c
									WHERE b.emp_status = 1
	  							AND b.emp_numero_matricula = a.oem_emp_numero_matricula
	  							AND b.emp_qfu_fun_codigo  = c.fun_codigo
	 							 	AND c.fun_posicao_trabalho = 0);
	r1 c1%ROWTYPE;
	v_c1_found BOOLEAN;
 BEGIN
 	IF p_emp_uor_codigo_lotacao != 0 THEN
	 OPEN c1;
	 FETCH c1 INTO r1;
	 IF c1%NOTFOUND THEN
    CLOSE c1;
	  OPEN c2;
	  FETCH c2 INTO r1;
	  IF c2%NOTFOUND THEN
     CLOSE c2;
	   OPEN c3;
	   FETCH c3 INTO r1;
	   IF c3%NOTFOUND THEN
	    CLOSE c3;
   		RETURN(chefe_imediato_subst(superior_uor(p_emp_uor_codigo_lotacao),
                            p_emp_numero_matricula,
                            p_via_data_inicio,
                            p_via_data_termino,
                            p_subst));
     END IF;
     CLOSE c3;
	  ELSE
	   CLOSE c2;
	  END IF;
	 ELSE
    CLOSE c1;
	 END IF;
   IF r1.oem_emp_numero_matricula = p_emp_numero_matricula THEN
     r1.oem_emp_numero_matricula :=chefe_imediato_subst(superior_uor(p_emp_uor_codigo_lotacao),
                           p_emp_numero_matricula,
                           p_via_data_inicio,
                           p_via_data_termino,
                           p_subst);
     IF NVL(r1.oem_emp_numero_matricula, 0) = 0 THEN
     	RETURN p_emp_numero_matricula;
     ELSE
     	RETURN r1.oem_emp_numero_matricula;
     END IF;
	 END IF;
	 RETURN (r1.oem_emp_numero_matricula);
	END IF;
	RETURN 0;
 END;

END PK_FERIAS;
/


-- End of DDL Script for Package IFRAGENDA.PK_FERIAS

CREATE TABLE ifragenda.terceiros
    (ter_cpf                        NUMBER(11,0) NOT NULL,
    ter_numero_matricula           NUMBER(7,0) NOT NULL,
    ter_nome                       VARCHAR2(60) NOT NULL,
    ter_nome_abreviado             VARCHAR2(40),
    ter_numero_celular             NUMBER(8,0),
    ter_ddd_celular                NUMBER(4,0),
    ter_qlp_car_codigo             NUMBER(3,0),
    ter_qlp_car_codigo_nivel       NUMBER(1,0),
    ter_qlp_car_occ_codigo         NUMBER(3,0),
    ter_dep_codigo_lotacao         NUMBER(4,0),
    ter_dep_codigo_fisico          NUMBER(4,0),
    ter_uor_codigo_lotacao         NUMBER(9,0),
    ter_status                     NUMBER(2,0),
    ter_nome_guerra                VARCHAR2(30),
    ter_endereco_eletronico_mail   VARCHAR2(80),
    ter_endereco_logradouro        VARCHAR2(100) NOT NULL,
    ter_endereco_numero_cep        NUMBER(8,0) NOT NULL,
    ter_data_nascimento            DATE NOT NULL,
    ter_ramal_residencial          NUMBER(4,0),
    ter_endereco_bairro            VARCHAR2(30),
    ter_endereco_fone              NUMBER(8,0),
    ter_ddd_residencial            NUMBER(4,0))
  
/

-- Grants for Table
GRANT ALTER ON ifragenda.terceiros TO agenda_usu
/
GRANT DELETE ON ifragenda.terceiros TO agenda_usu
/
GRANT INSERT ON ifragenda.terceiros TO agenda_usu
/
GRANT SELECT ON ifragenda.terceiros TO agenda_usu
/
GRANT UPDATE ON ifragenda.terceiros TO agenda_usu
/
GRANT REFERENCES ON ifragenda.terceiros TO agenda_usu
/

-- Constraints for IFRAGENDA.TERCEIROS

ALTER TABLE ifragenda.terceiros
ADD CONSTRAINT pk_terceiros PRIMARY KEY (ter_cpf)
using index tablespace tsi_pessoal
/


-- Comments for IFRAGENDA.TERCEIROS

COMMENT ON COLUMN ifragenda.terceiros.ter_cpf IS 'NUMERO DO CPF DO TERCEIRIZADO'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_data_nascimento IS 'Data de nascimento do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_ddd_celular IS 'DESCRICAO DO NUMERO DO DDD DO TERCEIRIZADO.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_ddd_residencial IS 'Descricao do numero do DDD do telefone residencial do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_dep_codigo_fisico IS 'CODIGO DA DEPENDENCIA FISICA DO TERCEIRIZADO (DEPENDENCIA REAL).'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_dep_codigo_lotacao IS 'CODIGO DA DEPENDENCIA DE LOTACAO DO TERCEIRIZADO (DEPENDENCIA DE LOTACAO).'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_endereco_bairro IS 'Descricao do endereco do bairro residencial do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_endereco_eletronico_mail IS 'DESCRICAO DO ENDERECO ELETRONICO DO TERCEIRIZADO.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_endereco_fone IS 'Descricao do numero do telefone residencial do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_endereco_logradouro IS 'Descricao do endereco residencial do terceirizado,'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_endereco_numero_cep IS 'Descricao do CEP do endereco residencial do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_nome IS 'DESCRICAO DO NOME DO TERCEIRIZADO COMPLETO.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_nome_abreviado IS 'DESCRICAO DO NOME DO TERCEIRIZADO ABREVIADO'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_nome_guerra IS 'NOME DE GUERRA (APELIDO) DO TERCEIRIZADO.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_numero_celular IS 'DESCRICAO DO NUMERO DO CELULAR DO TERCEIRIZADO.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_numero_matricula IS 'IDENTIFICADOR DO NUMERO DE MATRICULA DO TERCEIRIZADO CONTRATADO (ATIVO)'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_qlp_car_codigo IS 'CODIGO IDENTIFICADOR DO CARGO DO TERCEIRIZADO (EX.ANALISTA SUPERIOR) >> TAB_CARGOS.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_qlp_car_codigo_nivel IS 'CODIGO IDENTIFICADOR DO NIVEL DO CARGO DO TERCEIRIZADO (1. OPERACIONAL; 2. TECNICO; 3. ESPECIALIZADO; 4. PLENO; 5. SENIOR; 6. SEM NIVEL (CARGO ANTERIOR); 7. SEM NIVEL).'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_qlp_car_occ_codigo IS 'CODIGO IDENTIFICADOR DA OCUPACAO ATUAL DO TERCEIRIZADO (EX. ANALISTA DE SISTEMAS) >> TAB_OCUPACOES.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_ramal_residencial IS 'Descricao do numero do ramal da residencia do terceirizado.'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_status IS 'IDENTIFICADOR DO STATUS DO EMPREGADO (0. AFASTADO; 1. ATIVO; 2. DESLIGADO).'
/
COMMENT ON COLUMN ifragenda.terceiros.ter_uor_codigo_lotacao IS 'CODIGO DA LOTACAO (UOR) DO TERCEIRIZADO (SEMPRE LISTA UOR REAL).'
/


-- Start of DDL Script for View IFRAGENDA.VIW_CADASTROS
-- Generated 23-out-2003 9:20:21 from IFRAGENDA@HOMOLOG

CREATE OR REPLACE VIEW ifragenda.viw_cadastros (
   emp_numero_matricula,
   emp_nome,
   emp_nome_abreviado,
   emp_numero_celular,
   emp_ddd_celular,
   emp_oex_codigo_cedido,
   emp_oex_codigo_requisitado,
   emp_qlp_cargo,
   emp_qlp_car_nivel,
   emp_qlp_car_ocupacao,
   emp_qfu_funcao,
   emp_qfu_fun_codigo,
   emp_qfu_fun_codigo_acumula,
   emp_qfu_hfl_uor_cod_acum,
   emp_qfu_fun_codigo_substitui,
   emp_qfu_hfl_uor_cod_subst,
   emp_dep_lotacao,
   emp_dep_codigo_lotacao,
   emp_dep_fisico,
   emp_dep_fisico_tipo,
   emp_dep_fisico_tipo_nome,
   emp_dep_codigo_fisico,
   emp_uor_lotacao,
   emp_uor_lotacao_sigla,
   emp_uor_codigo_lotacao,
   emp_nome_guerra,
   emp_endereco_eletronico_mail,
   emp_efc_uff_tipo,
   emp_efc_uff_numero,
   emp_efc_uff_voip_ddd )
AS
(
SELECT 
EMP_NUMERO_MATRICULA, EMP_NOME, EMP_NOME_ABREVIADO, EMP_NUMERO_CELULAR, EMP_DDD_CELULAR, EMP_OEX_CODIGO_CEDIDO,
EMP_OEX_CODIGO_REQUISITADO, CAR.CAR_NOME AS EMP_QLP_CARGO, DECODE(EMP_NSA_CODIGO_NIVEL,1,'OPERACIONAL',2,'TECNICO',3,'ESPECIALIZADO',4,'PLENO',5,'SENIOR','') AS EMP_QLP_CAR_NIVEL,
OCC.OCC_DESCRICAO AS EMP_QLP_CAR_OCUPACAO, EMP_QFU_FUN_CODIGO AS EMP_QFU_FUNCAO, EMP_QFU_FUN_CODIGO, EMP_QFU_FUN_CODIGO_ACUMULA, EMP_QFU_HFL_UOR_COD_ACUM, EMP_QFU_FUN_CODIGO_SUBSTITUI, EMP_QFU_HFL_UOR_COD_SUBST,
D.DEP_NOME AS EMP_DEP_LOTACAO, EMP_DEP_CODIGO_LOTACAO, 
D.DEP_NOME AS EMP_DEP_FISICO, D.DEP_TIPO AS EMP_DEP_FISICO_TIPO,
DECODE(D.DEP_TIPO, 1,'SEDE', 2,'SUPERINTENDÊNCIA', 3,'AEROPORTO', 4,'GTA', 5,'COORDENAÇÃO DE NEGÓCIO', 6,'GNA', 
7,'UNA', 8,'CONVÊNIOS COM RESSARCIMENTO', 9,'CONVÊNIOS SEM RESSARCIMENTO', 10,'DEPENDÊNCIA GNA', 11,'DEPENDÊNCIA UNA', 
12,'DEPENDÊNCIA DE DEPENDÊNCIA', D.DEP_TIPO) AS EMP_DEP_FISICO_TIPO_NOME, 
EMP_DEP_CODIGO_FISICO, UOR.UOR_NOME AS EMP_UOR_LOTACAO, UOR.UOR_SIGLA AS EMP_UOR_LOTACAO_SIGLA, 
EMP_UOR_CODIGO_LOTACAO, EMP_NOME_GUERRA, EMP_ENDERECO_ELETRONICO_MAIL, 
DECODE(EFC.EFC_UFF_TIPO,1,'FONE DIRETO',2,'RAMAL',3,'FAX',EFC.efc_uff_tipo) AS EMP_EFC_UFF_TIPO,
EFC.EFC_UFF_NUMERO AS EMP_EFC_UFF_NUMERO, EFC.EFC_UFF_VOIP_DDD AS EMP_EFC_UFF_VOIP_DDD
FROM CADASTROS C, CARGOS CAR, OCUPACOES_CARGO OCC, DEPENDENCIAS D, DEPENDENCIAS D2,
UNIDADES_ORGANIZACIONAIS UOR, EMPREGADO_FONE_COMERCIAL EFC
WHERE
C.EMP_QLP_CAR_CODIGO = CAR.CAR_CODIGO 
AND C.EMP_QLP_CAR_CODIGO_NIVEL = CAR.CAR_CODIGO_NIVEL 
AND C.EMP_QLP_CAR_OCC_CODIGO = CAR.CAR_OCC_CODIGO 
AND CAR.CAR_OCC_CODIGO = OCC.OCC_CODIGO
AND C.EMP_DEP_CODIGO_LOTACAO = D.DEP_CODIGO  
AND C.EMP_DEP_CODIGO_FISICO = D2.DEP_CODIGO
AND C.EMP_UOR_CODIGO_LOTACAO = UOR.UOR_CODIGO
AND C.EMP_NUMERO_MATRICULA = EFC.EFC_EMP_NUMERO_MATRICULA
AND C.EMP_STATUS = '1' 
)
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_cadastros TO agenda_usu
/


CREATE OR REPLACE VIEW ifragenda.viw_cargos (
   car_codigo,
   car_codigo_nivel,
   car_occ_codigo,
   car_nome,
   car_sigla )
AS
(
SELECT 
CAR_CODIGO,CAR_CODIGO_NIVEL,CAR_OCC_CODIGO,CAR_NOME,CAR_SIGLA FROM CARGOS
)
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_cargos TO agenda_usu
/


CREATE OR REPLACE VIEW ifragenda.viw_concessionarias (
   con_identificador,
   con_ramo_comercial,
   con_nome,
   con_ddd_telefone,
   con_numero_telefone,
   con_numero_fax,
   con_dependencia,
   con_endereco_logradouro,
   con_endereco_bairro,
   con_endereco_cidade,
   con_endereco_cep,
   con_endereco_eletronico,
   con_nome_fantasia,
   con_endereco_ufe_sigla )
AS
(
select 
CON_IDENTIFICADOR,
CON_RAMO_COMERCIAL,
CON_NOME,
CON_DDD_TELEFONE,
CON_NUMERO_TELEFONE,
CON_NUMERO_FAX,
DEPENDENCIAS.DEP_NOME as CON_DEPENDENCIA,
CON_ENDERECO_LOGRADOURO,
CON_ENDERECO_BAIRRO,
CON_ENDERECO_CIDADE,
CON_ENDERECO_CEP,
CON_ENDERECO_ELETRONICO,
CON_NOME_FANTASIA,
CON_ENDERECO_UFE_SIGLA
FROM CONCESSIONARIAS, DEPENDENCIAS, MUNICIPIOS M
where
CONCESSIONARIAS.CON_STATUS = 'N' 
)
/

-- Grants for View

GRANT SELECT ON ifragenda.viw_concessionarias TO agenda_usu
/

-- Start of DDL Script for View IFRAGENDA.VIW_DADOS_SUPERINTENDENCIA
-- Generated 23-out-2003 9:21:43 from IFRAGENDA@HOMOLOG

CREATE OR REPLACE VIEW ifragenda.viw_dados_superintendencia (
   dep_codigo,
   dep_tipo,
   dep_nome,
   dep_sigla,
   dep_endereco_logradouro,
   dep_endereco_bairro,
   dep_endereco_municipio,
   dep_ufe_sigla,
   dep_endereco_cep,
   cnpj,
   fone_1,
   fone_2,
   num_fax,
   data_criacao )
AS
select
DEP_CODIGO,DEP_TIPO,DEP_NOME,DEP_SIGLA,DEP_ENDERECO_LOGRADOURO,DEP_ENDERECO_BAIRRO, DEP_ENDERECO_MUNICIPIO,DEP_UFE_SIGLA,
DEP_ENDERECO_CEP,DEP_NUMERO_CGC,DEP_NUMERO_TELEFONE_1,DEP_NUMERO_TELEFONE_2,
DEP_NUMERO_FAX,DEP_DATA_CRIACAO
from dependencias
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_dados_superintendencia TO agenda_usu
/

-- End of DDL Script for View IFRAGENDA.VIW_DADOS_SUPERINTENDENCIA


CREATE OR REPLACE VIEW ifragenda.viw_dependencias (
   dep_codigo,
   dep_tipo,
   dep_tipo_dependencia,
   dep_nome,
   dep_sigla,
   dep_dependencia,
   dep_endereco_logradouro,
   dep_endereco_bairro,
   dep_municipio,
   dep_ufe_sigla,
   dep_endereco_cep,
   dep_numero_telefone_1,
   dep_numero_telefone_2,
   dep_numero_fax,
   dep_numero_cgc,
   dep_dep_codigo,
   dep_data_criacao,
   dep_grupos_dependencias,
   dep_comar,
   dep_denominacao_completa,
   dep_ie,
   dep_horaria_administrativo,
   dep_fuso_horario_brasilia,
   dep_tel_achados_perdidos,
   dep_tel_balcao_informacao,
   dep_tel_comunicacao_social,
   dep_tel_secretaria,
   dep_nome_secretaria,
   dep_tel_superintendente,
   dep_nome_superintendente,
   dep_feriados_locais )
AS
(
SELECT
DEP.DEP_CODIGO, DEP.DEP_TIPO, DECODE(DEP.DEP_TIPO, 1,'SEDE', 2,'SUPERINTENDÊNCIA', 3,'AEROPORTO', 4,'GTA',
5,'COORDENAÇÃO DE NEGÓCIO', 6,'GNA', 7,'UNA', 8,'CONVÊNIOS COM RESSARCIMENTO', 9,'CONVÊNIOS SEM RESSARCIMENTO',
10,'DEPENDÊNCIA GNA', 11,'DEPENDÊNCIA UNA', 12,'DEPENDÊNCIA DE DEPENDÊNCIA', DEP.DEP_TIPO) AS DEP_TIPO_DEPENDENCIA,
DEP.DEP_NOME, DEP.DEP_SIGLA, DEP2.DEP_NOME AS DEP_DEPENDENCIA, DEP.DEP_ENDERECO_LOGRADOURO, DEP.DEP_ENDERECO_BAIRRO,
M.MUN_DESCRICAO AS DEP_MUNICIPIO, DEP.DEP_UFE_SIGLA, DEP.DEP_ENDERECO_CEP, DEP.DEP_NUMERO_TELEFONE_1,
DEP.DEP_NUMERO_TELEFONE_2, DEP.DEP_NUMERO_FAX, DEP.DEP_NUMERO_CGC, DEP.DEP_DEP_CODIGO,
TO_CHAR(DEP.DEP_DATA_CRIACAO,'DD/MM/YYYY') AS DEP_DATA_CRIACAO, DEP.DEP_GRUPOS_DEPENDENCIAS, DEP.DEP_COMAR,
DEP.DEP_DENOMINACAO_COMPLETA, '' AS DEP_IE, '' AS DEP_HORARIA_ADMINISTRATIVO, '' AS DEP_FUSO_HORARIO_BRASILIA,
-- TO_CHAR(DEP_DT_ABSORCAO_INFRAERO,'DD/MM/YYYY') AS DEP_DT_ABSORCAO_INFRAERO,
'' AS DEP_TEL_ACHADOS_PERDIDOS, '' AS DEP_TEL_BALCAO_INFORMACAO, '' AS DEP_TEL_COMUNICACAO_SOCIAL,
'' AS DEP_TEL_SECRETARIA, '' AS DEP_NOME_SECRETARIA, '' AS DEP_TEL_SUPERINTENDENTE, '' AS DEP_NOME_SUPERINTENDENTE,
'' AS DEP_FERIADOS_LOCAIS
FROM DEPENDENCIAS DEP, IFRDBA2.MUNICIPIOS M, DEPENDENCIAS DEP2
WHERE
M.MUN_CODIGO = DEP.DEP_MUN_CODIGO
AND DEP.DEP_DEP_CODIGO = DEP2.DEP_CODIGO
AND DEP.DEP_DATA_EXTINCAO IS NULL
AND (DEP.DEP_TIPO = 1 OR DEP.DEP_TIPO = 2 OR DEP.DEP_TIPO = 3 OR DEP.DEP_TIPO = 4 OR DEP.DEP_TIPO = 5
OR DEP.DEP_TIPO = 6 OR DEP.DEP_TIPO = 7)
)
/

-- Grants for View
GRANT DELETE ON ifragenda.viw_dependencias TO agenda_usu
/
GRANT INSERT ON ifragenda.viw_dependencias TO agenda_usu
/
GRANT SELECT ON ifragenda.viw_dependencias TO agenda_usu
/
GRANT UPDATE ON ifragenda.viw_dependencias TO agenda_usu
/


-- Start of DDL Script for View IFRAGENDA.VIW_ORGAOS_EXTERNOS
-- Generated 23-out-2003 9:22:40 from IFRAGENDA@HOMOLOG

CREATE OR REPLACE VIEW ifragenda.viw_orgaos_externos (
   oex_codigo,
   oex_sigla,
   oex_nome,
   oex_oex_subordinado,
   oex_endereco_logradouro,
   oex_endereco_bairro,
   oex_municipio,
   oex_ufe_sigla,
   oex_endereco_cep,
   oex_numero_telefone,
   oex_numero_fax )
AS
(
select OEX_CODIGO, OEX_SIGLA, OEX_NOME, OEX_OEX_CODIGO AS OEX_OEX_SUBORDINADO,
 OEX_ENDERECO_LOGRADOURO, OEX_ENDERECO_BAIRRO, 
M.MUN_DESCRICAO AS OEX_MUNICIPIO,
  OEX_UFE_SIGLA,
 OEX_ENDERECO_CEP, OEX_NUMERO_TELEFONE, 
 OEX_NUMERO_FAX
 FROM 
 orgaos_externos,MUNICIPIOS M
 WHERE 
 M.MUN_CODIGO(+) =ORGAOS_EXTERNOS.OEX_MUN_CODIGO
 )
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_orgaos_externos TO agenda_usu
/


CREATE OR REPLACE VIEW ifragenda.viw_terceiros (
   ter_numero_matricula,
   ter_nome,
   ter_nome_abreviado,
   ter_ddd_celular,
   ter_numero_celular,
   ter_qlp_car_codigo,
   ter_qlp_car_codigo_nivel,
   ter_qlp_car_occ_codigo,
   ter_dep_codigo_lotacao,
   ter_dep_codigo_fisico,
   ter_uor_codigo_lotacao,
   ter_status,
   ter_nome_guerra,
   ter_endereco_eletronico_mail )
AS
SELECT TER_NUMERO_MATRICULA, TER_NOME, TER_NOME_ABREVIADO, TER_DDD_CELULAR, TER_NUMERO_CELULAR, TER_QLP_CAR_CODIGO,
TER_QLP_CAR_CODIGO_NIVEL, TER_QLP_CAR_OCC_CODIGO, TER_DEP_CODIGO_LOTACAO, TER_DEP_CODIGO_FISICO,
TER_UOR_CODIGO_LOTACAO, TER_STATUS, TER_NOME_GUERRA, TER_ENDERECO_ELETRONICO_MAIL
FROM TERCEIROS
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_terceiros TO agenda_usu
/

create public synonym seq_concessionaria for ifragenda.seq_concessionaria;
create public synonym CONCESSIONARIAS for ifragenda.CONCESSIONARIAS;
create public synonym TERCEIROS for ifragenda.TERCEIROS;
create public synonym VIW_CADASTROS for ifragenda.VIW_CADASTROS;
create public synonym VIW_CARGOS for ifragenda.VIW_CARGOS;
create public synonym VIW_CONCESSIONARIAS for ifragenda.VIW_CONCESSIONARIAS;
create public synonym VIW_DADOS_SUPERINTENDENCIA for ifragenda.VIW_DADOS_SUPERINTENDENCIA;
create public synonym VIW_DEPENDENCIAS for ifragenda.VIW_DEPENDENCIAS;
create public synonym VIW_ORGAOS_EXTERNOS for ifragenda.VIW_ORGAOS_EXTERNOS;
create public synonym VIW_TERCEIROS for ifragenda.VIW_TERCEIROS;
create public synonym PK_FERIAS for ifragenda.PK_FERIAS;
create public synonym  viw_unidades_organizacionais for ifragenda.viw_unidades_organizacionais;

-- Start of DDL Script for View IFRAGENDA.VIW_UNIDADES_ORGANIZACIONAIS
-- Generated 23-out-2003 9:23:13 from IFRAGENDA@HOMOLOG

CREATE OR REPLACE VIEW ifragenda.viw_unidades_organizacionais (
   uor_codigo,
   uor_sigla,
   uor_nome,
   uor_dep_codigo,
   uor_dep_tipo_codigo,
   uor_dep_dep_codigo,
   uor_dep_tipo,
   uor_dep_nome,
   uor_data_criacao,
   uor_nome_abreviado,
   uor_tipo_unidad_org,
   uor_tipo_unidad_org_codigo,
   uor2_codigo,
   uor2_nome,
   uor2_sigla,
   uor2_tipo_unidad_org_codigo,
   uor3_codigo,
   uor3_nome,
   uor3_sigla,
   uor3_tipo_unidad_org_codigo,
   uor4_codigo,
   uor4_nome,
   uor4_sigla,
   uor4_tipo_unidad_org_codigo,
   uor_endereco_logradouro,
   uor_endereco_bairro,
   uor_endereco_municipio,
   uor_ufe_sigla,
   uor_cep,
   uor_numero_fax )
AS
( 
SELECT 
UOR.UOR_CODIGO, UOR.UOR_SIGLA, UOR.UOR_NOME, 
DEP.DEP_CODIGO AS UOR_DEP_CODIGO, DEP.DEP_TIPO AS UOR_DEP_TIPO_CODIGO, DEP.DEP_DEP_CODIGO AS UOR_DEP_DEP_CODIGO, 
DECODE(DEP.DEP_TIPO, 1,'SEDE', 2,'SUPERINTENDÊNCIA', 3,'AEROPORTO', 4,'GTA', 5,'COORDENAÇÃO DE NEGÓCIO', 6,'GNA', 
7,'UNA', 8,'CONVÊNIOS COM RESSARCIMENTO', 9,'CONVÊNIOS SEM RESSARCIMENTO', 10,'DEPENDÊNCIA GNA', 11,'DEPENDÊNCIA UNA', 
12,'DEPENDÊNCIA DE DEPENDÊNCIA', DEP.DEP_TIPO) AS UOR_DEP_TIPO, 
DEP.DEP_NOME AS UOR_DEP_NOME, 
TO_CHAR(UOR.UOR_DATA_CRIACAO,'DD/MM/YYYY') AS UOR_DATA_CRIACAO, UOR.UOR_NOME_ABREVIADO, 
DECODE(UOR.UOR_TIPO_UNIDAD_ORG,1,'PRESIDÊNCIA',2,'DIRETORIA',3,'SUPERINTENDÊNCIA',4,'GERÊNCIA',5,'COORDENAÇÃO', 
6,'ENCARREGADORIA',7,'GNA',8,'UTA',9,'CONVÊNIOS DAC',10,'CONVÊNIOS DEP',11,'CONVÊNIOS HASP',12,'CONVÊNIOS HACA', 
13,'CONVÊNIOS HFA',14,'CEDIDOS',15,'ASSESSORIA', UOR.UOR_TIPO_UNIDAD_ORG) AS UOR_TIPO_UNIDAD_ORG, 
UOR.UOR_TIPO_UNIDAD_ORG AS UOR_TIPO_UNIDAD_ORG_CODIGO, 
UOR.UOR_UOR_CODIGO AS UOR2_CODIGO, UOR2.UOR_NOME AS UOR2_NOME, 
UOR2.UOR_SIGLA AS UOR2_SIGLA, UOR2.UOR_TIPO_UNIDAD_ORG AS UOR2_TIPO_UNIDAD_ORG_CODIGO, 
UOR2.UOR_UOR_CODIGO AS UOR3_CODIGO, UOR3.UOR_NOME AS UOR3_NOME, 
UOR3.UOR_SIGLA AS UOR3_SIGLA, UOR3.UOR_TIPO_UNIDAD_ORG AS UOR3_TIPO_UNIDAD_ORG_CODIGO, 
UOR3.UOR_UOR_CODIGO AS UOR4_CODIGO, UOR4.UOR_NOME AS UOR4_NOME, 
UOR4.UOR_SIGLA AS UOR4_SIGLA, UOR4.UOR_TIPO_UNIDAD_ORG AS UOR4_TIPO_UNIDAD_ORG_CODIGO, 
UOR.UOR_ENDERECO_LOGRADOURO, UOR.UOR_ENDERECO_BAIRRO, UOR.UOR_ENDERECO_MUNICIPIO, 
UOR.UOR_UFE_SIGLA, UOR.UOR_CEP, UOR.UOR_NUMERO_FAX 
FROM UNIDADES_ORGANIZACIONAIS UOR, UNIDADES_ORGANIZACIONAIS UOR2, UNIDADES_ORGANIZACIONAIS UOR3, UNIDADES_ORGANIZACIONAIS UOR4, DEPENDENCIAS DEP 
WHERE 
UOR.UOR_DEP_CODIGO = DEP.DEP_CODIGO 
AND UOR.UOR_UOR_CODIGO = UOR2.UOR_CODIGO 
AND UOR2.UOR_UOR_CODIGO = UOR3.UOR_CODIGO 
AND UOR3.UOR_UOR_CODIGO = UOR4.UOR_CODIGO 
AND UOR.UOR_DATA_EXTINCAO IS NULL 
AND UOR.UOR_TIPO_UNIDAD_ORG <> 14 
)
/

-- Grants for View
GRANT SELECT ON ifragenda.viw_unidades_organizacionais TO agenda_usu
/

-- End of DDL Script for View IFRAGENDA.VIW_UNIDADES_ORGANIZACIONAIS

