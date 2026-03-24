import "package:json_annotation/json_annotation.dart";
part 'auth_model.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final String token;
  final User user;
  LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  /// From Json
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// To Json
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class User {
  final String userId;
  final String username;

  User({
    required this.userId,
    required this.username
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}








// // GET OTP Response Model {handleGetOTP()}
// class GetOtpResponse {
//   final bool error; // Updated to match the response structure
//   final String message; // Message field

//   GetOtpResponse({
//     required this.error,
//     required this.message,
//   });

//   // Factory constructor for creating an instance from JSON
//   factory GetOtpResponse.fromJson(Map<String, dynamic> json) {
//     return GetOtpResponse(
//       error: json['error'] as bool, // Parse 'error' field
//       message: json['message'] as String, // Parse 'message' field
//     );
//   }

//   // Method to convert the instance back to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'error': error,
//       'message': message,
//     };
//   }
// }

// // OTP Verification Response Model {authenticateOTPandHandleLogin()}
// class OtpVerificationResponse {
//   final bool error;
//   final String message;
//   final String? token;
//   final Map<String, dynamic>? data;

//   OtpVerificationResponse({
//     required this.error,
//     required this.message,
//     this.token,
//     this.data,
//   });

//   factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
//     return OtpVerificationResponse(
//       error: json['error'] as bool,
//       message: json['message'] as String,
//       token: json['token'],
//       data: json['data'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'error': error,
//       'message': message,
//       if (token != null) 'token': token,
//       if (data != null) 'data': data,
//     };
//   }
// }

// // Google Verification Response Model {handleGoogleSignIn()}
// class GoogleOAuthVerificationResponse {
//   final bool error;
//   final String message;
//   final String? token;
//   final Map<String, dynamic>? data;

//   GoogleOAuthVerificationResponse({
//     required this.error,
//     required this.message,
//     this.token,
//     this.data,
//   });

//   factory GoogleOAuthVerificationResponse.fromJson(Map<String, dynamic> json) {
//     return GoogleOAuthVerificationResponse(
//       error: json['error'] as bool,
//       message: json['message'] as String,
//       token: json['token'],
//       data: json['data'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'error': error,
//       'message': message,
//       if (token != null) 'token': token,
//       if (data != null) 'data': data,
//     };
//   }
// }

// // Apple Verification Response Model {handleAppleSignIn()}
// class AppleOAuthVerificationResponse {
//   final bool error;
//   final String message;
//   final String? token;
//   final Map<String, dynamic>? data;

//   AppleOAuthVerificationResponse({
//     required this.error,
//     required this.message,
//     this.token,
//     this.data,
//   });

//   factory AppleOAuthVerificationResponse.fromJson(Map<String, dynamic> json) {
//     return AppleOAuthVerificationResponse(
//       error: json['error'] as bool,
//       message: json['message'] as String,
//       token: json['token'],
//       data: json['data'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'error': error,
//       'message': message,
//       if (token != null) 'token': token,
//       if (data != null) 'data': data,
//     };
//   }
// }
