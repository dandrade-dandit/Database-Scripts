#!/bin/sh
#
#Inicio da função de shutdown immediate
funct_startup ( ) {
${ORACLE_HOME}/bin/sqlplus -s << EOF
/ as sysdba
startup
exit
EOF
}
funct_start_listener ( ) {
${ORACLE_HOME}/bin/lsnrctl start 
}
# Executa a função
funct_start_listener
funct_startup
# Encerra a execução

echo "Script startdb.sh executado por: `who am i`" >> log/startdb.sh
echo "********************************************************************************" >> log/startdb.sh