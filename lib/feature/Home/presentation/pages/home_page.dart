import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/Theme/app_images.dart';
import 'package:recepieapp/feature/Home/domain/model/recipe_model.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/amma_tip.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/app_bar.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/app_header.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/hero_recipe_card.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/recent_addition_card.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/recent_addition_title.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/recipes_list.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/search_bar.dart';
import 'package:recepieapp/feature/Home/presentation/widgets/suggestion_header.dart';

const List<Recipe> recentRecipes = [
  Recipe(
    tag: 'AMMA',
    title: 'Mixed Veg Sa...',
    subtitle: '',
    imageUrl: NetImg.mixedVeg,
  ),
  Recipe(
    tag: 'ATHAI',
    title: 'Kushpu Idly',
    subtitle: '',
    imageUrl: NetImg.dosa,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.softlavenderWhiteBackground,
      extendBody: true, // lets content flow under the floating nav
      body: Stack(
        children: [
          // ── Scrollable content ───
          /*Hari - In Scrollable , If your parent is CustomScrollView() then the children should be SliverToBoxAdapter() */
          CustomScrollView(
            slivers: [
              // App Bar
              CustomAppBar(tt: tt),

              // Header
              AppHeader(tt: tt),

              // ── Search bar ──
              IngredientSearchBar(tt: tt),

              // ── Filter chips ───
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) {
                        final active = i == _selectedFilter;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? const Color(0xFF3D3A8C)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              _filters[i],
                              style: tt.labelLarge?.copyWith(
                                fontSize: 14,
                                color: active
                                    ? Colors.white
                                    : const Color(0xFF4A4A6A),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // ── Today's Suggestion : section ──
              TodaySuggestionHeader(tt: tt),

              // ── Hero Recipe Card ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HeroRecipeCard(tt: tt),
                ),
              ),

              // List of Recipes
              RecipesList(tt: tt),

              // Amma's Tip
              AmmaTip(tt: tt),

              // Title: Recent Additions 
              RecentAdditionCardTitle(tt:tt),

              // Recent Addition Cards
              RecentAdditionCard(tt: tt),
              
              // Bottom padding so content isn't behind nav bar
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ],
      ),
    );
  }
}