ALTER TABLE ifrsicof.estrutura_visao_orcamento_loa
ADD ano_evl number(4)
/

-- Comments for ESTRUTURA_VISAO_ORCAMENTO_LOA

COMMENT ON COLUMN ifrsicof.estrutura_visao_orcamento_loa.ano_evl IS 'ANO DA VISAO ORÇAMENTO LOA'
/

UPDATE ifrsicof.estrutura_visao_orcamento_loa
SET ano_evl = 2009
/

COMMIT;

ALTER TABLE ifrsicof.estrutura_visao_orcamento_loa
drop CONSTRAINT evl_uk_1
/

drop index  ifrsicof.evl_uk_1
/


ALTER TABLE ifrsicof.estrutura_visao_orcamento_loa
ADD CONSTRAINT evl_uk_1 UNIQUE (cod_evl, cod_evl_1, cod_evl_2,ano_evl)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_sipro
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

ALTER TABLE ifrsicof.estrutura_visao_orcamento_loa
drop CONSTRAINT evl_uk_2
/

drop index  ifrsicof.evl_uk_2
/


ALTER TABLE ifrsicof.estrutura_visao_orcamento_loa
ADD CONSTRAINT evl_uk_2 UNIQUE (dsc_evl,ano_evl)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_sipro
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/




