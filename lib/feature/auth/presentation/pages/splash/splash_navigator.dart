import 'package:flutter/material.dart';
import '../../../../../utils/routes/routes.dart';
import '../../bloc/auth_state.dart';

class SplashNavigator {
  static Future<void> handleNavigation(
    BuildContext context,
    AuthState state,
  ) async {
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) return;

      switch (state) {
        case AuthAuthenticated _:
          Navigator.pushReplacementNamed(context, Routes.home);
          break;

        case AuthUnauthenticated _:
          Navigator.pushReplacementNamed(context, Routes.login);
          break;

        case AuthError _:
          Navigator.pushReplacementNamed(context, Routes.login);
          break;

        default:
        // Even on error, redirect to login so user can retry
          Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }
}
