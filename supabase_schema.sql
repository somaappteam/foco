-- Run this in Supabase SQL Editor

-- User Progress Table
create table user_progress (
  user_id uuid primary key references auth.users(id),
  source_language text default 'en',
  target_language text default 'en',
  current_battery float default 100,
  current_streak int default 0,
  total_words_illuminated int default 0,
  total_scenes_completed int default 0,
  last_session_date timestamp with time zone,
  subscription_tier text default 'scout',
  updated_at timestamp with time zone default now()
);

-- Discovered Words (Sync)
create table discovered_words (
  user_id uuid references auth.users(id),
  word_id text not null,
  language_code text,
  discovered_at timestamp with time zone,
  illumination_strength int default 100,
  synced_at timestamp with time zone default now(),
  primary key (user_id, word_id)
);

-- Illumination Records (Analytics)
create table illumination_records (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id),
  word_id text not null,
  scene_id text not null,
  illuminated_at timestamp with time zone,
  time_to_find_seconds int,
  unique(user_id, word_id, illuminated_at)
);

-- Competition Results
create table competition_results (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id),
  scene_id text not null,
  time_seconds int not null,
  username text,
  created_at timestamp with time zone default now()
);

-- Enable RLS
alter table user_progress enable row level security;
alter table discovered_words enable row level security;
alter table illumination_records enable row level security;
alter table competition_results enable row level security;

-- Policies (Users can only see/edit their own data)
create policy "Users can view own progress"
  on user_progress for select
  using (auth.uid() = user_id);

create policy "Users can update own progress"
  on user_progress for update
  using (auth.uid() = user_id);

create policy "Users can insert own progress"
  on user_progress for insert
  with check (auth.uid() = user_id);

-- Similar policies for other tables

-- Enable Realtime for ghost trails
alter publication supabase_realtime add table user_progress;
