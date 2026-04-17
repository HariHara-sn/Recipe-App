import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recepieapp/core/theme/app_theme.dart';
import 'package:recepieapp/utils/constants/constants.dart';
import 'package:recepieapp/utils/shared/app_internet_connectivity.dart';
import 'package:recepieapp/utils/shared/custom_snack_bar.dart';

import 'core/router/app_router.dart';
import 'core/services/bloc_observer.dart';
import 'feature/auth/data/datasources/firebase_auth_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.auth);
  await Hive.openBox(HiveBoxes.profile);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // BLoC observer — only active in debug builds
  assert(() {
    Bloc.observer = AppBlocObserver();
    return true;
  }());

  final authDataSource = FirebaseAuthDataSource();
  final authRepository = AuthRepositoryImpl(authDataSource);

  runApp(
    MyApp(
      authRepository: authRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;

  const MyApp({
    super.key,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepository)..add(const AppStarted()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Recipe App',
        scaffoldMessengerKey: CustomSnackBar.scaffoldMessengerKey,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        builder: (context, child) => ConnectivityWrapper(child: child!),
      ),
    );
  }
}