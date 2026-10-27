// Latihan 5 — Proyek Mini: Sistem Perpustakaan Sederhana
// Menerapkan: 3+ class, constructor, inheritance, polymorphism, mixin, try-catch

// ---------- MIXIN ----------
mixin BisaDicetak {
  String get isiCetak;

  void cetak() {
    print('========== CETAK ==========');
    print(isiCetak);
    print('===========================');
  }
}

// ---------- CUSTOM EXCEPTION ----------
class PerpustakaanException implements Exception {
  final String pesan;
  PerpustakaanException(this.pesan);

  @override
  String toString() => 'PerpustakaanException: $pesan';
}

// ---------- CLASS 1: Item (induk) ----------
abstract class Item {
  final String kode;
  final String judul;
  bool sedangDipinjam = false;

  Item(this.kode, this.judul);

  String get jenis;

  // Polymorphism: tiap jenis item punya denda berbeda
  int hitungDenda(int hariTerlambat);

  @override
  String toString() =>
      '[$kode] $jenis - $judul ${sedangDipinjam ? "(dipinjam)" : "(tersedia)"}';
}

// ---------- CLASS 2: Buku (inheritance) ----------
class Buku extends Item {
  final String penulis;

  Buku(super.kode, super.judul, this.penulis);

  @override
  String get jenis => 'Buku';

  @override
  int hitungDenda(int hariTerlambat) => hariTerlambat * 1000;

  @override
  String toString() => '${super.toString()} oleh $penulis';
}

// ---------- CLASS 3: Majalah (inheritance) ----------
class Majalah extends Item {
  final int edisi;

  Majalah(super.kode, super.judul, this.edisi);

  @override
  String get jenis => 'Majalah';

  @override
  int hitungDenda(int hariTerlambat) => hariTerlambat * 500;

  @override
  String toString() => '${super.toString()} edisi $edisi';
}

// ---------- CLASS 4: Anggota ----------
class Anggota {
  final String nama;
  final List<Item> daftarPinjaman = [];
  static const int batasPinjam = 2;

  Anggota(this.nama);
}

// ---------- CLASS 5: Perpustakaan (memakai mixin) ----------
class Perpustakaan with BisaDicetak {
  final List<Item> koleksi = [];

  void tambahItem(Item item) => koleksi.add(item);

  Item _cariItem(String kode) {
    for (Item item in koleksi) {
      if (item.kode == kode) return item;
    }
    throw PerpustakaanException('Item dengan kode "$kode" tidak ditemukan.');
  }

  void pinjam(String kode, Anggota anggota) {
    Item item = _cariItem(kode);

    if (item.sedangDipinjam) {
      throw PerpustakaanException('"${item.judul}" sedang dipinjam.');
    }
    if (anggota.daftarPinjaman.length >= Anggota.batasPinjam) {
      throw PerpustakaanException(
          '${anggota.nama} sudah mencapai batas pinjam (${Anggota.batasPinjam}).');
    }

    item.sedangDipinjam = true;
    anggota.daftarPinjaman.add(item);
    print('${anggota.nama} berhasil meminjam "${item.judul}".');
  }

  void kembalikan(String kode, Anggota anggota, int hariTerlambat) {
    Item item = _cariItem(kode);

    if (!anggota.daftarPinjaman.contains(item)) {
      throw PerpustakaanException(
          '${anggota.nama} tidak sedang meminjam "${item.judul}".');
    }

    item.sedangDipinjam = false;
    anggota.daftarPinjaman.remove(item);

    int denda = item.hitungDenda(hariTerlambat);
    print('${anggota.nama} mengembalikan "${item.judul}". '
        'Denda: Rp $denda');
  }

  @override
  String get isiCetak {
    final buffer = StringBuffer('DAFTAR KOLEKSI PERPUSTAKAAN\n');
    for (Item item in koleksi) {
      buffer.writeln(item);
    }
    return buffer.toString().trimRight();
  }
}

// ---------- MAIN ----------
void main() {
  Perpustakaan perpus = Perpustakaan();
  perpus.tambahItem(Buku('B01', 'Laskar Pelangi', 'Andrea Hirata'));
  perpus.tambahItem(Buku('B02', 'Bumi Manusia', 'Pramoedya Ananta Toer'));
  perpus.tambahItem(Majalah('M01', 'Tempo', 42));

  Anggota andi = Anggota('Andi');
  Anggota sari = Anggota('Sari');

  perpus.cetak();
  print('');

  // Daftar aksi; beberapa sengaja memicu error
  List<void Function()> aksi = [
    () => perpus.pinjam('B01', andi),
    () => perpus.pinjam('B01', sari), // error: sudah dipinjam
    () => perpus.pinjam('X99', sari), // error: tidak ditemukan
    () => perpus.pinjam('M01', andi),
    () => perpus.pinjam('B02', andi), // error: batas pinjam
    () => perpus.kembalikan('B01', andi, 3), // denda buku 3 hari
    () => perpus.kembalikan('M01', andi, 4), // denda majalah 4 hari
    () => perpus.kembalikan('B02', sari, 0), // error: tidak meminjam
  ];

  for (var a in aksi) {
    try {
      a();
    } on PerpustakaanException catch (e) {
      print('Gagal -> ${e.pesan}');
    } catch (e) {
      print('Error tak terduga: $e');
    }
  }

  print('');
  perpus.cetak();
}
