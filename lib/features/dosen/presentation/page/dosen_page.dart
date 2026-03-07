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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: AppTheme.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Daftar Dosen',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.neutral900)),
                  const SizedBox(height: 4),
                  dosenAsync.when(
                    data: (list) => Text('${list.length} dosen terdaftar',
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.neutral500)),
                    loading: () => const Text('Memuat...',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.neutral300)),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // List
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                error: (err, _) => Center(
                    child: Text('Error: $err',
                        style: const TextStyle(color: AppTheme.neutral500))),
                data: (list) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) =>
                      DosenListTile(dosen: list[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}