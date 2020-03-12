
-- View CAD_MAXIMO
CREATE OR REPLACE VIEW cad_maximo (
   emp_numero_matricula,
   emp_nome,
   emp_data_admissao,
   emp_eso_codigo,
   emp_qlp_car_codigo,
   emp_qlp_car_occ_codigo,
   emp_ati_ct_custos,
   emp_dep_codigo_lotacao,
   emp_uor_codigo_lotacao,
   emp_status,
   descricao_status,
   emp_tipo_remuneracao_funcao,
   salario,
   valor_fg,
   valor_rg,
   insalubridade,
   periculosidade,
   carga_horaria_funcionario,
   emp_qfu_fun_codigo )
AS
SELECT
        EMP_NUMERO_MATRICULA,
        EMP_NOME,
        EMP_DATA_ADMISSAO,
        EMP_ESO_CODIGO,
        EMP_QLP_CAR_CODIGO,
        EMP_QLP_CAR_OCC_CODIGO,
        EMP_ATI_CT_CUSTOS,
        EMP_DEP_CODIGO_LOTACAO,
        EMP_UOR_CODIGO_LOTACAO,
        EMP_STATUS,
        DECODE(EMP_STATUS,0,'Afastado',1,'Ativo',2,'Desligado'),
        DECODE(EMP_TIPO_REMUNERACAO_FUNCAO,NULL,'NR',EMP_TIPO_REMUNERACAO_FUNCAO),
        -- FUNCAO QUE DEVOLVE O SALARIO
        VALOR_SALARIO(emp_numero_matricula,
                      emp_sfu_codigo,
                      emp_nsa_codigo_nivel,
                      emp_nsa_codigo_padrao,
                      emp_nsa_in_nivel_escolaridade,
                      TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'YYYY'), -- ANO DE DOS MESES ANTERIORES
                      TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'MM')    -- MES DE DOS MESES ANTERIORES
                      ) salario,
        -- FUNCAO QUE DEVOLVE O VALOR DE FG SIM emp_tipo_remuneracao_funcao = 'FG' OU 0 SIM emp_tipo_remuneracao_funcao <> DE 'FG'
        DECODE(emp_tipo_remuneracao_funcao,'FG',
               (VALOR_PARA_TIPO_REMUNERACAO(emp_tipo_remuneracao_funcao,
                                            emp_qfu_fun_codigo,
                                            TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'YYYY'), -- ANO DE DOS MESES ANTERIORES
                                            TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'MM')    -- MES DE DOS MESES ANTERIORES
                                            )
                 ),0) valor_fg,
        -- FUNCAO QUE DEVOLVE O VALOR DE RG SIM emp_tipo_remuneracao_funcao = 'RG' OU 0 SIM emp_tipo_remuneracao_funcao <> DE 'RG'
        DECODE(emp_tipo_remuneracao_funcao,'RG',
               (VALOR_PARA_TIPO_REMUNERACAO(emp_tipo_remuneracao_funcao,
                                            emp_qfu_fun_codigo,
                                            TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'YYYY'), -- ANO DE DOS MESES ANTERIORES
                                            TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'MM')    -- MES DE DOS MESES ANTERIORES
                                            )
                 ),0) valor_rg,
        --  FUNCAO QUE DEVOLVE O VALOR_INTEGRAL SEGUN PARAMETRO mov_rub_codigo
        VALOR_INTEGRAL( emp_numero_matricula,
                        1085, -- insalubridade
                        TO_NUMBER(TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'YYYY')), -- ANO DE DOS MESES ANTERIORES
                        TO_NUMBER(TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'MM'))    -- MES DE DOS MESES ANTERIORES
                      ) insalubridade,
        VALOR_INTEGRAL(emp_numero_matricula,
                       1090, -- periculosidade
                       TO_NUMBER(TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'YYYY')), -- ANO DE DOS MESES ANTERIORES
                       TO_NUMBER(TO_CHAR(ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-2),'MM'))    -- MES DE DOS MESES ANTERIORES
                       ) periculosidade,
        -- FUNCAO QUE DEVOLVE A CARGA HORARIA DO FUNCIONARIO
        -- Nesta função se o empregado esteve de ferias na data se pegam as horas trabalhadas
        -- do mair mes sem ferias que o empregado trabalho.
        ULTIMA_CARGA_HORARIA_EMP(emp_numero_matricula,
                          ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE))+1,-2), -- PRIMEIRO DIA DE UM MES ANTERIOR
                          ADD_MONTHS(LAST_DAY(TRUNC(SYSDATE)),-1)    -- ULTIMO DIA DE UM MES ANTERIORES
                         ) carga_horaria_funcionario,
        EMP_QFU_FUN_CODIGO
     FROM CADASTROS
    WHERE (EMP_TIPO_REMUNERACAO_FUNCAO IS NULL OR
          EMP_TIPO_REMUNERACAO_FUNCAO != 'DI' )
/


-- End of DDL script for CAD_MAXIMO
