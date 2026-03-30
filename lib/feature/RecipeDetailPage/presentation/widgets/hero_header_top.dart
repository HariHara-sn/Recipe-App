import 'package:flutter/material.dart';
import 'package:recepieapp/feature/RecipeDetailPage/presentation/widgets/meta_chip.dart';

class HeroHeader extends StatelessWidget {
  final String tag, title, time, serves, level;
  final TextTheme tt;

  const HeroHeader({super.key, 
    required this.tag,
    required this.title,
    required this.time,
    required this.serves,
    required this.level,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4ECDC4), Color(0xFF2A7B9B)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dish illustration placeholder
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    color: Color(0xFF4ECDC4),
                    size: 54,
                  ),
                ),
              ),

              // Tag pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3A8C).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: tt.bodySmall?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Title
              Text(
                title,
                style: tt.headlineLarge?.copyWith(
                  color: Colors.white,
                  height: 1.2,
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 18),

              // Meta row
              Row(
                children: [
                  MetaChip(
                    icon: Icons.access_time_rounded,
                    label: 'TIME',
                    value: time,
                    tt: tt,
                  ),
                  const SizedBox(width: 20),
                  MetaChip(
                    icon: Icons.people_outline_rounded,
                    label: 'SERVES',
                    value: serves,
                    tt: tt,
                  ),
                  const SizedBox(width: 20),
                  MetaChip(
                    icon: Icons.star_border_rounded,
                    label: 'LEVEL',
                    value: level,
                    tt: tt,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
