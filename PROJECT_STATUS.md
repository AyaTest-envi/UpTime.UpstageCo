# UpTime Project Status

Snapshot: 30 September 2026

## Repository and release state

- Active feature branch: `codex/attendance-review-workflow` at `ae60a13a01f3c909b20eb34719526dce41a566f1`, synchronized with its origin branch at inspection time.
- `main` and `origin/main` remain at `1c2fe77b4ced194c900cd48a609658c405b69ac8`.
- Phase 8 and the Phase 9 core database time-integrity checkpoint are committed on the feature branch. The product is not yet a release candidate and the feature branch has not been merged to `main`.
- `supabase/migrations/20261001000000_add_time_integrity_checks.sql` was committed in `ae60a13a01f3c909b20eb34719526dce41a566f1` (`Phase 9: add database time integrity checks`). It represents constraints that were installed and tested manually in live Supabase before the Git checkpoint; do not execute it again.

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
- Eight time-integrity CHECK constraints are installed as `NOT VALID`: attendance time order and nonnegative gross/paid-break/unpaid-break/net minutes; break time order; job-entry time order and nonnegative duration. Controlled rejection tests passed for all eight, and zero-persistence verification confirmed that no `phase9_test_%` records remained.
- Existing open rows remain valid because nullable end times are supported.
- Historical malformed data remains unchanged: of 42 attendance rows, 8 have reversed intervals and negative gross/net values; none have negative paid or unpaid break minutes. Of 15 breaks, none have reversed intervals or remain open. Of 74 job time entries, 7 have reversed intervals; none have negative duration or remain open. These records require authoritative evidence, separate approval, and an evidence-based strategy before constraint validation; do not guess or automatically repair historical values.

## Testing status

- Phase 7 multi-device Realtime, assignment, job lifecycle, break/lunch, and overtime paths received extensive manual two-browser testing.
- Phase 8 employee workflow, Today's Work hierarchy, weekly review/details, manager corrections, approvals, reminders, live dashboard, and payroll review behavior passed focused manual and headless checks.
- Payroll test coverage includes ordinary no-job Regular time, confirmed uncovered OT review, clean CSV export, approval blocking for unresolved periods, and approval of ordinary pre-4 PM gaps. The payroll harness passed 16/16 cases.
- Phase 9 browser regression using Bodhi's account passed Time In, reload persistence, two Start Job/End Job cycles, return to job selection, Time Out, and Admin Dashboard/Live Employee Status clearing. Start Break/End Break was not tested because the legitimate break-time window was closed; this is a timing restriction, not a failure.
- HTML parsing, 4/4 script tags, duplicate-function scans, headless Chrome runtime scans, and `git diff --check` passed in the latest completed reviews. There is no committed automated test suite; several checks use temporary/ad hoc harnesses.

## Known issues and limits

- Historical malformed attendance and job-time rows remain unresolved, and the new constraints are not validated against old rows.
- The next technical step is a read-only authorization/RLS audit across Super Admin, Admin, Manager, and Employee access before any policy changes are designed. Role and RLS coverage still needs complete launch hardening, especially intended Manager/Admin read boundaries.
- A one-open-job database uniqueness/concurrency rule and `attendance.time_in NOT NULL` remain deferred.
- Audit Log completeness, legacy `localStorage`, client configuration/environment handling, and broader security cleanup remain launch work.
- Hosted Supabase staging and full release regression/UAT have not been completed.
- Current RMS integration is post-launch only and should begin read-only; Xero integration is post-launch and server-side. Notifications, analytics, observability, and other enhancements remain post-launch work.
