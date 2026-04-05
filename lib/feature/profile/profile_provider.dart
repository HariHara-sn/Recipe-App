import 'package:flutter/material.dart';
import 'presentation/pages/profile_page.dart';

/// ProfileProvider is now just a thin wrapper.
/// No BLoC, no Repository, no Datasource needed here —
/// AuthBloc (provided at app root) handles everything.
///
/// Usage in BottomNavigationBar / GoRouter:
///   body: const ProfileProvider()
class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}