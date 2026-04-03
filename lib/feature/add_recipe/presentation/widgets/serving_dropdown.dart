import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ServingsDropdown extends StatelessWidget {
  final int value;
  final TextTheme tt;
  final ValueChanged<int?> onChanged;

  const ServingsDropdown({
    super.key,
    required this.value,
    required this.tt,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blueShade5,
        border: Border.all(color: AppColors.blueShade4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          dropdownColor: AppColors.white,
          value: value,
          isExpanded: true,
          style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
          icon: const Icon(
            Icons.expand_more_rounded,
            color: AppColors.blueShadeText,
            size: 20,
          ),
          items: List.generate(
            7,
            (i) => DropdownMenuItem(
              value: i + 1,
              child: Text(
                i + 1 == 1 ? '1 person' : '${i + 1} people',
                style: tt.bodyMedium?.copyWith(color: AppColors.blackShadeText),
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
