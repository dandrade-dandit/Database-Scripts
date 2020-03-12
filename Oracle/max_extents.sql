/****script para gerar a porcentagem de
extents ocupados pelos segmentos do oracle***/

column owner format a15
column segment_name format a30
column segment_type format a12
set echo off
set linesize 100
set pagesize 1000

select 
	segment_type,
	owner,
	segment_name,
	max_extents,
        extents,
	round(extents*100/max_extents) pct_ocupada
from 	
	dba_segments
WHERE 
	extents*100/max_extents > 50
and
	max_extents <> 0
order by pct_ocupada desc
/

/**************gera script para correcao dos itens encontrados acima*******************/
select 'alter '||segment_type||' '||owner||'.'||segment_name||' storage (maxextents '||round(max_extents*120/100)||');' comando
from 	
	dba_segments
WHERE 
	extents*100/max_extents > 70
and
	max_extents <> 0
order by 
	round(extents*100/max_extents) desc
/
