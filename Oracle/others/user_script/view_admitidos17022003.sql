
-- View VIEW_ADMITIDOS

CREATE OR REPLACE VIEW view_admitidos (
   codigo_superintendencia,
   sigla_superintendencia,
   codigo_dependencia,
   sigla_dependencia,
   codigo_uor,
   uor_sigla,
   matricula,
   nome,
   nome_abreviado,
   status,
   numero_cpf,
   admissao,
   pis_pasep,
   sigla_cargo,
   descriÇÃo_sigla,
   ocupacao_atuacao,
   nÍvel,
   codigo_funcao,
   funcao_nome )
AS
select subor.dep_codigo codigo_Superintendencia,
       subor.dep_sigla Sigla_Superintendencia,
       dep.dep_codigo codigo_Dependencia,
       dep.dep_sigla Sigla_Dependencia,
       uor_codigo codigo_UOR,
       uor_sigla uor_Sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_status,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       emp_numero_pis_pasep Pis_Pasep,
       car_sigla sigla_Cargo,
       car_nome Descrição_sigla,
       Occ_descricao Ocupacao_Atuacao,
       decode(car_codigo_nivel,1,'Operacional',2,'Técnico',3,'Especializado',4,'Pleno',5,'Sênior',6,' ',7,'Sem Nível') Nível,
       emp_qfu_fun_codigo codigo_Funcao,
       fun_nome funcao_Nome
from cadastros,
     cargos,
     ocupacoes_cargo,
     cargos_confianca,
     dependencias dep,
     (select dep_codigo,
             dep_sigla
      from dependencias
      where dep_data_extincao is null
      connect by prior dep_codigo = dep_dep_codigo
      start with to_char(dep_codigo)  = '1') subor,
     unidades_organizacionais
where --emp_status != 2
-- and   emp_data_admissao       <= to_date('30092002','ddmmyyyy')
-- and emp_data_admissao       >= to_date('03102002','ddmmyyyy')
--and
emp_sfu_codigo in(1,2)
and   emp_qlp_car_codigo       = car_codigo(+)
and   emp_qlp_car_codigo_nivel = car_codigo_nivel(+)
and   emp_qlp_car_occ_codigo   = car_occ_codigo(+)
and   car_occ_codigo           = occ_codigo(+)
and   ((emp_dep_codigo_lotacao  = dep.dep_codigo
        and  dep.dep_dep_codigo = subor.dep_codigo)
      or
      (emp_dep_codigo_lotacao = 1
       and emp_dep_codigo_lotacao = dep.dep_codigo
       and dep.dep_codigo         = subor.dep_codigo))
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_qfu_fun_codigo     = fun_codigo(+)
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/

-- End of DDL script for VIEW_ADMITIDOS
