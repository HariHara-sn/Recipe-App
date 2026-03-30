import 'package:flutter/material.dart';
import 'package:recepieapp/feature/RecipeDetailPage/domain/model/ingredient_model.dart';

class IngredientTile extends StatelessWidget {
  final int index;
  final IngredientItem ingredient;
  final TextTheme tt;

  const IngredientTile({super.key, 
    required this.index,
    required this.ingredient,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$index',
                style: tt.bodyMedium?.copyWith(
                  color: const Color(0xFF3D3A8C),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (ingredient.subtitle.isNotEmpty)
                  Text(
                    ingredient.subtitle,
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF9090AA),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '${ingredient.qty} ${ingredient.unit}',
            style: tt.bodyMedium?.copyWith(
              color: const Color(0xFF3D3A8C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
