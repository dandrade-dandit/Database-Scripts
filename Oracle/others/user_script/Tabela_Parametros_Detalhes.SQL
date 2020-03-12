-- Start of DDL Script for Table DBA_INFRAERO.TAB_PARAMETROS_DETALHES
-- Generated 10-jun-2003 9:55:20 from DBA_INFRAERO@HOMOLOG

CREATE TABLE tab_parametros_detalhes
    (valor                          VARCHAR2(255) NOT NULL,
    data_inicio                    DATE NOT NULL,
    cod_grupo                      NUMBER(4),
    cod_assunto                    NUMBER(4),
    data_termino                   DATE)
  INITRANS    2
/

-- Indexes for TAB_PARAMETROS_DETALHES

CREATE INDEX relationship_1_fk ON tab_parametros_detalhes
  (
    cod_grupo                       ASC,
    cod_assunto                     ASC
  )
  INITRANS    2
/


-- Constraints for TAB_PARAMETROS_DETALHES

ALTER TABLE tab_parametros_detalhes
ADD CONSTRAINT pk_tab_parametro_detalhe PRIMARY KEY (data_inicio)
USING INDEX TABLESPACE TSI_PESSOAL
  INITRANS    2
/

-- Comments for TAB_PARAMETROS_DETALHES

COMMENT ON COLUMN tab_parametros_detalhes.cod_assunto IS 'Codigo de Assunto, que sera o codigo da referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.cod_grupo IS 'Codigo de Grupo, que identificara o grupo dentro do qual se encontra a referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.data_inicio IS 'Valor, que teria a referencia que estamos precisando '
/
COMMENT ON COLUMN tab_parametros_detalhes.data_termino IS 'Data de Termino do valor da referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.valor IS 'Valor, que teria a referencia que estamos precisando '
/

-- End of DDL Script for Table DBA_INFRAERO.TAB_PARAMETROS_DETALHES

-- Foreign Key
ALTER TABLE tab_parametros_detalhes
ADD CONSTRAINT fk_tab_para_relations_tab_para FOREIGN KEY (cod_grupo, 
  cod_assunto)
REFERENCES tab_parametros (cod_grupo,cod_assunto) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)
