import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recepieapp/feature/search_recipe/domain/model/match_result_model.dart';
import 'package:recepieapp/feature/search_recipe/domain/model/recipe_data_model.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';

const List<RecipeData> kRecipeDatabase = [
  RecipeData(
    id: '1',
    title: 'Spiced Potato & Tomato Stir-fry',
    author: 'AMMA',
    ingredients: ['potato', 'tomato', 'onion', 'cumin', 'oil'],
    time: '20m',
    level: 'Easy',
    description:
        'A classic heirloom comfort dish that uses your exact pantry staples with simple spices.',
    ammaTip: '"Cumin seeds in the oil first makes the potatoes sing!"',
    imageUrl:
        'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&q=80',
  ),
  RecipeData(
    id: '2',
    title: 'Rustic Onion & Tomato Broth',
    author: 'PATTI',
    ingredients: ['onion', 'tomato', 'garlic', 'fresh basil'],
    time: '35m',
    level: 'Medium',
    description:
        'A slow-simmered broth bursting with caramelised onion and ripe tomatoes.',
    imageUrl:
        'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&q=80',
  ),
  RecipeData(
    id: '3',
    title: 'Egg Fried Rice',
    author: 'ATHAI',
    ingredients: ['egg', 'rice', 'onion', 'soy sauce', 'oil'],
    time: '15m',
    level: 'Easy',
    description:
        'Quick weeknight egg fried rice with crispy bits and fluffy grains.',
    ammaTip: '"High flame and cold rice is the secret to restaurant texture!"',
    imageUrl:
        'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&q=80',
  ),
  RecipeData(
    id: '4',
    title: 'Sambar',
    author: 'AMMA',
    ingredients: ['lentils', 'potato', 'onion', 'tomato', 'tamarind', 'oil'],
    time: '40m',
    level: 'Medium',
    description:
        'The soul of South Indian cooking — a tangy, spiced lentil stew.',
    ammaTip: '"Never skip the tamarind — it is what ties everything together."',
    imageUrl:
        'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=800&q=80',
  ),
  RecipeData(
    id: '5',
    title: 'Tomato Soup',
    author: 'PATTI',
    ingredients: ['tomato', 'garlic', 'butter', 'cream'],
    time: '25m',
    level: 'Easy',
    description: 'Velvety roasted tomato soup with a whisper of cream.',
    imageUrl:
        'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&q=80',
  ),
  RecipeData(
    id: '6',
    title: 'Potato Egg Bhurji',
    author: 'AMMA',
    ingredients: ['potato', 'egg', 'onion', 'tomato', 'oil', 'chilli'],
    time: '18m',
    level: 'Easy',
    description:
        'Scrambled spiced eggs tossed with crisp potato and onion — breakfast royalty.',
    ammaTip: '"Add a pinch of turmeric for colour and warmth."',
    imageUrl:
        'https://images.unsplash.com/photo-1510693206972-df098062cb71?w=800&q=80',
  ),
  RecipeData(
    id: '7',
    title: 'Carrot Halwa',
    author: 'PATTI',
    ingredients: ['carrot', 'milk', 'sugar', 'ghee', 'cardamom'],
    time: '50m',
    level: 'Medium',
    description:
        'Slow-cooked shredded carrot in sweetened milk — a festive family favourite.',
    imageUrl:
        'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&q=80',
  ),
  RecipeData(
    id: '8',
    title: 'Rice Porridge (Kanji)',
    author: 'AMMA',
    ingredients: ['rice', 'water', 'salt', 'ginger'],
    time: '30m',
    level: 'Easy',
    description:
        'Simple, healing rice porridge — Amma\'s remedy for any rainy day.',
    imageUrl:
        'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&q=80',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// MATCHING ENGINE
// ─────────────────────────────────────────────────────────────────────────────
List<MatchResult> findMatches(List<String> pantry) {
  if (pantry.isEmpty) return [];

  final normalised = pantry.map((e) => e.toLowerCase().trim()).toList();

  final results = <MatchResult>[];

  for (final recipe in kRecipeDatabase) {
    final recipeIngs = recipe.ingredients; // already lowercase
    final matched = recipeIngs
        .where((ing) => normalised.contains(ing))
        .toList();
    final missing = recipeIngs
        .where((ing) => !normalised.contains(ing))
        .toList();

    final percent = ((matched.length / recipeIngs.length) * 100).round();

    // Only show recipes with at least 1 matching ingredient
    if (matched.isNotEmpty) {
      results.add(
        MatchResult(
          recipe: recipe,
          matchPercent: percent,
          matchedIngredients: matched,
          missingIngredients: missing,
        ),
      );
    }
  }

  // Sort descending by match %
  results.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
  return results;
}

// ─────────────────────────────────────────────────────────────────────────────
// PANTRY SEARCH PAGE
// ─────────────────────────────────────────────────────────────────────────────
class PantrySearchPage extends StatefulWidget {
  const PantrySearchPage({super.key});

  @override
  State<PantrySearchPage> createState() => _PantrySearchPageState();
}

class _PantrySearchPageState extends State<PantrySearchPage> {
  final TextEditingController _inputCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _pantry = [];
  List<MatchResult> _results = [];
  bool _searched = false;

  // ── Add ingredient from text field ─────────────────────────────────────────
  void _addIngredient(String raw) {
    // Support comma-separated entry like "rice, egg, onion"
    final parts = raw.split(',');
    for (final part in parts) {
      final clean = part.trim().toLowerCase();
      if (clean.isNotEmpty && !_pantry.contains(clean)) {
        _pantry.add(clean);
      }
    }
    _inputCtrl.clear();
    setState(() {});
  }

  // ── Remove a chip ───────────────────────────────────────────────────────────
  void _removeIngredient(String ing) {
    setState(() => _pantry.remove(ing));
  }

  // ── Run search ──────────────────────────────────────────────────────────────
  void _findRecipes() {
    // Add any pending text first
    if (_inputCtrl.text.trim().isNotEmpty) {
      _addIngredient(_inputCtrl.text);
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _results = findMatches(_pantry);
      _searched = true;
    });
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FB),
      extendBody: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App bar 
              // CustomAppBar(tt: tt),
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.menu_book_rounded,
                              color: Color(0xFF3D3A8C),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Amma's Notebook",
                              style: tt.titleMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const UserAvatar(),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Page heading ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                  child: Text(
                    'Pantry Search',
                    style: tt.headlineLarge?.copyWith(
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Text(
                    "Tell Amma what's in your kitchen, and she'll tell you what to cook.",
                    style: tt.bodyMedium?.copyWith(
                      color: const Color(0xFF6B6B8A),
                    ),
                  ),
                ),
              ),

              // ── Search input ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0DEF7)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D3A8C).withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.kitchen_outlined,
                          color: Color(0xFF9090AA),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _inputCtrl,
                            focusNode: _focusNode,
                            style: tt.bodyMedium?.copyWith(
                              color: const Color(0xFF1A1A2E),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter ingredients you have...',
                              hintStyle: tt.bodyMedium?.copyWith(
                                color: const Color(0xFFBBBBCC),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: _addIngredient,
                          ),
                        ),
                        // Quick add button
                        GestureDetector(
                          onTap: () {
                            if (_inputCtrl.text.trim().isNotEmpty) {
                              _addIngredient(_inputCtrl.text);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEEDFA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Add',
                              style: tt.labelLarge?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Ingredient chips ──────────────────────────────────────────
              if (_pantry.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._pantry.map(
                          (ing) => _IngredientChip(
                            label: _capitalise(ing),
                            onRemove: () => _removeIngredient(ing),
                            tt: tt,
                          ),
                        ),
                        // + Add more chip
                        GestureDetector(
                          onTap: () => _focusNode.requestFocus(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFFDDDCF0),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              '+ Add more',
                              style: tt.bodySmall?.copyWith(
                                color: const Color(0xFF6B6B8A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Find Recipes button ───────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _pantry.isNotEmpty ? _findRecipes : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D3A8C),
                        disabledBackgroundColor: const Color(
                          0xFF3D3A8C,
                        ).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Find Recipes',
                        style: tt.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ── Results header ────────────────────────────────────────────
              if (_searched)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Top Matches',
                          style: tt.headlineMedium?.copyWith(
                            color: const Color(0xFF1A1A2E),
                            fontSize: 22,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEDFA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_results.length} RECIPES FOUND',
                            style: tt.bodySmall?.copyWith(
                              color: const Color(0xFF3D3A8C),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── No results ────────────────────────────────────────────────
              if (_searched && _results.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          color: Color(0xFFCCCCDD),
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No matches found',
                          style: tt.titleMedium?.copyWith(
                            color: const Color(0xFF9090AA),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adding more ingredients to your pantry list.',
                          textAlign: TextAlign.center,
                          style: tt.bodyMedium?.copyWith(
                            color: const Color(0xFFBBBBCC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Recipe result cards ───────────────────────────────────────
              SliverList(
                delegate: SliverChildBuilderDelegate((_, i) {
                  final result = _results[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: _RecipeMatchCard(
                      result: result,
                      tt: tt,
                      onFavTap: () => setState(
                        () => result.isFavourite = !result.isFavourite,
                      ),
                    ),
                  );
                }, childCount: _results.length),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INGREDIENT CHIP
// ─────────────────────────────────────────────────────────────────────────────
class _IngredientChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  final TextTheme tt;

  const _IngredientChip({
    required this.label,
    required this.onRemove,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3A8C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: tt.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RECIPE MATCH CARD
// ─────────────────────────────────────────────────────────────────────────────
class _RecipeMatchCard extends StatelessWidget {
  final MatchResult result;
  final TextTheme tt;
  final VoidCallback onFavTap;

  const _RecipeMatchCard({
    required this.result,
    required this.tt,
    required this.onFavTap,
  });

  Color get _matchColor {
    if (result.matchPercent >= 80) return const Color(0xFF2E7D32);
    if (result.matchPercent >= 50) return const Color(0xFFE65100);
    return const Color(0xFF9090AA);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = result.recipe;
    final hasMissing = result.missingIngredients.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with match badge ────────────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.network(
                  recipe.imageUrl,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          height: 190,
                          color: const Color(0xFFEEEDFA),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF3D3A8C),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                ),
                // Match badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${result.matchPercent}% MATCH',
                          style: tt.bodySmall?.copyWith(
                            color: _matchColor,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Card body ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + fav
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                          fontSize: 18,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onFavTap,
                      child: Icon(
                        result.isFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: result.isFavourite
                            ? Colors.redAccent
                            : const Color(0xFF9090AA),
                        size: 22,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Time + level
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Color(0xFF9090AA),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe.time,
                      style: tt.bodySmall?.copyWith(
                        color: const Color(0xFF6B6B8A),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.bar_chart_rounded,
                      color: Color(0xFF9090AA),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      recipe.level,
                      style: tt.bodySmall?.copyWith(
                        color: const Color(0xFF6B6B8A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Description
                Text(
                  recipe.description,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF6B6B8A),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 10),

                // Matched ingredient pills
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ...result.matchedIngredients.map(
                      (ing) => _IngPill(
                        label: _capitalise(ing),
                        matched: true,
                        tt: tt,
                      ),
                    ),
                    ...result.missingIngredients.map(
                      (ing) => _IngPill(
                        label: _capitalise(ing),
                        matched: false,
                        tt: tt,
                      ),
                    ),
                  ],
                ),

                // Missing info
                if (hasMissing) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Missing: ${result.missingIngredients.map(_capitalise).join(', ')}. You can substitute or pick up from the store.',
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF9090AA),
                      height: 1.5,
                    ),
                  ),
                ],

                // Amma's tip
                if (recipe.ammaTip != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EFF9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AMMA'S TIP",
                          style: tt.bodySmall?.copyWith(
                            color: const Color(0xFF3D3A8C),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.ammaTip!,
                          style: tt.bodySmall?.copyWith(
                            color: const Color(0xFF4A4A6A),
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INGREDIENT PILL (matched = green, missing = grey strikethrough)
// ─────────────────────────────────────────────────────────────────────────────
class _IngPill extends StatelessWidget {
  final String label;
  final bool matched;
  final TextTheme tt;

  const _IngPill({
    required this.label,
    required this.matched,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: matched ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: matched ? const Color(0xFF81C784) : const Color(0xFFDDDDDD),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            matched
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: matched ? const Color(0xFF388E3C) : const Color(0xFFBBBBBB),
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: tt.bodySmall?.copyWith(
              color: matched
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF9090AA),
              fontWeight: FontWeight.w600,
              decoration: matched ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER
// ─────────────────────────────────────────────────────────────────────────────
String _capitalise(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);