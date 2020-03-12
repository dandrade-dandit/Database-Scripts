#!/bin/sh
#
#Inicio da função de shutdown immediate
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
# Executa a função
funct_stop_listener
funct_shutdown_a
# Encerra a execução

echo "Script shutdownabort.sh executado por: `who am i`" >> log/shutdownabort.sh
echo "********************************************************************************" >> log/shutdownabort.sh