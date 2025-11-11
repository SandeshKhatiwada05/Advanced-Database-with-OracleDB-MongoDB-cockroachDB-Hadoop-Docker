--before starting lab we first make database to work with
-- Drop old tables if they exist (optional cleanup)
DROP TABLE students CASCADE CONSTRAINTS;
DROP TABLE courses CASCADE CONSTRAINTS;


--CREATE TABLES
-- Parent table: COURSES
CREATE TABLE courses (
    course_id NUMBER(5) PRIMARY KEY,
    course_name VARCHAR2(50) NOT NULL,
    instructor VARCHAR2(50)
);


-- Child table: STUDENTS
CREATE TABLE students (
    student_id NUMBER(5) PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    course_id NUMBER(5),
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
);



--LAB 2 : 
--1. Insert operations
-- Parent table: COURSES
INSERT INTO courses (course_id, course_name, instructor)
VALUES (101, 'Database Systems', 'Dr. Smith');

-- Child table: STUDENTS
INSERT INTO students (student_id, student_name, course_id)
VALUES (1, 'Alice Johnson', 101);

INSERT INTO students (student_id, student_name, course_id)
VALUES (2, 'Bob Williams', 101);

COMMIT;




--2. Select operation
-- Verify parent table
SELECT * FROM courses WHERE course_id = 101;


-- Verify child table
SELECT * FROM students WHERE course_id = 101;


-- Verify parent-child relationship
SELECT s.student_id, s.student_name, c.course_name, c.instructor
FROM students s
JOIN courses c ON s.course_id = c.course_id;


--Domain Constraint Check
INSERT INTO courses (course_id, course_name, instructor)
VALUES (NULL, 'Invalid Course', 'Dr. John');  -- Should fail



--Referential Integrity Checkk
INSERT INTO students (student_id, student_name, course_id)
VALUES (3, 'Charlie Brown', 999);  -- Should fail (no such course_id)


--Update course instructor
UPDATE courses
SET instructor = 'Dr. Adams'
WHERE course_id = 101;


--Update student name
UPDATE students
SET student_name = 'Alice Parker'
WHERE student_id = 1;

COMMIT;


--Delete child records first
DELETE FROM students
WHERE course_id = 101;


--Then delete parent record
DELETE FROM courses
WHERE course_id = 101;

COMMIT;


