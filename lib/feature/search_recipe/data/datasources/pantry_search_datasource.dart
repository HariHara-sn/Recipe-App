import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';

/// Firestore data source for reading user recipes.
class PantrySearchDatasource {
  final FirebaseFirestore _firestore;

  PantrySearchDatasource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Streams a list of [RecipeModel] for the given [userId] in real-time.
  Stream<List<RecipeModel>> watchUserRecipes(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => RecipeModel.fromMap(doc.id, doc.data()))
            .toList());
  }
}
