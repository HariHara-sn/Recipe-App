import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recepieapp/Theme/app_colors.dart';

Widget sheetField(
  TextEditingController ctrl,
  String hint,
  TextTheme tt, {
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF4F3FB),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE0DEF7)),
    ),
    child: TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: tt.bodySmall?.copyWith(color: AppColors.hintTextColor),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
      ),
    ),
  );
}
