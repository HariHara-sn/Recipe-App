import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

/// A small pill showing whether an ingredient was matched (green) or missing (grey strikethrough).
class IngredientPill extends StatelessWidget {
  final String label;
  final bool matched;

  const IngredientPill({
    super.key,
    required this.label,
    required this.matched,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: matched ? AppColors.matchHighBg : AppColors.matchMissingBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: matched ? AppColors.matchHighIcon : AppColors.matchMissingIcon,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            matched
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: matched
                ? AppColors.matchHighBorder
                : AppColors.matchMissingBorder,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: tt.bodySmall?.copyWith(
              color: matched
                  ? AppColors.matchHigh
                  : AppColors.textGrey,
              fontWeight: FontWeight.w600,
              decoration: matched ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
