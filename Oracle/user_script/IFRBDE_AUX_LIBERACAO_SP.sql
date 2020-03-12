DROP TABLE ifrbde.aux_liberacao_sp
/

CREATE TABLE ifrbde.aux_liberacao_sp
    (num_fatura_sp                  VARCHAR2(14) NOT NULL,
    dat_liberacao                  DATE NOT NULL,
    dat_inclusao                   DATE,
    cnt_cre_cod_aux                NUMBER(10) NOT NULL,
    cnt_cod_aux                    VARCHAR2(30) NOT NULL,
    cod_tipo_pag_rp                VARCHAR2(1) NOT NULL,
    num_ano_realizacao             VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  system
  STORAGE   (
    INITIAL     10240
    NEXT        1048576
    PCTINCREASE 0
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON ifrbde.aux_liberacao_sp TO bde_views
/
GRANT INSERT ON ifrbde.aux_liberacao_sp TO bde_views
/
GRANT SELECT ON ifrbde.aux_liberacao_sp TO bde_views
/
GRANT UPDATE ON ifrbde.aux_liberacao_sp TO bde_views
/
GRANT DELETE ON ifrbde.aux_liberacao_sp TO bde_geral
/
GRANT INSERT ON ifrbde.aux_liberacao_sp TO bde_geral
/
GRANT SELECT ON ifrbde.aux_liberacao_sp TO bde_geral
/
GRANT UPDATE ON ifrbde.aux_liberacao_sp TO bde_geral
/
GRANT ALTER ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT DELETE ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT INDEX ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT INSERT ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT SELECT ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT UPDATE ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/
GRANT REFERENCES ON ifrbde.aux_liberacao_sp TO ifrbde_views
WITH GRANT OPTION
/

-- Comments for IFRBDE.AUX_LIBERACAO_SP

COMMENT ON COLUMN ifrbde.aux_liberacao_sp.cnt_cod_aux IS 'Numero do Contrato '
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.cnt_cre_cod_aux IS 'Numero sequencial da Carencia'
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.cod_tipo_pag_rp IS 'Tipo de Pagamento ( Pagamento, Reajuste )'
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.dat_inclusao IS 'Data da inclusão da fatura no sistema'
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.dat_liberacao IS 'Data da Liberação da Fatura'
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.num_ano_realizacao IS 'Ano de realização do recurso'
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.num_fatura_sp IS 'Número da Fatura'
/

-- End of DDL Script for Table IFRBDE.AUX_LIBERACAO_SP


