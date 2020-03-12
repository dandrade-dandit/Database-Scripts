#!/bin/sh
#
#Inicio da fun��o de shutdown immediate
funct_shutdown_a ( ) {
${ORACLE_HOME}/bin/sqlplus -s << EOF
/ as sysdba
shutdown abort
exit
EOF
}
funct_stop_listener ( ) {
${ORACLE_HOME}/bin/lsnrctl stop 
}
# Executa a fun��o
funct_stop_listener
funct_shutdown_a
# Encerra a execu��o

echo "Script shutdownabort.sh executado por: `who am i`" >> log/shutdownabort.sh
echo "********************************************************************************" >> log/shutdownabort.sh