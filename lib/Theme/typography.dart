import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme textTheme = const TextTheme(
    // 🔥 Display (Big Titles / Hero Text)
    displayLarge: TextStyle(
      fontFamily: 'Ephesis',
      fontSize: 40,
      fontWeight: FontWeight.w400,
    ),

    displayMedium: TextStyle(
      fontFamily: 'Ephesis',
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    // 🧾 Headlines (Recipe Titles)
    headlineLarge: TextStyle(
      fontFamily: 'Epilogue',
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),

    headlineMedium: TextStyle(
      fontFamily: 'Epilogue',
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),

    // 📌 Titles (Section headings)
    titleLarge: TextStyle(
      fontFamily: 'Epilogue',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    titleMedium: TextStyle(
      fontFamily: 'Epilogue',
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),

    // 📖 Body (Main readable text)
    bodyLarge: TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),

    bodyMedium: TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),

    // 🔘 Buttons
    labelLarge: TextStyle(
      fontFamily: 'Epilogue',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}
