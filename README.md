# Upstage Track

**Time · Attendance · Job Tracking** — a lightweight, single-file web app for Upstage Co employees to clock in/out, track breaks and lunch, log work against jobs, and give admins a way to review, correct, and export attendance.

Live demo accounts are seeded in the app itself — just open it and pick a name from the login dropdown to try it out.

---

## Features

- **PIN login** with role-based access: Employee, Manager, Payroll, and Super Admin.
- **Geolocation-verified Time In / Time Out** — GPS is required for both actions; the app checks the location against configured job-site geofences (currently covering Cebu City, Lapu-Lapu City, Manila, and Sydney, Australia).
- **Break & lunch tracking** with a live running counter next to the employee's status, showing elapsed time since they went on break or lunch.
- **Work log entries** with an optional photo, chosen from the employee's device gallery (not a live camera capture).
- **Correction requests** — employees can request a fix to their Time In, Time Out, or both, with a reason. Admins review each request alongside the original vs. requested times and related audit-log activity from that day.
- **Weekly timesheet view** showing every shift for the week at once, with a submission/correction deadline every Thursday.
- **Jobs management** — Managers and Super Admins can create jobs, edit details on open/active jobs, and assign or remove employees, with every change recorded in a per-job change log.
- **Admin dashboard** — who's currently clocked in/on break, weekly summaries, and audit logging across the app.
- **Excel/CSV export** for payroll and reporting.

## Tech stack

Plain HTML, CSS, and JavaScript — no build step, no framework, no external dependencies. Data is currently stored in the browser's `localStorage`.

## ⚠️ Current limitation: local-only data

This app stores all data in `localStorage`, which is tied to a single browser on a single device. That means:

- Two employees opening the site on their own phones will each see their **own separate, empty copy** of the app — not shared team data.
- Clearing browser data, using a private/incognito window, or switching devices will reset or hide that device's records.

This is fine for solo testing and demoing the UI, but **it is not yet ready for multiple employees to use at once for real attendance tracking.** Before rolling this out to a team, the storage layer needs to be swapped for a real shared backend (e.g. Supabase or Firebase) so that every device reads and writes the same data.

## Getting started (view it locally)

1. Download `index.html` (or clone this repo).
2. Open the file directly in any modern browser — no server or install required.
3. Log in with any name from the demo account dropdown and a PIN (shown next to each role group on the login screen).

## Deploying as a live website

The simplest free option is **GitHub Pages**:

1. Make sure the app file is named `index.html` and is committed to this repository's `main` branch.
2. Go to this repo's **Settings → Pages**.
3. Under "Build and deployment," set Source to **Deploy from a branch**, branch **main**, folder **/ (root)**, then Save.
4. After a minute or two, GitHub will show your live URL (e.g. `https://yourusername.github.io/your-repo-name/`).

Every time you push a change to `index.html`, GitHub Pages redeploys automatically within about a minute.

## Roadmap

- [ ] Replace `localStorage` with a shared backend (Supabase/Firebase) so data syncs across employees and devices.
- [ ] Decide the future purpose of the "Require GPS" setting toggle (GPS is currently always required for Time In/Out regardless of this toggle).
- [ ] Evaluate a data sync with [Current RMS](https://current-rms.com) (jobs/crew) via its Open API, if useful for the team's existing workflow.
- [ ] Custom domain once the app is validated with the team.

## License

Internal project for Upstage Co. No license specified yet.
