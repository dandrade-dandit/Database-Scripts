/* VERSION 2

Drop the STUDENT-TEAM database table.

Due to referential integrity constraints, the tables should be 
dropped in a particular order.  

In a one-to-many relationship the "many" side is dropped first.  
NOTE: This is the reverse in which the tables must be created.  
In a one-to-many relationship the "one" table is created first 
so the foreign key constraint can be created in the "many" table.

The SQL below is specifically for Oracle or Oracle XE.  

*/

/* Drop the evaluation items and scores table and the 
sequence it uses to generate unique values for the primary 
key field.
*/


DROP SEQUENCE eval_score_id_seq;
DROP TABLE eval_item_scores CASCADE CONSTRAINTS;


/* Drop the evaluations and evaluation items.  Both of these 
were on the "one" side of a one-to-many relationship to 
evaluation items and scores.
*/

DROP SEQUENCE eval_ID_seq;
DROP TABLE evaluations CASCADE CONSTRAINTS;

DROP SEQUENCE eval_item_ID_seq;
DROP TABLE eval_items CASCADE CONSTRAINTS;


/* Drop the attendance and workshop tables.
*/

DROP SEQUENCE attnd_ID_seq;
DROP TABLE attendances CASCADE CONSTRAINTS;

DROP SEQUENCE wkshp_ID_seq;
DROP TABLE workshops CASCADE CONSTRAINTS;

/* Drop the students table.
*/

DROP SEQUENCE stdid_seq;
DROP TABLE students CASCADE CONSTRAINTS;

/* Drop the team table.
*/

DROP SEQUENCE teamid_seq;
DROP TABLE teams CASCADE CONSTRAINTS;



/* Drop the project table and its sequence. 
*/


DROP SEQUENCE projectid_seq;
DROP TABLE projects CASCADE CONSTRAINTS;


/* Drop the triggers for populating the PK in
each table. */

DROP TRIGGER bi_teams;
DROP TRIGGER bi_students;
DROP TRIGGER bi_eval_items;
DROP TRIGGER bi_evaluations;
DROP TRIGGER bi_eval_item_scores;
DROP TRIGGER bi_workshops;
DROP TRIGGER bi_attendances;




