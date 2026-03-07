import 'package:flutter/material.dart';
import '../../data/models/dosen_model.dart';
import '../../../../../core/theme/app_theme.dart';

const _jabatanColors = <String, Color>{
  'Guru Besar':    AppTheme.purple,
  'Lektor Kepala': AppTheme.warning,
  'Dosen Tetap':   AppTheme.primary,
};
const _jabatanBgs = <String, Color>{
  'Guru Besar':    AppTheme.purpleLight,
  'Lektor Kepala': AppTheme.warningLight,
  'Dosen Tetap':   AppTheme.primaryLight,
};

class DosenListTile extends StatelessWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;

  const DosenListTile({super.key, required this.dosen, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = _jabatanColors[dosen.jabatan] ?? AppTheme.primary;
    final bg    = _jabatanBgs[dosen.jabatan]    ?? AppTheme.primaryLight;

    // Build clean initials: strip titles, take first 2 words
    final initials = dosen.nama
        .replaceAll(
        RegExp(r'\b(Dr|Prof|S\.Kom|M\.Kom|S\.T|M\.T|M\.Sc|Ph\.D|M\.Cs)\b\.?',
            caseSensitive: false), '')
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join()
        .toUpperCase();

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
              width: 48, height: 48,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(initials,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: color)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dosen.nama,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600,
                          color: AppTheme.neutral900),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(dosen.bidangKeahlian.isNotEmpty
                      ? dosen.bidangKeahlian : 'NIDN: ${dosen.nidn}',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.neutral500),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text('NIDN: ${dosen.nidn}',
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.neutral300)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: bg, borderRadius: BorderRadius.circular(6)),
              child: Text(dosen.jabatan,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700, color: color)),
            ),
          ],
        ),
      ),
    );
  }
}