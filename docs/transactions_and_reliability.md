# Transactions and Reliability

## Why transactions matter here
Academic data is naturally multi-step: enroll student → record enrollment → record grade. Partial writes create inconsistent histories and misleading analytics.

## Demonstrated approach
The transactions demo script (`sql/09_transactions_demo.sql`) shows:
- `BEGIN` to start an atomic unit of work
- `SAVEPOINT` to mark safe rollback boundaries
- `ROLLBACK TO SAVEPOINT` to recover from an error without losing all prior work
- `COMMIT` to persist only the valid final state

## Defensive mindset
The demo intentionally triggers a constraint violation (grade out of range), then rolls back to a savepoint and corrects the data. This mirrors real operational patterns: fail fast, rollback safely, re-apply correct change, commit.
