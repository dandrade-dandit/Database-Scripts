
CREATE OR REPLACE VIEW viw_desligados (
   codigo_superintendecia,
   sigla_superintendecia,
   codigo_dependencia,
   dep_sigla_lotacao,
   dep_codigo_lotacao,
   dep_codigo_pagamento,
   dep_codigo_fisico, 
   codigo_uor,
   uor_sigla,
   matricula,
   nome,
   nome_abreviado,
   centro_custos,
   numero_cpf,
   admissao,
   demissao,
   ofu_descricao,
   codigo_cargo,
   sigla_cargo,
   descricao_cargo,
   ocupacao_atuacao,
   sfu_codigo )
AS
select subor.dep_codigo codigo_Superintendecia,
       subor.dep_sigla Sigla_Superintendecia,
       dep.dep_codigo codigo_Dependencia,
       dep.dep_sigla Dep_Sigla,
       emp_dep_codigo_lotacao,
       emp_dep_codigo_pagto,
       emp_dep_codigo_fisico, 
       uor_codigo codigo_UOR,
       uor_sigla UOR_Sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_ati_ct_custos,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       oem_data_inicio Demissao,
       ofu_descricao,
       car_codigo codigo_cargo,
       car_sigla sigla_Cargo,
       car_nome Descricao_Cargo,
       Occ_descricao Ocupacao_Atuacao,
       emp_sfu_codigo
from cadastros,
     cargos,
     ocupacoes_cargo,
     dependencias dep,
     (select dep_codigo,
             dep_sigla
      from dependencias
      connect by prior dep_codigo = dep_dep_codigo
      start with to_char(dep_codigo)  = '1') subor,
     unidades_organizacionais,
     ocorrencias_empregados,
     tipos_ocorrencias
where emp_numero_matricula = oem_emp_numero_matricula
-- and   oem_data_inicio >= to_date('01092002','ddmmyyyy')
-- and   oem_data_inicio <= to_date('30092002','ddmmyyyy')
and ((oem_ofu_codigo            = ofu_codigo
      and   ofu_indicador_tipo  = 10
      and   ofu_codigo         != 264))
and   emp_qlp_car_codigo       = car_codigo(+)
and   emp_qlp_car_codigo_nivel = car_codigo_nivel(+)
and   emp_qlp_car_occ_codigo   = car_occ_codigo(+)
and   car_occ_codigo           = occ_codigo(+)
and   ((emp_dep_codigo_lotacao = dep.dep_codigo
        and  dep.dep_dep_codigo = subor.dep_codigo)
      or
      (emp_dep_codigo_lotacao = 1
       and emp_dep_codigo_lotacao = dep.dep_codigo
       and dep.dep_codigo = subor.dep_codigo))
and   emp_uor_codigo_lotacao = uor_codigo(+)
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/
