SQL> 

SQL> select parameter,value from nls_database_parameters;

PARAMETER                      VALUE
------------------------------ ----------------------------------------
NLS_LANGUAGE                   AMERICAN
NLS_TERRITORY                  AMERICA
NLS_CURRENCY                   $
NLS_ISO_CURRENCY               AMERICA
NLS_NUMERIC_CHARACTERS         .,
NLS_CHARACTERSET               WE8ISO8859P1
NLS_CALENDAR                   GREGORIAN
NLS_DATE_FORMAT                DD-MON-RR
NLS_DATE_LANGUAGE              AMERICAN
NLS_SORT                       BINARY
NLS_TIME_FORMAT                HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT           DD-MON-RR HH.MI.SSXFF AM
NLS_TIME_TZ_FORMAT             HH.MI.SSXFF AM TZH:TZM
NLS_TIMESTAMP_TZ_FORMAT        DD-MON-RR HH.MI.SSXFF AM TZH:TZM
NLS_DUAL_CURRENCY              $
NLS_COMP                       BINARY
NLS_NCHAR_CHARACTERSET         WE8ISO8859P1
NLS_RDBMS_VERSION              8.1.7.4.0

18 linhas selecionadas.

SQL> @i

INSTANCE_NUMBER INSTANCE_NAME    HOST_NAME                      STARTUP_ STATUS  PAR    THREAD# ARCHIVE
--------------- ---------------- ------------------------------ -------- ------- --- ---------- -------
              1 inet             s-sebu56                       23/10/03 OPEN    NO           1 STARTED

1 linha selecionada.

USER é "SYSMAN"
SQL> 