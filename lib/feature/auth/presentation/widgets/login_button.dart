import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final TextTheme tt;

  const LoginButton({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3D3A8C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: tt.labelLarge?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward, size: 22),
          ],
        ),
      ),
    );
  }
}
