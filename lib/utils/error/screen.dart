import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
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
      body: const Center(
        child: Text('Page not found', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
