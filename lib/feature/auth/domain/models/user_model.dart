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
  String toString() => 'UserModel(uid: $uid, name: $name, email: $email)';
}