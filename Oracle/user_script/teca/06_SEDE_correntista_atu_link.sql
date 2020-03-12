--Conectar com a conta CORRENTISTA_ATU
--
--No fim do script segue as connect strings utilizadas na cláusula USING
--

--Campinas
create database link PRKP.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'clusterkp'
/
select * from global_name@PRKP.INFRAERO.GOV.BR
/

--Guarulhos
create database link PRGR.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'clustergr'
/
select * from global_name@PRGR.INFRAERO.GOV.BR
/

--São José
create database link PRCG.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'clustercg'
/
select * from global_name@prcg.INFRAERO.GOV.BR
/

--Manaus
create database link PRMN.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERMN'
/
select * from global_name@PRMN.INFRAERO.GOV.BR
/

--Recife
create database link PRRF.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERRF'
/
select * from global_name@PRRF.INFRAERO.GOV.BR
/

--Rio de Janeiro
create database link PRRJ.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERRJ'
/
select * from global_name@PRRJ.INFRAERO.GOV.BR
/

--Porto Alegre
create database link PRPA.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERPA'
/
select * from global_name@PRPA.INFRAERO.GOV.BR
/

--Foz do Iguaçú
create database link prfi.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERFI'
/
select * from global_name@prfi.INFRAERO.GOV.BR
/

--Brasília
create database link PRBR.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERBR'
/
select * from global_name@PRBR.INFRAERO.GOV.BR
/

--Curitiba
create database link PRCT.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERCT'
/
select * from global_name@PRCT.INFRAERO.GOV.BR
/

--Belem
create database link PRBE.INFRAERO.GOV.BR
connect to CORRENTISTA_ATU identified by vpttrmyodyssyi
using 'CLUSTERBE'
/
select * from global_name@PRBE.INFRAERO.GOV.BR
/

------------------------------------------------------------------------------------------------


/* TNSNAMES.ORA

clustergr.infraero.gov.br=
 (DESCRIPTION_LIST=
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.2.17.47)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prgr1)
    )
  )
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.2.17.48)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prgr2)
    )
  )
)

clusterkp.infraero.gov.br =
 (DESCRIPTION_LIST=
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.42.17.16)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prkp1)
    )
  )
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.42.17.17)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prkp2)
    )
  )
)

clustercg.infraero.gov.br =
 (DESCRIPTION_LIST=
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.2.17.47)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prcg1)
    )
  )
  (DESCRIPTION =
    (ADDRESS_LIST =
	(ADDRESS =
	  (COMMUNITY = tcp.world)
	  (PROTOCOL = TCP)
	  (Host = 10.2.17.48)
	  (Port = 1521)
	)
    )
    (CONNECT_DATA = (SERVICE_NAME = prcg2)
    )
  )
)

CLUSTERRF.infraero.gov.br =
  (DESCRIPTION =
    (ADDRESS_LIST =
        (ADDRESS =
          (COMMUNITY = tcp.world)
          (PROTOCOL = TCP)
          (Host = S_RFBN28)
          (Port = 1521)
        )
        (ADDRESS =
          (COMMUNITY = tcp.world)
          (PROTOCOL = TCP)
          (Host = S_RFBN28)
          (Port = 1526)
        )
    )
    (CONNECT_DATA = (SID = IFR2RF)
    )
  )

CLUSTERMN.infraero.gov.br =
  (DESCRIPTION =
    (ADDRESS_LIST =
        (ADDRESS =
          (PROTOCOL = TCP)
          (Host = 10.3.17.6)
          (Port = 1521)
        )
    )
    (CONNECT_DATA = (SID = ifr1mn)
                    (SERVER = DEDICATED)
    )
  )

CLUSTERRJ.infraero.gov.br =
(DESCRIPTION_LIST =
  (DESCRIPTION =
    (ADDRESS_LIST =
        (ADDRESS = (PROTOCOL=TCP)(Host=10.1.17.4)(Port=1521))
    )
    (CONNECT_DATA = (SID = ifr1))
  )
  (DESCRIPTION =
    (ADDRESS_LIST =
        (ADDRESS = (PROTOCOL=TCP)(Host=10.1.17.5)(Port=1521))
    )
    (CONNECT_DATA = (SID = ifr2))
  )
)  

CLUSTERPA.INFRAERO.GOV.BR =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.4.17.71)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = ifr2pa)
    )
  )

CLUSTERFI.INFRAERO.GOV.BR =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.66.17.2)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = ifr1fi)
    )
  )


CLUSTERBR.INFRAERO.GOV.BR =
  (DESCRIPTION =
    (ADDRESS_LIST =
        (ADDRESS =
          (PROTOCOL = TCP)
          (Host = 10.6.17.20)
          (Port = 1526)
        )
    )
    (CONNECT_DATA = (SID = ifr1br)
    )
  )

CLUSTERCT.INFRAERO.GOV.BR =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.60.17.11)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = ifr1ct)
    )
  )

CLUSTERBE.infraero.gov.br =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.7.17.18)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SID = perseu)
      (SRVR = DEDICATED)
    )
  )




*/