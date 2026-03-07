import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../dosen/presentation/page/dosen_page.dart';
import '../../../mahasiswa/presentation/pages/mahasiswa_page.dart';
import '../../../profile/presentation/page/profile_page.dart';
import '../provider/dashboard_provider.dart';
import '../widgets/dashboard_widget.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardDataProvider.future),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "Overview",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            dashboardAsync.when(
              data: (data) => SliverPadding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final stats = data.stats[index];
                      return ModernStatCard(
                        stats: stats,
                        gradientColors: AppConstants.dashboardGradients[
                        index % AppConstants.dashboardGradients.length],
                        onTap: () {
                          Widget? targetPage;
                          if (stats.title == "Total Mahasiswa") {
                            targetPage = const MahasiswaPage();
                          } else if (stats.title == "Total Dosen") {
                            targetPage = const DosenPage();
                          } else if (stats.title == "Profil") {
                            targetPage = const ProfilePage();
                          }

                          if (targetPage != null) {
                            Navigator.push(context, _createRoute(targetPage));
                          }
                        },
                      );
                    },
                    childCount: data.stats.length,
                  ),
                ),
              ),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(child: Text("Terjadi kesalahan: $err")),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}