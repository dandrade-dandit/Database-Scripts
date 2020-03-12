

-- Function ESTAVA_DE_FERIAS

CREATE OR REPLACE
FUNCTION ESTAVA_DE_FERIAS
  ( p_matricula IN CADASTROS.EMP_NUMERO_MATRICULA%TYPE,
    p_data_inicio IN DATE,
    p_data_fin IN DATE)
  RETURN  VARCHAR2 IS
  --
  v_ferias VARCHAR2(1);
BEGIN
  BEGIN
    SELECT 'S'
      INTO v_ferias
      FROM programacoes_ferias
     WHERE (
          (pfe_data_inicio_1 >= p_data_inicio and pfe_data_inicio_1 <= p_data_fin)
           or
          (pfe_data_termino_1 >= p_data_inicio and pfe_data_termino_1 <= p_data_fin)
           or
          (pfe_data_inicio_2 >= p_data_inicio and pfe_data_inicio_2 <= p_data_fin)
           or
          (pfe_data_termino_2 >= p_data_inicio and pfe_data_termino_2 <= p_data_fin)
         )
    AND pfe_emp_numero_matricula = p_matricula;
  EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      v_ferias := 'S';
    WHEN NO_DATA_FOUND THEN
      v_ferias := 'N';
  END;
  --
  RETURN(v_ferias);
END;

/

-- End of DDL script for ESTAVA_DE_FERIAS
