import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class ProfileLogoutButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onLogout;

  const ProfileLogoutButton({
    super.key,
    required this.isLoading,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton.icon(
          onPressed: isLoading ? null : onLogout,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : const Icon(
                  Icons.logout_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
          label: Text(
            isLoading ? 'Logging out...' : 'Logout',
            style: tt.labelLarge?.copyWith(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
