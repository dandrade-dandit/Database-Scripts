-- Start of DDL Script for Table IFRBDE.AUX_USUARIO_CARENCIA
-- Generated 4-abr-2005 10:05:45 from IFRBDE@homolog2

-- Drop the old instance of AUX_USUARIO_CARENCIA
CREATE TABLE aux_usuario_carencia
    (nom_username                   VARCHAR2(10),
    seq_carencia                   NUMBER(10,0),
    tip_operacao                   VARCHAR2(1))
/

-- Grants for Table
GRANT DELETE ON aux_usuario_carencia TO bde_geral
/
GRANT INSERT ON aux_usuario_carencia TO bde_geral
/
GRANT SELECT ON aux_usuario_carencia TO bde_geral
/
GRANT UPDATE ON aux_usuario_carencia TO bde_geral
/



-- Constraints for AUX_USUARIO_CARENCIA

ALTER TABLE aux_usuario_carencia
ADD CONSTRAINT usc_tip_operacao_ck CHECK (TIP_OPERACAO in ('R','P'))
/


-- Comments for AUX_USUARIO_CARENCIA

COMMENT ON TABLE aux_usuario_carencia IS 'TABELA AUXILIAR PARA ROTINAS DE TRATAMENTO DE REMANEJAMENTO E PRE-COMPROMISSO'
/
COMMENT ON COLUMN aux_usuario_carencia.nom_username IS 'NOME DO USUARIO ATIVO'
/
COMMENT ON COLUMN aux_usuario_carencia.seq_carencia IS 'SEQUENCIAL DA CARENCIA'
/
COMMENT ON COLUMN aux_usuario_carencia.tip_operacao IS 'TIPO DA OPERACAO [R]EMANEJAMENTO OU [P]RE-COMPROMISSO'
/

-- End of DDL Script for Table IFRBDE.AUX_USUARIO_CARENCIA

