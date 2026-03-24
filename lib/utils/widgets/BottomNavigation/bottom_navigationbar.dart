// import 'package:flutter/material.dart';
// import 'package:nirals/feature/Invoice/Presentation/pages/invoice_page.dart';
// import 'package:nirals/feature/Home/social_media.dart';
// import 'package:nirals/feature/Profile/presentation/profile_page.dart';
// import 'package:nirals/utils/theme/app_colors.dart';
// import 'package:nirals/utils/theme/app_images.dart';

// import '../../../feature/TeacherDrive/presentation/pages/teacher_classes.dart';

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({super.key});

//   @override
//   _MyNavigationBarState createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     SocialMedia(),
//     InvoicePage(),
//     ClassesScreen(), //this is classroom or teacher drive page
//     Performance(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           iconSize: 20,
//           backgroundColor: AppColors.blueShade3,
//           selectedItemColor: AppColors.blueShade2,
//           selectedIconTheme: IconThemeData(
//             size: 30,
//             color: AppColors.blueShade1,
//           ),
//           unselectedIconTheme: IconThemeData(size: 25, color: AppColors.white),
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           items: [
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage("assets/icons/membersIcon.png")),
//               label: "Media",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.record_voice_over_rounded),
//               label: "InVoice",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.school),
//               label: "Classroom",
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(AppImages.performance)),
//               label: "Performance",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_sharp),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //--------------------------------------------------------------

// class Performance extends StatelessWidget {
//   const Performance({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Performance")),
//       body: Center(
//         child: Text("Performance Page", style: TextStyle(fontSize: 20)),
//       ),
//     );
//   }
// }
