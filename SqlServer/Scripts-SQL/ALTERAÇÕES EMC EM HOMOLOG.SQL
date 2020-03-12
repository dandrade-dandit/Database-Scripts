---*********************************************************************************************************************************
--HML DO ECM (10.0.17.155) - oraged
--NO INIT.ORA
*.log_buffer=16777216
*.session_cached_cursors=200
*.db_writer_processes=2
*.open_cursors=1000
*.processes=2500


--NO BD
create index ucm.idx_relatedcontent on ucm.relatedcontent(ddocname,dsource,dlinktypeid,disparent) tablespace tsd_idc_system;

create index ifrcorp.tab_empregados_ecm_idx1 on ifrcorp.tab_empregados_ecm(upper(cod_matricula)) tablespace tsd_geral;



alter table ucm.revisions cache;

alter table ucm.documents cache;

alter table ucm.docmeta cache;


alter database add logfile group 5 ('/u01/app/oracle/oradata/oraged/redo05.log') size 102400K;

alter database add logfile group 6 ('/u01/app/oracle/oradata/oraged/redo06.log') size 102400K;

alter database add logfile group 7 ('/u01/app/oracle/oradata/oraged/redo07.log') size 102400K;

alter database add logfile group 8 ('/u01/app/oracle/oradata/oraged/redo08.log') size 102400K;

alter database add logfile group 9 ('/u01/app/oracle/oradata/oraged/redo09.log') size 102400K;

---*********************************************************************************************************************************
--HML DO ECM (10.0.17.155) - oraged2
--NO INIT.ORA
*.log_buffer=16777216
*.session_cached_cursors=200
*.db_writer_processes=2
*.open_cursors=1000
*.processes=2500


--NO BD
create index ucm.idx_relatedcontent on ucm.relatedcontent(ddocname,dsource,dlinktypeid,disparent) tablespace tsd_idc_system;

create index ifrcorp.tab_empregados_ecm_idx1 on ifrcorp.tab_empregados_ecm(upper(cod_matricula)) tablespace tsd_geral;



alter table ucm.revisions cache;

alter table ucm.documents cache;

alter table ucm.docmeta cache;


alter database add logfile group 5 ('/u01/app/oracle/oradata/oraged2/redo05.log') size 102400K;

alter database add logfile group 6 ('/u01/app/oracle/oradata/oraged2/redo06.log') size 102400K;

alter database add logfile group 7 ('/u01/app/oracle/oradata/oraged2/redo07.log') size 102400K;

alter database add logfile group 8 ('/u01/app/oracle/oradata/oraged2/redo08.log') size 102400K;

alter database add logfile group 9 ('/u01/app/oracle/oradata/oraged2/redo09.log') size 102400K;

---*********************************************************************************************************************************
--HML DO IAS (10.0.17.160)
--NO INIT.ORA
*.log_buffer=16777216
*.session_cached_cursors=200
*.db_writer_processes=2
*.open_cursors=1000
*.processes=2500


--NO BD
alter database add logfile group 5 ('/u01/app/oradata/ecmias/redo05.log') size 102400K;

alter database add logfile group 6 ('/u01/app/oradata/ecmias/redo06.log') size 102400K;

alter database add logfile group 7 ('/u01/app/oradata/ecmias/redo07.log') size 102400K;

alter database add logfile group 8 ('/u01/app/oradata/ecmias/redo08.log') size 102400K;

alter database add logfile group 9 ('/u01/app/oradata/ecmias/redo09.log') size 102400K;

---*********************************************************************************************************************************