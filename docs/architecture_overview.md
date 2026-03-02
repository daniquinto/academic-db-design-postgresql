# Architecture Overview

## Scope
The database models a simplified academic environment with four core entities:
- **Students**: stable personal and academic identity
- **Teachers**: instructional staff assigned to courses
- **Courses**: offerings with credits/semester and an optional assigned teacher
- **Enrollments**: intersection entity capturing student participation and outcomes

## Design Philosophy
1. **Relational separation with intentional dependencies**
   - Students, teachers, and courses are independent master entities.
   - Enrollments is a dependent relationship entity representing a many-to-many between students and courses with additional attributes (enrollment date, final grade).

2. **Integrity enforced primarily in the database**
   - Data quality constraints (email sanity, grade bounds, positive credits, enumerated gender) are enforced via CHECK constraints.
   - Uniqueness is enforced for stable identifiers (student identification, course code) and communication identifiers (emails).

3. **Operational safety**
   - Changes that can affect many rows (e.g., deletes via cascades, reassignment effects) are designed to be observable and defensible.
   - Transaction script demonstrates safe rollback points for multi-step operations.

## Key Artifacts
- DDL staged in files to show maintainability:
  - Tables first (`02_create_tables.sql`)
  - Then constraints and FK behaviors (`03_constraints_and_relationships.sql`)
- Analytics and security are implemented as first-class concerns:
  - Queries explained in `docs/analytical_queries_explained.md`
  - A view provides a stable, safe read interface for reviewers
  - Role-based access implements least privilege
