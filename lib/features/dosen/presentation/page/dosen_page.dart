import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../provider/dosen_provider.dart';
import '../widget/dosen_widget.dart';

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
            // ── Header ──────────────────────────────────────
            Container(
              color:   AppTheme.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Data Dosen',
                          style: TextStyle(
                              fontSize:   20,
                              fontWeight: FontWeight.w700,
                              color:      AppTheme.neutral900)),
                      dosenAsync.maybeWhen(
                        data: (list) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color:        AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${list.length} dosen',
                              style: const TextStyle(
                                  fontSize:   12,
                                  fontWeight: FontWeight.w600,
                                  color:      AppTheme.primary)),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Program Studi D4 Teknik Informatika',
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.neutral500)),
                ],
              ),
            ),

            // ── List ────────────────────────────────────────
            Expanded(
              child: dosenAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
                  itemBuilder: (_, __) => Container(
                    height: 90,
                    decoration: BoxDecoration(
                        color:        AppTheme.neutral100,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                error: (err, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 52, color: Colors.red),
                      const SizedBox(height: 12),
                      Text('Error: $err',
                          style: const TextStyle(
                              color: AppTheme.neutral500)),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () =>
                            ref.refresh(dosenFutureProvider),
                        icon:  const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
                data: (list) => DosenListView(
                  dosenList:     list,
                  useModernCard: true,
                  onRefresh:     () => ref.refresh(dosenFutureProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}