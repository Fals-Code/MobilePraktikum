import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dosen_model.dart';
import '../../data/repositories/dosen_repository.dart';

final dosenRepositoryProvider = Provider((ref) => DosenRepository());

final dosenFutureProvider = FutureProvider<List<DosenModel>>((ref) {
  return ref.watch(dosenRepositoryProvider).fetchDosen();
});