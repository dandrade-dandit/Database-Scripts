set heading off
SET FEEDBACK OFF
set verify off

SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\LOG_OBJETOS_CADASTRADOS_ERRADOS.LOG

SELECT 'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''TABELA'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.TABLE_NAME
				FROM DBA_TABLES B
				WHERE B.OWNER=A.OWNER AND
				             B.TABLE_NAME=A.TABELA) AND
               A.TIPO='TABELA'
ORDER BY A.OWNER,A.TABELA;

SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''VIEW'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.VIEW_NAME
				FROM DBA_VIEWS B
				WHERE B.OWNER=A.OWNER AND
				             B.VIEW_NAME=A.TABELA) AND
               A.TIPO='VIEW'
ORDER BY A.OWNER,A.TABELA;
   
SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''SEQUENCE'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.SEQUENCE_OWNER||B.SEQUENCE_NAME
				FROM DBA_SEQUENCES B
				WHERE B.SEQUENCE_OWNER=A.OWNER AND
				             B.SEQUENCE_NAME=A.TABELA) AND
               A.TIPO='SEQUENCE'
ORDER BY A.OWNER,A.TABELA;

SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''FUNCTION'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.NAME
				FROM DBA_SOURCE B
				WHERE B.OWNER=A.OWNER AND
				             B.NAME=A.TABELA AND
                                                                             B.TYPE='FUNCTION'
                                                               GROUP BY B.OWNER,B.NAME) AND
               A.TIPO='FUNCTION'
ORDER BY A.OWNER,A.TABELA;

SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''PROCEDURE'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.NAME
				FROM DBA_SOURCE B
				WHERE B.OWNER=A.OWNER AND
				             B.NAME=A.TABELA AND
                                                                             B.TYPE='PROCEDURE'
                                                               GROUP BY B.OWNER,B.NAME) AND
               A.TIPO='PROCEDURE'
ORDER BY A.OWNER,A.TABELA;

SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''PACKAGE'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.NAME
				FROM DBA_SOURCE B
				WHERE B.OWNER=A.OWNER AND
				             B.NAME=A.TABELA AND
                                                                             B.TYPE='PACKAGE'
                                                               GROUP BY B.OWNER,B.NAME) AND
               A.TIPO='PACKAGE'
ORDER BY A.OWNER,A.TABELA;

SELECT  'DELETE FROM TABELAS WHERE',
       'APLICACAO='''||A.APLICACAO||''' AND TIPO=''PACKAGE BODY'' AND TABELA='''||A.TABELA||''' AND OWNER='''||A.OWNER||''';'
FROM TABELAS A
WHERE   A.APLICACAO NOT IN ('TECAPLUS','MONIT','SCOTT','SUCOTAP') AND
               A.OWNER||A.TABELA NOT IN (SELECT B.OWNER||B.NAME
				FROM DBA_SOURCE B
				WHERE B.OWNER=A.OWNER AND
				             B.NAME=A.TABELA AND
                                                                             B.TYPE='PACKAGE BODY'
                                                               GROUP BY B.OWNER,B.NAME) AND
               A.TIPO='PACKAGE BODY'
ORDER BY A.OWNER,A.TABELA;

SPOOL OFF