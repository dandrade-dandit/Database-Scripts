CREATE or replace PROCEDURE databasereport AS
-- Este procedimento gera um relat¢rio sobre a estrutura f¡sica do
-- banco de dados a que vocˆ est  correntemente conectado.
-- Execute este script como um administrador, como o SYSTEM, que
-- possa consultar as tabelas do sistema, e a seguir conceda o
-- privil‚gio EXECUTE a este procedimento aos usu rios ou personagens
-- desejados.

-- vari veis para armazenar as informa‡äes retornadas pela primeira
-- consulta
var0 VARCHAR2(100);
var1 VARCHAR2(100);
var2 VARCHAR2(100);

-- cursor para apresentar informa‡äes de tablespace
CURSOR tablespace IS
  SELECT tablespace_name, initial_extent, next_extent,
    min_extents, max_extents, pct_increase, status
    FROM sys.dba_tablespaces;

-- cursor para apresentar informa‡äes de arquivos de dados
CURSOR datafiles (tsname IN VARCHAR2) IS
  SELECT a.file_name, b.status
    FROM sys.dba_data_files a, v$datafile b
    WHERE a.tablespace_name = tsname
    AND a.file_name = b.name;

-- cursor para apresentar informa‡äes de grupos de log de transa‡äes
CURSOR loggroups IS
  SELECT group#, sequence#, bytes, members, archived
    FROM v$log;

-- cursor para apresentar informa‡äes de membros de log de transa‡äes
CURSOR logmembers (groupnum IN NUMBER) IS
  SELECT member, DECODE(status,'INVALID','INACCESSIBLE',
    'STALE','INCOMPLETE','DELETED','DELETED','OK') memberstatus
    FROM v$logfile
    WHERE group# = groupnum;

BEGIN
-- imprime cabe‡alho do relat¢rio
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('Relatorio de Banco de Dados '||SYSDATE);
  DBMS_OUTPUT.PUT_LINE('------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('');

-- imprime informa‡äes gerais sobre o banco de dados
  SELECT name, created, DECODE(log_mode,'NOARCHIVELOG','NO','YES')
    INTO var0, var1, var2
    FROM v$database;
  DBMS_OUTPUT.PUT_LINE(' Informacoes Gerais');
  DBMS_OUTPUT.PUT_LINE(' -----------------------------------------');
  DBMS_OUTPUT.PUT_LINE('  Nome do Banco de Dados:  '||var0);
  DBMS_OUTPUT.PUT_LINE('  Data de Criacao       :  '||var1);
  DBMS_OUTPUT.PUT_LINE('');

-- imprime informa‡äes sobre tablespaces e arquivos de dados
-- correspondentes
  DBMS_OUTPUT.PUT_LINE(' Informacoes sobre Tablespace e Arquivos '
    ||'de dados do Banco de Dados '||var0);
  DBMS_OUTPUT.PUT_LINE(' -----------------------------------------');
  DBMS_OUTPUT.PUT_LINE('');
  FOR dbtablespace IN tablespace LOOP
    DBMS_OUTPUT.PUT_LINE('  Nome do Tablespace: '
      ||dbtablespace.tablespace_name);
    DBMS_OUTPUT.PUT_LINE('  Disponibilidade:    '
      ||dbtablespace.status);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('  Definicao de Parametros Default no '
      ||'Tablespace '||dbtablespace.tablespace_name);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('  Tamanho Default do Extent Inicial:      '
      ||dbtablespace.initial_extent);
    DBMS_OUTPUT.PUT_LINE('  Tamanho Default do Proximo Extent:      '
      ||dbtablespace.next_extent);
    DBMS_OUTPUT.PUT_LINE('  Extents Minimos Default de Objetos:     '
      ||dbtablespace.min_extents);
    DBMS_OUTPUT.PUT_LINE('  Extents Maximos Default de Objetos:     '
      ||dbtablespace.max_extents);
    DBMS_OUTPUT.PUT_LINE('  Taxa de Crescimento Default de Extents: '
      ||dbtablespace.pct_increase||'%');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('  Arquivos de Dados do Tablespace '
      ||dbtablespace.tablespace_name);
    DBMS_OUTPUT.PUT_LINE('');
    FOR dbdatafile IN datafiles(dbtablespace.tablespace_name) LOOP
      DBMS_OUTPUT.PUT_LINE('    Nome do Arquivo de Dados: '
        ||dbdatafile.file_name);
      DBMS_OUTPUT.PUT_LINE('    Disponibilidade:          '
        ||dbdatafile.status);
      DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
  END LOOP;

-- imprime informa‡äes sobre grupos de log de transa‡äes e membros
-- correspondentes
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE(' Informacoes da Log de Transacoes do Banco '
    ||'de Dados '||var0);
  DBMS_OUTPUT.PUT_LINE(' ------------------------------------------'
    ||'-----------------');
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('  Recuperacao da Midia Ativa?: '||var2);
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('  Grupos de Log');
  DBMS_OUTPUT.PUT_LINE('');
  FOR dbloggroup IN loggroups LOOP
    DBMS_OUTPUT.PUT_LINE('   ID do Grupo:                    '
      ||dbloggroup.group#);
    DBMS_OUTPUT.PUT_LINE('   Numero de Sequencia Assinalado: '
      ||dbloggroup.sequence#);
    IF var2 = 'YES' THEN
      DBMS_OUTPUT.PUT_LINE('   Arquivado?:                     '
        ||dbloggroup.archived);
    END IF;
    DBMS_OUTPUT.PUT_LINE('   Tamanho (Bytes):                '
      ||dbloggroup.bytes);
    DBMS_OUTPUT.PUT_LINE('   Numero de Membros:              '
      ||dbloggroup.members);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('   Informacao dos Membros do Grupo '
      ||dbloggroup.group#);
    DBMS_OUTPUT.PUT_LINE('');
    FOR dblogmember IN logmembers(dbloggroup.group#) LOOP
      DBMS_OUTPUT.PUT_LINE('    Nome do Arquivo Membro: '
        ||dblogmember.member);
      DBMS_OUTPUT.PUT_LINE('    Status do Membro:       '
        ||dblogmember.memberstatus);
      DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
  END LOOP;

END databasereport;
