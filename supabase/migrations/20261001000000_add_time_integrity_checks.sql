BEGIN;

DO $migration$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'attendance'
      AND c.conname = 'attendance_time_order_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.attendance.attendance_time_order_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'attendance'
      AND c.conname = 'attendance_gross_minutes_nonnegative_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.attendance.attendance_gross_minutes_nonnegative_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'attendance'
      AND c.conname = 'attendance_paid_break_minutes_nonnegative_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.attendance.attendance_paid_break_minutes_nonnegative_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'attendance'
      AND c.conname = 'attendance_unpaid_break_minutes_nonnegative_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.attendance.attendance_unpaid_break_minutes_nonnegative_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'attendance'
      AND c.conname = 'attendance_net_minutes_nonnegative_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.attendance.attendance_net_minutes_nonnegative_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'breaks'
      AND c.conname = 'breaks_time_order_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.breaks.breaks_time_order_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'job_time_entries'
      AND c.conname = 'job_time_entries_time_order_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.job_time_entries.job_time_entries_time_order_check already exists; inspect before rerunning';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM pg_constraint c
    JOIN pg_class r ON r.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = r.relnamespace
    WHERE n.nspname = 'public'
      AND r.relname = 'job_time_entries'
      AND c.conname = 'job_time_entries_duration_nonnegative_check'
  ) THEN
    RAISE EXCEPTION
      'Constraint public.job_time_entries.job_time_entries_duration_nonnegative_check already exists; inspect before rerunning';
  END IF;

  ALTER TABLE public.attendance
    ADD CONSTRAINT attendance_time_order_check
    CHECK (
      time_out IS NULL
      OR time_in IS NULL
      OR time_out >= time_in
    ) NOT VALID;

  ALTER TABLE public.attendance
    ADD CONSTRAINT attendance_gross_minutes_nonnegative_check
    CHECK (
      gross_minutes IS NULL
      OR gross_minutes >= 0
    ) NOT VALID;

  ALTER TABLE public.attendance
    ADD CONSTRAINT attendance_paid_break_minutes_nonnegative_check
    CHECK (
      paid_break_minutes IS NULL
      OR paid_break_minutes >= 0
    ) NOT VALID;

  ALTER TABLE public.attendance
    ADD CONSTRAINT attendance_unpaid_break_minutes_nonnegative_check
    CHECK (
      unpaid_break_minutes IS NULL
      OR unpaid_break_minutes >= 0
    ) NOT VALID;

  ALTER TABLE public.attendance
    ADD CONSTRAINT attendance_net_minutes_nonnegative_check
    CHECK (
      net_minutes IS NULL
      OR net_minutes >= 0
    ) NOT VALID;

  ALTER TABLE public.breaks
    ADD CONSTRAINT breaks_time_order_check
    CHECK (
      end_time IS NULL
      OR start_time IS NULL
      OR end_time >= start_time
    ) NOT VALID;

  ALTER TABLE public.job_time_entries
    ADD CONSTRAINT job_time_entries_time_order_check
    CHECK (
      end_time IS NULL
      OR start_time IS NULL
      OR end_time >= start_time
    ) NOT VALID;

  ALTER TABLE public.job_time_entries
    ADD CONSTRAINT job_time_entries_duration_nonnegative_check
    CHECK (
      duration_seconds IS NULL
      OR duration_seconds >= 0
    ) NOT VALID;
END
$migration$;

COMMIT;
