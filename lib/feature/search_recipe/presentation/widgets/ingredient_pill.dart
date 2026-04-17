import 'package:flutter/material.dart';

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
        color: matched ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: matched ? const Color(0xFF81C784) : const Color(0xFFDDDDDD),
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
                ? const Color(0xFF388E3C)
                : const Color(0xFFBBBBBB),
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: tt.bodySmall?.copyWith(
              color: matched
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF9090AA),
              fontWeight: FontWeight.w600,
              decoration: matched ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
