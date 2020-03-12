column rr heading 'RB Segment' format a18 
column us heading 'Username' format a15 
column os heading 'OS User' format a15 
column te heading 'Terminal' format a15 
 
 
SELECT     r.name rr,  
           nvl(s.username,'no transaction') us, 
           s.osuser os,  
           s.terminal te 
FROM       v$lock  l, v$session  s,v$rollname  r 
WHERE      l.sid = s.sid(+) AND  
           trunc(l.id1/65536) = r.usn AND 
           l.type = 'TX' AND  
    l.lmode = 6 
ORDER BY   r.name 
/ 
 