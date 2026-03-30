import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/feature/RecipeDetailPage/presentation/widgets/author_widget.dart';

class NoteCard extends StatelessWidget {
  final String note, author;
  final TextTheme tt;
  const NoteCard({super.key, required this.note, required this.author, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: const Border(
          left: BorderSide(color: AppColors.blueShadeText, width: 3.5),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -4,
            right: 0,
            child: Text(
              '"',
              style: TextStyle(
                fontSize: 80,
                color: const Color(0xFF3D3A8C).withOpacity(0.1),
                height: 1,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note,
                style: tt.bodyMedium?.copyWith(
                  color: AppColors.blackShadeText,
                  height: 1.7,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              AuthorWidget(author: author, tt: tt),
            ],
          ),
        ],
      ),
    );
  }
}