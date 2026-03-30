import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/Theme/app_images.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/dashed_border_painter.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final TextTheme tt;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.onTap,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                Image.file(image!, fit: BoxFit.cover)
              else ...[
                Image.asset(AppImages.upLoadImageBackground, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Dotted border drawn with CustomPainter
                CustomPaint(
                  painter: DashedBorderPainter(
                    color: AppColors.blueShadeText.withOpacity(0.3),
                    strokeWidth: 2,
                    dashLength: 8,
                    gapLength: 6,
                    radius: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blueShadeText.withOpacity(0.12),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.blueShadeText,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add a Photo',
                        style: tt.labelLarge?.copyWith(
                          color: AppColors.blueShadeText,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Capture the final dish',
                        style: tt.bodySmall?.copyWith(
                          color: AppColors.blueShade3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (image != null)
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
