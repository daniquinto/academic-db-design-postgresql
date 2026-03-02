
-- Inserting sample data

-- -------------------------
-- TEACHERS (3)
-- -------------------------
INSERT INTO teachers (full_name, institutional_email, academic_department, years_experience)
VALUES
    ('Olivia Carter', 'olivia.carter@university.edu', 'Computer Science', 10),
    ('Henry Mitchell', 'henry.mitchell@university.edu', 'Business Administration', 6),
    ('Sophia Reed', 'sophia.reed@university.edu', 'Engineering', 3);

-- -------------------------
-- STUDENTS (5)
-- -------------------------
INSERT INTO students (full_name, email, gender, identification, major, birth_date, enrollment_date)
VALUES
    ('John Perez',   'john.perez@student.edu',   'Male', 'ID-100001', 'Computer Science',        DATE '2003-05-14', DATE '2022-08-15'),
    ('Mary Gomez',   'mary.gomez@student.edu',   'Female', 'ID-100002', 'Business Administration', DATE '2002-11-02', DATE '2021-08-16'),
    ('Charles Diaz', 'charles.diaz@student.edu', 'Male', 'ID-100003', 'Mechanical Engineering',   DATE '2004-02-21', DATE '2023-01-10'),
    ('Ann Lopez',    'ann.lopez@student.edu',    'Female', 'ID-100004', 'Computer Science',        DATE '2001-09-09', DATE '2020-08-17'),
    ('Luke Torres',  'luke.torres@student.edu',  'Male', 'ID-100005', 'Business Administration', DATE '2003-12-30', DATE '2022-01-12');

-- -------------------------
-- COURSES (4)
-- -------------------------
INSERT INTO courses (name, code, credits, semester, teacher_id)
VALUES
    ('Database Systems',          'CS-301', 4, 3, 1), -- Olivia Carter (10 yrs)
    ('Introduction to Marketing', 'BA-210', 3, 2, 2), -- Henry Mitchell (6 yrs)
    ('Data Structures',           'CS-201', 4, 2, 1), -- Olivia Carter (10 yrs)
    ('Statics',                   'EN-120', 3, 1, 3); -- Sophia Reed (3 yrs)

-- -------------------------
-- ENROLLMENTS (8)
-- - Some students in > 1 course
-- - At least one course has > 2 students
-- -------------------------
INSERT INTO enrollments (student_id, course_id, enrollment_date, final_grade)
VALUES
    (1, 1, DATE '2024-02-01', 92.50), -- John Perez -> Database Systems (sem 3)
    (1, 3, DATE '2023-02-01', 88.00), -- John Perez -> Data Structures (sem 2)
    (2, 2, DATE '2023-02-05', 78.25), -- Mary Gomez -> Marketing (sem 2)
    (2, 1, DATE '2024-02-01', 81.00), -- Mary Gomez -> Database Systems (sem 3)
    (3, 4, DATE '2023-01-15', 69.50), -- Charles Diaz -> Statics (sem 1)
    (4, 1, DATE '2024-02-01', 95.00), -- Ann Lopez -> Database Systems (sem 3)
    (4, 3, DATE '2022-02-01', 90.00), -- Ann Lopez -> Data Structures (sem 2)
    (5, 2, DATE '2024-02-05', 84.75); -- Luke Torres -> Marketing (sem 2)
