--Passo 1 como usuario internal
@?/ctx/admin/dr0csys.sql ctxsys system temp 

--10g
--******************************************
--Cria o usuario do intermedia text 10g
@?/ctx/admin/ctxsys.sql ctxsys system temp NOLOCK

--instalação os objetos do intermedia text no 10g
@?/ctx/admin/catctx.sql

--instalação da linguagem defualt do intermedia text no 10g 
connect CTXSYS/CTXSYS
-- portugues brasil
@?/ctx/admin/defaults/drdefptb.sql 
-- ingles
@?/ctx/admin/defaults/drdefus.sql 

--Install intermedia 10g outra opção (video, audio)
@?/ord/admin/ordinst.sql SYSAUX SYSAUX 

@?/ord/im/admin/iminst.sql 

--Testar o intermedia (video, audio)
@?/ord/im/admin/imchk.sql 

--como usuário ctxsys


--instalacao em outras versoes

@?/ctx/admin/dr0inst /opt/oracle/app/oracle/product/8.1.7/ctx/lib/libctxx8.so
@?/ctx/admin/defaults/drdefptb.sql

--Passo 2
CONNECT / AS SYSDBA; 
@?/ctx/admin/upgrade/s0801074.sql 
CONNECT ctxsys/<passwd> 
@?/ctx/admin/dr0pkh.sql 
@?/ctx/admin/dr0plb.sql 
@?/ctx/admin/dr0type.plb 
@?/ctx/admin/dr0typec.plb 
  
--Passo 3 (Verificar se está instalado) como usuario CTXSYS
column library_name format a8 
column file_spec format a60 wrap 
column object_name format a40 
column object_type format a20 

select object_type,count(*) 
from user_objects 
group by object_type; 

select object_name, object_type 
from user_objects 
where status = 'INVALID'; 

select library_name,file_spec,dynamic,status 
from user_libraries; 

--*******************************************
--Resultado da Consulta
--*******************************************

OBJECT_TYPE        COUNT(*) 
------------------ ---------- 
INDEX                      41 
INDEXTYPE                   2 
LIBRARY                     2 
LOB                         1 
OPERATOR                    3 
PACKAGE                    38 
PACKAGE BODY               32 
PROCEDURE                   1 
SEQUENCE                    3 
TABLE                      31 
TYPE                        5 
TYPE BODY                   4 
VIEW                       41 
  

no rows selected 
  

LIBRARY_ FILE_SPEC                                    STATUS 
-------- ------------------------------------------------------------ - ------- 
DR$LIB                                    &nbs VALID 
DR$LIBX  /oracle/db/dev118/ctx/lib/libctxx8.so                        Y VALID 

-------------------------------------------------------------------------------- 
  
--*******************************************

--Passo 4 (Teste)
------------------- Script text_quick_start.sql start ----------------------------- 
-- Create a user to work with interMedia Text 
create user textuser identified by textuser 
default tablespace tools 
temporary tablespace temp; 

-- You must grant 'ctxapp' role to textuser 
grant connect, resource, ctxapp to textuser; 

connect textuser/textuser@bdsede122

drop table quick; 

create table quick  ( 
    quick_id       number 
                   constraint quick_pk primary key, 
    text           varchar2(80)  ); 

insert into quick ( quick_id, text ) values (1,'The cat sat on the mat'); 
insert into quick ( quick_id, text ) values (2,'The quick brown fox jumps over the lazy dog' ); 
insert into quick ( quick_id, text ) values (3,'The dog barked like a dog'); 
commit; 

begin 
ctx_ddl.create_preference('mylex', 'BASIC_LEXER'); 
ctx_ddl.set_attribute ( 'mylex', 'index_themes', 'NO'); 
end; 
/ 

create index quick_text on quick ( text ) 
indextype is ctxsys.context parameters ('lexer mylex');

col text format a45 
col s format 999 
select text, score(42) s from quick 
where contains ( text, 'dog', 42 ) > 0 
order by s desc; 


drop user textuser;
------------------- Script text_quick_start.sql start ----------------------------- 
  


--******************************************
--instalar JVM

@?/javavm/install/initjvm.sql;
@?/xdk/admin/initxml.sql;
@?/xdk/admin/xmlja.sql; 
@?/rdbms/admin/catxsu.sql;
@?/javavm/install/init_jis.sql /u01/app/oracle/product/10.1; 
@?/javavm/install/jisaephc.sql /u01/app/oracle/product/10.1; 
@?/javavm/install/jisja.sql /u01/app/oracle/product/10.1; 
@?/javavm/install/jisdr.sql 2481 2482;
@?/jsp/install/initjsp.sql; 
@?/jsp/install/jspja.sql;
@?/rdbms/admin/initjms.sql;  
@?/rdbms/admin/initrapi.sql;  
@?/rdbms/admin/initsoxx.sql;  
@?/rdbms/admin/initapcx.sql;  
@?/rdbms/admin/initcdc.sql;
@?/rdbms/admin/initqsma.sql;
@?/rdbms/admin/initsjty.sql;
@?/rdbms/admin/initaqhp.sql;

select version, status from dba_registry where comp_id='JAVAVM';


--executa o ctxsrv na verssão 8i
ctxsrv -user ctxsys/intermedia_portal_infra_01 -personality M -log /u01/app/log/ctxsrv.log


UNRECOVERABLE LOAD data

ctxsrv -user ctxsys/intermedia_portal_infra_01 -logfile /ora05/inet/log
ctxsrv -user ctxsys/intermedia_portal_infra_01 -personality M -log /ora05/inet/ctxsrv.log & 


You can simply use a BEFORE SHUTDOWN TRIGGER created in the  CTXSYS schema that calls CTX_ADM.SHUTDOWN.  
Here is an example:  
CREATE OR REPLACE TRIGGER Stop_CtxSrv  
BEFORE SHUTDOWN ON DATABASE  
  BEGIN      
    Ctx_Adm.Shutdown();  
  END; 
/    


ctx_ddl.sync_index('<indexname>'); 