import 'dart:ui';

import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const FloatingNavBar({super.key, required this.selected, required this.onTap});

  static const _items = [
    (icon: Icons.home_rounded, label: 'HOME'),
    (icon: Icons.search_rounded, label: 'SEARCH'),
    (icon: Icons.add_circle_outline_rounded, label: 'ADD'),
    (icon: Icons.person_outline_rounded, label: 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.6), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3D3A8C).withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isSelected = i == selected;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: const Color(0xFF3D3A8C),
                          borderRadius: BorderRadius.circular(20),
                        )
                      : null,
                  child: isSelected
                      ? Icon(item.icon, color: Colors.white, size: 24)
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item.icon,
                              color: const Color(0xFF9090AA),
                              size: 22,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: tt.bodySmall?.copyWith(
                                color: const Color(0xFF9090AA),
                                fontSize: 9,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
