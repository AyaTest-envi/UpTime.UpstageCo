# UpTime Project Status

Snapshot: 30 September 2026

## Repository and release state

- Active feature branch: `codex/attendance-review-workflow` at `58faa524b829a1c04e5aef61287f08f6b0ffdf88`, synchronized with its origin branch at inspection time.
- `main` and `origin/main` remain at `1c2fe77b4ced194c900cd48a609658c405b69ac8`.
- Phase 8 is checkpointed on the feature branch. The product is not yet a release candidate and the feature branch has not been merged to `main`.
- `supabase/migrations/20261001000000_add_time_integrity_checks.sql` is currently an untracked repository representation of constraints already installed and tested manually in the live Supabase environment.

## Implemented and verified

- Supabase Auth and employee profiles support Employee, Manager, Admin, Super Admin, and Payroll application roles.
- Employee My Time supports Time In/Out, contextual Morning Break/Lunch, assigned Projects and Jobs, guarded Start/Switch/End Job flows, active-job-first display, manual Add Work, overtime decisions, and Sydney-date Today's Work grouped by authoritative Project -> Job relationships.
- Employee Timesheet navigation and the standalone Admin Live screen were removed. Live employee status remains on the Admin Dashboard.
- Supabase Realtime synchronizes attendance, breaks, job time entries, jobs, and assignment-driven job invalidation across devices, with reload/reconnect reconciliation and authenticated teardown.
- Manager/Admin Timesheets use Friday-Thursday employee review periods with detailed attendance, Project/Job sessions, corrections, correction history, period approval, approval history, recent/archive activity, and Thursday cutoff reminders.
- Payroll uses attendance elapsed time minus valid unpaid breaks as payable authority. Paid breaks remain payable; overlapping jobs do not increase pay; ordinary no-job gaps are Regular; confirmed uncovered post-4 PM time is review-required; unresolved review blocks CSV export; invalid attendance is excluded; only approved/corrected attendance is eligible.
- Private Supabase Storage photo behavior, historical records, reports, Audit Log rendering, and administrative history remain present.

## Database decisions and current integrity state

- The tracked `20260930000000_add_super_admin_time_read_policies.sql` reproduces tested SELECT-only Super Admin policies for attendance, breaks, and job time entries while preserving employee self-access.
- Eight time-integrity CHECK constraints are installed as `NOT VALID`: attendance time order and nonnegative gross/paid-break/unpaid-break/net minutes; break time order; job-entry time order and nonnegative duration. Controlled rejection tests passed for all eight.
- Existing open rows remain valid because nullable end times are supported.
- Historical malformed data remains unchanged: 8 of 42 attendance rows have reversed times and negative gross/net values; 7 of 74 job time entries have reversed times. No negative break durations were found. These records require an evidence-based strategy before constraint validation.

## Testing status

- Phase 7 multi-device Realtime, assignment, job lifecycle, break/lunch, and overtime paths received extensive manual two-browser testing.
- Phase 8 employee workflow, Today's Work hierarchy, weekly review/details, manager corrections, approvals, reminders, live dashboard, and payroll review behavior passed focused manual and headless checks.
- Payroll test coverage includes ordinary no-job Regular time, confirmed uncovered OT review, clean CSV export, approval blocking for unresolved periods, and approval of ordinary pre-4 PM gaps. The payroll harness passed 16/16 cases.
- Latest Phase 9 browser smoke test passed Time In, reload reconstruction, two job start/end cycles, Time Out, and Admin Dashboard clearing. Break start/end was not retested because the legitimate break window was closed.
- HTML parsing, 4/4 script tags, duplicate-function scans, headless Chrome runtime scans, and `git diff --check` passed in the latest completed reviews. There is no committed automated test suite; several checks use temporary/ad hoc harnesses.

## Known issues and limits

- Historical malformed attendance and job-time rows remain unresolved, and the new constraints are not validated against old rows.
- Role and RLS coverage still needs a complete launch hardening review, especially intended Manager/Admin read boundaries.
- Audit Log completeness, legacy `localStorage`, client configuration/environment handling, and broader security cleanup remain launch work.
- Hosted Supabase staging and full release regression/UAT have not been completed.
- Current RMS integration is post-launch only.
