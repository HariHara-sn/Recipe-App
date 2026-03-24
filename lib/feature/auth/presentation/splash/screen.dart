// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recepieapp/Theme/app_colors.dart';
// import 'package:recepieapp/feature/auth/provider/authentication.dart';
// import 'package:recepieapp/main.dart';
// import 'package:recepieapp/utils/routes/routes.dart';

// import 'copies.dart';

// class InitialSplashScreen extends StatefulWidget {
//   const InitialSplashScreen({super.key});

//   @override
//   InitialSplashScreenState createState() => InitialSplashScreenState();
// }

// class InitialSplashScreenState extends State<InitialSplashScreen> {
//   @override
//   void initState() {
//     final authState = context.read<AuthService>().state; // Access Cubit

//     final initialRoute = authState == null ? Routes.login : Routes.bottomNav;

//     logger.i("Token : $authState");
//     super.initState();
//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted) {
//         Navigator.of(
//           context,
//         ).pushNamedAndRemoveUntil(initialRoute, (route) => false);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.only(top: 15),
//           //   child: Align(
//           //     alignment: Alignment.center,
//           //     child: CircleAvatar(
//           //       backgroundImage: AssetImage(AppImages.logo),
//           //       radius: 150,
//           //     ),
//           //   ),
//           // ),
//           Center(
//             child: CircularProgressIndicator(
//               color: AppColors.blueShade3,
//               strokeWidth: 5,
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: Padding(
//         padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
//         child: Text(
//           SplashScreenTexts.powerBy,
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//       ),
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.blueShade3,
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(17),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 SplashScreenTexts.splashTitle,
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 70,
//                   color: AppColors.white,
//                   fontFamily: 'Nunito',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Text(
//                 SplashScreenTexts.splashSubtitle,
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: AppColors.white,
//                   fontFamily: 'Nunito',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Image.asset(AppImages.splashImage, width: 400),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // CustomTextButton(
//                   //   onPressed: () =>
//                   //       Navigator.pushNamed(context, Routes.register),
//                   //   text: SplashScreenTexts.getStarted,
//                   //   fontSize: 30,
//                   //   color: AppColors.white,
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: AppColors.white, width: 1),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
