import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';
import 'package:recepieapp/feature/recipe_details/presentation/pages/recipe_detail_page.dart';
import 'package:recepieapp/feature/search_recipe/data/datasources/pantry_search_datasource.dart';
import 'package:recepieapp/feature/search_recipe/data/repositories/pantry_search_repository_impl.dart';
import 'package:recepieapp/feature/search_recipe/domain/model/match_result_model.dart';
import 'package:recepieapp/feature/search_recipe/domain/usecases/pantry_match_engine.dart';
import 'package:recepieapp/feature/search_recipe/presentation/widgets/ingredient_chip.dart';
import 'package:recepieapp/feature/search_recipe/presentation/widgets/recipe_match_card.dart';

String _capitalise(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

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

  // Wired-up architecture layers
  late final PantrySearchRepositoryImpl _repository;
  final PantryMatchEngine _matchEngine = PantryMatchEngine();

  final List<String> _pantry = [];
  bool _searched = false;

  @override
  void initState() {
    super.initState();
    _repository = PantrySearchRepositoryImpl(
      datasource: PantrySearchDatasource(),
    );
  }

  // ── Add ingredient from text field ──────────────────────────────────────────
  void _addIngredient(String raw) {
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

  // ── Remove a chip ────────────────────────────────────────────────────────────
  void _removeIngredient(String ing) {
    setState(() => _pantry.remove(ing));
  }

  // ── Run search ───────────────────────────────────────────────────────────────
  void _findRecipes() {
    if (_inputCtrl.text.trim().isNotEmpty) {
      _addIngredient(_inputCtrl.text);
    }
    FocusScope.of(context).unfocus();
    setState(() => _searched = true);
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
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4F3FB),
        body: const Center(
          child: Text('Please log in to use pantry search.'),
        ),
      );
    }

    return StreamBuilder<List<RecipeModel>>(
      stream: _repository.watchUserRecipes(user.uid),
      builder: (context, snapshot) {
        final allRecipes = snapshot.data ?? [];

        final List<MatchResult> results = _searched && _pantry.isNotEmpty
            ? _matchEngine.findMatches(_pantry, allRecipes)
            : [];

        return Scaffold(
          backgroundColor: const Color(0xFFF4F3FB),
          extendBody: true,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // ── Header bar ───────────────────────────────────────────
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

                  // ── Page heading ──────────────────────────────────────────
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
                        style: tt.bodyMedium
                            ?.copyWith(color: const Color(0xFF6B6B8A)),
                      ),
                    ),
                  ),

                  // ── Search input ──────────────────────────────────────────
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
                              color:
                                  const Color(0xFF3D3A8C).withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 14),
                            const Icon(Icons.kitchen_outlined,
                                color: Color(0xFF9090AA), size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _inputCtrl,
                                focusNode: _focusNode,
                                style: tt.bodyMedium?.copyWith(
                                    color: const Color(0xFF1A1A2E)),
                                decoration: InputDecoration(
                                  hintText: 'Enter ingredients you have...',
                                  hintStyle: tt.bodyMedium?.copyWith(
                                      color: const Color(0xFFBBBBCC)),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: _addIngredient,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_inputCtrl.text.trim().isNotEmpty) {
                                  _addIngredient(_inputCtrl.text);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
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

                  // ── Ingredient chips ──────────────────────────────────────
                  if (_pantry.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ..._pantry.map(
                              (ing) => IngredientChip(
                                label: _capitalise(ing),
                                onRemove: () => _removeIngredient(ing),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _focusNode.requestFocus(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
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

                  // ── Find Recipes button ───────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _pantry.isNotEmpty ? _findRecipes : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3D3A8C),
                            disabledBackgroundColor:
                                const Color(0xFF3D3A8C).withOpacity(0.4),
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

                  // ── Results header ────────────────────────────────────────
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
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEDFA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${results.length} RECIPES FOUND',
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

                  // ── No results ────────────────────────────────────────────
                  if (_searched && results.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: Column(
                          children: [
                            const Icon(Icons.search_off_rounded,
                                color: Color(0xFFCCCCDD), size: 64),
                            const SizedBox(height: 16),
                            Text(
                              'No matches found',
                              style: tt.titleMedium?.copyWith(
                                  color: const Color(0xFF9090AA)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adding more ingredients to your pantry list.',
                              textAlign: TextAlign.center,
                              style: tt.bodyMedium?.copyWith(
                                  color: const Color(0xFFBBBBCC)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // ── Recipe result cards ───────────────────────────────────
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final result = results[i];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeDetailPage(recipe: result.recipe),
                              ),
                            ),
                            child: RecipeMatchCard(
                              result: result,
                              onFavTap: () => setState(
                                () => result.isFavourite = !result.isFavourite,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: results.length,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
