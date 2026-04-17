import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/feature/search_recipe/domain/model/match_result_model.dart';

/// Pure matching engine — no Flutter dependencies.
/// Compares the user's pantry against a list of [RecipeModel]s
/// and returns ranked [MatchResult]s.
class PantryMatchEngine {
  /// Returns matches sorted by match % descending.
  /// Only includes recipes that match at least one pantry ingredient.
  List<MatchResult> findMatches(
    List<String> pantry,
    List<RecipeModel> recipes,
  ) {
    if (pantry.isEmpty) return [];

    final normalisedPantry =
        pantry.map((e) => e.toLowerCase().trim()).toList();

    final results = <MatchResult>[];

    for (final recipe in recipes) {
      final recipeIngNames = recipe.ingredients
          .map((e) => e.name.toLowerCase().trim())
          .toList();

      final matched = recipeIngNames
          .where((ing) => normalisedPantry.contains(ing))
          .toList();
      final missing = recipeIngNames
          .where((ing) => !normalisedPantry.contains(ing))
          .toList();

      if (matched.isNotEmpty) {
        final percent =
            ((matched.length / recipeIngNames.length) * 100).round();
        results.add(
          MatchResult(
            recipe: recipe,
            matchPercent: percent,
            matchedIngredients: matched,
            missingIngredients: missing,
          ),
        );
      }
    }

    results.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    return results;
  }
}
