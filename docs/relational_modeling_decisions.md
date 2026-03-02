# Relational Modeling Decisions

## Entity separation and dependency
- **students** and **teachers** are modeled independently because they have distinct lifecycles and identifiers.
- **courses** is separate from teachers to avoid embedding instructor details in course rows (prevents update anomalies and supports teacher reassignment).
- **enrollments** is a relationship table because:
  - A student can enroll in multiple courses.
  - A course can have multiple students.
  - The relationship itself carries attributes (enrollment_date, final_grade).

## Keys and identifiers
- Surrogate primary keys (`*_id` as identity) provide stable references and simplify joins.
- Natural uniqueness is enforced where it matters:
  - `students.identification` is unique to prevent duplicate person records.
  - `courses.code` is unique to prevent ambiguous course references.
  - Emails are unique where appropriate to protect communication identity.

## ON DELETE choices (intentional)
- `courses.teacher_id → teachers.teacher_id` uses **ON DELETE SET NULL**:
  - If a teacher record is removed, courses remain as institutional records but become “unassigned”.
  - This preserves course history without forcing a cascade delete of course offerings.

- `enrollments.student_id → students.student_id` uses **ON DELETE CASCADE**:
  - Enrollment records have no meaning without a student.
  - Cascading prevents orphaned enrollment rows and keeps analytics consistent.

- `enrollments.course_id → courses.course_id` uses **ON DELETE CASCADE**:
  - Enrollment records also depend on the existence of the course offering.
  - Cascading ensures removals do not leave referential debris.

These decisions are implemented in `sql/03_constraints_and_relationships.sql` and demonstrated in Task 3 via a teacher deletion.
