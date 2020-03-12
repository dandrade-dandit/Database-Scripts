rm -f /u02/backup/rman.log
rman target / rcvcat rman_sebu59/infraero@sebn07 msglog '/u02/backup/rman.log' append << EOF
run { 
host "rm -f /u02/backup/rman/*";
}
#Limpa os registros das conjuntos de backup apagados
allocate channel for maintenance type disk;
crosscheck backup of database;
delete expired backup;
#Limpa os registros dos Archives apagados
allocate channel for maintenance type disk;
change archivelog all crosscheck;
release channel;
#Backup das tablepsaces 
run {execute script BkpFullNivel0_2;}
#backup dos Archives
run {execute script BkpFullArchives_2;}
#Lista os Backups atuais
list backup;
list copy of archivelog all;
EOF