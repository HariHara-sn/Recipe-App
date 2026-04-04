import 'ingredient_model.dart';
import 'step_model.dart';

class RecipeModel {
  final String? id;
  final String userId;
  final String imageUrl;
  final String title;
  final List<IngredientModel> ingredients;
  final String sourceLink;
  final int servings;
  final List<StepModel> steps;
  final DateTime? createdAt;

  const RecipeModel({
    this.id,
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.ingredients,
    required this.sourceLink,
    required this.servings,
    required this.steps,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'imageUrl': imageUrl,
    'title': title,
    'ingredients': ingredients.map((e) => e.toMap()).toList(),
    'sourceLink': sourceLink,
    'servings': servings,
    'steps': steps.map((e) => e.toMap()).toList(),
    'createdAt':
        createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
  };

  factory RecipeModel.fromMap(String id, Map<String, dynamic> map) =>
      RecipeModel(
        id: id,
        userId: map['userId'] as String,
        imageUrl: map['imageUrl'] as String,
        title: map['title'] as String,
        ingredients: (map['ingredients'] as List)
            .map((e) => IngredientModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        sourceLink: map['sourceLink'] as String,
        servings: map['servings'] as int,
        steps: (map['steps'] as List)
            .map((e) => StepModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        createdAt: map['createdAt'] != null
            ? DateTime.tryParse(map['createdAt'] as String)
            : null,
      );
}
