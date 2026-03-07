import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading

    return [
      MahasiswaModel(
        nama: 'Ahmad Faisal',
        nim: '1029384756',
        email: 'ahmad.faisal@gmail.com',
        jurusan: 'Sistem Informasi',
        angkatan: '2023',
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '5647382910',
        email: 'budi.santoso@gmail.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2022',
      ),
      MahasiswaModel(
        nama: 'Citra Lestari',
        nim: '9876543210',
        email: 'citra.lestari@gmail.com',
        jurusan: 'Sistem Informasi',
        angkatan: '2023',
      ),
    ];
  }
}