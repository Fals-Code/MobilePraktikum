import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider =
Provider((ref) => MahasiswaRepository());

// Provider Mahasiswa (/comments) — menggunakan http
final mahasiswaFutureProvider =
FutureProvider<List<MahasiswaModel>>((ref) =>
    ref.watch(mahasiswaRepositoryProvider).fetchMahasiswa());

// Provider Mahasiswa (/comments) — menggunakan dio
final mahasiswaDioProvider =
FutureProvider<List<MahasiswaModel>>((ref) =>
    ref.watch(mahasiswaRepositoryProvider).fetchMahasiswaDio());

// Provider Mahasiswa Aktif (/posts) — menggunakan http
final mahasiswaAktifProvider =
FutureProvider<List<MahasiswaAktifModel>>((ref) =>
    ref.watch(mahasiswaRepositoryProvider).fetchMahasiswaAktif());

// Provider Mahasiswa Aktif (/posts) — menggunakan dio
final mahasiswaAktifDioProvider =
FutureProvider<List<MahasiswaAktifModel>>((ref) =>
    ref.watch(mahasiswaRepositoryProvider).fetchMahasiswaAktifDio());

final mahasiswaSearchProvider = StateProvider<String>((ref) => '');

final filteredMahasiswaProvider =
Provider<AsyncValue<List<MahasiswaModel>>>((ref) {
  final query = ref.watch(mahasiswaSearchProvider).toLowerCase();
  return ref.watch(mahasiswaFutureProvider).whenData(
        (list) => query.isEmpty
        ? list
        : list
        .where((m) =>
    m.name.toLowerCase().contains(query) ||
        m.email.toLowerCase().contains(query))
        .toList(),
  );
});