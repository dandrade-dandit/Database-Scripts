ALTER TABLE ifrbioper.aeroportosenergias_secundarias
DROP CONSTRAINT arp_ensec_arp_fk
/

ALTER TABLE ifrbioper.aeroportosenergias_secundarias
DROP CONSTRAINT arp_ensec_ensec_fk 
/

ALTER TABLE ifrbioper.energias_secundarias
DROP CONSTRAINT ensec_tpensec_fk 
/

--************************************************************************************************
--************************************************************************************************

DROP TABLE ifrbioper.energias_secundarias
/

CREATE TABLE ifrbioper.energias_secundarias
    (arp_arp_codigo                NUMBER(4),
    tpensec_tp_energ_sec_cod       NUMBER(4),
    energ_sec_tp_comut             VARCHAR2(3),
    energ_sec_inst_ilum            VARCHAR2(30))
  TABLESPACE  ts_bioper
/


-- Constraints for IFRBIOPER.ENERGIAS_SECUNDARIAS

ALTER TABLE ifrbioper.energias_secundarias
ADD CONSTRAINT ensec_pk PRIMARY KEY (arp_arp_codigo, tpensec_tp_energ_sec_cod)
USING INDEX
  TABLESPACE  ts_bioper
/

-- Comments for IFRBIOPER.ENERGIAS_SECUNDARIAS

COMMENT ON COLUMN ifrbioper.energias_secundarias.energ_sec_inst_ilum IS 'INSTALAÇÕES ILUMINADAS'
/
COMMENT ON COLUMN ifrbioper.energias_secundarias.energ_sec_tp_comut IS 'TEMPO DE COMUTAÇÃO'
/
COMMENT ON COLUMN ifrbioper.energias_secundarias.tpensec_tp_energ_sec_cod IS 'CÓDIGO DA ENERGIA SECUNDÁRIA'
/

-- End of DDL Script for Table IFRBIOPER.ENERGIAS_SECUNDARIAS

-- Foreign Key
ALTER TABLE ifrbioper.energias_secundarias
ADD CONSTRAINT ensec_tpensec_fk FOREIGN KEY (tpensec_tp_energ_sec_cod)
REFERENCES IFRBIOPER.tipos_energia_secundaria (tp_energ_sec_cod) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)

--************************************************************************************************
--************************************************************************************************

-- Start of DDL Script for Table IFRBIOPER.AEROPORTOSENERGIAS_SECUNDARIAS
-- Generated 6-jan-2003 15:22:58 from SYSMAN@HOMOLOG

-- Drop the old instance of AEROPORTOSENERGIAS_SECUNDARIAS
DROP TABLE ifrbioper.aeroportosenergias_secundarias
/

CREATE TABLE ifrbioper.aeroportosenergias_secundarias
    (arp_arp_codigo                 NUMBER(4) NOT NULL,
    ensec_tpensec_tp_energ_sec_cod NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  ts_bioper
  STORAGE   (
    INITIAL     10240
    NEXT        10240
    PCTINCREASE 50
    MINEXTENTS  1
    MAXEXTENTS  121
  )
/


-- Indexes for IFRBIOPER.AEROPORTOSENERGIAS_SECUNDARIAS

CREATE INDEX ifrbioper.arp_ensec_ensec_fk_i ON ifrbioper.aeroportosenergias_secundarias
  (
    ensec_tpensec_tp_energ_sec_cod  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  ts_bioper
  STORAGE   (
    INITIAL     10240
    NEXT        10240
    PCTINCREASE 50
    MINEXTENTS  1
    MAXEXTENTS  121
  )
/
CREATE INDEX ifrbioper.arp_ensec_arp_fk_i ON ifrbioper.aeroportosenergias_secundarias
  (
    arp_arp_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  ts_bioper
  STORAGE   (
    INITIAL     10240
    NEXT        10240
    PCTINCREASE 50
    MINEXTENTS  1
    MAXEXTENTS  121
  )
/


-- Constraints for IFRBIOPER.AEROPORTOSENERGIAS_SECUNDARIAS

ALTER TABLE ifrbioper.aeroportosenergias_secundarias
ADD CONSTRAINT arp_ensec_pk PRIMARY KEY (arp_arp_codigo, 
  ensec_tpensec_tp_energ_sec_cod)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  ts_bioper
  STORAGE   (
    INITIAL     10240
    NEXT        10240
    PCTINCREASE 50
    MINEXTENTS  1
    MAXEXTENTS  121
  )
/

-- Comments for IFRBIOPER.AEROPORTOSENERGIAS_SECUNDARIAS

COMMENT ON COLUMN ifrbioper.aeroportosenergias_secundarias.arp_arp_codigo IS 'SIGLA DO AEROPORTO'
/
COMMENT ON COLUMN ifrbioper.aeroportosenergias_secundarias.ensec_tpensec_tp_energ_sec_cod IS 'CÓDIGO DA ENERGIA SECUNDÁRIA'
/

-- End of DDL Script for Table IFRBIOPER.AEROPORTOSENERGIAS_SECUNDARIAS

-- Foreign Key
ALTER TABLE ifrbioper.aeroportosenergias_secundarias
ADD CONSTRAINT arp_ensec_arp_fk FOREIGN KEY (arp_arp_codigo)
REFERENCES IFRBIOPER.aeroportos (arp_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrbioper.aeroportosenergias_secundarias
ADD CONSTRAINT arp_ensec_ensec_fk FOREIGN KEY (ensec_tpensec_tp_energ_sec_cod)
REFERENCES IFRBIOPER.energias_secundarias (tpensec_tp_energ_sec_cod) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)