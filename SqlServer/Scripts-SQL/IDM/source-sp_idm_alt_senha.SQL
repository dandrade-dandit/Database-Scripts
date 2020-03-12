CREATE OR REPLACE PROCEDURE ifrcorp.sp_idm_alt_senha
  ( px_result_cod out number,
    px_result_des out varchar2,
    px_login      varchar2,
    px_password   varchar2 )
is
	 v_sql                    varchar2(1000) := null;
   v_roleSistema            number(1)   := null;
   v_usuario                varchar2(13)   := px_login;
   v_password               varchar2(100)   := px_password;
   v_corpo_msg              varchar2(1500):= null;
   v_usr_solic              varchar2(100) := null;
   v_usr_maquina            varchar2(100) := null;
   v_EmailPara              varchar2(80) := null;
   v_erro										number(1) := 0;
begin
    px_result_cod := 0;
    px_result_des := 'Ok';
    ----------------------------------------------------------------
    -- Recupera o usuário do Sistema Operacional
    ----------------------------------------------------------------        
    select sys_context('USERENV','OS_USER') into v_usr_solic from dual;
    select sys_context('USERENV','TERMINAL') into v_usr_maquina from dual;
    ------------------------------------------------------------------------------
    -- Verifica se nao esta sendo dado privilegio em role do SGBD
    ------------------------------------------------------------------------------  
   begin
       select count(username)
        into v_RoleSistema
        from dba_users
        where username IN (select grantee from dba_role_privs where granted_role in ('AQ_ADMINISTRATOR_ROLE','AQ_USER_ROLE','CONNECT','CTXAPP','DBA','DELETE_CATALOG_ROLE','EJBCLIENT',
        'EXECUTE_CATALOG_ROLE','EXP_FULL_DATABASE','GATHER_SYSTEM_STATISTICS','GLOBAL_AQ_USER_ROLE','HS_ADMIN_ROLE',
        'IMP_FULL_DATABASE','JAVA_ADMIN','JAVADEBUGPRIV','JAVA_DEPLOY','JAVAIDPRIV','JAVASYSPRIV','JAVAUSERPRIV',
        'RECOVERY_CATALOG_OWNER','RESOURCE','SELECT_CATALOG_ROLE', 'ROL_USU_SISTEMA'))
        and username = UPPER(v_usuario);--verifica se a role passada como parametro é igual a uma das roles do SGBD
        
				if v_RoleSistema > 0 then
						px_result_cod := 1;
    	  	  px_result_des := 'Erro de tentativa de alteração da senha de usuário(' || v_usuario ||') de banco de dados.';
            v_corpo_msg := 'O usuário '||v_usr_solic||' no computador ' || v_usr_maquina||' no dia '||to_char(sysdate, 'DD/MM/YYYY')
            ||' as '||to_char(sysdate,'HH24:MI:SS')||','||chr(13)||'tentou um lock/unlock account no usuário '||v_usuario||'.';        
            
            envia_email('Banco_de_dados','banco_de_dados@infraero.gov.br','Tentativa indevida de alteracao de usuário',v_corpo_msg);
            
            v_erro := 1;
        end if;   
        
    end; 
    
    
    if (v_erro= 0) then
        begin
            -- se o usuário já existir altera a senha no banco
            v_sql := 'ALTER USER '||v_usuario||' IDENTIFIED BY '||v_password|| ' ACCOUNT UNLOCK';
            EXECUTE IMMEDIATE v_sql;
            px_result_cod := 0;
    	  	  px_result_des := 'Senha do usuário '||v_usuario|| ' foi alterada com sucesso.';
        exception
            when others then
            		px_result_cod := 1;
    	  	  	  px_result_des := 'Erro na alteração da senha do usuário '||v_usuario;
                v_erro := 1;
        end;
    end if;

    ----------------------------------------------------------------
    -- grava Informações na tabela de LOG
    ----------------------------------------------------------------    
    begin
        insert into tb_log_idm
        (dt_log,no_procedure,ds_procedure,nu_procedure_resultado,ds_procedure_resultado)    
        values
        (sysdate,'sp_idm_alt_senha','Sp para alterar a senha usuário no banco de dados Oracle.',px_result_cod,px_result_des);
        commit;
    exception
        when  others then
            raise_application_error(-20000, 'Erro ao inserir registro na tabela de LOG.',true);
    end;
end;
/

/*
--************************************
SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME = 'I1190738';
SELECT * FROM tb_log_idm;

set serveroutput on
DECLARE
 x_result_cod NUMBER(1);
 x_result_des VARCHAR2(150); 
BEGIN
  ifrcorp.sp_idm_alt_senha(x_result_cod,x_result_des,'I1190738','xpto');
  dbms_output.put_line(x_result_cod);
  dbms_output.put_line(x_result_des);
END;
/


set serveroutput on
DECLARE
 x_result_cod NUMBER(1);
 x_result_des VARCHAR2(150); 
BEGIN
  ifrcorp.sp_idm_alt_senha(x_result_cod,x_result_des,'IFRDBA','xpto');
  dbms_output.put_line(x_result_cod);
  dbms_output.put_line(x_result_des);
END;
/

*/
