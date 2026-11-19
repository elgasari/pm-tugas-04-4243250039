/// Abstraksi dasar untuk seluruh jenis kendaraan yang masuk ke area parkir.
abstract class Kendaraan {
  final String plat;
  final DateTime waktuMasuk;

  Kendaraan(this.plat, [DateTime? waktuMasuk])
      : waktuMasuk = waktuMasuk ?? DateTime.now();

  String get jenis;
  int get tarifPerJam;

  /// Menghitung biaya parkir dengan pembulatan ke atas per jam (minimal 1 jam).
  int biaya(DateTime keluar) {
    final durasiMenit = keluar.difference(waktuMasuk).inMinutes;
    int jam = (durasiMenit / 60).ceil();
    if (jam < 1) jam = 1;
    return jam * tarifPerJam;
  }

  @override
  String toString() => '$jenis$plat';
}

/// Mixin untuk memberikan fasilitas diskon 50% bagi sivitas akademika berlangganan.
mixin Berlangganan on Kendaraan {
  @override
  int biaya(DateTime keluar) {
    final biayaNormal = super.biaya(keluar);
    return (biayaNormal * 0.5).round();
  }

  @override
  String toString() => '$jenis (member)$plat';
}

class Motor extends Kendaraan {
  Motor(super.plat, [super.waktuMasuk]);

  @override
  String get jenis => 'Motor';

  @override
  int get tarifPerJam => 2000;
}

class Mobil extends Kendaraan {
  Mobil(super.plat, [super.waktuMasuk]);

  @override
  String get jenis => 'Mobil';

  @override
  int get tarifPerJam => 5000;
}

class MobilMember extends Mobil with Berlangganan {
  MobilMember(super.plat, [super.waktuMasuk]);
}

class Truk extends Kendaraan {
  Truk(super.plat, [super.waktuMasuk]);

  @override
  String get jenis => 'Truk';

  @override
  int get tarifPerJam => 10000;
}