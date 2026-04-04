import '../models/recipe_model.dart';

abstract class AddRecipeRepository {
  /// Uploads a local image file and returns the hosted URL
  Future<String> uploadImage(String localImagePath);

  /// Saves the recipe to Firestore under the user's collection
  Future<void> saveRecipe(RecipeModel recipe);
}
