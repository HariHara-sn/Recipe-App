import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  final GoRouterState state;
  const ErrorScreen({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      appBar: AppBar(
        backgroundColor: AppColors.blueShade3,
        automaticallyImplyLeading: false,
        title: const Text('Error', style: TextStyle(color: AppColors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            onPressed: () {
              // context.read<AuthService>().clearToken();

              //         ref.read(authServiceProvidere.notifier).deleteToken();

              // ref.read(firebaseAuthControllerProvider.notifier).signOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page not found',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'No route defined for: ${state.uri}',
              style: const TextStyle(fontSize: 15, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
