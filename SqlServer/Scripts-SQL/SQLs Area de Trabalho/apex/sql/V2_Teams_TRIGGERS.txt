/* VERSION 2

This script creates triggers for populating the primary key value in
each table.  The primary key is based on the sequence created for that
field in an earlier script (create table).

*/



/* Trigger for inserting a sequence value in the PROJECTS table. */

CREATE OR REPLACE trigger BI_PROJECTS  
  before insert on PROJECTS              
  for each row 
begin  
  if :NEW.PROJECTID is null then
    select PROJECTID_SEQ.nextval into :NEW.PROJECTID from dual;
  end if;
end;
/

/* ********************* */



/* Trigger for inserting a sequence value in the TEAMS table. */

CREATE OR REPLACE trigger BI_TEAMS  
  before insert on TEAMS              
  for each row 
begin  
  if :NEW.TEAMID is null then
    select TEAMID_SEQ.nextval into :NEW.TEAMID from dual;
  end if;
end;
/

/* ********************* */


/* Trigger for inserting a sequence value in the STUDENTS table. */

CREATE OR REPLACE trigger BI_STUDENTS  
  before insert on STUDENTS              
  for each row 
begin  
  if :NEW.STDID is null then
    select STDID_SEQ.nextval into :NEW.STDID from dual;
  end if;
end;
/

/* ********************* */




/* Trigger for inserting a sequence value in the EVAL_ITEMS table. */

CREATE OR REPLACE trigger BI_EVAL_ITEMS  
  before insert on EVAL_ITEMS              
  for each row 
begin  
  if :NEW.EVAL_ITEM_ID is null then
    select EVAL_ITEM_ID_SEQ.nextval into :NEW.EVAL_ITEM_ID from dual;
  end if;
end;
/

/* ********************* */



/* Trigger for inserting a sequence value in the EVALUATIONS table. */

CREATE OR REPLACE trigger BI_EVALUATIONS  
  before insert on EVALUATIONS              
  for each row 
begin  
  if :NEW.EVAL_ID is null then
    select EVAL_ID_SEQ.nextval into :NEW.EVAL_ID from dual;
  end if;
end;
/

/* ********************* */



/* Trigger for inserting a sequence value in the EVAL ITEMS SCORES table. */

CREATE OR REPLACE trigger BI_EVAL_ITEM_SCORES  
  before insert on EVAL_ITEM_SCORES              
  for each row 
begin  
  if :NEW.EVAL_SCORE_ID is null then
    select EVAL_SCORE_ID_SEQ.nextval into :NEW.EVAL_SCORE_ID from dual;
  end if;
end;
/

/* ********************* */



/* Trigger for inserting a sequence value in the WORKSHOPS table. */

CREATE OR REPLACE trigger BI_WORKSHOPS  
  before insert on WORKSHOPS              
  for each row 
begin  
  if :NEW.WKSHP_ID is null then
    select WKSHP_ID_SEQ.nextval into :NEW.WKSHP_ID from dual;
  end if;
end;
/

/* ********************* */



/* Trigger for inserting a sequence value in the ATTENDANCES table. */

CREATE OR REPLACE trigger BI_ATTENDANCES  
  before insert on ATTENDANCES              
  for each row 
begin  
  if :NEW.ATTND_ID is null then
    select ATTND_ID_SEQ.nextval into :NEW.ATTND_ID from dual;
  end if;
end;
/

/* ********************* */















