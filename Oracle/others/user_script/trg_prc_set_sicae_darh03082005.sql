CREATE OR REPLACE TRIGGER ifrsrh.trg_prc_set_sicae_darh
 AFTER
  INSERT OR DELETE OR UPDATE
 ON ifrsrh.ocorrencias_empregados
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN (OLD.OEM_OFU_CODIGO IN (85,86,88,256)
       OR
       NEW.OEM_OFU_CODIGO IN (85,86,88,256)
      )
DECLARE
  v_altera        VARCHAR2(1) := 'N';
  v_fun_codigo    CARGOS_CONFIANCA.fun_codigo% TYPE;
  v_cant          NUMBER(10);
  v_cant_pzero    NUMBER(10);
BEGIN
  -- TRATAMENTO PARA A OCORRENCIA DE FUNCAO
  -- Pode ganhar permissão
  IF (INSERTING OR
      (UPDATING AND :OLD.OEM_DATA_TERMINO IS NOT NULL AND :NEW.OEM_DATA_TERMINO IS NULL))
  THEN
--    IF NVL(:OLD.OEM_OFU_CODIGO,:NEW.OEM_OFU_CODIGO) IN (86,88,256) THEN
      --
      IF :NEW.OEM_FUN_CODIGO IN(905,907,940,914) THEN
        BEGIN
          -- verifico se a função e unica
          SELECT COUNT(EMP_QFU_FUN_CODIGO)
            INTO v_cant
            FROM CADASTROS
           WHERE (EMP_QFU_FUN_CODIGO         = :NEW.OEM_FUN_CODIGO
                  OR EMP_QFU_FUN_CODIGO_ACUMULA = :NEW.OEM_FUN_CODIGO
                 )
             AND EMP_UOR_CODIGO_LOTACAO = :NEW.OEM_UOR_CODIGO
             AND EMP_DEP_CODIGO_LOTACAO = :NEW.OEM_DEP_CODIGO
             AND EMP_STATUS != 2;
        EXCEPTION
          WHEN OTHERS THEN
            v_cant := 0;
        END;
        --
        IF NVL(v_cant,0) <= 1 THEN
          BEGIN
            -- Verifico se não exite otra matricula com função de chefia na dep e uor
            SELECT COUNT(EMP_QFU_FUN_CODIGO)
              INTO v_cant_pzero
              FROM CADASTROS,
                   CARGOS_CONFIANCA
             WHERE EMP_QFU_FUN_CODIGO = FUN_CODIGO(+)
               AND FUN_POSICAO_TRABALHO = 0
               AND EMP_QFU_FUN_CODIGO != :NEW.OEM_FUN_CODIGO
               AND EMP_UOR_CODIGO_LOTACAO = :NEW.OEM_UOR_CODIGO
               AND EMP_DEP_CODIGO_LOTACAO = :NEW.OEM_DEP_CODIGO
               AND EMP_STATUS != 2;
          EXCEPTION
            WHEN OTHERS THEN
              v_cant_pzero := 0;
          END;
          --
          IF NVL(v_cant_pzero,0) = 0 THEN
            -- DOU PERMISÃO
            PRC_SET_SICAE_DARH(0,:NEW.OEM_EMP_NUMERO_MATRICULA);
          END IF;
        END IF;
        --
      ELSE -- IF :NEW.OEM_FUN_CODIGO IN(905,907,940,914)
        -- Select para verificar se é uma função de chefia
        BEGIN
          SELECT 'S'
            INTO v_altera
            FROM CARGOS_CONFIANCA
           WHERE FUN_POSICAO_TRABALHO = 0
             AND FUN_CODIGO = :NEW.OEM_FUN_CODIGO;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            v_altera := 'N';
          WHEN TOO_MANY_ROWS THEN
            v_altera := 'S';

        END;
        IF v_altera = 'S' THEN
          PRC_SET_SICAE_DARH(0,:NEW.OEM_EMP_NUMERO_MATRICULA);
        END IF;
      END IF; -- IF :NEW.OEM_FUN_CODIGO IN(905,907,907,914)
    --
    -- TRATAMENTO PARA A OCORRENCIA DE FUNCAO ACUMULADA
--    ELSIF NVL(:OLD.OEM_OFU_CODIGO,:NEW.OEM_OFU_CODIGO) = 85 THEN
      --

      --
--    END IF; --IF NVL(:OLD.OEM_OFU_CODIGO,:NEW.OEM_OFU_CODIGO) IN (86,88,256) THEN
  -- tiro a permissão
  ELSIF ((UPDATING AND :OLD.OEM_DATA_TERMINO IS NULL AND :NEW.OEM_DATA_TERMINO IS NOT NULL)
          OR DELETING)
  THEN
    PRC_SET_SICAE_DARH(1,:NEW.OEM_EMP_NUMERO_MATRICULA);
  END IF;
--
END;
