1) CRIAR OS SERVIÇOS
srvctl add service -d ifrprod -s GESTAOTI -r ifrprod3 -a ifrprod1,ifrprod2,ifrprod4

2) START DOS SERVIÇOS
srvctl start service -d ifrprod -s GESTAOTI

3) USAR O TNS COMO NO MODELO ABAIXO...
GESTAOTI =
(DESCRIPTION_LIST =
  (DESCRIPTION = 
    (ADDRESS_LIST = 	
     	(load_balance=ON)
    	(failover=ON)
	(ADDRESS = (PROTOCOL=TCP)(Host=ifrprod1.infraero.gov.br)(Port=1521))
	(ADDRESS = (PROTOCOL=TCP)(Host=ifrprod2.infraero.gov.br)(Port=1521))
	(ADDRESS = (PROTOCOL=TCP)(Host=ifrprod3.infraero.gov.br)(Port=1521))
	(ADDRESS = (PROTOCOL=TCP)(Host=ifrprod4.infraero.gov.br)(Port=1521))
    )
    (CONNECT_DATA = (SERVICE_NAME = gestaoti.infraero.gov.br)
                    (failover_mode=
                        (type=select)
                        (method=basic)
                        (retries = 20)
         								(delay = 5)
                    )
    )
  )
)


4) STATUS DOS SERVIÇOS
srvctl status service -d ifrprod -s GESTAOTI

5) PARA VER OS SERVIÇOS
lsnrctl status