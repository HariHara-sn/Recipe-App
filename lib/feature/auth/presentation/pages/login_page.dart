import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recepieapp/utils/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../widgets/guest_button.dart';
import '../../widgets/hero_card.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_footer.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:AppColors.softlavenderWhiteBackground, 
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigator.pushReplacementNamed(context, Routes.bottomNav);
            context.go(AppRoutes.bottomNav);

          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),

                    const HeroCard(), // Card Container

                    const SizedBox(height: 70),

                    Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: tt.displayMedium?.copyWith(
                        color: const Color(0xFF3D3A8C),
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Amma Recipes',
                      textAlign: TextAlign.center,
                      style: tt.displayLarge?.copyWith(
                        color: const Color(0xFF3D3A8C),
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Step into the warmth of the kitchen. A digital heirloom for your family's secret ingredients.",
                      textAlign: TextAlign.center,
                      style: tt.bodyLarge?.copyWith(
                        color: AppColors.blackShadeText,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 48),

                    LoginButton(
                      tt: tt,
                      isLoading: isLoading,
                      onPressed: () => context.read<AuthBloc>().add(
                        const GoogleSignInRequested(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    GuestButton(tt: tt),

                    const SizedBox(height: 55),

                    LoginFooter(tt: tt),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
