import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  final TextTheme tt;

  const GuestButton({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8E7F5),
                      foregroundColor: const Color(0xFF3D3A8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue as Guest',
                      style: tt.labelLarge?.copyWith(
                        color: const Color(0xFF3D3A8C),
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
  }
}