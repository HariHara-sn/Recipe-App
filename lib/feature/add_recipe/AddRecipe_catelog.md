DataBase Structure Schema for Add Recipe Feature:
1. Dish Image (hosted url - string)
2. Name of the dish (recipe title) (string)
3. Ingredients
        i. ingredient name (string)
        ii. quantity (float)
        iii. unit of measurement (string)
4. source link (string)
5. servings (integer)
6. preparation steps method
    (1)    i. Heading (string)
           ii. Description (string)
    (2)    i. Heading (string)
           ii. Description (string)


## Project Structure
lib/feature/add_recipe/
├── add_recipe_provider.dart          ← DI: wires repo + bloc + page
├── data/
│   ├── failure.dart                  ← typed error class
│   ├── datasources/
│   │   └── add_recipe_firebase_datasource.dart  ← Firebase Storage + Firestore
│   └── repositories/
│       └── add_recipe_repository_impl.dart      ← implements domain repo
├── domain/
│   ├── models/
│   │   └── recipe_model.dart         ← RecipeModel, IngredientModel, StepModel
│   └── repositories/
│       └── add_recipe_repository.dart           ← abstract contract
└── presentation/
    ├── bloc/
    │   ├── add_recipe_bloc.dart
    │   ├── add_recipe_event.dart     ← AddRecipeSubmitted, AddRecipeReset
    │   └── add_recipe_state.dart     ← Initial, Loading, Success, Failure
    └── pages/
        └── add_recipe_page.dart      ← your existing UI, now BLoC-wired