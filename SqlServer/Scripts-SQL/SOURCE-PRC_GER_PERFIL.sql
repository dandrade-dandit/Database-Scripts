/*
     
--Para grant e revoke de perfil
exec prc_ger_perfil (pPermissao number, pRole varchar, pTipoUsuario in varchar2, pMatriculaUsuario varchar2, pMatriculaGestor varchar2)
      pPermissao = 0 para REVOKE e 1 para GRANT;
      pRole = Perfil a ser concedido;
      pTipoUsuario = 'I' para INFRAERO; 'E' para ESTAGIÁRIO;e 'T' para TERCEIROS;
      pMatriculaUsuario = Matricula do usuário que receberá o perfil;
      pMatriculaGestor = Matricula do usuário gesrtor que receberá um email com a inclusão do usuário no perfil (opicional). Para não enviar o email informe 'D';
      
--PRIVILEGIOS
GRANT EXECUTE ON ifrsrh.fun_gera_senha TO IFRCORP WITH GRANT OPTION;
GRANT EXECUTE ON ifrsrh.envia_email TO IFRCORP WITH GRANT OPTION;
GRANT SELECT ON IFRSRH.CADASTROS  TO IFRCORP WITH GRANT OPTION;
GRANT SELECT ON IFRAGENDA.TERCEIROS TO IFRCORP WITH GRANT OPTION;
GRANT SELECT ON ifrsrh_estagiario.CAD_ESTAGIARIO TO IFRCORP WITH GRANT OPTION;
GRANT SELECT ON ifrsrh_estagiario.CAD_ESTAGIARIO_PESSOAL TO IFRCORP WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON ifrsrh.log_retorna_senha TO IFRCORP WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON ifrsrh.log_altera_perfil TO IFRCORP WITH GRANT OPTION;
GRANT drop user, create user, alter user, grant any role TO IFRCORP;
GRANT CREATE SESSION TO IFRCORP WITH ADMIN OPTION;
grant select on dba_users to IFRCORP WITH GRANT OPTION;
grant select on dba_role_privs to IFRCORP WITH GRANT OPTION;
grant select on dba_roles to IFRCORP WITH GRANT OPTION;


--testes

--grant
exec ifrcorp.prc_ger_perfil (1, 'RH_PERFIL_99', 'I', 'I1190738', 'D');

--revoke
exec ifrcorp.prc_ger_perfil (0, 'RH_PERFIL_99', 'I', 'I1190738', 'D');


--grant
exec ifrcorp.prc_ger_perfil (1, 'DBA', 'I', 'I1190738', 'D');

--revoke
exec ifrcorp.prc_ger_perfil (0, 'srh_consulta', 'I', 'I1190738', 'D');

--GRANT PARA A ROLE DE SISTEMA...
GRANT EXECUTE ON prc_ger_perfil TO ROL_IDM_ADMIN;

--alter table de log
alter table IFRSRH.LOG_ALTERA_PERFIL modify DSC_USUARIO_BD varchar2(20);
*/


CREATE OR REPLACE PROCEDURE ifrcorp.prc_ger_perfil (pPermissao number, pRole varchar, pTipoUsuario in varchar2, pMatriculaUsuario varchar2, pMatriculaGestor varchar2)
IS
   v_sql                    varchar2(100) := null;
   v_role                   varchar2(30)   := pRole;
   v_roleSistema            number(1)   := null;
   v_usuario                varchar2(13)   := pMatriculaUsuario;
   v_emp_numero_matricula   varchar2(13) := null;
   v_corpo_msg              varchar2(1500):= null;
   v_usr_solic              varchar2(100) := null;
   v_usr_maquina            varchar2(100) := null;
   v_EmailPara              varchar2(80) := null;

/*-----------------------------------------------------------------------------------
-- prc_ger_perfil                                                                  --
--                                                                                 --
-- Procedure utilizada para alterar perfil do usuário e enviar email ao gestor     --
-- do sistema                                                                      --
-- Autor: Ana Carina e Carlos Eduardo                                              --
-- Data: 04/07/2005                                                                --
-- Dependencias:  ifrsrh.envia_email     - PARA ENVIAR EMAIL PARA O GESTOR         --
--                ifrsrh.log_altera_perfil    - INSERE REGISTRO NA TABELA DE LOG   --
--                                                                                 --
-- Privilégios que o owner deve ter: (grant any role, grant de select na dba_roles)--
-- Sinônimo: create public synonym prc_ger_perfil for ifrsrh.prc_ger_perfil        --
--                                                                                 --
-- Usuário de conexão: create user usr_altera_perfil identified by infraero;       --
--                     grant create session to  usr_altera_perfil;                 --
--                     grant select on ifrsrh.cadastros to usr_altera_perfil;      --
--                     grant execute on prc_altera_perfil  to usr_altera_perfil;   --
-- Alterado: Denis Andrade do Nascimento                                           --
-- Data da Alteração: 05/07/2010                                                   --
----------------------------------------------------------------------------------*/
begin
    ----------------------------------------------------------------
    -- Verifica se a matricula do usuário existe na tabela Cadastros
    -- senão existir aborta a operação
    ----------------------------------------------------------------
    if (pTipoUsuario =  'I') then
        begin
            select  emp_numero_matricula 
            into    v_emp_numero_matricula
            from    cadastros
            where   emp_numero_matricula = to_number(substr(pMatriculaUsuario,2,9))
            and     emp_status <> 2; -- afastado e ativo
        exception
            when no_data_found then
                raise_application_error(-20000,'Não existe essa matrícula na tabela Cadastros ou o Empregado não está Ativo.');
        end;
    elsif (pTipoUsuario =  'T') then
        begin
            select ter_cpf
            into    v_emp_numero_matricula
            from terceiros
            where ter_cpf like substr(pMatriculaUsuario,2,9) || '%'
              and ter_status = 1; -- ativo
        exception
            when no_data_found then
                raise_application_error(-20000,'Não existe essa matrícula na tabela de Terceiros ou terceiro não está Ativo.');
        end;
    elsif (pTipoUsuario =  'E') then
        begin
            select num_cpf
            into    v_emp_numero_matricula
            from cad_estagiario_pessoal ep
               , cad_estagiario e
            where ep.seq_estagiario_pessoal = e.seq_estagiario_pessoal
            and e.flg_desligado = 'N'
            and lpad(num_cpf,11,'0') like substr(pMatriculaUsuario,2,9) || '%';
        exception
            when no_data_found then
                raise_application_error(-20000,'Não existe essa matrícula na tabela de Terceiros ou terceiro não está Ativo.');
        end;
    else
        raise_application_error(-20000,'Erro desconhecido, contactar o DBA.');
    end if;


    ----------------------------------------------------------------------------------------
    -- Recupera o usuário do Sistema Operacional e a maquina de onde partiu a operação
    ----------------------------------------------------------------------------------------
    select sys_context('USERENV','OS_USER') into v_usr_solic from dual;
    select sys_context('USERENV','TERMINAL') into v_usr_maquina from dual;

    ------------------------------------------------------------------------------
    -- Verifica se nao esta sendo dado privilegio em role do SGBD
    ------------------------------------------------------------------------------  
   begin
        select count(role)
        into v_RoleSistema
        from dba_roles
        where role in ('AQ_ADMINISTRATOR_ROLE','AQ_USER_ROLE','CONNECT','CTXAPP','DBA','DELETE_CATALOG_ROLE','EJBCLIENT',
        'EXECUTE_CATALOG_ROLE','EXP_FULL_DATABASE','GATHER_SYSTEM_STATISTICS','GLOBAL_AQ_USER_ROLE','HS_ADMIN_ROLE',
        'IMP_FULL_DATABASE','JAVA_ADMIN','JAVADEBUGPRIV','JAVA_DEPLOY','JAVAIDPRIV','JAVASYSPRIV','JAVAUSERPRIV',
        'RECOVERY_CATALOG_OWNER','RESOURCE','SELECT_CATALOG_ROLE', 'ROL_USU_SISTEMA')
        and role = pRole;--verifica se a role passada como parametro é igual a uma das roles do SGBD
        
        if v_RoleSistema > 0 then
            v_corpo_msg := 'O usuário '||v_usr_solic||' no computador ' || v_usr_maquina||' no dia '||to_char(sysdate, 'DD/MM/YYYY')
            ||' as '||to_char(sysdate,'HH24:MI:SS')||','||chr(13)||'tentou atribuir o perfil '||v_role||' para o usuário '||v_usuario||'.';        
            
            envia_email('Banco_de_dados','banco_de_dados@infraero.gov.br','Tentativa indevida de alteracao de perfil',v_corpo_msg);
            
            raise_application_error(-20000,'Perfil não permitido. O Banco de dados será notificado quanto a esta tentativa indevida.');
        end if;    
    end;    
    ------------------------------------------------------------------------------
    -- Da / retira permissão do usuário e Monta corpo da mensagem do email
    ------------------------------------------------------------------------------
    BEGIN
       --se permissão = 0
       if pPermissao = 0 then
          v_sql := 'REVOKE  '||v_role||' FROM '||v_usuario;
          v_corpo_msg := 'Conforme solicitacao realizada por '||v_usr_solic||' no computador '||v_usr_maquina||' em '||
            to_char(sysdate, 'DD/MM/YYYY')||' as '||to_char(sysdate,'HH24:MI:SS')||','||
            chr(13)||'foi RETIRADO o perfil '||v_role||' do usuário '||v_usuario||'.';  
       elsif pPermissao = 1 then
       --se permissão = 1
           v_sql := 'GRANT '||v_role||' TO '||v_usuario;
           v_corpo_msg := 'Conforme solicitacao realizada por '||v_usr_solic||' no computador '||v_usr_maquina||' em '||
            to_char(sysdate, 'DD/MM/YYYY')||' as '||to_char(sysdate,'HH24:MI:SS')||','||
            chr(13)||'foi CONCEDIDO o perfil '||v_role||' para o usuário '||v_usuario||'.';
       end if;      

       EXECUTE IMMEDIATE v_sql;
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20000, 'Erro ao conceder a role '||v_role||' ao usuário: '||v_usuario,true);
    END;

    if (pMatriculaGestor != 'D') then
        ----------------------------------------------------------------
        -- Recupera email do gestor
        ----------------------------------------------------------------
        begin
            select emp_endereco_eletronico_mail 
            into   v_EmailPara
            from   cadastros
            where emp_numero_matricula = to_number(substr(pMatriculaUsuario,2,9));
        exception
            when no_data_found then
                raise_application_error(-20000,'Matrícula do gestor do sistema está errada.');      
        end;
        
        ------------------------------------------------------------------------------
        -- Envia email para o gestor do sistema que teve o perfil delegado/retirado
        ------------------------------------------------------------------------------
        envia_email('Banco_de_dados',v_EmailPara,'Alteracao de Perfil',v_corpo_msg);
    end if;
    

    ----------------------------------------------------------------
    -- grava Informações na tabela de LOG
    ----------------------------------------------------------------
    begin
        insert into log_altera_perfil
        (DSC_USUARIO_BD,DSC_PERMISSAO,DSC_ROLE,DSC_USUARIO_SO,DAT_ALTERACAO)
        values
        (v_usuario,pPermissao,v_role,v_usr_solic,sysdate);

        commit;
    exception
        when  others then
            raise_application_error(-20000, 'Erro ao inserir registro na tabela de LOG.',true);
    end;

end;
/

