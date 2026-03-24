// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nirals/utils/widgets/Buttons/auth_container.dart';
import 'package:nirals/utils/widgets/snackbar/custom_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepieapp/Theme/app_colors.dart';

import '../../../../utils/routes/routes.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/widgets/Buttons/auth_gradientButton.dart';
import '../controllers/loginBloc/login_bloc.dart';
import '../controllers/loginBloc/login_event.dart';
import '../controllers/loginBloc/login_state.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserIdController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool VisObscureText = true;

  @override
  void dispose() {
    UserIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signin() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            CustomSnackBar.showSnackBar(state.error, SnackBarType.failure);
          } else if (state is LoginSuccess) {
            CustomSnackBar.showSnackBar(state.message, SnackBarType.success);
            Navigator.pushReplacementNamed(context, Routes.bottomNav);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15.0),
            reverse: true,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  const Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthContainer(
                    icon: Icon(Icons.person_2, color: AppColors.Kitelogo),
                    HintText: 'UserId',
                    txtcontroller: UserIdController,
                  ),
                  const SizedBox(height: 15),
                  AuthContainer(
                    txtcontroller: passwordController,
                    HintText: 'Password',
                    isObscureText: VisObscureText,
                    icon: const Icon(Icons.lock, color: AppColors.Kitelogo),
                    Sfxicon: GestureDetector(
                      onTapDown: (_) => setState(() => VisObscureText = false),
                      onTapUp: (_) => setState(() => VisObscureText = true),
                      onTapCancel: () => setState(() => VisObscureText = true),
                      child: Icon(
                        VisObscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  state is LoginLoading
                      ? const CircularProgressIndicator(
                        color: AppColors.blueShade3,
                        strokeWidth: 3,
                      )
                      : AuthGradientbutton(
                        onpress: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginButtonPressed(
                                userId: UserIdController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        formkey: formKey,
                        text: 'Sign In',
                      ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.signup),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const <TextSpan>[
                          TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(
                              color: AppColors.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MediaQuery.of(context).viewInsets.bottom > 0
                      ? SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      )
                      : const SizedBox(
                        height: 40,
                      ), // Add spacing at bottom if keyboard is not open
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
