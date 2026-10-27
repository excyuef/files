// Latihan 4 — Exception Handling

double hitungRataRata(List<int> nilai) {
  if (nilai.isEmpty) {
    throw Exception('List nilai tidak boleh kosong!');
  }

  int total = 0;
  for (int n in nilai) {
    total += n;
  }
  return total / nilai.length;
}

void main() {
  List<int> daftarNilai = [80, 90, 75, 85];
  List<int> daftarKosong = [];

  // Kasus normal
  try {
    double rata = hitungRataRata(daftarNilai);
    print('Rata-rata: $rata');
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }

  // Kasus list kosong
  try {
    double rata = hitungRataRata(daftarKosong);
    print('Rata-rata: $rata');
  } catch (e) {
    print('Terjadi kesalahan: $e');
  } finally {
    print('Proses perhitungan selesai.');
  }
}
