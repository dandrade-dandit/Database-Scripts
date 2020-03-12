CREATE PROCEDURE securityreport (user VARCHAR2) AS
-- Este procedimento gera um relat¢rio de seguran‡a para o usu rio
-- especificado. O relat¢rio mostra os tablespaces default e tempor rio
-- do usu rio, perfil de limite de recursos, cotas de tablespace,
-- privil‚gios de sistema diretamente concedidos, privil‚gios de
-- objeto diretamente concedidos, e personagens.

-- Uso: EXECUTE securityreport('xxxxxxxx')
-- Onde : xxxxxxxx = identifica‡Æo do usu rio

-- vari veis para armazenar informa‡äes de conta
var0 VARCHAR2(100);
var1 VARCHAR2(100);
var2 VARCHAR2(100);

-- cursor para armazenar informa‡äes de cota de tablespace
CURSOR quotas IS
  SELECT tablespace_name, bytes,
    DECODE(max_bytes,-1,'Espaco Ilimitado',TO_CHAR(max_bytes)) quota
    FROM sys.dba_ts_quotas
    WHERE username = UPPER(user);

-- cursor para armazenar informa‡äes de privil‚gios de sistema
CURSOR sysprivs IS
  SELECT privilege, admin_option
    FROM sys.dba_sys_privs
    WHERE grantee = UPPER(user);

-- cursor para armazenar informa‡äes de privil‚gios de objeto
CURSOR objprivs IS
  SELECT owner, table_name, privilege, grantable
    FROM sys.dba_tab_privs
    WHERE grantee = UPPER(user);

-- cursor para armazenar informa‡äes de personagens
CURSOR roles IS
  SELECT granted_role, admin_option, default_role
    FROM sys.dba_role_privs
    WHERE grantee = UPPER(user);

BEGIN
-- Coleta informa‡äes de conta do usu rio para a primeira parte do
-- relat¢rio. Se o usu rio especificado nÆo existir, retorna uma
-- mensagem de erro.

  SELECT default_tablespace, temporary_tablespace, profile
    INTO var0, var1, var2
    FROM sys.dba_users
    WHERE username = UPPER(user);

-- imprime cabe‡alho do relat¢rio
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Relatorio de Seguran‡a para o Usuario: '||UPPER(user));
DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');

-- imprime defini‡äes da conta do usu rio
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(' Definicoes da conta de '||UPPER(user));
DBMS_OUTPUT.PUT_LINE('  Tablespace Default:            '||var0);
DBMS_OUTPUT.PUT_LINE('  Tablespace Temporario:         '||var1);
DBMS_OUTPUT.PUT_LINE('  Perfil de Limite de Recursos:  '||var2);

-- imprime cotas de tablespace do usu rio, se houverem
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(' Cotas de Tablespace para '||UPPER(user));
DBMS_OUTPUT.PUT_LINE(' -----------------------------------------------------');
FOR userquota IN quotas LOOP
  DBMS_OUTPUT.PUT_LINE('  Tablespace:    '||userquota.tablespace_name);
  DBMS_OUTPUT.PUT_LINE('  Bytes usados:  '||userquota.bytes);
  DBMS_OUTPUT.PUT_LINE('  Cota (Bytes):  '||userquota.quota);
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;

-- imprime privil‚gios de sistema do usu rio, se houverem
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(' Privilegios de Sistema Concedidos Diretamente a '
  ||UPPER(user));
DBMS_OUTPUT.PUT_LINE(' -----------------------------------------------------');
FOR usersyspriv IN sysprivs LOOP
  DBMS_OUTPUT.PUT_LINE('  Privilegio:      '||usersyspriv.privilege);
  DBMS_OUTPUT.PUT_LINE('  Opcao Admin?:    '||usersyspriv.admin_option);
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;

-- imprime privil‚gios de objeto do usu rio, se houverem
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(' Privilegios de Objeto Concedidos Diretamente a '
  ||UPPER(user));
DBMS_OUTPUT.PUT_LINE(' -----------------------------------------------------');
FOR userobjpriv IN objprivs LOOP
  DBMS_OUTPUT.PUT_LINE('  Nome do Objeto:  '||userobjpriv.owner||'.'
    ||userobjpriv.table_name);
  DBMS_OUTPUT.PUT_LINE('  Privilegio:      '||userobjpriv.privilege);
  DBMS_OUTPUT.PUT_LINE('  Opcao Admin?:    '||userobjpriv.grantable);
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;

-- imprime personagens do usu rio, se houverem, indicando quais sÆo
-- personagens default
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(' Personagens de '||UPPER(user));
DBMS_OUTPUT.PUT_LINE(' -----------------------------------------------------');
FOR userroles IN roles LOOP
  IF userroles.default_role = 'YES' THEN
    DBMS_OUTPUT.PUT_LINE('  Personagem Default:  '||userroles.granted_role);
  ELSE
    DBMS_OUTPUT.PUT_LINE('  Personagem:          '||userroles.granted_role);
  END IF;
  DBMS_OUTPUT.PUT_LINE('  Opcao Admin?:        '||userroles.admin_option);
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;

EXCEPTION
-- se o usu rio nÆo existe, levanta mensagem de erro definida pelo usu rio
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20000, UPPER(user)
      ||'nao eh usuario valido do banco de dados.');
END securityreport;
