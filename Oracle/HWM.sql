DECLARE 
	v_owner varchar2(30) := 'IFRMAXIMO';
	v_segment_name varchar2(30) := 'WORKORDER';
	v_segment_type varchar2(30) := 'TABLE';
	v_total_blocks number;
	v_total_bytes number;
	v_unused_blocks number;
	v_unused_bytes number;
	v_last_used_extent_file_id number;
	v_last_used_extent_block_id number;
	v_last_used_block number;
	BEGIN
		dbms_space.unused_space (v_owner,
		 	v_segment_name,
                 	v_segment_type,
                 	v_total_blocks,
                 	v_total_bytes,
                 	v_unused_blocks,    
                        v_unused_bytes,     
                        v_last_used_extent_file_id,
                        v_last_used_extent_block_id,
                        v_last_used_block
                );
                dbms_output.put_line(' ');
                dbms_output.put_line('**************************************************************************');
                dbms_output.put_line(INITCAP(v_segment_type) || ' : ' || v_owner ||'.'|| v_segment_name);
                dbms_output.put_line('Total Blocks : ' || TO_CHAR(v_total_blocks));
                dbms_output.put_line('Blocks acima HWM : ' || TO_CHAR(v_unused_blocks));
                dbms_output.put_line('**************************************************************************');
        END;
/

--**************************************************************************************************************************************

set serveroutput on 

declare
v_unformatted_blocks number;
v_unformatted_bytes number;
v_fs1_blocks number;
v_fs1_bytes number;
v_fs2_blocks number;
v_fs2_bytes number;
v_fs3_blocks number;
v_fs3_bytes number;
v_fs4_blocks number;
v_fs4_bytes number;
v_full_blocks number;
v_full_bytes number;

begin
     dbms_space.space_usage (
       'IFRMAXIMO', 
       'WOANCESTOR', 
       'TABLE', 
       v_unformatted_blocks,
       v_unformatted_bytes, 
       v_fs1_blocks, 
       v_fs1_bytes, 
       v_fs2_blocks, 
       v_fs2_bytes,
       v_fs3_blocks, 
       v_fs3_bytes, 
       v_fs4_blocks, 
       v_fs4_bytes, 
       v_full_blocks, 
       v_full_bytes,
       NULL);

     dbms_output.put_line('Unformatted Blocks                       = '||v_unformatted_blocks);
     dbms_output.put_line('Blocks with 00-25% free space   = '||v_fs1_blocks);
     dbms_output.put_line('Blocks with 26-50% free space   = '||v_fs2_blocks);
     dbms_output.put_line('Blocks with 51-75% free space   = '||v_fs3_blocks);
     dbms_output.put_line('Blocks with 76-100% free space = '||v_fs4_blocks);
     dbms_output.put_line('Full Blocks                                        = '||v_full_blocks);

end;
/
