import 'package:flutter/material.dart';

class AmmaTip extends StatelessWidget {
  final TextTheme tt;
  const AmmaTip({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: _AmmaTipCard(tt: tt),
      ),
    );
  }
}

class _AmmaTipCard extends StatelessWidget {
  final TextTheme tt;
  const _AmmaTipCard({required this.tt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: const Border(
          left: BorderSide(color: Color(0xFF3D3A8C), width: 3.5),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFF3D3A8C),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                "Amma's Tip",
                style: tt.labelLarge?.copyWith(
                  color: const Color(0xFF3D3A8C),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '"Always roast the mustard seeds until they pop, it releases the hidden soul of the spices!"',
            style: tt.bodyMedium?.copyWith(
              color: const Color(0xFF4A4A6A),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
