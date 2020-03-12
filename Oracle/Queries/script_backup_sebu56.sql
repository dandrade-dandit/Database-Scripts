echo " INICIO DO BACKUP ONLINE "

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace SYSTEM begin backup;
EOF
echo "/ora01/inet/system01.dbf - 400 MB - SYSTEM"
cp /ora01/inet/system01.dbf /ora05/inet/backup/online/system01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace SYSTEM end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace TEMP begin backup;
EOF
echo "/ora01/inet/temp01.dbf - 100 MB - TEMP"
cp /ora01/inet/temp01.dbf /ora05/inet/backup/online/temp01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace TEMP end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace RBS begin backup;
EOF
echo "/ora03/inet/rbs01.dbf - 200 MB - RBS"
cp /ora03/inet/rbs01.dbf /ora05/inet/backup/online/rbs01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace RBS end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace DRSYS begin backup;
EOF
echo "/ora01/inet/drsys01.dbf - 90 MB - DRSYS"
cp /ora01/inet/drsys01.dbf /ora05/inet/backup/online/drsys01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace DRSYS end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_DAT begin backup;
EOF
echo "/ora01/inet/licit_dat01.dbf - 350 MB - LICIT_DAT"
cp /ora01/inet/licit_dat01.dbf /ora05/inet/backup/online/licit_dat01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_DAT end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_IDX begin backup;
EOF
echo "/ora03/inet/licit_idx01.dbf - 100 MB - LICIT_IDX"
cp /ora03/inet/licit_idx01.dbf /ora05/inet/backup/online/licit_idx01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_IDX end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_LOB begin backup;
EOF
echo "/ora03/inet/licit_lob01.dbf - 100 MB - LICIT_LOB"
cp /ora03/inet/licit_lob01.dbf /ora05/inet/backup/online/licit_lob01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace LICIT_LOB end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_DAT begin backup;
EOF
echo "/ora01/inet/cdcs_dat01.dbf - 350 MB - CDCS_DAT"
cp /ora01/inet/cdcs_dat01.dbf /ora05/inet/backup/online/cdcs_dat01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_DAT end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_IDX begin backup;
EOF
echo "/ora03/inet/cdcs_idx01.dbf - 200 MB - CDCS_IDX"
cp /ora03/inet/cdcs_idx01.dbf /ora05/inet/backup/online/cdcs_idx01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_IDX end backup;
EOF

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_LOB begin backup;
EOF
echo "/ora03/inet/cdcs_lob01.dbf - 100 MB - CDCS_LOB"
cp /ora03/inet/cdcs_lob01.dbf /ora05/inet/backup/online/cdcs_lob01.dbf

sqlplus /nolog << EOF
connect operacao/operacao;
alter tablespace CDCS_LOB end backup;
EOF

echo " FINAL DO BACKUP ONLINE "