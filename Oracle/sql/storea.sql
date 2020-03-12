REM  Edit and/or remove the following  CREATE TABLE
REM  statement as your needs dictate.
CREATE TABLE  tkprof_table
(
 date_of_insert                       DATE   
,cursor_num                           NUMBER 
,depth                                NUMBER 
,user_id                              NUMBER 
,parse_cnt                            NUMBER 
,parse_cpu                            NUMBER 
,parse_elap                           NUMBER 
,parse_disk                           NUMBER 
,parse_query                          NUMBER 
,parse_current                        NUMBER 
,parse_miss                           NUMBER 
,exe_count                            NUMBER 
,exe_cpu                              NUMBER 
,exe_elap                             NUMBER 
,exe_disk                             NUMBER 
,exe_query                            NUMBER 
,exe_current                          NUMBER 
,exe_miss                             NUMBER 
,exe_rows                             NUMBER 
,fetch_count                          NUMBER 
,fetch_cpu                            NUMBER 
,fetch_elap                           NUMBER 
,fetch_disk                           NUMBER 
,fetch_query                          NUMBER 
,fetch_current                        NUMBER 
,fetch_rows                           NUMBER 
,ticks                                NUMBER 
,sql_statement                        LONG 
);
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 8, 0, 10209, 1, 0, 0, 0, 0, 0, 0 
, 2, 0, 0, 0, 0, 0, 0, 0 
, 4, 2, 30, 82, 164, 10, 2, 33 
, 'SELECT COUNT(*)   FROM PAGAMENTO_TEMP  WHERE TMP_SEQUENCIA = :b1  
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 5, 0, 10209, 1, 0, 2, 0, 0, 0, 0 
, 2, 1, 1, 0, 0, 0, 0, 0 
, 4, 0, 1, 0, 2, 8, 2, 22872 
, 'SELECT REL_RESUMO_FOLHA_SEQUENCIA.NEXTVAL   FROM DUAL  
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 10, 0, 10209, 1, 0, 2, 0, 0, 0, 1 
, 2, 1, 2, 0, 164, 70, 0, 54 
, 0, 0, 0, 0, 0, 0, 0, 277 
, 'DELETE FROM PAGAMENTO_TEMP WHERE TMP_SEQUENCIA = :b1 
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 3, 0, 10209, 1, 0, 1, 0, 0, 0, 0 
, 1, 0, 0, 0, 0, 0, 0, 0 
, 1, 0, 0, 0, 10, 4, 2, 0 
, 'SELECT DEP.DEP_SIGLA ,DEP.DEP_NOME ,DEP.DEP_CODIGO FROM DEPENDENCIAS DEP WHERE DEP.DEP_TIPO IN (1,5) ORDER BY DEP.DEP_SIGLA
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 4, 0, 10209, 1, 0, 0, 0, 0, 0, 0 
, 1, 0, 0, 0, 0, 0, 0, 0 
, 2, 0, 0, 0, 2, 0, 1, 382 
, 'SELECT DEP_CODIGO   FROM DEPENDENCIAS  WHERE DEP_SIGLA = :b1  
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 6, 0, 10209, 1, 0, 2, 0, 0, 0, 0 
, 4, 0, 2, 0, 0, 2, 0, 4 
, 0, 0, 0, 0, 0, 0, 0, 5 
, 'begin DBMS_TRANSACTION.COMMIT; end;
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 7, 0, 10209, 1, 0, 0, 0, 0, 0, 0 
, 2, 0, 7, 2, 19, 6, 0, 54 
, 0, 0, 0, 0, 0, 0, 0, 8 
, 'INSERT INTO PAGAMENTO_TEMP( TMP_SEQUENCIA,TMP_DEP_CODIGO )  SELECT :b1,DEP_CODIGO   FROM DEPENDENCIAS  WHERE DEP_CODIGO = :b2  OR DEP_DEP_CODIGO = :b3 
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 9, 0, 10209, 1, 0, 0, 0, 0, 0, 0 
, 4, 0, 2, 0, 0, 2, 0, 0 
, 0, 0, 0, 0, 0, 0, 0, 2 
, 'COMMIT
');
INSERT INTO tkprof_table VALUES
(
  SYSDATE, 11, 0, 10209, 1, 0, 0, 0, 0, 0, 1 
, 1, 0, 0, 0, 0, 0, 0, 0 
, 0, 0, 0, 0, 0, 0, 0, 1071721 
, 'ROLLBACK
');
