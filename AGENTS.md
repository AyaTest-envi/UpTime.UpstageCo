# UpTime Development Rules

Read this file, `PROJECT_STATUS.md`, and `NEXT_STEPS.md` before starting work. Inspect the current branch, `git status`, recent history, relevant code, and migrations; do not assume these documents override newer repository evidence.

## Repository and authority

- The application currently lives primarily in `index.html`; database changes belong in timestamped files under `supabase/migrations/`.
- Supabase is authoritative for authenticated attendance, breaks, job time entries, assignments, corrections, approvals, and payroll inputs. Existing `localStorage` use is legacy browser state/cache and must never overwrite newer authoritative data.
- Fail closed when authoritative state required for a write cannot be confirmed. Preserve Realtime reconciliation, reconnect handling, session teardown, and stale modal/timer safeguards.
- Use Australia/Sydney business dates. Manager review periods run Friday through Thursday. Preserve the established 4 PM overtime decision rules.
- Payroll derives payable time from valid attendance minus valid unpaid breaks. Paid breaks remain payable. Job coverage allocates work but does not create extra payable time. Ordinary uncovered time is Regular; confirmed uncovered post-4 PM time requires review. Payroll remains approved/corrected attendance only.
- Preserve Project -> Job relationships from authoritative IDs and flags. Never infer hierarchy from names. Keep the active job first in My Time without mutating authoritative arrays for presentation.

## Safety and workflow

- Preserve all existing worktree changes. Do not reset, clean, amend, squash, rebase, switch branches, merge, commit, or push unless the user explicitly authorizes that exact action.
- Stage only named files and verify the staged list before committing. Never force-push.
- Do not execute SQL or mutate Supabase without explicit authorization for that specific operation. Prepare migrations for review first. A repository migration may document a change already installed manually; record that distinction accurately.
- Never weaken RLS, use unrestricted policies for protected time data, expose service-role credentials, or broaden write permissions as a shortcut.
- Do not guess repairs for historical malformed records. Preserve evidence and counts until an approved correction strategy exists.
- Keep Current RMS integration out of launch scope; it is post-launch work.
- Avoid unrelated refactors and schema changes. Preserve historical attendance, worklogs, correction history, approval history, Audit Log data, and private Storage behavior.

## Validation and reporting

- For application changes, normally run `git diff --check`, HTML parsing, script-tag balance, duplicate named-function checks, and a headless Chrome load/runtime scan. Add focused tests for the changed behavior.
- For SQL, review transaction safety, object-name collisions, idempotency where required, roles/RLS scope, existing malformed rows, and rollback behavior. Never describe an unexecuted migration as applied.
- Report what was actually tested. Distinguish static, automated, manual, live-database, and unavailable tests; never infer a pass.
- Before handoff, report branch, HEAD, changed/staged files, checks, limitations, and whether anything was committed, pushed, or executed against Supabase.
- Update `PROJECT_STATUS.md` only after functionality is implemented and verified. Keep planned work in `NEXT_STEPS.md`.
