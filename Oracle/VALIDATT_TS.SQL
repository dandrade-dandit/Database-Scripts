set serverout on
CREATE OR REPLACE PACKAGE ValidateStructure
AS
        procedure ts( name varchar2 , casc boolean default true);
END;
/

CREATE OR REPLACE PACKAGE BODY ValidateStructure
AS
  numbad number:=0;
  --
  procedure item( typ varchar2 , schema varchar2, name varchar2, 
                       
casc boolean default true) is
    stmt varchar2(200);
    c    number;
    opt  varchar2(20):=null;
  begin
    if (casc) then
      opt:=' CASCADE ';
    end if;
    c:=dbms_sql.open_cursor;
    begin
      stmt:='ANALYZE '||typ||' "'||schema||'"."'||name||'" '||'VALIDATE STRUCTURE'||opt;
      dbms_sql.parse(c,stmt,dbms_sql.native);
    exception
      when others then
       dbms_output.put_line( 'Error analyzing '||typ||opt||'"'||schema||'.'||name||'" '||sqlerrm);
        numbad:=numbad+1;
    end;
    dbms_sql.close_cursor(c);
  end;
  --
  procedure ts( name varchar2 , casc boolean default true) is
    cursor c is 
        SELECT 'TABLE' typ,owner, table_name FROM DBA_TABLES
         where tablespace_name=upper(name)
        UNION ALL 
        SELECT 'CLUSTER',owner, cluster_name FROM DBA_CLUSTERS
         where tablespace_name=upper(name)
        ;
    n number:=0;
  begin
    numbad:=0;
    for R in C
    loop
        n:=n+1;
        ValidateStructure.item(R.typ,r.owner,r.table_name,casc);
    end loop;
    dbms_output.put_line('Analyzed '||N||' objects with '||numbad||' errors');
    if (numbad>0) then
        raise_application_error(-20002,numbad||' errors - SET SERVEROUT ON to view details');
    end if;
  end;
end;
/



  
set serverout on

BEGIN
  dbms_output.enable(1000000);
END;
/
execute sys.ValidateStructure.TS('TABLESPACE_NAME', FALSE);
