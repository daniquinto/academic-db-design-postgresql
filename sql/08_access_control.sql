
-- TASK 6 — SECURITY & ACCESS CONTROL

-- Create role academic_reviewer
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'academic_reviewer') THEN
        CREATE ROLE academic_reviewer;
    END IF;
END $$;

-- Least privilege: reviewers only need to read from the view
GRANT SELECT ON academic_history_view TO academic_reviewer;

-- Explicitly prevent DML on enrollments for this reviewer role
-- (Safe even if future grants accidentally add table access)
REVOKE INSERT, UPDATE, DELETE ON enrollments FROM academic_reviewer;

-- Optional defensive revokes on base tables to emphasize view-only review posture
REVOKE ALL ON students FROM academic_reviewer;
REVOKE ALL ON teachers FROM academic_reviewer;
REVOKE ALL ON courses FROM academic_reviewer;


