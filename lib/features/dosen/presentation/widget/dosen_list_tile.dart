import 'package:flutter/material.dart';
import '../../data/models/dosen_model.dart';
import '../../../../../core/theme/app_theme.dart';

class DosenListTile extends StatelessWidget {
  final DosenModel    dosen;
  final VoidCallback? onTap;

  const DosenListTile({super.key, required this.dosen, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Ambil inisial dari name
    final initials = dosen.name
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
              width: 48, height: 48,
              decoration: BoxDecoration(
                color:        AppTheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize:   16,
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
                    dosen.name,
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
                    '@${dosen.username}',
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.neutral500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dosen.email,
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.neutral300),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${dosen.address.street}, ${dosen.address.city}',
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.neutral300),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Badge ID
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:        AppTheme.primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#${dosen.id}',
                style: const TextStyle(
                  fontSize:   10,
                  fontWeight: FontWeight.w700,
                  color:      AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}