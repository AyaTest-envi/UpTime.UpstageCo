BEGIN;

DO $migration$
BEGIN
  IF to_regprocedure('public.is_super_admin()') IS NULL THEN
    RAISE EXCEPTION
      'Required function public.is_super_admin() does not exist';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename = 'attendance'
      AND policyname = 'Super Admins can view all attendance'
  ) THEN
    EXECUTE $policy$
      CREATE POLICY "Super Admins can view all attendance"
      ON public.attendance
      FOR SELECT
      TO authenticated
      USING (public.is_super_admin())
    $policy$;
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename = 'breaks'
      AND policyname = 'Super Admins can view all breaks'
  ) THEN
    EXECUTE $policy$
      CREATE POLICY "Super Admins can view all breaks"
      ON public.breaks
      FOR SELECT
      TO authenticated
      USING (public.is_super_admin())
    $policy$;
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename = 'job_time_entries'
      AND policyname = 'Super Admins can view all job time entries'
  ) THEN
    EXECUTE $policy$
      CREATE POLICY "Super Admins can view all job time entries"
      ON public.job_time_entries
      FOR SELECT
      TO authenticated
      USING (public.is_super_admin())
    $policy$;
  END IF;
END
$migration$;

COMMIT;
