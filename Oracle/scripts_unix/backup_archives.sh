ls -l /archifr4/arc* |head -5 | cut -c57-87 > /u01/app/scripts/teste
count=1
while [ $count -le 2 ];
 do
    if 	[ $count -e 1 ]; then
    	tar cvf /archifr4/teste.tar `head -$count /u01/app/scripts/teste |tail -1`
    else
        tar uvf /archifr4/teste.tar `head -$count /u01/app/scripts/teste |tail -1`
    fi
    # echo "tar cvf /archifr4/teste.tar `head -$count /u01/app/scripts/teste |tail -1 `" >> /u01/app/scripts/teste2
    # echo "rm -f `head -$count /u01/app/scripts/teste |tail -1 `" >> /u01/app/scripts/teste2
   count=`expr $count + 1`
 done