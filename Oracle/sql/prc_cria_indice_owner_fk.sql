CREATE OR REPLACE PROCEDURE ifrad.prc_cria_indice_owner_fk (pNo_owner IN VARCHAR2)
AS
   CURSOR c_constraint  IS
        select 	owner,table_name, constraint_name
		 from   dba_constraints
		where   constraint_type = 'R'
		  and 	owner = pNo_owner
     order by 	owner,table_name, constraint_name;
		  
   CURSOR c_cons_columns (pConstraint_name VARCHAR2) IS
        select 	a.owner,a.table_name,a.position,a.column_name
		 from   dba_cons_columns a
		where   a.constraint_name = pconstraint_name
		  and 	a.owner = pno_owner
		  and   not exists (select null from dba_ind_columns c
				where a.owner = c.table_owner
				and   a.table_name = c.table_name
				and   a.column_name = c.column_name
				and   a.position = c.column_position )					
     order by 	a.owner,a.table_name,a.position,a.column_name;
             
   v_comando        varchar2 (1000) := null;
   v_controle		number(1);
BEGIN
   FOR r_constraint IN c_constraint LOOP
      v_comando := 'CREATE INDEX '||pno_owner||'.'||r_constraint.constraint_name||'_IX ON '||pno_owner||'.'
	  				||r_constraint.table_name ||' ( ';

	  v_controle := 0;
	  	
      FOR r_cons_columns IN c_cons_columns (r_constraint.constraint_name) LOOP
         v_comando := v_comando || r_cons_columns.column_name || ' ASC,';
         v_controle:= 1; 
      END LOOP;

	  if v_controle = 1 then	
	      v_comando := SUBSTR (v_comando, 1, LENGTH (v_comando) - 1);
	      v_comando := v_comando || ' ); ';

		  if LENGTH(v_comando) > 255 then	
	      	DBMS_OUTPUT.put_line (substr(v_comando,1,255));
	      	DBMS_OUTPUT.put_line (substr(v_comando,256,255));
	      else
		  	DBMS_OUTPUT.put_line (v_comando);
		  end if;	
	  end if;
	  
	  v_comando := NULL;
   END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE ifrad.prc_cria_indice_tabela_fk (pNo_owner IN VARCHAR2, pNo_tabela in VARCHAR2)
AS
   CURSOR c_constraint  IS
        select 	owner,table_name, constraint_name
		 from   dba_constraints
		where   constraint_type = 'R'
		  and 	owner = pNo_owner
		  and   table_name = pNo_tabela
     order by 	owner,table_name, constraint_name;
		  
   CURSOR c_cons_columns (pConstraint_name VARCHAR2) IS
        select 	a.owner,a.table_name,a.position,a.column_name
		 from   dba_cons_columns a
		where   a.constraint_name = pconstraint_name
		  and 	a.owner = pno_owner
		  and   not exists (select null from dba_ind_columns c
				where a.owner = c.table_owner
				and   a.table_name = c.table_name
				and   a.column_name = c.column_name
				and   a.position = c.column_position )					
     order by 	a.owner,a.table_name,a.position,a.column_name;
             
   v_comando        varchar2 (2000) := null;
   v_controle		number(1);
BEGIN
   FOR r_constraint IN c_constraint LOOP
      v_comando := 'CREATE INDEX '||pno_owner||'.'||r_constraint.constraint_name||'_IX ON '||pno_owner||'.'
	  				||r_constraint.table_name ||' ( ';

	  v_controle := 0;
	  	
      FOR r_cons_columns IN c_cons_columns (r_constraint.constraint_name) LOOP
         v_comando := v_comando || r_cons_columns.column_name || ' ASC,';
         v_controle:= 1; 
      END LOOP;

	  if v_controle = 1 then	
	      v_comando := SUBSTR (v_comando, 1, LENGTH (v_comando) - 1);
	      v_comando := v_comando || ' ); ';

		  if LENGTH(v_comando) > 255 then	
	      	DBMS_OUTPUT.put_line (substr(v_comando,1,255));
	      	DBMS_OUTPUT.put_line (substr(v_comando,256,255));
	      else
		  	DBMS_OUTPUT.put_line (v_comando);
		  end if;	
	  end if;
	  
	  v_comando := NULL;
   END LOOP;
END;
/



-- End of DDL Script for Procedure IFRAD.PRC_CRIA_INDICE_TABELA_FK

