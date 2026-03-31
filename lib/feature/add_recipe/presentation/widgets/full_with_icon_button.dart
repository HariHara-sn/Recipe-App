import 'package:flutter/material.dart';
// for both add ingredient and add step button
class FullWidthIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final TextStyle? textStyle;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color iconColor;
  final double borderWidth;
  final double borderRadius;

  const FullWidthIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.textStyle,
    required this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16, color: iconColor),
        label: Text(label, style: textStyle),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: borderWidth)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}