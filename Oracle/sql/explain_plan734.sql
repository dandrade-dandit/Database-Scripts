/****plan table 7.3.4****/
create table PLAN_TABLE (
statement_id   	 varchar2(30),
timestamp		date,
remarks		varchar2(80),
operation       	varchar2(30),
options         	varchar2(30),
object_node     	varchar2(128), 
object_owner    	varchar2(30),
object_name     	varchar2(30),
object_instance 	numeric,
object_type     	varchar2(30),
optimizer       	varchar2(255),
search_columns 	numeric,
id             		numeric,
parent_id      	numeric,
position        	numeric,
other           	long);


EXPLAIN PLAN
SET STATEMENT_ID = 'MVM'
FOR...... 


SELECT LPAD(' ',2*(LEVEL-1))||operation||' '||options
   ||' '||object_name
   ||' '||DECODE(id, 0, 'Cost = '||position) "Query Plan"
FROM plan_table
START WITH id = 0 AND statement_id = 'MVM'
CONNECT BY PRIOR id = parent_id AND statement_id ='MVM'; 




EXPLAIN PLAN
SET STATEMENT_ID = 'MVM'
FOR
select *
from ordem_servico
        where (aa_ordem_servico, nr_ordem_servico, dep_cd_dependencia) in
              (select os_aa_ordem_servico, os_nr_ordem_servico, ipd_dep_cd_dependencia
              from item_requisicao
              where  ipd_dep_cd_dependencia = 901
                and  ipd_ig_ci_cd_classe = 5310
                and  ipd_ig_cd_item = '0173419');