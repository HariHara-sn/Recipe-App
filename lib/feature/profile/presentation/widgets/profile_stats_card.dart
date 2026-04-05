import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class ProfileStatsCard extends StatelessWidget {
  final int recipesShared;
  final int cooked;
  final int saved;

  const ProfileStatsCard({
    super.key,
    required this.recipesShared,
    required this.cooked,
    required this.saved,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueShadeButtonColor.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _StatItem(value: recipesShared, label: 'RECIPESSHARED', tt: tt),
            _VerticalDivider(),
            _StatItem(value: cooked, label: 'COOKED', tt: tt),
            _VerticalDivider(),
            _StatItem(value: saved, label: 'SAVED', tt: tt),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int value;
  final String label;
  final TextTheme tt;

  const _StatItem({required this.value, required this.label, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: tt.headlineLarge?.copyWith(
              color: AppColors.blueShadeText,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: tt.bodySmall?.copyWith(
              color: AppColors.blueShade3,
              letterSpacing: 0.8,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1.5, height: 40, color: const Color(0xFFE0DEF7));
  }
}
