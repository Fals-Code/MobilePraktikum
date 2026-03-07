import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  static const List<MahasiswaModel> _data = [
    MahasiswaModel(nama: 'Ahmad Fadli Ramadhan',   nim: '22010101', email: 'ahmad.fadli@st.unair.ac.id',   jurusan: 'Teknik Informatika', angkatan: '2023'),
    MahasiswaModel(nama: 'Siti Rahmawati',          nim: '22010102', email: 'siti.rahmawati@st.unair.ac.id', jurusan: 'Sistem Informasi',   angkatan: '2022'),
    MahasiswaModel(nama: 'Rizky Pratama',           nim: '22010103', email: 'rizky.pratama@st.unair.ac.id',  jurusan: 'Statistika',         angkatan: '2024'),
    MahasiswaModel(nama: 'Dinda Maharani Putri',    nim: '22010104', email: 'dinda.maharani@st.unair.ac.id', jurusan: 'Teknik Informatika', angkatan: '2022'),
    MahasiswaModel(nama: 'Muhammad Iqbal',          nim: '22010105', email: 'm.iqbal@st.unair.ac.id',        jurusan: 'Sistem Informasi',   angkatan: '2025'),
    MahasiswaModel(nama: 'Nabila Zahra',            nim: '22010106', email: 'nabila.zahra@st.unair.ac.id',   jurusan: 'Statistika',         angkatan: '2025'),
    MahasiswaModel(nama: 'Fajar Nugroho',           nim: '22010107', email: 'fajar.nugroho@st.unair.ac.id',  jurusan: 'Teknik Informatika', angkatan: '2023'),
    MahasiswaModel(nama: 'Rina Kartika Sari',       nim: '22010108', email: 'rina.kartika@st.unair.ac.id',   jurusan: 'Sistem Informasi',   angkatan: '2024'),
    MahasiswaModel(nama: 'Bagus Saputra',           nim: '22010109', email: 'bagus.saputra@st.unair.ac.id',  jurusan: 'Teknik Informatika', angkatan: '2022'),
    MahasiswaModel(nama: 'Lestari Ayu Wulandari',   nim: '22010110', email: 'lestari.ayu@st.unair.ac.id',    jurusan: 'Statistika',         angkatan: '2022'),
  ];

  Future<List<MahasiswaModel>> fetchMahasiswa() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _data;
  }

  Future<List<MahasiswaModel>> fetchMahasiswaAktif() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _data.take(6).toList();
  }
}