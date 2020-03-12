rem 
rem $Header: catparr.sql 17-mar-2000.11:12:24 ppjanic Exp $ 
rem 
Rem Copyright (c) 1990, 1995, 1996, 1997, 1998, 1999, 2000 by Oracle Corporation
Rem NAME
Rem    CATPARR.SQL
Rem  FUNCTION
Rem    Parallel-Server specific views for performance queries, etc.
Rem  NOTES
Rem     This script must be run while connected as SYS or INTERNAL.
Rem  MODIFIED
Rem     ppjanic    03/17/00 -  601567: Correct v$lock_element definition
Rem     nmacnaug   10/25/99 -  add le freelist view
Rem     mjungerm   06/15/99 -  add java shared data object type
Rem     nmacnaug   02/02/99 -  zero out unused field
Rem     kquinn     05/13/98 -  666009: Correct v$cache definition
Rem     nmacnaug   06/10/98 -  return zero for deleted columns
Rem     mcoyle     08/22/97 -  Move v$lock_activity to kernel view
Rem     tlahiri    03/23/97 -  Move v$bh to kqfv.h, remove use of ext_to_obj
Rem     tlahiri    07/23/96 -  Proj-2721: Modifications for enhanced OPS statis
Rem     atsukerm   07/22/96 -  change type for partitioned objects.
Rem     atsukerm   06/13/96 -  fix EXT_TO_OBJ view.
Rem     mmonajje   05/24/96 -  Replace type col name with type#
Rem     asurpur    04/08/96 -  Dictionary Protection Implementation
Rem     atsukerm   02/29/96 -  space support for partitions.
Rem     jwlee      02/05/96 -  fix x$bh column name.
Rem     atsukerm   02/05/96 -  fix ext_to_obj definition.
Rem     atsukerm   01/03/96 -  tablespace-relative DBAs.
Rem     tlahiri    11/30/95 -  Fix error in v$lock_element in last checkin
Rem     tlahiri    11/20/95 -  Bugs 313766 and 313767
Rem     aho        11/02/95 -  iot change clu# references in ext_to_obj_view
Rem     aezzat     08/09/95 -  modify v$bh, v$ping to include buffer class
Rem     pgreenwa   10/21/94 -  create public syn. for v$locks_with_collisions
Rem     svenkate   11/30/94 -  bug 250244 : view changes
Rem     thayes     07/08/94 -  Extend vbh view
Rem     svenkate   06/17/94 -  bug 172282 : amendments
Rem     svenkate   06/08/94 -  172288 : add file_lock, file_PING
Rem     wmaimone   05/06/94 -  #184921 run as sys/internal
Rem     jloaiza    03/17/94 -  add false ping view, v$lock_element, etc
Rem     hrizvi     02/09/93 -  apply changes to x$bh 
Rem     jloaiza    11/09/92 -  get rid of quted column 
Rem     jklein     11/04/92 -  fix view definitions 
Rem     jklein     10/28/92 -  merge forward changes from v6 
Rem    Porter    12/03/90 - Added to control system, renamed to psviews.sql
Rem    Laursen   10/01/90 - Creation
Rem
Rem  This table maps extents to database objects. This table must be dropped 
Rem  and recreated to include any new extents that are added after the last 
Rem  time it was created.
Rem 
Rem  NOTE: As of 8.0.3, none of the remaining views in this file depend upon
Rem  ext_to_obj. v$cache and v$ping (and their new gv$ versions) use obj$ and
Rem  undo$ to obtain the object name, partition name, type and owner#. The
Rem  advantage of using obj$ and undo$ is that it is no longer necessary to
Rem  repeatedly recreate ext_to_obj (an expensive operation) to keep the 
Rem  dynamic performance views consistent.  
Rem  
Rem  ext_to_obj has been retained only for backward compatability reasons. 
create or replace view ext_to_obj_view as
  select file$.file# file# 
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb
       , obj$.name name 
       , NULL partition_name
       , 'TABLE' kind
       , owner#
  from tab$, uet$, obj$, file$
  where bitand(tab$.property, 1024) = 0          /* exclude clustered tables */
    and tab$.file# = uet$.segfile#
    and tab$.block# = uet$.segblock#
    and tab$.ts# = uet$.ts#
    and tab$.obj# = obj$.obj#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select file$.file# file# 
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb
       , obj$.name name 
       , obj$.subname partition_name
       , 'TABLE PARTITION' kind
       , owner#
  from tabpart$, uet$, obj$, file$
  where tabpart$.file# = uet$.segfile#
    and tabpart$.block# = uet$.segblock#
    and tabpart$.ts# = uet$.ts#
    and tabpart$.obj# = obj$.obj#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select distinct
         file$.file# file# 
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb
       , obj$.name name 
       , NULL partition_name
       , 'CLUSTER' kind
       , owner#
  from tab$, uet$, obj$, file$
  where bitand(tab$.property, 1024) = 1024               /* clustered tables */
    and tab$.file# = uet$.segfile#
    and tab$.block# = uet$.segblock#
    and tab$.ts# = uet$.ts#
    and tab$.bobj# = obj$.obj#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select file$.file# file# 
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb 
       , obj$.name name 
       , NULL artition_name
       , 'INDEX' kind
       , owner#
  from ind$, uet$, obj$, file$
  where ind$.file# = uet$.segfile#
    and ind$.block# = uet$.segblock#
    and ind$.ts# = uet$.ts#
    and ind$.obj# = obj$.obj#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select file$.file# file# 
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb 
       , obj$.name name 
       , obj$.subname partition_name
       , 'INDEX PARTITION' kind
       , owner#
  from indpart$, uet$, obj$, file$
  where indpart$.file# = uet$.segfile#
    and indpart$.block# = uet$.segblock#
    and indpart$.ts# = uet$.ts#
    and indpart$.obj# = obj$.obj#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select file$.file# file#
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb
       , undo$.name name
       , NULL partition_name
       , 'UNDO' kind
       , user# owner#
  from undo$, uet$, file$
  where undo$.file# = uet$.segfile#
    and undo$.block# = uet$.segblock#
    and undo$.ts# = uet$.ts#
    and file$.ts# = uet$.ts#
    and file$.relfile# = uet$.file#
union all
  select file$.file# file#
       , uet$.block# lowb
       , uet$.block# + uet$.length - 1 highb
       , 'TEMP SEGMENT' name
       , NULL partition_name
       , 'TEMP SEGMENT' kind
       , 1 owner#
  from uet$, seg$, file$
  where seg$.file# = uet$.segfile#
   and  seg$.block# = uet$.block#
   and  seg$.ts# = uet$.ts#
   and  seg$.type# = 3
   and file$.ts# = uet$.ts#
   and file$.relfile# = uet$.file#
union all
  select file$.file#
       , fet$.block#
       , fet$.length + fet$.block# - 1
       , 'FREE EXTENT' name
       , NULL partition_name
       , 'FREE EXTENT' kind
       , 1  owner#
  from fet$, file$
  where file$.ts# = fet$.ts#
    and file$.relfile# = fet$.file#
  ;
grant select on ext_to_obj_view to select_catalog_role;

Rem  Create a table of extents since selecting from the view is too slow.

drop table ext_to_obj;
create table ext_to_obj as select * from ext_to_obj_view;


Rem  **************** NOTE FOR ORACLE 8.0.3 (and beyond) ******************
Rem  v$bh is now defined internally in the server (like other true
Rem  fixed views). A new view: gv$bh,  has also been added which is a
Rem  view on buffer headers across all instances. Correspondingly, there
Rem  are gv$ version of v$cache, v$ping, etc. (defined later). 
Rem 
Rem  The commented out definition of v$bh below is been retained so that a
Rem  description of the columns remains for the benefit of users and DBAs. 
Rem  gv$bh is identical to v$bh execept for an additional INST_ID column,
Rem  which gives the instance id of the corresponding buffer header.  

Rem  ***************** OLD DEFINITION OF V$BH   ********************
Rem  v$bh gives the status and number of x_to_null conversions, forced
Rem  writes and forced reads for every buffer in Rem  the buffer cache.
Rem  It gives the file number, block number, and data-object# for each
Rem  buffer, but unlike the v$cache  and v$ping views, it does not
Rem  translate  that to a database object.
Rem
Rem  There are three columns in v$bh for detecting i/o due to lock
Rem  lock conversion requests from other instances:
Rem 
Rem  1. The x_to_null column counts the number of times the block has
Rem  gone from exclusive mode to null on this instance due to a
Rem  conflicting lock request on another instance. This column has been
Rem  retained purely  for backward compatibility reasons. It provides only
Rem  a limited view of pinging, since it  does not capture other lock
Rem  transitions types such as  exclusive to share.
Rem 
Rem  2. The forced_write column counts the number of times DBWR had to
Rem  write this this block to disk because this instance had dirtied the
Rem  block and another instance had requested the lock on the block in a
Rem  conflicting mode.
Rem 
Rem  3. The forced_read column counts the number of times the block had
Rem  to be re-read from disk because another instance had forced it out
Rem  of this instance's cache by requesting the PCM lock on the block in
Rem  exclusive mode.
Rem
Rem  Columns 2 and 3  together represent the number of disk i/o's an
Rem  instance had to perform on each block in the cache due to
Rem  conflicting lock requests by other instances.
Rem 
Rem  These i/o's are wasteful since they occur only due to lock activity
Rem  and would not have occurred in a single instance environment. 
Rem  
Rem  In order to get a true picture of the pings you need to look at v$bh
Rem  on all instances. NOTE FOR ORACLE 8.0.3 and beyond - you can achive
Rem  this by looking at GV$BH. 
Rem
Rem  The 'lock_element_addr' column contains the address of the lock
Rem  element  contains the Parallel Cache Management (PCM) lock element
Rem  that is locking this buffer.
Rem
Rem  If two buffers have the same lock_element_addr, then they are being
Rem  protected by the same lock. Anytime two buffers are covered by the
Rem  PCM lock, you can have false collisions between the buffers.
Rem  With releasable locking, the association of a lock element to a PCM
Rem  lock  may change. This is the reason for including the
Rem  'lock_element_name' and  'lock_element_class' in this and subsequent
Rem  views, since they together uniquely identify a specific PCM lock.
Rem 
Rem  create or replace view v$bh as          /* view on buffer headers */
Rem  select FILE#                     file#,
Rem         DBABLK                    block#,
Rem         CLASS                     class#,
Rem         decode(state, 0, 'FREE',  /* not currently is use */
Rem                       1, 'XCUR',  /* held exclusive by this instance */
Rem                       2, 'SCUR',  /* held shared by this instance */
Rem                       3, 'CR',    /* only valid for consistent read */
Rem                       4, 'READ',  /* is being read from disk */
Rem                       5, 'MREC',  /* in media recovery mode */
Rem                       6, 'IREC')  /* in instance(crash) recovery mode */
Rem	    status,
Rem         x_to_null                 xnc, /* count of ping outs */
Rem         forced_reads              forced_reads,
Rem         forced_writes             forced_writes,
Rem         bh.le_addr                lock_element_addr,
Rem         name                      lock_element_name,
Rem         le_class                  lock_element_class,
Rem	    decode(bitand(flag,1), 0, 'N', 'Y')
Rem         dirty,			/* Dirty bit */
Rem	    decode(bitand(flag,16), 0, 'N', 'Y')
Rem         temp,			/* temporary bit */
Rem	    decode(bitand(flag,1536), 0, 'N', 'Y')
Rem	    ping,			/* ping (to shared or null) bit */
Rem	    decode(bitand(flag,16384), 0, 'N', 'Y')
Rem         stale,			/* stale bit */
Rem	    decode(bitand(flag,65536), 0, 'N', 'Y')
Rem         direct,			/* direct access bit */
Rem	    decode(bitand(flag,1048576), 0, 'N', 'Y')
Rem	    new,			/* new bit */
Rem         obj    objd
Rem         from x$bh bh, x$le le
Rem         where bh.le_addr = le.le_addr;
Rem grant select on v$bh to public;
Rem drop public synonym v$bh;
Rem create public synonym v$bh for v$bh;

Rem
Rem  The gv$ping view is like gv$bh but it only shows the buffers that
Rem  have been "force-written" or "force-read" at least once.
Rem  gv$ping also translates the block to the  corresponding database
Rem  object (using obj$ and undo$).
Rem 
Rem  For a description of the columns, see the description of the v$bh
Rem  view above. 
Rem
create or replace view gv$ping as
select bh.inst_id,
       bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       ob.name,
       ob.subname partition_name,
       decode (ob.type#,  1, 'INDEX',
                          2, 'TABLE',
                          3, 'CLUSTER',
                          4, 'VIEW',
                          5, 'SYNONYM',
                          6, 'SEQUENCE',
                          7, 'PROCEDURE',
                          8,  'FUNCTION',
                          9, 'PACKAGE',
                         10, 'NON-EXISTENT',
                         11, 'PACKAGE BODY',
                         12, 'TRIGGER',
                         13, 'TYPE',
                         14, 'TYPE BODY',
                         19, 'TABLE PARTITION',
                         20, 'INDEX PARTITION',
                         21, 'LOB',
                         22, 'LIBRARY',
                         28, 'JAVA SOURCE',
                         29, 'JAVA CLASS',
                         30, 'JAVA RESOURCE',
                         56, 'JAVA DATA',
                         'UNKNOWN') kind,
       ob.owner#,
       lock_element_addr,
       lock_element_name 
       from gv$bh bh, obj$ ob
       where (bh.objd = ob.dataobj#) and
             (bh.forced_reads + bh.forced_writes) > 0
union all                     
select bh.inst_id,
       bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       un.name,
       NULL             partition_name,
       'UNDO'           kind,
       un.user#         owner#,      
       lock_element_addr,
       lock_element_name
       from gv$bh bh, undo$ un
where (bh.class# >= 11) and
      (un.us# = floor((bh.class# - 11) / 2)) and
      (bh.forced_reads + bh.forced_writes) > 0;

grant select on gv$ping to public;
drop public synonym gv$ping;
create public synonym gv$ping for gv$ping;

Rem v$ping is identical to gv$ping, except that it only shows
Rem the buffers that in this instance that have been force-written
Rem or force-read
Rem
create or replace view v$ping as
select bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       ob.name,
       ob.subname partition_name,
       decode (ob.type#,  1, 'INDEX',
                          2, 'TABLE',
                          3, 'CLUSTER',
                          4, 'VIEW',
                          5, 'SYNONYM',
                          6, 'SEQUENCE',
                          7, 'PROCEDURE',
                          8,  'FUNCTION',
                          9, 'PACKAGE',
                         10, 'NON-EXISTENT',
                         11, 'PACKAGE BODY',
                         12, 'TRIGGER',
                         13, 'TYPE',
                         14, 'TYPE BODY',
                         19, 'TABLE PARTITION',
                         20, 'INDEX PARTITION',
                         21, 'LOB',
                         22, 'LIBRARY',
                         28, 'JAVA SOURCE',
                         29, 'JAVA CLASS',
                         30, 'JAVA RESOURCE',
                         56, 'JAVA DATA',
                         'UNKNOWN') kind,
       ob.owner#,
       lock_element_addr,
       lock_element_name
       from v$bh bh, obj$ ob
       where (bh.objd = ob.dataobj#) and
             (bh.forced_reads + bh.forced_writes) > 0
union all                     
select bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       un.name,
       NULL             partition_name,
       'UNDO'           kind,
       un.user#         owner#,      
       lock_element_addr,
       lock_element_name
       from v$bh bh, undo$ un
where (bh.class# >= 11) and
      (un.us# = floor((bh.class# - 11) / 2)) and
      (bh.forced_reads + bh.forced_writes) > 0;

grant select on v$ping to public;
drop public synonym v$ping;
create public synonym v$ping for v$ping;

Rem
Rem  The gv$cache view shows all blocks in all caches which have an
Rem  associated lock element (some blocks, such as temp blocks, may not).
Rem  It gives the file number, the block number, the number of times
Rem  force-written or force-read (if any); it also translates the block to
Rem  to the corresponding database object (using the obj$ and undo$ table)
Rem  The difference between this view and the gv$ping view is that gv$cache
Rem  shows all buffers (which have lock elements) in all caches , whether
Rem  or not they have ever been force-written or force-read. 
Rem
create or replace view gv$cache as
select bh.inst_id,
       bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       ob.name,
       ob.subname partition_name,
       decode (ob.type#,  1, 'INDEX',
                          2, 'TABLE',
                          3, 'CLUSTER',
                          4, 'VIEW',
                          5, 'SYNONYM',
                          6, 'SEQUENCE',
                          7, 'PROCEDURE',
                          8,  'FUNCTION',
                          9, 'PACKAGE',
                         10, 'NON-EXISTENT',
                         11, 'PACKAGE BODY',
                         12, 'TRIGGER',
                         13, 'TYPE',
                         14, 'TYPE BODY',
                         19, 'TABLE PARTITION',
                         20, 'INDEX PARTITION',
                         21, 'LOB',
                         22, 'LIBRARY',
                         28, 'JAVA SOURCE',
                         29, 'JAVA CLASS',
                         30, 'JAVA RESOURCE',
                         56, 'JAVA DATA',
                         'UNKNOWN') kind,
       ob.owner#,
       lock_element_addr,
       lock_element_name
       from gv$bh bh, obj$ ob
       where (bh.objd = ob.dataobj#)
union all
select bh.inst_id,
       bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       un.name,
       NULL              partition_name,
       'UNDO'            kind,
       un.user#          owner#,      
       lock_element_addr,
       lock_element_name
       from gv$bh bh, undo$ un
where (bh.class# >= 11) and
      (un.us# = floor(bh.class# - 11) / 2);

grant select on gv$cache to public;
drop public synonym gv$cache;
create public synonym gv$cache for gv$cache;

Rem v$cache is identical to gv$cache, except that it only shows
Rem blocks in this instance.
Rem
create or replace view v$cache as
select bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       ob.name,
       ob.subname partition_name,
       decode (ob.type#,  1, 'INDEX',
                          2, 'TABLE',
                          3, 'CLUSTER',
                          4, 'VIEW',
                          5, 'SYNONYM',
                          6, 'SEQUENCE',
                          7, 'PROCEDURE',
                          8,  'FUNCTION',
                          9, 'PACKAGE',
                         10, 'NON-EXISTENT',
                         11, 'PACKAGE BODY',
                         12, 'TRIGGER',
                         13, 'TYPE',
                         14, 'TYPE BODY',
                         19, 'TABLE PARTITION',
                         20, 'INDEX PARTITION',
                         21, 'LOB',
                         22, 'LIBRARY',
                         28, 'JAVA SOURCE',
                         29, 'JAVA CLASS',
                         30, 'JAVA RESOURCE',
                         56, 'JAVA DATA',
                         'UNKNOWN') kind,
       ob.owner#,
       lock_element_addr,
       lock_element_name
       from v$bh bh, obj$ ob
       where (bh.objd = ob.dataobj#)
union all
select bh.file#,
       bh.block#,
       bh.class#,
       bh.status,
       bh.xnc,
       bh.forced_reads,
       bh.forced_writes,
       un.name,
       NULL              partition_name,
       'UNDO'            kind,
       un.user#          owner#,      
       lock_element_addr,
       lock_element_name
       from v$bh bh, undo$ un
where (bh.class# >= 11) and
      (un.us# = floor((bh.class# - 11) / 2));

grant select on v$cache to public;
drop public synonym v$cache;
create public synonym v$cache for v$cache;

Rem
Rem  There is one entry in v$lock_element for each PCM lock that is used
Rem  by the buffer cache (gc_db_locks).  v$lock_element describes the
Rem  status of each lock.  The name of the PCM lock that corresponds to
Rem  a lock element is  {'BL', indx, class}.  
Rem  NOTE FOR ORACLE 8.0.3 AND BEYOND: This view is now defined internally
Rem  in the server. gv$lock_element is a new view that displays lock elements
Rem  on all instances. 
Rem create or replace view v$lock_element as
Rem select le_addr lock_element_addr,  /* address of lock, join with gv$bh */
Rem       indx,                        /* indx,class are used to identify a */
Rem       le_class class,              /*    lock to the OS lock manager */
Rem       name  lock_element_name,     /* first part of lock name */
Rem       le_mode  mode_held,          /* values are OS dependent, usually */
Rem                                    /*   5=exclusive, 3=share           */
Rem       le_blks  block_count,        /* number of blocks protected by lock */
Rem       le_rls   releasing,        /* non-zero if lock is being downgraded */
Rem       le_acq   acquiring,        /* non-zero if lock is being upgraded */
Rem       le_inv   invalid,          /* non-zero if lock is invalid, a lock  */
Rem                                  /*   may become invalid after a crash */
Rem       le_flags flags             /* process level flags for the le */
Rem   from x$le;
Rem grant select on v$lock_element to public;
Rem drop public synonym v$lock_element;
Rem create public synonym v$lock_element for v$lock_element;

Rem
Rem  This view is like v$cache, but it also contains the indx and class of
Rem  the PCM lock that is protecting the buffer.  This view is useful for 
Rem  backmapping Rem a PCM lock to a set of buffers.  The name of 
Rem  the PCM lock that corresponds to a lock element 
Rem  is  {'BL', indx, class}.  This can be useful if the 
Rem  OS lock manager provides tools for monitoring the
Rem  PCM lock operations that are occuring.  First you identify the 
Rem  lock element in question by using the indx and class, then you
Rem  find the buffers that are covered by this lock by looking in v$bh
Rem  for buffers with the correct lock_element_addr.
Rem
create or replace view v$cache_lock as
select file#, block#, status, xnc, forced_reads, forced_writes, 
       name, kind, owner#, c.lock_element_addr, c.lock_element_name,
       indx, class
  from v$cache c, v$lock_element l
where l.lock_element_addr = c.lock_element_addr;

grant select on v$cache_lock to public;
drop public synonym v$cache_lock;
create public synonym v$cache_lock for v$cache_lock;

Rem 
Rem  Find the locks that protect multiple buffers each of which has been
Rem  either force-written or force-read at least 10 times.
Rem  It is very likely that those buffers are experiencing false pings due
Rem  to being mapped to the same lock. 
Rem  NOTE FOR ORACLE 8.0.3 and beyond: This view is now defined internally in
Rem  in the server. gv$locks_with_collisions is a new view that shows 
Rem  locks with collisions on all instances. 
Rem 
Rem create or replace view v$locks_with_collisions as
Rem select lock_element_addr
Rem   from v$bh
Rem where (forced_writes + forced_reads) > 10
Rem group by lock_element_addr
Rem having count(*) >= 2;


Rem  
Rem  This view shows all the buffers that look like they are experiencing
Rem  false pings.  It select the buffers that had more than 10 forced i/o's
Rem  and that are protected by the same lock as another buffer that
Rem  has also had more than 5 forced i/o's.  If you are experiencing false
Rem  pinging then you can change your gc_files_to_locks so that the buffers
Rem  experiencing false pinging are mapped to different locks.
Rem  This view cannot be defined internally in the server, since it 
Rem  references gv$cache
create or replace view gv$false_ping as
select p.inst_id,
       file#,
       block#,
       status,
       xnc,
       p.forced_reads,
       p.forced_writes,
       name,
       partition_name,
       kind,
       owner#,
       p.lock_element_addr,
       p.lock_element_name,
       p.class#          lock_element_class
    from gv$ping p, gv$locks_with_collisions c
  where (p.forced_reads + p.forced_writes) > 5 
   and  p.lock_element_addr = c.lock_element_addr
   and  p.inst_id = c.inst_id;

grant select on gv$false_ping to public;
drop public synonym gv$false_ping;
create public synonym gv$false_ping for gv$false_ping;

Rem
Rem v$false_ping is identical to gv$false_ping, except that it
Rem only looks at buffers on this instance.
Rem
create or replace view v$false_ping as
select file#,
       block#,
       status,
       xnc,
       p.forced_reads,
       p.forced_writes,
       name,
       partition_name,
       kind,
       owner#,
       p.lock_element_addr,
       p.lock_element_name,
       p.class#          lock_element_class
    from v$ping p, v$locks_with_collisions c
  where (p.forced_reads + p.forced_writes) > 5 
   and  p.lock_element_addr = c.lock_element_addr;


grant select on v$false_ping to public;
drop public synonym v$false_ping;
create public synonym v$false_ping for v$false_ping;

Rem  **************** NOTE FOR ORACLE 8.0.3 (and beyond) ******************
Rem  v$lock_activity is now defined internally in the server (like other true
Rem  fixed views). A new view: gv$lock_activity,has  been added which is a
Rem  view on lock_activity across all instances. 
Rem
Rem  The commented out definition of v$lock_activity below is been retained 
Rem  so that a
Rem  description of the columns remains for the benefit of users and DBAs.
Rem  gv$lock_activity is identical to v$lock_activity except for an 
Rem  additional INST_ID column,
Rem  which gives the instance id of the corresponding lock activity data.

Rem
Rem  The v$lock_activity view shows the DLM lock operations the instance is
Rem  doing.  Each row corresponds to a type of lock operation.
Rem  
Rem create or replace view v$lock_activity as
Rem select decode(indx, 1, 'NULL', 2, 'NULL', 3, 'S',    4, 'S', 
Rem                     5, 'X',    6, 'X',    7, 'X',    8, 'SSX', 
Rem                     9, 'SSX', 10, 'SSX',     '???') from_val,
Rem        decode(indx, 1, 'S',    2, 'X',    3, 'NULL',  4, 'X', 
Rem                     5, 'NULL', 6, 'S',    7, 'SSX',   8, 'NULL', 
Rem                     9, 'S',   10, 'X',       '???') to_val,
Rem        decode(indx, 1, 'Lock buffers for read',
Rem                     2, 'Lock buffers for write',
Rem                     3, 'Make buffers CR (no write)',
Rem                     4, 'Upgrade read lock to write',
Rem                     5, 'Make buffers CR (write dirty buffers)',
Rem                    6, 'Downgrade write lock to read (write dirty buffers)',
Rem                     7, 'Write transaction table/undo blocks',
Rem                     8, 
Rem                'Transaction table/undo blocks (write dirty buffers)',
Rem                    9, 'Make transaction table/undo blocks available share',
Rem                     10,'Rearm transaction table write mechanism', 
Rem                     'should not happen') action_val,
Rem        conv counter
Rem        from x$le_stat where conv > 0;               


Rem The view file_ping gives the number of blocks pinged per 
Rem datafile.  This information in turn may be
Rem used to determine access patterns to existing
Rem datafiles and deciding new mappings from datafile
Rem blocks to PCM locks.
Rem
Rem Note that the FREQUENCY column has been retained in version
Rem 8.0 only for backward compatibility reasons (similar to the xnc
Rem column of v$bh). It counts the number of x to null transitions
Rem performed on blocks in the file.
Rem 
Rem There detailed statistics available per file that should Rem provide
Rem a better picture of the pinging in the system than the FREQUENCY column
Rem 
Rem There are three types of conversion information - lock down conversion,
Rem cross instance calls and lock up conversion. Each conversion count is
Rem incremented for a file when a block is belonging to that file has the
Rem corresponding conversion performed upon it. In addition to the count
Rem of the conversion, there maybe a "forced write count" and a "forced stale
Rem count" with the conversion. The "forced_write_count" is incremented when
Rem a block which was dirty had the specified conversion performed upon it.
Rem The "forced stale count" is incremented when the block that had the
Rem conversion performed was converted to a stale or CR copy in the cache.
Rem "Forced Writes" can happen on down conversions from X mode, or due to the
Rem three cross instance calls - Write Buffer for CR read, Reuse Block Range 
Rem and Checkpoint Block Range.
Rem
Rem."Forced Stale" happens when the lock on the block is downgraded to NULL, or
Rem when a reuse block range cross instance call is issued. 
Rem 
Rem NOTE FOR ORACLE 8.0.3 AND BEYOND: New fixed views gv$file_ping and v$file_
Rem ping have been added to the server and should be used instead of file_ping.
Rem These fixed views do not translate the file number to the file_name and
Rem tablespace name as the view defined below does. 
drop view file_ping; 
create view file_ping as 
select file_id, file_name,
       TABLESPACE_NAME            ts_name, 
       0                          frequency,
       /* lock down conversion counts */
       KCFIOX2NC                  x_2_null,          
       KCFIOX2NFWC                x_2_null_forced_write,
       KCFIOX2NFSC                x_2_null_forced_stale,
       KCFIOX2SC                  x_2_s,
       KCFIOX2SFWC                x_2_s_forced_writes,
       0                          x_2_ssx,
       0                          x_2_ssx_forced_writes,
       KCFIOS2NC                  s_2_null,
       KCFIOS2NFSC                s_2_null_forced_stale,
       0                          ss_2_null,
       /* cross instance call counts  */
       0                          wrb,           /* Write Buffer for CR read */
       0                          wrb_forced_write,
       KCFIORBRC                  rbr,                  /* Reuse Block Range */
       KCFIORBRFWC                rbr_forced_write, 
       0                          rbr_forced_stale,
       0                          cbr,             /* Checkpoint Block Range */
       0                          cbr_forced_write,
       /* lock up conversion counts    */
       KCFION2XC                  null_2_x,
       KCFIOS2XC                  s_2_x,
       0                          ssx_2_x,
       KCFION2SC                  n_2_s,
       0                          n_2_ss
       from x$kcfio x, dba_data_files d 
       where x.KCFIOFNO = d.FILE_ID; 
grant select on file_ping to select_catalog_role;
 
Rem The view file_lock is an aid to understanding the mapping of
Rem locks to files as established by the GC_FILES_TO_LOCKS
Rem parameter. START_LK shows the first lock corresponding to this datafile.
Rem NLOCKS shows the number of locks allocated to this datafile while 
Rem BLOCKING	records the number of blocks each lock protects.
Rem
drop view file_lock; 
create view file_lock as 
select file_id, file_name, TABLESPACE_NAME ts_name, 
    kclfhbas start_lk, kclfhsiz nlocks, kclfhgrp blocking 
    from x$kclfh fh, x$kclfi fi, dba_data_files d 
    where fh.indx = fi.kclfibuk and fi.indx = d.FILE_ID; 
grant select on file_lock to select_catalog_role;

Rem The view le_freelist shows the current length
Rem and the low water mark length of the lock element freelist.
Rem
drop view le_freelist;
create view le_freelist as
select len LENGTH, lwm LOW_WATER_MARK from x$kclfx;
grant select on le_freelist to select_catalog_role;

