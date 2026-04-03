import 'package:flutter/material.dart';
import 'package:recepieapp/utils/constants/Theme/app_colors.dart';

/// Model (move later to models/ if needed)
class StepRow {
  final TextEditingController headingCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
}
class CookingStepField extends StatelessWidget {
  final int index;
  final StepRow row;
  final TextTheme tt;
  final VoidCallback? onDelete;

  const CookingStepField({super.key, 
    required this.index,
    required this.row,
    required this.tt,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step number bubble
        Container(
          width: 26,
          height: 26,
          margin: const EdgeInsets.only(top: 12, right: 10),
          decoration: const BoxDecoration(
            color: AppColors.blueShadeText,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$index',
              style: tt.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // Fields
        Expanded(
          child: Column(
            children: [
              // Heading
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: const AppColors.blueShade5
                  color: AppColors.blueShade5,
                  border: Border.all(color: AppColors.blueShade4),
                ),
                child: TextField(
                  controller: row.headingCtrl,
                  style: tt.headlineSmall?.copyWith(
                    color: AppColors.blackShadeText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Heading: e.g., Prepare the Fish',
                    hintStyle: tt.bodyMedium?.copyWith(
                      color: AppColors.hintTextColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Description
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blueShade5,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blueShade4),
                ),
                child: TextField(
                  controller: row.descCtrl,
                  maxLines: 3,
                  style: tt.bodyMedium?.copyWith(
                    color: AppColors.blackShadeText,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Description: e.g., Clean the fish thoroughly...',
                    hintStyle: tt.bodySmall?.copyWith(
                      color: AppColors.hintTextColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Delete step
        if (onDelete != null)
          GestureDetector(
            onTap: onDelete,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 6),
              child: const Icon(
                Icons.remove_circle_outline,
                size: 20,
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
  }
}
