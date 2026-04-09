import 'package:flutter/material.dart';
import 'package:recepieapp/feature/search_recipe/presentation/pages/recipe_search_by_name_page.dart';

class IngredientSearchBar extends StatelessWidget {
  final TextTheme tt;
  const IngredientSearchBar({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecipeSearchByNamePage()),
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                const Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search recipes...',
                    style: tt.bodyMedium?.copyWith(
                      color: const Color(0xFFAAAAAA),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
