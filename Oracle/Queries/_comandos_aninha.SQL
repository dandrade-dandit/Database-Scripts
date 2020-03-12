-----------------------------------------------------------------
-- 1) TABELAS QUE ESTÃO NO PRODSEDE E NÃO HOMOLOG
-----------------------------------------------------------------
    select  a.owner, a.table_name
    from    dba_tables@PRODSEDE.WORLD a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     not exists
            (select null from dba_tables b
             where  b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    a.owner = b.owner
             and    a.table_name = b.table_name);  

-----------------------------------------------------------------
-- 2) TABELAS QUE ESTÃO NO HOMOLOG E NÃO NO PRODSEDE
-----------------------------------------------------------------
    select  a.owner, a.table_name
    from    dba_tables a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     not exists
            (select null from dba_tables@PRODSEDE.WORLD b
             where  b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    a.owner = b.owner 
             and    a.table_name = b.table_name);  

-----------------------------------------------------------------         
-- 3) COLUNAS QUE ESTÃO NO PRODSEDE E NÃO ESTÃO NO HOMOLOG
-----------------------------------------------------------------
    select  a.owner, a.table_name, a.column_name
    from    dba_tab_columns@PRODSEDE.WORLD a, dba_tables b
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )               
    and     b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )   
    and     b.owner = a.owner
    and     b.table_name = a.table_name
    and     not exists
            (select null from dba_tab_columns c
             where  c.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    c.owner = a.owner
             and    c.table_name = a.table_name
             and    c.column_name = a.column_name);      

-----------------------------------------------------------------         
-- 4) COLUNAS QUE ESTÃO DO HOMOLOG E NÃO ESTÃO NO PRODSEDE
-----------------------------------------------------------------
    select  a.owner, a.table_name, a.column_name
    from    dba_tab_columns a, dba_tables@PRODSEDE.WORLD b
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )             
    and     b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     b.owner = a.owner
    and     b.table_name = a.table_name
    and     not exists
            (select null from dba_tab_columns@PRODSEDE.WORLD c
             where  c.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    c.owner = a.owner
             and    c.table_name = a.table_name
             and    c.column_name = a.column_name);   

-----------------------------------------------------------------
-- 5) CONSTRAINTS QUE ESTÃO NO PRODSEDE E NÃO ESTÃO NO HOMOLOG
-----------------------------------------------------------------
    select  a.owner, a.table_name, a.constraint_name, a.constraint_type
    from    dba_constraints@PRODSEDE.WORLD a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
 --   and     a.constraint_name not like 'SYS_%'
    and     not exists
            (select null from dba_constraints b
             where  b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    b.owner = a.owner
             and    b.table_name = a.table_name
             and    b.constraint_name = a.constraint_name); --206

-----------------------------------------------------------------
-- 6) CONSTRAINTS QUE ESTÃO NO HOMOLOG E NÃO ESTÃO NO PRODSEDE
-----------------------------------------------------------------
    select  a.owner, a.table_name, a.constraint_name, a.constraint_type
    from    dba_constraints a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
 --   and     a.constraint_name not like 'SYS_%'
    and     not exists
            (select null from dba_constraints@PRODSEDE.WORLD b
             where  b.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
             and    b.owner = a.owner
             and    b.table_name = a.table_name
             and    b.constraint_name = a.constraint_name)
order by  a.constraint_type,  a.table_name, a.constraint_name;  --206
			 
-----------------------------------------------------------------
-- 7) OBJETOS QUE ESTÃO EM PRODSEDE  E NÃO EXISTEM NO HOMOLOG
-----------------------------------------------------------------
    select  a.owner, a.object_name||' - '||a.object_type
    from    dba_objects@PRODSEDE.WORLD  a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     a.object_type in ('PACKAGE','PACKAGE BODY','PROCEDURE',
            'SEQUENCE','TRIGGER','FUNCTION','VIEW','INDEX')
    and     not exists
            (select null from dba_objects b
             where  b.owner = a.owner
             and    b.object_name = a.object_name
             and    b.object_type = a.object_type)
    order by  a.object_type,  a.object_name; 
-- 20

-----------------------------------------------------------------
-- 8) OBJETOS QUE ESTÃO EM HOMOLOG  E NÃO EXISTEM NO PRODSEDE
-----------------------------------------------------------------
    select  a.owner, a.object_name||' - '||a.object_type
    from    dba_objects  a
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     a.object_type in ('PACKAGE','PACKAGE BODY','PROCEDURE',
            'SEQUENCE','TRIGGER','FUNCTION','VIEW','INDEX')
    and     not exists
            (select null from dba_objects@PRODSEDE.WORLD b
             where  b.owner = a.owner
             and    b.object_name = a.object_name
             and    b.object_type = a.object_type)
    order by  a.object_type,  a.object_name; 

-----------------------------------------------------------------
-- 11) VERIFICA AS ROLES QUE ESTÃO PRODSEDE E NÃO FORAM CRIADAS
-- NO HOMOLOG
-----------------------------------------------------------------
SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||';', grantable
FROM   DBA_TAB_PRIVS@PRODSEDE.WORLD 
WHERE  OWNER IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
MINUS
SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||';', grantable
FROM   DBA_TAB_PRIVS
WHERE  OWNER IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' ) ; -- ok


-- rOLES QUE EXISTEM NO HOMOLOG E NÃO EXISTEM NO PRODSEDE
SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||';', grantable
FROM   DBA_TAB_PRIVS
WHERE  OWNER IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
MINUS
SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||';', grantable
FROM   DBA_TAB_PRIVS@PRODSEDE.WORLD 
WHERE  OWNER IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' ) ; -- ok

-- SINÔNIMOS QUE ESTÃO NO PRODSEDE E NÃO ESTÃO NO HOMOLOG
select 'DROP PUBLIC SYNONYM '||table_name||';-- FOR '||table_owner||'.'||table_name||';'
  from dba_synonyms@PRODSEDE.WORLD
 where table_owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
MINUS
select 'DROP PUBLIC SYNONYM '||table_name||';-- FOR '||table_owner||'.'||table_name||';'
  from dba_synonyms
 where table_owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' ) ;

select 'CREATE PUBLIC SYNONYM '||table_name||' FOR '||table_owner||'.'||table_name||';'
  from dba_synonyms
 where table_owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
MINUS
select 'CREATE PUBLIC SYNONYM '||table_name||' FOR '||table_owner||'.'||table_name||';'
  from dba_synonyms@PRODSEDE.WORLD
 where table_owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' ) ; -- ok

select  a.owner, a.object_name, a.object_type, qtde_prodsede,qtde_prodsede_new
  from    (select owner, object_name, object_type, count(*) as qtde_prodsede from dba_objects@PRODSEDE.WORLD 
	        where status = 'INVALID'
		  	  and owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
  	          and object_type in ('PACKAGE','PACKAGE BODY','PROCEDURE',
                                   'SEQUENCE','TRIGGER','FUNCTION','VIEW')
			 group by owner, object_name, object_type )  a,
    		(select owner, object_name, object_type, count(*) as qtde_prodsede_new from dba_objects 
			  where status = 'INVALID'
			    AND owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
		        and object_type in ('PACKAGE','PACKAGE BODY','PROCEDURE',
                                    'SEQUENCE','TRIGGER','FUNCTION','VIEW')
			group by owner, object_name, object_type )  b
 where  b.owner = a.owner
   and  b.object_name = a.object_name
   and  b.object_type = a.object_type
   and  b.qtde_prodsede_new <> qtde_prodsede
 order by  a.owner, a.object_name, a.object_type; 


-- VERIFICA A QTDE DE OBJETOS 
select  a.owner, a.object_type, qtde_prodsede,qtde_prodsede_new
  from    (select owner, object_type, count(*) as qtde_prodsede from dba_objects@PRODSEDE.WORLD 
	        where owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
			 group by owner, object_type )  a,
    		(select owner, object_type, count(*) as qtde_prodsede_new from dba_objects 
			  where owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
			group by owner, object_type )  b
 where  b.owner = a.owner
   and  b.object_type = a.object_type
   and  b.qtde_prodsede_new <> qtde_prodsede
 order by  a.owner, a.object_type;  
IFRPROUVI_IMP                 	SYNONYM            	114          	100
                                                                                                                                                                       	28

-- CONSTRAINTS DESABILITDAS X HABILITADAS
SELECT a.OWNER,a.TABLE_NAME,a.CONSTRAINT_NAME,a.STATUS, b.status
FROM   dba_constraints a, dba_constraints@PRODSEDE.WORLD  b
WHERE  A.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
AND    a.OWNER = b.OWNER 
and    a.table_name = b.table_name 
and    a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
and    a.status <> b.status ;	

-- TRIGGERS DESABILITDAS X HABILITADAS
SELECT a.OWNER,a.TABLE_NAME,a.TRIGGER_NAME,a.STATUS, b.status
FROM   dba_triggers a, dba_triggers@PRODSEDE.WORLD  b
WHERE A.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
AND    a.OWNER = b.OWNER 
and    a.table_name = b.table_name 
and    a.TRIGGER_NAME = b.TRIGGER_NAME
and    a.status <> b.status ;		
             
-- OBJECTS DESABILITDAS X HABILITADAS
SELECT a.OWNER,a.object_name,a.object_type, a.STATUS status_new, b.status status_PRODSEDE
FROM   dba_objects a, dba_objects@PRODSEDE.WORLD  b
WHERE A.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
AND    a.OWNER = b.OWNER 
and    a.object_name = b.object_name 
and    a.object_type = b.object_type
and    a.status <> b.status ;	

-- compilar objetos inválidos
SELECT 'alter '||a.object_type||' '||a.OWNER||'.'||a.object_name||' compile;'
FROM   dba_objects a, dba_objects@PRODSEDE.WORLD  b
WHERE A.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
AND    a.OWNER = b.OWNER 
and    a.object_name = b.object_name 
and    a.object_type = b.object_type
and    a.object_type <> 'PACKAGE BODY'
and    a.status <> b.status ;	

SELECT 'alter package '||a.OWNER||'.'||a.object_name||' compile body;'
FROM   dba_objects a, dba_objects@PRODSEDE.WORLD  b
WHERE A.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
AND    a.OWNER = b.OWNER 
and    a.object_name = b.object_name 
and    a.object_type = b.object_type
and    a.object_type = 'PACKAGE BODY'
and    a.status <> b.status ;	
			   			    
-----------------------------------
-- COMPARA O TAMANHO DOS CAMPOS		     
-----------------------------------
    select  A.OWNER, A.TABLE_NAME, A.COLUMN_NAME,
			A.DATA_PRECISION DATA_PRECISION_PROD,A.DATA_SCALE DATA_SCALE_PROD,
			B.DATA_PRECISION DATA_PRECISION_HOMOLOG,  B.DATA_SCALE DATA_SCALE_HOMOLOG
    from    dba_tab_columns@PRODSEDE.WORLD a,  dba_tab_columns b
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     A.data_type = 'NUMBER'
    and     b.owner = a.owner
    and     b.table_name = a.table_name
    AND 	B.column_name = a.column_name
	and     B.data_type = A.data_type
	and     (B.data_precision <> A.data_precision
	or		B.data_scale <> A.data_scale)     ;	

-- VARCHAR2	
	select  a.owner, a.table_name, a.column_name, a.data_type,
			a.DATA_LENGTH DATA_LENGTH_GAS,B.DATA_LENGTH DATA_LENGTH_CASE
    from    dba_tab_columns@PRODSEDE.WORLD a,  dba_tab_columns b
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     A.data_type = b.data_type
    and     b.owner =  a.owner
    and     b.table_name = a.table_name
    AND 	B.column_name = a.column_name
	and     B.data_type = A.data_type
	and     A.DATA_LENGTH <> B.DATA_LENGTH;	
	
	
    select  a.owner, a.table_name, a.constraint_name, d.column_name
    from    dba_constraints@PRODSEDE.WORLD a, dba_cons_columns@PRODSEDE.WORLD d
    where   a.owner IN ('IFRSCA', 'IFRPROUVI_OWNER', 'IFRPROUVI_IMP' )
    and     a.constraint_name like 'SYS%'
    and     a.constraint_type = 'C'
    and     a.owner = d.owner
    and     a.table_name = d.table_name
    and     a.constraint_name = d.constraint_name
    and     not exists
            (select null from dba_constraints b, dba_cons_columns e
             where  b.owner = a.owner
             and    b.table_name = a.table_name
             and    b.constraint_type = 'C'
			 and    b.constraint_name like 'SYS%'
			 and    b.owner = e.owner
    		 and    b.table_name = e.table_name
    		 and    b.constraint_name = e.constraint_name
			 and    d.column_name = e.column_name);	
			 
select * from dba_db_links

-- VERIFICAR OBJETOS INVÁLIDOS EM PRODSEDE
select 'alter ' || object_type || ' ' ||owner||'.'|| object_name || ' compile;'|| 
'
show error' from dba_objects
   where status = 'INVALID'
   and owner IN ('IFRSRH','IFRDBA2','IFRSICOF','IFRMAXIMO_DBLINK', 'INTEGRACAO_DBLINK')
   and object_type != 'PACKAGE BODY' 
      order by owner
/

select 'alter PACKAGE ' ||owner||'.'|| object_name || ' compile BODY;'||
'
show error' from dba_objects
   where status = 'INVALID'
   and owner IN ('IFRSRH','IFRDBA2','IFRSICOF','IFRMAXIMO_DBLINK', 'INTEGRACAO_DBLINK')
   and object_type = 'PACKAGE BODY' 
   order by owner
/

			 			 	
