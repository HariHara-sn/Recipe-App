// DATA LAYER (Data Source + Models + Repository Impl)
import 'package:recepieapp/feature/search_recipe/domain/model/recipe_data_model.dart';

class LocalRecipeDatasource {
  List<RecipeData> getRecipes() {
    return const [
      RecipeData(
        id: '1',
        title: 'Spiced Potato & Tomato Stir-fry',
        author: 'AMMA',
        ingredients: ['potato', 'tomato', 'onion', 'cumin', 'oil'],
        time: '20m',
        level: 'Easy',
        description:
            'A classic heirloom comfort dish that uses your exact pantry staples.',
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
            'Slow-simmered broth bursting with caramelised onion and ripe tomatoes.',
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
        ammaTip: '"High flame and cold rice is the secret!"',
        imageUrl:
            'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&q=80',
      ),
      // ... and add the rest of your recipes here
    ];
  }
}