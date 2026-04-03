import 'package:flutter/material.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    fontFamily: 'Epilogue',

    textTheme: AppTypography.textTheme,
  );
}