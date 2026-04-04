import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/feature/add_recipe/presentation/bloc/add_recipe_bloc.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/cooking_step_field.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/field_label.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/full_with_icon_button.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/image_picker_widget.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_field_row.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_title_row.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredients_title.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/pattis_tip.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/serving_dropdown.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/styled_text_field.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/submit_button.dart';
import 'package:recepieapp/feature/home/presentation/widgets/app_bar.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../core/logging/logger.dart';
import '../../../../utils/shared/custom_snack_bar.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  File? _dishImage;
  final _titleController = TextEditingController();
  final List<IngredientRow> _ingredients = [IngredientRow()];
  final _sourceLinkController = TextEditingController();
  int _servings = 1;
  final List<StepRow> _steps = [StepRow(), StepRow()];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _dishImage = File(picked.path));
  }

  void _onSubmit() {
    // Basic validation
    if (_dishImage == null) {
      _showSnackBar('Please pick a dish image.', isSuccess: false);
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      _showSnackBar('Please enter a recipe title.', isSuccess: false);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnackBar(
        'You must be signed in to save a recipe.',
        isSuccess: false,
      );
      return;
    }

    context.read<AddRecipeBloc>().add(
      AddRecipeSubmitted(
        localImagePath: _dishImage!.path,
        title: _titleController.text.trim(),
        ingredients: _ingredients
            .where((e) => e.nameCtrl.text.trim().isNotEmpty)
            .map(
              (e) => IngredientModel(
                name: e.nameCtrl.text.trim(),
                quantity: double.tryParse(e.qtyCtrl.text.trim()) ?? 0,
                unit: e.unit,
              ),
            )
            .toList(),
        sourceLink: _sourceLinkController.text.trim(),
        servings: _servings,
        steps: _steps
            .where((e) => e.headingCtrl.text.trim().isNotEmpty)
            .toList()
            .asMap()
            .entries
            .map(
              (entry) => StepModel(
                stepNumber: entry.key + 1,
                heading: entry.value.headingCtrl.text.trim(),
                description: entry.value.descCtrl.text.trim(),
              ),
            )
            .toList(),
        userId: user.uid,
      ),
    );
  }

  void _showSnackBar(String msg, {bool isSuccess = false}) {
    CustomSnackBar.showSnackBar(
      msg,
      isSuccess ? SnackBarType.success : SnackBarType.failure,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sourceLinkController.dispose();
    for (final ing in _ingredients) {
      ing.nameCtrl.dispose();
      ing.qtyCtrl.dispose();
    }
    for (final step in _steps) {
      step.headingCtrl.dispose();
      step.descCtrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return BlocListener<AddRecipeBloc, AddRecipeState>(
      listener: (context, state) {
        if (state is AddRecipeSuccess) {
          logger.i('Recipe saved successfully');
          _showSnackBar('Recipe saved successfully! 🎉', isSuccess: true);
          context.read<AddRecipeBloc>().add(AddRecipeReset());

          setState(() {
            _dishImage = null;
            _titleController.clear();
            _sourceLinkController.clear();
            _servings = 1;

            for (var element in _ingredients) {
              element.nameCtrl.dispose();
              element.qtyCtrl.dispose();
            }
            _ingredients.clear();
            _ingredients.add(IngredientRow());

            for (var element in _steps) {
              element.headingCtrl.dispose();
              element.descCtrl.dispose();
            }
            _steps.clear();
            _steps.addAll([StepRow(), StepRow()]);
          });
        } else if (state is AddRecipeFailureState) {
          logger.e('Failed to save recipe: ${state.message}');
          _showSnackBar(state.message, isSuccess: false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.blueShade5,
        extendBody: true,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CustomAppBar(tt: tt),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                    child: Text(
                      'New Family Secret',
                      style: tt.headlineLarge?.copyWith(
                        color: AppColors.blackShadeText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Text(
                      'Preserve a new memory for the heirloom collection.',
                      style: tt.bodyMedium?.copyWith(
                        color: AppColors.blueShade3,
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blueShadeText.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImagePickerWidget(
                              image: _dishImage,
                              onTap: _pickImage,
                              tt: tt,
                            ),
                            const SizedBox(height: 24),

                            fieldLabel('RECIPE TITLE', tt),
                            const SizedBox(height: 8),
                            StyledTextField(
                              controller: _titleController,
                              hint: 'e.g., Sunday Mutton Curry',
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 24),

                            IngredientTitleRow(tt: tt),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                IngredientsTitle(
                                  tt: tt,
                                  title: 'Ingredient name',
                                  flexDigit: 4,
                                ),
                                IngredientsTitle(
                                  tt: tt,
                                  title: 'Qty',
                                  flexDigit: 2,
                                ),
                                IngredientsTitle(
                                  tt: tt,
                                  title: 'Unit',
                                  flexDigit: 3,
                                ),
                                const SizedBox(width: 28),
                              ],
                            ),
                            const SizedBox(height: 6),

                            ...List.generate(_ingredients.length, (i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: IngredientFieldRow(
                                  row: _ingredients[i],
                                  tt: tt,
                                  onDelete: _ingredients.length > 1
                                      ? () => setState(
                                          () => _ingredients.removeAt(i),
                                        )
                                      : null,
                                ),
                              );
                            }),

                            FullWidthIconButton(
                              onPressed: () => setState(
                                () => _ingredients.add(IngredientRow()),
                              ),
                              icon: Icons.add,
                              label: "Add Ingredient",
                              textStyle: tt.labelLarge?.copyWith(
                                color: AppColors.blueShadeText,
                                fontSize: 13,
                              ),
                              iconColor: AppColors.blueShadeText,
                              borderColor: AppColors.blueShade3.withOpacity(
                                0.5,
                              ),
                            ),
                            const SizedBox(height: 24),

                            fieldLabel('SOURCE LINK', tt),
                            const SizedBox(height: 8),
                            StyledTextField(
                              controller: _sourceLinkController,
                              hint: 'YouTube or Blog URL...',
                              prefixIcon: Icons.link_rounded,
                              keyboardType: TextInputType.url,
                            ),
                            const SizedBox(height: 24),

                            fieldLabel('SERVINGS', tt),
                            const SizedBox(height: 8),
                            ServingsDropdown(
                              value: _servings,
                              tt: tt,
                              onChanged: (v) => setState(() => _servings = v!),
                            ),
                            const SizedBox(height: 24),

                            fieldLabel('THE METHOD', tt),
                            const SizedBox(height: 12),

                            ...List.generate(_steps.length, (i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CookingStepField(
                                  index: i + 1,
                                  row: _steps[i],
                                  tt: tt,
                                  onDelete: _steps.length > 1
                                      ? () => setState(() => _steps.removeAt(i))
                                      : null,
                                ),
                              );
                            }),

                            FullWidthIconButton(
                              onPressed: () =>
                                  setState(() => _steps.add(StepRow())),
                              icon: Icons.add_circle_outline,
                              label: "Add Step",
                              textStyle: tt.labelLarge?.copyWith(
                                color: AppColors.blueShadeText,
                                fontSize: 13,
                              ),
                              iconColor: AppColors.blueShadeText,
                              backgroundColor: AppColors.blueShade4,
                            ),
                            const SizedBox(height: 24),

                            // Submit button — shows loader when BLoC is loading
                            BlocBuilder<AddRecipeBloc, AddRecipeState>(
                              builder: (context, state) {
                                return SubmitButton(
                                  tt: tt,
                                  isLoading: state is AddRecipeLoading,
                                  onPressed: _onSubmit,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const PattisTip(),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/// OLD VERSION WITHOUT Bloc

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:recepieapp/feature/home/presentation/widgets/app_bar.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/cooking_step_field.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/field_label.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/full_with_icon_button.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/image_picker_widget.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_field_row.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_title_row.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredients_title.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/pattis_tip.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/serving_dropdown.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/styled_text_field.dart';
// import 'package:recepieapp/feature/add_recipe/presentation/widgets/submit_button.dart';

// import '../../../../core/theme/app_colors.dart';


// class AddRecipePage extends StatefulWidget {
//   const AddRecipePage({super.key});

//   @override
//   State<AddRecipePage> createState() => _AddRecipePageState();
// }

// class _AddRecipePageState extends State<AddRecipePage> {
//   // 1. Image
//   File? _dishImage;

//   // 2. Recipe title
//   final _titleController = TextEditingController();

//   // 3. Ingredients
//   final List<IngredientRow> _ingredients = [IngredientRow()];

//   // 4. Source link
//   final _sourceLinkController = TextEditingController();

//   // 5. Servings
//   int _servings = 1;

//   // 6. Cooking steps
//   final List<StepRow> _steps = [StepRow(), StepRow()];

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) setState(() => _dishImage = File(picked.path));
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _sourceLinkController.dispose();
//     for (final ing in _ingredients) {
//       ing.nameCtrl.dispose();
//       ing.qtyCtrl.dispose();
//     }
//     for (final step in _steps) {
//       step.headingCtrl.dispose();
//       step.descCtrl.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tt = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: AppColors.blueShade5,
//       extendBody: true,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               //App bar
//               CustomAppBar(tt: tt),

//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
//                   child: Text(
//                     'New Family Secret',
//                     style: tt.headlineLarge?.copyWith(
//                       color: AppColors.blackShadeText,
//                     ),
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
//                   child: Text(
//                     'Preserve a new memory for the heirloom collection.',
//                     style: tt.bodyMedium?.copyWith(color: AppColors.blueShade3),
//                   ),
//                 ),
//               ),

//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.blueShadeText.withOpacity(0.06),
//                           blurRadius: 20,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // 1. Image picker
//                           ImagePickerWidget(
//                             image: _dishImage,
//                             onTap: _pickImage,
//                             tt: tt,
//                           ),

//                           const SizedBox(height: 24),

//                           // 2. Recipe title
//                           fieldLabel('RECIPE TITLE', tt),
//                           const SizedBox(height: 8),
//                           StyledTextField(
//                             controller: _titleController,
//                             hint: 'e.g., Sunday Mutton Curry',
//                             keyboardType: TextInputType.text,
//                           ),

//                           const SizedBox(height: 24),

//                           // 3. Ingredients
//                           IngredientTitleRow(tt: tt),

//                           const SizedBox(height: 10),

//                           Row(
//                             children: [
//                               IngredientsTitle(
//                                 tt: tt,
//                                 title: 'Ingredient name',
//                                 flexDigit: 4,
//                               ),
//                               IngredientsTitle(
//                                 tt: tt,
//                                 title: 'Qty',
//                                 flexDigit: 2,
//                               ),
//                               IngredientsTitle(
//                                 tt: tt,
//                                 title: 'Unit',
//                                 flexDigit: 3,
//                               ),

//                               const SizedBox(width: 28),
//                             ],
//                           ),
//                           const SizedBox(height: 6),

//                           ...List.generate(_ingredients.length, (i) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 8),
//                               child: IngredientFieldRow(
//                                 row: _ingredients[i],
//                                 tt: tt,
//                                 onDelete: _ingredients.length > 1
//                                     ? () => setState(
//                                         () => _ingredients.removeAt(i),
//                                       )
//                                     : null,
//                               ),
//                             );
//                           }),

//                           // Add ingredient button
//                           FullWidthIconButton(
//                             onPressed: () => setState(
//                               () => _ingredients.add(IngredientRow()),
//                             ),
//                             icon: Icons.add,
//                             label: "Add Ingredient",
//                             textStyle: tt.labelLarge?.copyWith(
//                               color: AppColors.blueShadeText,
//                               fontSize: 13,
//                             ),
//                             iconColor: AppColors.blueShadeText,
//                             borderColor: AppColors.blueShade3.withOpacity(0.5),
//                           ),

//                           const SizedBox(height: 24),

//                           fieldLabel('SOURCE LINK', tt),
//                           const SizedBox(height: 8),
//                           StyledTextField(
//                             controller: _sourceLinkController,
//                             hint: 'YouTube or Blog URL...',
//                             prefixIcon: Icons.link_rounded,
//                             keyboardType: TextInputType.url,
//                           ),

//                           const SizedBox(height: 24),

//                           fieldLabel('SERVINGS', tt),
//                           const SizedBox(height: 8),
//                           ServingsDropdown(
//                             value: _servings,
//                             tt: tt,
//                             onChanged: (v) => setState(() => _servings = v!),
//                           ),

//                           const SizedBox(height: 24),

//                           // Cooking steps
//                           fieldLabel('THE METHOD', tt),
//                           const SizedBox(height: 12),

//                           ...List.generate(_steps.length, (i) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 16),
//                               child: CookingStepField(
//                                 index: i + 1,
//                                 row: _steps[i],
//                                 tt: tt,
//                                 onDelete: _steps.length > 1
//                                     ? () => setState(() => _steps.removeAt(i))
//                                     : null,
//                               ),
//                             );
//                           }),

//                           // Add step button
//                           FullWidthIconButton(
//                             onPressed: () =>
//                                 setState(() => _steps.add(StepRow())),
//                             icon: Icons.add_circle_outline,
//                             label: "Add Step",
//                             textStyle: tt.labelLarge?.copyWith(
//                               color: AppColors.blueShadeText,
//                               fontSize: 13,
//                             ),
//                             iconColor: AppColors.blueShadeText,
//                             backgroundColor: AppColors.blueShade4,
//                           ),
//                           const SizedBox(height: 24),

//                           //Submit button
//                           SubmitButton(tt: tt),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const PattisTip(),

//               const SliverToBoxAdapter(child: SizedBox(height: 120)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
