# Constraints and Data Integrity

## Why constraints are strict here
This project assumes the database is the primary gatekeeper of correctness. Application code can change; constraints remain.

## Integrity layers implemented
1. **Entity identity**
   - PKs for every table
   - Natural uniqueness for stable identifiers (student identification, course code, emails)

2. **Domain correctness**
   - Gender constrained to a controlled set
   - Credits must be positive
   - Semester constrained to a realistic range
   - Years of experience cannot be negative
   - Grades constrained to `[0, 100]` (and may be NULL if not graded)

3. **Temporal sanity**
   - Enrollment date cannot precede student enrollment date (enforced where possible with query-time logic; see analytics docs)
   - Birth dates must be in the past and must imply realistic age at enrollment

4. **Relationship integrity**
   - FKs ensure valid references
   - Cascades and SET NULL are used intentionally (see modeling decisions)

## Maintainability detail
Constraints are applied in a dedicated script (`sql/03_constraints_and_relationships.sql`) to keep base table definitions readable while still making integrity enforcement explicit and reviewable.
