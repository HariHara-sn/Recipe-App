import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/feature/auth/presentation/widgets/guest_button.dart';
import 'package:recepieapp/feature/auth/presentation/widgets/hero_card.dart';
import 'package:recepieapp/feature/auth/presentation/widgets/login_button.dart';
import 'package:recepieapp/feature/auth/presentation/widgets/login_footer.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:AppColors.softlavenderWhiteBackground, 
      body: SafeArea(
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
                    color: AppColors.blackText,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 48),

                LoginButton(tt: tt),

                const SizedBox(height: 16),

                GuestButton(tt: tt),

                const SizedBox(height: 55),

                LoginFooter(tt: tt),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
