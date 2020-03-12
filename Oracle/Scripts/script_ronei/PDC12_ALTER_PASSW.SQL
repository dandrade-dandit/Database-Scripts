CREATE OR REPLACE PROCEDURE PDC12_ALTER_PASSW(
   STRING             IN  VARCHAR2,
   DS_RETORNO         OUT VARCHAR2,
   DS_RETCODE         OUT VARCHAR2
)
AS
    cursor_name INTEGER;
    ret INTEGER;
BEGIN

   DS_RETORNO := 'S';
   DS_RETCODE := '120201';

   cursor_name := DBMS_SQL.OPEN_CURSOR;
  
   --DDL statements are executed by the parse call, which
   --performs the implied commit
   DBMS_SQL.PARSE(cursor_name, string, DBMS_SQL.NATIVE);
   ret := DBMS_SQL.EXECUTE(cursor_name);
   DBMS_SQL.CLOSE_CURSOR(cursor_name);

   IF ret <> 0 then
        DS_RETORNO := 'W';
   END IF;  

RETURN;

EXCEPTION
-- -------------------------------------------------------------
-- DS_RETCODE = xxyyzz   onde:
-- xx - Número da PDC  Ex. PDC12 -> xx = 12
-- yy - Número da Função que está sendo executada
--      01 - SELECT
--      02 - INSERT
--      03 - UPDATE
--      04 - DELETE
--      05 - OPEN CURSOR
--      06 - FETCH CURSOR
--      07 - CLOSE CURSOR
--      08 - COMMIT
--      09 - CALL PROCEDURE
-- zz - Número sequencial dentro da PROCEDURE
-- -------------------------------------------------------------
WHEN OTHERS THEN
    DS_RETORNO := 'W';
END PDC12_ALTER_PASSW;
/

SQL> VARIABLE T1 VARCHAR2(1);
SQL> VARIABLE T2 VARCHAR2(6);
SQL> EXECUTE PDC12_ALTER_PASSW('CREATE TABLE TESTI (COL1 NUMBER)',:T1,:T2);

PL/SQL procedure successfully completed.

SQL> PRINT T1

T1
--------------------------------
S

SQL> PRINT T2

T2
--------------------------------
120201

SQL> DESC TESTI
 Name                            Null?    Type
 ------------------------------- -------- ----
 COL1                                     NUMBER
