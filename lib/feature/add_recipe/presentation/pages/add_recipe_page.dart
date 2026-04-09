import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../core/logging/logger.dart';
import '../../../../feature/add_recipe/presentation/bloc/add_recipe_bloc.dart';
import '../../../../feature/add_recipe/presentation/widgets/cooking_step_field.dart';
import '../../../../feature/add_recipe/presentation/widgets/field_label.dart';
import '../../../../feature/add_recipe/presentation/widgets/full_with_icon_button.dart';
import '../../../../feature/add_recipe/presentation/widgets/image_picker_widget.dart';
import '../../../../feature/add_recipe/presentation/widgets/ingredient_field_row.dart';
import '../../../../feature/add_recipe/presentation/widgets/ingredient_title_row.dart';
import '../../../../feature/add_recipe/presentation/widgets/ingredients_title.dart';
import '../../../../feature/add_recipe/presentation/widgets/pattis_tip.dart';
import '../../../../feature/add_recipe/presentation/widgets/serving_dropdown.dart';
import '../../../../feature/add_recipe/presentation/widgets/styled_text_field.dart';
import '../../../../feature/add_recipe/presentation/widgets/submit_button.dart';
import '../../../../feature/home/presentation/widgets/app_bar.dart';
import '../../../../utils/shared/custom_snack_bar.dart';
import '../../domain/models/ingredient_model.dart';
import '../../domain/models/step_model.dart';
import '../widgets/cooking_time_picker_sheet.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  File? _dishImage;
  final _titleController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final List<IngredientRow> _ingredients = [IngredientRow()];
  final _sourceLinkController = TextEditingController();
  int _servings = 1;
  final List<StepRow> _steps = [StepRow(), StepRow()];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _dishImage = File(picked.path));
  }

  void _showTimePicker() {
    int currentMinutes = 45;
    final text = _cookingTimeController.text;
    if (text.contains('hours')) {
      final parts = text.split(' ');
      final h = int.tryParse(parts[0]) ?? 0;
      int m = 0;
      if (parts.length > 2) {
        m = int.tryParse(parts[2]) ?? 0;
      }
      currentMinutes = (h * 60) + m;
    } else if (text.contains('mins')) {
      currentMinutes = int.tryParse(text.replaceAll(' mins', '')) ?? 45;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CookingTimePicker(
        initialTotalMinutes: currentMinutes,
        onTimeSelected: (totalMinutes) {
          setState(() {
            if (totalMinutes >= 60) {
              final h = totalMinutes ~/ 60;
              final m = totalMinutes % 60;
              _cookingTimeController.text = (m == 0)
                  ? '$h hours'
                  : '$h hours $m mins';
            } else {
              _cookingTimeController.text = '$totalMinutes mins';
            }
          });
        },
      ),
    );
  }

  // Widget cookingTimeLable(int defaultValue) {
  //   return GestureDetector(
  //     onLongPress: _showTimePicker,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //       decoration: BoxDecoration(
  //         color: const Color(0xFF3D3A8C).withOpacity(0.1),
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Icon(Icons.timer_outlined, color: Color(0xFF3D3A8C), size: 14),
  //           const SizedBox(width: 4),
  //           Text(
  //             _cookingTimeController.text.isEmpty
  //                 ? '$defaultValue mins'
  //                 : _cookingTimeController.text,
  //             style: const TextStyle(
  //               color: Color(0xFF3D3A8C),
  //               fontSize: 12,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _onSubmit() {
    if (_dishImage == null) {
      CustomSnackBar.showSnackBar(
        'Please pick a dish image.',
        SnackBarType.failure,
      );
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      CustomSnackBar.showSnackBar(
        'Please enter a recipe title.',
        SnackBarType.failure,
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      CustomSnackBar.showSnackBar(
        'You must be signed in to save a recipe.',
        SnackBarType.failure,
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
        cookingTime: _cookingTimeController.text.trim().isEmpty
            ? '45 mins'
            : _cookingTimeController.text.trim(),
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

  @override
  void dispose() {
    _titleController.dispose();
    _cookingTimeController.dispose();
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
          CustomSnackBar.showSnackBar(
            'Recipe saved successfully!',
            SnackBarType.success,
          );
          context.read<AddRecipeBloc>().add(AddRecipeReset());

          setState(() {
            _dishImage = null;
            _titleController.clear();
            _cookingTimeController.clear();
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
          CustomSnackBar.showSnackBar(state.message, SnackBarType.failure);
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

                            IngredientTitleRow(
                              tt: tt,
                              cookingTime: _cookingTimeController.text.isEmpty
                                  ? '10 mins'
                                  : _cookingTimeController.text,
                              onTimeTap: _showTimePicker,
                            ),
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
