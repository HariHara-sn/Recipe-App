import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/theme/app_images.dart';
import '../../domain/models/recipe_model.dart';
import '../failure.dart';

class AddRecipeFirebaseDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AddRecipeFirebaseDatasource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  /// Uploads the image to Cloudinary and returns the download URL.
  Future<String> uploadImage(String localImagePath) async {
    final user = _auth.currentUser;
    if (user == null) throw AddRecipeFailure.userNotAuthenticated();

    try {
      final cloudName = dotenv.env['VITE_CLOUDINARY_CLOUD_NAME'];
      final uploadPreset = dotenv.env['VITE_CLOUDINARY_UPLOAD_PRESET'];
      
      if (cloudName == null || uploadPreset == null) {
        throw Exception("Cloudinary credentials not initialized properly");
      }

      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', localImagePath));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url'] as String;
      } else {
        throw Exception("Failed to upload image to Cloudinary: ${response.statusCode}");
      }
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
      final recipesRef = _firestore.collection('users').doc(user.uid).collection('recipes');

      await recipesRef.add(recipe.toMap());
    } catch (e) {
      throw AddRecipeFailure.saveFailed(e.toString());
    }
  }
}
