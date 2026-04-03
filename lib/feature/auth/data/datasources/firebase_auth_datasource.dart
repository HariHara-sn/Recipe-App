import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../../../../utils/constants/constants.dart';
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
        _authBox = authBox ?? Hive.box(HiveBoxes.auth);
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
