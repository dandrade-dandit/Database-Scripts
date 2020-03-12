/* Formatted on 2005/05/05 16:59 (Formatter Plus v4.5.2) */
-- Start of DDL Script for Trigger IFRBDE.TRG_PRE_COMPROMISSO_03_IUD
-- Generated 2-dez-2004 20:24:34 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_pre_compromisso_03_iud
   BEFORE INSERT OR UPDATE OF num_situacao_pre_compromisso OR DELETE
   ON ifrbde.cad_pre_compromisso
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro      VARCHAR2 (200);
   v_sucesso   NUMBER (1);
BEGIN
   
--
   v_sucesso := 0;
   v_erro := '';
--
   IF INSERTING
   THEN
      IF :NEW.num_situacao_pre_compromisso <> 1
      THEN
         :NEW.num_situacao_pre_compromisso := 1;
      END IF;
   END IF;

   IF UPDATING
   THEN
      IF      :OLD.num_situacao_pre_compromisso = 1
          AND :NEW.num_situacao_pre_compromisso NOT IN (1, 2, 9)
      THEN
         v_sucesso := 1;
         v_erro :=
               'A situação do Pré-Compromisso de "Cadastrado" só pode ser alterada para "Licitando" !!!';
      END IF;

      IF      :OLD.num_situacao_pre_compromisso = 2
          AND :NEW.num_situacao_pre_compromisso NOT IN (2, 3, 5, 9)
      THEN
         v_sucesso := 1;
         v_erro :=
               'A situação do Pré-Compromisso de "Licitando" só pode ser alterada para "Contratada" ou "Cancelado" !!!';
      END IF;

      IF      :OLD.num_situacao_pre_compromisso = 3
          AND :NEW.num_situacao_pre_compromisso NOT IN (4, 9)
      THEN
         v_sucesso := 1;
         v_erro :=
               'A situação do Pré-Compromisso de "Contratada" só pode ser alterada para "Encerrado/Rescindido" !!!';
      END IF;

      IF      :OLD.num_situacao_pre_compromisso = 4
          AND :NEW.num_situacao_pre_compromisso NOT IN (9)
      THEN
         v_sucesso := 1;
         v_erro :=
               'A situação do Pré-Compromisso de "Encerrado/Rescindido" não podem modificada !!!';
      END IF;

      IF      :OLD.num_situacao_pre_compromisso = 5
          AND :NEW.num_situacao_pre_compromisso NOT IN (1,9)
      THEN
         v_sucesso := 1;
         v_erro :=
               'A situação do Pré-Compromisso de "Cancelado" não podem modificada !!!';
      END IF;
   END IF;
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_PRE_COMPROMISSO_03_IUD

