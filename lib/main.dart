import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:recepieapp/Theme/app_theme.dart';
import 'package:recepieapp/utils/routes/route_generator.dart';
import 'package:recepieapp/utils/routes/routes.dart';
import 'Service/bloc_objserver.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/presentation/controllers/loginBloc/login_bloc.dart';
import 'feature/auth/presentation/controllers/signupBloc/signup_bloc.dart';
import 'utils/widgets/snackbar/custom_snack_bar.dart' show CustomSnackBar;



var logger = Logger();
void main() async {
  if (kDebugMode) {
    Bloc.observer = SimpleBlocObserver();
    logger.f("BLoC debugging Activated!!"); // Shown only in dev
  }
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(); // for app
  // await dotenv.load(fileName: "assets/.env"); //for web+app
  await Hive.initFlutter();
  await Hive.openBox(AuthService.authBoxName);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginBloc(
                AuthRepository(AuthApi()),
                context.read<AuthService>(),
                context.read<UserService>(),
              ),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(AuthRepository(AuthApi())),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final token = context.read<AuthService>().state;
    // logger.i("Initial Token: $token");
    
    return MaterialApp(
      scaffoldMessengerKey: CustomSnackBar.scaffoldMessengerKey,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
