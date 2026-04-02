

[This is how the data is flown in structured way]
Imagine the user is first time opening the app

    - In main.dart, `create: (_) => AuthBloc(authRepository)..add(AppStarted()),` This creates the AuthBloc and adds the AppStarted event to it. - [main.dart]
    - The AppStarted event calls the _onAppStarted function  - [auth_bloc.dart]
    - Then _authRepository.getAuthState() calls - [auth_bloc.dart]
    - Then the getAuthState() function calls (only abstract class)- [domain/repositories/auth_repository.dart]
    - Then the getAuthState() function calls (implementation) - [auth/repositories/auth_repository_impl.dart]
    - Then above getAuthState() function Implementation written in FirebaseAuthDataSource - [firebase_auth_datasource.dart]
    - In [firebase_auth_datasource.dart] firebase checks in cloudDatabase and it returns Null because user is opening the app for the first time. So it returns null to [auth_repository_impl.dart]
    - Then it returns null back to [auth_bloc.dart]
    - Then in [auth_bloc.dart] it checks if user is null or not. If user is null then it emits AuthUnauthenticated state. So it emits AuthUnauthenticated to the UI.
    - Then in UI it checks if state is AuthUnauthenticated then it shows the LoginScreen.


main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/core/routes/app_router.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_event.dart';

import 'Bloc/Bloc_lessson3_structure_login_and_profile/core/services/bloc_observer.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/data/repositories/auth_repository_impl.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_bloc.dart';


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

  // ── Wire up the dependency graph ──────────────────────────────
  //
  //  DataSource  →  RepositoryImpl  →  BLoC
  //
  // BLoCs only ever see the abstract Repository interface.

  final authDataSource = FirebaseAuthDataSource();
  final authRepository = AuthRepositoryImpl(authDataSource);

  // final profileDataSource = ProfileLocalDataSource();
  // final profileRepository = ProfileRepositoryImpl(profileDataSource);

  runApp(
    RecipeApp(
      authRepository: authRepository,
      // profileRepository: profileRepository,
    ),
  );
}

class RecipeApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  // final ProfileRepositoryImpl profileRepository;

  const RecipeApp({
    super.key,
    required this.authRepository,
    // required this.profileRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AuthBloc fires AppStarted immediately via cascade (..)
        BlocProvider(
          create: (_) => AuthBloc(authRepository)..add(AppStarted()),
        ),
        // UserBloc starts idle; loads after auth is confirmed
        // BlocProvider(
        //   create: (_) => UserBloc(profileRepository),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

folderstructure
├── core
│   ├── error
│   │   └── error_screen.dart
│   ├── logging
│   │   └── logger.dart
│   ├── routes
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   └── services
│       └── bloc_observer.dart
├── features
│   └── auth
│       ├── data
│       │   ├── datasources
│       │   │   └── firebase_auth_datasource.dart
│       │   └── repositories
│       │       └── auth_repository_impl.dart
│       ├── domain
│       │   ├── models
│       │   │   └── user_model.dart
│       │   └── repositories
│       │       └── auth_repository.dart
│       └── presentation
│           ├── bloc
│           │   ├── auth_bloc.dart
│           │   ├── auth_event.dart
│           │   └── auth_state.dart
│           └── pages
│               ├── home_page.dart
│               ├── login_page.dart
│               └── splash
│                   ├── splash_animation.dart
│                   ├── splash_navigator.dart
│                   └── splash_screen.dart

main.dart
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

  // ── Wire up the dependency graph ──────────────────────────────
  //
  //  DataSource  →  RepositoryImpl  →  BLoC
  //
  // BLoCs only ever see the abstract Repository interface.

  final authDataSource = FirebaseAuthDataSource();
  final authRepository = AuthRepositoryImpl(authDataSource);

  // final profileDataSource = ProfileLocalDataSource();
  // final profileRepository = ProfileRepositoryImpl(profileDataSource);

  runApp(
    RecipeApp(
      authRepository: authRepository,
      // profileRepository: profileRepository,
    ),
  );
}

class RecipeApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  // final ProfileRepositoryImpl profileRepository;

  const RecipeApp({
    super.key,
    required this.authRepository,
    // required this.profileRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AuthBloc fires AppStarted immediately via cascade (..)
        BlocProvider(
          create: (_) => AuthBloc(authRepository)..add(AppStarted()),
        ),
        // UserBloc starts idle; loads after auth is confirmed
        // BlocProvider(
        //   create: (_) => UserBloc(profileRepository),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

routes/app_router.dart
[I want my router code look like below, replce the old with the gorouter]
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/splash/splash_screen.dart';
import 'app_routes.dart';
import '../../features/auth/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../error/error_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [

      GoRoute(
        path: AppRoutes.initial,
        builder: (context, state) => const InitialSplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),


      // GoRoute(
      //   path: AppRoutes.bottomNav,
      //   name: AppRoutes.bottomNav,
      //   builder: (context, state) => const MyNavigationBar(),
      // ),
    ],

    errorBuilder: (context, state) => ErrorScreen(state : state),
  );
}

services/bloc_observer.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logging/logger.dart';

/// Logs every BLoC/Cubit lifecycle event to the console. 
/// /// Registered only in debug mode via assert() in main.dart.
/// Swap print() for your logger package if preferred.
/// 
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
       logger.i('🟢 [BLoC] Created  → ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('📩 [BLoC] Event    → ${bloc.runtimeType} received ${event.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d('🔄 [BLoC] Change   → ${bloc.runtimeType}\n'
        '         current: ${change.currentState.runtimeType}\n'
        '         next:    ${change.nextState.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // onTransition fires for Bloc (not Cubit) and gives you event + state pair
    logger.d('➡️  [BLoC] Transition → ${bloc.runtimeType} '
        '| ${transition.event.runtimeType} '
        '→ ${transition.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('🔴 [BLoC] Error    → ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.w('🔴 [BLoC] Closed   → ${bloc.runtimeType}');
  }
}

firebase_auth_datasource.dart
// ← Google + Firebase SDK lives HERE
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../domain/models/user_model.dart';

/// ONLY file in the project that imports firebase_auth or google_sign_in.
/// Responsibilities:
///   • Communicate with Firebase Auth SDK
///   • Communicate with Google Sign-In SDK
///   • Persist/retrieve user JSON in Hive (raw I/O only)
///
/// It does NOT implement AuthRepository directly — that is the job of
/// AuthRepositoryImpl in the repositories/ folder. The datasource is
/// purely about I/O; the repository is about business rules.
class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Box _authBox;

  static const _cachedUserKey = 'cached_user';

  FirebaseAuthDataSource({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    Box? authBox,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _authBox = authBox ?? Hive.box('authBox');
  // Injectable constructor allows unit-testing with mocks ^

  // ── Streams ────────────────────────────────────────────────────

  /// Maps Firebase's User stream → UserModel? stream.
  /// Side-effect: caches UserModel to Hive on every emission.
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;

      final model = UserModel.fromFirebaseUser(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        email: firebaseUser.email,
        photoURL: firebaseUser.photoURL,
      );

      // Cache so getCachedUser() works immediately on next cold start
      _authBox.put(_cachedUserKey, jsonEncode(model.toJson()));
      return model;
    });
  }

  // ── Sign in ────────────────────────────────────────────────────

  Future<UserModel> signInWithGoogle() async {
    // Step 1: Google OAuth
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in was cancelled by the user.');
    }

    // Step 2: Get Google auth tokens
    final googleAuth = await googleUser.authentication;

    // Step 3: Exchange for Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 4: Sign into Firebase
    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;
    if (user == null) {
      throw Exception('Firebase sign-in succeeded but user was null.');
    }

    return UserModel.fromFirebaseUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
    );
    // Note: authStateChanges stream fires automatically after this,
    // triggering Authenticated state in AuthBloc without any extra emit.
  }


  Future<void> signOut() async {
    // Run both sign-outs in parallel for speed
    await Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
    await _authBox.delete(_cachedUserKey);
    // authStateChanges stream emits null automatically after firebaseAuth.signOut()
  }

  // ── Cache ──────────────────────────────────────────────────────

  /// Synchronous — reads from in-memory Hive box, no async needed.
  UserModel? getCachedUser() {
    try {
      final raw = _authBox.get(_cachedUserKey);
      if (raw == null) return null;
      return UserModel.fromJson(jsonDecode(raw as String));
    } catch (_) {
      // Corrupt cache — silently clear and return null
      _authBox.delete(_cachedUserKey);
      return null;
    }
  }
}
repo
//   ← implements AuthRepository

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

/// Concrete implementation of [AuthRepository].
///
/// Why have both DataSource AND RepositoryImpl?
///
///   DataSource  = raw I/O only (Firebase SDK calls, Hive reads/writes)
///   RepositoryImpl = business rules, error handling, data transformation
///
/// In a simple app they look almost identical, but the split pays off when:
///   • You add a second datasource (e.g. a REST API fallback)
///   • You need to combine data from multiple sources
///   • You want to add retry logic, caching policies, etc.
///
/// AuthBloc depends on the ABSTRACT AuthRepository — not this class.

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  // ── Contract implementation 

  @override
  Stream<UserModel?> getAuthState() {
    // Delegate straight to DataSource stream.
    // Add any stream transformation / business rules here if needed.
    return _dataSource.authStateChanges;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      return await _dataSource.signInWithGoogle();
    } on Exception {
      // Re-throw as a domain-level exception if you want custom error types.
      // For now we let the raw exception propagate to AuthBloc.
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } on Exception {
      rethrow;
    }
  }

  @override
  UserModel? getCachedUser() {
    return _dataSource.getCachedUser();
  }
}
domain
usemodel.dart
import 'package:equatable/equatable.dart';

/// Pure data model — zero SDK imports.
/// Lives in domain/ so both data/ and presentation/ can import it freely.
///
/// Extends Equatable so BLoC can compare states correctly
/// and avoid emitting duplicate rebuilds.
class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  // ── Factories ──────────────────────────────────────────────────

  /// Convert from raw Firebase User fields.
  /// Called only inside the DataSource — never in BLoC or UI.
  factory UserModel.fromFirebaseUser({
    required String uid,
    required String? displayName,
    required String? email,
    String? photoURL,
  }) {
    return UserModel(
      uid: uid,
      name: displayName ?? 'No Name',
      email: email ?? 'No Email',
      photoUrl: photoURL,
    );
  }

  /// Deserialise from Hive-stored JSON string.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  // ── Serialisation ──────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };

  // ── Equatable ──────────────────────────────────────────────────

  @override
  List<Object?> get props => [uid, name, email, photoUrl];

  // ── copyWith ───────────────────────────────────────────────────

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email)';
}
auth_repo
//    ← abstract class (interface)

// In domain folder contains only the abstract folders and files
// Lives in domain/ so both data/ and presentation/ can import it freely.

// No implementation code here

import '../models/user_model.dart';

/// CONTRACT — what auth can do. No SDK imports, no implementation.
///
/// AuthBloc depends on THIS type, never on FirebaseAuthDataSource.
/// This is the boundary that makes the whole architecture testable:
///
///   Production:  AuthRepositoryImpl(FirebaseAuthDataSource())
///   Tests:       MockAuthRepository()   ← swap with zero code changes to BLoC
abstract class AuthRepository {
  /// Continuous stream of auth state from Firebase.
  ///
  /// Emits:
  ///   • UserModel  — whenever a user is signed in (including token refresh)
  ///   • null       — whenever the user is signed out
  ///
  /// AuthBloc subscribes to this once on AppStarted and stays subscribed
  /// for the app's lifetime. Firebase handles token expiry automatically.
  Stream<UserModel?> getAuthState();

  /// Triggers the Google OAuth popup, then signs into Firebase.
  /// Throws [Exception] if the user cancels or Firebase rejects.
  Future<UserModel> signInWithGoogle();

  /// Signs out from Google + Firebase, clears local Hive cache.
  Future<void> signOut();

  /// Returns the user last persisted to Hive.
  /// Used on cold start before the async [getAuthState] stream fires,
  /// so the UI can show cached data instantly with no flicker.
  UserModel? getCachedUser();
}

persentation:
Bloc
1.import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_event.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_state.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
/// Orchestrates authentication flow.
///
/// Depends on the ABSTRACT AuthRepository — never on FirebaseAuthDataSource.
/// This means AuthBloc has zero knowledge of Firebase, Google, or Hive.
///
/// Event → Handler mapping:
///   AppStarted              → _onAppStarted           (subscribe to auth stream)
///   GoogleSignInRequested   → _onGoogleSignInRequested (trigger OAuth)
///   SignOutRequested        → _onSignOutRequested      (clear session)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  // ── AppStarted ─────────────────────────────────────────────────
  //
  // emit.onEach() subscribes to the repository's Stream<UserModel?>.
  // It automatically:
  //   • Calls onData for every stream emission
  //   • Calls onError if the stream errors
  //   • CANCELS the subscription when the BLoC is closed (no memory leaks)
  //
  // Because getAuthState() wraps FirebaseAuth.authStateChanges(),
  // it will emit:
  //   • UserModel  → when user signs in or token refreshes
  //   • null       → when user signs out or token is revoked
  Future<void> _onAppStarted( AppStarted event, Emitter<AuthState> emit) async {
    // Show cached user instantly while the async stream is starting up
    final cached = _authRepository.getCachedUser();
    if (cached != null) {
      emit(AuthAuthenticated(cached));
    }

    // Subscribe to live Firebase stream — stays active for app lifetime
    await emit.onEach<UserModel?>(
      _authRepository.getAuthState(),
      onData: (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
      onError: (error, _) {
        emit(AuthError(message: 'Auth stream error: ${error.toString()}'));
      },
    );
  }

  // ── GoogleSignInRequested ──────────────────────────────────────
  //
  // 1. Emit AuthLoading  → button disables, spinner shows
  // 2. Call repository   → Google OAuth + Firebase sign-in
  // 3. SUCCESS: do NOT emit — getAuthState() stream fires AuthAuthenticated
  // 4. FAILURE: emit AuthError with readable message
  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.signInWithGoogle();
      // Stream from _onAppStarted will fire AuthAuthenticated automatically
    } catch (e) {
      emit(AuthError(message: 'Sign-in failed. Please try again.\n${e.toString()}'));
    }
  }

  // ── SignOutRequested ───────────────────────────────────────────
  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.signOut();
      // Stream from _onAppStarted will fire AuthUnauthenticated automatically
    } catch (e) {
      emit(AuthError(message: 'Sign-out failed.\n${e.toString()}'));
    }
  }
}
2.import 'package:equatable/equatable.dart';

/// All events are Equatable so AppBlocObserver can compare and log them.
/// Events = things the USER or APP does (verbs, past tense).
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once by main.dart immediately after AuthBloc is created.
/// Kicks off the persistent auth stream subscription.
class AppStarted extends AuthEvent {
  const AppStarted();
}

/// User tapped "Sign in with Google" on LoginPage.
class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

/// User tapped "Sign out" on ProfilePage or anywhere in the app.
class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}
3.import 'package:equatable/equatable.dart';

import '../../domain/models/user_model.dart';



/// States = what the app IS right now (nouns, present tense).
/// Every state is Equatable so BLoC skips emitting if state didn't change.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// App just launched — auth status is not yet known.
/// SplashScreen shows a spinner while in this state.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Sign-in or sign-out is in progress.
/// UI should: disable button, show spinner, block interaction.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated. Carries UserModel so UI never needs
/// to call FirebaseAuth.currentUser — always read from state.user.
class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// No user is signed in. Navigate to LoginPage.
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// An error occurred during sign-in or sign-out.
/// Show [message] to the user (SnackBar, dialog, etc.).
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
splash
animation
import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.3, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _fade = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            FlutterLogo(size: 90),
            SizedBox(height: 24),
            Text(
              "Recipe App",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
navigation
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../bloc/auth_state.dart';

class SplashNavigator {
  static Future<void> handleNavigation(
    BuildContext context,
    AuthState state,
  ) async {
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) return;

      switch (state) {
        case AuthAuthenticated _:
          context.go(AppRoutes.home);
          break;

        case AuthUnauthenticated _:
          context.go(AppRoutes.login);
          break;

        case AuthError _:
          context.go(AppRoutes.login);
          break;

        default:
        // Even on error, redirect to login so user can retry
          context.go(AppRoutes.login);
      }
    });
  }
}
screen.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import 'splash_animation.dart';
import 'splash_navigator.dart';

// /// First screen the user sees.

// /// Listens to AuthBloc and redirects as soon as auth status is known.
// /// AuthBloc fires AppStarted in main.dart, so this screen typically
// /// resolves in under 200ms (from Hive cache) with no visible flicker.

class InitialSplashScreen extends StatelessWidget {
  const InitialSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => SplashNavigator.handleNavigation(context, state),
        child: const Center(child: SplashAnimation()),
      ),
    );
  }
}

loginpage:
dont use this login page UI. but use the blocConsumer to understande same structure and implement in my login page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/core/routes/app_routes.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Login page — dispatches GoogleSignInRequested on button tap.
///
/// Two BLoC interactions:
///   AuthBloc  → watches for Authenticated / Error states
///   UserBloc  → populated immediately after successful sign-in
///               so ProfilePage has user data ready without a second fetch
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        // ── Listener: side-effects (navigation, snackbars) ────────
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Pre-load user into UserBloc before navigating
            // context.read<UserBloc>().add(LoadUserEvent(state.user));  Add the data to userbloc for use it in profile page
            context.go(AppRoutes.home);
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },

        // ── Builder: what to render ───────────────────────────────
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / branding
                  const FlutterLogo(size: 80),
                  const SizedBox(height: 40),

                  Text(
                    'Recipe App',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to save and discover recipes',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 56),

                  // Google sign-in button
                  // Disabled + shows spinner while AuthLoading
                  FilledButton.icon(
                    onPressed: isLoading
                        ? null
                        : () => context.read<AuthBloc>().add(
                            const GoogleSignInRequested(),
                          ),
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.login),
                    label: Text(
                      isLoading ? 'Signing in…' : 'Continue with Google',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

