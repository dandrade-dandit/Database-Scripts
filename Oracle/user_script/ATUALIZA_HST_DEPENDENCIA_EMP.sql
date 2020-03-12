CREATE OR REPLACE
PROCEDURE ATUALIZA_HST_DEPENDENCIA_EMP (p_mes                    number,
                                        p_ano                    number,
                                        p_emp_numero_matricula   number DEFAULT NULL) IS
------------------------------------------------------------------------------------
--                           ATUALIZA_HST_DEPENDENCIA_EMP                         --
--                           -------- --- ----------- ---                         --
--                                                                                --
--    Rotina que atualiza a tabela hst_dependencia_empregado que é utilizada no   --
-- cálculo da Freqüência por afastamento de Absenteísmo.                          --
--                                                                                --
-- Criada por: Luiz Fernando Bastos Coura                                         --
-- Data da Criação: 14/11/2002                                                    --
--                                                                                --
-- Alterada por:                                                                  --
-- Data da última alteração:                                                      --
-- Obs.:                                                                          --
--                                                                                --
-- Alterada por:                                                                  --
-- Data da última alteração:                                                      --
-- Obs.:                                                                          --
--                                                                                --
------------------------------------------------------------------------------------
   --
   v_dep NUMBER(4);
   v_ct  NUMBER(4) := 0;
   --
   CURSOR c_emp IS
      SELECT emp_numero_matricula,
             emp_data_admissao,
             emp_dep_codigo_lotacao
      FROM   cadastros
      WHERE  emp_status != 2
      and   (   (p_emp_numero_matricula is null)
             or (emp_numero_matricula = p_emp_numero_matricula));
	  --
BEGIN
   --
   FOR r_emp IN c_emp LOOP
      --
      v_ct := v_ct + 1;
      --
      v_dep := NVL(BUSCA_DEPENDENCIA( r_emp.emp_numero_matricula,
                                      LAST_DAY( TO_DATE( LPAD(TO_CHAR(p_mes),2,'0') || TO_CHAR(p_ano), 'MMYYYY') ) )
                                     , r_emp.emp_dep_codigo_lotacao );
      --
      BEGIN
         --
         UPDATE hst_dependencia_empregado
         SET    hde_dep_codigo = v_dep
         WHERE  hde_emp_numero_matricula = r_emp.emp_numero_matricula
         AND    hde_mes_referencia       = p_mes
         AND    hde_ano_referencia       = p_ano;
         --
         IF SQL%NOTFOUND THEN
            --
            INSERT INTO HST_DEPENDENCIA_EMPREGADO
                   ( hde_emp_numero_matricula,
                     hde_mes_referencia,
                     hde_ano_referencia,
                     hde_dep_codigo )
            VALUES ( r_emp.emp_numero_matricula,
                     p_mes,
                     p_ano,
                     v_dep );
            --
         END IF;
         --
      END;
      --
      IF v_ct = 500 THEN
         --
         COMMIT;
         v_ct := 0;
         --
      END IF;
      --
   END LOOP;
   --
END ATUALIZA_HST_DEPENDENCIA_EMP;
/
