/*
--PARAMETROS
--Cria��o ou Drop de usu�rio no BD prodsede com privil�gio de SRH_WEB
exec prc_ger_usuario (pMatricula in varchar2, pSenha in varchar2, pTipoUsuario in varchar2, pOperacao in varchar2)
  
   onde:
      pMatricula = matricula do empregado, estagi�rio ou terceiro;
      pSenha = senha que ser� atribu�da ao usu�rio;
      pTipoUsuario = 'I' para INFRAERO; 'E' para ESTAGI�RIO;e 'T' para TERCEIROS;
      pOperacao = 'A' para ALTERAR A SENHA, 'I' para INCLUS�O DO USU�RIO e 'D' para DROP DO USU�RIO;


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


--ROLE PRA USUARIOS DE SISTEMA
CREATE ROLE ROL_USU_SISTEMA;

SELECT 'GRANT ROL_USU_SISTEMA TO ' || USERNAME || ';'
FROM DBA_USERS
WHERE USERNAME LIKE 'USR%';

--TESTES
EXEC ifrcorp.prc_ger_usuario ('I1190738', 'INFRAERO', 'I', 'O');

EXEC ifrcorp.prc_ger_usuario ('I1190738', NULL, 'I', 'D');
EXEC ifrcorp.prc_ger_usuario ('I1190738', 'INFRAERO', 'I', 'I');
EXEC ifrcorp.prc_ger_usuario ('I1190738', 'INFRAERO', 'I', 'A');

EXEC ifrcorp.prc_ger_usuario ('I1190739', 'INFRAERO', 'I', 'I');

EXEC ifrcorp.prc_ger_usuario ('T710801551', NULL, 'T', 'D');
EXEC ifrcorp.prc_ger_usuario ('T710801551', 'INFRAERO', 'T', 'I');
EXEC ifrcorp.prc_ger_usuario ('T710801551', 'INFRAERO', 'T', 'A');

EXEC ifrcorp.prc_ger_usuario ('T006323201', NULL, 'E', 'D');
EXEC ifrcorp.prc_ger_usuario ('T006323201', 'INFRAERO', 'E', 'I');
EXEC ifrcorp.prc_ger_usuario ('T006323201', 'INFRAERO', 'E', 'A');

EXEC ifrcorp.prc_ger_usuario ('IFRDBA', 'INFRAERO', 'E', 'A');
EXEC ifrcorp.prc_ger_usuario ('USR_IDM', 'INFRAERO', 'E', 'A');

--GRANT PARA A ROLE DE SISTEMA...
GRANT EXECUTE ON prc_ger_usuario TO ROL_IDM_ADMIN; 

--alter table de log
alter table IFRSRH.log_retorna_senha modify DSC_USUARIO_BD varchar2(20);
*/

CREATE OR REPLACE PROCEDURE ifrcorp.prc_ger_usuario (pMatricula in varchar2, pSenha in varchar2, pTipoUsuario in varchar2, pOperacao in varchar2)
IS
   v_sql                    varchar2(100) := null;
   v_senha                  varchar2(12)   := pSenha;
   v_usuario                varchar2(15)   := pMatricula;
   v_corpo_msg              varchar2(2000):= null;
   v_usr_solic              varchar2(100) := null;
   v_usr_maquina            varchar2(100) := null;
   v_emp_numero_cpf         varchar2(11) := null;
   v_emp_numero_matricula   number(11):=0;
   v_Email                  varchar2(80) := null;
   v_flg_usuario_novo       char(1):= 'N'; -- informa se foi necess�rio a cria��o de usu�rio no banco
   v_senha_cpf              boolean := false; --informa se a senha � o cpf do usuario
   v_roleSistema            number(1)   := null;
/*----------------------------------------------------------------------------------
-- PRC_GER_USUARIO                                                                --
--                                                                                --
-- Procedure utilizada para alterar senha no banco e enviar altera��o por email   --
-- Autor: Ana Carina e Carlos Eduardo                                             --
-- Data: 05/04/2005                                                               --
-- Dependencias:  ifrsrh.fun_gera_senha  - PARA GERAR SENHA ALEAT�RIA             --
--                ifrsrh.envia_email     - PARA ENVIAR EMAIL COM A NOVA SENHA     --
--                ifrsrh.log_retorna_senha    - INSERE REGISTRO NA TABELA DE LOG  --
-- Privil�gios que o owner deve ter: (create user, alter user, grant any role)    --
-- Sin�nimo: create public synonym PRC_GER_USUARIO for ifrsrh.PRC_GER_USUARIO     -- 
--                                                                                --    
-- Usu�rio de conex�o: create user usr_retorna_senha identified by infraero;      -- 
--                     grant create session to  usr_retorna_senha;                --                    
--                     grant select on ifrsrh.cadastros to usr_retorna_senha;     -- 
--                     grant execute on PRC_GER_USUARIO  to usr_retorna_senha;    --
-- Alterado: Denis Andrade do Nascimento                                          --
-- Data da Altera��o: 03/07/2010                                                  --
----------------------------------------------------------------------------------*/
begin
   
    ----------------------------------------------------------------
    -- Recupera o usu�rio do Sistema Operacional
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
        and username = v_usuario;--verifica se a role passada como parametro � igual a uma das roles do SGBD
        
        if v_RoleSistema > 0 then
            v_corpo_msg := 'O usu�rio '||v_usr_solic||' no computador ' || v_usr_maquina||' no dia '||to_char(sysdate, 'DD/MM/YYYY')
            ||' as '||to_char(sysdate,'HH24:MI:SS')||','||chr(13)||'tentou atribuir o usu�rio '||v_usuario||'.';        
            
            envia_email('Banco_de_dados','banco_de_dados@infraero.gov.br','Tentativa indevida de alteracao de usu�rio',v_corpo_msg);
            
            raise_application_error(-20000,'Usu�rio de sistema. Opera��o n�o permitida. O Banco de dados ser� notificado quanto a esta tentativa indevida.');
        end if;    
    end; 
     
    if (pOperacao != 'A' and pOperacao != 'I' and pOperacao != 'D') then
            raise_application_error(-20000,'Opera��o n�o permitida.');
    end if;
    
    if (pOperacao = 'A') then
        begin
            -- se o usu�rio j� existir altera a senha no banco
            v_sql := 'ALTER USER '||v_usuario||' IDENTIFIED BY '||v_senha;
            EXECUTE IMMEDIATE v_sql;
            return;
        exception
            when others then
                raise_application_error(-20000,'Usu�rio n�o cadastrado no banco de dados.');
                
        end;
    end if;
    
    if (pOperacao = 'D') then
        begin
            -- tenta dropar o usu�rio se ele j� existir.
            v_sql := 'DROP USER '||v_usuario||' CASCADE';
            EXECUTE IMMEDIATE v_sql;
            return;
        exception
            when others then
                raise_application_error(-20000,'Usu�rio n�o cadastrado no banco de dados.');
                
        end;
    end if;
    
    if (pTipoUsuario =  'I') then
        begin
            select  emp_numero_matricula,emp_endereco_eletronico_mail 
            into    v_emp_numero_matricula, v_Email
            from    cadastros
            where   emp_numero_matricula = to_number(substr(pmatricula,2,9))
            and     emp_status <> 2; -- afastado e ativo
        exception
            when no_data_found then
                raise_application_error(-20000,'N�o existe essa matr�cula na tabela Cadastros ou o Empregado n�o est� Ativo.');
        end;
    elsif (pTipoUsuario =  'T') then
        begin
            select ter_cpf, ter_endereco_eletronico_mail
            into    v_emp_numero_matricula, v_Email
            from terceiros
            where ter_cpf like substr(pmatricula,2,9) || '%'
              and ter_status = 1; -- ativo
        exception
            when no_data_found then
                raise_application_error(-20000,'N�o existe essa matr�cula na tabela de Terceiros ou terceiro n�o est� Ativo.');
        end;
    elsif (pTipoUsuario =  'E') then
        begin
            select num_cpf, end_email
            into    v_emp_numero_matricula, v_Email
            from cad_estagiario_pessoal ep
               , cad_estagiario e
            where ep.seq_estagiario_pessoal = e.seq_estagiario_pessoal
            and e.flg_desligado = 'N'
            and lpad(num_cpf,11,'0') like substr(pmatricula,2,9) || '%';
        exception
            when no_data_found then
                raise_application_error(-20000,'N�o existe essa matr�cula na tabela de Terceiros ou terceiro n�o est� Ativo.');
        end;
    else
        raise_application_error(-20000,'Erro desconhecido, contactar o DBA.');
    end if;
   

    ----------------------------------------------------------------
    -- Tenta criar o usu�rio no banco
    ----------------------------------------------------------------    
    v_sql := 'CREATE USER '||v_usuario||' IDENTIFIED BY '||v_senha;--||' PROFILE USUARIOS';
    BEGIN
       EXECUTE IMMEDIATE v_sql;
       v_flg_usuario_novo := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            -- se o usu�rio j� existir altera a senha no banco
            v_sql := 'ALTER USER '||v_usuario||' IDENTIFIED BY '||v_senha;
            EXECUTE IMMEDIATE v_sql;
    END;

    ----------------------------------------------------------------
    -- Concede a role srh_web ao usu�rio
    ----------------------------------------------------------------        
    if (pTipoUsuario =  'I') then
        begin
           v_sql := 'GRANT SRH_WEB TO '||v_usuario;
           EXECUTE IMMEDIATE v_sql;
        EXCEPTION
            WHEN OTHERS THEN
                raise_application_error(-20000, 'Erro ao conceder a role SRH_WEB ao usu�rio: '||v_usuario,true);
        END;
    ELSE
        begin
           v_sql := 'GRANT CREATE SESSION TO '||v_usuario;
           EXECUTE IMMEDIATE v_sql;
        EXCEPTION
            WHEN OTHERS THEN
                raise_application_error(-20000, 'Erro ao conceder a role CREATE SESSION ao usu�rio: '||v_usuario,true);
        END;
    END IF;
        
    ----------------------------------------------------------------
    -- grava Informa��es na tabela de LOG
    ----------------------------------------------------------------    
    begin
        insert into log_retorna_senha
        (DSC_USUARIO_BD,DSC_USUARIO_SO,DAT_ALTERACAO,FLG_USUARIO_NOVO  )    
        values
        (v_usuario,v_usr_solic,sysdate,v_flg_usuario_novo);
        commit;
    exception
        when  others then
            raise_application_error(-20000, 'Erro ao inserir registro na tabela de LOG.',true);
    end;
end;
/

