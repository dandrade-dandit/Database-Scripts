CREATE OR REPLACE procedure ifrsrh.atualiza_dependencia_usuario is
-- verificar se o empregado tem a dependência física diferente da dependência de lotação
-- caso haja, inserir registro na tabela controle_usuario_dependencia para que não tenha problema de acesso, principalmente no contra-cheque e Informe de rendimentos
-- será inserido registro somente para o sistema 13 (INFRANET). Para os demais sistemas, ainda não se tem permissão para realizar tal operação.

V_teste_dep_fisica   number(1);
V_teste_dep_lotacao  number(1);
V_flag_ind_dep_freq  varchar2(1) := 'N';
V_in_dep_principal   varchar2(1) := 'S';
V_matr_login         varchar2(10);

begin
     for reg in (select emp_numero_matricula,
                        emp_nome,
                        emp_dep_codigo_fisico,
                        emp_dep_codigo_lotacao
                 from   cadastros
                 where  emp_dep_codigo_fisico <> emp_dep_codigo_lotacao
                 and    emp_status <> 2)
     loop
       v_matr_login := 'I'||lpad(reg.emp_numero_matricula,7,'0');

       -- verificar os campos FLAG_IND_DEP_FREQUENCIA e IN_DEP_PRINCIPAL
       -- caso haja nenhum registro ou mais de um, assumir como valores 'N' e 'S' respectivamente
       -- verificar se já existe o registro para a dependência física

       begin
         select distinct flag_ind_dep_frequencia,
                in_dep_principal
         into   v_flag_ind_dep_freq,
                v_in_dep_principal
         from   controle_usuario_dependencia
         where  sgu_id_usuario  = v_matr_login
         and    ssi_cd_sistema  = 13;
       exception
         when others then
            v_flag_ind_dep_freq := 'N';
            v_in_dep_principal  := 'S';
       end;

       begin
         select 1
         into   v_teste_dep_fisica
         from   controle_usuario_dependencia
         where  sgu_id_usuario      = v_matr_login
         and    ssi_cd_sistema      = 13  -- INFRANET
         and    dep_cd_dependencia  = reg.emp_dep_codigo_fisico;
       exception
         when no_data_found then
           begin
             insert into controle_usuario_dependencia
             values (v_matr_login, 
                     reg.emp_dep_codigo_fisico,
                     v_flag_ind_dep_freq,
                     13,
                     v_in_dep_principal);
           exception
             when others then
               null;
           end;
       end;

        -- verificar se já existe o registro para a dependência de lotação

       begin
         select 1
         into   v_teste_dep_lotacao
         from   controle_usuario_dependencia
         where  sgu_id_usuario      = v_matr_login
         and    ssi_cd_sistema      = 13  -- INFRANET
         and    dep_cd_dependencia  = reg.emp_dep_codigo_lotacao;
       exception
         when no_data_found then
           begin
             insert into controle_usuario_dependencia
             values (v_matr_login, 
                     reg.emp_dep_codigo_lotacao,
                     v_flag_ind_dep_freq,
                     13,
                     v_in_dep_principal);
           exception
             when others then
               null;
           end;
       end; 
    end loop;
end;
/

-- Grants for Procedure
GRANT EXECUTE ON ifrsrh.atualiza_dependencia_usuario TO rh_perfil_99
/


-- End of DDL Script for Procedure IFRSRH.ATUALIZA_DEPENDENCIA_USUARIO

