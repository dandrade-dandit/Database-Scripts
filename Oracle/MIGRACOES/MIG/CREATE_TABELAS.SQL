CREATE TABLE tabelas
    (aplicacao                      VARCHAR2(20) NOT NULL,
    tabela                         VARCHAR2(40) NOT NULL,
    owner                          VARCHAR2(30) NOT NULL,
    tipo                           VARCHAR2(15) NOT NULL
  ,
  CONSTRAINT TABELAS_PK
  PRIMARY KEY (aplicacao, tipo, tabela, owner)
  )
/
-- Grants for Table
GRANT INSERT ON tabelas TO sysman
/

ALTER TABLE tabelas
ADD CONSTRAINT chk_owner CHECK (OWNER IS NOT NULL)
ENABLE NOVALIDATE
/

COMMENT ON TABLE tabelas IS 'INDICA QUE TABELA PERTENCE A QUE APLICACAO'
/
COMMENT ON COLUMN tabelas.aplicacao IS 'NOME DO SISTEMA'
/
COMMENT ON COLUMN tabelas.owner IS 'OWNER DE CRIACAO DA TABELA'
/
COMMENT ON COLUMN tabelas.tabela IS 'NOME DA TABELA'
/
