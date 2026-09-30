# UpTime Launch Next Steps

Complete this work in order. Do not mark an item complete without repository and runtime evidence.

1. **Database integrity and historical malformed-data strategy**
   - Checkpoint the reviewed Phase 9 migration representation.
   - Investigate the 8 malformed attendance rows and 7 reversed job time entries using source evidence; define approved repair, quarantine, or exception handling without guessing.
   - Re-audit data, apply approved corrections safely, then validate constraints only when all existing rows comply.

2. **Role and RLS hardening**
   - Inventory every table, view, RPC, Storage path, and application role.
   - Verify least-privilege Employee self-access, intended Manager/Admin scope, Super Admin scope, Payroll access, and all write/delete boundaries. Add reviewed migrations and role tests for confirmed gaps.

3. **Audit Log**
   - Verify security-sensitive attendance corrections, approvals, configuration changes, and administrative actions are complete, authoritative, attributable, immutable to ordinary users, and usable for review/export.

4. **`localStorage`, configuration, environment, and security cleanup**
   - Remove remaining browser state that can conflict with Supabase authority.
   - Move deploy-time configuration out of hardcoded application code, review secret handling and error exposure, and update stale setup documentation.

5. **Hosted Supabase staging**
   - Build a production-like hosted staging environment from repository migrations and documented configuration. Verify RLS, RPCs, Realtime, Storage, backups, and repeatable deployment from a clean database.

6. **Full regression**
   - Run employee-to-payroll end-to-end scenarios for every role, corrections, approvals, reminders, photos, exports, malformed/failure paths, and Sydney date/DST boundaries.
   - Run multi-device and Realtime tests for attendance, breaks, jobs, assignments, overtime, reconnect, reload, logout/session replacement, and concurrent actions.

7. **Release candidate around 12 October 2026**
   - Freeze scope, merge only approved work, deploy the candidate to staging, publish release notes, and record all validation evidence and accepted limitations.

8. **UAT, backup, recovery, and launch readiness**
   - Complete role-based UAT, production migration rehearsal, backup/restore proof, rollback and incident procedures, access review, monitoring/alerting, and operator training/sign-off.

9. **17-18 October 2026 launch-fix buffer**
   - Reserve for verified release blockers only. Re-run affected regression and preserve rollback readiness after every fix.

10. **19 October 2026 production launch and monitoring**
    - Take a final backup, apply approved migrations, deploy the signed-off release, run production smoke tests, and actively monitor Auth, RLS, Realtime, attendance, payroll, errors, and support reports.

## Post-launch

- Current RMS integration begins only after production stabilization. Do not implement it in the launch path.

## Fresh Codex Thread Handoff

Read `AGENTS.md`, `PROJECT_STATUS.md`, and `NEXT_STEPS.md`, then inspect the actual current branch, Git status and history, relevant code, Supabase migrations, and tests before acting. Treat newer repository or runtime evidence as authoritative if these documents are stale. Continue from the highest-priority verified incomplete launch item, preserve existing working behavior, keep changes compact, and test what you change. Never mark planned or unverified work complete. Before handoff, update `PROJECT_STATUS.md` and `NEXT_STEPS.md` to reflect only verified current state and remaining work.
