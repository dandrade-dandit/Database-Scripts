column   network     format a7 
column   disp        format a4 
column   oracle_user format a11 
column   sid         format 99999 
column   serial#     format 9999999 
column   os_user     format a10 
column   terminal    format a8 
column   program     format a20 
column   machine     format a20
break on network on disp 
 
select   d.network network,      d.name disp 
       , s.username oracle_user, s.sid sid,           s.serial# serial# 
       , p.username os_user,     p.terminal terminal, s.program program, s.machine machine
from     v$dispatcher d, v$circuit c, v$session s, v$process p 
where    d.paddr = c.dispatcher (+) 
and      c.saddr = s.saddr (+) 
and      s.paddr = p.addr (+) 
order by d.name, s.username 
/ 