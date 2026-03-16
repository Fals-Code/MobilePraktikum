import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aktifAsync = ref.watch(mahasiswaAktifProvider);

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
                      const Text('Mahasiswa Aktif',
                          style: TextStyle(
                              fontSize:   20,
                              fontWeight: FontWeight.w700,
                              color:      AppTheme.neutral900)),
                      aktifAsync.maybeWhen(
                        data: (list) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color:        AppTheme.successLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${list.length} aktif',
                              style: const TextStyle(
                                  fontSize:   12,
                                  fontWeight: FontWeight.w600,
                                  color:      AppTheme.success)),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Semester Genap 2024/2025',
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.neutral500)),
                ],
              ),
            ),

            // ── Status Banner ────────────────────────────────
            aktifAsync.maybeWhen(
              data: (list) => Container(
                margin:  const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color:        AppTheme.successLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppTheme.success.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_rounded,
                        color: AppTheme.success, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${list.length} post dari API /posts',
                            style: const TextStyle(
                                fontSize:   13,
                                fontWeight: FontWeight.w600,
                                color:      AppTheme.success),
                          ),
                          const Text(
                            'Data diambil dari jsonplaceholder.typicode.com',
                            style: TextStyle(
                                fontSize: 11, color: AppTheme.success),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),

            // ── List ────────────────────────────────────────
            Expanded(
              child: aktifAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
                  itemBuilder: (_, __) => Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color:        AppTheme.neutral100,
                        borderRadius: BorderRadius.circular(12)),
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
                            ref.refresh(mahasiswaAktifProvider),
                        icon:  const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
                data: (list) => RefreshIndicator(
                  onRefresh: () async =>
                      ref.refresh(mahasiswaAktifProvider),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final post = list[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color:        AppTheme.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppTheme.neutral100),
                        ),
                        child: Row(
                          children: [
                            // Nomor urut
                            Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(
                                  color: AppTheme.neutral100,
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              child: Center(
                                child: Text('${index + 1}',
                                    style: const TextStyle(
                                        fontSize:   12,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.neutral500)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Avatar
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(
                                color: AppTheme.success
                                    .withOpacity(0.12),
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '${post.userId}',
                                  style: const TextStyle(
                                      fontSize:   14,
                                      fontWeight: FontWeight.w700,
                                      color:      AppTheme.success),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(post.title,
                                      style: const TextStyle(
                                          fontSize:   13,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.neutral900),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis),
                                  const SizedBox(height: 3),
                                  Text(post.body,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: AppTheme.neutral500),
                                      maxLines: 2,
                                      overflow:
                                      TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Badge aktif
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppTheme.successLight,
                                  borderRadius:
                                  BorderRadius.circular(6)),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.circle,
                                      size: 6,
                                      color: AppTheme.success),
                                  SizedBox(width: 4),
                                  Text('AKTIF',
                                      style: TextStyle(
                                          fontSize:   10,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.success)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}