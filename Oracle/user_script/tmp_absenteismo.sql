CREATE OR REPLACE
Procedure CARREGAR_TMP_ABSENTEISMO
   (p_usuario       IN VARCHAR2,
    p_dsp_cod_cn    IN DEPENDENCIAS.dep_codigo%TYPE,
    p_dsp_cod_dep   IN DEPENDENCIAS.dep_codigo%TYPE,
    p_data_inicio   IN DATE,
    p_data_fim      IN DATE,
    p_flg_23       IN VARCHAR2,
    p_flg_24       IN VARCHAR2,
    p_flg_25       IN VARCHAR2,
    p_flg_46       IN VARCHAR2,
    p_flg_124      IN VARCHAR2
   )
   IS
--
-- Este procedimento carrega a tabela TMP_ABSENTEISMO
  CURSOR c_abs IS
    select uor_dep.Dep_Lot_epoca_f           Dep_Lot_epoca,
           dep3.dep_sigla                    Dep_Lot_atual,
           dep2.dep_sigla                    Dep_fis_atual,
           emp.emp_numero_matricula          matricula,
           emp.emp_nome                      nome,
           emp.emp_indicador_sexo            Sexo,
           oem.oem_ofu_codigo                Ocorrencia,
           ofu.ofu_descricao                 Descrição,
           oem.oem_data_inicio               Data_Inicio,
           oem.oem_data_termino              Data_Término,
           uor_dep.uor_epoca_f               UOR_Epoca,
           uor_dep.subord_f                  Subord,
           oem.oem_tipo_expediente           Tipo_exp,
           oem.oem_esc_cid_codigo            cid_codigo,
           oem.oem_ofu_codigo                ofu_codigo
      from ocorrencias_empregados oem,
           cadastros emp,
           tipos_ocorrencias ofu,
           dependencias dep2,
           dependencias dep3,
           (select emp.emp_numero_matricula Matricula_f,
                   dep1.dep_sigla Dep_Lot_epoca_f,
                   uor.uor_epoca uor_epoca_f,
                   uor.subord subord_f
              from ocorrencias_frequencia_emp ofe,
                   hst_dependencia_empregado hde,
                   cadastros emp,
                   tipos_ocorrencias ofu,
                   dependencias dep1,
                   (select oem.oem_emp_numero_matricula,
                           min(oem.oem_data_inicio)   dt_inicio,
                           min(oem.oem_data_termino)  dt_fim,
                           min( ltrim(uor.uor_sigla)) UOR_Epoca,
                           min(ltrim(uor_sub.uor_sigla)) Subord
                      from ocorrencias_empregados oem,
                           unidades_organizacionais uor,
                           unidades_organizacionais uor_sub
                     where (oem.oem_ofu_codigo  = 81 or oem.oem_ofu_codigo  = 137)
                      and uor.uor_codigo = oem.oem_uor_codigo
                      and uor_sub.uor_codigo(+) = uor.uor_uor_codigo
                      and to_char(oem.oem_dep_codigo) like nvl(ltrim(to_char(p_dsp_cod_dep)),'%')
                   group by oem.oem_emp_numero_matricula
                   ) uor
              where emp.emp_numero_matricula = uor.oem_emp_numero_matricula
                and ofe.ofe_ofu_codigo = ofu.ofu_codigo
                and ofe.ofe_emp_numero_matricula = hde.hde_emp_numero_matricula
                and ofe.ofe_data_inicio <=
                        LAST_DAY(to_date(to_char(p_data_fim,'dd/mm/yyyy'),'dd/mm/yyyy'))
                and ( (ofe.ofe_data_termino IS NULL) or
                    (ofe.ofe_data_termino >=
                        to_date(to_char(p_data_inicio,'dd/mm/yyyy'),'dd/mm/yyyy')) )
                and ofe.ofe_emp_numero_matricula not in
                        (select oem_emp_numero_matricula
                           from ocorrencias_empregados
                          where oem_ofu_codigo in (249,250,254,251,253,203,135,136)
                            and (oem_data_inicio <=
                                  ofe.ofe_data_termino or (ofe.ofe_data_termino IS NULL)
                                )
                            and ((oem_data_termino IS NULL)
                                    or (oem_data_termino >= ofe.ofe_data_inicio))
                         )
                and ofe.ofe_emp_numero_matricula not in
                         (select ofe2.ofe_emp_numero_matricula
                            from ocorrencias_frequencia_emp ofe2
                           where ofe2.ofe_ofu_codigo =258 and ofe.ofe_ofu_codigo=51
                             and ofe2.ofe_data_inicio = ofe.ofe_data_inicio
                             and ofe_data_termino = ofe.ofe_data_termino
                         )
                and hde.hde_mes_referencia = to_number(to_char(ofe.ofe_data_inicio,'mm'))
                and hde.hde_ano_referencia = to_number(to_char(ofe.ofe_data_inicio,'yyyy'))
                and ofe.ofe_emp_numero_matricula  = emp.emp_numero_matricula
                and hde.hde_dep_codigo            = dep1.dep_codigo
                and to_char(hde.hde_dep_codigo) like nvl(ltrim(to_char(p_dsp_cod_dep)),'%')
                and (ofe.ofe_tipo_expediente is null or ofe.ofe_tipo_expediente=3)
           group by emp.emp_numero_matricula,
                    dep1.dep_sigla,
                    uor.uor_epoca,
                    uor.subord
          ) uor_dep
     where emp.emp_dep_codigo_lotacao in
                  (select dep_codigo
                     from dependencias
                    where to_char(dep_codigo) like nvl(ltrim(to_char(p_dsp_cod_dep)),'%')
                  connect by prior dep_codigo = dep_dep_codigo
                    start with to_char(dep_codigo) like
                        nvl(ltrim(to_char(p_dsp_cod_dep)),
                                   nvl(ltrim(to_char(p_dsp_cod_cn)),'1'))
                   )
       and oem.oem_ofu_codigo in
                  (select tc.ofu_codigo
                     from tipos_ocorrencias tc
                    where (p_flg_23   = 'S' and  tc.ofu_codigo = 23 ) or
                          (p_flg_24   = 'S' and  tc.ofu_codigo = 24 )   or
                          (p_flg_25   = 'S' and  tc.ofu_codigo = 25 )   or
                          (p_flg_46   = 'S' and  tc.ofu_codigo = 46 )   or
                          (p_flg_124  = 'S' and  tc.ofu_codigo = 124)
                   )
       and oem.oem_data_inicio <=
               LAST_DAY(to_date(to_char(p_data_fim,'dd/mm/yyyy'),'dd/mm/yyyy'))
       and ((oem.oem_data_termino IS NULL) or (oem.oem_data_termino >=
               to_date(to_char(p_data_inicio,'dd/mm/yyyy'),'dd/mm/yyyy'))
            )
       and oem.oem_ofu_codigo = ofu.ofu_codigo
       and emp.emp_numero_matricula = uor_dep.matricula_f
       and oem.oem_emp_numero_matricula         = emp.emp_numero_matricula
       and emp.emp_dep_codigo_lotacao           = dep3.dep_codigo
       and emp.emp_dep_codigo_fisico            = dep2.dep_codigo;

   -- declaracão de variables
   r_dep                    c_abs%rowtype;

   --
BEGIN
  open c_abs;
  loop
    fetch c_abs into r_dep;
    exit when c_abs%notfound;
    --
    INSERT INTO TMP_ABSENTEISMO
         (
          Usuario,
          Dep_Lot_epoca,
          Dep_Lot_atual,
          Dep_fis_atual,
          Matricula,
          Nome,
          Sexo,
          Ocorrencia,
          Descrição,
          Data_Inicio,
          Data_Termino,
          UOR_Epoca,
          Subord,
          Tipo_exp,
          cid_codigo,
          ofu_codigo
         )
       VALUES
         (
          p_usuario,
          r_dep.Dep_Lot_epoca,
          r_dep.Dep_Lot_atual,
          r_dep.Dep_fis_atual,
          r_dep.matricula,
          r_dep.nome,
          r_dep.Sexo,
          r_dep.Ocorrencia,
          r_dep.Descrição,
          r_dep.Data_Inicio,
          r_dep.Data_Término,
          r_dep.UOR_Epoca,
          r_dep.Subord,
          r_dep.Tipo_exp,
          r_dep.cid_codigo,
          r_dep.ofu_codigo
         );
  --
  end loop;
  close c_abs;
  --
  commit;
  --
END; --
/
