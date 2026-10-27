// Latihan 2 — Inheritance dan Polymorphism

abstract class Pegawai {
  String nama;

  Pegawai(this.nama);

  // Method yang akan ditimpa oleh subclass
  double hitungGaji();
}

class PegawaiTetap extends Pegawai {
  double gajiPokok;
  double tunjangan;

  PegawaiTetap(super.nama, this.gajiPokok, this.tunjangan);

  @override
  double hitungGaji() => gajiPokok + tunjangan;
}

class PegawaiHarian extends Pegawai {
  double upahPerHari;
  int jumlahHariKerja;

  PegawaiHarian(super.nama, this.upahPerHari, this.jumlahHariKerja);

  @override
  double hitungGaji() => upahPerHari * jumlahHariKerja;
}

// Satu fungsi untuk semua jenis Pegawai (polymorphism)
void tampilkanGaji(Pegawai pegawai) {
  print('Nama  : ${pegawai.nama}');
  print('Tipe  : ${pegawai.runtimeType}');
  print('Gaji  : Rp ${pegawai.hitungGaji().toStringAsFixed(0)}');
  print('---------------------------');
}

void main() {
  Pegawai p1 = PegawaiTetap('Budi', 5000000, 1500000);
  Pegawai p2 = PegawaiHarian('Siti', 150000, 22);

  tampilkanGaji(p1);
  tampilkanGaji(p2);
}
