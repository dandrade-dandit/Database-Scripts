Prompt Atualizando PO.MLOG$_PO_LINES
UPDATE PO.MLOG$_PO_LINES A SET A.M_ROW$$=(SELECT ROWID  
FROM PO.PO_LINES B  WHERE B.PO_LINE_ID = A.PO_LINE_ID )
/
commit
/
spool off

exit
