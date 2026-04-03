import 'package:flutter/material.dart';
import 'package:recepieapp/utils/constants/app_colors.dart';

class AuthorWidget extends StatelessWidget {
  final String author;
  final TextTheme tt; 
  const AuthorWidget({super.key, required this.author, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  //Line
                  Container(
                    width: 32,
                    height: 1.5,
                    color: AppColors.blueShade3,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    author,
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.blueShade3,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
  }
}