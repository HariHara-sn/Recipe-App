import 'package:flutter/material.dart';
import 'package:recepieapp/utils/constants/app_colors.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;

  const StyledTextField({super.key, 
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueShade5,
        border: Border.all(color: AppColors.blueShade4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: tt.headlineSmall?.copyWith(
          color: AppColors.blackShadeText,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: tt.bodyMedium?.copyWith(
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.bold,
          ),

          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: const Color(0xFF9090AA), size: 18)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

