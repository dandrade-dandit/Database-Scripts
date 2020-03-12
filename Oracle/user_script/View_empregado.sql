CREATE OR REPLACE VIEW DBA_INFRAERO.EMPREGADOS_INFRAERO
 (
 EMP_NUMERO_MATRICULA, EMP_NOME_ABREVIADO, EMP_INDICADOR_SEXO, EMP_QLP_CAR_CODIGO, 
CAR_SIGLA, CAR_NOME, EMP_QLP_CAR_OCC_CODIGO, OCC_DESCRICAO, EMP_QLP_CAR_CODIGO_NIVEL, 
EMP_NSA_CODIGO_PADRAO, EMP_NSA_CODIGO_NIVEL, EMP_QFU_FUN_CODIGO, FUN_DESCRICAO, 
CFU_NOME, EMP_DEP_CODIGO_LOTACAO, DEP_SIGLA, DEP_NOME, EMP_DEP_CODIGO_FISICO, 
EMP_UOR_CODIGO_LOTACAO, UOR_SIGLA, EMP_NU_CARTEIRA_IDENTIDADE, EMP_SIGLA_ORGAO_EMITENTE_CI, 
EMP_NUMERO_CPF, EMP_ATI_CT_CUSTOS, EMP_ABA_BAN_CODIGO_CTA_PGTO, EMP_ABA_CODIGO_CONTA_PGTO, 
EMP_NU_CONTA_CORRENTE_PAGTO, EMP_TIPO_CONTA, CFU_VLD_CODIGO
 )
 AS 
select a.emp_numero_matricula,
       a.emp_nome_abreviado,
       a.emp_indicador_sexo,
       a.emp_qlp_car_codigo,
       b.car_sigla,
       b.car_nome,
       a.emp_qlp_car_occ_codigo,
       c.occ_descricao,
       a.emp_qlp_car_codigo_nivel,
       a.emp_nsa_codigo_padrao,
       a.emp_nsa_codigo_nivel,
       a.emp_qfu_fun_codigo,
       d.fun_descricao,
       e.cfu_nome,
       a.emp_dep_codigo_lotacao,
       g.dep_sigla,
       g.dep_nome,
       a.emp_dep_codigo_fisico,
       a.emp_uor_codigo_lotacao,
       f.uor_sigla,
       a.emp_nu_carteira_identidade,
       a.emp_sigla_orgao_emitente_ci,
       a.emp_numero_cpf,
       a.emp_ati_ct_custos,
       a.emp_aba_ban_codigo_cta_pgto,
       a.emp_aba_codigo_conta_pgto,
       a.emp_nu_conta_corrente_pagto,
       a.emp_tipo_conta,
       e.cfu_vld_codigo
   from cadastros a,
        cargos b,
        ocupacoes_cargo c,
        cargos_confianca d,
        categorias_funcoes e,
        unidades_organizacionais f,
        dependencias g
where a.emp_status = 1
and   a.emp_dep_codigo_lotacao     = g.dep_codigo
and   a.emp_uor_codigo_lotacao     = f.uor_codigo
and   a.emp_qfu_fun_codigo         = d.fun_codigo(+)
and   d.fun_cfu_codigo             = e.cfu_codigo(+)
and   a.emp_qlp_car_codigo         = b.car_codigo(+)
and   a.emp_qlp_car_occ_codigo     = b.car_occ_codigo(+)
and   a.emp_qlp_car_occ_codigo     = c.occ_codigo(+)
and   a.emp_qlp_car_codigo_nivel   = b.car_codigo_nivel(+)
/
