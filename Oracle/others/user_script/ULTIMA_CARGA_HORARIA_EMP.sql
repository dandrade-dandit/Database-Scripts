
-- Function ULTIMA_CARGA_HORARIA_EMP

CREATE OR REPLACE
Function ULTIMA_CARGA_HORARIA_EMP
  ( p_emp_numero_matricula IN CADASTROS.EMP_NUMERO_MATRICULA%TYPE,
    p_data_inicio IN DATE,
    p_data_fim IN DATE)
  RETURN  NUMBER IS
  --
   v_valor                 NUMBER;
   v_data_inicio           DATE;
   v_data_fim              DATE;
   --
BEGIN
    v_valor := CARGA_HORARIA_EMP(p_emp_numero_matricula,p_data_inicio,p_data_fim);
    --
    IF v_valor = 0 THEN
      v_data_inicio := ADD_MONTHS(p_data_inicio, -1);
      v_data_fim := ADD_MONTHS(p_data_fim, -1);
      --
      IF ESTAVA_DE_FERIAS(p_emp_numero_matricula,v_data_inicio,v_data_fim) = 'S' THEN
        v_data_inicio := ADD_MONTHS(v_data_inicio, -1);
        v_data_fim := ADD_MONTHS(v_data_fim, -1);
        IF ESTAVA_DE_FERIAS(p_emp_numero_matricula,v_data_inicio,v_data_fim) = 'S' THEN
          v_data_inicio := ADD_MONTHS(v_data_inicio, -1);
          v_data_fim := ADD_MONTHS(v_data_fim, -1);
        END IF;
      END IF;
      --
      -- Volto a calcular as horas com as novas datas
      v_valor := CARGA_HORARIA_EMP(p_emp_numero_matricula,v_data_inicio,v_data_fim);
    END IF;
    --
    RETURN v_valor;
END;
/

-- End of DDL script for ULTIMA_CARGA_HORARIA_EMP
