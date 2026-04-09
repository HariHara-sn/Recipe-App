import 'package:flutter/material.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/field_label.dart';
import 'cooking_time_label.dart';

class IngredientTitleRow extends StatelessWidget {
  final TextTheme tt;
  final String cookingTime;
  final VoidCallback onTimeTap;

  const IngredientTitleRow({
    super.key,
    required this.tt,
    required this.cookingTime,
    required this.onTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        fieldLabel('INGREDIENTS', tt),
        CookingTimeLabel(
          time: cookingTime,
          onPress: onTimeTap,
        ),
      ],
    );
  }
}

