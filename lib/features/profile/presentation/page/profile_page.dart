import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutral50,
      body: CustomScrollView(
        slivers: [
          // ── Header ───────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.white,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20, right: 20, bottom: 20,
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 84, height: 84,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(22)),
                    child: const Icon(Icons.person_rounded,
                        size: 48, color: AppTheme.primary),
                  ),
                  const SizedBox(height: 14),
                  const Text('Ahmad Mathlaul Falah',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700,
                          color: AppTheme.neutral900)),
                  const SizedBox(height: 4),
                  const Text('D4 Teknik Informatika  •  Angkatan 2024',
                      style: TextStyle(fontSize: 13, color: AppTheme.neutral500)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Badge(
                          label: 'Status: Aktif',
                          color: AppTheme.success,
                          bg: AppTheme.successLight,
                          icon: Icons.check_circle_rounded),
                      const SizedBox(width: 8),
                      _Badge(
                          label: 'Semester 4',
                          color: AppTheme.primary,
                          bg: AppTheme.primaryLight,
                          icon: Icons.book_rounded),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Quick Stats ──────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  _StatBox(label: 'IPK', value: '3.78', color: AppTheme.primary),
                  const SizedBox(width: 10),
                  _StatBox(label: 'SKS', value: '110', color: AppTheme.success),
                  const SizedBox(width: 10),
                  _StatBox(label: 'Kehadiran', value: '94%', color: AppTheme.warning),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ── Informasi Akademik ───────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel('Informasi Akademik'),
                  const SizedBox(height: 8),
                  _InfoGroup(items: const [
                    _InfoItem(icon: Icons.badge_outlined,
                        label: 'NIM', value: '434241123'),
                    _InfoItem(icon: Icons.school_outlined,
                        label: 'Program Studi', value: 'D4 Teknik Informatika'),
                    _InfoItem(icon: Icons.account_balance_outlined,
                        label: 'Fakultas', value: 'Vokasi'),
                    _InfoItem(icon: Icons.star_outline_rounded,
                        label: 'IPK Kumulatif', value: '3.78'),
                    _InfoItem(icon: Icons.book_outlined,
                        label: 'SKS Ditempuh', value: '110 / 144 SKS'),
                    _InfoItem(icon: Icons.calendar_today_outlined,
                        label: 'Tahun Masuk', value: '2024'),
                  ]),

                  const SizedBox(height: 16),
                  _SectionLabel('Kontak & Alamat'),
                  const SizedBox(height: 8),
                  _InfoGroup(items: const [
                    _InfoItem(icon: Icons.email_outlined,
                        label: 'Email', value: 'ahmad.mathlaul.falah-2024@vokasi.unair.ac.id'),
                    _InfoItem(icon: Icons.phone_outlined,
                        label: 'Telepon', value: '+62 812-3456-7890'),
                    _InfoItem(icon: Icons.location_on_outlined,
                        label: 'Alamat', value: 'Gresik, Jawa Timur'),
                  ]),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          label: 'Edit Profil',
                          icon: Icons.edit_outlined,
                          color: AppTheme.primary,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          label: 'Unduh KRS',
                          icon: Icons.download_outlined,
                          color: AppTheme.success,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text('Keluar',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.danger,
                        side: const BorderSide(color: Color(0xFFF8B4B4)),
                        backgroundColor: AppTheme.dangerLight,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Sub-widgets ──────────────────────────────

class _Badge extends StatelessWidget {
  final String label;
  final Color color, bg;
  final IconData icon;
  const _Badge({required this.label, required this.color,
    required this.bg, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: color),
      const SizedBox(width: 5),
      Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    ]),
  );
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral100),
      ),
      child: Column(children: [
        Text(value,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w800, color: color)),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: AppTheme.neutral500)),
      ]),
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) => Text(label,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700,
          color: AppTheme.neutral500, letterSpacing: 0.3));
}

class _InfoGroup extends StatelessWidget {
  final List<_InfoItem> items;
  const _InfoGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral100),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(children: [
            e.value,
            if (!isLast) const Divider(height: 1, indent: 52),
          ]);
        }).toList(),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
            color: AppTheme.neutral50,
            borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18, color: AppTheme.neutral500),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.neutral500)),
            const SizedBox(height: 1),
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500,
                    color: AppTheme.neutral900)),
          ],
        ),
      ),
    ]),
  );
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({required this.label, required this.icon,
    required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 17),
      label: Text(label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.4)),
        backgroundColor: color.withOpacity(0.06),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}