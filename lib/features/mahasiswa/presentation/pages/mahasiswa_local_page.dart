import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashboard_mahasiswa/core/widgets/widgets.dart';
import 'package:dashboard_mahasiswa/features/dosen/data/models/dosen_model.dart';
import 'package:dashboard_mahasiswa/features/mahasiswa/presentation/providers/mahasiswa_local_provider.dart';

class MahasiswaLocalPage extends ConsumerWidget {
  const MahasiswaLocalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaLocalNotifierProvider);
    final savedMahasiswa = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () =>
                ref.read(mahasiswaLocalNotifierProvider.notifier).refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedSection(savedMahasiswa: savedMahasiswa),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: mahasiswaState.when(
              loading: () => const LoadingWidget(),
              error:   (e, _) => CustomErrorWidget(
                message: e.toString(),
                onRetry: () => ref
                    .read(mahasiswaLocalNotifierProvider.notifier)
                    .refresh(),
              ),
              data: (list) => _MahasiswaList(list: list),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Saved Section ────────────────────────────────────────
class _SavedSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedMahasiswa;
  const _SavedSection({required this.savedMahasiswa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Data Tersimpan di Local Storage',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              savedMahasiswa.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(mahasiswaLocalNotifierProvider
                        .notifier)
                        .clearMahasiswa();
                    ref.invalidate(savedMahasiswaProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text('Semua data dihapus')),
                      );
                    }
                  },
                  icon: const Icon(
                      Icons.delete_sweep_outlined,
                      size: 14,
                      color: Colors.red),
                  label: const Text('Hapus Semua',
                      style: TextStyle(
                          fontSize: 12, color: Colors.red)),
                )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Content
          savedMahasiswa.when(
            loading: () => const LinearProgressIndicator(),
            error:   (_, __) => const Text('Gagal membaca data tersimpan',
                style: TextStyle(color: Colors.red, fontSize: 12)),
            data: (users) => users.isEmpty
                ? _emptyBox()
                : _savedList(context, ref, users),
          ),
        ],
      ),
    );
  }

  Widget _emptyBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              size: 16, color: Colors.grey.shade400),
          const SizedBox(width: 8),
          Text(
            'Belum ada data. Tap ikon simpan untuk menyimpan.',
            style:
            TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _savedList(BuildContext context, WidgetRef ref,
      List<Map<String, String>> users) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (_, __) => Divider(
            height: 1,
            color: Colors.blue.shade100,
            indent: 12,
            endIndent: 12),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(user['username'] ?? '-',
                style:
                const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(
              'ID: ${user['user_id']} • ${_fmt(user['saved_at'] ?? '')}',
              style: const TextStyle(fontSize: 11),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close,
                  size: 16, color: Colors.red),
              onPressed: () async {
                await ref
                    .read(mahasiswaLocalNotifierProvider.notifier)
                    .removeMahasiswa(user['user_id'] ?? '');
                ref.invalidate(savedMahasiswaProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                        Text('${user['username']} dihapus')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  String _fmt(String iso) {
    if (iso.isEmpty) return '-';
    try {
      final d = DateTime.parse(iso);
      return '${d.day}/${d.month}/${d.year} '
          '${d.hour}:${d.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}

// ── Daftar Mahasiswa ─────────────────────────────────────
class _MahasiswaList extends ConsumerWidget {
  final List<DosenModel> list;
  const _MahasiswaList({required this.list});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(mahasiswaLocalNotifierProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final m = list[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${m.id}')),
              title: Text(m.name),
              subtitle: Text(
                '${m.username} · ${m.email}\n${m.address.city}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan',
                onPressed: () async {
                  await ref
                      .read(mahasiswaLocalNotifierProvider.notifier)
                      .saveMahasiswa(m);
                  ref.invalidate(savedMahasiswaProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${m.username} berhasil disimpan'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}