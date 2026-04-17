import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_images.dart';

class HeroRecipeCard extends StatelessWidget {
  final TextTheme tt;
  const HeroRecipeCard({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.recipeDetails);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 280,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const AppNetworkImage(
                url: NetImg.tangyRasam,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.textMain.withOpacity(0.8)],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'AMMA',
                        style: tt.bodySmall?.copyWith(
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tangy Tomato Rasam',
                      style: tt.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '15 mins',
                          style: tt.bodySmall?.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.bar_chart_rounded,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Easy',
                          style: tt.bodySmall?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
