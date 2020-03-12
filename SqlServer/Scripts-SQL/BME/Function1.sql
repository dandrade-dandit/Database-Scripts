CREATE OR REPLACE FUNCTION IFRSRH.FUN_BME_VALOR_PARA_TIPO_REMUN
  ( p_emp_tipo_remuneracao_funcao IN CADASTROS.EMP_TIPO_REMUNERACAO_FUNCAO%TYPE,
    p_emp_qfu_fun_codigo IN CADASTROS.EMP_QFU_FUN_CODIGO%TYPE,
    p_ano IN VARCHAR2,
    p_mes IN VARCHAR2 )
  RETURN  NUMBER IS
  --
  -- Calcula valor para tipo_remuneracao segundo o tipo de remuneracao da função do empregado
  --
   v_valor_fg                   NUMBER;
   v_valor_rg                   NUMBER;
   v_valor_funcao               NUMBER;
   v_valor_tipo_remuneracao     NUMBER;
   --
BEGIN
    IF p_emp_tipo_remuneracao_funcao in ('RG','FG') THEN
      BEGIN
        SELECT NVL(CFV.CFV_VALOR_RG,0), NVL(CFV.CFV_VALOR_FG,0)
          INTO v_valor_rg,v_valor_fg
          FROM CARGOS_CONFIANCA CC,
               CATEGORIAS_FUNCOES_VALOR CFV
         WHERE CFV.CFV_DATA_VIGENCIA IN
                           (SELECT MAX(CFV2.CFV_DATA_VIGENCIA)
                              FROM CATEGORIAS_FUNCOES_VALOR CFV2
                             WHERE CFV2.CFV_CFU_CODIGO = CFV.CFV_CFU_CODIGO
                               AND TO_NUMBER(TO_CHAR(CFV2.CFV_DATA_VIGENCIA,'YYYYMM')) <=
                                   TO_NUMBER(LPAD(p_ano,4,'0')||LPAD(p_mes,2,'0'))
                           )
           AND CC.FUN_CFU_CODIGO = CFV.CFV_CFU_CODIGO
           AND CC.FUN_CODIGO = p_emp_qfu_fun_codigo;
        --
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            v_valor_fg := 0;
            v_valor_rg := 0;
            v_valor_funcao := 0;
      END;
      -- ASIGNO VALOR FUNCAO
      IF p_emp_tipo_remuneracao_funcao = 'RG' THEN
        v_valor_tipo_remuneracao := v_valor_rg;
      ELSIF p_emp_tipo_remuneracao_funcao = 'FG' THEN
        v_valor_tipo_remuneracao := v_valor_fg;
      END IF;
      --
    ELSIF p_emp_tipo_remuneracao_funcao = ('DI') THEN
      BEGIN
        SELECT NVL(CL.COL_VALOR,0)
          INTO v_valor_funcao
          FROM CONSTANTES_LEGAIS CL
         WHERE CL.COL_CODIGO = 11
           AND TO_DATE(TO_CHAR(CL.COL_MES_REFERENCIA)||'/'||
                       TO_CHAR(CL.COL_ANO_REFERENCIA),'MM/YYYY') IN
                          (SELECT MAX(TO_DATE(TO_CHAR(CL2.COL_MES_REFERENCIA)||'/'||
                                              TO_CHAR(CL2.COL_ANO_REFERENCIA),'MM/YYYY'))
                             FROM CONSTANTES_LEGAIS CL2
                            WHERE TO_NUMBER(LPAD(TO_CHAR(CL2.COL_ANO_REFERENCIA),4,'0')||
                                            LPAD(TO_CHAR(CL2.COL_MES_REFERENCIA),2,'0')) <=
                                  TO_NUMBER(LPAD(p_ano,4,'0')||LPAD(p_mes,2,'0'))
                          );
        --
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            v_valor_fg := 0;
            v_valor_rg := 0;
            v_valor_funcao := 0;
      END;
      -- ASIGNO VALOR FUNCAO
      v_valor_tipo_remuneracao := v_valor_funcao;
    -- ASIGNO VALOR FUNCAO
    ELSE
      v_valor_tipo_remuneracao := 0;
    END IF;
    --
    RETURN v_valor_tipo_remuneracao;
END;
/


