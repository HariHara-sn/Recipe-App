import 'package:flutter/material.dart';

class RecentAdditionCardTitle extends StatelessWidget {
  final TextTheme tt;

  const RecentAdditionCardTitle({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
        child: Text(
          'Recent Additions',
          style: tt.headlineMedium?.copyWith(
            color: const Color(0xFF1A1A2E),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
