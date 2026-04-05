import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepieapp/core/logging/logger.dart';
import 'package:recepieapp/feature/auth/data/failure.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

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
    on<LogoutRequested>(_onLogout);
    on<ForgotPasswordRequested>(_onForgotPassword);
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
  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    // Show cached user instantly while the async stream is starting up
    final cached = _authRepository.getCurrentProfile();
    if (cached != null) {
      emit(AuthAuthenticated(cached));
      logger.i("successfully loggedIn");
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
      emit(
        AuthError(
          message: 'Sign-in failed. Please try again.\n${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.logOut();
      // Stream from _onAppStarted will fire AuthUnauthenticated automatically
    } catch (e) {
      emit(AuthError(message: 'Sign-out failed.\n${e.toString()}'));
    }
  }

    Future<void> _onForgotPassword(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.sendPasswordResetEmail(event.email);
      emit(ProfilePasswordResetSent(event.email));
    } on AuthFailure catch (f) {
       emit(AuthError(message: f.message));
    } catch (e) {
      emit(AuthError(message: 'Unexpected error: $e'));
    }
  }
}
