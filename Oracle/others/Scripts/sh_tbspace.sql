 rem |   Gera relatório (sh_&tbspace.lis) com as informações das
 rem |       tablespaces do bd connectado
 rem |
 rem | parametros: nome da tablespace
 rem |

 
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 ACCEPT tabe PROMPT 'DIGITE O NOME DA TABLESPACE: '
 spool q:\scripts\sh_&tabe..lis

 select *
 from dba_tablespaces
 where tablespace_name = '&tabe'
/
 select *
 from dba_data_files
 where tablespace_name = '&tabe'
/
 break on owner skip 1
 select owner,segment_type,segment_name,
        header_file,header_block,bytes,blocks,extents
 from dba_segments
 where tablespace_name = '&tabe' 
 order by owner,segment_type,segment_name
/
 break on owner skip 1
 select owner,segment_type,segment_name,
        file_id,extent_id,block_id,bytes,blocks
 from  dba_extents
 where tablespace_name = '&tabe' 
 order by owner,segment_type,segment_name
/
 spool off