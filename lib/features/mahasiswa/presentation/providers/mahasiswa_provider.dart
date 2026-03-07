import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

// Provider untuk Repository
final mahasiswaRepositoryProvider = Provider((ref) => MahasiswaRepository());

// Provider untuk Semua Mahasiswa
final mahasiswaFutureProvider = FutureProvider<List<MahasiswaModel>>((ref) async {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return repository.fetchMahasiswa();
});

// Provider untuk Mahasiswa Aktif (Ini yang menyebabkan error jika belum ada)
final mahasiswaAktifProvider = FutureProvider<List<MahasiswaModel>>((ref) async {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return repository.fetchMahasiswaAktif();
});