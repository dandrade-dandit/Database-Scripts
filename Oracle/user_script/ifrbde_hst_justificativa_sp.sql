CREATE TABLE ifrbde.hst_justificativa_sp
    (num_seq_justificativa               NUMBER(15) NOT NULL,
    num_seq_resumo_pag           NUMBER(15) NOT NULL,
    dat_inclusao                 date not null,
    ds_justificativa           varchar2(2000) not null,
    dat_processamento            date )
/
-- Grants for Table
GRANT DELETE ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT INSERT ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT SELECT ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT UPDATE ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT DELETE ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT INSERT ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT SELECT ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT UPDATE ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT DELETE ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT INSERT ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT SELECT ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT UPDATE ON ifrbde.hst_justificativa_sp TO bde_views
/
GRANT DELETE ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT INSERT ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT SELECT ON ifrbde.hst_justificativa_sp TO bde_geral
/
GRANT UPDATE ON ifrbde.hst_justificativa_sp TO bde_geral
/

-- Comments for IFRBDE.hst_justificativa_sp

COMMENT ON COLUMN ifrbde.hst_justificativa_sp.num_seq_justificativa IS 'Número sequencial da Justificativa.'
/
COMMENT ON COLUMN ifrbde.hst_justificativa_sp.num_seq_resumo_pag IS 'Número sequencial da Resumo pagamento.'
/
COMMENT ON COLUMN ifrbde.hst_justificativa_sp.dat_inclusao IS 'Data de inclusão no sistema.'
/
COMMENT ON COLUMN ifrbde.hst_justificativa_sp.ds_justificativa IS 'Descrição da justificativa.'
/
COMMENT ON COLUMN ifrbde.hst_justificativa_sp.dat_processamento IS 'Data do Processamento'
/
ALTER TABLE ifrbde.hst_justificativa_sp
ADD CONSTRAINT hst_justificativa_sp_pk PRIMARY KEY (num_seq_justificativa)
/
