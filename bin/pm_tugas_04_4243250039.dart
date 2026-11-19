import 'package:pm_tugas_04_4243250039/model.dart';
import 'package:pm_tugas_04_4243250039/parkiran.dart';

Future<void> main() async {
  final parkiranFmipa = Parkiran(kapasitas: 3);

  // Listener layar pos jaga memantau Stream kejadian secara real-time
  final sub = parkiranFmipa.kejadian.listen((pesan) {
    print(pesan);
  });

  final waktuBase = DateTime(2026, 11, 17, 8, 0);

  // Demonstrasi polimorfisme: List<Kendaraan> menampung berbagai subclass
  final antreanMasuk = <Kendaraan>[
    Motor('BK 1234 AB', waktuBase),
    Mobil('BK 88 UN', waktuBase),
    MobilMember('BK 7 MIPA', waktuBase),
    Truk('BK 9999 XX', waktuBase), // Akan ditolak karena kapasitas 3
  ];

  for (final k in antreanMasuk) {
    try {
      await parkiranFmipa.masuk(k);
    } on ParkirPenuh catch (e) {
      print(e);
    }
  }

  // Simulasi kendaraan keluar setelah 2 jam 15 menit (dibulatkan ke atas menjadi 3 jam)
  final waktuKeluar = waktuBase.add(const Duration(hours: 2, minutes: 15));

  await parkiranFmipa.keluar('BK 1234 AB', waktuKeluar: waktuKeluar);
  await parkiranFmipa.keluar('BK 88 UN', waktuKeluar: waktuKeluar);
  await parkiranFmipa.keluar('BK 7 MIPA', waktuKeluar: waktuKeluar);

  // Beri jeda singkat agar seluruh event stream selesai dicetak sebelum ringkasan
  await Future.delayed(const Duration(milliseconds: 50));
  print('Pendapatan: Rp${parkiranFmipa.pendapatan}');

  await sub.cancel();
  await parkiranFmipa.tutup();
}