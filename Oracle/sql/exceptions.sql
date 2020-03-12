3. Try to Add the constraint: 

SQL> alter table test add 
2 (constraint test_pk primary key (a) using index 
3 storage (initial 5K) exceptions into exceptions); 
alter table test add 
* 
ERROR at line 1: 
ORA-02437: cannot enable (SYSTEM.TEST_PK) - primary key violated 

3. Check the exceptions table. It will list all duplicate rows. 
SQL> select * from exceptions; 

ROW_ID OWNER TABLE_NAME CONSTRAINT 
------------------ ----------- ----------- ----------- 
AAAAkbAABAAACmRAAA SYSTEM TEST TEST_PK 

AAAAkbAABAAACmRAAB SYSTEM TEST TEST_PK 

AAAAkbAABAAACmRAAD SYSTEM TEST TEST_PK 

AAAAkbAABAAACmRAAE SYSTEM TEST TEST_PK 

4. Join the exceptions table with the test table to find duplicate values. 

SQL> select zzz.a from test zzz, exceptions xxx 
2 where zzz.rowid = xxx.row_id; 
 

select a.* 
from ifrsrh2.tab_participacao_beneficio a, exceptions xxx 
where a.rowid = xxx.row_id; 



a. run the @?/rdbms/admin/utlexcpt to create the exceptions table 
b. try and create the pk --> alter table test add primary key (col1,col2) exceptions into exceptions 
c. delete from exceptions table the first row of every occurence 
1 delete from exceptions where row_id in 
2 (select min(b.row_id) 
3 from test a,exceptions b 
4 where a.rowid=b.row_id 
5 group by a.col1,a.col2); 
d. delete all remaining rows in exceptions from the original table 
1 delete from test where rowid in 
2 (select row_id from exceptions); 

