import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../dashboard/presentation/page/dashboard_page.dart';
import '../../../mahasiswa/presentation/pages/mahasiswa_page.dart';
import '../../../mahasiswa/presentation/pages/mahasiswa_local_page.dart';
import '../../../dosen/presentation/page/dosen_page.dart';
import '../../../profile/presentation/page/profile_page.dart';

final navIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navIndexProvider);

    const pages = <Widget>[
      DashboardPage(),
      MahasiswaPage(),
      MahasiswaLocalPage(),   // ← ganti MahasiswaAktifPage
      DosenPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.white,
          border: Border(
            top: BorderSide(color: AppTheme.neutral100, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => ref.read(navIndexProvider.notifier).state = i,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.white,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.neutral500,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.w700),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              activeIcon: Icon(Icons.people_rounded),
              label: 'Mahasiswa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined),      // ← ikon baru
              activeIcon: Icon(Icons.person_pin_rounded),
              label: 'Mhs Local',                         // ← label baru
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              activeIcon: Icon(Icons.school_rounded),
              label: 'Dosen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}