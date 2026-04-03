import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
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
  const RecipeDetailPage({super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  // Sample data — replace with actual model from navigation args
  final String _tag = 'FAMILY FAVORITE';
  final String _title = 'Slow-Roasted Heirloom Tomato Pasta';
  final String _time = '45 mins';
  final String _serves = '4 People';
  final String _level = 'Easy';
  final String _personalNote =
      "This was the first dish Patti taught me when the summer tomatoes were almost too ripe to eat. The secret is never to rush the roasting.";
  final String _noteAuthor = "AMMA'S PERSONAL NOTES";

  List<IngredientItem> _ingredients = [
    IngredientItem(name: 'Heirloom Tomatoes', qty: '500', unit: 'g'),
    IngredientItem(
      name: 'Extra Virgin Olive Oil',
      subtitle: 'Cold pressed preferred',
      qty: '4',
      unit: 'tbsp',
    ),
    IngredientItem(
      name: 'Fresh Basil Leaves',
      subtitle: 'Torn by hand',
      qty: '1',
      unit: 'cup',
    ),
  ];

  List<CookingStep> _steps = [
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
    CookingStep(
      heading: 'Combine & Emulsify',
      description:
          'Fold the roasted tomatoes into the pasta. Add reserved water and basil. Stir vigorously until a glossy sauce forms.',
    ),
  ];

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
              subtitle: e.subtitle,
              qty: e.qty,
              unit: e.unit,
            ),
          ),
        ),
        onSave: (updated) => setState(() => _ingredients = updated),
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
        onSave: (updated) => setState(() => _steps = updated),
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
          onTap: () => Navigator.maybePop(context),
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
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: UserAvatar()),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero header
                HeroHeader(
                  tag: _tag,
                  title: _title,
                  time: _time,
                  serves: _serves,
                  level: _level,
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
