import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/theme/app_images.dart';
import '../../domain/models/recipe_model.dart';
import '../failure.dart';

class AddRecipeFirebaseDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  AddRecipeFirebaseDatasource({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Uploads the image to Firebase Storage and returns the download URL.
  /// Images are stored at: users/{userId}/recipes/{timestamp}.jpg
  Future<String> uploadImage(String localImagePath) async {
    final user = _auth.currentUser;
    if (user == null) throw AddRecipeFailure.userNotAuthenticated();

    try {
      final file = File(localImagePath);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref('users/${user.uid}/recipes/$fileName');

      final uploadTask = await ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      return NetImg.tangyRasam;
    }
  }

  /// Saves the recipe document to Firestore.
  /// Path: users/{userId}/recipes/{autoId}
  Future<void> saveRecipe(RecipeModel recipe) async {
    final user = _auth.currentUser;
    if (user == null) throw AddRecipeFailure.userNotAuthenticated();

    try {
      final recipesRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('recipes');

      await recipesRef.add(recipe.toMap());
    } catch (e) {
      throw AddRecipeFailure.saveFailed(e.toString());
    }
  }
}
