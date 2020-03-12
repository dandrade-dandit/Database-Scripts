CREATE TABLE IFRDBA.LOG_TRANSACOES (
  ROLE VARCHAR2(100),
  QTD NUMBER(4),
  DTA DATE)

ALTER TABLE IFRDBA.LOG_TRANSACOES
ADD VOLUME NUMBER(10)
;

--como usuário sys
create or replace view viw_sessions as select * from gv$session;
create or replace view viw_trans as select * from GV$TRANSACTION;
create or replace view viw_sess_io as select * from gv$sess_io;
grant select on viw_trans to ifrdba;
grant select on viw_sessions to ifrdba;
grant select on viw_sess_io to ifrdba;


CREATE OR REPLACE PROCEDURE IFRDBA.PRC_CARGA_TRANSACOES 
IS  
begin
INSERT INTO  IFRDBA.LOG_TRANSACOES 
SELECT  GRANTED_ROLE, SUM(1), SYSDATE, SUM(block_changes)
  FROM  DBA_ROLE_PRIVS
     , (
        SELECT S.USERNAME, SIO.block_changes
        FROM sys.viw_trans T
           , sys.viw_sessions S
           , gv$sess_io sio
        WHERE S.SADDR = T.SES_ADDR
        AND   S.SID = SIO.SID
        AND   S.USERNAME NOT IN ('SYS', 'IFRDBA', 'SYSMAN', 'IFRAD'))
WHERE  GRANTEE = USERNAME
  AND  GRANTED_ROLE NOT IN ('CONNECT', 'RESOURCE', 'ROL_TECA_TKUSER', 'SELECT_CATALOG_ROLE')
GROUP BY GRANTED_ROLE
ORDER BY GRANTED_ROLE;

COMMIT;
end;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.SUBMIT(:jobno, 
      'IFRDBA.PRC_CARGA_TRANSACOES;',
      to_date('09/09/2010 11:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 5/1440');
   commit;
END;
/


select * from IFRDBA.LOG_TRANSACOES;

select * from dba_jobs where job = 827;


--***********************************************************************
CREATE TABLE IFRDBA.LOG_TERCEIROS (
    INST_ID NUMBER(1)
  , SID NUMBER(5)
  , SERIAL# NUMBER(5)
  , USERNAME VARCHAR2(100)
  , OSUSER VARCHAR2(100)
  , MACHINE VARCHAR2(100)
  , TERMINAL VARCHAR2(100)
  , PROGRAM VARCHAR2(100))

ALTER TABLE IFRDBA.LOG_TERCEIROS
ADD DTA_ATUALIZACAO DATE
/

CREATE OR REPLACE PROCEDURE IFRDBA.PRC_CARGA_LOG_TERCEIROS
IS  
begin
INSERT INTO  IFRDBA.LOG_TERCEIROS 
SELECT INST_ID
     , SID
     , SERIAL#
     , USERNAME
     , OSUSER
     , MACHINE
     , TERMINAL
     , PROGRAM 
     , SYSDATE
  FROM sys.viw_sessions
 WHERE OSUSER LIKE 'T%'
   AND TERMINAL LIKE 'SE%'
   AND PROGRAM IS NOT NULL;

COMMIT;
end;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.SUBMIT(:jobno, 
      'IFRDBA.PRC_CARGA_LOG_TERCEIROS;',
      to_date('09/09/2010 11:20:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 5/1440');
   commit;
END;
/

SELECT * FROM IFRDBA.LOG_TERCEIROS 

select * from dba_jobs where job = 828;
