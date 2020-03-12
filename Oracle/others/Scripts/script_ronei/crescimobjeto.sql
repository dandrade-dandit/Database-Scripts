-- parametrização necessaria
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK Off
 SET PAGESIZE 1000

 variable var varchar2(100);
 begin
    select 'C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\Cresc_'||
           rtrim(upper(global_name),'.WORLD')||'_'||
           to_char(sysdate,'YYYY_MM_DD_HH24_MI')||'.log'
    into :var from global_name;
 end;
/
 
 SET SERVEROUTPUT ON SIZE 100000
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\Xroda.tmp

BEGIN 
  dbms_output.put_line ('spool '||:var);
end;
/
spool off
set serveroutput off
@C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\Xroda.tmp
host del C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\Xroda.tmp

set echo on;

select 'CRESCIMENTO DA ÁREA EM DISCO',
     tablespace_name, sum(bytes) Ocupado
     from sys.dba_segments
     group by tablespace_name
--
--Intervalo: 1 vez por semana ou mais.
/


select 'CRESCIMENTO DOS OBJETOS DO BANCO DE DADOS',
                owner Dono,
                segment_type Tipo,
                segment_name Nome,
                bytes Tamanho,
                extents Extensoes
    from sys.dba_segments
    order by 1,2,3
--
--Intervalo: 1 vez por semana ou mais.
/



select 'CRESCIMENTO DAS TABELAS DO BANCO DE DADOS' from dual
/
--
analyze table <t> compute statistics
--
select owner Dono,
                table_name Tabela,
                num_rows Linhas,
                avg_row_len TamMedio
      from sys.dba_tables
      order by 1,2
--
--Intervalo: 1 vez por semana ou mais.
/



select 'NÚMERO DE TRANSAÇÕES ORACLE',
     sum(value)
     from v$sysstat
     where name in ('user commits', 'user rollbacks')
--
--Intervalo: De 20 em 20 minutos.
/


select 'NÚMERO DE USUÁRIOS CONECTADOS',
     count(*)-1
     from v$session
     where type = 'USER'
--
--Intervalo: De 20 em 20 minutos.
/



select 'CRESCIMENTO DA SGA', * from v$sga
--
--Intervalo: 1 vez por dia ou mais.
/



      col name for a40
      col value for a40

      select 'PARÂMETROS DE INICIALIZAÇÃO',
      name, value, description
      from v$parameter
--
--Intervalo: 1 vez por dia ou mais.
/		
spool off;
exit