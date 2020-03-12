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
and   oco1.oem_ofu_codigo in(80,82,83,84,137,267,237)
and   oco1.oem_data_inicio
           in(select max(oco2.oem_data_inicio)
                from ocorrencias_empregados oco2
               where oco2.oem_emp_numero_matricula = oco1.oem_emp_numero_matricula
                 and oco2.oem_ofu_codigo in(80,82,83,84,137,267,237)
                 and   oco2.oem_data_inicio  < oco.oem_data_inicio
              )
and   oco1.oem_dep_codigo = dep_ant.dep_codigo(+)
and   oco.oem_emp_numero_matricula = oco10.oem_emp_numero_matricula
and   oco10.oem_ofu_codigo = 81
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

GRANT SELECT,UPDATE ON view_transferidos TO rh_perfil_99
/

-- End of DDL script for VIEW_TRANSFERIDOS
