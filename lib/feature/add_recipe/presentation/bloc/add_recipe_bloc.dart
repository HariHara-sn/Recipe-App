import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/failure.dart';
import '../../domain/models/recipe_model.dart';
import '../../domain/repositories/add_recipe_repository.dart';

part 'add_recipe_event.dart';
part 'add_recipe_state.dart';

class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  final AddRecipeRepository _repository;

  AddRecipeBloc({required AddRecipeRepository repository})
      : _repository = repository,
        super(AddRecipeInitial()) {
    on<AddRecipeSubmitted>(_onSubmitted);
    on<AddRecipeReset>(_onReset);
  }

  Future<void> _onSubmitted(
    AddRecipeSubmitted event,
    Emitter<AddRecipeState> emit,
  ) async {
    emit(AddRecipeLoading());

    try {
      // Step 1: Upload image → get hosted URL
      final imageUrl = await _repository.uploadImage(event.localImagePath);

      // Step 2: Build the recipe model with the hosted URL
      final recipe = RecipeModel(
        userId: event.userId,
        imageUrl: imageUrl,
        title: event.title,
        ingredients: event.ingredients,
        sourceLink: event.sourceLink,
        servings: event.servings,
        steps: List.generate(
          event.steps.length,
          (i) => StepModel(
            stepNumber: i + 1,
            heading: event.steps[i].heading,
            description: event.steps[i].description,
          ),
        ),
        createdAt: DateTime.now(),
      );

      // Step 3: Save to Firestore
      await _repository.saveRecipe(recipe);

      emit(AddRecipeSuccess());
    } on AddRecipeFailure catch (f) {
      emit(AddRecipeFailureState(f.message));
    } catch (e) {
      emit(AddRecipeFailureState('Unexpected error: $e'));
    }
  }

  void _onReset(AddRecipeReset event, Emitter<AddRecipeState> emit) {
    emit(AddRecipeInitial());
  }
}
