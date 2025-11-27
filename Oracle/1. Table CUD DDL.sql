--parent table courses
CREATE TABLE courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(50) NOT NULL,
    instructor VARCHAR2(50)
);



--child table students
CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    course_id NUMBER,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);


--Alter Parent Table: Add a new column credits to courses
ALTER TABLE courses
ADD credits NUMBER(2);



--Alter Child Table: Add a new column email to students
ALTER TABLE students
ADD email VARCHAR2(50);



--Modify Column Type: Change email length
ALTER TABLE students
MODIFY email VARCHAR2(100);



--Drop Column: Remove email column if not needed
ALTER TABLE students
DROP COLUMN email;


--Delete (Drop) Tables:
DROP TABLE students;
DROP TABLE courses;


