import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recepieapp/utils/constants/app_theme.dart';

import 'core/router/app_router.dart';
import 'core/services/bloc_observer.dart';
import 'feature/auth/data/datasources/firebase_auth_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();

  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await Hive.openBox('profileBox');

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
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}