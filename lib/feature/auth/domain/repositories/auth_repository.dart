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
