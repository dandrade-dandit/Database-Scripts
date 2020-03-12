-- TIRA PERMISSAO
DECLARE
  CURSOR FUN IS
     SELECT --EMP_DEP_CODIGO_LOTACAO ,
            --EMP_UOR_CODIGO_LOTACAO,
            'I'||LPAD(EMP_NUMERO_MATRICULA,7,'0') matricula
            --EMP_QFU_FUN_CODIGO
       FROM CADASTROS
      WHERE EMP_QFU_FUN_CODIGO IS NOT NULL;

   C1	FUN%ROWTYPE;
   --
   v_retorno NUMBER(1):= 0;
BEGIN
  FOR C1 IN FUN LOOP
    -- Tira permissão
    PRC_SET_SICAE_DARH(1,C1.matricula,v_retorno);
  END LOOP;
  commit;
END;

