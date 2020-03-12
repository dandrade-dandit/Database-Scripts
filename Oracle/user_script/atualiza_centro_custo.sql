create or replace procedure atualiza_centro_custo is

    v_centro_custo number(6) := null;

begin
    v_centro_custo := null;
    begin
       select ind_valor
       into   v_centro_custo
       from   indices
       where  ind_data_fim is null
       and    ind_idx_sigla = 'CC';
    exception
       when no_data_found then
         null;
    end;
    for reg in (select emp.emp_numero_matricula matricula,
                       emp.emp_nome             nome,
                       emp.emp_status           status,
                       emp.emp_ati_ct_custos    centro_custo,
                       cc.data_criacao         dt_criacao,
                       cc.data_extincao        dt_extincao,
                       emb.emb_ben_sigla        beneficio,
                       emb.data_adesao          adesao,
                       emb.emb_data_exclusao    exclusao
                from   cadastros emp,
                       empregados_beneficios emb,
                       centro_custo cc
                where  emp.emp_status = 2
                and    to_number(substr(emp.emp_ati_ct_custos,1,5)) = cc.cd_centro_custo
                and    cc.data_extincao is not null
                and    to_number(substr(emp.emp_ati_ct_custos,1,5)) in (select to_number(cd_centro_custo)
                                                                        from   centro_custo
                                                                        where  data_extincao is not null)
                and    emb.emb_ben_sigla = 'MED'
                and    emb.emb_emp_numero_matricula = emp.emp_numero_matricula
                and    emb.emb_data_exclusao is null)
    loop
       begin
          update cadastros
          set    emp_ati_ct_custos = v_centro_custo
          where  emp_numero_matricula = reg.matricula;
       exception
          when others then
             dbms_output.put_line('Erro ao atualizar centro de custo: '||to_char(reg.matricula));
       end;
    end loop;
end;
