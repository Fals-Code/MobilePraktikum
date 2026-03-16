import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../../../../core/theme/app_theme.dart';

class MahasiswaListTile extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback?  onTap;

  const MahasiswaListTile(
      {super.key, required this.mahasiswa, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Inisial dari name
    final initials = mahasiswa.name
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
          color:        AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(color: AppTheme.neutral100),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color:        AppTheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize:   15,
                    fontWeight: FontWeight.w700,
                    color:      AppTheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mahasiswa.name,
                    style: const TextStyle(
                      fontSize:   14,
                      fontWeight: FontWeight.w600,
                      color:      AppTheme.neutral900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mahasiswa.email,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.neutral500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mahasiswa.body,
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.neutral300),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Badge postId
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color:        AppTheme.neutral100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#${mahasiswa.id}',
                style: const TextStyle(
                  fontSize:   11,
                  fontWeight: FontWeight.w600,
                  color:      AppTheme.neutral500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}