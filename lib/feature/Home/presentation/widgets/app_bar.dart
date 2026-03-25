import 'package:flutter/material.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';


class CustomAppBar extends StatelessWidget {
  final TextTheme tt;
  const CustomAppBar({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    color: Color(0xFF3D3A8C),
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Amma's Notebook",
                    style: tt.titleMedium?.copyWith(
                      color: const Color(0xFF3D3A8C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const UserAvatar()
            ],
          ),
        ),
      ),
    );
  }
}
