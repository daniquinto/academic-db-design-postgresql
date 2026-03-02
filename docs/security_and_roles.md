# Security and Roles

## Principle
Use **least privilege**: grant only the minimal rights required for a role to do its job.

## Role design
- `academic_reviewer` is intended for read-only academic auditing.
- Access is granted to a curated view (`academic_history_view`) rather than direct base tables.
  - This reduces accidental exposure of unnecessary columns and limits the surface area of permissions.

## Enforcement actions
Implemented in `sql/08_access_control.sql`:
- Create role `academic_reviewer`
- Grant SELECT on the view
- Revoke INSERT/UPDATE/DELETE on enrollments
  - Even if a reviewer gains access to enrollments indirectly, they cannot alter academic outcomes

## Why a view-based permission model
Views provide:
- A stable interface for reviewers
- A controlled projection of data aligned with review needs
- Easier future changes to underlying schema without changing the reviewer contract
