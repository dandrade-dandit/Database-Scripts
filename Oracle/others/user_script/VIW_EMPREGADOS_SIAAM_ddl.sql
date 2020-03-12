CREATE OR REPLACE VIEW viw_empregados_siaam (
   emp_numero_matricula,
   emp_nome,
   uor_codigo,
   lotacao,
   cod_dependencia,
   sigla_dependencia,
   emp_data_nascimento,
   nacionalidade,
   emp_numero_cpf,
   identidade,
   emp_endereco_logradouro,
   emp_endereco_numero_cep,
   emp_endereco_bairro,
   mun_descricao,
   mun_codigo,
   emp_ufe_sigla_residente,
   emp_endereco_eletronico_mail,
   car_nome,
   fun_codigo,
   emp_endereco_fone,
   emp_indicador_sexo,
   emp_ocl_sigla )
AS
select emp_numero_matricula,
       emp_nome,
       emp_uor_codigo_lotacao uor_codigo,
       uor_sigla lotacao,
       uor_dep_codigo cod_dependencia,
       dep_sigla      sigla_dependencia,
       emp_data_nascimento,
       decode(emp_nacionalidade, 1, 'Brasileira',
                                 2, 'Naturalizado/Brasileiro',
                                 3, 'Estrangeiro') nacionalidade  ,
       lpad(emp_numero_cpf,11,'0') emp_numero_cpf,
       emp_nu_carteira_identidade || ' ' ||
       emp_sigla_orgao_emitente_ci||'/'||emp_ufe_sigla_ci identidade,
       emp_endereco_Logradouro,
       emp_endereco_numero_cep,
       emp_endereco_bairro,
       mun_descricao,
       mun_codigo,
       emp_ufe_sigla_residente,
       emp_endereco_eletronico_mail,
       car.car_nome,
       emp_qfu_fun_codigo,
       emp_endereco_fone,
       emp_indicador_sexo,
       emp_ocl_sigla
from   empregados emp,
       unidades_organizacionais uor,
       dependencias dep,
       municipios mun,
       cargos car
where  emp.emp_status <> 2
and    emp.emp_uor_codigo_lotacao = uor.uor_codigo
and    uor.uor_dep_codigo = dep.dep_codigo
and    emp_mun_codigo_reside = mun.mun_codigo
and    emp.emp_ufe_sigla_residente = mun.mun_ufe_sigla
and    emp.emp_qlp_car_codigo = car.car_codigo
and    emp.emp_qlp_car_codigo_nivel = car.car_codigo_nivel
and    emp.emp_qlp_car_occ_codigo = car.car_occ_codigo
/

-- Grants for View
GRANT SELECT ON viw_empregados_siaam TO rh_perfil_99
/

-- End of DDL Script for View IFRSRH.VIW_EMPREGADOS_SIAAM

