set timing on
set serveroutput on

spo log_criacao_workorder_temp_open.log

exec dbms_output.put_line('JANEIRO/2009');
--JANEIRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate > TO_DATE ('31/12/2008', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/02/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('FEVEREIRO/2009');
--FEVEREIRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/02/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/03/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('MARÇO/2009');
--MARÇO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/03/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/04/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('ABRIL/2009');
--ABRIL/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/04/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/05/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('MAIO/2009');
--MAIO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/05/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/06/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('JUNHO/2009');
--JUNHO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/06/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/07/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('JULHO/2009');
--JULHO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/07/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/08/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('AGOSTO/2009');
--AGOSTO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/08/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/09/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('SETEMBRO/2009');
--SETEMBRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/09/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/10/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('OUTUBRO/2009');
--OUTUBRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/10/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/11/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('NOVEMBRO/2009');
--NOVEMBRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/11/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/12/2009', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('DEZEMBRO/2009');
--DEZEMBRO/2009
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/12/2009', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/01/2010', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('JANEIRO/2010');
--JANEIRO/2010
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/01/2010', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/02/2010', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('FEVEREIRO/2010');
--FEVEREIRO/2010
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/02/2010', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/03/2010', 'DD/MM/YYYY')
/

COMMIT
/

exec dbms_output.put_line('MARÇO/2010');
--MARÇO/2010
insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE STATUS != 'FECHADA'
and siteid = 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate >= TO_DATE ('01/03/2010', 'DD/MM/YYYY')
/

COMMIT
/

spo off


insert into workorder_temp
SELECT  /*+ index(ifrmaximo.maxreportdate_idx_temp) */
     *
FROM workorder
WHERE siteid != 'INFRAERO'
AND orgid = 'INFRAERO'
and reportdate > TO_DATE ('31/12/2008', 'DD/MM/YYYY')
and reportdate < TO_DATE ('01/02/2009', 'DD/MM/YYYY')
/

COMMIT
/

--migração feita em 04/2011

--Buscar dados da WOSTATUS para migração
select * 
  from wostatus
 where (to_date(changedate) <= to_date('31/12/2009','dd/mm/yyyy') 
       or wonum in (select wonum 
                      from workorder
                     where to_date(reportdate) <= to_date('31/12/2010', 'dd/mm/yyyy')
                       and STATUS  = 'CAN'
                       and siteid = 'INFRAERO'
                       and orgid = 'INFRAERO'
                       and reportdate <= to_date('31/12/2010', 'dd/mm/yyyy')) 


--Buscar dados da WORKORDER para migração
select * 
  from workorder
 where STATUS  = 'CAN'
   and siteid = 'INFRAERO'
   and orgid = 'INFRAERO'
   and reportdate <= to_date('31/12/2010', 'dd/mm/yyyy')