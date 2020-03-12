CREATE OR REPLACE VIEW viw_cadastros (
   emp_numero_matricula,
   emp_data_nascimento,
   emp_fun_codigo,
   emp_data_admissao,
   emp_car_codigo_nivel,
   emp_nome,
   emp_nome_abreviado,
   emp_numero_celular,
   emp_ddd_celular,
   emp_oex_codigo_cedido,
   emp_oex_codigo_requisitado,
   emp_qlp_cargo,
   emp_dep_fisico_tipo,
   emp_dep_fisico_tipo_nome,
   emp_qlp_car_nivel,
   emp_qlp_car_ocupacao,
   emp_uor_sigla,
   emp_uor2_sigla,
   emp_uor2_lotacao,
   emp_uor3_sigla,
   emp_uor3_lotacao,
   emp_uor4_sigla,
   emp_uor4_lotacao,
   emp_qfu_funcao,
   emp_qfu_fun_codigo,
   emp_qfu_fun_codigo_acumula,
   emp_qfu_hfl_uor_cod_acum,
   emp_qfu_fun_codigo_substitui,
   emp_qfu_hfl_uor_cod_subst,
   emp_dep_lotacao,
   emp_dep_codigo_lotacao,
   emp_dep_lotacao_sigla,
   emp_dep_fisico,
   emp_dep_codigo_fisico,
   emp_dep_fisico_sigla,
   emp_uor_lotacao,
   emp_uor_codigo_lotacao,
   emp_status,
   emp_nome_guerra,
   emp_endereco_eletronico_mail,
   emp_efc_uff_voip_ddd,
   emp_efc_uff_fone_direto,
   emp_efc_uff_ramal,
   emp_efc_uff_fax )
AS
(SELECT emp_numero_matricula, emp_data_nascimento,
           cargos_confianca.fun_codigo AS emp_fun_codigo, emp_data_admissao,
           cargos.car_codigo_nivel AS emp_car_codigo_nivel, emp_nome,
           emp_nome_abreviado, emp_numero_celular, emp_ddd_celular,
           emp_oex_codigo_cedido, emp_oex_codigo_requisitado,
           cargos.car_nome AS emp_qlp_cargo,
           d.dep_tipo AS emp_dep_fisico_tipo,
           DECODE (d.dep_tipo,
                   1, 'SEDE',
                   2, 'SUPERINTENDÊNCIA',
                   3, 'AEROPORTO',
                   4, 'GTA',
                   5, 'COORDENAÇÃO DE NEGÓCIO',
                   6, 'GNA',
                   7, 'UNA',
                   8, 'CONVÊNIOS COM RESSARCIMENTO',
                   9, 'CONVÊNIOS SEM RESSARCIMENTO',
                   10, 'DEPENDÊNCIA GNA',
                   11, 'DEPENDÊNCIA UNA',
                   12, 'DEPENDÊNCIA DE DEPENDÊNCIA',
                   d.dep_tipo
                  ) AS emp_dep_fisico_tipo_nome,
           DECODE (emp_nsa_codigo_nivel,
                   1, 'OPERACIONAL',
                   2, 'TECNICO',
                   3, 'ESPECIALIZADO',
                   4, 'PLENO',
                   5, 'SENIOR',
                   'SEM NIVEL'
                  ) AS emp_qlp_car_nivel,
           occ.occ_descricao AS emp_qlp_car_ocupacao,
           uor.uor_sigla AS emp_uor_sigla, uor2.uor_sigla AS emp_uor2_sigla,
           uor2.uor_nome AS emp_uor2_lotacao,
           uor3.uor_sigla AS emp_uor3_sigla,
           uor3.uor_nome AS emp_uor3_lotacao,
           uor4.uor_sigla AS emp_uor4_sigla,
           uor4.uor_nome AS emp_uor4_lotacao,
           cargos_confianca.fun_nome AS emp_qfu_funcao, emp_qfu_fun_codigo,
           emp_qfu_fun_codigo_acumula, emp_qfu_hfl_uor_cod_acum,
           emp_qfu_fun_codigo_substitui, emp_qfu_hfl_uor_cod_subst,
           d.dep_nome AS emp_dep_lotacao, emp_dep_codigo_lotacao,
           d.dep_sigla AS emp_dep_lotacao_sigla, d.dep_nome AS emp_dep_fisico,
           emp_dep_codigo_fisico, d.dep_sigla AS emp_dep_fisico_sigla,
           uor.uor_nome AS emp_uor_lotacao, emp_uor_codigo_lotacao,
           DECODE (emp_status,
                   0, 'TEMPORARIAMENTE AFASTADO',
                   1, 'ATIVO',
                   2, 'DESLIGADO',
                   emp_status
                  ) AS emp_status,
           emp_nome_guerra, emp_endereco_eletronico_mail,
           (SELECT f.efc_uff_voip_ddd
              FROM empregado_fone_comercial f
             WHERE cadastros.emp_numero_matricula =
                           f.efc_emp_numero_matricula
               AND f.efc_uff_tipo = 1) AS emp_efc_uff_voip_ddd,
           (SELECT f.efc_uff_numero
              FROM empregado_fone_comercial f
             WHERE cadastros.emp_numero_matricula =
                        f.efc_emp_numero_matricula
               AND f.efc_uff_tipo = 1) AS emp_efc_uff_fone_direto,
           (SELECT f.efc_uff_numero
              FROM empregado_fone_comercial f
             WHERE cadastros.emp_numero_matricula =
                              f.efc_emp_numero_matricula
               AND f.efc_uff_tipo = 2) AS emp_efc_uff_ramal,
           (SELECT f.efc_uff_numero
              FROM empregado_fone_comercial f
             WHERE cadastros.emp_numero_matricula =
                                f.efc_emp_numero_matricula
               AND f.efc_uff_tipo = 3) AS emp_efc_uff_fax
      FROM cadastros,
           cargos,
           ocupacoes_cargo occ,
           dependencias d,
           dependencias d2,
           unidades_organizacionais uor,
           unidades_organizacionais uor2,
           unidades_organizacionais uor3,
           unidades_organizacionais uor4,
           quadro_funcoes,
           cargos_confianca
     WHERE cadastros.emp_status <> 2
       AND uor.uor_tipo_unidad_org <> 14
       AND cargos.car_codigo(+) = cadastros.emp_qlp_car_codigo
       AND cargos.car_codigo_nivel(+) = cadastros.emp_qlp_car_codigo_nivel
       AND cargos.car_occ_codigo(+) = cadastros.emp_qlp_car_occ_codigo
       AND occ.occ_codigo(+) = cargos.car_occ_codigo
       AND quadro_funcoes.qfu_fun_codigo(+) = cadastros.emp_qfu_fun_codigo
       AND quadro_funcoes.qfu_hfl_uor_codigo(+) =
                                              cadastros.emp_qfu_hfl_uor_codigo
       AND quadro_funcoes.qfu_hfl_data_vigencia(+) =
                                           cadastros.emp_qfu_hfl_data_vigencia
       AND cargos_confianca.fun_codigo(+) = cadastros.emp_qfu_fun_codigo
       AND d.dep_codigo(+) = cadastros.emp_dep_codigo_lotacao
       AND d2.dep_codigo(+) = cadastros.emp_dep_codigo_fisico
       AND uor.uor_codigo(+) = cadastros.emp_uor_codigo_lotacao
       AND uor2.uor_codigo(+) = uor.uor_uor_codigo
       AND uor3.uor_codigo(+) = uor2.uor_uor_codigo
       AND uor4.uor_codigo(+) = uor3.uor_uor_codigo
       AND cadastros.emp_numero_matricula <> 831828
       AND cadastros.emp_numero_matricula <> 4914602
       AND cadastros.emp_numero_matricula <> 9773268)
/

-- Grants for View
GRANT SELECT ON viw_cadastros TO agenda_des
/

-- End of DDL Script for View IFRAGENDA.VIW_CADASTROS

