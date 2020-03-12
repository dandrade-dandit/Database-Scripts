rman target / rcvcat rman_sebu59/infraero@sebn07 msglog '/u02/backup/rman.log' append << EOF
#Limpa os registros dos Archives apagados
allocate channel for maintenance type disk;
change archivelog all crosscheck;
release channel;
#Backup das tablepsaces 
run {execute script BkpFullNivel1_2;}
#backup dos Archives
run {execute script BkpFullArchives_2;}
#Lista os Backups atuais
list backup;
list copy of archivelog all;
EOF