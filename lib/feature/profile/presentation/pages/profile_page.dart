import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recepieapp/core/router/app_routes.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_event.dart';
import 'package:recepieapp/feature/auth/presentation/bloc/auth_state.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/forgot_password_dialog.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_avatar.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_logout_button.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_menu_card.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_quote_card.dart';
import 'package:recepieapp/feature/profile/presentation/widgets/profile_stats_card.dart';
import 'package:recepieapp/utils/shared/custom_snack_bar.dart';

import '../../../../core/theme/app_colors.dart';

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
            color: AppColors.borderColor,
            fontSize: 20,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.blueShadeText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.blueShadeButtonColor.withOpacity(0.6),
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
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _onAboutUs() {
    context.push(AppRoutes.about);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRoutes.login);
        } else if (state is ProfilePasswordResetSent) {
          CustomSnackBar.showSnackBar(
            'Password reset email sent to ${state.email}',
            SnackBarType.success,
          );
        } else if (state is AuthError) {
          CustomSnackBar.showSnackBar(state.message, SnackBarType.failure);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: AppColors.softlavenderWhiteBackground,
            extendBody: true,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                          child: Text(
                            'My Diary',
                            style: tt.headlineMedium?.copyWith(
                              color: AppColors.blueShadeText,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        ProfileAvatar(photoUrl: user?.photoUrl),

                        const SizedBox(height: 16),

                        Center(
                          child: isLoading
                              ? const SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.blueShadeText,
                                  ),
                                )
                              : Text(
                                  user?.name ?? '',
                                  style: tt.headlineLarge?.copyWith(
                                    color: AppColors.blackShadeText,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 4),

                        Center(
                          child: Text(
                            user?.email ?? '',
                            style: tt.bodyMedium?.copyWith(
                              color: AppColors.blueShade3,
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

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                          child: Text(
                            'ACCOUNT & SETTINGS',
                            style: tt.bodySmall?.copyWith(
                              color: AppColors.blackShadeText,
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
