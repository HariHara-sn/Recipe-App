import 'package:recepieapp/feature/search_recipe/domain/model/recipe_data_model.dart';

class MatchResult {
  final RecipeData recipe;
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