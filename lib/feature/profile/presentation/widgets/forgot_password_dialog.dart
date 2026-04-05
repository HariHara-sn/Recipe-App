import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final String prefillEmail;
  final void Function(String email) onSubmit;

  const ForgotPasswordDialog({
    super.key,
    required this.prefillEmail,
    required this.onSubmit,
  });

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.prefillEmail);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Reset Password',
        style: tt.headlineMedium?.copyWith(
          color: AppColors.blackShadeText,
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter your email and we'll send a reset link.",
            style: tt.bodyMedium?.copyWith(color: AppColors.blueShade3),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'your@email.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: tt.labelLarge?.copyWith(color: AppColors.blueShade3),
          ),
        ),
        TextButton(
          onPressed: () {
            final email = _emailCtrl.text.trim();
            if (email.isNotEmpty) {
              Navigator.pop(context);
              widget.onSubmit(email);
            }
          },
          child: Text(
            'Send Link',
            style: tt.labelLarge?.copyWith(color: AppColors.blueShadeText),
          ),
        ),
      ],
    );
  }
}
