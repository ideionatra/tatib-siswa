# TATIB-SISWA

Website sederhana berbasis **PHP Native (tanpa framework)** yang digunakan untuk pengelolaan dan tampilan sistem **Tata Tertib Siswa**.

Project ini menggunakan pendekatan **routing sederhana + template layout + komponen**, sehingga struktur tetap rapi tanpa menerapkan pola MVC secara penuh.

---

## Tujuan Project

Project ini dibuat untuk:

* Memisahkan **halaman**, **komponen UI**, dan **routing**
* Membuat struktur PHP lebih terorganisir dibanding seluruh kode dalam satu file
* Menyediakan layout yang konsisten antar halaman
* Menjadi dasar pengembangan aplikasi web menggunakan **PHP Native**

---

# Struktur Folder

```plaintext
TATIB-SISWA
│
├── .dist/
│
├── components/
│   ├── footer.php
│   ├── head.php
│   └── navbar.php
│
├── public/
│   ├── assets/
│   │   ├── css/
│   │   ├── images/
│   │   └── js/
│   │
│   ├── pages/
│   │   ├── dashboard.php
│   │   └── index.php
│
├── routes/
│   └── web.php
│
├── storage/
│
├── Dockerfile
├── docker-compose.yaml
├── index.php
├── README.md
└── tatib_siswa.sql
```

---

# Penjelasan Struktur

## `/components`

Berisi komponen tampilan yang dapat digunakan ulang (reusable component).

Contoh:

* `navbar.php` → Navigasi website
* `footer.php` → Footer halaman
* `head.php` → Metadata dan konfigurasi HTML `<head>`

Tujuan:

* Mengurangi duplikasi kode
* Mempermudah perubahan tampilan global

---

## `/public`

Folder yang berisi seluruh resource yang ditampilkan ke browser.

### `/public/assets`

Menyimpan file statis.

```plaintext
assets/
├── css/
├── images/
└── js/
```

Isi:

* `css/` → File stylesheet
* `images/` → Gambar
* `js/` → Script JavaScript

---

### `/public/pages`

Berisi isi halaman utama.

Contoh:

* `dashboard.php`

Setiap file di folder ini hanya berisi **konten halaman**, bukan layout penuh.

---

### `/public/index.php`

Template utama (layout).

Bertugas:

* Menampilkan `<head>`
* Menampilkan navbar
* Menampilkan halaman sesuai router
* Menampilkan footer

Contoh alur:

```plaintext
Route
↓
public/index.php
↓
Navbar
↓
Page Content
↓
Footer
```

---

## `/routes`

Berisi daftar route aplikasi.

Contoh:

```php
return [

'/' => [
'title' => 'Dashboard',
'page' => './public/pages/dashboard.php'

]

];
```

Fungsi:

* Menentukan URL
* Menentukan judul halaman
* Menentukan file halaman yang dirender

---

## `/storage`

Digunakan untuk penyimpanan file sementara atau data aplikasi.

Contoh penggunaan:

* Upload file
* Cache
* Export laporan

---

## `index.php`

Entry point aplikasi.

File ini bertugas:

1. Membaca URL
2. Mencocokkan route
3. Mengirim data ke layout
4. Menampilkan halaman

Contoh alur:

```plaintext
Browser
↓
index.php
↓
routes/web.php
↓
public/index.php
↓
components + pages
```

---

## `tatib_siswa.sql`

File database yang berisi struktur tabel dan data awal aplikasi.

Import menggunakan:

```bash
mysql -u root -p < tatib_siswa.sql
```

---

# Menjalankan Project

## Menggunakan Laragon

Masuk ke terminal dan jalankan command:

```plaintext
php -S localhost:8000
```

---

## Menggunakan Docker

Jalankan:

```bash
docker compose up --build
```

Akses:

```plaintext
http://localhost:8080
```

---

# Konsep yang Digunakan

* PHP Native
* Routing sederhana
* Component-based structure
* Layout Template
* Reusable UI

---

Dikembangkan sebagai project pembelajaran dan pengembangan sistem Tata Tertib Siswa.
