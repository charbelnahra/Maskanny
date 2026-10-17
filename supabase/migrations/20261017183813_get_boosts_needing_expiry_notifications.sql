
create or replace function public.get_boosts_needing_expiry_notifications(
  p_today date
)
returns table (
  boost_id uuid,
  property_title text,
  owner_firstname text,
  owner_email text,
  end_date date,
  notification_type text
)
language sql
security definer
set search_path = ''
as $$
  select
    pb.property_boosting_id,
    p.title::text,
    u.firstname::text,
    u.email::text,
    pb.end_date::date,
    case
      when pb.end_date::date = p_today + 3
        then 'three_day_reminder'
      else 'expired'
    end::text
  from public.property_boosting as pb
  join public.property as p
    on p.property_id = pb.property_id
  join public.host as h
    on h.host_id = p.host_id
  join public."user" as u
    on u.user_id = h.user_id
  where pb.status = 'active'
    and pb.end_date is not null
    and pb.end_date::date in (p_today, p_today + 3)
    and u.email is not null;
$$;

revoke all on function
  public.get_boosts_needing_expiry_notifications(date)
  from public, anon, authenticated;

grant execute on function
  public.get_boosts_needing_expiry_notifications(date)
  to service_role;
