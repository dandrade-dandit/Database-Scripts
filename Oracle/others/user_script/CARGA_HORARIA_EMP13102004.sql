
CREATE OR REPLACE
Function CARGA_HORARIA_EMP
  ( p_emp_numero_matricula IN CADASTROS.EMP_NUMERO_MATRICULA%TYPE,
    p_data_inicio IN DATE,
    p_data_fin IN DATE)
  RETURN  NUMBER IS
  --
   v_valor                 NUMBER;
   --
BEGIN
    BEGIN
       SELECT HF.HFR_JORNADA_MENSAL
         INTO v_valor
         FROM HORARIOS_FREQUENCIA HF,
              OCORRENCIAS_FREQUENCIA_EMP OFE,
              CADASTROS C
        WHERE C.EMP_NUMERO_MATRICULA = OFE.ofe_emp_numero_matricula
          AND OFE.OFE_DATA_INICIO = (SELECT MAX(OFE2.OFE_DATA_INICIO)
                                       FROM OCORRENCIAS_FREQUENCIA_EMP OFE2
                                      WHERE (OFE2.OFE_DATA_INICIO >= p_data_inicio
                                        AND TRUNC(OFE2.OFE_DATA_INICIO) <= p_data_fin)
                                        AND OFE2.OFE_OFU_CODIGO = OFE.OFE_OFU_CODIGO
                                        AND OFE2.OFE_EMP_NUMERO_MATRICULA = OFE.OFE_EMP_NUMERO_MATRICULA
                                    )
          AND (OFE.OFE_DATA_INICIO >= p_data_inicio
          AND TRUNC(OFE.OFE_DATA_INICIO) <= p_data_fin)
          AND HF.hfr_dep_codigo = NVL(ofe.ofe_dep_codigo, C.emp_dep_codigo_lotacao)
          AND HF.hfr_cod_horario = OFE.ofe_cod_horario_empregado
          AND HF.hfr_turno_trabalho = OFE.ofe_turno_trabalho_empregado
          AND OFE.OFE_OFU_CODIGO = 147
          AND OFE.OFE_EMP_NUMERO_MATRICULA = p_emp_numero_matricula;
          --
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          --
          BEGIN
            --
            SELECT HF.HFR_JORNADA_MENSAL
              INTO v_valor
              FROM HORARIOS_FREQUENCIA HF,
                   OCORRENCIAS_FREQUENCIA_EMP OFE,
                   CADASTROS C
             WHERE C.EMP_NUMERO_MATRICULA = OFE.ofe_emp_numero_matricula
               AND OFE.OFE_DATA_INICIO = (SELECT MAX(OFE2.OFE_DATA_INICIO)
                                            FROM OCORRENCIAS_FREQUENCIA_EMP OFE2
                                           WHERE (OFE2.OFE_DATA_INICIO >= p_data_inicio
                                             AND TRUNC(OFE2.OFE_DATA_INICIO) <= p_data_fin)
                                             AND OFE2.OFE_OFU_CODIGO = OFE.OFE_OFU_CODIGO
                                             AND OFE2.OFE_EMP_NUMERO_MATRICULA = OFE.OFE_EMP_NUMERO_MATRICULA
                                         )
              AND (OFE.OFE_DATA_INICIO >= p_data_inicio
              AND TRUNC(OFE.OFE_DATA_INICIO) <= p_data_fin)
              AND HF.hfr_dep_codigo = NVL(ofe.ofe_dep_codigo, C.emp_dep_codigo_lotacao)
              AND HF.hfr_cod_horario = OFE.ofe_cod_horario_empregado
              AND HF.hfr_turno_trabalho = OFE.ofe_turno_trabalho_empregado
              AND OFE.OFE_OFU_CODIGO = 47
              AND OFE.OFE_EMP_NUMERO_MATRICULA = p_emp_numero_matricula;            
              --
          EXCEPTION
            WHEN NO_DATA_FOUND THEN  
              v_valor := 0;
          END;
          --
    END;
    --
    RETURN v_valor;
END;
/
