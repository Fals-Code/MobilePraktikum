import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/services/local_storage_service.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';
import 'package:dashboard_mahasiswa/features/mahasiswa/data/repositories/mahasiswa_local_repository.dart';

final mahasiswaLocalRepositoryProvider =
Provider<MahasiswaLocalRepository>((_) => MahasiswaLocalRepository());

final mahasiswaStorageProvider =
Provider<LocalStorageService>((_) => LocalStorageService());

const _mahasiswaKey = 'saved_mahasiswa';

final savedMahasiswaProvider =
FutureProvider<List<Map<String, String>>>((ref) {
  return ref
      .watch(mahasiswaStorageProvider)
      .getSavedUsersWithKey(_mahasiswaKey);
});

class MahasiswaNotifier extends AsyncNotifier<List<DosenModel>> {
  @override
  Future<List<DosenModel>> build() {
    return ref
        .watch(mahasiswaLocalRepositoryProvider)
        .getMahasiswaList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
          () => ref
          .read(mahasiswaLocalRepositoryProvider)
          .getMahasiswaList(),
    );
  }

  Future<void> saveMahasiswa(DosenModel m) async {
    await ref
        .read(mahasiswaStorageProvider)
        .addUserToSavedListWithKey(
      key:      _mahasiswaKey,
      userId:   m.id.toString(),
      username: m.username,
    );
  }

  Future<void> removeMahasiswa(String userId) async {
    await ref
        .read(mahasiswaStorageProvider)
        .removeSavedUserWithKey(_mahasiswaKey, userId);
  }

  Future<void> clearMahasiswa() async {
    await ref
        .read(mahasiswaStorageProvider)
        .clearSavedUsersWithKey(_mahasiswaKey);
  }
}

final mahasiswaLocalNotifierProvider =
AsyncNotifierProvider<MahasiswaNotifier, List<DosenModel>>(
  MahasiswaNotifier.new,
);