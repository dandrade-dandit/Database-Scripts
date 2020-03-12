BEGIN
   DBMS_REFRESH.MAKE (
      name => 'IFRTECA.TKPREFRESHSP',
      list => 'TKPSANPSP_MOV_RECEBIMENTO,TKPSANPSP_MOV_FINANCEIRO,TKPSANPSP_MOV_ENTREGA',
      next_date => SYSDATE, 
      interval => '(TRUNC(sysdate) + 1) + 0/24',
      implicit_destroy => FALSE, 
      rollback_seg => '',
      push_deferred_rpc => TRUE, 
      refresh_after_errors => FALSE);
END;
/

