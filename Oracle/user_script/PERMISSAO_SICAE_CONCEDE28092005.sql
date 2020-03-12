-- Concede Permissão
DECLARE
  CURSOR CHEFES IS
     SELECT EMP_DEP_CODIGO_LOTACAO dep_codigo,
            EMP_UOR_CODIGO_LOTACAO uor_codigo,
            'I'||LPAD(EMP_NUMERO_MATRICULA,7,'0') matricula,
            EMP_NUMERO_MATRICULA mat,
            EMP_QFU_FUN_CODIGO fun_codigo
       FROM CADASTROS
      WHERE (EMP_QFU_FUN_CODIGO in (905,907,940,914)
             OR
             EXISTS (SELECT 'S'
                       FROM CARGOS_CONFIANCA
                       WHERE FUN_POSICAO_TRABALHO = 0
                         AND EMP_QFU_FUN_CODIGO = FUN_CODIGO)
                    )
        AND EMP_STATUS != 2

    UNION ALL

     SELECT EMP_DEP_CODIGO_LOTACAO dep_codigo,
            EMP_UOR_CODIGO_LOTACAO uor_codigo,
            'I'||LPAD(EMP_NUMERO_MATRICULA,7,'0') matricula,
            EMP_NUMERO_MATRICULA mat,
            EMP_QFU_FUN_CODIGO_ACUMULA fun_codigo
        FROM CADASTROS
       WHERE (EMP_QFU_FUN_CODIGO_ACUMULA in (905,907,940,914)
              OR
             EXISTS (SELECT 'S'
                       FROM CARGOS_CONFIANCA
                      WHERE FUN_POSICAO_TRABALHO = 0
                        AND EMP_QFU_FUN_CODIGO_ACUMULA = FUN_CODIGO)
                     )
         AND EMP_STATUS != 2;

   C1	CHEFES%ROWTYPE;
   --
   v_cant NUMBER(10):= 0;
   v_cant_pzero NUMBER(10):= 0;
   --
   v_retorno NUMBER(1) := 0;
BEGIN
  -- CABEÇALHO
  -- DBMS_OUTPUT.PUT_LINE('MATRICULA'||'|'||'UOR'||'|'||'FUN'||'|'||'PERMISSAO');
  --
  FOR C1 IN CHEFES LOOP
    -- Concede permissão
    IF C1.FUN_CODIGO IN(905,907,940,914) THEN
      BEGIN
        -- verifico se a função e unica
        SELECT COUNT(EMP_QFU_FUN_CODIGO)
          INTO v_cant
          FROM CADASTROS
         WHERE (EMP_QFU_FUN_CODIGO         = C1.FUN_CODIGO
                OR EMP_QFU_FUN_CODIGO_ACUMULA = C1.FUN_CODIGO
                )
           AND EMP_UOR_CODIGO_LOTACAO = C1.UOR_CODIGO
           AND EMP_DEP_CODIGO_LOTACAO = C1.DEP_CODIGO
           AND EMP_NUMERO_MATRICULA  != C1.MAT
           AND EMP_STATUS != 2;

      EXCEPTION
        WHEN OTHERS THEN
            v_cant := 0;
      END;
      --
      IF NVL(v_cant,0) < 1 THEN
        BEGIN
          -- Verifico se não exite otra matricula com função de chefia na dep e uor
          SELECT COUNT(EMP_QFU_FUN_CODIGO)
            INTO v_cant_pzero
            FROM CADASTROS,
                 CARGOS_CONFIANCA
           WHERE EMP_QFU_FUN_CODIGO = FUN_CODIGO(+)
             AND FUN_POSICAO_TRABALHO = 0
             AND EMP_QFU_FUN_CODIGO != C1.FUN_CODIGO
             AND EMP_UOR_CODIGO_LOTACAO = C1.UOR_CODIGO
             AND EMP_DEP_CODIGO_LOTACAO = C1.DEP_CODIGO
             AND EMP_STATUS != 2;

        EXCEPTION
          WHEN OTHERS THEN
            v_cant_pzero := 0;
        END;
        --
        IF NVL(v_cant_pzero,0) = 0 THEN
          -- CONCEDE PERMISSÃO
          PRC_SET_SICAE_DARH(0,C1.MATRICULA,v_retorno);
          --DBMS_OUTPUT.PUT_LINE(C1.MATRICULA||'|'||TO_CHAR(C1.UOR_CODIGO)||'|'||
          --                     TO_CHAR(C1.FUN_CODIGO)||'|'||'S');
          --ELSE
          --  DBMS_OUTPUT.PUT_LINE(C1.MATRICULA||'|'||TO_CHAR(C1.UOR_CODIGO)||'|'||
          --                       TO_CHAR(C1.FUN_CODIGO)||'|'||'N outra fun');
        END IF;
       --ELSE
       -- DBMS_OUTPUT.PUT_LINE(C1.MATRICULA||'|'||TO_CHAR(C1.UOR_CODIGO)||'|'||
       --                      TO_CHAR(C1.FUN_CODIGO)||'|'||'N mais de um fun');
      END IF;
      --
    ELSE -- IF C1.FUN_CODIGO IN(905,907,940,914)
      -- CONCEDE PERMISSÃO
      PRC_SET_SICAE_DARH(0,C1.matricula,v_retorno);
      --DBMS_OUTPUT.PUT_LINE(C1.MATRICULA||'|'||TO_CHAR(C1.UOR_CODIGO)||'|'||
      --                     TO_CHAR(C1.FUN_CODIGO)||'|'||'S');
    END IF;
  END LOOP;
  commit;
END;

