import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final TextTheme tt;
  const AppHeader({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Text(
          'What shall we\ncook today?',
          style: tt.headlineLarge?.copyWith(
            color: const Color(0xFF1A1A2E),
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
