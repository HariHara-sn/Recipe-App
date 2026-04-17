import 'package:flutter/material.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

import '../../../../core/theme/app_images.dart';

class RecentAdditionCard extends StatelessWidget {
  final TextTheme tt;

  const RecentAdditionCard({super.key, required this.tt});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: _RecentCard(
                tag: 'AMMA',
                title: 'Mixed Veg Sa...',
                imageUrl: NetImg.mixedVeg,
                tt: tt,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _RecentCard(
                tag: 'ATHAI',
                title: 'Elaneer Paya...',
                imageUrl: NetImg.elaneer,
                tt: tt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  final String tag, title, imageUrl;
  final TextTheme tt;
  const _RecentCard({
    required this.tag,
    required this.title,
    required this.imageUrl,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),

      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: AppNetworkImage(
              url: imageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 8),
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
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
