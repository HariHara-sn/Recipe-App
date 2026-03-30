import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/field_label.dart';

class IngredientTitleRow extends StatelessWidget {
  final TextTheme tt;
  const IngredientTitleRow({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        fieldLabel('INGREDIENTS', tt),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.blueShadeText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.mic_rounded, color: Colors.white, size: 16),
        ),
      ],
    );
  }
}
