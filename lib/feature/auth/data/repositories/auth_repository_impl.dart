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
