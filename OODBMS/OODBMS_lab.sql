--Ex 1-1
CREATE OR REPLACE TYPE person_typ AS OBJECT (
idno NUMBER,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
email VARCHAR2(25),
phone VARCHAR2(20),
MAP MEMBER FUNCTION get_idno RETURN NUMBER,
MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ));
/

CREATE TYPE BODY person_typ AS
MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
BEGIN
RETURN idno;
END;
MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) IS
BEGIN
-- use the PUT_LINE procedure of the DBMS_OUTPUT package to display details
DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
DBMS_OUTPUT.PUT_LINE(email || ' ' || phone);
END;
END;
/
-- Example 1-2 Creating the contacts Table with an Object Type Column
-- requires existing person_typ fr. Ex 1-1
CREATE TABLE contacts (
contact person_typ,
contact_date DATE );
/
INSERT INTO contacts VALUES (
person_typ (65, 'Rama', 'Shrestha', 'rama@oic.edu.np', '9833229934'),
to_date('24-Jun-2003', 'dd-Mon-YYYY'));
/
COMMIT;
/
--Example 1-3 Using the get_idno Object Method
SELECT c.contact.get_idno() FROM contacts c;
/
-- Example 1-4 Creating the person_obj_table Object Table
-- requires Ex. 1-1
CREATE TABLE person_obj_table OF person_typ;
/
-- Example 1-5 Operations on the person_obj_table Object Table
-- requires Ex. 1-1 and 1-4
INSERT INTO person_obj_table VALUES (
person_typ(101, 'Prakash', 'Shrestha', 'prakash@oic.edu.np',
'9866334455') );
/
COMMIT;
SELECT VALUE(p) FROM person_obj_table p
WHERE p.last_name = 'Shrestha';
/
commit;
SET SERVEROUTPUT ON -- this comman will allow to access the serveroutput on the screen
/
DECLARE
person person_typ;
BEGIN -- PL/SQL block for selecting a person and displaying details
SELECT VALUE(p) INTO person FROM person_obj_table p WHERE p.idno = 101;
person.display_details();
END;
/
-- Example 1-6 Using a REF to the emp_person_typ Object
CREATE TYPE emp_person_typ AS OBJECT (
name VARCHAR2(30),
manager REF emp_person_typ );
/
CREATE TABLE emp_person_obj_table OF emp_person_typ;
/
INSERT INTO emp_person_obj_table VALUES (
emp_person_typ ('Priti Kishor', NULL));
/
INSERT INTO emp_person_obj_table
SELECT emp_person_typ ('Kishor Gautam', REF(e))
FROM emp_person_obj_table e
WHERE e.name = 'Priti Kishor';
/
commit;
SELECT * FROM emp_person_obj_table;
/
-- requires Ex. 1-1, 1-4, and 1-5
CREATE TABLE contacts_ref (
contact_ref REF person_typ SCOPE IS person_obj_table,
contact_date DATE );
-- To insert a row in the table, you could issue the following:
INSERT INTO contacts_ref
SELECT REF(p), '26 Jun 2003'
FROM person_obj_table p
WHERE p.idno = 101;
/
commit;
SELECT "cr".contact_ref.phone FROM contacts_ref "cr";

-- Example 1-8 Using DEREF to Dereference a REF
SELECT DEREF(e.manager) FROM emp_person_obj_table e;
/
-- Example 1-9 Dereferencing a Dangling Ref
DELETE from person_obj_table WHERE idno = 101;
/
Commit;
SELECT DEREF(c.contact_ref), c.contact_date FROM contacts_ref c;

-- Example 1-11 Obtaining a REF to a Row Object
-- requires Ex. 1-1, 1-4, and 1-5
DECLARE
person_ref REF person_typ;
person person_typ;
BEGIN
SELECT REF(p) INTO person_ref
FROM person_obj_table p
WHERE p.idno = 101;
select deref(person_ref) into person from dual;
person.display_details();
END;
/