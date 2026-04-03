import 'package:flutter/material.dart';
import 'package:recepieapp/utils/constants/app_colors.dart';

class PattisTip extends StatelessWidget {
  const PattisTip({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: const Border(
              left: BorderSide(color: AppColors.blueShadeText, width: 3.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppColors.blueShadeText,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Patti's Note",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.blueShadeText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Don't forget to mention if the heat should be low or high; that's where the soul of the curry lives.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.blackShadeText,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
