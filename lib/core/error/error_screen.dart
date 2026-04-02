import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final GoRouterState state;
  const ErrorScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: Center(
        child: Text(
          'No route defined for: ${state.uri}',
          style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
