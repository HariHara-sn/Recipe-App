import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final TextTheme tt;
  final bool isLoading;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key, 
    required this.tt,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueShadeText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_book_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    'Add to Recipe Notebook',
                    style: tt.labelLarge?.copyWith(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
      ),
    );
  }
}
