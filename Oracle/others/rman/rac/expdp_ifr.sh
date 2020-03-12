chmod 770 /backup/export/*
rm -f /backup/export/*
expdp operacao/infraero FULL=Y DIRECTORY=EXP_DUMP DUMPFILE=EXP_FULL.DPM LOGFILE=EXP_FULL.LOG PARALLEL=3
/usr/openv/netbackup/bin/bpbackup -p Linux_Oracle_Export -s Linux_Export -S s-segu113 -t 0 /backup/export
