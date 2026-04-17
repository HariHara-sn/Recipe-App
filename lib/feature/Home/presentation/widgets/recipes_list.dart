import 'package:flutter/material.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

import '../../../../core/theme/app_images.dart';

class RecipesList extends StatelessWidget {
  final TextTheme tt;

  const RecipesList({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          children: [
            _ListRecipeCard(
              tag: 'PATTI',
              title: 'Traditional Pulao',
              subtitle: 'Fragrant basmati rice with spices...',
              imageUrl: NetImg.pulao,
              tt: tt,
            ),
            const SizedBox(height: 12),
            _ListRecipeCard(
              tag: 'ATHAI',
              title: 'Crispy Ghee\nRoast',
              subtitle: 'Perfectly crisp dosa with...',
              imageUrl: NetImg.dosa,
              tt: tt,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListRecipeCard extends StatelessWidget {
  final String tag, title, subtitle, imageUrl;
  final TextTheme tt;
  const _ListRecipeCard({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppNetworkImage(
            url: imageUrl,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: tt.bodySmall?.copyWith(
                    color: const Color(0xFF3D3A8C),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: tt.titleMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: tt.bodySmall?.copyWith(color: const Color(0xFF9090AA)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
