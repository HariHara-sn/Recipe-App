import 'package:go_router/go_router.dart';

import '../../feature/add_recipe/add_recipe_provider.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/splash/splash_screen.dart';
import '../../feature/home/presentation/pages/home_page.dart';
import '../../feature/profile/presentation/about/about_page.dart';
import '../../feature/recipe_details/presentation/pages/recipe_detail_page.dart';
import '../../utils/shared/floating_navigationbar.dart';
import '../error/er_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        builder: (context, state) => const InitialSplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const SignIn(),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: AppRoutes.addRecipe,
        builder: (context, state) => const AddRecipeProvider(),
      ),

      GoRoute(
        path: AppRoutes.recipeDetails,
        builder: (context, state) => const RecipeDetailPage(),
      ),

      GoRoute(
        path: AppRoutes.bottomNav,
        builder: (context, state) => const FloatingNavBar(),
      ),

      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const AboutPage(),
      ),
    ],

    errorBuilder: (context, state) => ErrorScreen(state: state),
  );
}
