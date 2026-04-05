import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recepieapp/core/router/app_routes.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_event.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_state.dart';
import 'package:recepieapp/feature/profile/presentation/about/about_page.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/forgot_password_dialog.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_avatar.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_logout_button.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_menu_card.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_quote_card.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_stats_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileView();
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  // Stats — will be implemented later
  final int _recipesShared = 42;
  final int _cooked = 128;
  final int _saved = 15;

  void _onForgotPassword(String email) {
    showDialog(
      context: context,
      builder: (_) => ForgotPasswordDialog(
        prefillEmail: email,
        onSubmit: (enteredEmail) {
          // context.read<AuthBloc>().add(ForgotPasswordRequested(enteredEmail));
        },
      ),
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Log out?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF1A1A2E),
            fontSize: 20,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6B6B8A),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFF9090AA),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            child: Text(
              'Log out',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFFD64545),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRoutes.login);
        } else if (state is ProfilePasswordResetSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset email sent to ${state.email}'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFF4F3FB),
            extendBody: true,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Top bar ──────────────────────────────────────
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Diary',
                                style: tt.headlineMedium?.copyWith(
                                  color: const Color(0xFF3D3A8C),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // TODO: navigate to edit profile screen
                                },
                                icon: const Icon(
                                  Icons.settings_outlined,
                                  color: Color(0xFF3D3A8C),
                                  size: 26,
                                ),
                                tooltip: 'Edit Profile',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        ProfileAvatar(photoUrl: user?.photoUrl),

                        const SizedBox(height: 16),

                        // ── Name ─────────────────────────────────────────
                        Center(
                          child: isLoading
                              ? const SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFF3D3A8C),
                                  ),
                                )
                              : Text(
                                  user?.name ?? '',
                                  style: tt.headlineLarge?.copyWith(
                                    color: const Color(0xFF1A1A2E),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 4),

                        // ── Email ─────────────────────────────────────────
                        Center(
                          child: Text(
                            user?.email ?? '',
                            style: tt.bodyMedium?.copyWith(
                              color: const Color(0xFF9090AA),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        ProfileStatsCard(
                          recipesShared: _recipesShared,
                          cooked: _cooked,
                          saved: _saved,
                        ),

                        const SizedBox(height: 20),

                        const ProfileQuoteCard(),

                        const SizedBox(height: 28),

                        // ── Account & Settings label ──────────────────────
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                          child: Text(
                            'ACCOUNT & SETTINGS',
                            style: tt.bodySmall?.copyWith(
                              color: const Color(0xFF1A1A2E),
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),

                        ProfileMenuCard(
                          onForgotPassword: () =>
                              _onForgotPassword(user?.email ?? ''),
                          onAboutUs: _onAboutUs,
                        ),

                        const SizedBox(height: 32),

                        ProfileLogoutButton(
                          isLoading: isLoading,
                          onLogout: _onLogout,
                        ),

                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
