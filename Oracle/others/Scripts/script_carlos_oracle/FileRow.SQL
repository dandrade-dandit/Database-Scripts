set serveroutput on
declare
   NomeArq varchar(50);
   wfile number;
   cursor c1 is
      select rowid, d1
      from scott.teste_par;
begin
   for crowid in c1 loop
      wfile := dbms_rowid.rowid_relative_fno(crowid.rowid);
      /* */
      select Name 
      into NomeArq
      from v$datafile
      where file# = wfile;
      /* */
      dbms_output.put_line('Linha: '||crowid.d1||' Datafile : '||wfile||'-'||NomeArq);
   end loop;
end;            
/