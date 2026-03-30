import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/app_bar.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/cooking_step_field.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/field_label.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/image_picker_widget.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_field_row.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredient_title_row.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/ingredients_title.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/pattis_tip.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/serving_dropdown.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/styled_text_field.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/submit_button.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // 1. Image
  File? _dishImage;

  // 2. Recipe title
  final _titleController = TextEditingController();

  // 3. Ingredients
  final List<IngredientRow> _ingredients = [IngredientRow()];

  // 4. Source link
  final _sourceLinkController = TextEditingController();

  // 5. Servings
  int _servings = 1;

  // 6. Cooking steps
  final List<StepRow> _steps = [StepRow(), StepRow()];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _dishImage = File(picked.path));
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

    return Scaffold(
      backgroundColor: AppColors.blueShade5,
      extendBody: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              //App bar
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
                    style: tt.bodyMedium?.copyWith(color: AppColors.blueShade3),
                  ),
                ),
              ),

              // ── White card ────────────────────────────────────────────────
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
                          // 1. Image picker
                          ImagePickerWidget(
                            image: _dishImage,
                            onTap: _pickImage,
                            tt: tt,
                          ),

                          const SizedBox(height: 24),

                          // 2. Recipe title
                          fieldLabel('RECIPE TITLE', tt),
                          const SizedBox(height: 8),
                          StyledTextField(
                            controller: _titleController,
                            hint: 'e.g., Sunday Mutton Curry',
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 24),

                          // 3. Ingredients
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

                          // Add ingredient button
                          GestureDetector(
                            onTap: () => setState(
                              () => _ingredients.add(IngredientRow()),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                    0xFF3D3A8C,
                                  ).withOpacity(0.3),
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: AppColors.blueShadeText,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Add Ingredient',
                                    style: tt.labelLarge?.copyWith(
                                      color: AppColors.blueShadeText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── 4. Source link ────────────────────────────────
                          fieldLabel('SOURCE LINK', tt),
                          const SizedBox(height: 8),
                          StyledTextField(
                            controller: _sourceLinkController,
                            hint: 'YouTube or Blog URL...',
                            prefixIcon: Icons.link_rounded,
                            keyboardType: TextInputType.url,
                          ),

                          const SizedBox(height: 24),

                          //5. Servings
                          fieldLabel('SERVINGS', tt),
                          const SizedBox(height: 8),
                          ServingsDropdown(
                            value: _servings,
                            tt: tt,
                            onChanged: (v) => setState(() => _servings = v!),
                          ),

                          const SizedBox(height: 24),

                          // ── 6. Cooking steps ──────────────────────────────
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

                          // Add step button
                          GestureDetector(
                            onTap: () => setState(() => _steps.add(StepRow())),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEDFA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: AppColors.blueShadeText,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Add Step',
                                    style: tt.labelLarge?.copyWith(
                                      color: AppColors.blueShadeText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          //Submit button
                          SubmitButton(tt: tt),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Patti's tip
              const PattisTip(),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ],
      ),
    );
  }
}
