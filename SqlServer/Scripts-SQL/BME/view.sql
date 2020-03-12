CREATE OR REPLACE VIEW IFRSRH.VIW_BME_SALARIO_ATIVOS
(MATRICULA, TP_FUN, REMUNERACAO_CARGO, VALOR_FG, VALOR_RG, 
 VALOR_DI, SALARIO)
AS 
SELECT matricula,
         tp_fun,
         remuneracao_cargo,
         valor_FG,
         valor_RG,
         valor_DI,
         DECODE(tp_fun, null, remuneracao_cargo
                      , 'DI', valor_DI
                      , 'RG', valor_RG
                      , 'FG', remuneracao_cargo + valor_FG
                ) salario
  FROM
    (SELECT EMP_NUMERO_MATRICULA matricula,
            EMP_TIPO_REMUNERACAO_FUNCAO tp_fun,
            -- FUNCAO QUE DEVOLVE A REMUNERACAO DO CARGO
            BME_VALOR_SALARIO(emp_numero_matricula,
                          emp_sfu_codigo,
                          emp_nsa_codigo_nivel,
                          emp_nsa_codigo_padrao,
                          emp_nsa_in_nivel_escolaridade,
                          TO_CHAR(SYSDATE,'YYYY'), -- ANO DE DOS MESES ANTERIORES
                          TO_CHAR(SYSDATE,'MM')    -- MES DE DOS MESES ANTERIORES
                          ) remuneracao_cargo,
            -- FUNCAO QUE DEVOLVE O VALOR DE FG SIM emp_tipo_remuneracao_funcao = 'FG' OU 0 SIM emp_tipo_remuneracao_funcao <> DE 'FG'
            DECODE(emp_tipo_remuneracao_funcao,'FG',
                   (BME_VALOR_PARA_TIPO_REMUN(emp_tipo_remuneracao_funcao,
                                                emp_qfu_fun_codigo,
                                                TO_CHAR(SYSDATE,'YYYY'),
                                                TO_CHAR(SYSDATE,'MM')
                                                )
                     ),0) valor_FG,
            -- FUNCAO QUE DEVOLVE O VALOR DE RG SIM emp_tipo_remuneracao_funcao = 'RG' OU 0 SIM emp_tipo_remuneracao_funcao <> DE 'RG'
            DECODE(emp_tipo_remuneracao_funcao,'RG',
                   (BME_VALOR_PARA_TIPO_REMUN(emp_tipo_remuneracao_funcao,
                                                emp_qfu_fun_codigo,
                                                TO_CHAR(SYSDATE,'YYYY'),
                                                   TO_CHAR(SYSDATE,'MM')
                                                )
                     ),0) valor_RG,
            DECODE(emp_tipo_remuneracao_funcao,'DI',
                   (BME_VALOR_PARA_TIPO_REMUN(emp_tipo_remuneracao_funcao,
                                                emp_qfu_fun_codigo,
                                                TO_CHAR(SYSDATE,'YYYY'),
                                                TO_CHAR(SYSDATE,'MM')
                                                )
                     ),0) valor_DI,
            EMP_QFU_FUN_CODIGO
       FROM CADASTROS
      WHERE EMP_STATUS != 2) GRAL
/


