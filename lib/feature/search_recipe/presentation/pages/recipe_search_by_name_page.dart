import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recepieapp/feature/add_recipe/domain/models/recipe_model.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/feature/recipe_details/presentation/pages/recipe_detail_page.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

class RecipeSearchByNamePage extends StatefulWidget {
  const RecipeSearchByNamePage({super.key});

  @override
  State<RecipeSearchByNamePage> createState() => _RecipeSearchByNamePageState();
}

class _RecipeSearchByNamePageState extends State<RecipeSearchByNamePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.softlavenderWhiteBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.textMain),
        title: Text(
          'Search Recipes',
          style: tt.titleLarge?.copyWith(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: user == null
          ? const Center(child: Text('Please log in to see your recipes.'))
          : Column(
              children: [
                // Search input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.blueShade4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.search,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (v) => setState(() => _searchQuery = v),
                            autofocus: true,
                            style: tt.bodyMedium?.copyWith(
                              color: AppColors.textMain,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search by recipe name...',
                              hintStyle: tt.bodyMedium?.copyWith(
                                color: AppColors.hintLight,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Icon(Icons.close, color: AppColors.textGrey, size: 20),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Recipe List
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('recipes')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final docs = snapshot.data?.docs ?? [];
                      final allRecipes = docs.map((doc) {
                        return RecipeModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                      }).toList();

                      final filteredRecipes = _searchQuery.isEmpty
                          ? allRecipes
                          : allRecipes
                              .where((r) => r.title.toLowerCase().contains(_searchQuery.toLowerCase()))
                              .toList();

                      if (filteredRecipes.isEmpty) {
                        return Center(
                          child: Text(
                            'No recipes found.',
                            style: tt.bodyLarge?.copyWith(color: AppColors.textGrey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredRecipes.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBlue.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailPage(recipe: recipe),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(12),
                              leading: AppNetworkImage(
                                url: recipe.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(
                                recipe.title,
                                style: tt.titleMedium?.copyWith(
                                  color: AppColors.textMain,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person, size: 14, color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${recipe.servings} serves',
                                      style: tt.bodySmall?.copyWith(color: AppColors.textSecondary),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Text(
                                      recipe.cookingTime,
                                      style: tt.bodySmall?.copyWith(color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
