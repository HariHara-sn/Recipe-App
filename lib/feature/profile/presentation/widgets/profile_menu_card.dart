import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class ProfileMenuCard extends StatelessWidget {
  final VoidCallback onForgotPassword;
  final VoidCallback onAboutUs;

  const ProfileMenuCard({
    super.key,
    required this.onForgotPassword,
    required this.onAboutUs,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEEEDFA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _MenuButton(
              icon: Icons.lock_reset_rounded,
              label: 'Forgot Password',
              onPressed: onForgotPassword,
              tt: tt,
              showDivider: true,
            ),
            _MenuButton(
              icon: Icons.info_outline_rounded,
              label: 'About Us',
              onPressed: onAboutUs,
              tt: tt,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final TextTheme tt;
  final bool showDivider;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.tt,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(double.infinity, 0),
            alignment: Alignment.centerLeft,
            foregroundColor: const Color(0xFF1A1A2E),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blueShadeButtonColor.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(icon, color: AppColors.blueShadeButtonColor, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: tt.bodyLarge?.copyWith(
                    color: AppColors.blackShadeText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.blueShade3,
                size: 20,
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.blackShadeText.withOpacity(0.08),
            ),
          ),
      ],
    );
  }
}
