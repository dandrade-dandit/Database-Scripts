IFRDBA@bdsede131 SQL>@SOS_CRIA_TUDO.SQL
DIGITE O NOME DO OWNER: IFRSRH
IFRDBA@bdsede131 SQL>ACCEPT OK

IFRDBA@bdsede131 SQL>set echo off;
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\AGENDA_MED_ODO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'AGENDA_MED_ODO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'AGENDA_MED_ODO'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\ATIV_EMPREGADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from  
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'ATIV_EMPREGADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'ATIV_EMPREGADOS'  
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\CADASTRO_FREQUENCIA.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'CADASTRO_FREQUENCIA' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'CADASTRO_FREQUENCIA' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\CADASTRO_OCORRENCIAS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'  
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'CADASTRO_OCORRENCIAS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =               
'CADASTRO_OCORRENCIAS' ;
select '/' from dual;
spool off; 
                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\CAD_MAXIMO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from       
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'CAD_MAXIMO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'CAD_MAXIMO' ;
select   
'/' from dual;
spool off; 
                                                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from       
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'EMPREGADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'EMPREGADOS' ;
select   
'/' from dual;
spool off; 
                                                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS_CAD.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'EMPREGADOS_CAD' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'EMPREGADOS_CAD'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS_CNMN.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from  
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'EMPREGADOS_CNMN' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'EMPREGADOS_CNMN'  
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS_GERDOC.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'EMPREGADOS_GERDOC' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'EMPREGADOS_GERDOC' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS_INFRAERO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'EMPREGADOS_INFRAERO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'EMPREGADOS_INFRAERO' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\EMPREGADOS_SUBORDINADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner       
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'EMPREGADOS_SUBORDINADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name 
= 'EMPREGADOS_SUBORDINADOS' ;
select '/' from dual;
spool off; 
                                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\FUNCOES.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from          
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'FUNCOES' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'FUNCOES' ;
select '/' from
dual;
spool off; 
                                                                                                                 
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\HORAS_EXTRAS_COMP.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'HORAS_EXTRAS_COMP' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'HORAS_EXTRAS_COMP' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\HORAS_EXTRAS_PAG.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from 
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'HORAS_EXTRAS_PAG' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'HORAS_EXTRAS_PAG'
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\MOV_PROVENTOS_DESCONTOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner       
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'MOV_PROVENTOS_DESCONTOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name 
= 'MOV_PROVENTOS_DESCONTOS' ;
select '/' from dual;
spool off; 
                                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\OCORRENCIAS_AC_FA_FN.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'  
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'OCORRENCIAS_AC_FA_FN' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =               
'OCORRENCIAS_AC_FA_FN' ;
select '/' from dual;
spool off; 
                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\OCORRENCIAS_FUNCIONAIS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'OCORRENCIAS_FUNCIONAIS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =             
'OCORRENCIAS_FUNCIONAIS' ;
select '/' from dual;
spool off; 
                                                                      
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\OCORRENCIAS_REEMBOLSOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'OCORRENCIAS_REEMBOLSOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =             
'OCORRENCIAS_REEMBOLSOS' ;
select '/' from dual;
spool off; 
                                                                      
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\QUADRO_CARGOS_DEP_VIEW.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'QUADRO_CARGOS_DEP_VIEW' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =             
'QUADRO_CARGOS_DEP_VIEW' ;
select '/' from dual;
spool off; 
                                                                      
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\SALDOS_TRATAMENTOS_ODONT.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner      
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'SALDOS_TRATAMENTOS_ODONT' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name
= 'SALDOS_TRATAMENTOS_ODONT' ;
select '/' from dual;
spool off; 
                                                                  
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\SIAD_VIEW_AVALIACAO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'SIAD_VIEW_AVALIACAO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'SIAD_VIEW_AVALIACAO' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\SST_EMP_ATIVIDADE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'SST_EMP_ATIVIDADE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'SST_EMP_ATIVIDADE' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_ADMITIDOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_ADMITIDOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_ADMITIDOS'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_APOSENTADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from 
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_APOSENTADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_APOSENTADOS'
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_ATIVOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from      
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_ATIVOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_ATIVOS' ;
select 
'/' from dual;
spool off; 
                                                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_CEDIDOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from     
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_CEDIDOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_CEDIDOS'        
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_DEMITIDOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_DEMITIDOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_DEMITIDOS'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_REINTEGRADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_REINTEGRADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIEW_REINTEGRADOS' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_REQUISITADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_REQUISITADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIEW_REQUISITADOS' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_SUB_JUDICE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from  
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_SUB_JUDICE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIEW_SUB_JUDICE'  
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIEW_TRANSFERIDOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIEW_TRANSFERIDOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIEW_TRANSFERIDOS' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ACONSULTA.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from    
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_ACONSULTA' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_ACONSULTA'      
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ADMITIDOS_EFETIVO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' 
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_ADMITIDOS_EFETIVO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =              
'VIW_ADMITIDOS_EFETIVO' ;
select '/' from dual;
spool off; 
                                                                       
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ATIVIDADE_CARGO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_ATIVIDADE_CARGO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'VIW_ATIVIDADE_CARGO' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ATIVOS_L.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from     
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_ATIVOS_L' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_ATIVOS_L'        
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_CADASTRO_DW.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from  
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_CADASTRO_DW' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_CADASTRO_DW'  
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_MED_DMH.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner     
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_MED_DMH' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and           
v.view_name = 'VIW_DEMONST_CUSTO_MED_DMH' ;
select '/' from dual;
spool off; 
                                                     
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_MED_DMO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner     
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_MED_DMO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and           
v.view_name = 'VIW_DEMONST_CUSTO_MED_DMO' ;
select '/' from dual;
spool off; 
                                                     
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_MED_GPR.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner     
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_MED_GPR' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and           
v.view_name = 'VIW_DEMONST_CUSTO_MED_GPR' ;
select '/' from dual;
spool off; 
                                                     
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_MED_REE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner     
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_MED_REE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and           
v.view_name = 'VIW_DEMONST_CUSTO_MED_REE' ;
select '/' from dual;
spool off; 
                                                     
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_MED_TDM.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner     
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_MED_TDM' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and           
v.view_name = 'VIW_DEMONST_CUSTO_MED_TDM' ;
select '/' from dual;
spool off; 
                                                     
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_PAT_CANC.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner    
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_PAT_CANC' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and          
v.view_name = 'VIW_DEMONST_CUSTO_PAT_CANC' ;
select '/' from dual;
spool off; 
                                                    
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_PAT_DEVOLV.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner  
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_PAT_DEVOLV' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and        
v.view_name = 'VIW_DEMONST_CUSTO_PAT_DEVOLV' ;
select '/' from dual;
spool off; 
                                                  
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_PAT_NAO_CANC.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_PAT_NAO_CANC' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and      
v.view_name = 'VIW_DEMONST_CUSTO_PAT_NAO_CANC' ;
select '/' from dual;
spool off; 
                                                
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_TVT_CANCEL.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner  
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_TVT_CANCEL' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and        
v.view_name = 'VIW_DEMONST_CUSTO_TVT_CANCEL' ;
select '/' from dual;
spool off; 
                                                  
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_TVT_DEVOLV.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner  
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_TVT_DEVOLV' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and        
v.view_name = 'VIW_DEMONST_CUSTO_TVT_DEVOLV' ;
select '/' from dual;
spool off; 
                                                  
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONST_CUSTO_TVT_NAO_CANC.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONST_CUSTO_TVT_NAO_CANC' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and      
v.view_name = 'VIW_DEMONST_CUSTO_TVT_NAO_CANC' ;
select '/' from dual;
spool off; 
                                                
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_CRE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_CRE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_CRE' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_FUN.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_FUN' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_FUN' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_ODO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_ODO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_ODO' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_PRS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_PRS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_PRS' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_TCT.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_TCT' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_TCT' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEMONSTRATIVO_CUSTO_TPE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_TPE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_DEMONSTRATIVO_CUSTO_TPE' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEM_PPP.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from      
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_DEM_PPP' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_DEM_PPP' ;
select 
'/' from dual;
spool off; 
                                                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DEP_PORTAL.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_DEP_PORTAL' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_DEP_PORTAL'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DESLIGADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_DESLIGADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_DESLIGADOS'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DIRETORIAS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_DIRETORIAS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_DIRETORIAS'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DISPON_FERIAS_CONFIRMADO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner  
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DISPON_FERIAS_CONFIRMADO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and        
v.view_name = 'VIW_DISPON_FERIAS_CONFIRMADO' ;
select '/' from dual;
spool off; 
                                                  
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DISPON_FERIAS_PREVISAO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner    
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_DISPON_FERIAS_PREVISAO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and          
v.view_name = 'VIW_DISPON_FERIAS_PREVISAO' ;
select '/' from dual;
spool off; 
                                                    
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_DISPON_FOLGAS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_DISPON_FOLGAS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIW_DISPON_FOLGAS' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMP_INTEGRASS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_EMP_INTEGRASS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIW_EMP_INTEGRASS' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_EMPREGADOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_EMPREGADOS'    
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_ECM.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'    
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_ECM' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                 
'VIW_EMPREGADOS_ECM' ;
select '/' from dual;
spool off; 
                                                                          
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADO_SICST.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADO_SICST' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'VIW_EMPREGADO_SICST' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_IFRSEG.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' 
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_IFRSEG' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =              
'VIW_EMPREGADOS_IFRSEG' ;
select '/' from dual;
spool off; 
                                                                       
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_NOTES.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'  
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_NOTES' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =               
'VIW_EMPREGADOS_NOTES' ;
select '/' from dual;
spool off; 
                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_NTB.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'    
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_NTB' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                 
'VIW_EMPREGADOS_NTB' ;
select '/' from dual;
spool off; 
                                                                          
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_PORTAL.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' 
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_PORTAL' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =              
'VIW_EMPREGADOS_PORTAL' ;
select '/' from dual;
spool off; 
                                                                       
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_SIAAM.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'  
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_SIAAM' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =               
'VIW_EMPREGADOS_SIAAM' ;
select '/' from dual;
spool off; 
                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_EMPREGADOS_SIPRECO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_EMPREGADOS_SIPRECO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =             
'VIW_EMPREGADOS_SIPRECO' ;
select '/' from dual;
spool off; 
                                                                      
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_FICHA_EMP.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from    
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_FICHA_EMP' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_FICHA_EMP'      
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_FORMACOES_PROF.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'    
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_FORMACOES_PROF' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                 
'VIW_FORMACOES_PROF' ;
select '/' from dual;
spool off; 
                                                                          
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_HST_OCORRENCIAS_CARGOS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner    
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_HST_OCORRENCIAS_CARGOS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and          
v.view_name = 'VIW_HST_OCORRENCIAS_CARGOS' ;
select '/' from dual;
spool off; 
                                                    
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_HST_OCORRENCIAS_FUNCAO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner    
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_HST_OCORRENCIAS_FUNCAO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and          
v.view_name = 'VIW_HST_OCORRENCIAS_FUNCAO' ;
select '/' from dual;
spool off; 
                                                    
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_LOCK_PRODSEDE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_LOCK_PRODSEDE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                  
'VIW_LOCK_PRODSEDE' ;
select '/' from dual;
spool off; 
                                                                           
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_LOCK_PRODSEDE_ROLE.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_LOCK_PRODSEDE_ROLE' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =             
'VIW_LOCK_PRODSEDE_ROLE' ;
select '/' from dual;
spool off; 
                                                                      
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_OCORRENCIAS_AFASTAMENTO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_OCORRENCIAS_AFASTAMENTO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_OCORRENCIAS_AFASTAMENTO' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_PENULT_UOR_EMPREGADO_SICST.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_PENULT_UOR_EMPREGADO_SICST' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and      
v.view_name = 'VIW_PENULT_UOR_EMPREGADO_SICST' ;
select '/' from dual;
spool off; 
                                                
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_PPP_DEPENDENCIAS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'  
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_PPP_DEPENDENCIAS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =               
'VIW_PPP_DEPENDENCIAS' ;
select '/' from dual;
spool off; 
                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_PPP_RJ.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from       
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_PPP_RJ' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_PPP_RJ' ;
select   
'/' from dual;
spool off; 
                                                                                                        
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_PRPG_EMP_FUNCAO.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_PRPG_EMP_FUNCAO' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'VIW_PRPG_EMP_FUNCAO' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_RELACAO_FUNCOES.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH'   
from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and  
v.view_name = 'VIW_RELACAO_FUNCOES' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name =                
'VIW_RELACAO_FUNCOES' ;
select '/' from dual;
spool off; 
                                                                         
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_SESSIONS.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from     
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_SESSIONS' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_SESSIONS'        
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_TERCEIROS_RH.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from 
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_TERCEIROS_RH' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_TERCEIROS_RH'
;
select '/' from dual;
spool off; 
                                                                                               
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ULT_INATIV_EMPREGADO_SICST.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_ULT_INATIV_EMPREGADO_SICST' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and      
v.view_name = 'VIW_ULT_INATIV_EMPREGADO_SICST' ;
select '/' from dual;
spool off; 
                                                
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_ULT_UOR_EMPREGADO_SICST.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner   
IFRSRH' from dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =        
'IFRSRH' and v.view_name = 'VIW_ULT_UOR_EMPREGADO_SICST' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and         
v.view_name = 'VIW_ULT_UOR_EMPREGADO_SICST' ;
select '/' from dual;
spool off; 
                                                   
set termout off;
set echo off;
set pagesize 1000;
col s_path new_value f_path;
col text format a150 wrapped;
select                 
'IFRSRH\views\VIW_UOR_PORTAL.sql' AS s_path from dual;
spool d:\scripts\&f_path;
set termout on;
select '--### owner IFRSRH' from   
dual;
select 'CREATE OR REPLACE '|| V.owner || '.' ||V.view_name || '  IS'   from dba_views V 
 where V.owner =  'IFRSRH' and       
v.view_name = 'VIW_UOR_PORTAL' ;
select V.text   from dba_views V 
 where V.owner =  'IFRSRH' and v.view_name = 'VIW_UOR_PORTAL'    
;
select '/' from dual;
spool off; 
                                                                                               
declare
*
ERRO na linha 1:
ORA-01791: not a SELECTed expression 
ORA-06512: at line 13 
ORA-06512: at line 81 


IFRDBA@bdsede131 SQL>SPO OFF
