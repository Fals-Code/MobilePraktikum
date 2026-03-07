import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_list_tile.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = ref.watch(filteredMahasiswaProvider);
    final query = ref.watch(mahasiswaSearchProvider);

    return Scaffold(
      backgroundColor: AppTheme.neutral50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: AppTheme.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Data Mahasiswa',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.neutral900)),
                  const SizedBox(height: 4),
                  filtered.maybeWhen(
                    data: (list) => Text(
                        '${list.length} mahasiswa ditemukan',
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.neutral500)),
                    orElse: () => const Text('Memuat...',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.neutral300)),
                  ),
                  const SizedBox(height: 14),
                  // Search Bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.neutral100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (v) =>
                      ref.read(mahasiswaSearchProvider.notifier).state = v,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.neutral900),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama atau NIM...',
                        hintStyle: TextStyle(
                            fontSize: 14, color: AppTheme.neutral500),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 20, color: AppTheme.neutral500),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // List
            Expanded(
              child: filtered.when(
                loading: () => _buildSkeletonList(),
                error: (err, _) => Center(
                    child: Text('Error: $err',
                        style: const TextStyle(color: AppTheme.neutral500))),
                data: (list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded,
                              size: 48, color: AppTheme.neutral300),
                          const SizedBox(height: 12),
                          Text(
                            query.isEmpty
                                ? 'Tidak ada data'
                                : 'Tidak ditemukan untuk "$query"',
                            style: const TextStyle(
                                fontSize: 14, color: AppTheme.neutral500),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) =>
                        MahasiswaListTile(mahasiswa: list[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, __) => Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppTheme.neutral100,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}