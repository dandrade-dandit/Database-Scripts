--Oracle Performance&Tuning
--Script's de Administração de Back-End
--Sessões Oracle por tipo de classificação

/*********GSF********GSF********GSF********GSF********GSF********GSF********/
/***************************************************************************/
/*                                                                         */
/* Propriedade: (Cliente)                                                  */
/* Autor      : Gesualdo Saudino Filho (GSF) E-mail: gsf@mandic.com.br     */
/* Data       : 08/02/1999                                                 */
/* GSF*EFB    : Esquema Fisico de Back-End                                 */
/* Arquivo    : vsesslog.sql                                               */
/* Descricao  : Sessoes Oracle por classificacao                           */
/* Modulo     : Performance&Tuning - Administracao                         */
/* Localizacao: ?path/oracle/7322/adm                                      */
/* Reponsabilidade    : Celula de Adm. de Banco de Dados                   */
/* Parametros Externos: Nao Ha                                             */
/* Alteracoes Efetuadas:                                                   */
/* SEQ#     DATA      AUTOR / SIGLA                 DETALHAMENTO           */
/* ----   ---------   ----------------------------  -----------------------*/
/*  01    98/Fev/99   Gesualdo Saudino Filho / GSF  Administracao          */
/*                                                                         */
/*********GSF********GSF********GSF********GSF********GSF********GSF********/
/***************************************************************************/

set verify off
set pagesize 45
set linesize 150
set feedback off
set showmode off
set echo off
set pause on
set pause 'Enter para continuar...'

REM ------------------------------------

set pause off

PROMPT
PROMPT Primerira selecao para classificacao
PROMPT ------------------------------------
 
PROMPT 1 = OS User
PROMPT 2 = Oracle User Name
PROMPT 3 = Pgm OS Pid
PROMPT 4 = Oracle OS Pid
PROMPT 5 = Oracle Session ID
PROMPT 6 = Serial#
PROMPT 7 = Program Name
PROMPT 8 = Server Type
ACCEPT USER_INPUT1 NUMBER PROMPT 'Informe a opcao desejada:> '
col sort_by_number1 new_value sort_by_number_value1 noprint
col sort_by_text1   new_value sort_by_text_value1   noprint
select decode(&USER_INPUT1, 1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7, 8,8, 8) 
sort_by_number1,
       decode(&USER_INPUT1, 1,'OS User',
                            2,'Oracle User Name',
                            3,'Pgm OS Pid',
                            4,'Oracle OS Pid',
                            5,'Oracle Session ID',
                            6,'Serial#',
                            7,'Program Name',
                            8,'Server Type',
                            'Server Type') sort_by_text1
from dual;
 
REM ------------------------------------

PROMPT
PROMPT Segunda selecao para classificacao
PROMPT ----------------------------------
 
PROMPT 1 = OS User
PROMPT 2 = Oracle User Name
PROMPT 3 = Pgm OS Pid
PROMPT 4 = Oracle OS Pid
PROMPT 5 = Oracle Session ID
PROMPT 6 = Serial#
PROMPT 7 = Program Name
PROMPT 8 = Server Type 
ACCEPT USER_INPUT2 NUMBER PROMPT 'Informe a opcao desejada:> '
col sort_by_number2 new_value sort_by_number_value2 noprint
col sort_by_text2   new_value sort_by_text_value2   noprint
select decode(&USER_INPUT2, 1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7, 8,8, 8) 
sort_by_number2,
       decode(&USER_INPUT2, 1,'OS User',
                            2,'Oracle User Name',
                            3,'Pgm OS Pid',
                            4,'Oracle OS Pid',
                            5,'Oracle Session ID',
                            6,'Serial#',
                            7,'Program Name',
                            8,'Server Type',
                            'Server Type') sort_by_text2
from dual; 

set pause on

REM ------------------------------------
 
col bb heading "OS|User|Name"          format a10
col cc heading "Oracle|User|Name"      format a12
col dd heading "Pgm|OS|Pid"            format a7
col ee heading "Oracle|OS|Pid"         format a7
col ef heading "Oracle|Session|ID"     format 999999
col eg heading "Serial#"               format 999999
col gg heading "Program Name"          format a16
col ii heading "Server|Type"           format a9
col hh heading "Logon|Time"            format a20
col jj heading "Client|Machine"        format a10
col kk heading "Idle Time"             format a35
ttitle "Todas as Sessoes de Usuarios Oracle|Classificada: &sort_by_text_value1, &sort_by_text_value2"
select vs.osuser bb,
       vs.username cc,
       vs.process dd,
       vp.spid ee,
       vs.sid ef,
       vs.serial# eg,
       substr(vs.program,1,16) gg,
       vs.server ii,
       to_char(vs.logon_time,'DD-MON-YYYY HH24:MI:SS') hh,
       vs.machine jj,
       trunc(LAST_CALL_ET/86400) || ' Days ' ||
       trunc(mod(LAST_CALL_ET,86400)/3600) || ' Hours ' ||
       trunc(mod(mod(LAST_CALL_ET,86400),3600)/60) || ' Min. ' ||
       mod(mod(mod(LAST_CALL_ET,86400),3600),60) || ' Sec. ' kk
  from v$process vp, v$session vs
 where vs.paddr = vp.addr
   and not exists ( select 'x'
                     from v$bgprocess vbg
                    where vbg.paddr != '00'
                      and vbg.paddr  = vp.addr)
 order by &sort_by_number_value1, &sort_by_number_value2;

