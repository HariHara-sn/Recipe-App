import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';

class PantrySearchDatasource {
  final FirebaseFirestore _firestore;

  PantrySearchDatasource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<RecipeModel>> watchUserRecipes(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => RecipeModel.fromMap(doc.id, doc.data())).toList());
  }
}
