import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/dosen_provider.dart';
import '../widget/dosen_card.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenAsync = ref.watch(dosenFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Dosen"),
        centerTitle: true,
      ),
      body: dosenAsync.when(
        data: (daftarDosen) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: daftarDosen.length,
          itemBuilder: (context, index) {
            return DosenCard(dosen: daftarDosen[index]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}