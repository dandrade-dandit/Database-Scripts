
-- View VIW_FAIXAS_SALARIAIS

CREATE OR REPLACE VIEW viw_faixas_salariais (
   cod_regional,
   sigla_regional,
   cod_dep,
   sigla_dep,
   cod_uor,
   sigla_uor,
   emp_sina,
   matricula,
   emp_nome,
   cod_cargo,
   sigla_cargo,
   nome_cargo,
   cbo_cargo,
   cod_ocupacao_atuacao,
   desc_ocupacao_atuacao,
   cod_funcao,
   tipo,
   desc_funcao,
   cbo_funcao,
   salario,
   cod_intervalo,
   desc_intervalo )
AS
select subor.dep_codigo cod_regional,
       subor.dep_sigla Sigla_regional,
       dep.dep_codigo cod_Dep,
       dep.dep_sigla Sigla_Dep,
       emp_uor_codigo_lotacao cod_UOR,
       uor_sigla Sigla_UOR,
       empregado_sina(emp_numero_matricula,
                      TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'YYYY')),
                      TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM'))
                      ) Emp_sina,
       emp_numero_matricula Matricula,
       emp_nome_abreviado Nome,
       car_codigo cod_Cargo,
       car_sigla Sigla_Cargo,
       Car_nome Nome_Cargo,
       car_codigo_cbo cbo_cargo,
       emp_qlp_car_occ_codigo cod_Ocupacao_atuacao,
       Occ_descricao Desc_Ocupacao_atuacao,
       emp_qfu_fun_codigo cod_Funcao,
       emp_tipo_remuneracao_funcao Tipo,
       fun_nome Desc_Funcao,
       fun_codigo_cbo cbo_funcao,
       sal.salario,
       sal.cod_intervalo,
       DECODE(sal.cod_intervalo,1, '0 até 1000',2,'1000,01 até 2000',
                                3,'2000,01 até 3000',4,'Acima de 3000') desc_intervalo
from cadastros,
     cargos,
     ocupacoes_cargo,
     dependencias dep,
     (select dep_codigo,
             dep_sigla,
             dep_nome
      from dependencias
      where dep_data_extincao is null
      connect by prior dep_codigo = dep_dep_codigo
      start with to_char(dep_codigo)  = '1') subor,
     unidades_organizacionais,
     funcoes,
     (SELECT MOV_EMP_NUMERO_MATRICULA MAT,
             SUM(MOV_VALOR) SALARIO,
             INTERVALO(SUM(MOV_VALOR)) COD_INTERVALO
        FROM MOVIMENTACAO
       WHERE MOV_RUB_CODIGO IN (1000,1005,1010,1015,1060,1070,1085,1090,
                                1385,1300,1305)
         AND MOV_MES_REFERENCIA = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'MM'))
         AND MOV_ANO_REFERENCIA = TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE,-1),'YYYY'))
         AND MOV_VERSAO_PAGAMENTO = 1
      GROUP BY MOV_EMP_NUMERO_MATRICULA
      ) SAL
where emp_qlp_car_codigo = car_codigo(+)
and   emp_qlp_car_codigo_nivel = car_codigo_nivel(+)
and   emp_qlp_car_occ_codigo = car_occ_codigo(+)
and   car_occ_codigo = occ_codigo(+)
and   ((emp_dep_codigo_lotacao = dep.dep_codigo
        and  dep.dep_dep_codigo = subor.dep_codigo)
      or
      (emp_dep_codigo_lotacao = 1
       and emp_dep_codigo_lotacao = dep.dep_codigo
       and dep.dep_codigo = subor.dep_codigo))
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_qfu_fun_codigo = fun_codigo(+)
and   emp_numero_matricula = sal.mat(+)
and   emp_sfu_codigo in (1,2)
and   emp_status != 2
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome_abreviado
/

-- End of DDL script for VIW_FAIXAS_SALARIAIS
