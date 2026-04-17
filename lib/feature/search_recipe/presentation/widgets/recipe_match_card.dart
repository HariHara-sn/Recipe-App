import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/feature/search_recipe/domain/model/match_result_model.dart';
import 'package:recepieapp/feature/search_recipe/presentation/widgets/ingredient_pill.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

String _capitalise(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// Card displaying a recipe with its match percentage and ingredient breakdown.
class RecipeMatchCard extends StatelessWidget {
  final MatchResult result;
  final VoidCallback onFavTap;

  const RecipeMatchCard({
    super.key,
    required this.result,
    required this.onFavTap,
  });

  Color get _matchColor {
    if (result.matchPercent >= 80) return AppColors.matchHigh;
    if (result.matchPercent >= 50) return AppColors.matchMedium;
    return AppColors.textGrey;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final recipe = result.recipe;
    final hasMissing = result.missingIngredients.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image / Gradient header ──────────────────────────────────────
          AppNetworkImage(
            url: recipe.imageUrl,
            width: double.infinity,
            height: 190,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            foreground: Positioned(
              top: 12,
              right: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${result.matchPercent}% MATCH',
                      style: tt.bodySmall?.copyWith(
                        color: _matchColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Card body ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + favourite
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: tt.headlineMedium?.copyWith(
                          color: AppColors.textMain,
                          fontSize: 18,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onFavTap,
                      child: Icon(
                        result.isFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: result.isFavourite
                            ? Colors.redAccent
                            : AppColors.textGrey,
                        size: 22,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Time + Servings
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: AppColors.textGrey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe.cookingTime,
                      style: tt.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.people_alt_rounded,
                      color: AppColors.textGrey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${recipe.servings} Servings',
                      style: tt.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Summary
                Text(
                  'Uses ${recipe.ingredients.length} ingredients. Tap to view & cook!',
                  style: tt.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 10),

                // Ingredient match pills
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ...result.matchedIngredients.map(
                      (ing) => IngredientPill(
                        label: _capitalise(ing),
                        matched: true,
                      ),
                    ),
                    ...result.missingIngredients.map(
                      (ing) => IngredientPill(
                        label: _capitalise(ing),
                        matched: false,
                      ),
                    ),
                  ],
                ),

                // Missing ingredients note
                if (hasMissing) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Missing: ${result.missingIngredients.map(_capitalise).join(', ')}. You can substitute or pick up from the store.',
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
