import '../models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardData> fetchDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return DashboardData(
      userName: 'Ahmad Mathlaul Falah',
      lastUpdate: DateTime.now(),
      stats: const [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '1.240',
          subtitle: 'Meningkat dari bulan lalu',
          percentage: 12.5,
          isIncrease: true,
        ),
        DashboardStats(
          title: 'Rata-rata IPK',
          value: '3.45',
          subtitle: 'Stabil semester ini',
          percentage: 0.5,
          isIncrease: true,
        ),
        DashboardStats(
          title: 'Kehadiran',
          value: '92%',
          subtitle: 'Turun 2% minggu ini',
          percentage: 2.0,
          isIncrease: false,
        ),
        DashboardStats(
          title: 'SKS Selesai',
          value: '110',
          subtitle: 'Target 144 SKS',
          percentage: 76.4,
          isIncrease: true,
        ),
      ],
    );
  }
}