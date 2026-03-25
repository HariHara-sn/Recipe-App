import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recepieapp/feature/add_recipe/presentation/pages/addRecipe.dart';
import 'package:recepieapp/feature/Home/presentation/pages/home_page.dart';
import 'package:recepieapp/feature/Profile/presentation/profile_page.dart';
import 'package:recepieapp/feature/SearchRecipe/presentation/pages/searchRecipePage.dart';

class FloatingNavBar extends StatefulWidget {
  const FloatingNavBar({super.key});

  static const _items = [
    (icon: Icons.home_rounded, label: 'HOME'),
    (icon: Icons.search_rounded, label: 'SEARCH'),
    (icon: Icons.add_circle_outline_rounded, label: 'ADD'),
    (icon: Icons.person_outline_rounded, label: 'PROFILE'),
  ];

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchRecipePage(),
    AddRecipePage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      extendBody: true, 
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          _pages[_selectedIndex],

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.65), // ✅ glass feel
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D3A8C).withOpacity(0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(FloatingNavBar._items.length, (i) {
                        final item = FloatingNavBar._items[i];
                        final bool isSelected = i == _selectedIndex;

                        return GestureDetector(
                          onTap: () => _onItemTapped(i),
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
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
                                ? Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 24,
                                  )
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}