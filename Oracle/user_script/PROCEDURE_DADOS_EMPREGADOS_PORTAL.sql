-- Start of DDL Script for Procedure IFRSRH.ATUALIZA_EMPREGADOS_PORTAL
-- Generated 12-fev-2004 15:54:10 from IFRSRH@MAQUINA4.WORLD

CREATE OR REPLACE 
PROCEDURE ATUALIZA_DADOS_PORTAL
as
begin
delete from empregados_portal@inet;

insert into empregados_portal@inet
select * from ifrsrh.viw_empregados_portal;

commit;

delete from dep_portal@inet;

insert into dep_portal@inet
select * from ifrsrh.viw_dep_portal;

commit;

delete from uor_portal@inet;

insert into uor_portal@inet
select * from ifrsrh.viw_uor_portal;

commit;

end;
/



-- End of DDL Script for Procedure IFRSRH.ATUALIZA_EMPREGADOS_PORTAL

