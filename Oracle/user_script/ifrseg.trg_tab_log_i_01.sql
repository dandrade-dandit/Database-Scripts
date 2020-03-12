/* Formatted on 18/02/2005 16:27 (Formatter Plus v4.8.0) */
CREATE OR REPLACE TRIGGER ifrseg.trg_tab_log_i_01
   BEFORE INSERT
   ON ifrseg.tab_log
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   SELECT ifrseg.seq_tab_log.NEXTVAL
     INTO :NEW.num_seq_log
     FROM DUAL;
END;
/

