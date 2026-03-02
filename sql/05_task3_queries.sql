
-- TASK 3 - BASIC QUERIES AND MANIPULATION

-- 1) JOIN students + enrollments + courses
-- Purpose: produce a readable academic record showing student enrollments and outcomes
SELECT
    s.student_id,
    s.full_name AS student_name,
    s.major,
    c.course_id,
    c.name AS course_name,
    c.code AS course_code,
    c.semester,
    e.enrollment_date,
    e.final_grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY s.student_id, c.semester, c.code;

-- 2) Courses taught by teachers with > 5 years experience
SELECT
    c.course_id,
    c.name AS course_name,
    c.code AS course_code,
    t.full_name AS teacher_name,
    t.years_experience
FROM courses c
JOIN teachers t ON t.teacher_id = c.teacher_id
WHERE t.years_experience > 5
ORDER BY t.years_experience DESC, c.code;

-- 3) AVG grades per course
SELECT
    c.course_id,
    c.name AS course_name,
    c.code AS course_code,
    ROUND(AVG(e.final_grade), 2) AS average_final_grade
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.name, c.code
ORDER BY c.code;

-- 4) Students in more than one course (HAVING)
SELECT
    s.student_id,
    s.full_name AS student_name,
    COUNT(*) AS courses_taken
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(*) > 1
ORDER BY courses_taken DESC, s.student_id;

-- 5) ALTER TABLE add academic_status
-- controlled vocabulary to keep status values consistent
ALTER TABLE students
    ADD COLUMN academic_status TEXT NOT NULL DEFAULT 'Active';

ALTER TABLE students
    ADD CONSTRAINT ck_students_academic_status
    CHECK (academic_status IN ('Active', 'On leave', 'Graduated', 'Withdrawn'));

-- Validating the new column is populated
SELECT student_id, full_name, academic_status
FROM students
ORDER BY student_id;

-- 6) DELETE teacher showing ON DELETE effect
-- Intention: deleting a teacher should NOT delete courses; courses become unassigned
-- We delete Sophia Reed (teacher_id = 3), who currently teaches Statics (EN-120)
DELETE FROM teachers
WHERE teacher_id = 3;

-- Verify effect: the Statics course should remain but teacher_id should become NULL
SELECT course_id, name, code, teacher_id
FROM courses
ORDER BY course_id;

-- 7) Courses with more than 2 students
SELECT
    c.course_id,
    c.name AS course_name,
    c.code AS course_code,
    COUNT(e.enrollment_id) AS enrolled_students
FROM courses c
JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.name, c.code
HAVING COUNT(e.enrollment_id) > 2
ORDER BY enrolled_students DESC, c.code;
