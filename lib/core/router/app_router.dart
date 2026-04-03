import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../feature/auth/presentation/pages/splash/splash_screen.dart';
import '../../utils/widgets/BottomNavigation/floating_navigationbar.dart';
import '../error/error_screen.dart';
import '../../feature/RecipeDetailPage/presentation/pages/recipe_detail_page.dart';
import '../../feature/add_recipe/presentation/pages/addRecipe.dart';
import '../../feature/Home/presentation/pages/home_page.dart';
import '../../feature/auth/presentation/pages/login_page.dart';

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
        builder: (context, state) => const AddRecipePage(),
      ),

      GoRoute(
        path: AppRoutes.recipeDetails,
        builder: (context, state) => const RecipeDetailPage(),
      ),  

      GoRoute(
        path: AppRoutes.bottomNav,
        builder: (context, state) => const FloatingNavBar(),
      ),

    ],

    errorBuilder: (context, state) => ErrorScreen(state : state),
  );
}