-- ============================================================
-- SETUP DATABASE PORTOFOLIO — jalankan di Supabase SQL Editor
-- (Dashboard Supabase > SQL Editor > New query > paste semua ini > Run)
-- ============================================================

-- 1. Buat tabel portfolio (satu baris data untuk seluruh isi situs)
create table if not exists portfolio (
  id int primary key default 1,
  profile jsonb not null default '{}'::jsonb,
  socials jsonb not null default '[]'::jsonb,
  products jsonb not null default '[]'::jsonb,
  updated_at timestamptz default now()
);

-- 2. Isi data awal (sesuai isi portofolio kamu sebelumnya)
insert into portfolio (id, profile, socials, products)
values (
  1,
  '{
    "nama": "Rama",
    "role": "Web Developer",
    "lokasi": "Indonesia",
    "bio": "Membangun solusi digital dengan kode & kreativitas",
    "foto_url": "https://ui-avatars.com/api/?name=Rama&size=130&background=7ec8e3&color=fff&bold=true",
    "nomor_wa": ""
  }'::jsonb,
  '[
    {"platform": "instagram", "url": "#"},
    {"platform": "github", "url": "#"},
    {"platform": "linkedin", "url": "#"},
    {"platform": "twitter", "url": "#"},
    {"platform": "youtube", "url": "#"},
    {"platform": "tiktok", "url": "#"}
  ]'::jsonb,
  '[
    {"nama": "Web App Pro", "deskripsi": "Sistem manajemen bisnis", "harga": "Rp 1.200.000", "foto_url": "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&h=300&fit=crop"},
    {"nama": "Mobile UI Kit", "deskripsi": "Desain iOS & Android", "harga": "Rp 850.000", "foto_url": "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400&h=300&fit=crop"},
    {"nama": "Cloud API", "deskripsi": "Integrasi data real-time", "harga": "Rp 2.100.000", "foto_url": "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=400&h=300&fit=crop"},
    {"nama": "UI/UX Package", "deskripsi": "Prototype & user research", "harga": "Rp 1.500.000", "foto_url": "https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400&h=300&fit=crop"}
  ]'::jsonb
)
on conflict (id) do nothing;

-- 3. Aktifkan Row Level Security (WAJIB, jangan dilewati)
alter table portfolio enable row level security;

-- 4. Siapa saja boleh MEMBACA data (supaya portofolio bisa dilihat semua orang)
create policy "Portfolio dapat dibaca publik"
  on portfolio for select
  using (true);

-- 5. Hanya user yang SUDAH LOGIN (admin) yang boleh MENGUBAH data
create policy "Hanya admin login yang boleh update"
  on portfolio for update
  using (auth.role() = 'authenticated');

-- ============================================================
-- LANGKAH TAMBAHAN (di luar SQL ini, lakukan di Dashboard Supabase):
--
-- Buat akun admin:
-- 1. Buka menu "Authentication" > "Users" > "Add user" > "Create new user"
-- 2. Isi email (bebas, misal admin@portofolio-kamu.com) dan password admin
-- 3. Matikan "Auto Confirm User"? -> Biarkan tercentang / confirmed
-- 4. Simpan email & password itu — ini yang dipakai untuk login di panel admin
-- ============================================================
