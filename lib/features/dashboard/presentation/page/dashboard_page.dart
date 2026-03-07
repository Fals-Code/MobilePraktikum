import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../provider/dashboard_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_info_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Selamat Pagi'
        : now.hour < 17
        ? 'Selamat Siang'
        : 'Selamat Malam';

    return Scaffold(
      backgroundColor: AppTheme.neutral50,
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: () => ref.refresh(dashboardDataProvider.future),
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Container(
                color: AppTheme.white,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greeting,
                            style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.neutral500)),
                        const SizedBox(height: 2),
                        dashboardAsync.when(
                          data: (d) => Text(d.userName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.neutral900)),
                          loading: () => const Text('Memuat...',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.neutral300)),
                          error: (_, __) => const Text('Dashboard',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.neutral900)),
                        ),
                      ],
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_none_rounded,
                          color: AppTheme.primary, size: 22),
                    ),
                  ],
                ),
              ),
            ),

            // Stats Section Label
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Text('Ringkasan Akademik',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.neutral900)),
              ),
            ),

            // Stats Grid
            dashboardAsync.when(
              data: (data) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final stats = data.stats[index];
                      return StatCard(
                        stats: stats,
                        gradientColors: AppConstants
                            .statGradients[index % AppConstants.statGradients.length],
                      );
                    },
                    childCount: data.stats.length,
                  ),
                ),
              ),
              loading: () => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (_, __) => const _SkeletonCard(),
                    childCount: 4,
                  ),
                ),
              ),
              error: (err, _) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade400),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Gagal memuat data: $err',
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Quick Info Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text('Informasi Terkini',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.neutral900)),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  children: const [
                    QuickInfoCard(
                      icon: Icons.calendar_month_rounded,
                      iconColor: AppTheme.primary,
                      iconBg: AppTheme.primaryLight,
                      title: 'Jadwal UTS',
                      subtitle: '15 April – 22 April 2025',
                    ),
                    SizedBox(height: 10),
                    QuickInfoCard(
                      icon: Icons.assignment_outlined,
                      iconColor: AppTheme.warning,
                      iconBg: AppTheme.warningLight,
                      title: 'Pengisian KRS',
                      subtitle: 'Dibuka hingga 10 Maret 2025',
                    ),
                    SizedBox(height: 10),
                    QuickInfoCard(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: AppTheme.success,
                      iconBg: AppTheme.successLight,
                      title: 'Status Akademik',
                      subtitle: 'Aktif – Semester Genap 2024/2025',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
    );
  }
}