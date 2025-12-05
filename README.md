# ☕ Aplikasi Kopi Nako — Flutter
**NAMA MAHASISWA PEMBUAT** : Muhammad Ilham Riyadi 
**NIM** : 14022300009  
**MATA KULIAH** : Pemrograman Mobile  
**DOSEN PENGAMPU** : Faisal Akhmad S.Kom., M.Kom.  
**PROGRAM STUDI** : Sistem Informasi  
**FAKULTAS** : Fakultas Ilmu Komputer  
**UNIVERSITAS BINA BANGSA**
---
## 📱 Deskripsi Aplikasi
Aplikasi **Kopi Nako** adalah aplikasi pemesanan kopi berbasis Flutter dengan tampilan modern, interaktif, dan responsif. Pengguna dapat menjelajahi menu kopi, menambahkan ke favorit, memasukkan pesanan ke keranjang, mengedit profil, hingga mengganti foto profil menggunakan Image Picker.
Aplikasi ini juga dilengkapi **Dark Mode** yang dapat diganti kapan saja oleh pengguna.
Aplikasi dibuat sebagai tugas pemrograman mobile dengan minimal **5 layer/halaman**.
---
## 🧭 Navigasi Layar
Aplikasi menggunakan **BottomNavigationBar** dengan **5 menu utama**, yaitu:
1. 🏠 **Home**  
2. ☕ **Menu Kopi**  
3. ❤️ **Favorit**  
4. 🛒 **Keranjang**  
5. 👤 **Profil**
Setiap halaman memiliki fungsi yang berbeda sesuai kebutuhan aplikasi.
---
# ☕ **Layer 1 — Home**
Halaman pertama yang tampil saat aplikasi dibuka.
### Fitur Home:
- Banner sambutan pengguna  
- Search bar untuk mencari menu  
- Banner promo mingguan  
- Kategori kopi populer (Classic, Shot, Special, Iced)  
- Rekomendasi menu kopi  
- Navigasi cepat ke halaman Menu  
UI dibuat modern dengan:
- Rounded card  
- Gradient promo  
- Shadow lembut  
- Responsive layout  
---
# 📋 **Layer 2 — Menu**
Halaman daftar menu kopi.
### Fitur:
- Menampilkan seluruh menu kopi dengan gambar  
- Grid view 2 kolom  
- Harga & kategori  
- Klik item membuka halaman detail  
---
# ⭐ **Layer 3 — Favorit**
Daftar menu kopi yang disukai pengguna.  
Disimpan secara **in-memory** di aplikasi.
### Fitur:
- Klik ♥ untuk menyimpan atau menghapus favorit  
- Tersinkron otomatis dengan halaman detail  
- Tampilan grid seperti menu  
---
# 🛒 **Layer 4 — Keranjang**
Halaman checkout pesanan.
### Fitur:
- Daftar item yang ditambahkan  
- Tambah/kurang jumlah pesan  
- Hapus item  
- Total harga otomatis  
- Tombol checkout  
---
# 👤 **Layer 5 — Profil**
Halaman profil pengguna dengan tampilan modern (glass card style).
### Fitur:
- Menampilkan nama & foto profil   
- Mengubah nama pengguna  
- Badge *Gold Member*  
- Menu pengaturan (dummy)  
- **Toggle Dark/Light Mode**
---
## 🌙 **Mode Gelap / Terang**
Aplikasi mendukung dua mode:
- **Light Mode** (cream / coklat Kopi Nako)
- **Dark Mode** (hitam / coklat gelap)
Pengguna dapat menggantinya dari halaman Profil.
Cara Menjalankan Aplikasi
Install Flutter SDK
Clone/download project
Jalankan perintah:
flutter pub get
flutter run
======================================================================
🎨 Desain UI
Aplikasi menggunakan desain:
Dark theme modern
Gradient promo banner
Tampilan konsisten rapi pada setiap layer.
======================================================================
🚀 Rencana Pengembangan (Opsional)
Versi lanjutan bisa memiliki fitur:
Menu kopi dari API server
Notifikasi promo
======================================================================
❤️ Kesimpulan
Aplikasi Kopi Nako adalah aplikasi pemesanan kopi modern berbasis Flutter dengan 5 layer utama (Home, Menu, Favorit, Cart, Profil). Aplikasi ini dirancang dengan desain UI yang menarik, smooth, dan responsif, serta memanfaatkan berbagai konsep Flutter seperti:
Dark mode
Image picker
Sangat cocok sebagai tugas kuliah, proyek akhir
======================================================================
🗂️ Struktur Folder Project
lib/
main.dart
pages/
models/
widgets/
android/
ios/
web/
pubspec.yaml
README.md
======================================================================
👨‍💻 Developer
Dibuat oleh:Muhammad Ilham Riyadi
Project Aplikasi Kopi Nako – Flutter
Universitas Bina Bangsa
Pemrograman Mobile – 5 Layer App
📝 Riwayat Commit (Commit History)
Gunakan commit message yang jelas dan profesional.
Berikut contoh commit terbaik untuk proyek Kopi Nako:
✅ Commit Awal
"Upload pertama aplikasi Kopi Nako Flutter"
✅ Penambahan Fitur Menu
"Menambahkan halaman Menu Kopi + Grid View + Detail Page"
✅ Sistem Favorit
"Implementasi fitur favorit dengan sinkronisasi ke halaman detail"
✅ Sistem Keranjang
"Membuat fitur Cart: tambah/kurang jumlah, total harga, checkout"
✅ Profil & Edit Profil
"Menambahkan halaman profil + edit nama + pilihan avatar"
✅ Dark Mode
"Menambahkan Dark/Light Mode + Theme switching di halaman profil"
🎯 Tujuan Commit Guidelines
Memudahkan dosen melakukan review
Menjelaskan perkembangan proyek
Profesional saat dipresentasikan
Menjadi portofolio GitHub yang rapi
