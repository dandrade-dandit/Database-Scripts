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
set maxdata 32767;
set long 32767;

 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
 SET SERVEROUTPUT ON SIZE 1000000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\cria_fk_sem_index_&dono..sql

DECLARE
 my_ow       all_tables.owner%type;
 my_apl      varchar2(20);
 my_rows     number;
 my_leng     number;
 my_rows_ref number;
 my_leng_ref number;
 my_tab      all_tables.table_name%type;
 my_tab_aux  all_tables.table_name%type;
 my_pk       all_cons_columns.constraint_name%type;
 my_col      all_cons_columns.column_name%type;
 my_fk       all_cons_columns.constraint_name%type;
 my_fk_ref   all_cons_columns.constraint_name%type;
 my_ow_ref   all_cons_columns.owner%type;
 my_tab_ref  all_cons_columns.table_name%type;
 my_pk_ref   all_cons_columns.constraint_name%type;
 virg        varchar2(1);

cursor c1 is
 select B.owner,B.constraint_name,B.table_name,D.owner,D.table_name
 from all_cons_columns A, all_constraints B, all_constraints D
 where B.owner = '&dono' and A.owner = '&dono' and 
       B.table_name = A.table_name and 
       A.constraint_name = B.constraint_name and
       B.constraint_type = 'R' and
       not exists   (select *
            from all_ind_columns C
            where C.table_owner = A.owner and
                  C.table_name = A.table_name and
                  C.column_position = A.position and
                  C.column_name = A.column_name) and
       D.owner = B.r_owner and
       D.constraint_name = B.r_constraint_name and
       D.constraint_type = 'P'
 group by B.owner,B.constraint_name,B.table_name,D.owner,D.table_name
 order by B.table_name,B.constraint_name;

 cursor c2 is
          select A.column_name
          from all_cons_columns A
          where A.owner='&dono' and A.table_name=my_tab and A.constraint_name=my_fk
          order by A.position;

 cursor c3 is
          select A.num_rows,A.avg_row_len
          from dba_tables A
          where A.owner=my_ow and A.table_name=my_tab;

 cursor c4 is
          select A.num_rows,A.avg_row_len
          from dba_tables A
          where A.owner=my_ow_ref and A.table_name=my_tab_ref;

BEGIN 
 dbms_output.put_line ('set feedback on');
 dbms_output.put_line ('set verify on');
 dbms_output.put_line ('set echo on');
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_fk, my_tab, my_ow_ref, my_tab_ref ;
       EXIT WHEN C1%NOTFOUND;
--      busca o tamanho das tabelas
        begin
          open c3;
          loop
             fetch c3 into my_rows,my_leng;
             exit when c3%notfound;
          end loop;
          close c3;
          open c4;
          loop
             fetch c4 into my_rows_ref,my_leng_ref;
             exit when c4%notfound;
          end loop;
          close c4;
        end;

--      verifica o tamanho da tabela 'filha' (tam bloco * qtd blocos lidos)
        if (my_rows * my_leng) > 130000 then
            dbms_output.put_line ('--*******************************************************');
       	dbms_output.put_line ('-- TAB('||my_tab||'): '||(my_rows * my_leng)||'  TAB REF('||my_tab_ref||'): '||(my_rows_ref * my_leng_ref));
       	dbms_output.put_line ('create index '||my_fk||' on '||my_ow||'.'||my_tab);

--      	Pesquisa as colunas
        	begin
          	  open c2;
          	  virg := '('; 
          	  loop
             	fetch c2 into my_col;
             	exit when c2%notfound;
             	dbms_output.put (virg||my_col);
             	virg := ','; 
          	  end loop;
          	  close c2;
          	  dbms_output.put_line (')');
          	  dbms_output.put_line ('Tablespace TSD_INDICE;');
        	end;
	  end if;
 END LOOP;
 CLOSE C1;
 END;
/
spool off
