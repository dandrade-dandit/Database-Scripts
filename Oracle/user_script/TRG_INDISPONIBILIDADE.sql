CREATE OR REPLACE TRIGGER ifrmaximo.trg_linha_indisponibilidade
 BEFORE
  INSERT OR UPDATE
 ON ifrmaximo.workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.wo31 IS NULL OR :NEW.wo30 IS NULL
   THEN
      :NEW.wo19 := :NEW.wo19;
   ELSE
      :NEW.wo19 := ((:NEW.wo31 - :NEW.wo30) * 24);
   END IF;
END;
/

