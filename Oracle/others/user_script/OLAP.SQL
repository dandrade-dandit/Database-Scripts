REM
REM     ORACLE - Licence Management Services
REM              Database Option Detection - OLAP
REM
REM     Change History
REM     Date:     Rev:   Author:                Description:
REM     10/18/02  1.0    John.Mielke            Original script 
REM       
REM     This script verifies if OLAP is installed and being used. 
REM     Connect with DBA privileges prior to running this script.
REM

SPOOL OLAP.TXT

cLEAR sCREEN

set feedbacK ON

PROMPT
PROMPT

PROMPT CHECKING TO SEE IF OLAP IS INSTALLLED / USED

set heading  off

PROMPT
PROMPT IF THE VALUE IS TRUE THEN THE OLAP OPTION IS INSTALLED
PROMPT IF THE VALUE IS FALSE THEN THE OLAP OPTION IS NOT INSTALLED
PROMPT IF NO ROWS ARE SELECTED THEN THE OPTION IS NOT BEING USED
select 
	value
from 
	v$option 
where 
	parameter = 'OLAP';

set feedback off

PROMPT
PROMPT

PROMPT CHECKING TO SEE IF THE OLAP OPTION IS BEING USED....

PROMPT

PROMPT CHECKING FOR OLAP CATALOGS...

PROMPT

PROMPT IF THE COUNT IS > 0 THEN THE OLAP OPTION IS BEING USED
PROMPT IF THE COUNT IS = 0 THEN THE OLAP OPTION IS NOT BEING USED
PROMPT IF THE TABLE DOES NOT EXIST (ORA-00942) ...THEN THE OLAP CATALOGS ARE NOT BEING USED
PROMPT

set heading on

set feedback off

SELECT 
	count(*) "OLAP CATALOGS" 
FROM 
	olapsys.dba$olap_cubes 
WHERE 
	OWNER <>'SH' ;

PROMPT

PROMPT CHECKING FOR ANALYTICAL WORK SPACES...

PROMPT
PROMPT IF THE COUNT IS >1 THEN THE OPTION IS BEING USED
PROMPT IF THE COUNT IS 0 OR 1 THEN ANALYTICAL WORKSPACES ARE NOT BEING USED
PROMPT IF THE TABLE DOES NOT EXIST (ORA-00942) ...THEN ANALYTICAL WORKSPACES ARE NOT BEING USED
PROMPT 

SELECT 
	count(*) "Analytical Workspaces" 
FROM
	dba_aws;

PROMPT
PROMPT NOTE: A positive result FROM either QUERY indicates the use of the OLAP option
PROMPT
PROMPT

SPOOL OFF

