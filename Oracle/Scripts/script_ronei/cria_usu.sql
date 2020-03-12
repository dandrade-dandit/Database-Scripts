 rem |   Cria conta e atribui role
 rem |
 rem | parametros: matricula e role
 rem |

 ACCEPT usu PROMPT 'DIGITE O MATRICULA: '
 ACCEPT role PROMPT 'DIGITE A ROLE: '

 SET ECHO ON
 CREATE USER &USU IDENTIFIED BY INFRAERO 
        DEFAULT TABLESPACE TS_FINAN 
        TEMPORARY TABLESPACE TEMP;

 GRANT &ROLE TO &USU;
 SET ECHO OFF;
 @C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\CRIA_USU.SQL