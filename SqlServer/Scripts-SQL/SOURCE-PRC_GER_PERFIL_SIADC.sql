/*
     
--Para grant e revoke de perfil
exec ifrsiadc.prc_ger_perfil_siadc (pMatriculaUsuario varchar2, pPermissao number)
      pPermissao = 0 para REVOKE e 1 para GRANT;
      pMatriculaUsuario = Matricula do usuário que receberá o perfil com o 'I' na frente da matricula do usuário;
      
--PRIVILEGIOS
GRANT EXECUTE ON ifrsrh.envia_email TO ifrsiadc WITH GRANT OPTION;
GRANT SELECT ON IFRSRH.CADASTROS  TO ifrsiadc WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON ifrsrh.log_retorna_senha TO ifrsiadc WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON ifrsrh.log_altera_perfil TO ifrsiadc WITH GRANT OPTION;
GRANT drop user, create user, alter user, grant any role TO ifrsiadc;
GRANT CREATE SESSION TO ifrsiadc WITH ADMIN OPTION;
grant select on dba_users to ifrsiadc WITH GRANT OPTION;
grant select on dba_role_privs to ifrsiadc WITH GRANT OPTION;
grant select on dba_roles to ifrsiadc WITH GRANT OPTION;


--testes

--grant
exec prc_ger_perfil_siadc ('I1190738', 1);

--revoke
exec prc_ger_perfil_siadc ('I1190738', 0);


-create public synonym
  create public synonym prc_ger_perfil_siadc for ifrsiadc.prc_ger_perfil_siadc 
  
--grant para todos os usuários porem executar a procedures
  grant execute on prc_ger_perfil_siadc to SRH_WEB;  
*/


CREATE OR REPLACE PROCEDURE ifrsiadc.prc_ger_perfil_siadc (pMatriculaUsuario varchar2, pPermissao number)
IS
   v_sql                    varchar2(100) := null;
   v_role                   varchar2(30)   := 'ROL_SIADC_AVALIADOR';
   v_roleSistema            number(1)   := null;
   v_usuario                varchar2(13)   := pMatriculaUsuario;
   v_emp_numero_matricula   varchar2(13) := null;
   v_corpo_msg              varchar2(1500):= null;
   v_usr_solic              varchar2(100) := null;
   v_usr_maquina            varchar2(100) := null;

/*-----------------------------------------------------------------------------------
-- ifrsiadc.prc_ger_perfil_siadc                                                   --
--                                                                                 --
-- Procedure utilizada para conceder e retirar o perfil ROL_SIADC_AVALIADOR        --
-- do sistema SIADC                                                                --
-- Autor: Denis Andrade                                                            --
-- Data: 29/03/2011                                                                --
-- Dependencias:  ifrsrh.envia_email     - PARA ENVIAR EMAIL PARA O GESTOR         --
--                ifrsrh.log_altera_perfil    - INSERE REGISTRO NA TABELA DE LOG   --
--                                                                                 --
-- Privilégios que o owner deve ter: (grant any role, grant de select na dba_roles)--
-- Sinônimo: prc_ger_perfil_siadc para o objeto ifrsiadc.prc_ger_perfil_siadc      --
--                                                                                 --
-- Usuário de conexão: create user usr_altera_perfil identified by infraero;       --
--                     grant create session to  usr_altera_perfil;                 --
--                     grant select on ifrsrh.cadastros to usr_altera_perfil;      --
--                     grant execute on prc_altera_perfil  to usr_altera_perfil;   --
-- Alterado:                                                                       --
-- Data da Alteração:                                                              --
----------------------------------------------------------------------------------*/
begin
    ----------------------------------------------------------------
    -- Verifica se a matricula do usuário existe na tabela Cadastros
    -- senão existir aborta a operação
    ----------------------------------------------------------------
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
        and role = v_role;--verifica se a role passada como parametro é igual a uma das roles do SGBD
        
        if v_RoleSistema > 0 then
            v_corpo_msg := 'O usuário '||v_usr_solic||' no computador ' || v_usr_maquina||' no dia '||to_char(sysdate, 'DD/MM/YYYY')
            ||' as '||to_char(sysdate,'HH24:MI:SS')||','||chr(13)||'tentou atribuir o perfil '||v_role||' para o usuário '||v_usuario||'.';        
            
            envia_email('Banco_de_dados','banco_de_dados@infraero.gov.br','Tentativa indevida de alteracao de perfil',v_corpo_msg);
            
            raise_application_error(-20000,'Perfil não permitido. O Banco de dados será notificado quanto a esta tentativa indevida.');
        end if;    
    end;    
    ------------------------------------------------------------------------------
    -- Concede / retira permissão do usuário e Monta corpo da mensagem do email
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

    ----------------------------------------------------------------
    -- grava Informações na tabela de LOG
    ----------------------------------------------------------------
    begin
        insert into ifrsrh
        .log_altera_perfil
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

