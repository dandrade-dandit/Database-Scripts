SELECT name, value, isdefault
FROM   v$parameter
WHERE  name LIKE 'result_cache%';


ALTER SYSTEM SET result_cache_max_size = 512M SCOPE = MEMORY;
ALTER SYSTEM SET result_cache_max_result = 10 SCOPE = MEMORY;


BEGIN
     DBMS_RESULT_CACHE.FLUSH;
END;
/


SELECT  *--'ALTER TABLE ' || OWNER || '.' || TABLE_NAME || ' result_cache  (mode force);'  -- (mode default)
  FROM  DBA_TABLES
 WHERE  OWNER = 'IFRGESTAO_TI' 
   --AND  RESULT_CACHE != 'DEFAULT'
   


Help for Interactive Commands - procps version 3.2.7
Window 1:Def: Cumulative mode Off.  System: Delay 3.0 secs; Secure mode Off.

  Z,B       Global: 'Z' change color mappings; 'B' disable/enable bold
  l,t,m     Toggle Summaries: 'l' load avg; 't' task/cpu stats; 'm' mem info
  1,I       Toggle SMP view: '1' single/separate states; 'I' Irix/Solaris mode

  f,o     . Fields/Columns: 'f' add or remove; 'o' change display order
  F or O  . Select sort field
  <,>     . Move sort field: '<' next col left; '>' next col right
  R,H     . Toggle: 'R' normal/reverse sort; 'H' show threads
  c,i,S   . Toggle: 'c' cmd name/line; 'i' idle tasks; 'S' cumulative time
  x,y     . Toggle highlights: 'x' sort field; 'y' running tasks
  z,b     . Toggle: 'z' color/mono; 'b' bold/reverse (only if 'x' or 'y')
  u       . Show specific user only
  n or #  . Set maximum tasks displayed

  k,r       Manipulate tasks: 'k' kill; 'r' renice
  d or s    Set update interval
  W         Write configuration file
  q         Quit
          ( commands shown with '.' require a visible task display window )
Press 'h' or '?' for help with Windows,
any other key to continue
