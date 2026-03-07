import '../models/dosen_model.dart';

class DosenRepository {
  Future<List<DosenModel>> fetchDosen() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const [
      DosenModel(nama: 'Dr. Ahmad Fauzi, S.Kom., M.Kom.', nidn: '0123456701', foto: '', bidangKeahlian: 'Kecerdasan Buatan', jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Dr. Siti Rahmawati, S.T., M.T.', nidn: '0212345602', foto: '', bidangKeahlian: 'Rekayasa Perangkat Lunak', jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Prof. Budi Santoso, M.Sc., Ph.D.', nidn: '0311223303', foto: '', bidangKeahlian: 'Jaringan Komputer', jabatan: 'Guru Besar'),
      DosenModel(nama: 'Dr. Rina Kurniawati, S.Kom., M.Kom.', nidn: '0412349904', foto: '', bidangKeahlian: 'Basis Data', jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Dr. Andi Pratama, S.T., M.T.', nidn: '0512377705', foto: '', bidangKeahlian: 'Sistem Terdistribusi', jabatan: 'Dosen Tetap'),
      DosenModel(nama: 'Dr. Dewi Lestari, S.Kom., M.Cs.', nidn: '0612456706', foto: '', bidangKeahlian: 'Sains Data', jabatan: 'Lektor Kepala'),
    ];
  }
}