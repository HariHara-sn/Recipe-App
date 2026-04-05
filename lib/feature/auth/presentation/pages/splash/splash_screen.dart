import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import 'splash_animation.dart';
import 'splash_navigator.dart';

class InitialSplashScreen extends StatelessWidget {
  const InitialSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => SplashNavigator.handleNavigation(context, state),
        child: const Center(child: SplashAnimation()),
      ),
    );
  }
}
