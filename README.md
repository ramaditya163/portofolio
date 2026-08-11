# Portofolio Rama — Panduan Setup Lengkap (dari HP Android)

Isi portofolio (profil, sosial media, produk) sekarang tersimpan di **Supabase**
dan bisa diubah kapan saja lewat **panel admin** di situs itu sendiri — tidak perlu
edit kode lagi setelah setup awal ini selesai.

Ada 3 file:
- `index.html` → situs portofolionya
- `supabase-setup.sql` → skrip database
- `README.md` → panduan ini

---

## LANGKAH 1 — Buat project Supabase (database)

1. Buka https://supabase.com lewat browser HP, daftar/login (bisa pakai akun Google).
2. Klik **New Project**. Isi nama bebas, buat password database (simpan baik-baik), pilih region terdekat (Singapore).
3. Tunggu ± 2 menit sampai project siap.
4. Di sidebar, buka **SQL Editor** → **New query**.
5. Buka file `supabase-setup.sql` di sini, salin semua isinya, tempel ke SQL Editor, lalu klik **Run**.
6. Buka menu **Authentication → Users → Add user → Create new user**.
   Isi email bebas (misal `admin@punyamu.com`) dan password admin kamu. Ini akan jadi
   kunci masuk ke panel admin (ganti PIN lama, jauh lebih aman).
7. Buka menu **Project Settings → API**. Catat dua hal ini:
   - **Project URL**
   - **anon public key**

---

## LANGKAH 2 — Isi konfigurasi di index.html

Di Termux, buka file `index.html` (misal pakai `nano index.html`), cari bagian ini di
paling bawah dekat `<script>`:

```js
const SUPABASE_URL = "GANTI_DENGAN_SUPABASE_URL";
const SUPABASE_ANON_KEY = "GANTI_DENGAN_SUPABASE_ANON_KEY";
const ADMIN_EMAIL = "GANTI_DENGAN_EMAIL_ADMIN";
```

Ganti dengan Project URL, anon key, dan email admin dari Langkah 1. Simpan file
(di nano: `Ctrl+O` lalu `Enter`, keluar dengan `Ctrl+X`).

---

## LANGKAH 3 — Push ke GitHub lewat Termux

Kalau belum ada git & termux setup:

```bash
pkg update && pkg upgrade -y
pkg install git -y
```

Login GitHub dari Termux (sekali saja, pakai Personal Access Token sebagai password —
buat token di GitHub: Settings → Developer settings → Personal access tokens):

```bash
git config --global user.name "Nama Kamu"
git config --global user.email "email_kamu@gmail.com"
```

Buat repo baru di github.com lewat browser (misal nama `portofolio-rama`), jangan
centang "add README" (biar kosong). Lalu di Termux, masuk ke folder project ini:

```bash
cd path/ke/folder/portofolio-app
git init
git add .
git commit -m "Portofolio pertama"
git branch -M main
git remote add origin https://github.com/USERNAME_KAMU/portofolio-rama.git
git push -u origin main
```

Saat diminta login, masukkan username GitHub dan **Personal Access Token** (bukan password akun).

---

## LANGKAH 4 — Deploy ke Vercel

1. Buka https://vercel.com lewat browser, daftar/login pakai akun GitHub kamu (paling gampang).
2. Klik **Add New → Project**.
3. Pilih repo `portofolio-rama` yang baru dipush tadi → **Import**.
4. Framework preset biarkan **Other** (karena ini HTML biasa), klik **Deploy**.
5. Tunggu ± 1 menit → selesai! Kamu akan dapat link publik seperti
   `https://portofolio-rama.vercel.app` yang bisa dilihat siapa saja.

---

## LANGKAH 5 — Cara pakai panel admin

1. Buka situs kamu, klik ikon ⚙️ (gear) di pojok kanan atas.
2. Masukkan **password admin** (yang dibuat di Langkah 1 nomor 6).
3. Setelah masuk, kamu bisa ubah nama, profesi, bio, foto, nomor WhatsApp, daftar
   sosial media, dan daftar produk — lalu klik **Simpan Perubahan**.
4. Perubahan langsung tersimpan di Supabase dan otomatis muncul untuk semua
   pengunjung situsmu — tidak perlu push ulang ke GitHub/Vercel.

**Catatan foto:** karena versi ini belum ada fitur upload file, isi kolom foto
dengan **link URL gambar** (misalnya upload dulu ke imgur.com atau Supabase Storage,
lalu salin link-nya). Kalau nanti mau ditambah fitur upload foto langsung dari HP,
tinggal bilang saja.

**Update kode di masa depan:** kalau suatu saat mau ubah desain/kode (bukan isi
konten), edit `index.html` di Termux lalu:
```bash
git add .
git commit -m "update"
git push
```
Vercel otomatis deploy ulang setiap kali ada push baru ke GitHub.
