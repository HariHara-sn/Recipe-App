import 'package:flutter/material.dart';
import 'package:recepieapp/feature/add_recipe/presentation/pages/addRecipe.dart';
import 'package:recepieapp/feature/Home/presentation/pages/home_page.dart';
import 'package:recepieapp/login_page.dart';
import 'package:recepieapp/utils/widgets/BottomNavigation/floating_navigationbar.dart';

import '../error/screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.initial:
      // return MaterialPageRoute(builder: (_) => const InitialSplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.addRecipe:
        return MaterialPageRoute(builder: (_) => const AddRecipePage());
      // case Routes.signup:
      //   return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.bottomNav:
        return MaterialPageRoute(builder: (_) => const FloatingNavBar());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
