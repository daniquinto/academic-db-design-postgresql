-- Adding integrity constraints and foreign key behaviors

-- -------------------------
-- UNIQUENESS CONSTRAINTS
-- -------------------------
ALTER TABLE students
    ADD CONSTRAINT uq_students_email UNIQUE (email);

ALTER TABLE students
    ADD CONSTRAINT uq_students_identification UNIQUE (identification);

ALTER TABLE teachers
    ADD CONSTRAINT uq_teachers_institutional_email UNIQUE (institutional_email);

ALTER TABLE courses
    ADD CONSTRAINT uq_courses_code UNIQUE (code);

-- Prevent duplicate enrollment of the same student in the same course
ALTER TABLE enrollments
    ADD CONSTRAINT uq_enrollments_student_course UNIQUE (student_id, course_id);

-- -------------------------
-- DOMAIN / CHECK CONSTRAINTS
-- -------------------------

-- Email sanity: intentionally lightweight, avoids over-restrictive patterns
ALTER TABLE students
    ADD CONSTRAINT ck_students_email_format
    CHECK (email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$');

ALTER TABLE teachers
    ADD CONSTRAINT ck_teachers_email_format
    CHECK (institutional_email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$');

-- Gender as controlled options
ALTER TABLE students
    ADD CONSTRAINT ck_students_gender
    CHECK (gender IN ('Female', 'Male', 'Non-binary', 'Prefer not to say'));

-- Credits must be positive and reasonable
ALTER TABLE courses
    ADD CONSTRAINT ck_courses_credits_positive
    CHECK (credits > 0 AND credits <= 10);

-- Semester bounded to a realistic academic range
ALTER TABLE courses
    ADD CONSTRAINT ck_courses_semester_range
    CHECK (semester BETWEEN 1 AND 12);

-- Years experience cannot be negative; allow 0 for new hires
ALTER TABLE teachers
    ADD CONSTRAINT ck_teachers_years_experience_non_negative
    CHECK (years_experience >= 0);

-- Birth date must be in the past; enrollment date must also be in the past or today
ALTER TABLE students
    ADD CONSTRAINT ck_students_birth_date_in_past
    CHECK (birth_date < CURRENT_DATE);

ALTER TABLE students
    ADD CONSTRAINT ck_students_enrollment_date_not_future
    CHECK (enrollment_date <= CURRENT_DATE);

-- Realistic minimum age at enrollment: >= 15 years old at enrollment time
ALTER TABLE students
    ADD CONSTRAINT ck_students_minimum_age_at_enrollment
    CHECK (enrollment_date >= birth_date + INTERVAL '15 years');

-- Enrollment date is not future; final grades (if present) must be in [0,100]
ALTER TABLE enrollments
    ADD CONSTRAINT ck_enrollments_enrollment_date_not_future
    CHECK (enrollment_date <= CURRENT_DATE);

ALTER TABLE enrollments
    ADD CONSTRAINT ck_enrollments_final_grade_range
    CHECK (final_grade IS NULL OR (final_grade >= 0 AND final_grade <= 100));

-- Identification should be non-empty and trimmed
ALTER TABLE students
    ADD CONSTRAINT ck_students_identification_nonempty
    CHECK (length(btrim(identification)) >= 6);

-- Course code: uppercase letters/numbers with optional dash, e.g., CS-101
ALTER TABLE courses
    ADD CONSTRAINT ck_courses_code_format
    CHECK (code ~ '^[A-Z]{2,10}(-[0-9]{2,4})$');

-- -------------------------
-- FOREIGN KEYS + ON DELETE
-- -------------------------

-- Courses keep institutional identity even if the teacher record is removed
ALTER TABLE courses
    ADD CONSTRAINT fk_courses_teacher
    FOREIGN KEY (teacher_id)
    REFERENCES teachers (teacher_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Enrollments depend on a student and a course; remove enrollments if either parent is removed
ALTER TABLE enrollments
    ADD CONSTRAINT fk_enrollments_student
    FOREIGN KEY (student_id)
    REFERENCES students (student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE enrollments
    ADD CONSTRAINT fk_enrollments_course
    FOREIGN KEY (course_id)
    REFERENCES courses (course_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -------------------------
-- SUPPORTING INDEXES
-- -------------------------
-- 
-- 1) enrollments.student_id:
--    Improves performance for student-centric queries (academic history, multi-course
--    analysis, and HAVING-based aggregations), since enrollments is the highest-
--    cardinality table and frequently joined to students
--
-- 2) enrollments.course_id:
--    Accelerates course-based analytics (average grades, enrollment counts, and
--    course participation queries) by reducing scan cost when grouping or filtering
--    by course
--
-- 3) courses.teacher_id:
--    Optimizes joins between courses and teachers, especially when filtering by
--    teacher attributes (e.g., years of experience) and when validating ON DELETE
--    SET NULL behavior
--
-- Design note:
-- Primary keys already create indexes automatically; these additional indexes target
-- foreign key columns because they are heavily used in joins and improve both query
-- performance and referential integrity maintenance during updates/deletes
CREATE INDEX IF NOT EXISTS idx_enrollments_student_id ON enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course_id ON enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_courses_teacher_id ON courses(teacher_id);
