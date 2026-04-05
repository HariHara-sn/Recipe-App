import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  final String? photoUrl;

  const ProfileAvatar({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFD0CEF0), width: 3),
        ),
        child: ClipOval(
          child: photoUrl != null && photoUrl!.isNotEmpty
              ? Image.network(
                  photoUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      Image.network(NetImg.avatar, fit: BoxFit.cover),
                )
              : Image.network(NetImg.avatar, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
