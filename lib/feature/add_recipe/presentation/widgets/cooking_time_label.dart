import 'package:flutter/material.dart';

class CookingTimeLabel extends StatelessWidget {
  final String time;
  final VoidCallback onPress;

  const CookingTimeLabel({
    super.key,
    required this.time,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF3D3A8C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.timer_outlined,
              color: Color(0xFF3D3A8C),
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFF3D3A8C),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
