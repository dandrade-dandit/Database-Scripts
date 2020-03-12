CREATE TABLE ifrmaximo.tab_indisponibilidade
    (wo_wonum                       VARCHAR2(18) NOT NULL,
    wo_total                       FLOAT(126))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/




CREATE INDEX ifrmaximo.tab_indisponibilidade_ndx1 ON ifrmaximo.tab_indisponibilidade
  (
    wo_wonum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/




CREATE OR REPLACE TRIGGER ifrmaximo.trg_indisponibilidade
 BEFORE
  INSERT OR UPDATE
 ON ifrmaximo.tab_indisponibilidade
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   SELECT SUM (wo19)
     INTO :NEW.wo_total
     FROM workorder
    WHERE PARENT = :NEW.wo_wonum;

   UPDATE workorder
   SET wo19 = :NEW.wo_total
   WHERE  wonum = :NEW.wo_wonum;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (-20645,
                               'ERRO AO ATUALIZAR A WORKORDER' || SQLERRM);
END;
/



COMMENT ON COLUMN ifrmaximo.tab_indisponibilidade.wo_total IS 'total de indisponibilidade'
/
COMMENT ON COLUMN ifrmaximo.tab_indisponibilidade.wo_wonum IS 'numero da OS'
/

