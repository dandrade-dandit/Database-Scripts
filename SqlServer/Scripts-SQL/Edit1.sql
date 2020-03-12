revoke rh_perfil_99 from C000225  ;      --DESCONHECIDO 4 - OK  
revoke rh_perfil_99 from I1190836  ;     --ADRIANO MESSIAS - OK
revoke rh_perfil_99 from CTIS0888   ;    --ESTEBAN 2 -  OK 
revoke rh_perfil_99 from T725761381  ;   --LUIS FABIO -  OK
revoke rh_perfil_99 from T057126701  ;   --CLOVIS PITASSI - OK
revoke rh_perfil_99 from T834307251  ;   --MARCELÃO - OK
revoke rh_perfil_99 from CTIS1269  ;     --DESCONHECIDO 3 - OK    
revoke rh_perfil_99 from T029096481 ;    --ANDRE FERNANDES - OK
revoke rh_perfil_99 from T398970361 ;    --DESCONHECIDO 2 - OK    
revoke rh_perfil_99 from T071299698  ;   --DESCONHECIDO - OK
revoke rh_perfil_99 from T733301321 ;    --ESTEBAN - OK 
revoke rh_perfil_99 from T016768161  ;   --EDUARDO - CADASTRO - OK
revoke rh_perfil_99 from T013470841 ;    --FELIPE - SICOF  - OK
revoke rh_perfil_99 from T563233871 ;    --MARCO ASSIS (CONTINUA)
revoke rh_perfil_99 from T398434161 ;    --BIGU - OK
revoke rh_perfil_99 from I1274337;       --ALLAN AMANCIO (CONTINUA)
revoke rh_perfil_99 from I1190934;       --JOSE BARBOSA - OK
revoke rh_perfil_99 from I0217750;       --QUEDIMA - OK

/*
SRH_SFP
I0200775
I9435685        
I9452098 
DISCOVERER_ADMIN
*/


C000225, CTIS0888, T725761381, T057126701, T834307251, CTIS1269, T029096481, T398970361, T071299698, T733301321, T016768161, T013470841, T563233871, T398434161.

I1190836
IFRDBA@bdsede131 SQL>@ROLE I1190836
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'I1190836'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
I1190836                       SRH_WEB                        NO  YES
I1190836                       SICAE_DARH                     NO  YES

REVOKE SICAE_DARH FROM I1190836;


I1274337
IFRDBA@bdsede131 SQL>@ROLE I1274337
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'I1274337'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
I1274337                       SICAE_DARH                     NO  YES
I1274337                       RH_SST_SAUDE                   NO  YES
I1274337                       MAT_GES_SED                    NO  YES
I1274337                       SRH_WEB                        NO  YES
I1274337                       SEG_GERAL                      NO  YES
I1274337                       SRH_ESTAGIARIO_MANUTENCAO      NO  YES

6 linhas selecionadas.

REVOKE SICAE_DARH, RH_SST_SAUDE, MAT_GES_SED, SEG_GERAL, SRH_ESTAGIARIO_MANUTENCAO FROM I1274337;


I1190934 
IFRDBA@bdsede131 SQL>@ROLE I1190934
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'I1190934'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
I1190934                       SRH_WEB                        NO  YES
I1190934                       SRH_TRN_01                     NO  YES

REVOKE SRH_TRN_01 FROM I1190934;


I0217750
IFRDBA@bdsede131 SQL>@ROLE I0217750
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'I0217750'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
I0217750                       SRH_WEB                        NO  YES
I0217750                       RL_VAX_SICOM                   NO  YES
I0217750                       RL_VAX_RDB                     NO  YES
I0217750                       SEG_GERAL                      NO  YES
I0217750                       SIAD_COMAVAL                   NO  YES


REVOKE RL_VAX_SICOM, RL_VAX_RDB, SEG_GERAL, SIAD_COMAVAL FROM I0217750;

--*****************
--BIGU
IFRDBA@bdsede131 SQL>@role T398434161
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T398434161'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T398434161                     SRH_CONCURSO_DEPENDENCIA       NO  YES
T398434161                     SRH_CONCURSO_BOLSISTA_MANUT    NO  YES
T398434161                     RH_SST_MASTER                  NO  YES
T398434161                     SRH_CONCURSO_SEDE              NO  YES
T398434161                     SRH_CONCURSO_CONSULTA          NO  YES
T398434161                     SRH_ESTAGIARIO_MANUTENCAO      NO  YES
T398434161                     SRHRSP_RESP                    NO  YES
T398434161                     SRH_WEB                        NO  YES
T398434161                     SICAE_GER                      NO  YES
T398434161                     SRH_CONCURSO_MANUTENCAO        NO  YES
T398434161                     SRH_PAGAMENTO_BOLSA            NO  YES
T398434161                     SRH_TRN_03                     NO  YES
T398434161                     SRH_PROMOCAO                   NO  YES
T398434161                     SRH_ESTAGIARIO_CONSULTA        NO  YES
T398434161                     SRH_CONCURSO_BOLSISTA_SEDE     NO  YES
T398434161                     SRH_CONSULTA                   NO  YES
T398434161                     SRH_TRN_01                     NO  YES
T398434161                     SRH_ESTAGIARIO_DEPENDENCIA     NO  YES
T398434161                     SEG_GERAL                      NO  YES
T398434161                     INFRADOC_GERAL                 NO  YES
T398434161                     SRH_ESTAGIARIO_SEDE            NO  YES
T398434161                     SRHRSP_RHTE                    NO  YES

--**********************
--EDUARDO CADASTRO
IFRDBA@bdsede131 SQL>@ROLE T016768161
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T016768161'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T016768161                     RH_BEN_99                      NO  YES
T016768161                     SEG_GERAL                      NO  YES
T016768161                     RH_SFP_99                      NO  YES
T016768161                     RH_CAD_99                      NO  YES


--*******************************
--ESTEBAN
IFRDBA@bdsede131 SQL>@ROLE T733301321
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T733301321'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T733301321                     SRH_ESTAGIARIO_MANUTENCAO      NO  YES
T733301321                     SRH_ESTAGIARIO_SEDE            NO  YES
T733301321                     SRH_PAGAMENTO_BOLSA            NO  YES
T733301321                     SRH_TRN_01                     NO  YES
T733301321                     SRH_ESTAGIARIO_DEPENDENCIA     NO  YES
T733301321                     MAT_USU_EXT                    NO  YES
T733301321                     RL_VAX_SICOM                   NO  YES
T733301321                     RL_VAX_COBRA                   NO  YES
T733301321                     SRH_CONCURSO_MANUTENCAO        NO  YES
T733301321                     SRH_CONCURSO_SEDE              NO  YES
T733301321                     SRH_CONCURSO_BOLSISTA_MANUT    NO  YES
T733301321                     SEG_GERAL                      NO  YES
T733301321                     SRHRSP_RHTE                    NO  YES
T733301321                     RL_VAX_RDB                     NO  YES
T733301321                     SRH_CONCURSO_DEPENDENCIA       NO  YES
T733301321                     RH_SST_MASTER                  NO  YES
T733301321                     SICAE_DARH                     NO  YES
T733301321                     SRH_CONCURSO_BOLSISTA_SEDE     NO  YES


--****************************
--DESCONHECIDO
IFRDBA@bdsede131 SQL>@ROLE T071299698
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T071299698'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T071299698                     PAT_TEC_CUSTO                  NO  YES
T071299698                     LICRSP_AGLI                    NO  YES
T071299698                     SICST_CONSULTA                 NO  YES
T071299698                     SEG_GERAL                      NO  YES
T071299698                     SRHRSP_RHTE                    NO  YES
T071299698                     SRH_BEN_13                     NO  YES

6 linhas selecionadas.

--**************************
--DESCONHECIDO 2
IFRDBA@bdsede131 SQL>@ROLE T398970361
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T398970361'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T398970361                     RH_BEN_99                      NO  YES
T398970361                     RH_SFP_99                      NO  YES


--****************
--ANDRE FERNANDES
IFRDBA@bdsede131 SQL>@ROLE T029096481
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T029096481'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T029096481                     SRH_ESTAGIARIO_SEDE            NO  YES
T029096481                     SEG_GERAL                      NO  YES
T029096481                     SRH_CAD_99                     NO  YES
T029096481                     SRH_ESTAGIARIO_DEPENDENCIA     NO  YES
T029096481                     SRH_WEB                        NO  YES
T029096481                     RH_SFP_99                      NO  YES
T029096481                     RH_BEN_99                      NO  YES
T029096481                     SRH_CONCURSO_MANUTENCAO        NO  YES
T029096481                     SRH_CONCURSO_BOLSISTA_MANUT    NO  YES
T029096481                     RH_CAD_99                      NO  YES
T029096481                     SRH_CONCURSO_SEDE              NO  YES
T029096481                     SRH_ESTAGIARIO_CONSULTA        NO  YES

12 linhas selecionadas.


--***************
--DESCONHECIDO 3
IFRDBA@bdsede131 SQL>@ROLE CTIS1269
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'CTIS1269'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
CTIS1269                       SRH_PAGAMENTO_BOLSA            NO  YES
CTIS1269                       SRH_ESTAGIARIO_SEDE            NO  YES
CTIS1269                       SRH_CONCURSO_MANUTENCAO        NO  YES
CTIS1269                       SRH_CONCURSO_DEPENDENCIA       NO  YES
CTIS1269                       SRH_ESTAGIARIO_MANUTENCAO      NO  YES
CTIS1269                       SRHRSP_RESP                    NO  YES
CTIS1269                       SRH_ESTAGIARIO_DEPENDENCIA     NO  YES
CTIS1269                       SRHRSP_RHTE                    NO  YES
CTIS1269                       SRH_CONCURSO_SEDE              NO  YES
CTIS1269                       SRH_CONCURSO_BOLSISTA_MANUT    NO  YES
CTIS1269                       SRH_TRN_01                     NO  YES
CTIS1269                       RL_VAX_RDB                     NO  YES
CTIS1269                       SRHRSP_WEB                     NO  YES
CTIS1269                       SRH_CONCURSO_BOLSISTA_SEDE     NO  YES


--***************************
--MARCELÃO
IFRDBA@bdsede131 SQL>@ROLE T834307251
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T834307251'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T834307251                     SEG_GERAL                      NO  YES
T834307251                     SRH_ESTAGIARIO_MANUTENCAO      NO  YES
T834307251                     SRH_BEN_13                     NO  YES

--**************
--CLOVIS PITASSI
IFRDBA@bdsede131 SQL>@ROLE T057126701
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T057126701'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T057126701                     RH_SFP_99                      NO  YES
T057126701                     SRH_CAD_99                     NO  YES
T057126701                     RL_VAX_SICOM                   NO  YES
T057126701                     RL_VAX_RDB                     NO  YES

--***************************
--LUIS FABIO
IFRDBA@bdsede131 SQL>
IFRDBA@bdsede131 SQL>@ROLE T725761381
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T725761381'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T725761381                     RH_SFP_99                      NO  YES
T725761381                     SRHRSP_RHTE                    NO  YES
T725761381                     SRH_WEB                        NO  YES
T725761381                     SEG_GERAL                      NO  YES
T725761381                     SRH_BEN_13                     NO  YES
T725761381                     SRH_CAD_99                     NO  YES
T725761381                     RH_BEN_99                      NO  YES
T725761381                     SRH_ESTAGIARIO_MANUTENCAO      NO  YES
T725761381                     SRH_ESTAGIARIO_CONSULTA        NO  YES
T725761381                     SRHRSP_RESP                    NO  YES


--*****************************
--ESTEBAN 2
IFRDBA@bdsede131 SQL>@ROLE CTIS0888
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'CTIS0888'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
CTIS0888                       RL_VAX_RDB                     NO  YES
CTIS0888                       MAT_USU_EXT                    NO  YES
CTIS0888                       PROUVI_CONSULTA_GERAL          NO  YES
CTIS0888                       SRH_CONCURSO_SEDE              NO  YES
CTIS0888                       SRH_CONCURSO_BOLSISTA_MANUT    NO  YES
CTIS0888                       SRH_ESTAGIARIO_DEPENDENCIA     NO  YES
CTIS0888                       RL_VAX_SICOM                   NO  YES
CTIS0888                       SRH_CONCURSO_MANUTENCAO        NO  YES
CTIS0888                       SRH_CONCURSO_DEPENDENCIA       NO  YES
CTIS0888                       SICAE_DARH                     NO  YES
CTIS0888                       SRH_TRN_01                     NO  YES
CTIS0888                       SRH_ESTAGIARIO_MANUTENCAO      NO  YES
CTIS0888                       SRH_ESTAGIARIO_SEDE            NO  YES
CTIS0888                       SRH_PAGAMENTO_BOLSA            NO  YES
CTIS0888                       RL_VAX_COBRA                   NO  YES
CTIS0888                       SEG_GERAL                      NO  YES
CTIS0888                       SRH_CONCURSO_BOLSISTA_SEDE     NO  YES


--*********************
--DESCONHECIDO 4
IFRDBA@bdsede131 SQL>@ROLE C000225
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'C000225'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
C000225                        SRH_BEN_13                     NO  YES
C000225                        LICRSP_AGLI                    NO  YES
C000225                        SEG_GERAL                      NO  YES
C000225                        SRHRSP_RHTE                    NO  YES
C000225                        SICST_CONSULTA                 NO  YES


--*******************
--FELIPE - SICOF
IFRDBA@bdsede131 SQL>@role T013470841
antigo   1: select * from  dba_role_privs where grantee = '&1'
novo   1: select * from  dba_role_privs where grantee = 'T013470841'

GRANTEE                        GRANTED_ROLE                   ADM DEF
------------------------------ ------------------------------ --- ---
T013470841                     ORC_GER_GERAL                  NO  YES
T013470841                     ORC_GER_USR                    NO  YES
T013470841                     ORC_GER_ORC                    NO  YES
T013470841                     SEG_GERAL                      NO  YES