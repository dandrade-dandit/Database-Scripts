declare

v_usersid          NUMBER(24);
--v_data             VARCHAR2(12) := '13/06/2011';
v_matricula        VARCHAR2(30);
v_hostname         VARCHAR2(255);
v_hora_inicio      DATE;
v_hora_fim         DATE;
v_site             VARCHAR2(255);
v_sum_bytes        NUMBER(24);
v_sum_time         NUMBER(24);

cursor c1 is
select  distinct
        data
     ,  ip
     ,  usersid
     ,  sitesid
  from  IFRMYSAR.trafficsummaries
--sample  (2)
--where  data = to_date(v_data,'DD/MM/YYYY')
 where FLG_MIGRADO = 3
   and  ip != 4294967295
 order
    by  data
     ,  usersid
     ,  sitesid;
 
cursor c2 (nData date, nIp number) is
select  distinct 
        usersid
     ,  authuser
  from  IFRMYSAR.TRAFFIC
 where  data = nData --to_date(nData,'DD/MM/YYYY')
   and  ip = nIp
 order 
    by  2 desc;
---------------------------------------------------------------------------------

begin
	--ATUALIZA OS DADOS MIGRADOS ORIGINAIS DO MYSAR
	UPDATE IFRMYSAR.trafficsummaries 
	   SET FLG_MIGRADO = 3 
	 WHERE FLG_MIGRADO = 0;
	COMMIT;
			
  for x in c1 loop

    begin
       for y in c2(x.data, x.ip) loop
        begin
          if (c2%rowcount = 1 and y.authuser = '-') then
            v_usersid := x.usersid;
            v_matricula := 'Não Autenticado';
          elsif  (c2%rowcount >= 1 and y.authuser != '-') then
            v_usersid := y.usersid;
            v_matricula := y.authuser;
          elsif  (c2%rowcount > 1 and y.authuser = '-') then
            exit;
          end if;

          begin
            select  distinct 
                    hostname
              into  v_hostname
              from  IFRMYSAR.hostnames
             where  ip = x.ip;
     
            exception
              when NO_DATA_FOUND then
                v_hostname := 'Não Identificado';
              when others then
                v_hostname := 'Não Identificado';
          end;
    
          begin
           SELECT   to_date(nvl(min(to_char(time, 'dd/mm/yyyy hh24:mi:ss')),'01/01/1970 00:00:00'), 'dd/mm/yyyy hh24:mi:ss') min_hora
               ,    to_date(nvl(max(to_char(time, 'dd/mm/yyyy hh24:mi:ss')),'01/01/1970 00:00:00'), 'dd/mm/yyyy hh24:mi:ss') max_hora
               ,    nvl((((max(time)-min(time))*24)*60)*60,0) tempo_toral
               ,    nvl(sum(bytes),0) sum_bytes
            INTO    v_hora_inicio
               ,    v_hora_fim
               ,    v_sum_time
               ,    v_sum_bytes
            FROM    IFRMYSAR.TRAFFIC
           WHERE    usersid = x.usersid
             AND    sitesid = x.sitesid
             AND    ip = x.ip;
     
            exception
              when NO_DATA_FOUND then
                v_sum_time := 0;
                v_sum_bytes := 0;
              when others then
                v_sum_time := 0;
                v_sum_bytes := 0;
          end;
          
          begin
           SELECT   distinct
                    site
            INTO    v_site
            FROM    IFRMYSAR.sites
           WHERE    id = x.sitesid;
     
            exception
              when NO_DATA_FOUND then
                v_site := 'Não Identificado';
              when others then
                v_site := 'Não Identificado';
          end;
          
          --TRUNCATE TABLE IFRMYSAR.TAB_DADOS_DETALHADOS_TMP;
          insert into IFRMYSAR.TAB_DADOS_DETALHADOS_TMP (usersid, matricula, ip, hostname, data, hora_inicio, hora_fim, sitesid, site, bytes, sum_time)
                 values (v_usersid, v_matricula, x.ip, v_hostname, x.data, v_hora_inicio, v_hora_fim, x.sitesid, v_site, v_sum_bytes, v_sum_time);
          commit;
        end;
      end loop;
    end;
  end loop;
  
  --ATUALIZA OS DADOS MIGRADOS ORIGINAIS DO MYSAR
  UPDATE IFRMYSAR.trafficsummaries 
     SET FLG_MIGRADO = 2 
   WHERE FLG_MIGRADO = 3;
  COMMIT;
  
  --CONSOLIDAÇÃO DOS DADOS MIGRADOS NESSA PROCEDURE
  INSERT INTO IFRMYSAR.TAB_DADOS_DETALHADOS
	SELECT 	DISTINCT
	        USERSID,
				  MATRICULA,
				  IP,
				  HOSTNAME,
				  DATA,
				  MIN(HORA_INICIO) hora_ini,
				  MAX(HORA_FIM) hora_fim,
				  SITESID,
				  SITE,
				  SUM(BYTES) BYTES,
				  --SUM(SUM_TIME) SUM_TIME
				  ROUND(nvl((((MAX(HORA_FIM)-MIN(HORA_INICIO))*24)*60)*60,0),0) SUM_TIME
	FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
 WHERE FLG_MIGRADO = 0
	GROUP
	   BY USERSID,
			  MATRICULA,
			  IP,
			  HOSTNAME,
			  DATA,
			  SITESID,
			  SITE;
	COMMIT;
	
	--ATUALIZA OS DADOS MIGRADOS COMPILADOS NESSA PROCEDURE
	UPDATE IFRMYSAR.TAB_DADOS_DETALHADOS_TMP 
     SET FLG_MIGRADO = 1 
   WHERE FLG_MIGRADO = 0;
  COMMIT;
	
end;
/

