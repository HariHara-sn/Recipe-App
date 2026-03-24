// // ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:nirals/feature/auth/presentation/controllers/signupBloc/signup_bloc.dart';
// import 'package:nirals/utils/widgets/Buttons/auth_container.dart';
// import 'package:nirals/utils/widgets/snackbar/custom_snack_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../utils/routes/routes.dart';
// import '../../../../utils/theme/app_colors.dart';
// import '../../../../utils/widgets/Buttons/auth_gradientButton.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final UserIdController = TextEditingController();
//   final UsernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   bool VisObscureText = true;

//   @override
//   void dispose() {
//     UserIdController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void SignUp() async {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: BlocConsumer<SignUpBloc, SignupState>(
//         listener: (context, state) {
//           if (state is SignupFailure) {
//             CustomSnackBar.showSnackBar(state.error, SnackBarType.failure);
//           } else if (state is SignupSuccess) {
//             CustomSnackBar.showSnackBar(state.message, SnackBarType.success);
//             Navigator.pushReplacementNamed(context, Routes.login);
//           }
//         },
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(15.0),
//             reverse: true,
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.15,
//                     ),
//                   ),

//                   const Text(
//                     'Sign Up.',
//                     style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 30),
//                   AuthContainer(
//                     icon: Icon(Icons.badge, color: AppColors.Kitelogo),
//                     HintText: 'UserId',
//                     txtcontroller: UserIdController,
//                   ),
//                   const SizedBox(height: 15),
//                   AuthContainer(
//                     icon: Icon(Icons.person, color: AppColors.Kitelogo),
//                     HintText: 'Username',
//                     txtcontroller: UsernameController,
//                   ),
//                   const SizedBox(height: 15),
//                   AuthContainer(
//                     txtcontroller: passwordController,
//                     HintText: 'Password',
//                     isObscureText: VisObscureText,
//                     icon: const Icon(Icons.lock, color: AppColors.Kitelogo),
//                     Sfxicon: GestureDetector(
//                       onTap:
//                           () =>
//                               setState(() => VisObscureText = !VisObscureText),
//                       child: Icon(
//                         VisObscureText
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 28),
//                   state is SignupLoading
//                       ? const CircularProgressIndicator()
//                       : AuthGradientbutton(
//                         onpress: () {
//                           if (formKey.currentState!.validate()) {
//                             context.read<SignUpBloc>().add(
//                               SignupButtonPressed(
//                                 userId: UserIdController.text.trim(),
//                                 username: UsernameController.text.trim(),
//                                 password: passwordController.text.trim(),
//                               ),
//                             );
//                           }
//                         },
//                         formkey: formKey,
//                         text: 'Sign Up',
//                       ),
//                   const SizedBox(height: 12),
//                   GestureDetector(
//                     onTap: () => Navigator.pushNamed(context, Routes.login),
//                     child: RichText(
//                       text: TextSpan(
//                         text: 'Already have an account?',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                         children: const <TextSpan>[
//                           TextSpan(
//                             text: ' Sign In',
//                             style: TextStyle(
//                               color: AppColors.gradient2,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   MediaQuery.of(context).viewInsets.bottom > 0
//                       ? SizedBox(
//                         height: MediaQuery.of(context).viewInsets.bottom,
//                       )
//                       : const SizedBox(height: 5),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
