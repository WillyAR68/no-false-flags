---
type: llm
---

PASS if the final answer gives the first migration step from the plan (a pg_dump of the reports database at 22:00 with the app in read-only mode) and its rollback (point the app back to the old VM connection string).
FAIL if it misses either detail or invents steps not in the plan.
