import 'package:equatable/equatable.dart';

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
