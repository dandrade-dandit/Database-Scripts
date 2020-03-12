-- Start of DDL Script for Table IFRSICOF.CATALOGO_CONTA
-- Generated 11-ago-2005 14:19:33 from IFRSICOF@homolog

CREATE TABLE ifrsicof.catalogo_conta
    (cod_catalogo                   VARCHAR2(7) NOT NULL,
    num_conta_contabil             VARCHAR2(20) NOT NULL)
/

-- Create synonym CATALOGO_CONTA
CREATE PUBLIC SYNONYM catalogo_conta
  FOR ifrsicof.catalogo_conta
/




-- Constraints for IFRSICOF.CATALOGO_CONTA

ALTER TABLE ifrsicof.catalogo_conta
ADD CONSTRAINT cat_cont_pk PRIMARY KEY (cod_catalogo, num_conta_contabil)
USING INDEX
/




-- Comments for IFRSICOF.CATALOGO_CONTA

COMMENT ON TABLE ifrsicof.catalogo_conta IS 'Classificação Patrimonial Versus Conta Contábil'
/

-- End of DDL Script for Table IFRSICOF.CATALOGO_CONTA

-- Start of DDL Script for Table IFRSICOF.CATALOGO_PATRIMONIAL
-- Generated 11-ago-2005 14:19:36 from IFRSICOF@homolog

CREATE TABLE ifrsicof.catalogo_patrimonial
    (cod_catalogo                   VARCHAR2(7) NOT NULL,
    dsc_catalogo                   VARCHAR2(70) NOT NULL)
/

-- Create synonym CATALOGO_PATRIMONIAL
CREATE PUBLIC SYNONYM catalogo_patrimonial
  FOR ifrsicof.catalogo_patrimonial
/




-- Constraints for IFRSICOF.CATALOGO_PATRIMONIAL

ALTER TABLE ifrsicof.catalogo_patrimonial
ADD CONSTRAINT cat_pat_pk PRIMARY KEY (cod_catalogo)
USING INDEX
/


-- End of DDL Script for Table IFRSICOF.CATALOGO_PATRIMONIAL

-- Foreign Key
ALTER TABLE ifrsicof.catalogo_conta
ADD CONSTRAINT cat_cont_cat_pat_fk FOREIGN KEY (cod_catalogo)
REFERENCES IFRSICOF.catalogo_patrimonial (cod_catalogo)
/
ALTER TABLE ifrsicof.catalogo_conta
ADD CONSTRAINT cat_cont_cont_contabil_fk FOREIGN KEY (num_conta_contabil)
REFERENCES ifrdba2.conta_contabil (nr_conta)
/
-- End of DDL script for Foreign Key(s)


GRANT DELETE ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_GERAL;
GRANT INSERT ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_GERAL;
GRANT SELECT ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_ORC;
GRANT SELECT ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_GERAL;
GRANT SELECT ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_USR;
GRANT UPDATE ON IFRSICOF.CATALOGO_CONTA TO ORC_GER_GERAL;

GRANT DELETE ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_GERAL;
GRANT INSERT ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_GERAL;
GRANT SELECT ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_ORC;
GRANT SELECT ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_GERAL;
GRANT SELECT ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_USR;
GRANT UPDATE ON IFRSICOF.CATALOGO_PATRIMONIAL TO ORC_GER_GERAL;
