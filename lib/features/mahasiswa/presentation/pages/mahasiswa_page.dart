import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = ref.watch(filteredMahasiswaProvider);
    final query    = ref.watch(mahasiswaSearchProvider);

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
                      const Text('Data Mahasiswa',
                          style: TextStyle(
                              fontSize:   20,
                              fontWeight: FontWeight.w700,
                              color:      AppTheme.neutral900)),
                      filtered.maybeWhen(
                        data: (list) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color:        AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${list.length} data',
                              style: const TextStyle(
                                  fontSize:   12,
                                  fontWeight: FontWeight.w600,
                                  color:      AppTheme.primary)),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Search bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                        color:        AppTheme.neutral100,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (v) => ref
                          .read(mahasiswaSearchProvider.notifier)
                          .state = v,
                      style: const TextStyle(
                          fontSize: 14, color: AppTheme.neutral900),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama atau email...',
                        hintStyle: TextStyle(
                            fontSize: 14, color: AppTheme.neutral500),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 20, color: AppTheme.neutral500),
                        border:         InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── List ────────────────────────────────────────
            Expanded(
              child: filtered.when(
                loading: () => _skeleton(),
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
                            ref.refresh(mahasiswaFutureProvider),
                        icon:  const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
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
                                fontSize: 14,
                                color:    AppTheme.neutral500),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async =>
                        ref.refresh(mahasiswaFutureProvider),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final m = list[i];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:        AppTheme.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppTheme.neutral100),
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width:  46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary
                                      .withOpacity(0.1),
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    m.name
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize:   18,
                                      fontWeight: FontWeight.bold,
                                      color:      AppTheme.primary,
                                    ),
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
                                    Text(m.name,
                                        style: const TextStyle(
                                            fontSize:   14,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.neutral900),
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Text(m.email,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.neutral500),
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Text(m.body,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: AppTheme.neutral500),
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              // ID badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLight,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                                child: Text('#${m.id}',
                                    style: const TextStyle(
                                        fontSize:   11,
                                        fontWeight: FontWeight.w700,
                                        color:      AppTheme.primary)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
      height: 80,
      decoration: BoxDecoration(
          color:        AppTheme.neutral100,
          borderRadius: BorderRadius.circular(12)),
    ),
  );
}