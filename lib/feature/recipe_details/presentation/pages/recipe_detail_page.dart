import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/ingredient_model.dart' as add_ing;
import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/step_model.dart' as add_step;
import 'package:recepieapp/feature/recipe_details/domain/model/cooking_steps_model.dart';
import 'package:recepieapp/feature/recipe_details/domain/model/ingredient_model.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/cooking_steps_list.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/edit_ingredients_bottomSheet.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/edit_steps_bottomSheet.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/hero_header_top.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/ingredient_title_widget.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/note_card.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/start_cooking_button.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeModel? recipe;
  const RecipeDetailPage({super.key, this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late String _tag;
  late String _title;
  late String _time;
  late String _serves;
  late String _level;
  late String _imageUrl;
  final String _personalNote =
      "This was the first dish Patti taught me when the summer tomatoes were almost too ripe to eat. The secret is never to rush the roasting.";
  final String _noteAuthor = "AMMA'S PERSONAL NOTES";

  List<IngredientItem> _ingredients = [];
  List<CookingStep> _steps = [];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.recipe != null) {
      final r = widget.recipe!;
      _tag = 'FAMILY FAVORITE';
      _title = r.title;
      _time = r.cookingTime;
      _serves = '${r.servings} People';
      _level = 'Medium';
      _imageUrl = r.imageUrl;
      _ingredients = r.ingredients
          .map((e) => IngredientItem(
                name: e.name,
                qty: e.quantity.toString(),
                unit: e.unit,
              ))
          .toList();
      _steps = r.steps
          .map((e) => CookingStep(
                heading: e.heading,
                description: e.description,
                hasTimer: e.hasTimer,
                timerMinutes: e.timerMinutes,
              ))
          .toList();
    } else {
      // Fallback/Seed data
      _tag = 'FAMILY FAVORITE';
      _title = 'Slow-Roasted Heirloom Tomato Pasta';
      _time = '45 mins';
      _serves = '4 People';
      _level = 'Easy';
      _imageUrl = '';
      _ingredients = [
        IngredientItem(name: 'Heirloom Tomatoes', qty: '500', unit: 'g'),
        IngredientItem(name: 'Extra Virgin Olive Oil', qty: '4', unit: 'tbsp'),
        IngredientItem(name: 'Fresh Basil Leaves', qty: '1', unit: 'cup'),
      ];
      _steps = [
        CookingStep(
          heading: 'Prepare & Roast',
          description:
              'Preheat your oven to 200°C. Toss the tomatoes with olive oil, crushed garlic, and a pinch of sea salt in a large roasting pan.',
          hasTimer: true,
          timerMinutes: 20,
        ),
        CookingStep(
          heading: 'The Pasta Base',
          description:
              'While tomatoes roast, boil a large pot of salted water. Cook the pasta until just before al dente. Reserve one cup of pasta water.',
        ),
      ];
    }
  }

  Future<void> _saveToFirebase() async {
    if (widget.recipe == null || widget.recipe!.id == null) return;

    setState(() => _isSaving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final updatedIngredients = _ingredients.map((e) {
        return add_ing.IngredientModel(
          name: e.name,
          quantity: double.tryParse(e.qty) ?? 0.0,
          unit: e.unit,
        );
      }).toList();

      final updatedSteps = _steps.asMap().entries.map((entry) {
        final i = entry.key;
        final s = entry.value;
        return add_step.StepModel(
          stepNumber: i + 1,
          heading: s.heading,
          description: s.description,
          hasTimer: s.hasTimer,
          timerMinutes: s.timerMinutes,
        );
      }).toList();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('recipes')
          .doc(widget.recipe!.id)
          .update({
        'ingredients': updatedIngredients.map((e) => e.toMap()).toList(),
        'steps': updatedSteps.map((e) => e.toMap()).toList(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update recipe: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // Open ingredient edit bottom sheet
  void _openEditIngredients() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => EditIngredientsSheet(
        ingredients: List.from(
          _ingredients.map(
            (e) => IngredientItem(
              name: e.name,
              qty: e.qty,
              unit: e.unit,
            ),
          ),
        ),
        onSave: (updated) {
          setState(() => _ingredients = updated);
          _saveToFirebase();
        },
      ),
    );
  }

  // Open cooking steps edit bottom sheet
  void _openEditSteps() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditStepsSheet(
        steps: List.from(
          _steps.map(
            (e) => CookingStep(
              heading: e.heading,
              description: e.description,
              hasTimer: e.hasTimer,
              timerMinutes: e.timerMinutes,
            ),
          ),
        ),
        onSave: (updated) {
          setState(() => _steps = updated);
          _saveToFirebase();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF3D3A8C),
              size: 16,
            ),
          ),
        ),
        title: Text(
          "Amma's Notebook",
          style: tt.titleMedium?.copyWith(
            color: const Color(0xFF3D3A8C),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: SizedBox(
                      width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
            ),
          const Padding(padding: EdgeInsets.only(right: 12), child: UserAvatar()),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // background header
                HeroHeader(
                  tag: _tag,
                  title: _title,
                  time: _time,
                  serves: _serves,
                  level: _level,
                  imageUrl: _imageUrl,
                  tt: tt,
                ),

                const SizedBox(height: 20),

                // Personal notes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: NoteCard(
                    note: _personalNote,
                    author: _noteAuthor,
                    tt: tt,
                  ),
                ),

                const SizedBox(height: 28),

                // ── Ingredients section ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ingredients',
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openEditIngredients,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_basket_outlined,
                              color: Color(0xFF3D3A8C),
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Edit list',
                              style: tt.bodyMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                ...List.generate(_ingredients.length, (i) {
                  final ing = _ingredients[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: IngredientTile(
                      index: i + 1,
                      ingredient: ing,
                      tt: tt,
                    ),
                  );
                }),

                const SizedBox(height: 28),

                // ── Cooking Steps section ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cooking Steps',
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openEditSteps,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF3D3A8C),
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Edit steps',
                              style: tt.bodyMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CookingStepsList(steps: _steps, tt: tt),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // ── Start Cooking sticky button
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: StartCookingButton(tt: tt),
          ),
        ],
      ),
    );
  }
}
