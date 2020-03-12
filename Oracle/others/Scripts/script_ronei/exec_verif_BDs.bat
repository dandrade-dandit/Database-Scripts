echo off
echo ********************************
echo ---conectando Serv. Aplic. S_SEBN12 - PRODUCAO
ping 10.0.17.12
pause
echo ********************************
echo ---conectando Serv. Aplic. S_SEAN07 - DESENVOLVIMENTO 
ping 10.0.17.07
pause
echo ********************************
echo ---conectando Serv. Banco S_SEBN02 - HOMOLOG 
ping 10.0.17.2
pause
echo ********************************
echo ---conectando Serv. Banco S_SEBU04 - PRODSEDE 
ping 10.0.17.4
pause
echo ********************************
echo ---conectando Serv. Banco S_SEBU05 - PRODSEDE 
ping 10.0.17.5
pause
echo ********************************
echo ---conectando ORACLE S_SEBN02 - HOMOLOGACAO
plus33 -s operacao/operacao@homolog @c:\Check-list-BDs\exec_verif_BDs_oracle.sql
pause
echo ********************************
echo ---conectando Oracle S_SEBU04 - PRODUCAO 4
plus33 -s operacao/operacao@maquina4 @c:\Check-list-BDs\exec_verif_BDs_oracle.sql
pause
echo ********************************
echo ---conectando Oracle S_SEBU05 - PRODUCAO 5
plus33 -s operacao/operacao@maquina5 @c:\Check-list-BDs\exec_verif_BDs_oracle.sql
pause
echo ********************************
echo ---conectando Sqlserver S_SEBN60 - Smartstream
osql -U Operacao -P Operacao -S S_SEBN60 -d master -h-1 -i c:\Check-list-BDs\exec_verif_BDs_sqlserver.sql
pause
echo ********************************
echo ---conectando Sqlserver S_SEBN63 - Smartstream
osql -U Operacao -P Operacao -S S_SEBN63 -d master -h-1 -i c:\Check-list-BDs\exec_verif_BDs_sqlserver.sql

