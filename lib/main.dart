import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recepieapp/Theme/app_theme.dart';
import 'package:recepieapp/utils/routes/route_generator.dart';
import 'package:recepieapp/utils/routes/routes.dart';

var logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}