import 'package:equatable/equatable.dart';

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
