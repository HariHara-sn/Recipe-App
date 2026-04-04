import '../../domain/models/recipe_model.dart';
import '../../domain/repositories/add_recipe_repository.dart';
import '../datasources/add_recipe_firebase_datasource.dart';
import '../failure.dart';

class AddRecipeRepositoryImpl implements AddRecipeRepository {
  final AddRecipeFirebaseDatasource _datasource;

  AddRecipeRepositoryImpl({required AddRecipeFirebaseDatasource datasource})
      : _datasource = datasource;

  @override
  Future<String> uploadImage(String localImagePath) async {
    try {
      return await _datasource.uploadImage(localImagePath);
    } on AddRecipeFailure {
      rethrow;
    } catch (e) {
      throw AddRecipeFailure.unknown(e.toString());
    }
  }

  @override
  Future<void> saveRecipe(RecipeModel recipe) async {
    try {
      await _datasource.saveRecipe(recipe);
    } on AddRecipeFailure {
      rethrow;
    } catch (e) {
      throw AddRecipeFailure.unknown(e.toString());
    }
  }
}
