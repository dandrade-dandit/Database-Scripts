#!/bin/sh

quantidade=`df -k | tail -1 | cut -c62-64`

if [$quantidade -ge 50 ]; then

  if [ `ps -ef | grep -v grep | grep -c RMAN`  -ge 1 ]; then
	at -f /u02/backup/valida_arch.sh now + 1 hours #agenda a execucao deste script para daki a 1 hora 
       
        echo "`date` -> Existem processos de RMAN em excecucao. Backup de Archive abortado" >> valida_arch.log
        echo "-----------------------------------------------------------------------" >>valida_arch.log
        exit 0
  fi

   at -f /u02/backup/valida_arch.sh now + 1 hours #agenda a execucao deste script para daki a 1 hora 
   echo "`date` -> Iniciando Backup dos Archives..." >> valida_arch.log

   /u02/backup/bkp_arch.sh #executa o script bkp_arch.sh

   echo "`date`-> Backup dos archives concluido com sucesso!" >> valida_arch.log
   echo "-----------------------------------------------------------------------" >>valida_arch.log

else
  at -f /u02/backup/valida_arch.sh now + 1 hours #agenda a execucao deste script para daki a 1 hora

  echo "`date` -> Utilizado apenas"$quantidade"% da area de archive." >> valida_arch.log
  echo "`date` -> O backup dos Archives e realizado quando o espaco ultrapassar 50%" >> valida_arch.log
  echo "-----------------------------------------------------------------------" >>valida_arch.log
  exit 0 
fi
