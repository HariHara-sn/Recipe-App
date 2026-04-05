import 'package:equatable/equatable.dart';

/// All events are Equatable so AppBlocObserver can compare and log them.
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

class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  const ForgotPasswordRequested(this.email);
}