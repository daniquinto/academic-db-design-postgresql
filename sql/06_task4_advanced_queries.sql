-- TASK 4 — SUBQUERIES & FUNCTIONS

-- 1) Students above global average grade
-- compares each student's average to the global average across all graded enrollments
SELECT
    s.student_id,
    s.full_name AS student_name,
    ROUND(AVG(e.final_grade), 2) AS student_avg_grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
WHERE e.final_grade IS NOT NULL
GROUP BY s.student_id, s.full_name
HAVING AVG(e.final_grade) > (
    SELECT AVG(final_grade)
    FROM enrollments
    WHERE final_grade IS NOT NULL
)
ORDER BY student_avg_grade DESC;

-- 2) Majors with students in semester >= 2 courses (IN or EXISTS)
-- Interpreting "semester >= 2 courses" as: a student enrolled in at least one course where course.semester >= 2
-- EXISTS is used to ensure majors are listed if any student in the major matches the condition
SELECT DISTINCT s.major
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    JOIN courses c ON c.course_id = e.course_id
    WHERE e.student_id = s.student_id
      AND c.semester >= 2
)
ORDER BY s.major;

-- 3) ROUND, SUM, MAX, MIN, COUNT indicators
-- Compact academic indicators for reporting.
SELECT
    COUNT(*) AS total_enrollments,
    COUNT(DISTINCT student_id) AS distinct_students_enrolled,
    COUNT(DISTINCT course_id) AS distinct_courses_with_enrollments,
    ROUND(AVG(final_grade), 2) AS global_average_grade,
    MAX(final_grade) AS highest_grade,
    MIN(final_grade) AS lowest_grade,
    ROUND(SUM(final_grade), 2) AS sum_of_all_grades
FROM enrollments
WHERE final_grade IS NOT NULL;

-- Extra indicator: per-major student count
SELECT
    major,
    COUNT(*) AS students_in_major
FROM students
GROUP BY major
ORDER BY students_in_major DESC, major;
