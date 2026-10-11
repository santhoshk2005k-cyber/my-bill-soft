-- Run this once in your Supabase project's SQL editor
create table shopdata (
  id text primary key,
  data jsonb,
  updated_at timestamptz default now()
);
alter table shopdata enable row level security;
create policy "public access" on shopdata for all using (true) with check (true);
