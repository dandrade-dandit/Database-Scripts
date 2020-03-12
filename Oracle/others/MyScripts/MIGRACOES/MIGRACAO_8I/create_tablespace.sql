
CREATE TABLESPACE TSD_MAXIMO
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_MAXIMO01.DBF' SIZE 1200M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSD_SELO
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_SELO01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_SELO02.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_SELO03.DBF' SIZE 1000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSD_BDCLIM
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_BDCLIM01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_BDCLIM02.DBF' SIZE 2000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TOOLS
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TOOLS01.DBF' SIZE 2000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSD_INDICE
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_INDICE01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_INDICE02.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_INDICE03.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_INDICE04.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_INDICE05.DBF' SIZE 2000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSD_PESSOAL
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_PESSOAL01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_PESSOAL02.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_PESSOAL03.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_PESSOAL04.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_PESSOAL05.DBF' SIZE 2000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSD_FINAN
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_FINAN01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_FINAN02.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_FINAN03.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_FINAN04.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSD_FINAN05.DBF' SIZE 1000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSI_BDCLIM
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_BDCLIM.DBF' SIZE 1536M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/

CREATE TABLESPACE TSI_SELO
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_SELO01.DBF' SIZE 2000M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_SELO02.DBF' SIZE 2000M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/


CREATE TABLESPACE TSI_PESSOAL
DATAFILE 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_PESSOAL01.DBF' SIZE 2048M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_PESSOAL02.DBF' SIZE 2048M AUTOEXTEND OFF,
	 'G:\ORACLE\ORADATA\IFR1SEDE\TSI_PESSOAL03.DBF' SIZE 2048M AUTOEXTEND OFF
ONLINE
EXTENT MANAGEMENT LOCAL
/