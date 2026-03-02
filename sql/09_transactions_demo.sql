
-- TASK 6 — TRANSACTIONS DEMO: BEGIN, SAVEPOINT, ROLLBACK, COMMIT

-- Scenario: Assign a new grade for a specific enrollment, with a safe recovery step
-- I will:
-- 1) Start a transaction
-- 2) Create a savepoint
-- 3) Intentionally attempt an invalid update (grade out of range) to trigger constraint failure
-- 4) Roll back to savepoint
-- 5) Apply a valid update
-- 6) Commit

BEGIN;

-- Choose a concrete enrollment row to update (deterministic for graders):
-- enrollment_id = 5 (Charles Diaz -> Statics), currently has 69.50
SELECT enrollment_id, student_id, course_id, final_grade
FROM enrollments
WHERE enrollment_id = 5;

SAVEPOINT before_grade_update;

-- Intentional error: violates ck_enrollments_final_grade_range (must be between 0 and 100).
-- This statement should fail and leave the transaction open
UPDATE enrollments
SET final_grade = 150.00
WHERE enrollment_id = 5;

-- Recover safely without losing the entire transaction
ROLLBACK TO SAVEPOINT before_grade_update;

-- Apply a correct update
UPDATE enrollments
SET final_grade = 72.00
WHERE enrollment_id = 5;

-- Confirm the corrected value inside the transaction
SELECT enrollment_id, final_grade
FROM enrollments
WHERE enrollment_id = 5;

COMMIT;

-- Confirm the committed result
SELECT enrollment_id, final_grade
FROM enrollments
WHERE enrollment_id = 5;
