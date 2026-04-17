import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/core/theme/app_images.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String? photoUrl;

  const ProfileAvatar({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final url = (photoUrl != null && photoUrl!.isNotEmpty)
        ? photoUrl!
        : NetImg.avatar;

    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.blueShade4, width: 3),
        ),
        child: ClipOval(
          child: AppNetworkImage(
            url: url,
            width: 110,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
