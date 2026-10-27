// Latihan 3 — Mixin

mixin BisaDicetak {
  // Class yang memakai mixin wajib menyediakan isi yang akan dicetak
  String get isiCetak;

  void cetak() {
    print('===== MENCETAK =====');
    print(isiCetak);
    print('====================');
  }
}

class Laporan with BisaDicetak {
  String judul;
  String isi;

  Laporan(this.judul, this.isi);

  @override
  String get isiCetak => 'Laporan: $judul\n$isi';
}

class Kartu with BisaDicetak {
  String nama;
  String nomor;

  Kartu(this.nama, this.nomor);

  @override
  String get isiCetak => 'Kartu Anggota\nNama  : $nama\nNomor : $nomor';
}

void main() {
  Laporan laporan = Laporan('Laporan Bulanan', 'Penjualan naik 10% bulan ini.');
  Kartu kartu = Kartu('Andi', 'A-0012');

  laporan.cetak();
  kartu.cetak();
}
