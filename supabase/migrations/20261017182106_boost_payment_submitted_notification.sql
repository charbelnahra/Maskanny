
CREATE OR REPLACE FUNCTION public.get_host_boost_payment_notification_details(
  p_boost_id uuid
)
RETURNS TABLE (
  property_title text,
  owner_firstname text,
  owner_email text,
  plan_name text,
  amount_due numeric,
  currency text
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT
    p.title::text,
    u.firstname::text,
    u.email::text,
    bp.name::text,
    pb.amount_due,
    pb.currency::text
  FROM public.property_boosting AS pb
  JOIN public.property AS p
    ON p.property_id = pb.property_id
  JOIN public.host AS h
    ON h.host_id = p.host_id
  JOIN public."user" AS u
    ON u.user_id = h.user_id
  JOIN public.boosting_plan AS bp
    ON bp.boosting_plan_id = pb.boosting_plan_id
  WHERE pb.property_boosting_id = p_boost_id
    AND u.user_id = auth.uid()
    AND EXISTS (
      SELECT 1
      FROM public.boost_payment AS pay
      WHERE pay.property_boosting_id = pb.property_boosting_id
    );
$$;

REVOKE ALL ON FUNCTION
  public.get_host_boost_payment_notification_details(uuid)
  FROM PUBLIC;

GRANT EXECUTE ON FUNCTION
  public.get_host_boost_payment_notification_details(uuid)
  TO authenticated;
