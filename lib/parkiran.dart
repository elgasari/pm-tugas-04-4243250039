import 'dart:async';
import 'model.dart';

/// Exception kustom ketika kapasitas lahan parkir telah terpenuhi.
class ParkirPenuh implements Exception {
  final int kapasitas;
  ParkirPenuh(this.kapasitas);

  @override
  String toString() => 'Ditolak: Parkiran penuh (kapasitas $kapasitas)';
}

/// Layanan pengelola operasional parkir kampus FMIPA.
class Parkiran {
  final int kapasitas;
  final List<Kendaraan> _terparkir = [];
  int _pendapatan = 0;
  final _kejadianController = StreamController<String>.broadcast();

  Parkiran({required this.kapasitas});

  Stream<String> get kejadian => _kejadianController.stream;
  int get sisa => kapasitas - _terparkir.length;
  int get pendapatan => _pendapatan;

  /// Simulasi kendaraan masuk melewati palang otomatis.
  Future<void> masuk(Kendaraan k) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_terparkir.length >= kapasitas) {
      throw ParkirPenuh(kapasitas);
    }
    _terparkir.add(k);
    _kejadianController.add('MASUK $k (sisa$sisa)');
  }

  /// Simulasi kendaraan keluar, menghitung tarif, dan membuka palang.
  Future<int> keluar(String plat, {DateTime? waktuKeluar}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _terparkir.indexWhere((k) => k.plat == plat);
    if (index == -1) {
      throw StateError('Kendaraan dengan plat $plat tidak ditemukan di parkiran');
    }

    final kendaraan = _terparkir.removeAt(index);
    final totalBiaya = kendaraan.biaya(waktuKeluar ?? DateTime.now());
    _pendapatan += totalBiaya;

    _kejadianController.add('KELUAR $kendaraan bayar Rp$totalBiaya');
    return totalBiaya;
  }

  Future<void> tutup() => _kejadianController.close();
}