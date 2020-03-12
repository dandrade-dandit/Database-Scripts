 rem |   Gera relatório (SHOW_&aplic.sql) com as informações de uma
 rem |       aplicacao informado
 rem |
 rem | parametros: nome da aplicacao
 rem |

-- parametrização necessaria
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK OFF
 SET PAGESIZE 1000
set arraysize 1;
set maxdata 60000;
set long 32767;

 ACCEPT dono PROMPT 'DIGITE O NOME DA APLICAÇÃO: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT dblink PROMPT 'DIGITE O NOME DO DB-LINK (C/ @): '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 1000000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\SHOW_&dono..tmp

DECLARE
 my_ow       dba_tables.owner%type;
 my_apl      varchar2(20);
 my_tab      dba_tables.table_name%type;

 cursor c1 is
   select owner,tabela,aplicacao
   from  IFRBANCO.TABELAS&dblink A
   where A.aplicacao like '&dono' and (A.tipo='TABELA' or A.tipo='VIEW')
   order by A.tabela;

BEGIN 
  OPEN C1;
  dbms_output.put_line ('set echo on;');
  LOOP
    FETCH C1 inTO my_ow, my_tab, my_apl;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put_line ('--');
        dbms_output.put_line ('Desc '||my_ow||'.'||my_tab||';');
  end loop;
  close c1;
end;
/
spool off;

spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\SHOW_&dono..txt;
begin
  dbms_output.put_line ('*****************************************************************************************');
  dbms_output.put_line ('** Describe: ');
end;
/

@C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\SHOW_&dono..tmp
set echo off;

DECLARE
 my_ow       dba_tables.owner%type;
 my_apl      varchar2(20);
 my_tab      dba_tables.table_name%type;
 my_tab_aux  dba_tables.table_name%type;
 my_pk       dba_cons_columns.constraint_name%type;
 my_col      dba_cons_columns.column_name%type;
 my_fk       dba_cons_columns.constraint_name%type;
 my_fk_ref   dba_cons_columns.constraint_name%type;
 my_ow_ref   dba_cons_columns.owner%type;
 my_tab_ref  dba_cons_columns.table_name%type;
 my_pk_ref   dba_cons_columns.constraint_name%type;
 my_uk       dba_constraints.constraint_name%type;
 my_tbsp     dba_indexes.tablespace_name%type;
 my_ind      dba_indexes.index_name%type;
 my_uniq     dba_indexes.uniqueness%type;
 my_chk      dba_constraints.search_condition%type;
 my_prv      dba_tab_privs.privilege%type;
 my_rol      dba_tab_privs.grantee%type;
 my_syn      dba_synonyms.synonym_name%type;
 my_obj      dba_dependencies.name%type;
 my_typ      dba_dependencies.type%type;
 virg          varchar2(1);
 my_def	 dba_tab_columns.data_default%type;
 cnt           number;
 brn          varchar2(1);

 cursor c1 is
   select owner,tabela,aplicacao
   from  IFRBANCO.TABELAS&dblink A
   where A.aplicacao like '&dono' and (A.tipo='TABELA' or A.tipo='VIEW')
   order by A.tabela;

 cursor c2 is
   select table_name 
   from  dba_tables A
   where A.owner=my_ow and
         A.table_name=my_tab;

 cursor c3 is
    select A.referenced_owner,A.referenced_name,A.referenced_type
    from dba_dependencies A
    where A.owner = my_ow and A.name = my_tab
    order by A.referenced_type,A.referenced_owner,A.referenced_name;

 cursor c4 is
          select A.column_name,A.constraint_name 
          from dba_cons_columns A, dba_constraints B
          where B.owner=my_ow and B.table_name=my_tab and B.constraint_type='P' and
                A.owner=B.owner and A.constraint_name=B.constraint_name
          order by A.position;
 cursor c41 is
          select owner,table_name,constraint_name 
          from dba_constraints
          where r_owner=my_ow and r_constraint_name=my_pk
          order by owner,table_name,constraint_name;
 cursor c42 is
          select column_name 
          from dba_cons_columns
          where owner=my_ow_ref and constraint_name=my_fk_ref
          order by position;

 cursor c5 is
   select B.constraint_name,A.owner,A.table_name,A.constraint_name
   from dba_constraints A, dba_constraints B
   where B.owner = my_ow and B.table_name = my_tab and B.constraint_type='R' and
         A.owner=B.r_owner and A.constraint_name=B.r_constraint_name
   order by B.constraint_name;
 cursor c51 is
          select column_name 
          from dba_cons_columns
          where owner=my_ow and constraint_name=my_fk
          order by position;
 cursor c52 is
          select column_name 
          from dba_cons_columns
          where owner=my_ow_ref and constraint_name=my_pk_ref
          order by position;

 cursor c6 is
   select B.constraint_name
   from dba_constraints B
   where B.owner = my_ow and B.table_name = my_tab and B.constraint_type='U';
 cursor c61 is
          select column_name 
          from dba_cons_columns
          where owner=my_ow and constraint_name=my_uk
          order by position;

 cursor c7 is
   select A.index_name,A.uniqueness
   from dba_indexes A
   where A.table_owner = my_ow and A.table_name = my_tab;
 cursor c71 is
          select column_name 
          from dba_ind_columns
          where table_owner=my_ow and table_name=my_tab and index_name=my_ind
          order by column_position;

 cursor c8 is
    select B.constraint_name,B.search_condition
    from dba_constraints B
    where B.owner = my_ow and B.table_name = my_tab and B.constraint_type='C' 
--and B.search_condition not like '%NOT NULL'
    order by B.constraint_name;

 cursor c81 is
    select B.column_name,B.data_default
    from dba_tab_columns B
    where B.owner = my_ow and B.table_name = my_tab and B.data_default is not null;

 cursor c9 is
    select B.privilege
    from dba_tab_privs B
    where B.owner = my_ow and B.table_name = my_tab
    group by B.privilege;

 cursor c92 is
    select B.grantee
    from dba_tab_privs B
    where B.owner = my_ow and B.table_name = my_tab and B.privilege=my_prv
    order by B.grantee;

 cursor c91 is
    select B.privilege,B.grantee,B.column_name
    from dba_col_privs B
    where B.owner = my_ow and B.table_name = my_tab
    order by B.privilege,B.grantee;

 cursor c10 is
    select A.owner,A.synonym_name
    from dba_synonyms A
    where A.table_owner = my_ow and A.table_name = my_tab;

 cursor c11 is
    select A.owner,A.name,A.type
    from dba_dependencies A
    where A.referenced_owner = my_ow and A.referenced_name = my_tab
    order by A.type,A.owner,A.name;

BEGIN 
 brn := ' ';
 OPEN C1;
 LOOP
    dbms_output.put_line ('*****************************************************************************************');
    FETCH C1 inTO my_ow, my_tab, my_apl ;
       EXIT WHEN C1%NOTFOUND;

--      Pesquisa IFRBANCO.TABELAS inexistentes
--        begin
--          open c2;
--          virg := ' '; 
--          loop
--             fetch c2 into my_tab_aux;
--             exit when c2%notfound;
--                dbms_output.put_line (brn);
--                dbms_output.put_line ('** Tabela Inexistente =>'||my_ow||'.'||my_tab_aux);
--          end loop;
--          close c2;
--        end;

--      Descricao da tabela
        dbms_output.put_line ('-');
        dbms_output.put_line ('** Detalhes da '||my_ow||'.'||my_tab);
        dbms_output.put_line ('-');
 
--      Pesquisa Dependencia
        begin
          open c3;
          virg := ' '; 
          dbms_output.put ('** Depende de:');
          loop
             fetch c3 into my_ow_ref,my_tab_ref,my_typ;
             exit when c3%notfound;
                dbms_output.put (virg||my_ow_ref||'.'||my_tab_ref||' ('||my_typ||')');
                virg := ','; 
          end loop;
          dbms_output.put_line (brn);
          close c3;
        end;

--      Pesquisa Primary Key e quem faz referencia a ele
        dbms_output.put_line ('-');
        begin
          open c4;
          dbms_output.put ('** Primary Key =>');
          loop
             fetch c4 into my_col, my_pk;
             exit when c4%notfound;
             dbms_output.put (virg||my_col);
             virg := ','; 
          end loop;
          dbms_output.put_line (brn);
          dbms_output.put_line ('-');
          close c4;
          dbms_output.put_line ('** Fazem referencia a PK:');
          begin
            open c41;
            virg := ' '; 
            loop
               fetch c41 into my_ow_ref, my_tab_ref, my_fk_ref;
               exit when c41%notfound;
               dbms_output.put ('....'||my_ow_ref||'.'||my_tab_ref||' ('||my_fk_ref||':');
               virg := ' '; 
               begin
                 open c42;
                 loop
                    fetch c42 into my_col;
                    exit when c42%notfound;
                    dbms_output.put (virg||my_col);
                    virg := ','; 
                 end loop;
                 dbms_output.put_line (')');
                 close c42;
               end;
            end loop;
            dbms_output.put_line (brn);
            close c41;
          end;
          dbms_output.put_line (brn);
        end;

--      Pesquisa Foreign Key
        dbms_output.put_line ('-');
        BEGIN 
          OPEN C5;
          dbms_output.put_line ('** Foreign Key:');
          LOOP
             FETCH C5 inTO my_fk, my_ow_ref, my_tab_ref, my_pk_ref;
             EXIT WHEN C5%NOTFOUND;
              dbms_output.put ('....'||my_fk||':');
              begin
                open c51;
                virg := ' '; 
                loop
                   fetch c51 into my_col;
                   exit when c51%notfound;
                   dbms_output.put (virg||my_col);
                   virg := ','; 
                end loop;
                dbms_output.put_line (brn);
                close c51;
              end;
              dbms_output.put ('. . .refere em '||my_ow_ref||'.');
              dbms_output.put (my_tab_ref||' ('||my_pk_ref||':');
              begin
                open c52;
                virg := ' '; 
                loop
                   fetch c52 into my_col;
                   exit when c52%notfound;
                   dbms_output.put (virg||my_col);
                   virg := ','; 
                end loop;
                close c52;
              end;
              dbms_output.put_line (')');
--              dbms_output.put_line ('.');
          END LOOP;
        CLOSE C5;
        END;

--      Pesquisa Unique Key
        dbms_output.put_line ('-');
        BEGIN 
          OPEN C6;
          dbms_output.put_line ('** Unique Key:');
          LOOP
             FETCH C6 inTO my_uk ;
               EXIT WHEN C6%NOTFOUND;
               dbms_output.put ('....'||my_uk||':');
               begin
                  open c61;
                  virg := ' '; 
                  loop
                     fetch c61 into my_col;
                       exit when c61%notfound;
                       dbms_output.put (virg||my_col);
                       virg := ','; 
                  end loop;
                  close c61;
               end;
               dbms_output.put_line (brn);
          END LOOP;
          CLOSE C6;
        END;

--      Pesquisa Constraints Check
        dbms_output.put_line ('-');
        begin
          open c8;
          virg := ' '; 
          dbms_output.put_line ('** Check:');
          loop
             fetch c8 into my_uk, my_chk;
             exit when c8%notfound;
             dbms_output.put_line ('....'||my_uk||': '||my_chk);
          end loop;
          close c8;
          dbms_output.put_line (brn);
        end;

--      Pesquisa Colunas com Default
        dbms_output.put_line ('-');
        begin
          open c81;
          virg := ' '; 
          dbms_output.put_line ('** Default Value:');
          loop
             fetch c81 into my_col, my_def;
             exit when c81%notfound;
             dbms_output.put_line ('....'||my_col||': '||my_def);
          end loop;
          close c81;
          dbms_output.put_line (brn);
        end;

--      Pesquisa privilegios de acesso
        dbms_output.put_line ('-');
        begin
          open c9;
          dbms_output.put_line ('** Privilegios:');
          loop
             fetch c9 into my_prv;
             exit when c9%notfound;
             dbms_output.put ('....'||my_prv||':' );
             virg := ' '; 
             begin
                open c92;
                cnt := 0;
                loop
                   fetch c92 into my_rol;
                   exit when c92%notfound;
                   cnt := cnt + 1;
                   if cnt  >  6 then
                       dbms_output.put_line (',');
                       dbms_output.put ('....      .');
                       cnt := 1;
                       virg := ' ';
                   end if;
                   dbms_output.put (virg||my_rol);
                   virg := ',';
                end loop;
                dbms_output.put_line (brn);
                close c92;
             end;
             dbms_output.put_line (brn);
          end loop;
          close c9;
          dbms_output.put_line ('....');
        end;

        begin
          open c91;
          virg := ' '; 
          loop
             fetch c91 into my_prv, my_rol, my_col;
             exit when c91%notfound;
             dbms_output.put_line ('....'||my_prv||' na coluna '||my_col||': '||my_rol);
          end loop;
          close c91;
          dbms_output.put_line (brn);
        end;

--      Pesquisa indices
        dbms_output.put_line ('-');
     BEGIN 
        OPEN C7;
        dbms_output.put_line ('** Indices:');
        LOOP
           FETCH C7 inTO my_ind, my_uniq; 
           EXIT WHEN C7%NOTFOUND;
           dbms_output.put ('....'||my_uniq||': '||my_ind||' (');
           begin
              open c71;
              virg := ' '; 
              loop
                 fetch c71 into my_col;
                 exit when c71%notfound;
                 dbms_output.put (virg||my_col);
                 virg := ','; 
              end loop;
              dbms_output.put_line (')');
              close c71;
           end;
           dbms_output.put_line (brn);
        END LOOP;
        CLOSE C7;
     END;

-- Pesquisa Sinonimo
        dbms_output.put_line ('-');
        begin
          open c10;
          virg := ' '; 
          loop
             fetch c10 into my_ow, my_syn;
             exit when c10%notfound;
             dbms_output.put_line ('** Sinonimo '||my_ow||': '||my_syn);
          end loop;
          close c10;
          dbms_output.put_line (brn);
        end;

-- Pesquisa Objetos Dependentes
        dbms_output.put_line ('-');
        begin
          open c11;
          dbms_output.put_line ('** Objetos Dependentes:');
          virg := ' '; 
          loop
             fetch c11 into my_ow, my_obj, my_typ;
             exit when c11%notfound;
             dbms_output.put_line ('....'||my_typ||': '||my_ow||'.'||my_obj);
          end loop;
          close c11;
          dbms_output.put_line (brn);
        dbms_output.put_line ('-');
        end;

 END LOOP;
 CLOSE C1;
 END;
/
set arraysize 1;
set maxdata 60000;
set long 32767;

 -- Pesquisa triggers
 select '** Triggers =>' from dual;
 select '....',
  B.description,
  B.trigger_body
  from dba_triggers B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
	 A.tipo='TABELA' and
	 B.table_owner=A.owner and 
	 B.table_name=A.tabela
order by B.trigger_name;

 -- Pesquisa views
 select '** Views =>' from dual;
 select '....'||B.view_name,
  B.text
  from dba_views B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
	 A.tipo='VIEW' and
	 B.owner=A.owner and
	 B.view_name=A.tabela
 order by B.view_name;

 -- Pesquisa sequences
 select '** Sequence =>' from dual;
 select '....'||B.sequence_name,
  'Min valor '||B.min_value,
  'Max valor '||B.max_value,
  'Increment '||B.increment_by,
  'Ult valor '||B.last_number
  from dba_sequences B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
	 A.tipo='SEQUENCE' and
	 B.sequence_owner=A.owner and
	 B.sequence_name=A.tabela 
 order by B.sequence_name;

 -- Pesquisa roles
 select '** Roles =>' from dual;
DECLARE
 my_rol     dba_tab_privs.grantee%type;
 my_priv   dba_tab_privs.privilege%type;
 virg        varchar2(1);
 my_tab      all_tables.table_name%type;
 brn         varchar2(1);

 cursor c12 is
   select A.grantee,A.table_name
   from dba_tab_privs A, IFRBANCO.TABELAS&dblink B
   where B.aplicacao like '&dono' and
               A.owner = B.owner and A.table_name = B.tabela
    group by A.grantee,A.table_name ;
 cursor c121 is
          select privilege
          from dba_tab_privs
          where grantee=my_rol and table_name=my_tab 
          order by privilege;

 BEGIN 
     brn := ' ';
     dbms_output.put_line (brn);
     OPEN C12;
     LOOP
        FETCH C12 inTO my_rol, my_tab; 
        EXIT WHEN C12%NOTFOUND;
        dbms_output.put ('....'||my_rol||': '||my_tab||' (');
        begin
           open c121;
           virg := ' '; 
           loop
              fetch c121 into my_priv;
              exit when c121%notfound;
              dbms_output.put (virg||my_priv);
              virg := ','; 
           end loop;
           dbms_output.put_line (')');
           close c121;
        end;
        dbms_output.put_line (brn);
     END LOOP;
     CLOSE C12;
 END;
/

 -- Pesquisa functions
 select '** Functions =>' from dual;
 select '....'||B.text
  from dba_source B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
       A.tipo='FUNCTION' and
	 B.owner=A.owner and
	 B.name=A.tabela and
	 B.type = 'FUNCTION'
 order by B.name,B.line;

 -- Pesquisa Procedure
 select '** Procedure =>' from dual;
 select '....'||B.text
  from dba_source B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
       A.tipo='PROCEDURE' and
	 B.owner=A.owner and
	 B.name=A.tabela and
	 B.type = 'PROCEDURE'
 order by B.name,B.line;

 -- Pesquisa package
 select '** Package =>' from dual;
 select '....'||B.text
  from dba_source B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
       A.tipo='PACKAGE' and
	 B.owner=A.owner and
	 B.name=A.tabela and
	 B.type = 'PACKAGE'
 order by B.name,B.line;

 -- Pesquisa PACKAGE_BODY
 select '** Package Body =>' from dual;
 select '....'||B.text
  from dba_source B, IFRBANCO.TABELAS&dblink A
 where A.aplicacao like '&dono' and
       A.tipo='PACKAGE BODY' and
	 B.owner=A.owner and
	 B.name=A.tabela and
	 B.type = 'PACKAGE BODY'
 order by B.name,B.line;

spool off
