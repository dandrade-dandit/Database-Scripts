create or replace procedure atualiza_empregados_portal
as
begin
delete from empregados_portal@inet;

insert into empregados_portal@inet
select * from ifrsrh.viw_empregados_portal;

commit;
end;
/