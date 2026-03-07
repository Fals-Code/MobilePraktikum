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
          children: [
            // ── Header ───────────────────────────────────
            Container(
              color: AppTheme.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Data Mahasiswa',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700,
                              color: AppTheme.neutral900)),
                      filtered.maybeWhen(
                        data: (list) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${list.length} data',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600,
                                  color: AppTheme.primary)),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                        color: AppTheme.neutral100,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (v) =>
                      ref.read(mahasiswaSearchProvider.notifier).state = v,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.neutral900),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama atau NIM...',
                        hintStyle: TextStyle(fontSize: 14, color: AppTheme.neutral500),
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

            // ── Jurusan Filter Chips ─────────────────────
            filtered.maybeWhen(
              data: (_) => _JurusanSummary(ref: ref),
              orElse: () => const SizedBox.shrink(),
            ),

            // ── List ─────────────────────────────────────
            Expanded(
              child: filtered.when(
                loading: () => _skeleton(),
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
                              size: 52, color: AppTheme.neutral300),
                          const SizedBox(height: 12),
                          Text(
                            query.isEmpty
                                ? 'Tidak ada data mahasiswa'
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
                    itemBuilder: (_, i) =>
                        MahasiswaListTile(mahasiswa: list[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeleton() => ListView.separated(
    padding: const EdgeInsets.all(16),
    itemCount: 6,
    separatorBuilder: (_, __) => const SizedBox(height: 8),
    itemBuilder: (_, __) => Container(
        height: 72,
        decoration: BoxDecoration(
            color: AppTheme.neutral100,
            borderRadius: BorderRadius.circular(12))),
  );
}

class _JurusanSummary extends ConsumerWidget {
  const _JurusanSummary({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef watchRef) {
    final all = watchRef.watch(mahasiswaFutureProvider).asData?.value ?? [];
    if (all.isEmpty) return const SizedBox.shrink();

    final counts = <String, int>{};
    for (final m in all) {
      counts[m.jurusan] = (counts[m.jurusan] ?? 0) + 1;
    }

    const colors = {
      'Teknik Informatika': AppTheme.primary,
      'Sistem Informasi': AppTheme.success,
      'Sains Data': AppTheme.purple,
    };

    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: counts.entries.map((e) {
          final color = colors[e.key] ?? AppTheme.primary;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text('${e.value}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700,
                          color: color)),
                  const SizedBox(height: 2),
                  Text(e.key.replaceAll(' ', '\n'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9, color: color.withOpacity(0.8))),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}