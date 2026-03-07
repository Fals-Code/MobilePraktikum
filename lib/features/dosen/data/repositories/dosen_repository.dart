import '../models/dosen_model.dart';

class DosenRepository {
  Future<List<DosenModel>> fetchDosen() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const [
      DosenModel(nama: 'Purbandini',    nidn: '0123456701', foto: '', bidangKeahlian: 'Kecerdasan Buatan',       jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Anank Prasetyo',     nidn: '0212345602', foto: '', bidangKeahlian: 'Aplikasi Mobile', jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Rachman Sinatriya',   nidn: '0311223303', foto: '', bidangKeahlian: 'Jaringan Komputer',       jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Alifian Sukma', nidn: '0412349904', foto: '', bidangKeahlian: 'Workshop UI',             jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Dr. Eva Hariyanti',       nidn: '0512377705', foto: '', bidangKeahlian: 'Manajemen Proyek Perangkat Lunak',    jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Tesa Eranti Putri',    nidn: '0612456706', foto: '', bidangKeahlian: 'Basis Data',             jabatan: 'Kepala Prodi'),
    ];
  }
}