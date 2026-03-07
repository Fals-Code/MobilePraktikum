import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider =
Provider((ref) => MahasiswaRepository());

final mahasiswaFutureProvider = FutureProvider<List<MahasiswaModel>>((ref) {
  return ref.watch(mahasiswaRepositoryProvider).fetchMahasiswa();
});

final mahasiswaAktifProvider = FutureProvider<List<MahasiswaModel>>((ref) {
  return ref.watch(mahasiswaRepositoryProvider).fetchMahasiswaAktif();
});

final mahasiswaSearchProvider = StateProvider<String>((ref) => '');

final filteredMahasiswaProvider = Provider<AsyncValue<List<MahasiswaModel>>>((ref) {
  final query = ref.watch(mahasiswaSearchProvider).toLowerCase();
  final asyncList = ref.watch(mahasiswaFutureProvider);
  return asyncList.whenData((list) => query.isEmpty
      ? list
      : list
      .where((m) =>
  m.nama.toLowerCase().contains(query) ||
      m.nim.toLowerCase().contains(query))
      .toList());
});