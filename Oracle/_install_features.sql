select comp_name "Component" from dba_registry;

--XDB
catqm lambda sysaux temp

--CTXSYS --BUSCA TEXTUAL
@catctx.sql ctxsys sysaux temp nolock

--MDSYS -- ORACLE SPACIAL
@?/md/admin/mdinst.sql 

--ORDSYS --INTERMEDIA
@?/ord/admin/ordinst.sql SYSAUX SYSAUX


@wk0setup.sql /u01/app/OraHome_1 "" SYS <senha_SYS> "as sysdba" wksys SYSAUX TEMP "" "FALSE" DATABASE "" /u01/app/OraHome_1/jdbc/lib/classes12.zip /u01/app/OraHome_1/jlib/orai18n.jar /u01/app/OraHome_1/jdk/bin/java /u01/app/OraHome_1/ctx/bin/ctxhx 10.0.17.196:1521:ecmias 10.0.17.196:1521:ecmias /u01/app/OraHome_1