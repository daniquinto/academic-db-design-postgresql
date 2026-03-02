# Checklist

## Database name
- Database: `academic_university_management` → `sql/01_create_database.sql` (CREATE DATABASE)

## TASK 1 — Database Design (Tables + Required Constraints)
### Tables exist with required columns
- `students` table and columns → `sql/02_create_tables.sql` (STUDENTS)
- `teachers` table and columns → `sql/02_create_tables.sql` (TEACHERS)
- `courses` table and columns → `sql/02_create_tables.sql` (COURSES)
- `enrollments` table and columns → `sql/02_create_tables.sql` (ENROLLMENTS)

### NOT NULL constraints
- Implemented in base definitions → `sql/02_create_tables.sql` (all table definitions)

### UNIQUE constraints
- Student email + identification → `sql/03_constraints_and_relationships.sql` (UNIQUENESS CONSTRAINTS)
- Teacher institutional_email → `sql/03_constraints_and_relationships.sql` (UNIQUENESS CONSTRAINTS)
- Course code → `sql/03_constraints_and_relationships.sql` (UNIQUENESS CONSTRAINTS)
- Prevent duplicate enrollment (student_id, course_id) → `sql/03_constraints_and_relationships.sql`

### CHECK constraints (realistic)
- Email sanity (students/teachers) → `sql/03_constraints_and_relationships.sql` (ck_*_email_format)
- Gender vocabulary → `sql/03_constraints_and_relationships.sql` (ck_students_gender)
- Credits positive and bounded → `sql/03_constraints_and_relationships.sql` (ck_courses_credits_positive)
- Semester range → `sql/03_constraints_and_relationships.sql` (ck_courses_semester_range)
- Years experience non-negative → `sql/03_constraints_and_relationships.sql` (ck_teachers_years_experience_non_negative)
- Grade range [0,100] or NULL → `sql/03_constraints_and_relationships.sql` (ck_enrollments_final_grade_range)
- Age at enrollment (>= 15) → `sql/03_constraints_and_relationships.sql` (ck_students_minimum_age_at_enrollment)

### Foreign Keys + explicit ON DELETE behavior
- courses.teacher_id → teachers.teacher_id (ON DELETE SET NULL) → `sql/03_constraints_and_relationships.sql` (fk_courses_teacher)
- enrollments.student_id → students.student_id (ON DELETE CASCADE) → `sql/03_constraints_and_relationships.sql` (fk_enrollments_student)
- enrollments.course_id → courses.course_id (ON DELETE CASCADE) → `sql/03_constraints_and_relationships.sql` (fk_enrollments_course)

## TASK 2 — Data Insertion 
- 5 students → `sql/04_insert_sample_data.sql` (STUDENTS)
- 3 teachers → `sql/04_insert_sample_data.sql` (TEACHERS)
- 4 courses → `sql/04_insert_sample_data.sql` (COURSES)
- 8 enrollments → `sql/04_insert_sample_data.sql` (ENROLLMENTS)

## TASK 3 — Basic Queries
- JOIN students + enrollments + courses → `sql/05_task3_queries.sql` (Query 1)
- Courses taught by teachers with > 5 years experience → `sql/05_task3_queries.sql` (Query 2)
- AVG grades per course → `sql/05_task3_queries.sql` (Query 3)
- Students in more than one course (HAVING) → `sql/05_task3_queries.sql` (Query 4)
- ALTER TABLE add academic_status → `sql/05_task3_queries.sql` (Query 5)
- DELETE teacher showing ON DELETE effect → `sql/05_task3_queries.sql` (Query 6 + verification SELECT)
- Courses with more than 2 students → `sql/05_task3_queries.sql` (Query 7)

## TASK 4 — Subqueries & Functions
- Students above global average grade → `sql/06_task4_advanced_queries.sql` (Query 1)
- Majors with students in semester >= 2 courses (IN/EXISTS) → `sql/06_task4_advanced_queries.sql` (Query 2, EXISTS)
- ROUND/SUM/MAX/MIN/COUNT indicators → `sql/06_task4_advanced_queries.sql` (Query 3)

## TASK 5 — View
- Create `academic_history_view` with required fields → `sql/07_create_view.sql` (CREATE OR REPLACE VIEW)

## TASK 6 — Security & Transactions
- Create role `academic_reviewer` → `sql/08_access_control.sql` (role creation DO block)
- GRANT SELECT on view → `sql/08_access_control.sql` (GRANT SELECT)
- REVOKE INSERT/UPDATE/DELETE on enrollments → `sql/08_access_control.sql` (REVOKE)
- Demonstrate BEGIN, SAVEPOINT, ROLLBACK, COMMIT → `sql/09_transactions_demo.sql`
