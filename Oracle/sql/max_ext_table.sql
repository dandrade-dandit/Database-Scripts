col onwer for a15
col segment_name for a30

undef tab
undef own
accept own char prompt 'Entre com o owner : '
accept tab char prompt 'Entre com a tabela: '

select 	b.owner,
	a.segment_name,
       	a.TotalUsu,
       	b.max_extents TotalAloc
from (Select segment_name, count(1) as TotalUsu 
      from dba_extents
      where segment_name = upper('&tab')
      and   owner        = upper('&own')
      group by segment_name ) a,
     dba_tables b
where a.segment_name = b.table_name
order by 1,2,3
/