import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  final TextTheme tt;
  const LoginFooter({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.favorite_border_rounded,
          size: 14,
          color: Color(0xFF9B98C8),
        ),
        const SizedBox(width: 6),
        Text(
          'ESTABLISHED IN THE HEART',
          style: tt.bodySmall?.copyWith(
            color: const Color(0xFF9B98C8),
            letterSpacing: 1.8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
