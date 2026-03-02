-- Base tables. Constraints and FKs are applied in 03_constraints_and_relationships.sql

-- STUDENTS
CREATE TABLE students (
    student_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name          TEXT NOT NULL,
    email              TEXT NOT NULL,
    gender             TEXT NOT NULL,
    identification     TEXT NOT NULL,
    major              TEXT NOT NULL,
    birth_date         DATE NOT NULL,
    enrollment_date    DATE NOT NULL
);

-- TEACHERS
CREATE TABLE teachers (
    teacher_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name             TEXT NOT NULL,
    institutional_email   TEXT NOT NULL,
    academic_department   TEXT NOT NULL,
    years_experience      INTEGER NOT NULL
);

-- COURSES
CREATE TABLE courses (
    course_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          TEXT NOT NULL,
    code          TEXT NOT NULL,
    credits       INTEGER NOT NULL,
    semester      INTEGER NOT NULL,
    teacher_id    BIGINT NULL  -- teacher can be unassigned; FK defined in 03_constraints_and_relationships.sql
);

-- ENROLLMENTS (relationship entity)
CREATE TABLE enrollments (
    enrollment_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id        BIGINT NOT NULL,
    course_id         BIGINT NOT NULL,
    enrollment_date   DATE NOT NULL,
    final_grade       NUMERIC(5,2) NULL
);
