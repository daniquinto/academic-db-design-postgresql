# Academic University Management (PostgreSQL) 

## Purpose
This project implements a small but realistic university management database in PostgreSQL to demonstrate:
- Relational modeling and separation of entities (students, teachers, courses, enrollments)
- Integrity enforcement through constraints (PK/FK/UNIQUE/CHECK) and intentional ON DELETE behaviors
- Correct analytical querying (joins, grouping, subqueries, aggregate indicators)
- Transaction safety (BEGIN/SAVEPOINT/ROLLBACK/COMMIT)
- Security and least-privilege access (role + view-based access)

## Folder Structure
- `docs/` — concise engineering documentation (design intent, integrity, analytics, transactions, security)
- `sql/` — executable PostgreSQL scripts, designed to run sequentially
- `us_checklist.md` — mapping: requirement → file → exact location

## Execution Order (Step-by-Step)
> All SQL is PostgreSQL-compatible. Run with `psql` as a superuser (or a role allowed to create DB/roles).

1. **Create database**
   - Run: `sql/01_create_database.sql`
2. **Create tables**
   - Run: `sql/02_create_tables.sql`
3. **Apply constraints + relationships**
   - Run: `sql/03_constraints_and_relationships.sql`
4. **Insert sample data**
   - Run: `sql/04_insert_sample_data.sql`
5. **Task 3 basic queries (includes ALTER + DELETE demonstration)**
   - Run: `sql/05_task3_queries.sql`
6. **Task 4 advanced queries**
   - Run: `sql/06_task4_advanced_queries.sql`
7. **Create the view**
   - Run: `sql/07_create_view.sql`
8. **Security (role + grants/revokes)**
   - Run: `sql/08_access_control.sql`
9. **Transactions demo**
   - Run: `sql/09_transactions_demo.sql`

## Assumptions
- Grades are numeric in `[0, 100]`. `NULL` is allowed only when a final grade is not yet assigned.
- A course is associated with **at most one** teacher at a time; if a teacher is removed, historical course records remain but become unassigned (ON DELETE SET NULL).
- Enrollment records are dependent on both a student and a course; if either is removed, dependent enrollments are removed (ON DELETE CASCADE).

## Quick Validation Steps
After running scripts 01–04:
- Confirm row counts:
  - `SELECT COUNT(*) FROM students;` → 5
  - `SELECT COUNT(*) FROM teachers;` → 3
  - `SELECT COUNT(*) FROM courses;` → 4
  - `SELECT COUNT(*) FROM enrollments;` → 8
- Confirm integrity behaviors:
  - Run Task 3 DELETE in `sql/05_task3_queries.sql` and then:
    - `SELECT course_id, code, teacher_id FROM courses ORDER BY course_id;`
    - Courses taught by deleted teacher should have `teacher_id = NULL`.
- Confirm view:
  - `SELECT * FROM academic_history_view ORDER BY student_name, semester, course_name;`

For requirement-by-requirement verification, see `us_checklist.md`.
