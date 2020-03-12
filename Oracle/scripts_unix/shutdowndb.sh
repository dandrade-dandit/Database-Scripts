#!/bin/sh
#
#Inicio da função de shutdown immediate
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
# Executa a função
funct_stop_listener
funct_shutdown_i
# Encerra a execução

echo "Script shutdowndb.sh executado por: `who am i`" >> log/shutdowndb.sh
echo "********************************************************************************" >> log/shutdownabort.sh