class AuthFailure{
  final String message;
  const AuthFailure(this.message);

  factory AuthFailure.userNotFound() =>
      const AuthFailure('No signed-in user found.');

  factory AuthFailure.passwordResetFailed(String details) =>
      AuthFailure('Password reset failed: $details');

  factory AuthFailure.logoutFailed(String details) =>
      AuthFailure('Logout failed: $details');

  factory AuthFailure.unknown(String details) =>
      AuthFailure('Unexpected error: $details');

  @override
  String toString() => message;
}

 // instead use the exception class to handle errors














//  class FailureResponse {
//   final String message;

//   FailureResponse({required this.message});

//   factory FailureResponse.fromJson(Map<String, dynamic> json) {
//     return FailureResponse(
//       message: json['message'] ?? 'Something went wrong',
//     );
//   }
// }

//the above is for you to understand the error response from the server