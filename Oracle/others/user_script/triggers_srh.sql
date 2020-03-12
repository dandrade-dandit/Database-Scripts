-- Start of DDL Script for Trigger DBA_INFRAERO.TRG_AML_LOG
-- Generated 27-fev-2003 16:01:55 from SYSMAN@HOMOLOG

CREATE OR REPLACE TRIGGER trg_aml_log
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON amb_local
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   wk_Operacao char(1);
   wk log_AMB_LOCAL%rowtype;
BEGIN
   if    inserting then
         wk_operacao := 'I';
         wk.AML_CODIGO := :new.AML_CODIGO;
         wk.AML_DV := :new.AML_DV;
         wk.AML_DESCRICAO := :new.AML_DESCRICAO;
         wk.AML_COEFICIENTE := :new.AML_COEFICIENTE;
         wk.AML_PORTE_ANESTESICO := :new.AML_PORTE_ANESTESICO;
         wk.AML_AUXILIAR := :new.AML_AUXILIAR;
         wk.AML_FILME := :new.AML_FILME;
         wk.AML_CRE_SEQUENCIAL := :new.AML_CRE_SEQUENCIAL;
   elsif deleting then
         wk_operacao := 'E';
         wk.AML_CODIGO := :old.AML_CODIGO;
         wk.AML_DV := :old.AML_DV;
         wk.AML_DESCRICAO := :old.AML_DESCRICAO;
         wk.AML_COEFICIENTE := :old.AML_COEFICIENTE;
         wk.AML_PORTE_ANESTESICO := :old.AML_PORTE_ANESTESICO;
         wk.AML_AUXILIAR := :old.AML_AUXILIAR;
         wk.AML_FILME := :old.AML_FILME;
         wk.AML_CRE_SEQUENCIAL := :old.AML_CRE_SEQUENCIAL;
   elsif updating then
         wk_operacao := 'A';
         wk.AML_CODIGO := :new.AML_CODIGO;
         wk.AML_DV := :new.AML_DV;
         if :old.AML_DESCRICAO <> :new.AML_DESCRICAO then
             wk.AML_DESCRICAO := :new.AML_DESCRICAO;
         end if;
         if :old.AML_COEFICIENTE <> :new.AML_COEFICIENTE then
            wk.AML_COEFICIENTE := :new.AML_COEFICIENTE;
         end if;
         if :old.AML_PORTE_ANESTESICO <> :new.AML_PORTE_ANESTESICO then
            wk.AML_PORTE_ANESTESICO := :new.AML_PORTE_ANESTESICO;
         end if;
         if :old.AML_AUXILIAR <> :new.AML_AUXILIAR then
            wk.AML_AUXILIAR := :new.AML_AUXILIAR;
         end if;
         if :old.AML_FILME <> :new.AML_FILME then
             wk.AML_FILME := :new.AML_FILME;
         end if;
         if :old.AML_CRE_SEQUENCIAL <> :new.AML_CRE_SEQUENCIAL then
            wk.AML_CRE_SEQUENCIAL := :new.AML_CRE_SEQUENCIAL;
         end if;
   end if;
   insert into LOG_AMB_LOCAL
      (
       cod_usuario,
       dta_operacao,
       tip_operacao,
       AML_CODIGO,
       AML_DV,
       AML_DESCRICAO,
       AML_COEFICIENTE,
       AML_PORTE_ANESTESICO,
       AML_AUXILIAR,
       AML_FILME,
       AML_CRE_SEQUENCIAL
      )
     values
      (
       user,
       sysdate,
       wk_operacao,
       wk.AML_CODIGO,
       wk.AML_DV,
       wk.AML_DESCRICAO,
       wk.AML_COEFICIENTE,
       wk.AML_PORTE_ANESTESICO,
       wk.AML_AUXILIAR,
       wk.AML_FILME,
       wk.AML_CRE_SEQUENCIAL
      );
 END;
/

-- End of DDL Script for Trigger DBA_INFRAERO.TRG_AML_LOG



-- Start of DDL Script for Trigger DBA_INFRAERO.TRG_LPL_LOG
-- Generated 27-fev-2003 16:02:29 from SYSMAN@HOMOLOG

CREATE OR REPLACE TRIGGER trg_lpl_log
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON lpm_local
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   wk_Operacao char(1);
   wk log_LPM_LOCAL%rowtype;
BEGIN
   if    inserting then
         wk_operacao := 'I';
         wk.LPL_CODIGO := :new.LPL_CODIGO;
         wk.LPL_DV := :new.LPL_DV;
         wk.LPL_DESCRICAO := :new.LPL_DESCRICAO;
         wk.LPL_COEFICIENTE := :new.LPL_COEFICIENTE;
         wk.LPL_PORTE_ANESTESICO := :new.LPL_PORTE_ANESTESICO;
         wk.LPL_AUXILIAR := :new.LPL_AUXILIAR;
         wk.LPL_FILME := :new.LPL_FILME;
         wk.LPL_CRE_SEQUENCIAL := :new.LPL_CRE_SEQUENCIAL;
   elsif deleting then
         wk_operacao := 'E';
         wk.LPL_CODIGO := :old.LPL_CODIGO;
         wk.LPL_DV := :old.LPL_DV;
         wk.LPL_DESCRICAO := :old.LPL_DESCRICAO;
         wk.LPL_COEFICIENTE := :old.LPL_COEFICIENTE;
         wk.LPL_PORTE_ANESTESICO := :old.LPL_PORTE_ANESTESICO;
         wk.LPL_AUXILIAR := :old.LPL_AUXILIAR;
         wk.LPL_FILME := :old.LPL_FILME;
         wk.LPL_CRE_SEQUENCIAL := :old.LPL_CRE_SEQUENCIAL;
   elsif updating then
         wk_operacao := 'A';
         wk.LPL_CODIGO := :new.LPL_CODIGO;
         wk.LPL_DV := :new.LPL_DV;
         if :old.LPL_DESCRICAO <> :new.LPL_DESCRICAO then
             wk.LPL_DESCRICAO := :new.LPL_DESCRICAO;
         end if;
         if :old.LPL_COEFICIENTE <> :new.LPL_COEFICIENTE then
            wk.LPL_COEFICIENTE := :new.LPL_COEFICIENTE;
         end if;
         if :old.LPL_PORTE_ANESTESICO <> :new.LPL_PORTE_ANESTESICO then
            wk.LPL_PORTE_ANESTESICO := :new.LPL_PORTE_ANESTESICO;
         end if;
         if :old.LPL_AUXILIAR <> :new.LPL_AUXILIAR then
            wk.LPL_AUXILIAR := :new.LPL_AUXILIAR;
         end if;
         if :old.LPL_FILME <> :new.LPL_FILME then
             wk.LPL_FILME := :new.LPL_FILME;
         end if;
         if :old.LPL_CRE_SEQUENCIAL <> :new.LPL_CRE_SEQUENCIAL then
            wk.LPL_CRE_SEQUENCIAL := :new.LPL_CRE_SEQUENCIAL;
         end if;
   end if;
   insert into LOG_LPM_LOCAL
      (
       cod_usuario,
       dta_operacao,
       tip_operacao,
       LPL_CODIGO,
       LPL_DV,
       LPL_DESCRICAO,
       LPL_COEFICIENTE,
       LPL_PORTE_ANESTESICO,
       LPL_AUXILIAR,
       LPL_FILME,
       LPL_CRE_SEQUENCIAL
      )
     values
      (
       user,
       sysdate,
       wk_operacao,
       wk.LPL_CODIGO,
       wk.LPL_DV,
       wk.LPL_DESCRICAO,
       wk.LPL_COEFICIENTE,
       wk.LPL_PORTE_ANESTESICO,
       wk.LPL_AUXILIAR,
       wk.LPL_FILME,
       wk.LPL_CRE_SEQUENCIAL
      );
 END;
/

-- End of DDL Script for Trigger DBA_INFRAERO.TRG_LPL_LOG

