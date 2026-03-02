
-- TASK 5 — VIEW: academic_history_view

CREATE OR REPLACE VIEW academic_history_view AS
SELECT
    s.full_name AS student_name,
    c.name AS course_name,
    COALESCE(t.full_name, 'Unassigned') AS teacher_name,
    c.semester,
    e.final_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
LEFT JOIN teachers t ON t.teacher_id = c.teacher_id;

-- Quick sanity check
SELECT *
FROM academic_history_view
ORDER BY student_name, semester, course_name;
