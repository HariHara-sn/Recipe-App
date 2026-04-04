part of 'add_recipe_bloc.dart';

abstract class AddRecipeState {}

final class AddRecipeInitial extends AddRecipeState {}

/// Image is being uploaded or recipe is being saved
final class AddRecipeLoading extends AddRecipeState {}

/// Upload + save succeeded
final class AddRecipeSuccess extends AddRecipeState {}

final class AddRecipeFailureState extends AddRecipeState {
  final String message;
  AddRecipeFailureState(this.message);
}
