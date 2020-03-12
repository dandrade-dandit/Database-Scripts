-- Start of DDL Script for Table DBA_INFRAERO.TAB_PARAMETROS
-- Generated 10-jun-2003 9:53:45 from DBA_INFRAERO@HOMOLOG

CREATE TABLE tab_parametros
    (cod_grupo                      NUMBER(4) NOT NULL,
    desc_grupo                     VARCHAR2(150) NOT NULL,
    cod_assunto                    NUMBER(4) NOT NULL,
    desc_assunto                   VARCHAR2(250) NOT NULL)
  INITRANS    2
/

-- Constraints for TAB_PARAMETROS

ALTER TABLE tab_parametros
ADD CONSTRAINT pk_tab_parametro PRIMARY KEY (cod_grupo, cod_assunto)
USING INDEX TABLESPACE TSI_PESSOAL
  INITRANS    2
/

-- Comments for TAB_PARAMETROS

COMMENT ON COLUMN tab_parametros.cod_assunto IS 'Codigo de Assunto, que sera o codigo da referencia'
/
COMMENT ON COLUMN tab_parametros.cod_grupo IS 'Codigo de Grupo, que identificara o grupo dentro do qual se encontra a referencia'
/
COMMENT ON COLUMN tab_parametros.desc_assunto IS 'Descricao de Assunto, que sera a descricao da referencia'
/
COMMENT ON COLUMN tab_parametros.desc_grupo IS 'Descricao do Grupo, onde se dara o nome do grupo'
/

-- End of DDL Script for Table DBA_INFRAERO.TAB_PARAMETROS


