CREATE TABLE ifrrelproxy.USUARIO (
MATRICULA VARCHAR2(20) NOT NULL,
NOME VARCHAR2(100),
LOTACAO VARCHAR2(30));

ALTER TABLE ifrrelproxy.USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY (MATRICULA);

select * from ifrrelproxy.USUARIO;

update ifrrelproxy.USUARIO
set NOME = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e ')
/	  	

CREATE TABLE ifrrelproxy.HOSTNAME (
ID INT NOT NULL,
HOSTNAME VARCHAR(20),
DESCRICAO VARCHAR(200));

ALTER TABLE ifrrelproxy.HOSTNAME ADD CONSTRAINT PK_HOSTNAME PRIMARY KEY (ID);

CREATE SEQUENCE ifrrelproxy.SEQ_HOSTNAME 
MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE TRIGGER ifrrelproxy."TRG_HOSTNAME_I" BEFORE INSERT ON ifrrelproxy.HOSTNAME FOR EACH ROW
BEGIN   
  SELECT SEQ_HOSTNAME.NEXTVAL INTO :new.ID FROM DUAL; 
END;
/

CREATE UNIQUE INDEX ifrrelproxy.IDX_HOSTANME ON ifrrelproxy.HOSTNAME (HOSTNAME)

SELECT * FROM ifrrelproxy.HOSTNAME;

DECLARE
 V_HOSTNAME VARCHAR(100);
 V_TEMP VARCHAR(100);
 V_INT1 NUMBER(3);
 V_INT2 NUMBER(3);
BEGIN  
  FOR X IN 0..255
  LOOP
	  FOR I IN 0..255
	  LOOP
	        FOR J IN 0..255
	        LOOP
	             V_TEMP := '10.'||X||'.'||I||'.'||J;
	             INSERT INTO ifrrelproxy.HOSTNAME (HOSTNAME) VALUES (V_TEMP);
	        END LOOP;
	        COMMIT;
	  END LOOP;
  END LOOP;
END;
/

--*******************************************************************
create table ifrrelproxy.traffic_temp( 
   col1 varchar2(20), 
   col2 varchar2(20), 
    col3 varchar2(20), 
    col4 varchar2(50), 
    col5 varchar2(20), 
    col6 varchar2(20), 
   col7 varchar2(4000), 
    col8 varchar2(200), 
   col9 varchar2(100), 
   col10 varchar2(200)) 
   organization external (type oracle_loader default directory ext_tab_dir 
   access parameters (fields terminated by ' ') 
   location ('log_sede_mensal_Jun.log')) 
  PARALLEL 4
REJECT LIMIT UNLIMITED;


CREATE TABLE ifrrelproxy.HOSTS (
ID INT NOT NULL,
HOSTNAME VARCHAR(20),
DESCRICAO VARCHAR(200));

ALTER TABLE ifrrelproxy.HOSTS ADD CONSTRAINT PK_HOSTS PRIMARY KEY (ID);

CREATE SEQUENCE ifrrelproxy.SEQ_HOSTS
MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE TRIGGER ifrrelproxy.TRG_HOSTS_I BEFORE INSERT ON ifrrelproxy.HOSTS FOR EACH ROW
BEGIN   
  SELECT SEQ_HOSTS.NEXTVAL INTO :new.ID FROM DUAL; 
END;
/

CREATE UNIQUE INDEX ifrrelproxy.IDX_HOSTS ON ifrrelproxy.HOSTS (HOSTNAME)

SELECT * FROM ifrrelproxy.HOSTS;

INSERT INTO ifrrelproxy.HOSTS (hostname,descricao)
SELECT DISTINCT rtrim(ltrim(COL1 )), NULL
FROM ifrrelproxy.traffic_temp;

COMMIT;

--*****************

CREATE TABLE ifrrelproxy.USERS (
ID_USERS INT NOT NULL,
USERNAME VARCHAR(40));

ALTER TABLE ifrrelproxy.USERS ADD CONSTRAINT PK_USER PRIMARY KEY (ID_USERS);

CREATE SEQUENCE ifrrelproxy.SEQ_USERS
MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE TRIGGER ifrrelproxy.TRG_USERS_I BEFORE INSERT ON ifrrelproxy.USERS FOR EACH ROW
BEGIN   
  SELECT SEQ_USERS.NEXTVAL INTO :new.ID_USERS FROM DUAL; 
END;
/

CREATE UNIQUE INDEX ifrrelproxy.IDX_USERS ON ifrrelproxy.USERS (USERNAME)

SELECT * FROM ifrrelproxy.USERS;

INSERT INTO ifrrelproxy.USERS (USERNAME)
SELECT DISTINCT rtrim(ltrim(COL3))
FROM ifrrelproxy.traffic_temp;

COMMIT;

--*****************


SELECT DISTINCT substr( replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://','') , 1, instr(replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://',''), '/') )
FROM ifrrelproxy.traffic_temp;



SELECT  U.ID_USERS
     ,  H.ID
     ,  substr( trim(ltrim(COL4)), 2,2) AS DIA
     ,  substr( rtrim(ltrim(COL4)), 5,3) AS MES
     ,  substr( rtrim(ltrim(COL4)), 9,4) AS ANO
     ,  substr( rtrim(ltrim(COL4)), 14,8) AS HORA
     ,  substr( replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://','') , 1, instr(replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://',''), '/') )
     ,  SUM(RTRIM(LTRIM(COL10)))/1024/1024 AS TOTAL
FROM    ifrrelproxy.traffic_temp t
   ,    ifrrelproxy.USERS u
   ,    ifrrelproxy.HOSTS H
WHERE   rtrim(ltrim(COL3)) = u.USERNAME
  AND   rtrim(ltrim(COL1)) = h.hostname
  AND   RTRIM(LTRIM(COL9)) NOT IN ('0', '407')
GROUP
   BY   U.ID_USERS
     ,  H.ID
     ,  substr( trim(ltrim(COL4)), 2,2)
     ,  substr( rtrim(ltrim(COL4)), 5,3)
     ,  substr( rtrim(ltrim(COL4)), 9,4)
     ,  substr( rtrim(ltrim(COL4)), 14,8) 
     ,  substr( replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://','') , 1, instr(replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://',''), '/') );
     
--[01/Apr/2011:15:14:51
--*******************************
CREATE TABLE ifrrelproxy.TRAFFIC_RESUME (
        ID_TRAFFIC_RESUME NUMBER(20) NOT NULL
     ,  ID_USERS INT NOT NULL
     ,  ID INT NOT NULL
     ,  DIA INT
     ,  MES INT
     ,  ANO INT
     ,  HORA VARCHAR2(100)
     ,  SITE VARCHAR2(1000)
     ,  SUM_TOTAL_BYTES NUMBER(20)
     );
     
ALTER TABLE ifrrelproxy.TRAFFIC_RESUME ADD CONSTRAINT PK_TRAFFIC_RESUME PRIMARY KEY (ID_TRAFFIC_RESUME);

CREATE SEQUENCE ifrrelproxy.SEQ_TRAFFIC_RESUME
MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

CREATE TRIGGER ifrrelproxy.TRG_TRAFFIC_RESUME_I BEFORE INSERT ON ifrrelproxy.TRAFFIC_RESUME FOR EACH ROW
BEGIN   
  SELECT SEQ_TRAFFIC_RESUME.NEXTVAL INTO :new.ID_TRAFFIC_RESUME FROM DUAL; 
END;
/

CREATE INDEX ifrrelproxy.IDX_SEQ_TRAFFIC_RESUME ON ifrrelproxy.TRAFFIC_RESUME (ID_USERS,ID,DIA,MES,ANO);

SELECT * FROM ifrrelproxy.TRAFFIC_RESUME;

INSERT INTO ifrrelproxy.TRAFFIC_RESUME (ID_USERS, ID,  DIA,  MES,  ANO,  HORA,  SITE,  SUM_TOTAL_BYTES)
SELECT  U.ID_USERS
     ,  H.ID
     ,  substr( trim(ltrim(COL4)), 2,2) AS DIA
     ,  '04' as mes --substr( rtrim(ltrim(COL4)), 5,3) AS MES
     ,  substr( rtrim(ltrim(COL4)), 9,4) AS ANO
     ,  substr( rtrim(ltrim(COL4)), 14,8) AS HORA
     ,  substr( replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://','') , 1, instr(replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://',''), '/') )
     ,  SUM(RTRIM(LTRIM(COL10))) AS TOTAL
FROM    ifrrelproxy.traffic_temp t
   ,    ifrrelproxy.USERS u
   ,    ifrrelproxy.HOSTS H
WHERE   rtrim(ltrim(COL3)) = u.USERNAME
  AND   rtrim(ltrim(COL1)) = h.hostname
  AND   RTRIM(LTRIM(COL9)) NOT IN ('0', '407')
GROUP
   BY   U.ID_USERS
     ,  H.ID
     ,  substr( trim(ltrim(COL4)), 2,2)
     ,  '04' --substr( rtrim(ltrim(COL4)), 5,3)
     ,  substr( rtrim(ltrim(COL4)), 9,4)
     ,  substr( rtrim(ltrim(COL4)), 14,8)
     ,  substr( replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://','') , 1, instr(replace(replace(rtrim(ltrim(COL7)),'http://',''),'https://',''), '/') );


COMMIT;


--*********************
create or replace view ifrrelproxy.viw_traffic as
SELECT h.hostname
     , u.matricula
     , u.nome
     , u.lotacao
     , t.dia
     , t.mes
     , t.ano
     , t.hora
     , t.site
     , t.sum_total_bytes
FROM   ifrrelproxy.TRAFFIC_RESUME t
   ,   ifrrelproxy.USERS uu
   ,   ifrrelproxy.USUARIO u
   ,   ifrrelproxy.HOSTS h
WHERE  t.id = h.id
  AND  t.id_users = uu.id_users
  and  uu.username = u.matricula
  and  t.site != '(null)';
  

select hostname
     , matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano
     , site
     , round(sum_total_bytes/1024/1024,2) as total
from ifrrelproxy.viw_traffic
where matricula = 'i1190738'
order by total desc

select hostname
     , matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano
     , site
     , round(sum_total_bytes/1024/1024,2) as total
from ifrrelproxy.viw_traffic
where hostname = 'i1190738'
order by total desc

select hostname
     , matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano
     , round(sum(sum_total_bytes)/1024/1024,2) as total
from ifrrelproxy.viw_traffic
where matricula = 'i1572034'
group
   by hostname
     , matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano;

select hostname
     , dia
     , mes
     , ano
     , round(sum(sum_total_bytes)/1024/1024,2) as total
from ifrrelproxy.viw_traffic
group
   by  hostname
     , dia
     , mes
     , ano
order 
   by
      total desc
    , hostname

select matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano
     , round(sum(sum_total_bytes)/1024/1024,2) as total
from ifrrelproxy.viw_traffic
group
   by  matricula
     , nome
     , lotacao
     , dia
     , mes
     , ano
order 
   by
      total desc
    , matricula