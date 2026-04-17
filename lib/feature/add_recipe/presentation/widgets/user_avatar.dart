import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recepieapp/utils/shared/app_network_image.dart';

import '../../../../core/theme/app_images.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photoUrl = user?.photoURL;
    
    final url = (photoUrl != null && photoUrl.isNotEmpty) ? photoUrl : NetImg.avatar;

    return ClipOval(
      child: AppNetworkImage(
        url: url,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }
}