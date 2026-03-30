import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final TextTheme tt;
  const SubmitButton({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueShadeText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Row(
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
