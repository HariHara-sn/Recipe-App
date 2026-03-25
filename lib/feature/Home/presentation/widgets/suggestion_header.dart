import 'package:flutter/material.dart';

class TodaySuggestionHeader extends StatelessWidget {
  final TextTheme tt;
  const TodaySuggestionHeader({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's Suggestion",
              style: tt.headlineMedium?.copyWith(
                color: const Color(0xFF1A1A2E),
                fontSize: 20,
              ),
            ),
            Text(
              'View Archive',
              style: tt.bodyMedium?.copyWith(
                color: const Color(0xFF3D3A8C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
