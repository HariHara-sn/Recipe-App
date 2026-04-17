import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/feature/search_recipe/data/datasources/pantry_search_datasource.dart';
import 'package:recepieapp/feature/search_recipe/domain/repositories/pantry_search_repository.dart';

class PantrySearchRepositoryImpl implements PantrySearchRepository {
  final PantrySearchDatasource _datasource;

  PantrySearchRepositoryImpl({required PantrySearchDatasource datasource})
      : _datasource = datasource;

  @override
  Stream<List<RecipeModel>> watchUserRecipes(String userId) {
    return _datasource.watchUserRecipes(userId);
  }
}
