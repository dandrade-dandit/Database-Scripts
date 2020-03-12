#!/bin/sh
#
#Inicio da fun��o de shutdown immediate
funct_shutdown_i ( ) {
${ORACLE_HOME}/bin/sqlplus -s << EOF
/ as sysdba
shutdown immediate
exit
EOF
}
funct_stop_listener ( ) {
${ORACLE_HOME}/bin/lsnrctl stop
}
# Executa a fun��o
funct_stop_listener
funct_shutdown_i
# Encerra a execu��o

echo "Script shutdowndb.sh executado por: `who am i`" >> log/shutdowndb.sh
echo "********************************************************************************" >> log/shutdownabort.sh