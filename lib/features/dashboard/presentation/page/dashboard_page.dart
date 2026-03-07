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
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? 'Selamat Pagi' : hour < 17 ? 'Selamat Siang' : 'Selamat Malam';

    return Scaffold(
      backgroundColor: AppTheme.neutral50,
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: () => ref.refresh(dashboardDataProvider.future),
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                color: AppTheme.white,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 20, right: 20, bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greeting,
                            style: const TextStyle(
                                fontSize: 13, color: AppTheme.neutral500)),
                        const SizedBox(height: 2),
                        dashboardAsync.when(
                          data: (d) => Text(d.userName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700,
                                  color: AppTheme.neutral900)),
                          loading: () => Container(
                              height: 24, width: 180,
                              decoration: BoxDecoration(
                                  color: AppTheme.neutral100,
                                  borderRadius: BorderRadius.circular(6))),
                          error: (_, __) => const Text('Dashboard',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700,
                                  color: AppTheme.neutral900)),
                        ),
                      ],
                    ),
                    Container(
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.notifications_none_rounded,
                          color: AppTheme.primary, size: 22),
                    ),
                  ],
                ),
              ),
            ),

            // ── Semester Banner ──────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A56DB), Color(0xFF1239A5)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.school_rounded,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Semester Genap 2024/2025',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 2),
                          Text('D4 Teknik Informatika – UNAIR',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text('Aktif',
                          style: TextStyle(
                              color: Colors.white, fontSize: 11,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ),

            // ── Stats Label ──────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Text('Ringkasan Akademik',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppTheme.neutral900)),
              ),
            ),

            // ── Stats Grid ───────────────────────────────
            dashboardAsync.when(
              data: (data) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12,
                    crossAxisSpacing: 12, childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, i) => StatCard(
                      stats: data.stats[i],
                      gradientColors: AppConstants.statGradients[
                      i % AppConstants.statGradients.length],
                    ),
                    childCount: data.stats.length,
                  ),
                ),
              ),
              loading: () => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12,
                    crossAxisSpacing: 12, childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (_, __) => Container(
                        decoration: BoxDecoration(
                            color: AppTheme.neutral100,
                            borderRadius: BorderRadius.circular(12))),
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
                        color: const Color(0xFFFDE8E8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF8B4B4))),
                    child: Row(children: [
                      const Icon(Icons.error_outline, color: Color(0xFFE02424)),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Gagal memuat data: $err',
                          style: const TextStyle(fontSize: 13))),
                    ]),
                  ),
                ),
              ),
            ),

            // ── Informasi Terkini ────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text('Informasi Terkini',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppTheme.neutral900)),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
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
                    SizedBox(height: 10),
                    QuickInfoCard(
                      icon: Icons.announcement_outlined,
                      iconColor: AppTheme.purple,
                      iconBg: AppTheme.purpleLight,
                      title: 'Pengumuman Beasiswa',
                      subtitle: 'Pendaftaran dibuka s.d. 28 Feb 2025',
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