import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';

class MatchResult {
  final RecipeModel recipe;
  final int matchPercent;
  final List<String> matchedIngredients;
  final List<String> missingIngredients;
  bool isFavourite;

  MatchResult({
    required this.recipe,
    required this.matchPercent,
    required this.matchedIngredients,
    required this.missingIngredients,
    this.isFavourite = false,
  });
}