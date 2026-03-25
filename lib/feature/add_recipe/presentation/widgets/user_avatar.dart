import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_images.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(NetImg.avatar),
    );
  }
}
