CREATE TABLE USUARIOS_PLANOS_SAUDE (
	UPS_CRE_SEQUENCIAL   		NUMBER(5)
,	UPS_EMP_NUMERO_MATRICULA   	NUMBER(7)
,	UPS_COD_USUARIO       		NUMBER(8)
,	UPS_DATA_INICIO      		DATE
,	UPS_DATA_TERMINO   		DATE
)
/

COMMENT ON COLUMN USUARIOS_PLANOS_SAUDE.UPS_CRE_SEQUENCIAL IS 'C�DIGO IDENTIFICADOR DO CREDENCIADOS CHAVE TABELA CREDENCIADOS'
/

COMMENT ON COLUMN USUARIOS_PLANOS_SAUDE.UPS_EMP_NUMERO_MATRICULA IS 'MATR�CULA ATRIBU�DA AO EMPREGADO CHAVE TABELA CADASTROS'
/

COMMENT ON COLUMN USUARIOS_PLANOS_SAUDE.UPS_COD_USUARIO IS 'C�DIGO IDENTIFICADOR DO USU�RIO TITULAR DO PLANO DE SA�DE COMP�E CHAVE TABELA'
/

COMMENT ON COLUMN USUARIOS_PLANOS_SAUDE.UPS_DATA_INICIO IS 'DATA DA CRIA��O DO REGISTRO. IN�CIO DO BENEF�CIO UTILIZA��O DO PLANO DE SA�DE'
/

COMMENT ON COLUMN USUARIOS_PLANOS_SAUDE.UPS_DATA_TERMINO IS 'DATA T�RMINO DO BENEF�CIO UTILIZA��O DO PLANO DE SA�DE'
/

ALTER TABLE USUARIOS_PLANOS_SAUDE
ADD CONSTRAINT UPS_PK PRIMARY KEY (UPS_CRE_SEQUENCIAL,UPS_EMP_NUMERO_MATRICULA,UPS_COD_USUARIO)
USING INDEX
TABLESPACE TS_INDICE
/ 

ALTER TABLE USUARIOS_PLANOS_SAUDE
ADD CONSTRAINT UPS_CRE_FK FOREIGN KEY (UPS_CRE_SEQUENCIAL)
      REFERENCES CREDENCIADOS (CRE_SEQUENCIAL)
/

ALTER TABLE USUARIOS_PLANOS_SAUDE
ADD CONSTRAINT UPS_EMP_FK FOREIGN KEY (UPS_EMP_NUMERO_MATRICULA)
      REFERENCES CADASTROS (EMP_NUMERO_MATRICULA)
/

--**************************************************************************************************************************

CREATE TABLE DEPENDENTES_USU_PLANO_SAUDE (
	DUS_CRE_SEQUENCIAL   		NUMBER(5)
,	DUS_EMP_NUMERO_MATRICULA 	NUMBER(7) 
,	DUS_UPS_COD_USUARIO   		NUMBER(6)
,	DUS_COD_DEPENDENTE   		NUMBER(8) 
,	DUS_PVI_SEQUENCIAL     		NUMBER(2)
,	DUS_DATA_INICIO     		DATE
,	DUS_DATA_TERMINO   		DATE
)
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_CRE_SEQUENCIAL IS 'C�DIGO IDENTIFICADOR DO CREDENCIADOS CHAVE TABELA CREDENCIADOS'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_EMP_NUMERO_MATRICULA IS 'MATR�CULA ATRIBU�DA AO EMPREGADO CHAVE TABELA CADASTROS'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_UPS_COD_USUARIO IS 'C�DIGO IDENTIFICADOR DO USU�RIO TITULAR DO PLANO DE SA�DE CHAVE TABELA USUARIOS_PLANOS_SAUDE'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_COD_DEPENDENTE IS 'C�DIGO IDENTIFICADOR DO DEPENDENTE USU�RIO DO PLANO DE SA�DE CHAVE TABELA USUARIOS_PLANOS_SAUDE'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_PVI_SEQUENCIAL IS 'C�DIGO IDENTIFICADOR DO TIPO DE V�NCULO DO DEPENDENTE CHAVE TABELA PESSOAS_VINCULADAS'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_DATA_INICIO IS 'DATA DA CRIA��O DO REGISTRO. IN�CIO DO BENEF�CIO UTILIZA��O DO PLANO DE SA�DE'
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_DATA_TERMINO IS 'DATA T�RMINO DO BENEF�CIO UTILIZA��O DO PLANO DE SA�DE'
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_PK PRIMARY KEY (DUS_CRE_SEQUENCIAL,DUS_EMP_NUMERO_MATRICULA,DUS_UPS_COD_USUARIO,DUS_COD_DEPENDENTE)
USING INDEX
TABLESPACE TS_INDICE
/ 

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_CRE_FK FOREIGN KEY (DUS_CRE_SEQUENCIAL)
      REFERENCES CREDENCIADOS (CRE_SEQUENCIAL)
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_EMP_FK FOREIGN KEY (DUS_EMP_NUMERO_MATRICULA)
      REFERENCES CADASTROS (EMP_NUMERO_MATRICULA)
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_UPS_FK FOREIGN KEY (DUS_CRE_SEQUENCIAL,DUS_EMP_NUMERO_MATRICULA,DUS_UPS_COD_USUARIO)
      REFERENCES USUARIOS_PLANOS_SAUDE (UPS_CRE_SEQUENCIAL,UPS_EMP_NUMERO_MATRICULA,UPS_COD_USUARIO)
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_PVI_FK FOREIGN KEY (DUS_EMP_NUMERO_MATRICULA,DUS_PVI_SEQUENCIAL)
      REFERENCES PESSOAS_VINCULADAS (PVI_EMP_NUMERO_MATRICULA,PVI_SEQUENCIAL)
/

CREATE PUBLIC SYNONYM USUARIOS_PLANOS_SAUDE FOR IFRSRH.USUARIOS_PLANOS_SAUDE
/

CREATE PUBLIC SYNONYM DEPENDENTES_USU_PLANO_SAUDE FOR IFRSRH.DEPENDENTES_USU_PLANO_SAUDE
/

INSERT INTO TABELAS VALUES ('SRHCAD', 'USUARIOS_PLANOS_SAUDE', 'IFRSRH', 'TABELA')
/

INSERT INTO TABELAS VALUES ('SRHCAD', 'DEPENDENTES_USU_PLANO_SAUDE', 'IFRSRH', 'TABELA')
/

--**************************************************************************************************************************
--ALTERA��ES DIA 10/09/2002
--**************************************************************************************************************************
ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
DROP CONSTRAINT DUS_UPS_FK
/

ALTER TABLE USUARIOS_PLANOS_SAUDE
DROP CONSTRAINT UPS_PK
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
DROP CONSTRAINT DUS_PK
/

ALTER TABLE USUARIOS_PLANOS_SAUDE
ADD CONSTRAINT UPS_PK PRIMARY KEY (UPS_CRE_SEQUENCIAL,UPS_EMP_NUMERO_MATRICULA,UPS_COD_USUARIO,UPS_DATA_INICIO )
USING INDEX
TABLESPACE TS_INDICE
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD DUS_UPS_DATA_INICIO     DATE
/

COMMENT ON COLUMN DEPENDENTES_USU_PLANO_SAUDE.DUS_UPS_DATA_INICIO IS 'DATA DA CRIA��O DO REGISTRO. IN�CIO DO BENEF�CIO UTILIZA��O DO PLANO DE SA�DE'
/

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_PK PRIMARY KEY (DUS_CRE_SEQUENCIAL,DUS_EMP_NUMERO_MATRICULA,DUS_UPS_COD_USUARIO,DUS_UPS_DATA_INICIO,DUS_COD_DEPENDENTE,DUS_DATA_INICIO)
USING INDEX
TABLESPACE TS_INDICE
/ 

ALTER TABLE DEPENDENTES_USU_PLANO_SAUDE
ADD CONSTRAINT DUS_UPS_FK FOREIGN KEY (DUS_CRE_SEQUENCIAL,DUS_EMP_NUMERO_MATRICULA,DUS_UPS_COD_USUARIO,DUS_UPS_DATA_INICIO)
      REFERENCES USUARIOS_PLANOS_SAUDE (UPS_CRE_SEQUENCIAL,UPS_EMP_NUMERO_MATRICULA,UPS_COD_USUARIO,UPS_DATA_INICIO)
/
