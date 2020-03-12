-- Create a user to work with interMedia Text 
create user textuser identified by textuser 
default tablespace tools 
temporary tablespace temp; 

-- You must grant 'ctxapp' role to textuser 
grant connect, resource, ctxapp to textuser; 

connect textuser/textuser@maquina4

drop table quick; 

create table quick  ( 
    quick_id       number 
                   constraint quick_pk primary key, 
    text           varchar2(80)  ); 

insert into quick ( quick_id, text ) values (1,'The cat sat on the mat'); 
insert into quick ( quick_id, text ) values (2,'The quick brown fox jumps over the lazy dog' ); 
insert into quick ( quick_id, text ) values (3,'The dog barked like a dog'); 
commit; 

create index quick_text on quick ( text ) 
indextype is ctxsys.context; 

col text format a45 
col s format 999 
select text, score(42) s from quick 
where contains ( text, 'dog', 42 ) > 0 
order by s desc; 
------------------- Script text_quick_start.sql start ----------------------------- 
  

