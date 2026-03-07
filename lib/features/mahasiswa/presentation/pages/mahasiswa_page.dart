import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100], // Background yang bersih
      appBar: AppBar(
        title: const Text('Data Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(mahasiswaNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Gagal memuat data: ${error.toString()}'),
              ElevatedButton(
                onPressed: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
                child: const Text('Coba Lagi'),
              )
            ],
          ),
        ),
        data: (mahasiswaList) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(mahasiswaNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                final mahasiswa = mahasiswaList[index];
                // Menggunakan gradien biru untuk semua kartu (Bisa disesuaikan)
                final gradientColors = [Color(0xFF4facfe), Color(0xFF00f2fe)];

                return ModernMahasiswaCard(
                  mahasiswa: mahasiswa,
                  gradientColors: gradientColors,
                  onTap: () {
                    // Tindakan jika kartu diklik (misal: masuk ke detail)
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}