set serveroutput on
begin
   if dbms_audit_mgmt.IS_CLEANUP_INITIALIZED(
      audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD) then
      dbms_audit_mgmt.DEINIT_CLEANUP(
      audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD);
      dbms_output.put_line('DEINIT_CLEANUP for AUDIT_TRAIL_AUD_STD');
  end if;
end;
/