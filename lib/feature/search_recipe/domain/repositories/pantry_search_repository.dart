import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';

/// Abstract contract for fetching recipes for pantry search.
abstract class PantrySearchRepository {
  /// Returns a real-time stream of all recipes for the current user.
  Stream<List<RecipeModel>> watchUserRecipes(String userId);
}
