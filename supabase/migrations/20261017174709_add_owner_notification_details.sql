CREATE OR REPLACE FUNCTION public.get_property_owner_notification_details(
  p_property_id uuid
)
RETURNS TABLE (
  property_title text,
  owner_firstname text,
  owner_email text
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  PERFORM public.require_admin();

  RETURN QUERY
  SELECT
    p.title::text,
    u.firstname::text,
    u.email::text
  FROM public.property AS p
  JOIN public.host AS h
    ON h.host_id = p.host_id
  JOIN public."user" AS u
    ON u.user_id = h.user_id
  WHERE p.property_id = p_property_id;
END;
$$;

REVOKE ALL ON FUNCTION
  public.get_property_owner_notification_details(uuid)
  FROM PUBLIC;

GRANT EXECUTE ON FUNCTION
  public.get_property_owner_notification_details(uuid)
  TO authenticated;