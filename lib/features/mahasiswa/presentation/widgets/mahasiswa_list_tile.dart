import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../../../../core/theme/app_theme.dart';

const _jurusanColors = <String, Color>{
  'Teknik Informatika': AppTheme.primary,
  'Sistem Informasi':   AppTheme.success,
  'Sains Data':         AppTheme.purple,
};

class MahasiswaListTile extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback? onTap;

  const MahasiswaListTile({super.key, required this.mahasiswa, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = _jurusanColors[mahasiswa.jurusan] ?? AppTheme.primary;
    final initials = mahasiswa.nama.trim().split(' ').take(2)
        .map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.neutral100),
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(initials,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: color)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mahasiswa.nama,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600,
                          color: AppTheme.neutral900),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Row(children: [
                    Text(mahasiswa.nim,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.neutral500)),
                    const Text(' • ',
                        style: TextStyle(fontSize: 12, color: AppTheme.neutral300)),
                    Expanded(
                      child: Text(mahasiswa.jurusan,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.neutral500),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(mahasiswa.angkatan,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600,
                      color: AppTheme.neutral500)),
            ),
          ],
        ),
      ),
    );
  }
}