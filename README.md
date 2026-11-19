# Tugas Rutin 4: Sistem Parkir Kampus (Console)

## a. Identitas
- **Nama:** Elga Sari Tanjung
- **NIM:** 4243250039
- **Kelas:** PSIK-24C
- **Program Studi:** Ilmu Komputer

## b. Diagram Kelas
```text
+---------------------------------------+
|            <<abstract>>               |
|             Kendaraan                 |
+---------------------------------------+
| + plat: String                        |
| + waktuMasuk: DateTime                |
| + jenis: String {get}                 |
| + tarifPerJam: int {get}              |
+---------------------------------------+
| + biaya(keluar: DateTime): int        |
+---------------------------------------+
         ^           ^           ^
         |           |           |
   +-----+     +-----+     +-----+
   |           |           |
+-------+   +-------+   +-------+      +-----------------------+
| Motor |   | Mobil |   | Truk  |      |       <<mixin>>       |
+-------+   +-------+   +-------+      |     Berlangganan      |
               ^                       +-----------------------+
               |                       | + biaya(): int        |
               +----------+------------+ +-----------------------+
                          | (with)
                   +-------------+
                   | MobilMember |
                   +-------------+

+---------------------------------------+        +------------------+
|               Parkiran                |------->|  <<exception>>   |
+---------------------------------------+        |   ParkirPenuh    |
| + kapasitas: int                      |        +------------------+
| - _terparkir: List<Kendaraan>         |
| - _pendapatan: int                    |
| - _kejadianController: StreamCtrl     |
+---------------------------------------+
| + sisa: int {get}                     |
| + pendapatan: int {get}               |
| + masuk(k: Kendaraan): Future         |
| + keluar(plat: String): Future        |
+---------------------------------------+
```

## c. Tangkapan Layar Keluaran
![Tangkapan Layar Keluaran Program](screenshots/output_tugas_parkir.png)

## d. Penjelasan Enkapsulasi, Polimorfisme, dan Async
Pada sistem parkir kampus FMIPA ini, **enkapsulasi** diterapkan pada kelas `Parkiran` melalui field privat `_terparkir` dan `_pendapatan` (diawali garis bawah sehingga bersifat *library-private* di Dart). Akses ke data tersebut diatur melalui getter `sisa` dan `pendapatan` serta method `masuk()` dan `keluar()` agar status kapasitas dan pendapatan tidak diubah sembarangan dari luar. **Polimorfisme** diterapkan di fungsi `main` melalui `List<Kendaraan>` yang menampung beberapa jenis kendaraan (`Motor`, `Mobil`, `MobilMember`, dan `Truk`). Saat `biaya()` dipanggil, Dart menjalankan implementasi sesuai objek aslinya serta menerapkan potongan tarif 50% dari mixin `Berlangganan` pada `MobilMember`. Sementara itu, **async** diterapkan dengan `Future.delayed` pada `masuk()` dan `keluar()` untuk mensimulasikan palang otomatis tanpa memblokir *event loop*, serta `StreamController.broadcast()` untuk memancarkan log kejadian secara *real-time* ke listener pos jaga.

## e. Pernyataan Penggunaan AI
Dalam pengerjaan tugas ini, AI digunakan sebagai asisten diskusi untuk memverifikasi struktur kode Dart 3, memastikan kesesuaian dengan ketentuan modul, serta menyusun format dokumentasi.
