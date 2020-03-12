
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
   numero_cpf,
   admissao,
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
       emp_numero_cpf,
       emp_data_admissao Admissao,
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
where emp_status != 2
-- and   emp_data_admissao       <= to_date('30092002','ddmmyyyy')
-- and emp_data_admissao       >= to_date('03102002','ddmmyyyy')
and   emp_sfu_codigo in(1,2)
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

-- Grants for VIEW_ADMITIDOS

GRANT SELECT ON view_admitidos TO rh_perfil_99
/

-- End of DDL script for VIEW_ADMITIDOS

-- View VIEW_APOSENTADOS

CREATE OR REPLACE VIEW view_aposentados (
   codigo_superintendecia,
   sigla_superintendecia,
   codigo_dependencia,
   dep_sigla,
   uor_sigla,
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   admissao,
   data_afastamento,
   codigo_ocorrencia,
   data_inclusao,
   descricao_ocorrencia )
AS
select subor.dep_codigo codigo_Superintendecia,
       subor.dep_sigla Sigla_Superintendecia,
       dep.dep_codigo codigo_Dependencia,
       dep.dep_sigla dep_Sigla,
       uor_sigla UOR_sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       oem.oem_data_inicio Data_Afastamento,
       oem.oem_ofu_codigo codigo_Ocorrencia,
       oem.oem_data_inclusao Data_Inclusao,
       ofu_descricao Descricao_Ocorrencia
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
     ocorrencias_empregados oem,
     tipos_ocorrencias
where emp_numero_matricula = oem.oem_emp_numero_matricula
-- and   oem.oem_data_inclusao >= to_date('01122002','ddmmyyyy')
-- and   oem.oem_data_inclusao <= to_date('31122002','ddmmyyyy')
and   oem.oem_ofu_codigo = 113
and   oem.oem_ofu_codigo = ofu_codigo
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
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/

-- Grants for VIEW_APOSENTADOS

GRANT SELECT ON view_aposentados TO rh_perfil_99
/

-- End of DDL script for VIEW_APOSENTADOS


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
   descricao_funcao )
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
       fun_nome Descricao_Funcao
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
     funcoes
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
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/

-- Grants for VIEW_ATIVOS

GRANT SELECT ON view_ativos TO rh_perfil_99
/

-- End of DDL script for VIEW_ATIVOS

-- View VIEW_CEDIDOS

CREATE OR REPLACE VIEW view_cedidos (
   codigo_dependencia,
   dep_sigla,
   uor_sigla,
   descricao_uor,
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   data_inicio,
   data_termino,
   codigo_ocorrencia,
   descricao_ocorrencia )
AS
select dep_codigo codigo_Dependencia,
       dep_sigla dep_Sigla,
       uor_sigla UOR_sigla,
       uor_nome Descricao_UOR,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       oem_data_inicio Data_Inicio,
       oem_data_termino Data_Termino,
       oem_ofu_codigo codigo_Ocorrencia,
       ofu_descricao Descricao_Ocorrencia
from cadastros,
     ocorrencias_empregados,
     tipos_ocorrencias,
     unidades_organizacionais,
     dependencias
where emp_status != 2
and   emp_numero_matricula   = oem_emp_numero_matricula
and   oem_ofu_codigo        in(135,136,203,249,250,251,253,254)
and   (oem_data_termino is null
       or  oem_data_termino > sysdate)
and   oem_ofu_codigo         = ofu_codigo
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_dep_codigo_lotacao = dep_codigo(+)
order by dep_sigla,
         uor_sigla,
         emp_nome
/

-- Grants for VIEW_CEDIDOS

GRANT SELECT ON view_cedidos TO rh_perfil_99
/
-- End of DDL script for VIEW_CEDIDOS

-- View VIEW_DEMITIDOS

CREATE OR REPLACE VIEW view_demitidos (
   codigo_superintendecia,
   sigla_superintendecia,
   codigo_dependencia,
   dep_sigla,
   codigo_uor,
   uor_sigla,
   matrÍcula,
   nome,
   nome_abreviado,
   numero_cpf,
   admissao,
   demissao,
   ofu_descricao,
   sigla_cargo,
   descricao_cargo,
   ocupacao_atuacao )
AS
select subor.dep_codigo codigo_Superintendecia,
       subor.dep_sigla Sigla_Superintendecia,
       dep.dep_codigo codigo_Dependencia,
       dep.dep_sigla Dep_Sigla,
       uor_codigo codigo_UOR,
       uor_sigla UOR_Sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       oem_data_inicio Demissao,
       ofu_descricao,
       car_sigla sigla_Cargo,
       car_nome Descricao_Cargo,
       Occ_descricao Ocupacao_Atuacao
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

-- Grants for VIEW_DEMITIDOS

GRANT SELECT ON view_demitidos TO rh_perfil_99
/
-- End of DDL script for VIEW_DEMITIDOS

-- View VIEW_REINTEGRADOS

CREATE OR REPLACE VIEW view_reintegrados (
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
   reintegracao,
   desligamento,
   codigo_reintegracao,
   descricao_reintegracao,
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
   descricao_funcao )
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
       reinteg.data_ocorrencia_inicio Reintegracao,
       reinteg.data_ocorrencia_termino Desligamento,
       reinteg.ofu_codigo codigo_reintegracao,
       reinteg.ofu_descricao descricao_reintegracao,
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
       fun_nome Descricao_Funcao
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
     (SELECT OEM_EMP_NUMERO_MATRICULA matricula,
             OEM_DATA_INICIO DATA_OCORRENCIA_inicio,
             OEM_DATA_TERMINO DATA_OCORRENCIA_termino,
             OEM_OFU_CODIGO ofu_codigo,
             OFU_DESCRICAO
        FROM OCORRENCIAS_EMPREGADOS OE,
             TIPOS_OCORRENCIAS TIPOS
       WHERE TIPOS.OFU_CODIGO = OE.OEM_OFU_CODIGO
         AND OEM_OFU_CODIGO IN (142,201)
         AND EXISTS (SELECT 'S'
                       FROM OCORRENCIAS_EMPREGADOS OE2,
                            TIPOS_OCORRENCIAS
                      WHERE OFU_CODIGO = OE2.OEM_OFU_CODIGO
                        AND OFU_INDICADOR_TIPO = 10
                        AND OE2.OEM_EMP_NUMERO_MATRICULA =  OE.OEM_EMP_NUMERO_MATRICULA
                      )
       ORDER BY OEM_EMP_NUMERO_MATRICULA
      ) REINTEG
where emp_status != 2
and   emp_numero_matricula = reinteg.matricula
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
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/

-- Grants for VIEW_REINTEGRADOS

GRANT SELECT ON view_reintegrados TO rh_perfil_99
/
-- End of DDL script for VIEW_REINTEGRADOS

-- View VIEW_REQUISITADOS

CREATE OR REPLACE VIEW view_requisitados (
   codigo_dependencia,
   dep_sigla,
   codigo_uor,
   uor_sigla,
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   codigo_ocorrencia,
   descricao_ocorrencia,
   data_inicio,
   data_termino )
AS
select dep_codigo codigo_Dependencia,
       dep_sigla Dep_Sigla,
       uor_codigo codigo_UOR,
       uor_sigla UOR_Sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       oem_ofu_codigo codigo_Ocorrencia,
       ofu_descricao Descricao_Ocorrencia,
       oem_data_inicio Data_Inicio,
       oem_data_termino Data_Termino
from cadastros,
     ocorrencias_empregados,
     tipos_ocorrencias,
     unidades_organizacionais,
     dependencias
where emp_status != 2
and   emp_numero_matricula   = oem_emp_numero_matricula
and   oem_ofu_codigo         in(07,10,11,12)
and   oem_ofu_codigo         = ofu_codigo
-- and   oem_data_inicio        >= to_date('01092002','ddmmyyyy')
-- and   oem_data_inicio        <= to_date('30092002','ddmmyyyy')
and   (oem_data_termino is null
       or  oem_data_termino > sysdate)
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_dep_codigo_lotacao = dep_codigo(+)
order by dep_sigla,
         uor_sigla,
         emp_nome
/

-- Grants for VIEW_REQUISITADOS

GRANT SELECT ON view_requisitados TO rh_perfil_99
/

-- End of DDL script for VIEW_REQUISITADOS


-- View VIEW_SUB_JUDICE

CREATE OR REPLACE VIEW view_sub_judice (
   cod_superintendencia,
   sigla_superintendencia,
   cod_dependencia,
   dep_sigla,
   uor_sigla,
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   admissao,
   sigla_cargo,
   descricao_cargo,
   ocupacao_atuacao,
   data_inicio,
   data_termino,
   ofu_descricao )
AS
select subor.dep_codigo cod_Superintendencia,
       subor.dep_sigla Sigla_Superintendencia,
       dep.dep_codigo cod_Dependencia,
       dep.dep_sigla dep_Sigla,
       uor_sigla UOR_sigla,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       emp_data_admissao Admissao,
       car_sigla Sigla_Cargo,
       car_nome Descricao_cargo,
       Occ_descricao Ocupacao_Atuacao,
       oem_data_inicio Data_inicio,
       oem_data_termino Data_termino,
       ofu_descricao ofu_Descricao
from cadastros,
     cargos,
     ocupacoes_cargo,
     dependencias dep,
     (select dep_codigo,
             dep_sigla
      from dependencias
      where dep_data_extincao is null
      connect by prior dep_codigo = dep_dep_codigo
      start with to_char(dep_codigo)  = '1') subor,
     unidades_organizacionais,
     ocorrencias_empregados,
     tipos_ocorrencias
where emp_qlp_car_codigo       = car_codigo(+)
and   emp_qlp_car_codigo_nivel = car_codigo_nivel(+)
and   emp_qlp_car_occ_codigo   = car_occ_codigo(+)
and   car_occ_codigo = occ_codigo(+)
and   ((emp_dep_codigo_lotacao  = dep.dep_codigo
        and  dep.dep_dep_codigo = subor.dep_codigo)
      or
      (emp_dep_codigo_lotacao = 1
       and emp_dep_codigo_lotacao = dep.dep_codigo
       and dep.dep_codigo         = subor.dep_codigo))
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_numero_matricula   = oem_emp_numero_matricula
and   oem_ofu_codigo         = 18 -- contrato suspenso(sub-judice)
-- and   oem_data_inicio >= to_date('20082002','ddmmyyyy')
-- and   oem_data_inicio <= to_date('18072002','ddmmyyyy')
and   oem_ofu_codigo         = ofu_codigo
order by subor.dep_codigo,
         dep.dep_codigo,
         emp_nome
/

-- Grants for VIEW_SUB_JUDICE

GRANT SELECT ON view_sub_judice TO rh_perfil_99
/

-- End of DDL script for VIEW_SUB_JUDICE

-- View VIEW_TRANSFERIDOS

CREATE OR REPLACE VIEW view_transferidos (
   matricula,
   nome,
   nome_abreviado,
   numero_cpf,
   data_tranferencia,
   ofu_codigo,
   ofu_descricao,
   dep_ant,
   dep_atual,
   uor_ant,
   uor_atual,
   sigla_cargo,
   descricao_cargo,
   ocupacao_atuacao )
AS
select emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_numero_cpf,
       oco.oem_data_inicio Data_Tranferencia,
       oco.oem_ofu_codigo ofu_codigo,
       ofu_descricao OFU_Descricao,
       dep_ant.dep_sigla Dep_Ant,
       dep_oco.dep_sigla Dep_Atual,
       uor_ant.uor_sigla UOR_Ant,
       uor_oco.uor_sigla UOR_Atual,
       car_sigla sigla_Cargo,
       car_nome Descricao_Cargo,
       Occ_descricao Ocupacao_Atuacao
from cadastros,
     dependencias dep_oco,
     dependencias dep_ant,
     ocorrencias_empregados oco,
     ocorrencias_empregados oco1,
     ocorrencias_empregados oco10,
     tipos_ocorrencias tipo,
     unidades_organizacionais uor_oco,
     unidades_organizacionais uor_ant,
     cargos,
     ocupacoes_cargo
where emp_numero_matricula         = oco.oem_emp_numero_matricula
--and   oco.oem_data_inicio         >= to_date('01122002','ddmmyyyy')
--and   oco.oem_data_inicio         <= to_date('31122002','ddmmyyyy')
and   oco.oem_ofu_codigo           = tipo.ofu_codigo
and   tipo.ofu_indicador_tipo      = 5
and   oco.oem_dep_codigo           = dep_oco.dep_codigo(+)
and   oco.oem_uor_codigo           = uor_oco.uor_codigo(+)
and   oco.oem_emp_numero_matricula = oco1.oem_emp_numero_matricula
and   oco1.oem_ofu_codigo in(80,82,83,84,137,267)
and   oco1.oem_data_inicio
           in(select max(oco2.oem_data_inicio)
                from ocorrencias_empregados oco2
               where oco2.oem_emp_numero_matricula = oco1.oem_emp_numero_matricula
                 and oco2.oem_ofu_codigo in(80,82,83,84,137,267)
                 and   oco2.oem_data_inicio  < oco.oem_data_inicio
              )
and   oco1.oem_dep_codigo = dep_ant.dep_codigo(+)
and   oco.oem_emp_numero_matricula = oco10.oem_emp_numero_matricula
and   oco10.oem_ofu_codigo in(81,137)
and   oco10.oem_data_inicio
               in(select max(oco2.oem_data_inicio)
                    from ocorrencias_empregados oco2
                   where oco2.oem_emp_numero_matricula = oco10.oem_emp_numero_matricula
                     and oco2.oem_ofu_codigo in(81,137)
                     and oco2.oem_data_inicio  < oco.oem_data_inicio
                  )
and   oco10.oem_uor_codigo = uor_ant.uor_codigo(+)
and   emp_qlp_car_codigo = car_codigo(+)
and   emp_qlp_car_codigo_nivel = car_codigo_nivel(+)
and   emp_qlp_car_occ_codigo = car_occ_codigo(+)
and   car_occ_codigo = occ_codigo(+)
order by emp_numero_matricula
/

-- Grants for VIEW_TRANSFERIDOS

GRANT SELECT ON view_transferidos TO rh_perfil_99
/

-- End of DDL script for VIEW_TRANSFERIDOS
