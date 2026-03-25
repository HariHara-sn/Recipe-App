import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/utils/routes/routes.dart';

import '../../auth/provider/userprovider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userData = context.watch<UserService>().state;

    // // Check if userData is null and handle the case gracefully
    // if (userData == null) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   ); // Show loading indicator or an error message if necessary
    // }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("My Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    // userData.user.username, // Now safe to access userData
                    'Hari',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'username@gmail.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildProfileOption(Icons.search, "About", () {}),
            _buildProfileOption(Icons.pin_drop, "My posts", () {}),
            const Divider(),
            _buildProfileOption(Icons.cloud_download, "Downloads", () {}),
            _buildProfileOption(Icons.favorite_border, "Likes", () {}),
            const Divider(),
            _buildProfileOption(Icons.lock_open, "Forget Password", () {}),
            _buildProfileOption(
              Icons.article_outlined,
              "Terms & Conditions",
              () {},
            ),
            const SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => handle_signout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

void handle_signout(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        title: const Text("Logout"),
        content: const SizedBox(
          width: 200,
          child: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.blueShade3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.blueShade3),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushReplacementNamed(context, Routes.login);
              // When logging out

              // await context.read<AuthService>().clearToken();

              // await context.read<UserService>().clearUser();

              // // Verify
              // final currentToken = context.read<AuthService>().state;
              // logger.e(currentToken); // Should be null

              // Navigator.of(
              //   context,
              // ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
            },

            child: const Text(
              "Logout",
              style: TextStyle(color: AppColors.blueShade3),
            ),
          ),
        ],
      );
    },
  );
}
