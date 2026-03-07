import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../provider/dosen_provider.dart';
import '../widget/dosen_list_tile.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenAsync = ref.watch(dosenFutureProvider);

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
                      const Text('Daftar Dosen',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700,
                              color: AppTheme.neutral900)),
                      dosenAsync.maybeWhen(
                        data: (list) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${list.length} dosen',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600,
                                  color: AppTheme.primary)),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Program Studi D4 Teknik Informatika',
                      style: TextStyle(fontSize: 13, color: AppTheme.neutral500)),
                ],
              ),
            ),

            // ── Jabatan Summary ──────────────────────────
            dosenAsync.maybeWhen(
              data: (list) => _JabatanSummary(list: list),
              orElse: () => const SizedBox.shrink(),
            ),

            // ── List ─────────────────────────────────────
            Expanded(
              child: dosenAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, __) => Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: AppTheme.neutral100,
                          borderRadius: BorderRadius.circular(12))),
                ),
                error: (err, _) => Center(
                    child: Text('Error: $err',
                        style: const TextStyle(color: AppTheme.neutral500))),
                data: (list) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => DosenListTile(dosen: list[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JabatanSummary extends StatelessWidget {
  final List<dynamic> list;
  const _JabatanSummary({required this.list});

  @override
  Widget build(BuildContext context) {
    final counts = <String, int>{};
    for (final d in list) {
      counts[d.jabatan] = (counts[d.jabatan] ?? 0) + 1;
    }
    const palette = {
      'Guru Besar':    [AppTheme.purple,  AppTheme.purpleLight],
      'Lektor Kepala': [AppTheme.warning,  AppTheme.warningLight],
      'Dosen Tetap':   [AppTheme.primary,  AppTheme.primaryLight],
    };
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: counts.entries.map((e) {
          final c = palette[e.key] ?? [AppTheme.primary, AppTheme.primaryLight];
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: (c[1] as Color),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                Text('${e.value}',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800,
                        color: c[0] as Color)),
                const SizedBox(height: 2),
                Text(e.key,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w600,
                        color: (c[0] as Color).withOpacity(0.8))),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}