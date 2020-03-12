CREATE OR REPLACE VIEW sys.dba_objects_eng (
   owner,
   object_name,
   subobject_name,
   object_id,
   data_object_id,
   object_type,
   created,
   last_ddl_time,
   timestamp,
   status,
   temporary,
   generated,
   secondary )
AS
select u.name, o.name, o.subname, o.obj#, o.dataobj#,
       decode(o.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
                      4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
                      7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
                      11, 'PACKAGE BODY', 12, 'TRIGGER',
                      13, 'TYPE', 14, 'TYPE BODY',
                      19, 'TABLE PARTITION', 20, 'INDEX PARTITION', 21, 'LOB',
                      22, 'LIBRARY', 23, 'DIRECTORY', 24, 'QUEUE',
                      28, 'JAVA SOURCE', 29, 'JAVA CLASS', 30, 'JAVA RESOURCE',
                      32, 'INDEXTYPE', 33, 'OPERATOR',
                      34, 'TABLE SUBPARTITION', 35, 'INDEX SUBPARTITION',
                      40, 'LOB PARTITION', 41, 'LOB SUBPARTITION',
                      42, 'MATERIALIZED VIEW',
                      43, 'DIMENSION',
                      44, 'CONTEXT', 46, 'RULE SET', 47, 'RESOURCE PLAN',
                      48, 'CONSUMER GROUP',
                      51, 'SUBSCRIPTION', 52, 'LOCATION',
                      55, 'XML SCHEMA', 56, 'JAVA DATA',
                      57, 'SECURITY PROFILE', 59, 'RULE',
                      62, 'EVALUATION CONTEXT',
                     'UNDEFINED'),
       o.ctime, o.mtime,
       to_char(o.stime, 'YYYY-MM-DD:HH24:MI:SS'),
       decode(o.status, 0, 'N/A', 1, 'VALID', 'INVALID'),
       decode(bitand(o.flags, 2), 0, 'N', 2, 'Y', 'N'),
       decode(bitand(o.flags, 4), 0, 'N', 4, 'Y', 'N'),
       decode(bitand(o.flags, 16), 0, 'N', 16, 'Y', 'N')
from sys.obj$ o, sys.user$ u
where o.owner# = u.user#
  and o.linkname is null
  and (o.type# not in (1  /* INDEX - handled below */,
                      10 /* NON-EXISTENT */)
       or
       (o.type# = 1 and 1 = (select 1
                              from sys.ind$ i
                             where i.obj# = o.obj#
                               and i.type# in (1, 2, 3, 4, 6, 7, 9))))
  and o.name != '_NEXT_OBJECT'
  and o.name != '_default_auditing_options_'
union all
select u.name, l.name, NULL, to_number(null), to_number(null),
       'DATABASE LINK',
       l.ctime, to_date(null), NULL, 'VALID','N','N', 'N'
from sys.link$ l, sys.user$ u
where l.owner# = u.user# and u.name in ('IFRBDE','IFRBDE_VIEWS','INTEGRACAO','IFRSEG')
/

-- Grants for View
GRANT SELECT ON sys.dba_objects_eng TO eng_desenv
/

CREATE OR REPLACE VIEW sys.dba_source_eng (
   owner,
   name,
   type,
   line,
   text )
AS
select u.name, o.name,
decode(o.type#, 7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
               11, 'PACKAGE BODY', 12, 'TRIGGER', 13, 'TYPE', 14, 'TYPE BODY',
               'UNDEFINED'),
s.line, s.source
from sys.obj$ o, sys.source$ s, sys.user$ u
where o.obj# = s.obj#
  and o.owner# = u.user#
  and o.type# in (7, 8, 9, 11, 12, 13, 14)
union all
select /*+ ORDERED */ u.name, o.name, 'JAVA SOURCE', s.joxftlno, s.joxftsrc
from sys.obj$ o, x$joxfs s, sys.user$ u
where o.obj# = s.joxftobn
  and o.owner# = u.user#
  and o.type# = 28 and u.name in ('IFRBDE','IFRBDE_VIEWS','INTEGRACAO','IFRSEG')
/

-- Grants for View
GRANT SELECT ON sys.dba_source_eng TO eng_desenv
/

CREATE OR REPLACE VIEW sys.dba_triggers_eng (
   owner,
   trigger_name,
   trigger_type,
   triggering_event,
   table_owner,
   base_object_type,
   table_name,
   column_name,
   referencing_names,
   when_clause,
   status,
   description,
   action_type,
   trigger_body )
AS
select trigusr.name, trigobj.name,
decode(t.type#, 0, 'BEFORE STATEMENT',
                1, 'BEFORE EACH ROW',
                2, 'AFTER STATEMENT',
                3, 'AFTER EACH ROW',
                4, 'INSTEAD OF',
                   'UNDEFINED'),
decode(t.insert$*100 + t.update$*10 + t.delete$,
                 100, 'INSERT',
                 010, 'UPDATE',
                 001, 'DELETE',
                 110, 'INSERT OR UPDATE',
                 101, 'INSERT OR DELETE',
                 011, 'UPDATE OR DELETE',
                 111, 'INSERT OR UPDATE OR DELETE', 'ERROR'),
tabusr.name,
decode(bitand(t.property, 1), 1, 'VIEW',
                              0, 'TABLE',
                                 'UNDEFINED'),
tabobj.name, NULL,
'REFERENCING NEW AS '||t.refnewname||' OLD AS '||t.refoldname,
t.whenclause,decode(t.enabled, 0, 'DISABLED', 1, 'ENABLED', 'ERROR'),
t.definition,
decode(bitand(t.property, 2), 2, 'CALL',
                                 'PL/SQL     '),
t.action#
from sys.obj$ trigobj, sys.obj$ tabobj, sys.trigger$ t,
     sys.user$ tabusr, sys.user$ trigusr
where (trigobj.obj#   = t.obj# and
       tabobj.obj#    = t.baseobject and
       tabobj.owner#  = tabusr.user# and
       trigobj.owner# = trigusr.user# and
       bitand(t.property, 63)     < 8 )
union all
select trigusr.name, trigobj.name,
decode(t.type#, 0, 'BEFORE EVENT',
                2, 'AFTER EVENT',
                   'UNDEFINED'),
decode(bitand(t.sys_evts, 1), 1, 'STARTUP ') ||
decode(bitand(t.sys_evts, 2), 2,
       decode(sign(bitand(t.sys_evts, 1)), 1, 'OR SHUTDOWN ',
                                               'SHUTDOWN ')) ||
decode(bitand(t.sys_evts, 4), 4,
       decode(sign(bitand(t.sys_evts, 3)), 1, 'OR ERROR ',
					      'ERROR ')) ||
decode(bitand(t.sys_evts, 8), 8,
       decode(sign(bitand(t.sys_evts, 7)), 1, 'OR LOGON ',
                                              'LOGON ')) ||
decode(bitand(t.sys_evts, 16), 16,
       decode(sign(bitand(t.sys_evts, 15)), 1, 'OR LOGOFF ',
                                               'LOGOFF ')) ||
decode(bitand(t.sys_evts, 262176), 32,
       decode(sign(bitand(t.sys_evts, 31)), 1, 'OR CREATE ',
                                               'CREATE ')) ||
decode(bitand(t.sys_evts, 262208), 64,
       decode(sign(bitand(t.sys_evts, 63)), 1, 'OR ALTER ',
                                               'ALTER ')) ||
decode(bitand(t.sys_evts, 262272), 128,
       decode(sign(bitand(t.sys_evts, 127)), 1, 'OR DROP ',
                                                'DROP ')) ||
decode (bitand(t.sys_evts, 262400), 256,
        decode(sign(bitand(t.sys_evts, 255)), 1, 'OR ANALYZE ',
                                                 'ANALYZE ')) ||
decode (bitand(t.sys_evts, 262656), 512,
        decode(sign(bitand(t.sys_evts, 511)), 1, 'OR COMMENT ',
                                                 'COMMENT ')) ||
decode (bitand(t.sys_evts, 263168), 1024,
        decode(sign(bitand(t.sys_evts, 1023)), 1, 'OR GRANT ',
                                                  'GRANT ')) ||
decode (bitand(t.sys_evts, 264192), 2048,
        decode(sign(bitand(t.sys_evts, 2047)), 1, 'OR REVOKE ',
                                                  'REVOKE ')) ||
decode (bitand(t.sys_evts, 266240), 4096,
        decode(sign(bitand(t.sys_evts, 4095)), 1, 'OR TRUNCATE ',
                                                  'TRUNCATE ')) ||
decode (bitand(t.sys_evts, 270336), 8192,
        decode(sign(bitand(t.sys_evts, 8191)), 1, 'OR RENAME ',
                                                  'RENAME ')) ||
decode (bitand(t.sys_evts, 278528), 16384,
        decode(sign(bitand(t.sys_evts, 16383)), 1, 'OR ASSOCIATE STATISTICS ',
                                                   'ASSOCIATE STATISTICS ')) ||
decode (bitand(t.sys_evts, 294912), 32768,
        decode(sign(bitand(t.sys_evts, 32767)), 1, 'OR AUDIT ',
                                                   'AUDIT ')) ||
decode (bitand(t.sys_evts, 327680), 65536,
        decode(sign(bitand(t.sys_evts, 65535)), 1,
               'OR DISASSOCIATE STATISTICS ', 'DISASSOCIATE STATISTICS ')) ||
decode (bitand(t.sys_evts, 393216), 131072,
        decode(sign(bitand(t.sys_evts, 131071)), 1, 'OR NOAUDIT ',
                                                    'NOAUDIT ')) ||
decode (bitand(t.sys_evts, 262144), 262144,
        decode(sign(bitand(t.sys_evts, 31)), 1, 'OR DDL ',
                                                   'DDL ')) ||
decode (bitand(t.sys_evts, 8388608), 8388608,
        decode(sign(bitand(t.sys_evts, 8388607)), 1, 'OR SUSPEND ',
                                                     'SUSPEND ')),
'SYS',
'DATABASE        ',
NULL,
NULL,
'REFERENCING NEW AS '||t.refnewname||' OLD AS '||t.refoldname
  || decode(bitand(t.property,32),32,' PARENT AS ' || t.refprtname,NULL),
t.whenclause,decode(t.enabled, 0, 'DISABLED', 1, 'ENABLED', 'ERROR'),
t.definition,
decode(bitand(t.property, 2), 2, 'CALL',
                                 'PL/SQL     '),
t.action#
from sys.obj$ trigobj, sys.trigger$ t, sys.user$ trigusr
where (trigobj.obj#   = t.obj# and
       trigobj.owner# = trigusr.user# and
       bitand(t.property, 63)    >= 8 and bitand(t.property, 63) < 16)
union all
select trigusr.name, trigobj.name,
decode(t.type#, 0, 'BEFORE EVENT',
                2, 'AFTER EVENT',
                   'UNDEFINED'),
decode(bitand(t.sys_evts, 1), 1, 'STARTUP ') ||
decode(bitand(t.sys_evts, 2), 2,
       decode(sign(bitand(t.sys_evts, 1)), 1, 'OR SHUTDOWN ',
                                               'SHUTDOWN ')) ||
decode(bitand(t.sys_evts, 4), 4,
       decode(sign(bitand(t.sys_evts, 3)), 1, 'OR ERROR ',
					      'ERROR ')) ||
decode(bitand(t.sys_evts, 8), 8,
       decode(sign(bitand(t.sys_evts, 7)), 1, 'OR LOGON ',
                                              'LOGON ')) ||
decode(bitand(t.sys_evts, 16), 16,
       decode(sign(bitand(t.sys_evts, 15)), 1, 'OR LOGOFF ',
                                               'LOGOFF ')) ||
decode(bitand(t.sys_evts, 262176), 32,
       decode(sign(bitand(t.sys_evts, 31)), 1, 'OR CREATE ',
                                               'CREATE ')) ||
decode(bitand(t.sys_evts, 262208), 64,
       decode(sign(bitand(t.sys_evts, 63)), 1, 'OR ALTER ',
                                               'ALTER ')) ||
decode(bitand(t.sys_evts, 262272), 128,
       decode(sign(bitand(t.sys_evts, 127)), 1, 'OR DROP ',
                                                'DROP ')) ||
decode (bitand(t.sys_evts, 262400), 256,
        decode(sign(bitand(t.sys_evts, 255)), 1, 'OR ANALYZE ',
                                                 'ANALYZE ')) ||
decode (bitand(t.sys_evts, 262656), 512,
        decode(sign(bitand(t.sys_evts, 511)), 1, 'OR COMMENT ',
                                                 'COMMENT ')) ||
decode (bitand(t.sys_evts, 263168), 1024,
        decode(sign(bitand(t.sys_evts, 1023)), 1, 'OR GRANT ',
                                                  'GRANT ')) ||
decode (bitand(t.sys_evts, 264192), 2048,
        decode(sign(bitand(t.sys_evts, 2047)), 1, 'OR REVOKE ',
                                                  'REVOKE ')) ||
decode (bitand(t.sys_evts, 266240), 4096,
        decode(sign(bitand(t.sys_evts, 4095)), 1, 'OR TRUNCATE ',
                                                  'TRUNCATE ')) ||
decode (bitand(t.sys_evts, 270336), 8192,
        decode(sign(bitand(t.sys_evts, 8191)), 1, 'OR RENAME ',
                                                  'RENAME ')) ||
decode (bitand(t.sys_evts, 278528), 16384,
        decode(sign(bitand(t.sys_evts, 16383)), 1, 'OR ASSOCIATE STATISTICS ',
                                                   'ASSOCIATE STATISTICS ')) ||
decode (bitand(t.sys_evts, 294912), 32768,
        decode(sign(bitand(t.sys_evts, 32767)), 1, 'OR AUDIT ',
                                                   'AUDIT ')) ||
decode (bitand(t.sys_evts, 327680), 65536,
        decode(sign(bitand(t.sys_evts, 65535)), 1,
               'OR DISASSOCIATE STATISTICS ', 'DISASSOCIATE STATISTICS ')) ||
decode (bitand(t.sys_evts, 393216), 131072,
        decode(sign(bitand(t.sys_evts, 131071)), 1, 'OR NOAUDIT ',
                                                    'NOAUDIT ')) ||
decode (bitand(t.sys_evts, 262144), 262144,
        decode(sign(bitand(t.sys_evts, 31)), 1, 'OR DDL ',
                                                   'DDL ')) ||
decode (bitand(t.sys_evts, 8388608), 8388608,
        decode(sign(bitand(t.sys_evts, 8388607)), 1, 'OR SUSPEND ',
                                                     'SUSPEND ')),
tabusr.name,
'SCHEMA',
NULL,
NULL,
'REFERENCING NEW AS '||t.refnewname||' OLD AS '||t.refoldname,
t.whenclause,decode(t.enabled, 0, 'DISABLED', 1, 'ENABLED', 'ERROR'),
t.definition,
decode(bitand(t.property, 2), 2, 'CALL',
                                 'PL/SQL     '),
t.action#
from sys.obj$ trigobj, sys.trigger$ t, sys.user$ tabusr, sys.user$ trigusr
where (trigobj.obj#   = t.obj# and
       trigobj.owner# = trigusr.user# and
       bitand(t.property, 63) >= 16 and bitand(t.property, 63) < 32 and
       tabusr.user# = t.baseobject)
union all
select trigusr.name, trigobj.name,
decode(t.type#, 0, 'BEFORE STATEMENT',
               1, 'BEFORE EACH ROW',
               2, 'AFTER STATEMENT',
               3, 'AFTER EACH ROW',
               4, 'INSTEAD OF',
               'UNDEFINED'),
decode(t.insert$*100 + t.update$*10 + t.delete$,
                 100, 'INSERT',
                 010, 'UPDATE',
                 001, 'DELETE',
                 110, 'INSERT OR UPDATE',
                 101, 'INSERT OR DELETE',
                 011, 'UPDATE OR DELETE',
                 111, 'INSERT OR UPDATE OR DELETE', 'ERROR'),
tabusr.name,
decode(bitand(t.property, 1), 1, 'VIEW',
                              0, 'TABLE',
                                 'UNDEFINED'),
tabobj.name, ntcol.name,
'REFERENCING NEW AS '||t.refnewname||' OLD AS '||t.refoldname ||
  ' PARENT AS ' || t.refprtname,
t.whenclause,decode(t.enabled, 0, 'DISABLED', 1, 'ENABLED', 'ERROR'),
t.definition,
decode(bitand(t.property, 2), 2, 'CALL',
                                 'PL/SQL     '),
t.action#
from sys.obj$ trigobj, sys.obj$ tabobj, sys.trigger$ t,
     sys.user$ tabusr, sys.user$ trigusr, sys.viewtrcol$ ntcol
where (trigobj.obj#   = t.obj# and
       tabobj.obj#    = t.baseobject and
       tabobj.owner#  = tabusr.user# and
       trigobj.owner# = trigusr.user# and
       t.nttrigcol    = ntcol.intcol# and
       t.nttrigatt    = ntcol.attribute# and
       t.baseobject   = ntcol.obj# and
       bitand(t.property, 63)     >= 32) and trigusr.name in ('IFRBDE','IFRBDE_VIEWS','INTEGRACAO','IFRSEG')
/

-- Grants for View
GRANT SELECT ON sys.dba_triggers_eng TO eng_desenv
/

-
