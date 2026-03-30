// Helper
import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';

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
