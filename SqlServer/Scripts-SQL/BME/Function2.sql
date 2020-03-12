CREATE OR REPLACE FUNCTION IFRSRH.FUN_BME_VALOR_SALARIO ( p_emp_numero_matricula IN CADASTROS.EMP_NUMERO_MATRICULA%TYPE,
    p_emp_sfu_codigo IN CADASTROS.EMP_SFU_CODIGO%TYPE,
    p_emp_nsa_codigo_nivel IN CADASTROS.EMP_NSA_CODIGO_NIVEL%TYPE,
    p_emp_nsa_codigo_padrao IN CADASTROS.EMP_NSA_CODIGO_PADRAO%TYPE,
    p_emp_nsa_in_nivel_escola IN CADASTROS.EMP_NSA_IN_NIVEL_ESCOLARIDADE%TYPE,
    p_ano VARCHAR2,
    p_mes VARCHAR2)
  RETURN  NUMBER IS
-- Calcula Valor Salario para a Matricula dada como parametro
--
   v_valor                 HISTORICO_NIVEIS_SALARIAIS.HNS_VALOR_REMUNERACAO%TYPE;
   --
BEGIN
  IF p_emp_sfu_codigo = 1 THEN
    BEGIN
      SELECT NVL(HNS.HNS_VALOR_REMUNERACAO,0)
        INTO v_valor
        FROM HISTORICO_NIVEIS_SALARIAIS HNS
       WHERE HNS.HNS_DATA_VIGENCIA =
                 ( SELECT MAX(HNS2.HNS_DATA_VIGENCIA)
                     FROM HISTORICO_NIVEIS_SALARIAIS HNS2, CADASTROS C2
                    WHERE C2.EMP_NUMERO_MATRICULA = p_emp_numero_matricula
                      AND C2.EMP_NSA_IN_NIVEL_ESCOLARIDADE = HNS.HNS_NSA_INDICADOR_NIVEL_ESCOLA
                      AND TO_NUMBER(TO_CHAR(HNS2.HNS_DATA_VIGENCIA,'YYYYMM')) <=
                          TO_NUMBER(LPAD(p_ano,4,'0')||LPAD(p_mes,2,'0'))
                 )
         AND HNS.HNS_NSA_CODIGO_NIVEL = p_emp_nsa_codigo_nivel
         AND HNS.HNS_NSA_CODIGO_PADRAO = p_emp_nsa_codigo_padrao
         AND HNS.HNS_NSA_INDICADOR_NIVEL_ESCOLA = p_emp_nsa_in_nivel_escola;
      --
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          v_valor := 0;
        WHEN OTHERS THEN
          v_valor := -1;
      END;
    ELSE
      v_valor := 0;
    END IF;
    --
    RETURN v_valor;
END;
/


