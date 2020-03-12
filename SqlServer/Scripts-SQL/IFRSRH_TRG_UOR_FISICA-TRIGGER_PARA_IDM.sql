
CREATE OR REPLACE TRIGGER IFRSRH.TRG_LOG_IDM 
BEFORE INSERT  OR UPDATE
ON IFRSRH.cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  --
    -- Altero a UOR fisica para que tenha o mesmo valor que a uor da lotacao
   IF UPDATING THEN
      --ALTERA OS STATUS DO EMPREGADO.
      IF :NEW.EMP_STATUS = 0 THEN
        UPDATE IFRCORP.TAB_INTERFACE_IDM 
           SET dsc_situacao_funcional = 'I' 
         WHERE num_cpf = :NEW.emp_numero_cpf;
      ELSIF :NEW.EMP_STATUS = 2 THEN
        UPDATE IFRCORP.TAB_INTERFACE_IDM 
           SET dsc_situacao_funcional = 'D' 
         WHERE num_cpf = :NEW.emp_numero_cpf; 
      ELSE
        UPDATE IFRCORP.TAB_INTERFACE_IDM 
           SET dsc_situacao_funcional = 'A'
         WHERE num_cpf = :NEW.emp_numero_cpf;     
      END IF;
                 
      IF ((:OLD.emp_uor_codigo_lotacao != :NEW.emp_uor_codigo_lotacao) OR (:OLD.emp_uor_codigo_fisico != :NEW.emp_uor_codigo_fisico)) THEN
         UPDATE IFRCORP.TAB_INTERFACE_IDM 
            SET  cod_uor_lotacao = :NEW.emp_uor_codigo_lotacao
              ,  sig_uor_lotacao = (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_lotacao AND UOR_DATA_EXTINCAO IS NULL)
              ,  nme_uor_lotacao = (SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_lotacao AND UOR_DATA_EXTINCAO IS NULL)
              ,  cod_uor_fisica = :NEW.emp_uor_codigo_fisico
              ,  sig_uor_fisica = (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_fisico AND UOR_DATA_EXTINCAO IS NULL)
              ,  nme_uor_fisica = (SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_fisico AND UOR_DATA_EXTINCAO IS NULL)
          WHERE num_cpf = :NEW.emp_numero_cpf;
      END IF;
      
      IF ((:OLD.emp_dep_codigo_lotacao != :NEW.emp_dep_codigo_lotacao) OR (:OLD.emp_dep_codigo_fisico != :NEW.emp_dep_codigo_fisico)) THEN
         UPDATE IFRCORP.TAB_INTERFACE_IDM 
            SET  cod_dep_lotacao = :NEW.emp_dep_codigo_lotacao
              ,  sig_dep_lotacao = (SELECT DEP_SIGLA FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_lotacao AND DEP_DATA_EXTINCAO IS NULL)
              ,  nme_dep_lotacao = (SELECT DEP_NOME FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_lotacao AND DEP_DATA_EXTINCAO IS NULL)
              ,  cod_dep_fisica = :NEW.emp_dep_codigo_fisico
              ,  sig_dep_fisica = (SELECT DEP_SIGLA FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_fisico AND DEP_DATA_EXTINCAO IS NULL)
              ,  nme_dep_fisica = (SELECT DEP_NOME FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_fisico AND DEP_DATA_EXTINCAO IS NULL)
          WHERE num_cpf = :NEW.emp_numero_cpf;
      END IF;
      
    END IF;
  --
END; --End TRIGGER trg_uor_fisica
/


-- End of DDL Script for Trigger IFRSRH.TRG_UOR_FISICA

