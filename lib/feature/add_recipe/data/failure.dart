class AddRecipeFailure {
  final String message;
  const AddRecipeFailure(this.message);

  factory AddRecipeFailure.imageUploadFailed(String details) => AddRecipeFailure('Image upload failed: $details');

  factory AddRecipeFailure.saveFailed(String details) => AddRecipeFailure('Failed to save recipe: $details');

  factory AddRecipeFailure.userNotAuthenticated() => const AddRecipeFailure('User is not authenticated.');

  factory AddRecipeFailure.unknown(String details) => AddRecipeFailure('Unexpected error: $details');
  
  @override
  String toString() => message;
}
