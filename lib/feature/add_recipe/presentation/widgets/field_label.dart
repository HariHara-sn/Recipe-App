// Helper
import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

Widget fieldLabel(String text, TextTheme tt) {
  return Text(
    text,
    style: tt.bodySmall?.copyWith(
      color: AppColors.blueShade3,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.4,
    ),
  );
}

// Widget cookingTimeLable(int time) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(
//       color: const Color(0xFF3D3A8C).withOpacity(0.1),
//       borderRadius: BorderRadius.circular(6),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Icon(Icons.timer_outlined, color: Color(0xFF3D3A8C), size: 14),
//         const SizedBox(width: 4),
//         Text(
//           '$time mins',
//           style: const TextStyle(
//             color: Color(0xFF3D3A8C),
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     ),
//   );
// }
