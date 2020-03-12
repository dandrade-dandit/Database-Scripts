create or replace PACKAGE PK_VIAGENS  IS
 function aprovador( p_dep_codigo number,
                     p_uor_codigo number,
                     p_emp_qfu_fun_codigo number := 0,
                     p_avi_ofu_codigo number,
                     p_via_data_inicio date,
                     p_via_data_termino date) return number;
 function aprovador_delegado(p_uor_codigo number,
                             p_avi_ofu_codigo number,
                             p_via_data_inicio date,
                             p_via_data_termino date) return number;
 function superior_uor(p_uor_codigo number) return number;
 function diaria_padrao(p_emp_nsa_codigo_nivel number,
                        p_emp_nsa_codigo_padrao varchar2,
                        p_cfu_vld_codigo number,
                        p_emp_qfu_fun_codigo number,
                        p_acompanhante number := 0) return number;
 function diaria_substituicao(p_emp_numero_matricula number,
                              p_via_data_inicio date,
                              p_via_data_termino date) return number;
 function chefe_imediato(p_emp_uor_codigo_lotacao number,
                         p_emp_numero_matricula number,
                         p_via_data_inicio date,
                         p_via_data_termino date) return number;
 function chefe_imediato_subst(p_emp_uor_codigo_lotacao number,
                               p_emp_numero_matricula number,
                               p_via_data_inicio date,
                               p_via_data_termino date,
                               p_subst number) return number;
 function substituicao(p_emp_numero_matricula number,
                       p_via_data_inicio date,
                       p_via_data_termino date) return number;
 function nomeacao_aeroporto(p_dep_codigo number,
                             p_via_data_inicio date,
                             p_via_data_termino date) return number;
 pragma restrict_references(aprovador, WNDS, WNPS, RNPS);
 pragma restrict_references(aprovador_delegado, WNDS, WNPS, RNPS);
 pragma restrict_references(superior_uor, WNDS, WNPS, RNPS);
 pragma restrict_references(diaria_padrao, WNDS, WNPS, RNPS);
 pragma restrict_references(diaria_substituicao, WNDS, WNPS, RNPS);
 pragma restrict_references(chefe_imediato, WNDS, WNPS, RNPS);
 pragma restrict_references(chefe_imediato_subst, WNDS, WNPS, RNPS);
 pragma restrict_references(substituicao, WNDS, WNPS, RNPS);
 pragma restrict_references(nomeacao_aeroporto, WNDS, WNPS, RNPS);
END;
/
