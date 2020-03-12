CREATE PUBLIC DATABASE LINK oracle.world USING 'HOMOLOG.INFRAERO.GOV.BR';
CREATE DATABASE LINK oracle.world CONNECT TO sysman IDENTIFIED BY jasmin USING 'HOMOLOG.INFRAERO.GOV.BR';


insert into CADASTROS@oracle.world
select  *
from     cadastros
where  emp_status <> 2
and      emp_dep_codigo_fisico = 1;
