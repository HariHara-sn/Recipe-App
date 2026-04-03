import 'package:flutter/material.dart';
import 'package:recepieapp/utils/constants/Theme/app_images.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3D3A8C).withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Row(
              children: [
                // Left: shimmer text lines
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerLine(double.infinity),
                        const SizedBox(height: 12),
                        _shimmerLine(120),
                        const SizedBox(height: 12),
                        _shimmerLine(80),
                      ],
                    ),
                  ),
                ),
                // Right: warm botanical bg
                Expanded(
                  flex: 4,
                  child: Container(
                    color: const Color(0xFFF5E9DA),
                    child: Center(
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.asset(
                          AppImages.loginCard,
                          // '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.spa_outlined,
                            size: 64,
                            color: Color(0xFFB8A090),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating fork & knife badge — top-left
        Positioned(
          top: -14,
          left: 0,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF5C59B8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3D3A8C).withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.restaurant, color: Colors.white, size: 22),
          ),
        ),

        // Floating book icon badge — top center - later add
        // Positioned(
        //   top: 40,
        //   left: 0,
        //   right: 0,
        //   child: Center(
        //     child: Container(
        //       width: 58,
        //       height: 58,
        //       decoration: BoxDecoration(
        //         color: const Color(0xFF3D3A8C),
        //         borderRadius: BorderRadius.circular(50),
        //         boxShadow: [
        //           BoxShadow(
        //             color: const Color(0xFF3D3A8C).withOpacity(0.3),
        //             blurRadius: 14,
        //             offset: const Offset(0, 5),
        //           ),
        //         ],
        //       ),
        //       child: const Icon(
        //         Icons.menu_book_rounded,
        //         color: Colors.white,
        //         size: 26,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}


Widget _shimmerLine(double width) {
    return Container(
      height: 10,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE0DEF7),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }