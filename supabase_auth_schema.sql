-- ==================== FILE: supabase_auth_schema.sql ====================

-- Enable Anonymous Sign-ins (if using Supabase's native anon auth)
-- Or use the device_id approach in the Dart code above

-- Add constraint: Subscriptions require auth.users reference
create table user_subscriptions (
  id uuid default gen_random_uuid() primary key,
  user_id uuid not null references auth.users(id), -- Must be real user
  tier_id text not null,
  status text default 'active',
  created_at timestamp with time zone default now(),
  expires_at timestamp with time zone,
  unique(user_id, tier_id)
);

-- RLS: Only authenticated users can subscribe
alter table user_subscriptions enable row level security;

create policy "Authenticated users can view own subscriptions"
  on user_subscriptions for select
  using (auth.uid() = user_id);

create policy "Authenticated users can insert own subscriptions"
  on user_subscriptions for insert
  with check (auth.uid() = user_id);

-- Function to migrate guest data (called from Dart)
create or replace function migrate_guest_data(old_device_id text, new_user_id uuid)
returns void as $$
begin
  -- Update any server-side records from device_id to user_id
  update competition_results 
  set user_id = new_user_id::text 
  where user_id = old_device_id;
  
  -- Note: Hive data migration happens client-side
end;
$$ language plpgsql security definer;
