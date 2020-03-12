CREATE OR REPLACE VIEW syscolcount (
   obj#,
   colcount )
AS
SELECT C.OBJ#, COUNT(*) FROM SYS.COL$ C GROUP BY C.OBJ#
/

CREATE OR REPLACE VIEW sysind_col# (
   ind_obj,
   col_count )
AS
SELECT OBJ#, COUNT(*) FROM SYS.ICOL$ GROUP BY OBJ#
/


CREATE OR REPLACE VIEW syscolauth (
   grantee,
   creator,
   privilege,
   tname,
   colname )
AS
SELECT UE.NAME, U.NAME, decode(substr(lpad(sum(power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1))), 26, '0'), 5, 2), '00', 'SELECT', '01', 'UPDATE', '11', 'UPDATE', 'SELECT'), O.NAME, C.NAME FROM SYS.OBJAUTH$ OA, SYS.COL$ C, SYS.OBJ$ O, SYS.USER$ U, SYS.USER$ UR, SYS.USER$ UE WHERE OA.COL# is not null and OA.OBJ# = C.OBJ# AND OA.COL# = C.COL# and OA.OBJ# = O.OBJ# AND OA.GRANTOR# = UR.USER# AND OA.GRANTEE# = UE.USER# AND U.USER# = O.OWNER# and (oa.grantor# = uid or oa.grantee# in (select kzsrorol from x$kzsro) or o.owner# = uid) group by u.name, o.name, c.name, ur.name, ue.name
/

GRANT SELECT ON syscolauth TO PUBLIC
/

CREATE OR REPLACE VIEW syscolumns (
   tbcreator,
   name,
   tbname,
   colno,
   coltype,
   length,
   nulls,
   updates,
   remarks,
   scale )
AS
SELECT U.NAME, C.NAME, O.NAME, C.COL#, decode(c.type#, 1, 'VARCHAR2', 2, decode(c.scale, null, decode(c.precision#, null, 'NUMBER', 'FLOAT'), 'NUMBER'), 8, 'LONG', 9, 'VARCHAR', 12, 'DATE', 23, 'RAW', 24, 'LONG RAW', 69, 'ROWID', 96,'CHAR', 'UNDEFINED'), C.LENGTH, DECODE(C.NULL$, 0, 'Y', ' '), 'Y', CO.COMMENT$, C.SCALE FROM SYS.COL$ C, SYS.OBJ$ O, SYS.USER$ U, SYS.COM$ CO WHERE O.OBJ# = C.OBJ# AND O.OWNER# = U.USER# AND O.TYPE# IN (2, 4) AND C.OBJ# = CO.OBJ#(+) AND C.COL# = CO.COL#(+) and (o.owner# = uid or o.obj# in ( select obj# from sys.objauth$ where grantee# in ( select kzsrorol from x$kzsro ) ) )
/

GRANT SELECT ON syscolumns TO PUBLIC
/

CREATE OR REPLACE VIEW sysindexes (
   tbcreator,
   name,
   tbname,
   creator,
   uniquerule,
   colcount,
   ixtype,
   clusterrule,
   ixsize,
   percentfree )
AS
SELECT IU.NAME, O.NAME, IO.NAME, U.NAME, DECODE(bitand (I.property, 1), 0, 'D', 1, 'U', 'D'), COL_COUNT, 'B', 'N', 0, 0 FROM sys.ts$ ts, SYS.SEG$ S, SYS.USER$ IU, SYS.OBJ$ IO, SYS.USER$ U, SYS.IND$ I, SYS.OBJ$ O, SYSIND_COL# CNT WHERE U.USER# = O.OWNER# AND O.OBJ# = I.OBJ# AND O.OBJ# = CNT.IND_OBJ AND I.BO# = IO.OBJ# AND IO.OWNER# = IU.USER# and i.ts# = ts.ts# AND I.FILE# = S.FILE# AND I.BLOCK# = S.BLOCK# AND (IO.OWNER# = UID OR IO.OBJ# IN ( SELECT OBJ# from objauth$ where grantee# in ( select kzsrorol from x$kzsro ) ) )
/

GRANT SELECT ON sysindexes TO PUBLIC
/

CREATE OR REPLACE VIEW syskeys (
   ixcreator,
   ixname,
   colname,
   colno,
   colseq,
   ordering,
   function )
AS
SELECT IO.NAME, IDX.NAME, C.NAME, C.COL#, IC.POS#, 'A', '' FROM SYS.COL$ C, SYS.OBJ$ IDX, SYS.OBJ$ BASE, SYS.ICOL$ IC, SYS.USER$ IO, SYS.USER$ BO WHERE BASE.OBJ# = C.OBJ# AND IC.COL# = C.COL# AND IC.BO# = BASE.OBJ# AND IO.USER# = IDX.OWNER# AND BO.USER# = BASE.OWNER# AND IC.OBJ# = IDX.OBJ# AND (IDX.OWNER# = UID OR BASE.OWNER# = UID OR BASE.OBJ# IN ( SELECT OBJ# from sys.objauth$ where grantee# in ( select kzsrorol from x$kzsro ) ) )
/

GRANT SELECT ON syskeys TO PUBLIC
/

CREATE OR REPLACE VIEW syssynonyms (
   name,
   creator,
   tbname,
   tbcreator )
AS
SELECT O.NAME, U.NAME, S.NAME, S.OWNER FROM SYS.USER$ U, SYS.SYN$ S, SYS.OBJ$ O WHERE O.OBJ# = S.OBJ# AND O.TYPE# = 5 AND O.OWNER# = U.USER# and o.owner# in ( select kzsrorol from x$kzsro )
/

GRANT SELECT ON syssynonyms TO PUBLIC
/

CREATE OR REPLACE VIEW systabauth (
   grantee,
   tcreator,
   ttname,
   updatecols,
   selectcols,
   alterauth,
   deleteauth,
   indexauth,
   insertauth,
   selectauth,
   updateauth )
AS
SELECT UE.NAME, U.NAME, O.NAME, decode(substr(lpad(sum(decode(col#, null, power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1)), 0)), 26, '0'), 5, 2),'01', 'N', '11', 'N', decode(substr(lpad(sum(decode(col#, null, 0, power(10, privilege#))), 12, '0'), 2, 1), '0', 'N', '*')), decode(substr(lpad(sum(decode(col#, null, power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1)), 0)), 26, '0'), 3, 2), '01', 'N', '11', 'N', decode(substr(lpad(sum(decode(col#, null, 0, power(10, privilege#))), 12, '0'), 1, 1), '0', 'N', '*')), decode(substr(lpad(sum(power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2+1))), 26, '0'), 25, 2), '00', 'N', '01', 'Y', '11', 'Y', 'N'), decode(substr(lpad(sum(power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2+1))), 26, '0'), 19, 2), '00', 'N', '01', 'Y', '11', 'Y', 'N'), decode(substr(lpad(sum(power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2+1))), 26, '0'), 15, 2), '00', 'N', '01', 'Y', '11', 'Y', 'N'), decode(substr(lpad(sum(decode(col#, null, power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1)), 0)), 26, '0'), 13, 2), '01', 'Y', '11', 'Y', decode(substr(lpad(sum(decode(col#, null, 0, power(10, privilege#))), 12, '0'), 6, 1), '0', 'N', 'Y')), decode(substr(lpad(sum(power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1))), 26, '0'), 7, 2), '00', 'N', '01', 'Y', '11', 'Y', 'N'), decode(substr(lpad(sum(decode(col#, null, power(10, privilege#*2) + decode(option$, null, 0, power(10, privilege#*2 + 1)), 0)), 26, '0'), 5, 2),'01', 'Y', '11', 'Y', decode(substr(lpad(sum(decode(col#, null, 0, power(10, privilege#))), 12, '0'), 2, 1), '0', 'N', 'N')) FROM SYS.OBJAUTH$ OA, SYS.OBJ$ O, SYS.USER$ U, SYS.USER$ UR, SYS.USER$ UE WHERE OA.OBJ# = O.OBJ# AND OA.GRANTOR# = UR.USER# AND OA.GRANTEE# = UE.USER# AND U.USER# = O.OWNER# and (oa.grantor# = uid or oa.grantee# in (select kzsrorol from x$kzsro) or o.owner# = uid) group by u.name, o.name, ur.name, ue.name
/

GRANT SELECT ON systabauth TO PUBLIC
/

CREATE OR REPLACE VIEW systables (
   creator,
   name,
   colcount,
   type,
   remarks,
   percentfree )
AS
SELECT U.NAME, O.NAME, CO.COLCOUNT, DECODE(O.TYPE#, 2, 'T', 4, 'V', 5, 'S', 'S'), C.COMMENT$, 0 FROM SYS.OBJ$ O, SYS.USER$ U, SYS.COM$ C, SYSCOLCOUNT CO WHERE O.OWNER# = U.USER# AND O.OBJ# = C.OBJ#(+) AND C.COL#(+) IS NULL AND O.TYPE# IN (2, 4) AND O.OBJ# = CO.OBJ# and o.linkname is null and (o.owner# in (uid, 1) or o.obj# in ( select obj# from sys.objauth$ where grantee# in ( select kzsrorol from x$kzsro ) ) )
/

GRANT SELECT ON systables TO PUBLIC
/

CREATE OR REPLACE VIEW systables1 (
   creator,
   name,
   type,
   remarks,
   percentfree )
AS
SELECT U.NAME, O.NAME, DECODE(O.TYPE#, 2, 'T', 4, 'V', 5, 'S', 'S'), C.COMMENT$, 0 FROM SYS.OBJ$ O, SYS.USER$ U, SYS.COM$ C WHERE O.OWNER# = U.USER# AND O.OBJ# = C.OBJ#(+) AND C.COL#(+) IS NULL AND O.TYPE# IN (2, 4) and o.linkname is null and (o.owner# in (uid, 1) or o.obj# in ( select obj# from sys.objauth$ where grantee# in ( select kzsrorol from x$kzsro ) ) )
/

GRANT SELECT ON systables1 TO PUBLIC
/
