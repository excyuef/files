// Latihan 1 — Class dan Constructor

class Buku {
  String judul;
  String penulis;
  int tahunTerbit;

  // Constructor untuk mengisi ketiga property
  Buku(this.judul, this.penulis, this.tahunTerbit);

  void tampilkanInfo() {
    print('Judul        : $judul');
    print('Penulis      : $penulis');
    print('Tahun Terbit : $tahunTerbit');
    print('---------------------------');
  }
}

void main() {
  Buku buku1 = Buku('Laskar Pelangi', 'Andrea Hirata', 2005);
  Buku buku2 = Buku('Bumi Manusia', 'Pramoedya Ananta Toer', 1980);

  buku1.tampilkanInfo();
  buku2.tampilkanInfo();
}
