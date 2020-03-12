

CREATE TABLE tab_remanejamento
    (rmj_cod                        NUMBER(7,0) NOT NULL,
    rmj_ano                        VARCHAR2(4) NOT NULL,
    rmj_seq_orig                   NUMBER(10,0) NOT NULL,
    rmj_seq_dest                   NUMBER(10,0) NOT NULL,
    rmj_valor                      NUMBER(12,2) NOT NULL,
    rmj_rti_cod_orig               VARCHAR2(5) NOT NULL,
    rmj_rti_cod_dest               VARCHAR2(5) NOT NULL,
    dat_remanejamento              DATE,
    rmj_usuario                    VARCHAR2(10),
    dsc_justificativa              VARCHAR2(2000),
    val_aprovacao_origem           NUMBER(18,2),
    val_aprovacao_destino          NUMBER(18,2))
/

-- Grants for Table
GRANT DELETE ON tab_remanejamento TO ifrbde_views
WITH GRANT OPTION
/
GRANT INSERT ON tab_remanejamento TO ifrbde_views
WITH GRANT OPTION
/
GRANT SELECT ON tab_remanejamento TO ifrbde_views
WITH GRANT OPTION
/
GRANT UPDATE ON tab_remanejamento TO ifrbde_views
WITH GRANT OPTION
/
GRANT REFERENCES ON tab_remanejamento TO ifrbde_views
WITH GRANT OPTION
/
GRANT DELETE ON tab_remanejamento TO bde_geral
/
GRANT INSERT ON tab_remanejamento TO bde_geral
/
GRANT SELECT ON tab_remanejamento TO bde_geral
/
GRANT UPDATE ON tab_remanejamento TO bde_geral
/



-- Indexes for TAB_REMANEJAMENTO

CREATE INDEX tab_remanejamento_01_ix ON tab_remanejamento
  (
    rmj_ano                         ASC,
    rmj_seq_orig                    ASC,
    rmj_seq_dest                    ASC
  )
  TABLESPACE  tsi_maximo
/



-- Constraints for TAB_REMANEJAMENTO





ALTER TABLE tab_remanejamento
ADD CONSTRAINT tab_remanejamento_pk PRIMARY KEY (rmj_cod)
USING INDEX
  TABLESPACE  tsi_maximo
/
-- Comments for TAB_REMANEJAMENTO

COMMENT ON COLUMN tab_remanejamento.dat_remanejamento IS 'Data que foi Executado o Remanejamento'
/
COMMENT ON COLUMN tab_remanejamento.dsc_justificativa IS 'Justificativa do remanejamento'
/
COMMENT ON COLUMN tab_remanejamento.rmj_ano IS 'Ano do Remanjeamento'
/
COMMENT ON COLUMN tab_remanejamento.rmj_cod IS 'identificador do Remanejamento - Codigo'
/
COMMENT ON COLUMN tab_remanejamento.rmj_rti_cod_dest IS 'RELACIONAMENTO COM A TABELA TAB_TIPO_RECURSO_ITEM'
/
COMMENT ON COLUMN tab_remanejamento.rmj_rti_cod_orig IS 'RELACIONAMENTO COM A TABELA TAB_TIPO_RECURSO'
/
COMMENT ON COLUMN tab_remanejamento.rmj_seq_dest IS 'RELACIONAMENTO COM A TABELA TAB_CARENCIA'
/
COMMENT ON COLUMN tab_remanejamento.rmj_seq_orig IS 'RELACIONAMENTO COM A TABELA TAB_CARENCIA'
/
COMMENT ON COLUMN tab_remanejamento.rmj_usuario IS 'Nome do Usuário que Executou o Remanejamento'
/
COMMENT ON COLUMN tab_remanejamento.rmj_valor IS 'Valor do Remanejamento'
/
COMMENT ON COLUMN tab_remanejamento.val_aprovacao_destino IS 'Valor Aprovado Inicial de Destino'
/
COMMENT ON COLUMN tab_remanejamento.val_aprovacao_origem IS 'Valor Aprovado Inicial de Origem'
/

-- End of DDL Script for Table IFRBDE.TAB_REMANEJAMENTO

-- Foreign Key
ALTER TABLE tab_remanejamento
ADD CONSTRAINT tab_remanejamento_01_fk FOREIGN KEY (rmj_seq_dest)
REFERENCES tab_carencia (cre_cod) ON DELETE SET NULL
/
ALTER TABLE tab_remanejamento
ADD CONSTRAINT tab_remanejamento_02_fk FOREIGN KEY (rmj_seq_orig)
REFERENCES tab_carencia (cre_cod) ON DELETE SET NULL
/
ALTER TABLE tab_remanejamento
ADD CONSTRAINT tab_remanejamento_03_fk FOREIGN KEY (rmj_rti_cod_dest)
REFERENCES tab_tipo_recurso_item (rti_cod) ON DELETE SET NULL
/
ALTER TABLE tab_remanejamento
ADD CONSTRAINT tab_remanejamento_04_fk FOREIGN KEY (rmj_rti_cod_orig)
REFERENCES tab_tipo_recurso_item (rti_cod) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)
