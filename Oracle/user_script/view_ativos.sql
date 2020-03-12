

-- View VIEW_ATIVOS

CREATE OR REPLACE VIEW view_ativos (
   codigo_superintendecia,
   sigla_superintendecia,
   nome_superintendecia,
   codigo_dependencia,
   sigla_dependencia,
   nome_dependencia,
   codigo_uor,
   sigla_uor,
   descricao_uor,
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   admissao,
   nascimento,
   categoria,
   padrao,
   centro_custos,
   codigo_cargo,
   sigla_cargo,
   nome_cargo,
   codigo_ocupacao,
   descricao_ocupacao,
   codigo_funcao,
   tipo_remuneracao,
   descricao_funcao,
   codigo_escolaridade,
   escolaridade
   )
AS
select subor.dep_codigo codigo_Superintendecia,
       subor.dep_sigla Sigla_Superintendecia,
       subor.dep_nome Nome_Superintendecia,
       dep.dep_codigo codigo_Dependencia,
       dep.dep_sigla Sigla_Dependencia,
       dep.dep_nome Nome_Dependencia,
       emp_uor_codigo_lotacao codigo_UOR,
       uor_sigla Sigla_UOR,
       uor_nome Descricao_UOR,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       emp_data_nascimento Nascimento,
       emp_nsa_codigo_padrao Categoria,
       emp_nsa_codigo_nivel Padrao,
       emp_ati_ct_custos Centro_Custos,
       car_codigo codigo_Cargo,
       car_sigla Sigla_Cargo,
       Car_nome Nome_Cargo,
       emp_qlp_car_occ_codigo codigo_Ocupacao,
       Occ_descricao Descricao_Ocupacao,
       emp_qfu_fun_codigo codigo_Funcao,
       emp_tipo_remuneracao_funcao Tipo,
       fun_nome Descricao_Funcao,
       emp_eso_codigo,
       eso_nome Escolaridade
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
     escolaridades
where emp_status != 2
--and   emp_ati_ct_custos in(201321,205130,145108)
and   emp_qlp_car_codigo = car_codigo(+)
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
and   emp_eso_codigo = eso_codigo(+)
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/


