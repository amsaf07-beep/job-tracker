-- Run this once in Supabase: Project → SQL Editor → New query → paste → Run

create table public.jobs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null,
  company text,
  link text,
  notes text,
  stage text not null default 'New Job',
  created_at timestamptz not null default now()
);

-- Lock the table down so each person can only ever see and change their own rows.
alter table public.jobs enable row level security;

create policy "Users manage their own jobs"
on public.jobs
for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Needed for the live-update feature on the board.
alter publication supabase_realtime add table public.jobs;
