CREATE or replace PROCEDURE spacereport AS
-- Este procedimento gera um relat¢rio com o espa‡o total e livre de
-- cada arquivo de dados no banco de dados, por tablespace.
-- Execute este script como um administrador, como o SYSTEM, que
-- possa consultar as tabelas do sistema, e a seguir conceda o
-- privil‚gio EXECUTE a este procedimento aos usu rios ou personagens
-- desejados.

CURSOR datafile1 IS
  SELECT tablespace_name, file_id, max(bytes) largeextent,
    sum(bytes) totalfreespace
    FROM sys.dba_free_space
    GROUP BY tablespace_name, file_id
    ORDER BY tablespace_name, file_id;

CURSOR datafile2 (fileid VARCHAR2) IS
  SELECT name, bytes
    FROM v$datafile
    WHERE file# = fileid;

dbname VARCHAR2(8);

BEGIN

SELECT name INTO dbname
  FROM v$database;
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Relatorio de Espaco do Banco de Dados '
  ||dbname);
DBMS_OUTPUT.PUT_LINE('-----------------------------------------'
  ||'-----');
DBMS_OUTPUT.PUT_LINE('');
FOR file IN datafile1 LOOP
  DBMS_OUTPUT.PUT_LINE('Nome do Tablespace:      '
    ||file.tablespace_name);
  DBMS_OUTPUT.PUT_LINE('');
  FOR filedata IN datafile2 (file.file_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Nome do Arquivo de Dados:          '
      ||filedata.name);
    DBMS_OUTPUT.PUT_LINE('Tamanho Total do Arquivo (KB):     '
      ||ROUND(filedata.bytes/1024,0));
    DBMS_OUTPUT.PUT_LINE('Espaco Livre no Arquivo (KB):      '
      ||ROUND(file.totalfreespace/1024,0));
    DBMS_OUTPUT.PUT_LINE('% Espaco Livre no Arquivo:         '
      ||ROUND(((file.totalfreespace/filedata.bytes)*100),0)||'%');
    DBMS_OUTPUT.PUT_LINE('Maior Extent (KB):                 '
      ||ROUND(file.largeextent/1024,0));
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
END LOOP;

END spacereport;
