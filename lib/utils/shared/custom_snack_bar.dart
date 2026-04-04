import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum SnackBarType { success, failure }

class CustomSnackBar {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message, SnackBarType type) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppColors.green;
        break;
      case SnackBarType.failure:
        backgroundColor = AppColors.red;
        break;
    }

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: ExcludeSemantics(
          child: Text(message, style: const TextStyle(color: AppColors.white)),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
