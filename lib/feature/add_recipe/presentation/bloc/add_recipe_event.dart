part of 'add_recipe_bloc.dart';

abstract class AddRecipeEvent {}

/// Fired when the user taps Submit on the add recipe form
final class AddRecipeSubmitted extends AddRecipeEvent {
  final String localImagePath;   // path from image_picker
  final String title;
  final List<IngredientModel> ingredients;
  final String sourceLink;
  final int servings;
  final String cookingTime;
  final List<StepModel> steps;
  final String userId;

  AddRecipeSubmitted({
    required this.localImagePath,
    required this.title,
    required this.ingredients,
    required this.sourceLink,
    required this.servings,
    required this.cookingTime,
    required this.steps,
    required this.userId,
  });
}

/// Fired to reset the form back to initial state (e.g. after navigation)
final class AddRecipeReset extends AddRecipeEvent {}
