BEGIN;

DO $migration$
BEGIN
  IF to_regprocedure('public.auto_close_4pm_shifts()') IS NULL THEN
    RAISE EXCEPTION
      'Required function public.auto_close_4pm_shifts() does not exist';
  END IF;
END
$migration$;

REVOKE EXECUTE ON FUNCTION public.auto_close_4pm_shifts()
  FROM PUBLIC, anon, authenticated;

GRANT EXECUTE ON FUNCTION public.auto_close_4pm_shifts()
  TO service_role;

COMMIT;
