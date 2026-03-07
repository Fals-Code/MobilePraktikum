import 'package:flutter/material.dart';
import '../../data/models/dosen_model.dart';
import '../../../../../core/theme/app_theme.dart';

class DosenListTile extends StatelessWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;

  const DosenListTile({super.key, required this.dosen, this.onTap});

  @override
  Widget build(BuildContext context) {
    final initials = dosen.nama
        .replaceAll(RegExp(r'\b(Dr|Prof|S\.Kom|M\.Kom|S\.T|M\.T|M\.Sc|Ph\.D|M\.Cs)\b\.?', caseSensitive: false), '')
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join()
        .toUpperCase();

    final isProf = dosen.nama.startsWith('Prof');
    final jabatanColor = isProf ? const Color(0xFF7E3AF2) : AppTheme.primary;
    final jabatanBg = isProf
        ? const Color(0xFFF3EEFF)
        : AppTheme.primaryLight;

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
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: jabatanColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(initials,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: jabatanColor)),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dosen.nama,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.neutral900),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(dosen.bidangKeahlian.isNotEmpty
                      ? dosen.bidangKeahlian
                      : 'NIDN: ${dosen.nidn}',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.neutral500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text('NIDN: ${dosen.nidn}',
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.neutral300)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Jabatan badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: jabatanBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(dosen.jabatan,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: jabatanColor)),
            ),
          ],
        ),
      ),
    );
  }
}