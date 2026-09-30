BEGIN;

DO $migration$
BEGIN
  IF to_regprocedure('public.is_super_admin()') IS NULL THEN
    RAISE EXCEPTION
      'Required function public.is_super_admin() does not exist';
  END IF;
END
$migration$;

REVOKE EXECUTE ON FUNCTION public.is_super_admin()
  FROM PUBLIC, anon;

GRANT EXECUTE ON FUNCTION public.is_super_admin()
  TO authenticated, service_role;

COMMIT;
