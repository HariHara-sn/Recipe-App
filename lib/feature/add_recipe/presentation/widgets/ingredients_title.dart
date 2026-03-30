import 'package:flutter/material.dart';

class IngredientsTitle extends StatelessWidget {
  final TextTheme tt;
  final String title;
  final int flexDigit;
  
  const IngredientsTitle({super.key, required this.tt, required this.title, required this.flexDigit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexDigit,
      child: Text(
        title,
        style: tt.bodySmall?.copyWith(
          color: const Color(0xFF9090AA),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
