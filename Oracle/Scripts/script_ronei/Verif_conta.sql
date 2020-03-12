-- CONTAS PARA EMPREGADOS DEMITIDOS
select 'drop user '||b.username||';'
from  dba_users b
where exists (select a.emp_numero_matricula
           from cadastros a
           where a.emp_numero_matricula = to_number(substr(b.username,2,7)) and
                 a.emp_status=2) and
b.username not like 'IF%' and
b.username not like 'IN%' and
b.username like 'I%'
/

-- CONTAS FORA DO CADASTRO
select b.username,c.no_usuario,c.dep_cd_dependencia
from  dba_users b, seg_usuario c
where c.id_usuario(+)=b.username and
      not exists (select a.emp_numero_matricula
                 from cadastros a
                 where a.emp_numero_matricula = to_number(substr(b.username,2,7))) and
      b.username not like 'IF%' and
      b.username not like 'IN%' and
      b.username like 'I%' ;

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I0000000
I0008335
I0012977                       TÂNIA MARIA NABUCO B. E PAIVA                   1
I0019147
I0020427                       IRENE MARIA SOARES FABRINO                      1
I0027852                       ARMANDO BARBOSA                                 1
I0058136                       YEDDA MARIA DOS SANTOS
I0092012                       MAURO CAUVILE                                   2
I0096929                       NILCE MARIA C DOS SANTOS                        1
I0100457
I0103035                       FERNANDO SIRACUSA VIANA COELHO                  2
I0108723                       MANOEL REYS                                    57
I0140103                       EROTIDES GONZAGA DA SILVA                      57
I0158418                       MARIA APARECIDA T.SOARES                       10
I0203379
I0416832                       CLÁUDIA FERNANDES DE ARAÚJO                    61
I0423632
I0515653                       PAULO ROBERTO P. BATISTA                       61
I0537041                       JORGE FERNANDO MACEDO BRAGA                    61
I0635456                       WLADIMIR B. LOBO
I0693454

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I0700449                       ADILSON PEREIRA DA SILVA                       49
I0727217                       NADIA HALIL AIDÉ RODRIGUES                     61
I0824625
I0833828
I0835528                       DAISY GONÇALVES BELEM                          13
I0843133                       SIRLENE DE OLIVEIRA PINTO                      61
I0902792
I0946992
I0958266
I1073641                       VIOLETA L G F LEITE                             2
I1215843
I1500061                       IRACEMA BARROS DA S. FILHA                     25
I1503668                       MARCOS JOSÉ SANTANA                             2
I1532828                       EDMAR  SOCORRO F. MARQUES                      25
I1538238
I1565128                       TARCISIO MOTA ALEXANDRE                        25
I1943210                       HOSANNAH DA FONSECA LEDO                        4
I1947619                       TÂNIA MARIA DE AQUINO BRITO                    25
I1973113                       DULCÍDIO SOARES MONTEIRO                        4
I2011161
I2112057

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I2327042
I2551624                       FRANCISCO JOSELITO CÂNDIDO LIM                  6
I2627029
I2809099                       JOSÉ MOACIR RIBEIRO                            57
I3001915
I3139985                       FRANCISCO VALTER P.FILHO
I3160789                       DANIELE MARA TOURÃO
I3937980
I4129938                       LOURENÇO R. DA  MATA FILHO                     57
I4132826                       JOSÉ CARLOS SILVINO                            64
I4154342                       MARCO AURELIO T. MAGALHÃES                     61
I4154721
I4161719
I4234532
I4241332                       LUIZ GONZAGA V. LEITE JUNIO                    14
I5811405                       MARIA LIZANGELA A LEITE
I6030640                       SILVÉRIO GONÇALVES                             58
I6049708
I6596555
I6935969
I7034380

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I7204123
I8078386                       LUCIA DE FÁTIMA ANDRADE                         2
I9003526
I9004910                       ELAINE GUIMARÃES TRINDADE                      57
I9009310
I9014308
I9025411
I9035702                       SEBASTIÃO F SOBRINHO                          901
I9036509                       PAULO ROBERTO DE ANDRADE                        1
I9061190                       RAIMUNDO RODRIGUES S. FILHO                    25
I9080101                       SÉRGIO FERNANDES BALTORÉ                       14
I9094492                       ANTONIO HENRIQUE M. PAREDES                     4
I9094906
I9415887
I9438744                       COSME XAVIER CAMPOS                            57
I9448976                       ADEL SARAIVA PEÑA                              13
I9454198                       ROBERTA HELENA OSTINI                          57
I9464646                       HELIO RODRIGUES SAMPAIO                         1
I9468644
I9475763                       VICENTE DE PAULO SILVA                          1
I9482573                       JOAQUINA MARGARETH NETO BESERR                 14

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I9492411
I9500115                       SANDRA MARIA GUIDO                             60
I9503274                       EZENILDES R. DE B. DOS SANTOS                  56
I9513590                       NIVEA SILVEIRA CARPES                          13
I9519583
I9523514                       CARLOS JOSÉ BARROS PEREIRA                     25
I9553085                       GILMAR P. RODRIGUES                             2
I95557274
I9557460                       MARIA S. DOS SANTOS
I9601212                       JOSÉ FRANCISCO M.FREIRE                        14
I9648976                       ADEL SARAIVA PENA                              13
I9689648                       JUSSARA RODRIGUES GOUVEIA                      13
I9750570                       ELIANE M B SOUZA                                1
I9767858
I9776862                       MARCELO LUIZ SALAME                            47
I9788739
I9795454                       SANDRA MARIA N. ARAUJO                         62
I9883367
I9900208                       SISMAT/SISLIC
I9999998
I9999999                       CADASTRO                                        1

105 rows selected.

SQL> 

-- CONTAS FORA DO CADASTRO E DO SISEG
select 'drop user '||b.username||';'
from  dba_users b
where not exists (select c.id_usuario
                 from seg_usuario c
                 where c.id_usuario = b.username) and
      not exists (select a.emp_numero_matricula
                 from cadastros a
                 where a.emp_numero_matricula = to_number(substr(b.username,2,7))) and
      b.username not like 'IF%' and
      b.username not like 'IN%' and
      b.username like 'I%' ;

'DROPUSER'||B.USERNAME||';'
-----------------------------------------
drop user I0000000;
drop user I0008335;
drop user I0019147;
drop user I0100457;
drop user I0203379;
drop user I0423632;
drop user I0693454;
drop user I0824625;
drop user I0833828;
drop user I0902792;
drop user I0946992;
drop user I0958266;
drop user I1215843;
drop user I1538238;
drop user I2011161;
drop user I2112057;
drop user I2327042;
drop user I2627029;
drop user I3001915;
drop user I3937980;
drop user I4154721;

'DROPUSER'||B.USERNAME||';'
-----------------------------------------
drop user I4161719;
drop user I4234532;
drop user I6049708;
drop user I6596555;
drop user I6935969;
drop user I7034380;
drop user I7204123;
drop user I9003526;
drop user I9009310;
ERROR:
ORA-01722: invalid number



29 rows selected.




senhas alteradas para vax em 20/08/01 *******************************

SQL> select b.username,c.no_usuario,c.dep_cd_dependencia
  2  from  dba_users b, seg_usuario c
  3  where c.id_usuario(+)=b.username and
  4        not exists (select a.emp_numero_matricula
  5                   from cadastros a
  6                   where a.emp_numero_matricula = to_number(substr(b.username,2,7))) and
  7        b.username not like 'IF%' and
  8        b.username not like 'IN%' and
  9        b.username like 'I%' ;

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I0000000
I0012977                       TÂNIA MARIA NABUCO B. E PAIVA                   1
I0020427                       IRENE MARIA SOARES FABRINO                      1
I0027852                       ARMANDO BARBOSA                                 1
I0058136                       YEDDA MARIA DOS SANTOS
I0092012                       MAURO CAUVILE                                   2
I0096929                       NILCE MARIA C DOS SANTOS                        1
I0103035                       FERNANDO SIRACUSA VIANA COELHO                  2
I0108723                       MANOEL REYS                                    57
I0140103                       EROTIDES GONZAGA DA SILVA                      57
I0158418                       MARIA APARECIDA T.SOARES                       10
I0416832                       CLÁUDIA FERNANDES DE ARAÚJO                    61
I0515653                       PAULO ROBERTO P. BATISTA                       61
I0537041                       JORGE FERNANDO MACEDO BRAGA                    61
I0635456                       WLADIMIR B. LOBO
I0700449                       ADILSON PEREIRA DA SILVA                       49
I0727217                       NADIA HALIL AIDÉ RODRIGUES                     61
I0835528                       DAISY GONÇALVES BELEM                          13
I0843133                       SIRLENE DE OLIVEIRA PINTO                      61
I1073641                       VIOLETA L G F LEITE                             2
I1500061                       IRACEMA BARROS DA S. FILHA                     25

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I1503668                       MARCOS JOSÉ SANTANA                             2
I1532828                       EDMAR  SOCORRO F. MARQUES                      25
I1565128                       TARCISIO MOTA ALEXANDRE                        25
I1943210                       HOSANNAH DA FONSECA LEDO                        4
I1947619                       TÂNIA MARIA DE AQUINO BRITO                    25
I1973113                       DULCÍDIO SOARES MONTEIRO                        4
I2551624                       FRANCISCO JOSELITO CÂNDIDO LIM                  6
I2809099                       JOSÉ MOACIR RIBEIRO                            57
I3139985                       FRANCISCO VALTER P.FILHO
I3160789                       DANIELE MARA TOURÃO
I4129938                       LOURENÇO R. DA  MATA FILHO                     57
I4132826                       JOSÉ CARLOS SILVINO                            64
I4154342                       MARCO AURELIO T. MAGALHÃES                     61
I4241332                       LUIZ GONZAGA V. LEITE JUNIO                    14
I5811405                       MARIA LIZANGELA A LEITE
I6030640                       SILVÉRIO GONÇALVES                             58
I8078386                       LUCIA DE FÁTIMA ANDRADE                         2
I9004910                       ELAINE GUIMARÃES TRINDADE                      57
I9035702                       SEBASTIÃO F SOBRINHO                          901
I9036509                       PAULO ROBERTO DE ANDRADE                        1
I9061190                       RAIMUNDO RODRIGUES S. FILHO                    25

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I9080101                       SÉRGIO FERNANDES BALTORÉ                       14
I9094492                       ANTONIO HENRIQUE M. PAREDES                     4
I9438744                       COSME XAVIER CAMPOS                            57
I9448976                       ADEL SARAIVA PEÑA                              13
I9464646                       HELIO RODRIGUES SAMPAIO                         1
I9475763                       VICENTE DE PAULO SILVA                          1
I9482573                       JOAQUINA MARGARETH NETO BESERR                 14
I9500115                       SANDRA MARIA GUIDO                             60
I9503274                       EZENILDES R. DE B. DOS SANTOS                  56
I9513590                       NIVEA SILVEIRA CARPES                          13
I9523514                       CARLOS JOSÉ BARROS PEREIRA                     25
I9553085                       GILMAR P. RODRIGUES                             2
I9557460                       MARIA S. DOS SANTOS
I9601212                       JOSÉ FRANCISCO M.FREIRE                        14
I9648976                       ADEL SARAIVA PENA                              13
I9689648                       JUSSARA RODRIGUES GOUVEIA                      13
I9750570                       ELIANE M B SOUZA                                1
I9776862                       MARCELO LUIZ SALAME                            47
I9779446                       MARIO CLAUDIO Q. DE ALMEIDA
I9795454                       SANDRA MARIA N. ARAUJO                         62
I9796041

USERNAME                       NO_USUARIO                     DEP_CD_DEPENDENCIA
------------------------------ ------------------------------ ------------------
I9900208                       SISMAT/SISLIC
I9999999                       CADASTRO                                        1

65 rows selected.





--período
select 'Periodo de '||min(timestamp)||' ate '||max(timestamp)
from dba_audit_session;


--total de acessos, POR U.O.
select upper(substr(uor_sigla,1,4)),' Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' and
returncode <> 1017
group by upper(substr(uor_sigla,1,4));

--total de acessos da area de INFORMÁTICA com conta de usuário, POR U.O.
select upper(substr(uor_sigla,1,4)),' Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by upper(substr(uor_sigla,1,4));

--total de acessos da area de INFORMÁTICA com conta de usuário, POR CONTA E U.O.
select OS_USERNAME||'       '||upper(substr(uor_sigla,1,4))||'   Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by OS_USERNAME,upper(substr(uor_sigla,1,4));

--acessos da area de INFORMÁTICA com conta de usuário, POR CONTA NA REDE
select OS_USERNAME||'       '||upper(emp_nome)||'   Qtd:'||count(*)
from dba_audit_session,cadastros
--,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
--emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
instr(upper(emp_nome),upper(substr(os_username,6,5))) = 0   and
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by OS_USERNAME,upper(emp_nome);
 
-- CONEXOES INDEVIDAS SEM SUCESSO
select OS_USERNAME||'     '||USERNAME||'   Qtd:'||count(*)
from dba_audit_session
where username NOT like 'I%' AND
      returncode = 1017
GROUP BY OS_USERNAME,USERNAME;
