# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
umask 022
TZ=America/Sao_Paulo; export TZ
#ORACLE_HOSTNAME=s-sebu86.localdomain; export ORACLE_HOSTNAME
ORACLE_HOSTNAME=s-sebu86.infraero.gov.br; export ORACLE_HOSTNAME
ORACLE_SID=ifrprod1; export ORACLE_SID
ORACLE_UNQNAME=ifrprod; export ORACLE_UNQNAME
ORACLE_BASE=/u01/rdbms/oracle; export ORACLE_BASE
ORACLE_HOME=/u01/rdbms/oracle/product/11.2/dbhome_1; export ORACLE_HOME
ORACLE_AGENT=/u01/rdbms/oracle/product/11.2/dbhome_1/agent12c; export ORACLE_AGENT
ORA_CRS_HOME=/u01/crs/product/11.2/crs_1; export ORA_CRS_HOME
ORACLE_PATH=$ORACLE_BASE/common/oracle/sql:.:$ORACLE_HOME/rdbms/admin
export ORACLE_PATH
#PATH=$PATH:$ORACLE_HOME/bin: export PATH
TNS_ADMIN=$ORACLE_HOME/network/admin; export TNS_ADMIN
NLS_LANG=American_America.WE8ISO8859P1; export NLS_LANG
NLS_CHARACTERSET=WE8ISO8859P1; export NLS_CHARACTERSET
#NLS_LANG=American_America.AL32UTF8; export NLS_LANG
#NLS_CHARACTERSET=AL32UTF8; export NLS_CHARACTERSET
#LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORA_CRS_HOME/lib:$ORACLE_HOME/lib32:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
#LIBPATH=$ORACLE_HOME/lib:$ORA_CRS_HOME/lib:$ORACLE_HOME/lib32:$LIBPATH; export LIBPATH
PATH=$PATH/usr/bin:/bin:/usr/bin/X11:/usr/sbin:/sbin:$ORACLE_HOME:$ORACLE_HOME/bin:$ORACLE_BASE:$ORA_CRS_HOME:$ORA_CRS_HOME/bin:/u01/rdbms/oracle/common/oracle/sql
export PATH

EDITOR=vi
export EDITOR

alias rm='rm -i'

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:$ORA_CRS_HOME/inventory/Scripts/ext/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

if [ $USER = "oracle" ]; then
  if [ $SHELL = "/bin/ksh" ]; then
    ulimit -p 16384
    ulimit -n 65536
  else
    ulimit -u 16384 -n 65536
  fi
fi

PATH=$PATH:$ORACLE_HOME/OPatch
export PATH 
