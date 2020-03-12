 set echo on
 rem |   Gera LOG ('path\arq'.log) 
 rem |   Obs: o arquivo deve ter a extensão .sql
 rem |
 rem | parametros: path\arquivo (sem extensão)
 rem |
 set echo off
 
 set line 132
 set pause off
 SET PAGESIZE 1000
 ACCEPT dono PROMPT 'DIGITE O PATH/NOME DO ARQUIVO (sem .extensão): '
 
 spool &dono..log
 disconnect
 connect sysman@prodbr
 select '*****---** prod BR start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod BR stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodpa
 select '*****---** prod PA start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod PA stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodrj
 select '*****---** prod RJ start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod RJ stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodsp
 select '*****---** prod SP start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod SP stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodrf
 select '*****---** prod RF start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod RF stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodbe
 select '*****---** prod BE start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod BE stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodmn
 select '*****---** prod MN start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod MN stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 disconnect
 connect sysman@prodsede
 select '*****---** prod SEDE start:'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 @&dono
 select '*****---** prod SEDE stop :'||to_char(sysdate, 'DD-MM-YYYY HH:MI:SS') now from dual;
 spool off
 disconnect
