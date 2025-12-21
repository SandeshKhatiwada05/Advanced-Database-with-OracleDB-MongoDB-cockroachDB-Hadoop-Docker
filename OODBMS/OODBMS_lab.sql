/* ===============================
   CLEANUP (ignore errors)
   =============================== */
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE contacts_ref';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE emp_person_obj_table';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE person_obj_table';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE contacts';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE emp_person_typ';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TYPE person_typ';
EXCEPTION WHEN OTHERS THEN NULL; END;
/







--1. Object type with method
CREATE OR REPLACE TYPE person_typ AS OBJECT (
  idno NUMBER,
  first_name VARCHAR2(20),
  last_name VARCHAR2(25),
  email VARCHAR2(25),
  phone VARCHAR2(20),
  MAP MEMBER FUNCTION get_idno RETURN NUMBER,
  MEMBER PROCEDURE display_details (SELF IN OUT NOCOPY person_typ)
);
/

CREATE TYPE BODY person_typ AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN idno;
  END;

  MEMBER PROCEDURE display_details (SELF IN OUT NOCOPY person_typ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(idno || ' ' || first_name || ' ' || last_name);
    DBMS_OUTPUT.PUT_LINE(email || ' ' || phone);
  END;
END;
/



--1.2. Table with Object Column
CREATE TABLE contacts (
  contact person_typ,
  contact_date DATE
);
/

INSERT INTO contacts VALUES (
  person_typ(65, 'Rama', 'Shrestha', 'rama@oic.edu.np', '9833229934'),
  DATE '2003-06-24'
);
COMMIT;


--1.3
SELECT c.contact.get_idno() FROM contacts c;




--1-4 & 1-5: Object Table + Operations
CREATE TABLE person_obj_table OF person_typ;
/
INSERT INTO person_obj_table VALUES (
  person_typ(101, 'Prakash', 'Shrestha', 'prakash@oic.edu.np', '9866334455')
);

INSERT INTO person_obj_table VALUES (
  person_typ(102, 'Rama', 'Adhikari', 'rama@oic.edu.np', '9811111111')
);

INSERT INTO person_obj_table VALUES (
  person_typ(103, 'Sita', 'Karki', 'sita@oic.edu.np', '9822222222')
);

COMMIT;

SELECT VALUE(p)
FROM person_obj_table p
WHERE p.last_name = 'Shrestha';


SET SERVEROUTPUT ON
/

DECLARE
  person person_typ;
BEGIN
  SELECT VALUE(p)
  INTO person
  FROM person_obj_table p
  WHERE p.idno = 101;

  person.display_details();
END;
/


--1-6: REF Example (Managers)
CREATE TYPE emp_person_typ AS OBJECT (
  name VARCHAR2(30),
  manager REF emp_person_typ
);
/

CREATE TABLE emp_person_obj_table OF emp_person_typ;
/

-- Top-level managers
INSERT INTO emp_person_obj_table VALUES (
  emp_person_typ('Priti Kishor', NULL)
);

INSERT INTO emp_person_obj_table VALUES (
  emp_person_typ('Anita Sharma', NULL)
);

-- Employees
INSERT INTO emp_person_obj_table
SELECT emp_person_typ('Kishor Gautam', REF(e))
FROM emp_person_obj_table e
WHERE e.name = 'Priti Kishor';

INSERT INTO emp_person_obj_table
SELECT emp_person_typ('Ramesh Adhikari', REF(e))
FROM emp_person_obj_table e
WHERE e.name = 'Anita Sharma';
COMMIT;


SELECT e.name,
       DEREF(e.manager).name AS manager_name
FROM emp_person_obj_table e;


--Contacts Using REF
CREATE TABLE contacts_ref (
  contact_ref REF person_typ SCOPE IS person_obj_table,
  contact_date DATE
);
/

INSERT INTO contacts_ref
SELECT REF(p), DATE '2003-06-26'
FROM person_obj_table p
WHERE p.idno IN (101,102);

COMMIT;

SELECT c.contact_ref.phone
FROM contacts_ref c;

--Ex 1-8: DEREF
SELECT DEREF(e.manager)
FROM emp_person_obj_table e;



--1-9: Dangling REF Demo (INTENTIONAL)
DELETE FROM person_obj_table WHERE idno = 102;
COMMIT;

SELECT DEREF(c.contact_ref), c.contact_date
FROM contacts_ref c;


--Obtaining REF + Display
SET SERVEROUTPUT ON

DECLARE
  person_ref REF person_typ;
  person     person_typ;
BEGIN
  SELECT REF(p)
  INTO person_ref
  FROM person_obj_table p
  WHERE p.idno = 101;

  SELECT DEREF(person_ref)
  INTO person
  FROM dual;

  person.display_details();
END;
/

