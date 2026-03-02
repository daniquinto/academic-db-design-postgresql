# Analytical Queries Explained

## Task 3 (basic analytics)
- **Student academic join (students + enrollments + courses)**:
  Produces a human-meaningful record of who enrolled in what, including course metadata and grades. This validates relational wiring and supports downstream analytics.

- **Courses taught by experienced teachers (> 5 years)**:
  Uses a join with a filter on `teachers.years_experience`, illustrating that descriptive instructor attributes remain normalized and queryable without duplication.

- **Average grades per course**:
  Grouping by course demonstrates correct aggregation and handles NULL grades defensibly by using AVG on `final_grade` (NULL-safe behavior in PostgreSQL).

- **Students enrolled in more than one course**:
  HAVING clause confirms many-to-many functionality and identifies multi-course students.

- **Courses with more than 2 students**:
  Validates enrollment density and supports capacity/interest analytics.

- **ALTER + status**:
  Adds `academic_status` to students to illustrate controlled schema evolution.

- **DELETE teacher showing ON DELETE effect**:
  Demonstrates that course records are preserved and become unassigned (SET NULL), rather than being deleted.

## Task 4 (subqueries and indicators)
- **Students above global average grade**:
  Uses a scalar subquery for a meaningful benchmark.

- **Majors with students enrolled in semester >= 2 courses (IN/EXISTS)**:
  Finds majors linked to more advanced coursework participation, demonstrating nested logic and correct use of EXISTS.

- **Indicators with ROUND/SUM/MAX/MIN/COUNT**:
  Provides a compact set of operational metrics useful for academic reporting and highlights correct aggregate usage.
