delete plan_table
where statement_id ='Plano_Consulta'
/

commit
/

EXPLAIN PLAN
SET STATEMENT_ID = 'Plano_Consulta'
FOR     select
           dep3.dep_sigla                    Dep_Lot_atual,
           dep2.dep_sigla                    Dep_fis_atual,
           emp.emp_numero_matricula          matricula,
           emp.emp_nome                      nome,
           emp.emp_indicador_sexo            Sexo,
           oem.oem_ofu_codigo                Ocorrencia,
           ofu.ofu_descricao                 Descrição,
           oem.oem_data_inicio               Data_Inicio,
           oem.oem_data_termino              Data_Termino,
           oem.oem_tipo_expediente           Tipo_exp,
           oem.oem_esc_cid_codigo            CID_codigo,
           oem.oem_esc_eid_codigo            especificacao_CID,
           emp.emp_data_nascimento           data_nascimento,
           emp.emp_nu_carteira_identidade    nro_identidade,
           emp.emp_data_expedicao_CI         data_expedicao_CI,
           oem.oem_ofu_codigo                ofu_codigo,
           --
           car_sigla                         sigla_cargo_atual,
           Occ_descricao                     descricao_ocupacao_atual,
           fun_nome                          descricao_funcao_atual
           --
      from ocorrencias_empregados oem,
           cadastros emp,
           tipos_ocorrencias ofu,
           dependencias dep2,
           dependencias dep3,
           --
           cargos,
           ocupacoes_cargo,
           cargos_confianca
           --
     where emp.emp_dep_codigo_lotacao in
                  (select dep_codigo
                     from dependencias
                    where to_char(dep_codigo) like nvl(ltrim(to_char(1)),'%')
                  connect by prior dep_codigo = dep_dep_codigo
                    start with to_char(dep_codigo) like
                        nvl(ltrim(to_char(1)),
                                   nvl(ltrim(to_char(1)),'1'))
                   )
       and (
            (2002 = 2002 and oem.oem_ofu_codigo in (23,24,25,46,124))
             or
            (2002 = 2001 and oem.oem_ofu_codigo in (18,79,242,21,22,243,74,75,15,16,
                                                             17,127,143,144,23,24,25,32,124,
                                                             128,224,225,226,227,228,229,230,
                                                             231,232,
                                                             34,35,36,46,47,48,49,50,51,52,55,
                                                             58,60,61,63,151,156
                                                             )
             )
           )
       and oem.oem_emp_numero_matricula         = emp.emp_numero_matricula
       and emp.emp_dep_codigo_lotacao           = dep3.dep_codigo
       and emp.emp_dep_codigo_fisico            = dep2.dep_codigo
       and emp.emp_qlp_car_codigo         = car_codigo(+)
       and emp.emp_qlp_car_codigo_nivel   = car_codigo_nivel(+)
       and emp.emp_qlp_car_occ_codigo     = car_occ_codigo(+)
       and car_occ_codigo                 = occ_codigo(+)
       and emp.emp_qfu_fun_codigo         = fun_codigo(+)
       and oem.oem_ofu_codigo = ofu.ofu_codigo
       and (2002 = 2002 and
                (oem.oem_tipo_expediente is null or oem.oem_tipo_expediente = 3)
            or
             2002 = 2001
           )
       and oem.oem_data_inicio <=
                    LAST_DAY(to_date(to_char(TO_DATE('31/01/2004','DD/MM/YYYY'),
                                                      'dd/mm/yyyy'),'dd/mm/yyyy'))
       and ((oem.oem_data_termino IS NULL) or (oem.oem_data_termino >=
                    to_date(to_char(TO_DATE('01/01/2004','DD/MM/YYYY'),
                                                      'dd/mm/yyyy'),'dd/mm/yyyy'))
            )
     order by emp_numero_matricula
/

SELECT LPAD(' ',2*(LEVEL-1))||operation||' '||options
||' '||object_name
||' '||DECODE(id, 0, 'Cost = '||position) "Query Plan"
FROM plan_table
START WITH id = 0 AND statement_id = 'Plano_Consulta'
CONNECT BY PRIOR id = parent_id AND statement_id ='Plano_Consulta'
/
