-- Start of DDL Script for Procedure IFRSRH.PRC_RETORNA_SENHA
-- Generated 30-jun-2010 15:17:07 from IFRSRH@DSV

CREATE OR REPLACE 
PROCEDURE          prc_retorna_senha (pMatricula in number, pRetorno out varchar2)
IS
   v_sql                    varchar2(100) := null;
   v_senha                  varchar2(12)   := null;
   v_usuario                varchar2(8)   := 'I'||LPAD(to_char(pMatricula),7,0);
   v_corpo_msg              varchar2(2000):= null;
   v_usr_solic              varchar2(100) := null;
   v_emp_numero_cpf         varchar2(11) := null;
   v_emp_numero_matricula   number(7):=0;
   v_Email                  varchar2(80) := null;
   v_flg_usuario_novo       char(1):= 'N'; -- informa se foi necessário a criação de usuário no banco
   v_senha_cpf              boolean := false; --informa se a senha é o cpf do usuario
/*----------------------------------------------------------------------------------
-- PRC_RETORNA_SENHA                                  --
--                                                                                --
-- Procedure utilizada para alterar senha no banco e enviar alteração por email   --
-- Autor: Ana Carina e Carlos Eduardo                                             --
-- Data: 05/04/2005                                                               --
-- Dependencias:  ifrsrh.fun_gera_senha  - PARA GERAR SENHA ALEATÓRIA             --
--                ifrsrh.envia_email     - PARA ENVIAR EMAIL COM A NOVA SENHA     --
--                ifrsrh.log_retorna_senha    - INSERE REGISTRO NA TABELA DE LOG  --
-- Privilégios que o owner deve ter: (create user, alter user, grant any role)    --
-- Sinônimo: create public synonym PRC_RETORNA_SENHA for ifrsrh.PRC_RETORNA_SENHA -- 
--                                                                                --    
-- Usuário de conexão: create user usr_retorna_senha identified by infraero;      -- 
--                     grant create session to  usr_retorna_senha;                --                    
--                     grant select on ifrsrh.cadastros to usr_retorna_senha;     -- 
--                     grant execute on PRC_RETORNA_SENHA  to usr_retorna_senha;  --
----------------------------------------------------------------------------------*/
begin
    ----------------------------------------------------------------
    -- Verifica se a matricula e email existe na tabela Cadastros
    -- senão existir aborta a operação
    ----------------------------------------------------------------
    begin
        select  emp_numero_matricula,emp_endereco_eletronico_mail 
        into    v_emp_numero_matricula, v_Email
        from    cadastros
        where   emp_numero_matricula = pmatricula
        and     emp_status <> 2; -- afastado e ativo
    exception
        when no_data_found then
            raise_application_error(-20000,'Não existe essa matrícula na tabela Cadastros ou o Empregado não está Ativo.');
    end;

    ----------------------------------------------------------------
    -- Se usuario nao tiver email, muda a senha para o CPF
    ----------------------------------------------------------------
    if  (v_Email is null ) then
        begin
            select  LPAD(EMP_NUMERO_CPF,11,0) --garante que o CPF terá 11 numeros 
            into    v_emp_numero_cpf 
            from    cadastros
            where   emp_numero_matricula = pmatricula
            and     emp_status <> 2; -- afastado e ativo
        exception
            when no_data_found then
                raise_application_error(-20000,'Não existe essa matrícula na tabela Cadastros ou o Empregado não está Ativo.');
        end;
        select 'C'||v_emp_numero_cpf into v_senha from dual;--acrescenta a letra C antes do numero do CPF
        v_senha_cpf := true;--infoma se a senha do usuario é composta pelo cpf
    else
        ----------------------------------------------------------------
        -- Se usuario tiver email, gera uma senha aleatória para o usuário
        ----------------------------------------------------------------
        select fun_gera_senha into v_senha from dual;
    end if;

    ----------------------------------------------------------------
    -- Tenta criar o usuário no banco
    ----------------------------------------------------------------    
    v_sql := 'CREATE USER '||v_usuario||' IDENTIFIED BY '||v_senha;--||' PROFILE USUARIOS';
    BEGIN
       EXECUTE IMMEDIATE v_sql;
       v_flg_usuario_novo := 'S';
    EXCEPTION
        WHEN OTHERS THEN
            -- se o usuário já existir altera a senha no banco
            v_sql := 'ALTER USER '||v_usuario||' IDENTIFIED BY '||v_senha;
            EXECUTE IMMEDIATE v_sql;
    END;

    ----------------------------------------------------------------
    -- Concede a role srh_web ao usuário
    ----------------------------------------------------------------        
    BEGIN
       v_sql := 'GRANT SRH_WEB TO '||v_usuario;
       EXECUTE IMMEDIATE v_sql;
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20000, 'Erro ao conceder a role SRH_WEB ao usuário: '||v_usuario,true);
    END;

    ----------------------------------------------------------------
    -- Recupera o usuário do Sistema Operacional
    ----------------------------------------------------------------        
    select sys_context('USERENV','OS_USER') into v_usr_solic from dual;

    ----------------------------------------------------------------
    -- Informa senha para usuário
    ----------------------------------------------------------------
    if (v_senha_cpf = true) then --se a senha for composta pela CPF, informa na tela
        pRetorno := 'Senha do usuário '||v_usuario||' foi alterada.'
        ||chr(13)||'Sua nova senha é composta pelos numeros do seu CPF precedido da letra "C".'
        ||chr(13)||'Ex.: C70954284687';   
    else--senão, manda email    
        ----------------------------------------------------------------
        -- Monta corpo da mensagem do email
        ----------------------------------------------------------------       
        v_corpo_msg := 'Conforme solicitacao realizada por '||v_usr_solic||' em '||to_char(sysdate, 'DD/MM/YYYY')||' as '||to_char(sysdate,'HH24:MI:SS')||', segue os dados do login.'||
        chr(13)||'A senha da matricula '||v_usuario||' foi alterada para '||v_senha||'.'||
        chr(13)||'Caso tenha duvida no momento da conexao, favor selecionar o botao "Instrucoes para Conexao".'||
        chr(13)||
        chr(13)||'Exemplo de preenchimento:  '||
        chr(13)||chr(9)||'Usuario  = '||v_usuario||
        chr(13)||chr(9)||'Senha    = '||v_senha||
        chr(13);

        ----------------------------------------------------------------
        -- Envia email para o usuário que teve a senha alterada
        ----------------------------------------------------------------    
        envia_email('GestorH',v_email,'Senha de acesso',v_corpo_msg);    
    end if;

    ----------------------------------------------------------------
    -- grava Informações na tabela de LOG
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

-- Grants for Procedure
GRANT EXECUTE ON prc_retorna_senha TO ctis0888
/
GRANT EXECUTE ON prc_retorna_senha TO usr_retorna_senha
/
GRANT EXECUTE ON prc_retorna_senha TO rh_sfp_99
/
GRANT EXECUTE ON prc_retorna_senha TO rh_cad_99
/
GRANT EXECUTE ON prc_retorna_senha TO rh_ben_99
/


-- End of DDL Script for Procedure IFRSRH.PRC_RETORNA_SENHA

