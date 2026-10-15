create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = public
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null default '',
  email text not null default '',
  phone text,
  company text,
  professional_registry text,
  avatar_url text,
  dark_mode boolean not null default false,
  app_icon_key text not null default 'principal',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table public.clients (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  document text,
  phone text,
  email text,
  city text,
  state text check (state is null or char_length(state) = 2),
  active boolean not null default true,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create table public.farms (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  client_id uuid not null references public.clients(id) on delete cascade,
  name text not null,
  area_ha double precision not null check (area_ha > 0),
  crop text not null,
  season text not null,
  city text,
  state text check (state is null or char_length(state) = 2),
  active boolean not null default true,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create table public.plots (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  farm_id uuid not null references public.farms(id) on delete cascade,
  name text not null,
  area_ha double precision not null check (area_ha > 0),
  notes text,
  active boolean not null default true,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create table public.catalog_products (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  commercial_name text not null,
  active_ingredient text,
  category text not null,
  default_unit text not null,
  min_dose double precision,
  max_dose double precision,
  unit_price double precision,
  manufacturer text,
  notes text,
  active boolean not null default true,
  is_seed boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz,
  constraint catalog_products_owner check (
    (is_seed and user_id is null) or (not is_seed and user_id is not null)
  )
);

create table public.technical_references (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  stage text not null,
  title text not null,
  description text,
  management_focus text,
  practices text,
  pattern text,
  highlight text
);

create table public.plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  client_id uuid references public.clients(id) on delete set null,
  farm_id uuid references public.farms(id) on delete set null,
  name text not null,
  crop text not null,
  season text not null,
  total_area_ha double precision not null check (total_area_ha > 0),
  status text not null check (status in ('rascunho', 'ativo', 'consolidado')),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create table public.stages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  plan_id uuid not null references public.plans(id) on delete cascade,
  code text not null,
  label text not null,
  position integer not null default 0,
  application_date timestamptz,
  notes text,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create table public.application_products (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  stage_id uuid not null references public.stages(id) on delete cascade,
  catalog_product_id uuid references public.catalog_products(id) on delete set null,
  product_name text not null,
  product_category text not null,
  dose double precision not null check (dose > 0),
  dose_unit text not null,
  area_ha double precision not null check (area_ha > 0),
  plot_reference text,
  total_override double precision,
  override_reason text,
  unit_price double precision,
  notes text,
  planned_date timestamptz,
  position integer not null default 0,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  deleted_at timestamptz
);

create index clients_user_updated_idx on public.clients(user_id, updated_at);
create index farms_user_client_idx on public.farms(user_id, client_id);
create index plots_user_farm_idx on public.plots(user_id, farm_id);
create index catalog_products_user_category_idx on public.catalog_products(user_id, category);
create index catalog_products_seed_idx on public.catalog_products(is_seed) where is_seed;
create index technical_references_category_stage_idx on public.technical_references(category, stage);
create index plans_user_updated_idx on public.plans(user_id, updated_at);
create index stages_user_plan_idx on public.stages(user_id, plan_id);
create index application_products_user_stage_idx on public.application_products(user_id, stage_id);

create trigger profiles_set_updated_at before update on public.profiles
for each row execute function public.set_updated_at();
create trigger clients_set_updated_at before update on public.clients
for each row execute function public.set_updated_at();
create trigger farms_set_updated_at before update on public.farms
for each row execute function public.set_updated_at();
create trigger plots_set_updated_at before update on public.plots
for each row execute function public.set_updated_at();
create trigger catalog_products_set_updated_at before update on public.catalog_products
for each row execute function public.set_updated_at();
create trigger plans_set_updated_at before update on public.plans
for each row execute function public.set_updated_at();
create trigger stages_set_updated_at before update on public.stages
for each row execute function public.set_updated_at();
create trigger application_products_set_updated_at before update on public.application_products
for each row execute function public.set_updated_at();

alter table public.profiles enable row level security;
alter table public.clients enable row level security;
alter table public.farms enable row level security;
alter table public.plots enable row level security;
alter table public.catalog_products enable row level security;
alter table public.technical_references enable row level security;
alter table public.plans enable row level security;
alter table public.stages enable row level security;
alter table public.application_products enable row level security;

create policy profiles_select_own on public.profiles for select to authenticated
using (id = (select auth.uid()));
create policy profiles_insert_own on public.profiles for insert to authenticated
with check (id = (select auth.uid()));
create policy profiles_update_own on public.profiles for update to authenticated
using (id = (select auth.uid())) with check (id = (select auth.uid()));
create policy profiles_delete_own on public.profiles for delete to authenticated
using (id = (select auth.uid()));

create policy clients_select_own on public.clients for select to authenticated
using (user_id = (select auth.uid()));
create policy clients_insert_own on public.clients for insert to authenticated
with check (user_id = (select auth.uid()));
create policy clients_update_own on public.clients for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy clients_delete_own on public.clients for delete to authenticated
using (user_id = (select auth.uid()));

create policy farms_select_own on public.farms for select to authenticated
using (user_id = (select auth.uid()));
create policy farms_insert_own on public.farms for insert to authenticated
with check (
  user_id = (select auth.uid()) and exists (
    select 1 from public.clients c where c.id = client_id and c.user_id = (select auth.uid())
  )
);
create policy farms_update_own on public.farms for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy farms_delete_own on public.farms for delete to authenticated
using (user_id = (select auth.uid()));

create policy plots_select_own on public.plots for select to authenticated
using (user_id = (select auth.uid()));
create policy plots_insert_own on public.plots for insert to authenticated
with check (
  user_id = (select auth.uid()) and exists (
    select 1 from public.farms f where f.id = farm_id and f.user_id = (select auth.uid())
  )
);
create policy plots_update_own on public.plots for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy plots_delete_own on public.plots for delete to authenticated
using (user_id = (select auth.uid()));

create policy catalog_products_select on public.catalog_products for select to authenticated
using (is_seed or user_id = (select auth.uid()));
create policy catalog_products_insert_own on public.catalog_products for insert to authenticated
with check (not is_seed and user_id = (select auth.uid()));
create policy catalog_products_update_own on public.catalog_products for update to authenticated
using (not is_seed and user_id = (select auth.uid()))
with check (not is_seed and user_id = (select auth.uid()));
create policy catalog_products_delete_own on public.catalog_products for delete to authenticated
using (not is_seed and user_id = (select auth.uid()));

create policy technical_references_read on public.technical_references
for select to authenticated using (true);

create policy plans_select_own on public.plans for select to authenticated
using (user_id = (select auth.uid()));
create policy plans_insert_own on public.plans for insert to authenticated
with check (user_id = (select auth.uid()));
create policy plans_update_own on public.plans for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy plans_delete_own on public.plans for delete to authenticated
using (user_id = (select auth.uid()));

create policy stages_select_own on public.stages for select to authenticated
using (user_id = (select auth.uid()));
create policy stages_insert_own on public.stages for insert to authenticated
with check (
  user_id = (select auth.uid()) and exists (
    select 1 from public.plans p where p.id = plan_id and p.user_id = (select auth.uid())
  )
);
create policy stages_update_own on public.stages for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy stages_delete_own on public.stages for delete to authenticated
using (user_id = (select auth.uid()));

create policy application_products_select_own on public.application_products
for select to authenticated using (user_id = (select auth.uid()));
create policy application_products_insert_own on public.application_products
for insert to authenticated with check (
  user_id = (select auth.uid()) and exists (
    select 1 from public.stages s where s.id = stage_id and s.user_id = (select auth.uid())
  )
);
create policy application_products_update_own on public.application_products
for update to authenticated
using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy application_products_delete_own on public.application_products
for delete to authenticated using (user_id = (select auth.uid()));

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, name, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'name', new.raw_user_meta_data ->> 'full_name', ''),
    coalesce(new.email, '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();
